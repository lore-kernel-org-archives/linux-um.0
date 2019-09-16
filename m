Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by bombadil.infradead.org with esmtps (Exim 4.92.2 #3 (Red Hat Linux))
 id 1i9qls-0004OD-4t
 for linux-um@lists.infradead.org; Mon, 16 Sep 2019 13:10:28 +0000
From: Johannes Berg <johannes@sipsolutions.net>
Subject: [RFC 3/3] um: implement time-travel=virtio
Date: Mon, 16 Sep 2019 15:10:18 +0200
Message-Id: <1568639418-I3bd4c6c347fbe4c07747f1ec2f34a26be1a89b75@changeid>
In-Reply-To: <1568639418-I895f9019593bd579566f14e5af9346e3c9b56f28@changeid>
References: <1568639418-I895f9019593bd579566f14e5af9346e3c9b56f28@changeid>
MIME-Version: 1.0
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: linux-um@lists.infradead.org
Cc: Johannes Berg <johannes.berg@intel.com>

From: Johannes Berg <johannes.berg@intel.com>

This implements synchronized time-travel mode, which - using a special
virtio device, lets multiple machines take part in a time-travelling
simulation together.

Note that the 1234 device ID is not assigned, so don't use this code :-)

Also this code is a lot more complex than I'd like, and has all the
weird poll() semantics etc. It works, but occasionally deadlocks and
I haven't yet found why.

Instead of continuing this, I'm going to try to work on a much simpler
simulation time driver not using virtio, since this is a special thing.
Then only the first patch in this series and some smaller virtio
changes will hopefully be required.

---
 arch/um/Kconfig                       |  13 ++
 arch/um/drivers/virtio_uml.c          | 204 ++++++++++++++++-
 arch/um/include/linux/time-internal.h |  14 ++
 arch/um/include/shared/os.h           |   6 +
 arch/um/kernel/time.c                 | 315 +++++++++++++++++++++++++-
 arch/um/os-Linux/file.c               | 116 ++++++++++
 include/uapi/linux/virtio_ids.h       |   2 +
 include/uapi/linux/virtio_simtime.h   |  99 ++++++++
 8 files changed, 755 insertions(+), 14 deletions(-)
 create mode 100644 include/uapi/linux/virtio_simtime.h

diff --git a/arch/um/Kconfig b/arch/um/Kconfig
index 3debe293169c..22011875f620 100644
--- a/arch/um/Kconfig
+++ b/arch/um/Kconfig
@@ -197,6 +197,19 @@ config UML_TIME_TRAVEL_SUPPORT
 
 	  It is safe to say Y, but you probably don't need this.
 
+config UML_TIME_TRAVEL_VIRTIO
+	bool "VirtIO-backed time-travel mode (for cross-system simulation)"
+	depends on UML_TIME_TRAVEL_SUPPORT
+	depends on VIRTIO_UML=y
+	help
+	  Enable this option to support synchronized time travel (time
+	  simulation) across multiple machines, using VirtIO transport.
+
+	  You can find an example for the necessary userspace in the QEMU
+	  git repository (vhost-user-simtime).
+
+	  It is safe to say Y, but you probably don't need this.
+
 endmenu
 
 source "arch/um/drivers/Kconfig"
diff --git a/arch/um/drivers/virtio_uml.c b/arch/um/drivers/virtio_uml.c
index c23129b1c220..e4d13b45182a 100644
--- a/arch/um/drivers/virtio_uml.c
+++ b/arch/um/drivers/virtio_uml.c
@@ -26,6 +26,7 @@
 #include <linux/virtio.h>
 #include <linux/virtio_config.h>
 #include <linux/virtio_ring.h>
+#include <linux/time-internal.h>
 #include <shared/as-layout.h>
 #include <irq_kern.h>
 #include <init.h>
@@ -39,6 +40,12 @@
 
 #define MAX_SUPPORTED_QUEUE_SIZE	256
 
+#ifdef CONFIG_UML_TIME_TRAVEL_VIRTIO
+static LIST_HEAD(virtio_uml_devices);
+static DEFINE_SPINLOCK(virtio_uml_devices_lock);
+static struct os_poll *virtio_poll;
+#endif
+
 #define to_virtio_uml_device(_vdev) \
 	container_of(_vdev, struct virtio_uml_device, vdev)
 
@@ -53,6 +60,10 @@ struct virtio_uml_device {
 	struct virtio_device vdev;
 	struct platform_device *pdev;
 
+#ifdef CONFIG_UML_TIME_TRAVEL_VIRTIO
+	struct list_head list;
+#endif
+
 	spinlock_t sock_lock;
 	int sock, req_fd;
 	u64 features;
@@ -63,6 +74,11 @@ struct virtio_uml_device {
 struct virtio_uml_vq_info {
 	int kick_fd, call_fd;
 	char name[32];
+#ifdef CONFIG_UML_TIME_TRAVEL_VIRTIO
+	struct virtqueue *vq;
+	vq_callback_t *callback;
+	struct time_travel_event defer;
+#endif
 };
 
 extern unsigned long long physmem_size, highmem;
@@ -120,7 +136,43 @@ static int vhost_user_recv(struct virtio_uml_device *vu_dev,
 			   size_t max_payload_size)
 {
 	size_t size;
-	int rc = vhost_user_recv_header(fd, msg);
+	int rc;
+
+#ifdef CONFIG_UML_TIME_TRAVEL_VIRTIO
+	/*
+	 * In virtio time-travel mode, we're handling all the vhost-user
+	 * FDs by polling them whenever appropriate. However, we get into
+	 * situations where we get some updates messages from some device
+	 * while we're waiting for a response, or similar; so we need to
+	 * poll and handle other things while reading a message.
+	 *
+	 * Note that this MUST be done only once for each message, if we
+	 * were to do this in e.g. full_read() above then we could
+	 *  - send a simtime message
+	 *  - wait for a response
+	 *  - receive a partial response
+	 *  - receive some other message on another device
+	 *  - schedule an interrupt for it, and that causes us
+	 *    to talk to the simtime device again
+	 *  - wait for a response (again)
+	 *  - receive the partial message as though it was the full one
+	 *
+	 * This is avoided by doing the poll() only once for each message
+	 * and reading it completely once it should be available, even if
+	 * the sender might be creating it in multiple pieces, and we may
+	 * receive it in multiple rounds inside full_read().
+	 */
+	if (time_travel_virtio) {
+		bool remove = os_poll_add(&virtio_poll, fd);
+
+		while (!os_poll_check_readable(virtio_poll, fd))
+			virtio_uml_poll_fds();
+		if (remove)
+			os_poll_remove(&virtio_poll, fd);
+	}
+#endif
+
+	rc = vhost_user_recv_header(fd, msg);
 
 	if (rc == -ECONNRESET) {
 		struct virtio_uml_platform_data *pdata;
@@ -208,7 +260,17 @@ static int vhost_user_send(struct virtio_uml_device *vu_dev,
 	if (request_ack)
 		msg->header.flags |= VHOST_USER_FLAG_NEED_REPLY;
 
-	spin_lock_irqsave(&vu_dev->sock_lock, flags);
+	/*
+	 * Don't let an interrupt break us in the middle of some message
+	 * handshake, we need it to be done properly as "send request"
+	 * followed by "read response".
+	 *
+	 * In time-travel=virtio mode, we may actually end up recursing
+	 * this for different sockets, but we don't have real interrupts
+	 * connected to virtio anyway, so we don't need locking.
+	 */
+	if (!time_travel_virtio)
+		spin_lock_irqsave(&vu_dev->sock_lock, flags);
 	rc = full_sendmsg_fds(vu_dev->sock, msg, size, fds, num_fds);
 	if (rc < 0)
 		goto out;
@@ -221,14 +283,17 @@ static int vhost_user_send(struct virtio_uml_device *vu_dev,
 			goto out;
 
 		if (status) {
-			vu_err(vu_dev, "slave reports error: %llu\n", status);
+			vu_err(vu_dev, "slave reports error: %llu to message %*ph (fd %d)\n",
+			       status, (int)sizeof(msg->header), &msg->header,
+			       vu_dev->sock);
 			rc = -EIO;
 			goto out;
 		}
 	}
 
 out:
-	spin_unlock_irqrestore(&vu_dev->sock_lock, flags);
+	if (!time_travel_virtio)
+		spin_unlock_irqrestore(&vu_dev->sock_lock, flags);
 	return rc;
 }
 
@@ -377,6 +442,29 @@ static int vu_request_irq(struct virtio_uml_device *vu_dev,
 			  int fd, irq_handler_t handler,
 			  const char *name, void *data)
 {
+#ifdef CONFIG_UML_TIME_TRAVEL_VIRTIO
+	/*
+	 * In time-travel=virtio mode, virtio becomes part of the simulation
+	 * handling, and we don't want real IRQs to happen. Instead, we will
+	 * poll all the file descriptors whenever we need to, in order to
+	 * process the messages coming from other parts of the simulation.
+	 * We also defer all interrupts to after simulation scheduling.
+	 *
+	 * We could process the interrupts normally, but we need to do this
+	 * anyway for the simtime device because we may need to talk to it
+	 * with interrupts disabled, so just do all processing the same way
+	 * for all file descriptors.
+	 */
+	if (time_travel_virtio) {
+		int ret;
+
+		ret = os_poll_add(&virtio_poll, fd);
+		if (ret < 0)
+			return ret;
+		return 0;
+	}
+#endif
+
 	return um_request_irq(VIRTIO_IRQ, fd, IRQ_READ, handler,
 			      IRQF_SHARED, name, data);
 }
@@ -384,6 +472,13 @@ static int vu_request_irq(struct virtio_uml_device *vu_dev,
 static void vu_free_irq(struct virtio_uml_device *vu_dev,
 			int fd, void *data)
 {
+#ifdef CONFIG_UML_TIME_TRAVEL_VIRTIO
+	if (time_travel_virtio) {
+		os_poll_remove(&virtio_poll, fd);
+		return;
+	}
+#endif
+
 	um_free_irq(VIRTIO_IRQ, data);
 }
 
@@ -712,6 +807,9 @@ static bool vu_notify(struct virtqueue *vq)
 	const uint64_t n = 1;
 	int rc;
 
+	if (time_travel_virtio && vq->vdev->id.device != VIRTIO_ID_SIMTIME)
+		time_travel_propagate_time();
+
 	if (info->kick_fd < 0) {
 		struct virtio_uml_device *vu_dev;
 
@@ -744,6 +842,40 @@ static irqreturn_t vu_interrupt(int irq, void *opaque)
 	return ret;
 }
 
+#ifdef CONFIG_UML_TIME_TRAVEL_VIRTIO
+/* See the comment in vu_request_irq() */
+void virtio_uml_poll_fds(void)
+{
+	struct virtio_uml_device *vu_dev;
+	unsigned long flags;
+	int ret;
+
+	local_irq_save(flags);
+	do {
+		ret = os_poll(virtio_poll, -1);
+		if (ret < 0 && ret != -EINTR)
+			pr_err("virtio_uml_poll_fds() poll returned %d\n", ret);
+	} while (ret < 0);
+
+	list_for_each_entry(vu_dev, &virtio_uml_devices, list) {
+		struct virtqueue *vq;
+
+		if (os_poll_check_readable(virtio_poll, vu_dev->req_fd)) {
+			if (vu_req_interrupt(0 /* ignored */, vu_dev) == IRQ_NONE)
+				os_poll_remove(&virtio_poll, vu_dev->req_fd);
+		}
+
+		virtio_device_for_each_vq((&vu_dev->vdev), vq) {
+			struct virtio_uml_vq_info *info = vq->priv;
+
+			if (info->call_fd >= 0 &&
+			    os_poll_check_readable(virtio_poll, info->call_fd))
+				vu_interrupt(0 /* ignored */, vq);
+		}
+	}
+	local_irq_restore(flags);
+}
+#endif
 
 static void vu_get(struct virtio_device *vdev, unsigned offset,
 		   void *buf, unsigned len)
@@ -860,6 +992,26 @@ static int vu_setup_vq_call_fd(struct virtio_uml_device *vu_dev,
 	return rc;
 }
 
+#ifdef CONFIG_UML_TIME_TRAVEL_VIRTIO
+static void vu_defer_irq_handle(struct time_travel_event *d)
+{
+	struct virtio_uml_vq_info *info;
+	unsigned long flags;
+
+	local_irq_save(flags);
+	info = container_of(d, struct virtio_uml_vq_info, defer);
+	info->callback(info->vq);
+	local_irq_restore(flags);
+}
+
+static void vu_defer_irq_callback(struct virtqueue *vq)
+{
+	struct virtio_uml_vq_info *info = vq->priv;
+
+	time_travel_add_irq_event(&info->defer);
+}
+#endif
+
 static struct virtqueue *vu_setup_vq(struct virtio_device *vdev,
 				     unsigned index, vq_callback_t *callback,
 				     const char *name, bool ctx)
@@ -879,6 +1031,19 @@ static struct virtqueue *vu_setup_vq(struct virtio_device *vdev,
 	snprintf(info->name, sizeof(info->name), "%s.%d-%s", pdev->name,
 		 pdev->id, name);
 
+#ifdef CONFIG_UML_TIME_TRAVEL_VIRTIO
+	/*
+	 * When we get an interrupt, we must bounce it through the simulation
+	 * calendar (the simtime device), except for the simtime device itself
+	 * since that's part of the simulation control.
+	 */
+	if (time_travel_virtio && vdev->id.device != VIRTIO_ID_SIMTIME) {
+		info->callback = callback;
+		callback = vu_defer_irq_callback;
+		time_travel_set_event_fn(&info->defer, vu_defer_irq_handle);
+	}
+#endif
+
 	vq = vring_create_virtqueue(index, num, PAGE_SIZE, vdev, true, true,
 				    ctx, vu_notify, callback, info->name);
 	if (!vq) {
@@ -887,6 +1052,9 @@ static struct virtqueue *vu_setup_vq(struct virtio_device *vdev,
 	}
 	vq->priv = info;
 	num = virtqueue_get_vring_size(vq);
+#ifdef CONFIG_UML_TIME_TRAVEL_VIRTIO
+	info->vq = vq;
+#endif
 
 	if (vu_dev->protocol_features &
 			BIT_ULL(VHOST_USER_PROTOCOL_F_INBAND_NOTIFICATIONS)) {
@@ -1038,15 +1206,13 @@ static void virtio_uml_release_dev(struct device *d)
 
 /* Platform device */
 
-struct virtio_uml_platform_data {
-	u32 virtio_device_id;
-	const char *socket_path;
-};
-
 static int virtio_uml_probe(struct platform_device *pdev)
 {
 	struct virtio_uml_platform_data *pdata = pdev->dev.platform_data;
 	struct virtio_uml_device *vu_dev;
+#ifdef CONFIG_UML_TIME_TRAVEL_VIRTIO
+	unsigned long flags;
+#endif
 	int rc;
 
 	if (!pdata)
@@ -1082,6 +1248,12 @@ static int virtio_uml_probe(struct platform_device *pdev)
 	rc = register_virtio_device(&vu_dev->vdev);
 	if (rc)
 		put_device(&vu_dev->vdev.dev);
+
+#ifdef CONFIG_UML_TIME_TRAVEL_VIRTIO
+	spin_lock_irqsave(&virtio_uml_devices_lock, flags);
+	list_add_tail(&vu_dev->list, &virtio_uml_devices);
+	spin_unlock_irqrestore(&virtio_uml_devices_lock, flags);
+#endif
 	return rc;
 
 error_init:
@@ -1092,7 +1264,19 @@ static int virtio_uml_probe(struct platform_device *pdev)
 static int virtio_uml_remove(struct platform_device *pdev)
 {
 	struct virtio_uml_device *vu_dev = platform_get_drvdata(pdev);
+#ifdef CONFIG_UML_TIME_TRAVEL_VIRTIO
+	unsigned long flags;
+#endif
+
+	/* This is totally necessary even during shutdown, just leak it */
+	if (vu_dev->vdev.id.device == VIRTIO_ID_SIMTIME)
+		return 0;
 
+#ifdef CONFIG_UML_TIME_TRAVEL_VIRTIO
+	spin_lock_irqsave(&virtio_uml_devices_lock, flags);
+	list_del(&vu_dev->list);
+	spin_unlock_irqrestore(&virtio_uml_devices_lock, flags);
+#endif
 	unregister_virtio_device(&vu_dev->vdev);
 	return 0;
 }
@@ -1125,6 +1309,8 @@ static void vu_conn_broken(struct work_struct *wk)
 {
 	struct virtio_uml_platform_data *pdata;
 
+printk(KERN_DEBUG "************ broken\n");
+
 	pdata = container_of(wk, struct virtio_uml_platform_data, conn_broken_wk);
 	vu_unregister_cmdline_device(&pdata->pdev->dev, NULL);
 }
diff --git a/arch/um/include/linux/time-internal.h b/arch/um/include/linux/time-internal.h
index 752a47d44557..0f1828851180 100644
--- a/arch/um/include/linux/time-internal.h
+++ b/arch/um/include/linux/time-internal.h
@@ -47,5 +47,19 @@ static inline void time_travel_sleep(unsigned long long duration)
 
 /* this is a macro so the event/function need not exist */
 #define time_travel_set_event_fn(e, fn) do {} while (0)
+#endif
+
+#ifdef CONFIG_UML_TIME_TRAVEL_VIRTIO
+extern bool time_travel_virtio;
+void time_travel_propagate_time(void);
+
+void virtio_uml_poll_fds(void);
+void time_travel_add_irq_event(struct time_travel_event *e);
+#else
+#define time_travel_virtio false
+
+static inline void time_travel_propagate_time(void)
+{
+}
 #endif /* CONFIG_UML_TIME_TRAVEL_SUPPORT */
 #endif /* __TIMER_INTERNAL_H__ */
diff --git a/arch/um/include/shared/os.h b/arch/um/include/shared/os.h
index 69cc88b51168..6a6acb2f80ab 100644
--- a/arch/um/include/shared/os.h
+++ b/arch/um/include/shared/os.h
@@ -181,6 +181,12 @@ extern int os_falloc_punch(int fd, unsigned long long offset, int count);
 extern int os_eventfd(unsigned int initval, int flags);
 extern int os_sendmsg_fds(int fd, const void *buf, unsigned int len,
 			  const int *fds, unsigned int fds_num);
+struct os_poll;
+/* Returns 1 if added, 0 if already present, -ENOMEM on OOM */
+int os_poll_add(struct os_poll **poll, int fd);
+void os_poll_remove(struct os_poll **poll, int fd);
+int os_poll(struct os_poll *poll, int timeout);
+bool os_poll_check_readable(struct os_poll *p, int fd);
 
 /* start_up.c */
 extern void os_early_checks(void);
diff --git a/arch/um/kernel/time.c b/arch/um/kernel/time.c
index d3ebb6a448d7..b698b9efcce4 100644
--- a/arch/um/kernel/time.c
+++ b/arch/um/kernel/time.c
@@ -15,6 +15,10 @@
 #include <linux/sched.h>
 #include <linux/spinlock.h>
 #include <linux/threads.h>
+#include <linux/module.h>
+#include <linux/virtio.h>
+#include <linux/virtio_config.h>
+#include <linux/virtio_simtime.h>
 #include <asm/irq.h>
 #include <asm/param.h>
 #include <kern_util.h>
@@ -42,6 +46,265 @@ static void time_travel_set_time(unsigned long long ns)
 	time_travel_time = ns;
 }
 
+#ifdef CONFIG_UML_TIME_TRAVEL_VIRTIO
+bool time_travel_virtio;
+static struct virtio_device *time_travel_virtio_dev;
+static struct virtqueue *time_travel_virtio_vqs[2]; /* request, notify */
+static unsigned long long time_travel_virtio_prev_request;
+static bool time_travel_virtio_prev_request_valid;
+static LIST_HEAD(time_travel_deferred_irqs);
+static unsigned long long time_travel_virtio_free_until;
+static bool time_travel_virtio_free_until_valid;
+static unsigned int time_travel_virtio_waiting;
+static unsigned int virtio_requests_open;
+
+static struct virtio_simtime_msg *simtime_msg_tx, *simtime_msg_resp;
+static struct virtio_simtime_msg *simtime_msg_rx;
+static struct scatterlist _simtime_msg_sgs[3];
+static struct scatterlist *simtime_msg_sgs[2] = {
+	&_simtime_msg_sgs[0],
+	&_simtime_msg_sgs[1],
+};
+
+static void time_travel_virtio_req(u64 op, u64 time)
+{
+	unsigned int wait;
+
+	simtime_msg_tx->op = op;
+	simtime_msg_tx->time = time;
+	virt_wmb();
+
+	BUG_ON(!simtime_msg_tx->op);
+	BUG_ON(!time_travel_virtio_dev);
+
+	wait = virtio_requests_open++;
+
+	virtqueue_add_sgs(time_travel_virtio_vqs[0], simtime_msg_sgs, 1, 1,
+			  simtime_msg_tx, GFP_ATOMIC);
+	virtqueue_kick(time_travel_virtio_vqs[0]);
+
+	while (virtio_requests_open > wait) {
+		virtio_uml_poll_fds();
+		if (virtqueue_is_broken(time_travel_virtio_vqs[1]))
+			panic("timer-virtio device broke!\n");
+	}
+	if (op == VIRTIO_SIMTIME_GET)
+		time_travel_set_time(simtime_msg_resp->time);
+}
+
+static void time_travel_virtio_update_request(unsigned long long time)
+{
+	if (!time_travel_virtio_dev)
+		return;
+
+	/* asked for exactly this time previously */
+	if (time_travel_virtio_prev_request_valid &&
+	    time >= time_travel_virtio_prev_request)
+		return;
+
+	time_travel_virtio_prev_request = time;
+	time_travel_virtio_prev_request_valid = true;
+	time_travel_virtio_req(VIRTIO_SIMTIME_REQUEST, time);
+}
+
+void time_travel_propagate_time(void)
+{
+	time_travel_virtio_req(VIRTIO_SIMTIME_UPDATE, time_travel_time);
+}
+
+/* returns true if we must do a wait to the simtime device */
+static bool time_travel_virtio_request(unsigned long long time)
+{
+	/*
+	 * If we received an external sync point ("free until") then we
+	 * don't have to request/wait for anything until then, unless
+	 * we're already waiting.
+	 */
+	if (!time_travel_virtio_waiting && time_travel_virtio_free_until_valid &&
+	    time < time_travel_virtio_free_until)
+		return false;
+
+	time_travel_virtio_update_request(time);
+	return true;
+}
+
+static void time_travel_virtio_wait(void)
+{
+	int wait = time_travel_virtio_waiting;
+
+	time_travel_virtio_prev_request_valid = false;
+	time_travel_virtio_waiting++;
+
+	time_travel_virtio_req(VIRTIO_SIMTIME_WAIT, -1);
+
+	/*
+	 * Here we are deep in the idle loop, so we have to break out of the
+	 * kernel abstraction in a sense and implement this in terms of the
+	 * UML system waiting on the VQ interrupt while sleeping, when we get
+	 * the signal it'll call time_travel_virtio_vq_notify_done() completing the
+	 * call.
+	 */
+	while (time_travel_virtio_waiting > wait) {
+		virtio_uml_poll_fds();
+		if (virtqueue_is_broken(time_travel_virtio_vqs[1]))
+			panic("timer-virtio device broke!\n");
+	}
+	/* we might request more stuff while polling - reset when we run */
+	time_travel_virtio_prev_request_valid = false;
+}
+
+static void virtio_set_time(unsigned long long to)
+{
+	if (unlikely(!time_travel_virtio_dev)) {
+		time_travel_set_time(to);
+		return;
+	}
+
+	if (time_travel_virtio_request(to))
+		time_travel_virtio_wait();
+	else
+		time_travel_set_time(to);
+}
+
+static void time_travel_virtio_get_time(void)
+{
+	time_travel_virtio_req(VIRTIO_SIMTIME_GET, -1);
+}
+
+static void time_travel_virtio_vq_request_done(struct virtqueue *vq)
+{
+	unsigned int len;
+	struct virtio_simtime_msg *msg = virtqueue_get_buf(vq, &len);
+
+	if (!msg)
+		return;
+
+	virtio_requests_open--;
+}
+
+static void time_travel_virtio_vq_notify_done(struct virtqueue *vq)
+{
+	unsigned int len;
+	struct virtio_simtime_msg *msg = virtqueue_get_buf(vq, &len);
+
+	BUG_ON(!msg || len != sizeof(*msg));
+	switch (msg->op) {
+	case VIRTIO_SIMTIME_RUN:
+		BUG_ON(!time_travel_virtio_waiting);
+		time_travel_set_time(msg->time);
+		/* write the time before setting waiting = false */
+		wmb();
+		time_travel_virtio_waiting--;
+		break;
+	case VIRTIO_SIMTIME_FREE_UNTIL:
+		time_travel_virtio_free_until = msg->time;
+		time_travel_virtio_free_until_valid = true;
+		break;
+	default:
+		pr_err("unexpected simtime message %lld\n",
+		       (unsigned long long)msg->op);
+	}
+
+	/* resubmit the buffer */
+	virtqueue_add_inbuf(time_travel_virtio_vqs[1], &_simtime_msg_sgs[2], 1,
+			    simtime_msg_rx, GFP_ATOMIC);
+	virtqueue_kick(time_travel_virtio_vqs[1]);
+}
+
+static int time_travel_virtio_probe(struct virtio_device *vdev)
+{
+	static const char *const names[2] = { "request", "notify", };
+	static vq_callback_t *callbacks[2] = {
+		time_travel_virtio_vq_request_done,
+		time_travel_virtio_vq_notify_done,
+	};
+	int err;
+
+	if (WARN(!time_travel_virtio,
+		 "Without virtio time-travel mode, virtio timer devices are not useful!"))
+		return -EIO;
+
+	if (WARN(time_travel_virtio_dev,
+		 "Multiple virtio timer devices are not useful!"))
+		return -EIO;
+
+	time_travel_virtio_dev = vdev;
+
+	err = virtio_find_vqs(vdev, 2, time_travel_virtio_vqs, callbacks, names, NULL);
+	if (WARN_ON(err))
+		return err;
+
+	virtio_device_ready(vdev);
+
+	/* submit a buffer for the notification VQ for later */
+	virtqueue_add_inbuf(time_travel_virtio_vqs[1], &_simtime_msg_sgs[2], 1,
+			    simtime_msg_rx, GFP_KERNEL);
+	virtqueue_kick(time_travel_virtio_vqs[1]);
+
+	pr_info("virtio-timer device connected\n");
+
+	return 0;
+}
+
+static void time_travel_virtio_remove(struct virtio_device *vdev)
+{
+	panic("virtio-timer device must not be removed\n");
+}
+
+static struct virtio_device_id time_travel_virtio_id_table[] = {
+	{ VIRTIO_ID_SIMTIME, VIRTIO_DEV_ANY_ID },
+	{ 0 },
+};
+
+static struct virtio_driver time_travel_virtio_driver = {
+	.driver.name = "virtio-timer",
+	.driver.owner =	THIS_MODULE,
+	.id_table = time_travel_virtio_id_table,
+	.probe = time_travel_virtio_probe,
+	.remove = time_travel_virtio_remove,
+};
+
+static int time_travel_virtio_init(void)
+{
+	simtime_msg_tx = kmalloc_array(3, sizeof(*simtime_msg_tx), GFP_KERNEL);
+	BUG_ON(!simtime_msg_tx);
+	simtime_msg_resp = simtime_msg_tx + 1;
+	simtime_msg_rx = simtime_msg_tx + 2;
+
+	sg_init_one(&_simtime_msg_sgs[0], simtime_msg_tx,
+		    sizeof(*simtime_msg_tx));
+	sg_init_one(&_simtime_msg_sgs[1], simtime_msg_resp,
+		    sizeof(*simtime_msg_resp));
+	sg_init_one(&_simtime_msg_sgs[2], simtime_msg_rx,
+		    sizeof(*simtime_msg_rx));
+
+	return register_virtio_driver(&time_travel_virtio_driver);
+}
+module_init(time_travel_virtio_init);
+#else
+#define time_travel_virtio_dev NULL
+
+static void virtio_set_time(unsigned long long to)
+{
+}
+
+static void time_travel_virtio_get_time(void)
+{
+}
+
+static void time_travel_virtio_update_request(unsigned long long time)
+{
+}
+#endif /* CONFIG_VIRTIO_UML */
+
+static void __time_travel_update_time(unsigned long long ns)
+{
+	if (time_travel_virtio)
+		virtio_set_time(ns);
+	else
+		time_travel_set_time(ns);
+}
+
 static void time_travel_add_event(struct time_travel_event *e,
 				  unsigned long long time)
 {
@@ -76,6 +339,7 @@ static void time_travel_add_event(struct time_travel_event *e,
 	tmp = list_first_entry(&time_travel_events,
 			       struct time_travel_event,
 			       list);
+	time_travel_virtio_update_request(tmp->time);
 	time_travel_next_event = tmp->time;
 }
 
@@ -88,8 +352,17 @@ void time_travel_periodic_timer(struct time_travel_event *e)
 
 static void time_travel_deliver_event(struct time_travel_event *e)
 {
-	/* this is basically just deliver_alarm(), handles IRQs itself */
-	e->fn(e);
+	if (e == &time_travel_timer_event) {
+		/*
+		 * deliver_alarm() does the irq_enter/irq_exit
+		 * by itself, so must handle it specially here
+		 */
+		e->fn(e);
+	} else {
+		irq_enter();
+		e->fn(e);
+		irq_exit();
+	}
 }
 
 static bool time_travel_del_event(struct time_travel_event *e)
@@ -112,7 +385,7 @@ static void time_travel_update_time(unsigned long long next, bool retearly)
 
 		if (e && e->time <= next) {
 			BUG_ON(!time_travel_del_event(e));
-			time_travel_set_time(e->time);
+			__time_travel_update_time(e->time);
 			if (irqs_disabled()) {
 				mark_time_travel_irq_pending();
 				e->pending = true;
@@ -122,8 +395,14 @@ static void time_travel_update_time(unsigned long long next, bool retearly)
 				time_travel_deliver_event(e);
 			}
 		} else {
-			time_travel_set_time(next);
+			__time_travel_update_time(next);
 		}
+
+		e = list_first_entry_or_null(&time_travel_events,
+					     struct time_travel_event,
+					     list);
+		if (e)
+			time_travel_virtio_update_request(e->time);
 	} while (!retearly && time_travel_time < next);
 }
 
@@ -140,7 +419,20 @@ void time_travel_deliver_pending(void)
 	}
 }
 
-static void time_travel_oneshot_timer(struct time_travel_event *e)
+void time_travel_add_irq_event(struct time_travel_event *e)
+{
+	BUG_ON(!time_travel_virtio);
+
+	time_travel_virtio_get_time();
+	/*
+	 * We could model interrupt latency here, for now just
+	 * don't have any latency at all and request the exact
+	 * same time (again) to run the interrupt...
+	 */
+	time_travel_add_event(e, time_travel_time);
+}
+
+void time_travel_oneshot_timer(struct time_travel_event *e)
 {
 	deliver_alarm();
 }
@@ -152,6 +444,9 @@ void time_travel_sleep(unsigned long long duration)
 	if (time_travel_mode == TT_MODE_BASIC)
 		os_timer_disable();
 
+	if (unlikely(time_travel_virtio && !time_travel_virtio_dev))
+		panic("Must have a virtio timer device for time-travel=virtio");
+
 	time_travel_update_time(next, true);
 
 	if (time_travel_mode == TT_MODE_BASIC &&
@@ -402,6 +697,16 @@ int setup_time_travel(char *str)
 		return 1;
 	}
 
+#ifdef CONFIG_UML_TIME_TRAVEL_VIRTIO
+	if (strcmp(str, "=virtio") == 0) {
+		time_travel_mode = TT_MODE_INFCPU;
+		time_travel_virtio = true;
+		timer_clockevent.name = "time-travel-timer-external";
+		timer_clocksource.name = "time-travel-clock-external";
+		return 1;
+	}
+#endif
+
 	if (!*str) {
 		time_travel_mode = TT_MODE_BASIC;
 		timer_clockevent.name = "time-travel-timer";
diff --git a/arch/um/os-Linux/file.c b/arch/um/os-Linux/file.c
index 5133e3afb96f..3e598f47fa9e 100644
--- a/arch/um/os-Linux/file.c
+++ b/arch/um/os-Linux/file.c
@@ -5,6 +5,7 @@
 
 #include <stdio.h>
 #include <unistd.h>
+#include <stdlib.h>
 #include <errno.h>
 #include <fcntl.h>
 #include <signal.h>
@@ -16,6 +17,7 @@
 #include <sys/un.h>
 #include <sys/types.h>
 #include <sys/eventfd.h>
+#include <poll.h>
 #include <os.h>
 
 static void copy_stat(struct uml_stat *dst, const struct stat64 *src)
@@ -664,3 +666,117 @@ int os_sendmsg_fds(int fd, const void *buf, unsigned int len, const int *fds,
 		return -errno;
 	return err;
 }
+
+struct os_poll {
+	unsigned int max, n;
+	struct pollfd fds[];
+};
+
+int os_poll_add(struct os_poll **pp, int fd)
+{
+	struct os_poll *p = *pp;
+
+	if (p) {
+		int i;
+
+		for (i = 0; i < p->n; i++)
+			if (p->fds[i].fd == fd)
+				return 0;
+	}
+
+	if (!p || p->n >= p->max) {
+		unsigned int n = p ? 2 * p->max : 10;
+		unsigned int nsize = sizeof(*p) + n * sizeof(p->fds[0]);
+		struct os_poll *pnew;
+
+		/* NB: realloc isn't wrapped, open-code it */
+		pnew = malloc(nsize);
+		if (!pnew)
+			return -ENOMEM;
+		memset(pnew, 0, nsize);
+		if (p) {
+			memcpy(pnew, p, sizeof(*p) + p->n * sizeof(p->fds[0]));
+			free(p);
+		}
+		p = pnew;
+		p->max = n;
+	}
+
+	p->fds[p->n].fd = fd;
+	p->fds[p->n].events = POLLIN;
+	p->fds[p->n].revents = 0;
+	p->n++;
+
+	*pp = p;
+	return 1;
+}
+
+void os_poll_remove(struct os_poll **pp, int fd)
+{
+	struct os_poll *p = *pp;
+	int i, found = -1;
+
+	for (i = 0; i < p->n; i++) {
+		if (p->fds[i].fd == fd) {
+			found = i;
+			break;
+		}
+	}
+
+	if (found < 0)
+		return;
+
+	p->n--;
+	p->fds[found] = p->fds[p->n];
+	if (p->n == 0) {
+		free(p);
+		*pp = NULL;
+	}
+}
+
+int os_poll(struct os_poll *p, int timeout)
+{
+	int ret, i;
+
+	if (!p)
+		return -ENOENT;
+
+	for (i = 0; i < p->n; i++)
+		p->fds[i].revents = 0;
+
+	ret = poll(p->fds, p->n, timeout);
+
+	if (ret < 0)
+		return -errno;
+	return ret;
+}
+
+bool os_poll_check_readable(struct os_poll *p, int fd)
+{
+	int i;
+
+	if (!p)
+		return false;
+
+	for (i = 0; i < p->n; i++) {
+		if (p->fds[i].fd == fd)
+			return p->fds[i].revents & POLLIN;
+	}
+
+	return false;
+}
+
+bool os_poll_present(struct os_poll *p, int fd)
+{
+	int i;
+
+	if (!p)
+		return false;
+
+	for (i = 0; i < p->n; i++) {
+		if (p->fds[i].fd == fd)
+			return true;
+	}
+
+	return false;
+}
diff --git a/include/uapi/linux/virtio_ids.h b/include/uapi/linux/virtio_ids.h
index 348fd0176f75..745a6dc5af90 100644
--- a/include/uapi/linux/virtio_ids.h
+++ b/include/uapi/linux/virtio_ids.h
@@ -46,4 +46,6 @@
 #define VIRTIO_ID_IOMMU        23 /* virtio IOMMU */
 #define VIRTIO_ID_PMEM         27 /* virtio pmem */
 
+#define VIRTIO_ID_SIMTIME    1234 /* virtio time travel device for UML */
+
 #endif /* _LINUX_VIRTIO_IDS_H */
diff --git a/include/uapi/linux/virtio_simtime.h b/include/uapi/linux/virtio_simtime.h
new file mode 100644
index 000000000000..72b77b1c7e8f
--- /dev/null
+++ b/include/uapi/linux/virtio_simtime.h
@@ -0,0 +1,99 @@
+/*
+ * This header file is BSD licensed so anyone can use the definitions to
+ * implement compatible drivers/servers:
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions
+ * are met:
+ * 1. Redistributions of source code must retain the above copyright
+ *    notice, this list of conditions and the following disclaimer.
+ * 2. Redistributions in binary form must reproduce the above copyright
+ *    notice, this list of conditions and the following disclaimer in the
+ *    documentation and/or other materials provided with the distribution.
+ * 3. Neither the name of Intel nor the names of its contributors
+ *    may be used to endorse or promote products derived from this software
+ *    without specific prior written permission.
+ * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS ``AS IS'' AND
+ * ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
+ * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
+ * ARE DISCLAIMED.  IN NO EVENT SHALL INTEL OR CONTRIBUTORS BE LIABLE
+ * FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
+ * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
+ * OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
+ * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
+ * LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY
+ * OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
+ * SUCH DAMAGE.
+ *
+ * Copyright (C) 2019 Intel Corporation
+ */
+#ifndef _UAPI_LINUX_VIRTIO_SIMTIME_H
+#define _UAPI_LINUX_VIRTIO_SIMTIME_H
+#include <linux/types.h>
+#include <linux/virtio_types.h>
+#include <linux/virtio_ids.h>
+
+/*
+ * A message passed on either of the VQs (input and output).
+ */
+struct virtio_simtime_msg {
+	__u64 op;		/* see below */
+	__u64 time;		/* time in nanoseconds */
+};
+
+/**
+ * enum virtio_simtime_ops - Operation codes
+ */
+enum virtio_simtime_ops {
+	/**
+	 * @VIRTIO_SIMTIME_REQUEST: request to run at the given time
+	 *	(host -> device)
+	 */
+	VIRTIO_SIMTIME_REQUEST		= 1,
+
+	/**
+	 * @VIRTIO_SIMTIME_WAIT: Indicate waiting for the previously requested
+	 *	runtime, new requests may be made while waiting (e.g. due to
+	 *	interrupts); the time field is ignored. The device must process
+	 *	this message and later	send a %VIRTIO_SIMTIME_RUN message when
+	 *	the host can run again.
+	 *	(host -> device)
+	 */
+	VIRTIO_SIMTIME_WAIT		= 2,
+
+	/**
+	 * @VIRTIO_SIMTIME_GET: return the current time from the device, it
+	 *	must fill the input buffer that's given; the time field is
+	 *	ignored
+	 *	(host -> device, which fills the input buffer)
+	 */
+	VIRTIO_SIMTIME_GET		= 3,
+
+	/**
+	 * @VIRTIO_SIMTIME_UPDATE: time update to the device, must be sent e.g.
+	 *	before kicking an interrupt to another device
+	 *	(host -> device)
+	 */
+	VIRTIO_SIMTIME_UPDATE		= 4,
+
+	/**
+	 * @VIRTIO_SIMTIME_RUN: run time request granted, current time is in
+	 *	the time field
+	 *	(device -> host)
+	 */
+	VIRTIO_SIMTIME_RUN		= 5,
+
+	/**
+	 * @VIRTIO_SIMTIME_FREE_UNTIL: Enable free-running until the given time,
+	 *	this is a message from the device telling the host that it can
+	 *	freely do its own scheduling for anything before the indicated
+	 *	time.
+	 *	Note that if a device sends this message once, the host may
+	 *	assume that it will also do so in the future, if it implements
+	 *	wraparound semantics for the time field.
+	 *	(device -> host)
+	 */
+	VIRTIO_SIMTIME_FREE_UNTIL	= 6,
+};
+
+#endif /* _UAPI_LINUX_VIRTIO_SIMTIME_H */
-- 
2.20.1


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

