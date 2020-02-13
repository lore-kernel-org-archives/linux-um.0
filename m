Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1j2EWI-0001vD-3J
 for linux-um@lists.infradead.org; Thu, 13 Feb 2020 13:27:11 +0000
From: Johannes Berg <johannes@sipsolutions.net>
Subject: [PATCH 4/6] um: implement time-travel=ext
Date: Thu, 13 Feb 2020 14:26:47 +0100
Message-Id: <20200213132651.20506-5-johannes@sipsolutions.net>
In-Reply-To: <20200213132651.20506-1-johannes@sipsolutions.net>
References: <20200213132651.20506-1-johannes@sipsolutions.net>
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

This implements synchronized time-travel mode which - using a special
application on a unix socket - lets multiple machines take part in a
time-travelling simulation together.

The protocol for the unix domain socket is defined in the new file
include/uapi/linux/um_timetravel.h.

Change-Id: I0c06fae89d77d5b272dfb4c7ea64641b597b5c7b
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 arch/um/drivers/virtio_uml.c          |  68 +++++-
 arch/um/include/linux/time-internal.h |  27 +++
 arch/um/include/shared/os.h           |   1 +
 arch/um/kernel/skas/syscall.c         |   3 +-
 arch/um/kernel/time.c                 | 323 +++++++++++++++++++++++++-
 arch/um/os-Linux/file.c               |  30 +++
 include/uapi/linux/um_timetravel.h    | 128 ++++++++++
 7 files changed, 563 insertions(+), 17 deletions(-)
 create mode 100644 include/uapi/linux/um_timetravel.h

diff --git a/arch/um/drivers/virtio_uml.c b/arch/um/drivers/virtio_uml.c
index 9b4c5b7c0f0d..be54d368e73d 100644
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
@@ -64,6 +65,11 @@ struct virtio_uml_device {
 struct virtio_uml_vq_info {
 	int kick_fd, call_fd;
 	char name[32];
+#ifdef CONFIG_UML_TIME_TRAVEL_SUPPORT
+	struct virtqueue *vq;
+	vq_callback_t *callback;
+	struct time_travel_event defer;
+#endif
 };
 
 extern unsigned long long physmem_size, highmem;
@@ -118,10 +124,27 @@ static int vhost_user_recv_header(int fd, struct vhost_user_msg *msg)
 
 static int vhost_user_recv(struct virtio_uml_device *vu_dev,
 			   int fd, struct vhost_user_msg *msg,
-			   size_t max_payload_size)
+			   size_t max_payload_size, bool wait)
 {
 	size_t size;
-	int rc = vhost_user_recv_header(fd, msg);
+	int rc;
+
+	/*
+	 * In virtio time-travel mode, we're handling all the vhost-user
+	 * FDs by polling them whenever appropriate. However, we may get
+	 * into a situation where we're sending out an interrupt message
+	 * to a device (e.g. a net device) and need to handle a simulation
+	 * time message while doing so, e.g. one that tells us to update
+	 * our idea of how long we can run without scheduling.
+	 *
+	 * Thus, we need to not just read() from the given fd, but need
+	 * to also handle messages for the simulation time - this function
+	 * does that for us while waiting for the given fd to be readable.
+	 */
+	if (wait)
+		time_travel_wait_readable(fd);
+
+	rc = vhost_user_recv_header(fd, msg);
 
 	if (rc == -ECONNRESET && vu_dev->registered) {
 		struct virtio_uml_platform_data *pdata;
@@ -143,7 +166,8 @@ static int vhost_user_recv_resp(struct virtio_uml_device *vu_dev,
 				struct vhost_user_msg *msg,
 				size_t max_payload_size)
 {
-	int rc = vhost_user_recv(vu_dev, vu_dev->sock, msg, max_payload_size);
+	int rc = vhost_user_recv(vu_dev, vu_dev->sock, msg,
+				 max_payload_size, true);
 
 	if (rc)
 		return rc;
@@ -173,7 +197,8 @@ static int vhost_user_recv_req(struct virtio_uml_device *vu_dev,
 			       struct vhost_user_msg *msg,
 			       size_t max_payload_size)
 {
-	int rc = vhost_user_recv(vu_dev, vu_dev->req_fd, msg, max_payload_size);
+	int rc = vhost_user_recv(vu_dev, vu_dev->req_fd, msg,
+				 max_payload_size, false);
 
 	if (rc)
 		return rc;
@@ -700,6 +725,8 @@ static bool vu_notify(struct virtqueue *vq)
 	const uint64_t n = 1;
 	int rc;
 
+	time_travel_propagate_time();
+
 	if (info->kick_fd < 0) {
 		struct virtio_uml_device *vu_dev;
 
@@ -847,6 +874,23 @@ static int vu_setup_vq_call_fd(struct virtio_uml_device *vu_dev,
 	return rc;
 }
 
+#ifdef CONFIG_UML_TIME_TRAVEL_SUPPORT
+static void vu_defer_irq_handle(struct time_travel_event *d)
+{
+	struct virtio_uml_vq_info *info;
+
+	info = container_of(d, struct virtio_uml_vq_info, defer);
+	info->callback(info->vq);
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
@@ -866,6 +910,19 @@ static struct virtqueue *vu_setup_vq(struct virtio_device *vdev,
 	snprintf(info->name, sizeof(info->name), "%s.%d-%s", pdev->name,
 		 pdev->id, name);
 
+#ifdef CONFIG_UML_TIME_TRAVEL_SUPPORT
+	/*
+	 * When we get an interrupt, we must bounce it through the simulation
+	 * calendar (the simtime device), except for the simtime device itself
+	 * since that's part of the simulation control.
+	 */
+	if (time_travel_mode == TT_MODE_EXTERNAL && callback) {
+		info->callback = callback;
+		callback = vu_defer_irq_callback;
+		time_travel_set_event_fn(&info->defer, vu_defer_irq_handle);
+	}
+#endif
+
 	vq = vring_create_virtqueue(index, num, PAGE_SIZE, vdev, true, true,
 				    ctx, vu_notify, callback, info->name);
 	if (!vq) {
@@ -874,6 +931,9 @@ static struct virtqueue *vu_setup_vq(struct virtio_device *vdev,
 	}
 	vq->priv = info;
 	num = virtqueue_get_vring_size(vq);
+#ifdef CONFIG_UML_TIME_TRAVEL_SUPPORT
+	info->vq = vq;
+#endif
 
 	if (vu_dev->protocol_features &
 			BIT_ULL(VHOST_USER_PROTOCOL_F_INBAND_NOTIFICATIONS)) {
diff --git a/arch/um/include/linux/time-internal.h b/arch/um/include/linux/time-internal.h
index eb1f84616edb..e21655926f08 100644
--- a/arch/um/include/linux/time-internal.h
+++ b/arch/um/include/linux/time-internal.h
@@ -15,6 +15,7 @@ enum time_travel_mode {
 	TT_MODE_OFF,
 	TT_MODE_BASIC,
 	TT_MODE_INFCPU,
+	TT_MODE_EXTERNAL,
 };
 
 #ifdef CONFIG_UML_TIME_TRAVEL_SUPPORT
@@ -35,6 +36,24 @@ time_travel_set_event_fn(struct time_travel_event *e,
 {
 	e->fn = fn;
 }
+
+void __time_travel_propagate_time(void);
+
+static inline void time_travel_propagate_time(void)
+{
+	if (time_travel_mode == TT_MODE_EXTERNAL)
+		__time_travel_propagate_time();
+}
+
+void __time_travel_wait_readable(int fd);
+
+static inline void time_travel_wait_readable(int fd)
+{
+	if (time_travel_mode == TT_MODE_EXTERNAL)
+		__time_travel_wait_readable(fd);
+}
+
+void time_travel_add_irq_event(struct time_travel_event *e);
 #else
 struct time_travel_event {
 };
@@ -47,5 +66,13 @@ static inline void time_travel_sleep(unsigned long long duration)
 
 /* this is a macro so the event/function need not exist */
 #define time_travel_set_event_fn(e, fn) do {} while (0)
+
+static inline void time_travel_propagate_time(void)
+{
+}
+
+static inline void time_travel_wait_readable(int fd)
+{
+}
 #endif /* CONFIG_UML_TIME_TRAVEL_SUPPORT */
 #endif /* __TIMER_INTERNAL_H__ */
diff --git a/arch/um/include/shared/os.h b/arch/um/include/shared/os.h
index 506bcd1bca68..65af1f27b968 100644
--- a/arch/um/include/shared/os.h
+++ b/arch/um/include/shared/os.h
@@ -181,6 +181,7 @@ extern int os_falloc_punch(int fd, unsigned long long offset, int count);
 extern int os_eventfd(unsigned int initval, int flags);
 extern int os_sendmsg_fds(int fd, const void *buf, unsigned int len,
 			  const int *fds, unsigned int fds_num);
+int os_poll(unsigned int n, const int *fds);
 
 /* start_up.c */
 extern void os_early_checks(void);
diff --git a/arch/um/kernel/skas/syscall.c b/arch/um/kernel/skas/syscall.c
index 2e82820f7d29..0a12d5a09217 100644
--- a/arch/um/kernel/skas/syscall.c
+++ b/arch/um/kernel/skas/syscall.c
@@ -24,7 +24,8 @@ void handle_syscall(struct uml_pt_regs *r)
 	 * went to sleep, even if said userspace interacts with the kernel in
 	 * various ways.
 	 */
-	if (time_travel_mode == TT_MODE_INFCPU)
+	if (time_travel_mode == TT_MODE_INFCPU ||
+	    time_travel_mode == TT_MODE_EXTERNAL)
 		schedule();
 
 	/* Initialize the syscall number and default return value. */
diff --git a/arch/um/kernel/time.c b/arch/um/kernel/time.c
index cdebe96308d7..15c4825b857e 100644
--- a/arch/um/kernel/time.c
+++ b/arch/um/kernel/time.c
@@ -20,10 +20,12 @@
 #include <kern_util.h>
 #include <os.h>
 #include <linux/time-internal.h>
+#include <linux/um_timetravel.h>
 #include <shared/init.h>
 
 #ifdef CONFIG_UML_TIME_TRAVEL_SUPPORT
 enum time_travel_mode time_travel_mode;
+EXPORT_SYMBOL_GPL(time_travel_mode);
 
 static bool time_travel_start_set;
 static unsigned long long time_travel_start;
@@ -32,6 +34,12 @@ static LIST_HEAD(time_travel_events);
 static unsigned long long time_travel_timer_interval;
 static unsigned long long time_travel_next_event;
 static struct time_travel_event time_travel_timer_event;
+static int time_travel_ext_fd = -1;
+static unsigned int time_travel_ext_waiting;
+static bool time_travel_ext_prev_request_valid;
+static unsigned long long time_travel_ext_prev_request;
+static bool time_travel_ext_free_until_valid;
+static unsigned long long time_travel_ext_free_until;
 
 static void time_travel_set_time(unsigned long long ns)
 {
@@ -41,6 +49,199 @@ static void time_travel_set_time(unsigned long long ns)
 	time_travel_time = ns;
 }
 
+enum time_travel_message_handling {
+	TTMH_IDLE,
+	TTMH_POLL,
+	TTMH_READ,
+};
+
+static void time_travel_handle_message(struct um_timetravel_msg *msg,
+				       enum time_travel_message_handling mode)
+{
+	struct um_timetravel_msg resp = {
+		.op = UM_TIMETRAVEL_ACK,
+	};
+	int ret;
+
+	/*
+	 * Poll outside the locked section (if we're not called to only read
+	 * the response) so we can get interrupts for e.g. virtio while we're
+	 * here, but then we need to lock to not get interrupted between the
+	 * read of the message and write of the ACK.
+	 */
+	if (mode != TTMH_READ) {
+		while (os_poll(1, &time_travel_ext_fd) != 0) {
+			if (mode == TTMH_IDLE) {
+				BUG_ON(!irqs_disabled());
+				local_irq_enable();
+				local_irq_disable();
+			}
+		}
+	}
+
+	ret = os_read_file(time_travel_ext_fd, msg, sizeof(*msg));
+
+	if (ret == 0)
+		panic("time-travel external link is broken\n");
+	if (ret != sizeof(*msg))
+		panic("invalid time-travel message - %d bytes\n", ret);
+
+	switch (msg->op) {
+	default:
+		WARN_ONCE(1, "time-travel: unexpected message %lld\n",
+			  (unsigned long long)msg->op);
+		break;
+	case UM_TIMETRAVEL_ACK:
+		return;
+	case UM_TIMETRAVEL_RUN:
+		time_travel_set_time(msg->time);
+		break;
+	case UM_TIMETRAVEL_FREE_UNTIL:
+		time_travel_ext_free_until_valid = true;
+		time_travel_ext_free_until = msg->time;
+		break;
+	}
+
+	os_write_file(time_travel_ext_fd, &resp, sizeof(resp));
+}
+
+static u64 time_travel_ext_req(u32 op, u64 time)
+{
+	static int seq;
+	int mseq = ++seq;
+	struct um_timetravel_msg msg = {
+		.op = op,
+		.time = time,
+		.seq = mseq,
+	};
+	unsigned long flags;
+
+	/*
+	 * We need to save interrupts here and only restore when we
+	 * got the ACK - otherwise we can get interrupted and send
+	 * another request while we're still waiting for an ACK, but
+	 * the peer doesn't know we got interrupted and will send
+	 * the ACKs in the same order as the message, but we'd need
+	 * to see them in the opposite order ...
+	 *
+	 * This wouldn't matter *too* much, but some ACKs carry the
+	 * current time (for UM_TIMETRAVEL_GET) and getting another
+	 * ACK without a time would confuse us a lot!
+	 *
+	 * The sequence number assignment that happens here lets us
+	 * debug such message handling issues more easily.
+	 */
+	local_irq_save(flags);
+	os_write_file(time_travel_ext_fd, &msg, sizeof(msg));
+
+	while (msg.op != UM_TIMETRAVEL_ACK)
+		time_travel_handle_message(&msg, TTMH_READ);
+
+	if (msg.seq != mseq)
+		panic("time-travel: ACK message has different seqno! op=%d, seq=%d != %d time=%lld\n",
+		      msg.op, msg.seq, mseq, msg.time);
+
+	if (op == UM_TIMETRAVEL_GET)
+		time_travel_set_time(msg.time);
+	local_irq_restore(flags);
+
+	return msg.time;
+}
+
+void __time_travel_wait_readable(int fd)
+{
+	int fds[2] = { fd, time_travel_ext_fd };
+	int ret;
+
+	if (time_travel_mode != TT_MODE_EXTERNAL)
+		return;
+
+	while ((ret = os_poll(2, fds))) {
+		struct um_timetravel_msg msg;
+
+		if (ret == 1)
+			time_travel_handle_message(&msg, TTMH_READ);
+	}
+}
+EXPORT_SYMBOL_GPL(__time_travel_wait_readable);
+
+static void time_travel_ext_update_request(unsigned long long time)
+{
+	if (time_travel_mode != TT_MODE_EXTERNAL)
+		return;
+
+	/* asked for exactly this time previously */
+	if (time_travel_ext_prev_request_valid &&
+	    time == time_travel_ext_prev_request)
+		return;
+
+	time_travel_ext_prev_request = time;
+	time_travel_ext_prev_request_valid = true;
+	time_travel_ext_req(UM_TIMETRAVEL_REQUEST, time);
+}
+
+void __time_travel_propagate_time(void)
+{
+	time_travel_ext_req(UM_TIMETRAVEL_UPDATE, time_travel_time);
+}
+EXPORT_SYMBOL_GPL(__time_travel_propagate_time);
+
+/* returns true if we must do a wait to the simtime device */
+static bool time_travel_ext_request(unsigned long long time)
+{
+	/*
+	 * If we received an external sync point ("free until") then we
+	 * don't have to request/wait for anything until then, unless
+	 * we're already waiting.
+	 */
+	if (!time_travel_ext_waiting && time_travel_ext_free_until_valid &&
+	    time < time_travel_ext_free_until)
+		return false;
+
+	time_travel_ext_update_request(time);
+	return true;
+}
+
+static void time_travel_ext_wait(bool idle)
+{
+	struct um_timetravel_msg msg = {
+		.op = UM_TIMETRAVEL_ACK,
+	};
+
+	time_travel_ext_prev_request_valid = false;
+	time_travel_ext_waiting++;
+
+	time_travel_ext_req(UM_TIMETRAVEL_WAIT, -1);
+
+	/*
+	 * Here we are deep in the idle loop, so we have to break out of the
+	 * kernel abstraction in a sense and implement this in terms of the
+	 * UML system waiting on the VQ interrupt while sleeping, when we get
+	 * the signal it'll call time_travel_ext_vq_notify_done() completing the
+	 * call.
+	 */
+	while (msg.op != UM_TIMETRAVEL_RUN)
+		time_travel_handle_message(&msg, idle ? TTMH_IDLE : TTMH_POLL);
+
+	time_travel_ext_waiting--;
+
+	/* we might request more stuff while polling - reset when we run */
+	time_travel_ext_prev_request_valid = false;
+}
+
+static void time_travel_ext_get_time(void)
+{
+	time_travel_ext_req(UM_TIMETRAVEL_GET, -1);
+}
+
+static void __time_travel_update_time(unsigned long long ns, bool idle)
+{
+	if (time_travel_mode == TT_MODE_EXTERNAL && time_travel_ext_request(ns))
+		time_travel_ext_wait(idle);
+	else
+		time_travel_set_time(ns);
+}
+
 static struct time_travel_event *time_travel_first_event(void)
 {
 	return list_first_entry_or_null(&time_travel_events,
@@ -85,6 +286,7 @@ static void __time_travel_add_event(struct time_travel_event *e,
 		list_add_tail(&e->list, &time_travel_events);
 
 	tmp = time_travel_first_event();
+	time_travel_ext_update_request(tmp->time);
 	time_travel_next_event = tmp->time;
 }
 
@@ -106,8 +308,21 @@ void time_travel_periodic_timer(struct time_travel_event *e)
 
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
+		unsigned long flags;
+
+		local_irq_save(flags);
+		irq_enter();
+		e->fn(e);
+		irq_exit();
+		local_irq_restore(flags);
+	}
 }
 
 static bool time_travel_del_event(struct time_travel_event *e)
@@ -119,13 +334,13 @@ static bool time_travel_del_event(struct time_travel_event *e)
 	return true;
 }
 
-static void time_travel_update_time(unsigned long long next, bool retearly)
+static void time_travel_update_time(unsigned long long next, bool idle)
 {
 	struct time_travel_event ne = {
 		.onstack = true,
 	};
 	struct time_travel_event *e;
-	bool finished = retearly;
+	bool finished = idle;
 
 	/* add it without a handler - we deal with that specifically below */
 	__time_travel_add_event(&ne, next);
@@ -134,7 +349,7 @@ static void time_travel_update_time(unsigned long long next, bool retearly)
 		e = time_travel_first_event();
 
 		BUG_ON(!e);
-		time_travel_set_time(e->time);
+		__time_travel_update_time(e->time, idle);
 
 		/* new events may have been inserted while we were waiting */
 		if (e == time_travel_first_event()) {
@@ -150,11 +365,29 @@ static void time_travel_update_time(unsigned long long next, bool retearly)
 				time_travel_deliver_event(e);
 			}
 		}
-	} while (!finished);
+
+		e = time_travel_first_event();
+		if (e)
+			time_travel_ext_update_request(e->time);
+	} while (ne.pending && !finished);
 
 	time_travel_del_event(&ne);
 }
 
+void time_travel_add_irq_event(struct time_travel_event *e)
+{
+	BUG_ON(time_travel_mode != TT_MODE_EXTERNAL);
+
+	time_travel_ext_get_time();
+	/*
+	 * We could model interrupt latency here, for now just
+	 * don't have any latency at all and request the exact
+	 * same time (again) to run the interrupt...
+	 */
+	time_travel_add_event(e, time_travel_time);
+}
+EXPORT_SYMBOL_GPL(time_travel_add_irq_event);
+
 static void time_travel_oneshot_timer(struct time_travel_event *e)
 {
 	deliver_alarm();
@@ -199,6 +432,42 @@ static void time_travel_set_interval(unsigned long long interval)
 {
 	time_travel_timer_interval = interval;
 }
+
+static int time_travel_connect_external(const char *socket)
+{
+	const char *sep;
+	unsigned long long id = (unsigned long long)-1;
+	int rc;
+
+	if ((sep = strchr(socket, ':'))) {
+		char buf[25] = {};
+		if (sep - socket > sizeof(buf) - 1)
+			goto invalid_number;
+
+		memcpy(buf, socket, sep - socket);
+		if (kstrtoull(buf, 0, &id)) {
+invalid_number:
+			panic("time-travel: invalid external ID in string '%s'\n",
+			      socket);
+			return -EINVAL;
+		}
+
+		socket = sep + 1;
+	}
+
+	rc = os_connect_socket(socket);
+	if (rc < 0) {
+		panic("time-travel: failed to connect to external socket %s\n",
+		      socket);
+		return rc;
+	}
+
+	time_travel_ext_fd = rc;
+
+	time_travel_ext_req(UM_TIMETRAVEL_START, id);
+
+	return 1;
+}
 #else /* CONFIG_UML_TIME_TRAVEL_SUPPORT */
 #define time_travel_start_set 0
 #define time_travel_start 0
@@ -216,6 +485,9 @@ static void time_travel_set_interval(unsigned long long interval)
 {
 }
 
+/* fail link if this actually gets used */
+extern u64 time_travel_ext_req(u32 op, u64 time);
+
 /* these are empty macros so the struct/fn need not exist */
 #define time_travel_add_event(e, time) do { } while (0)
 #define time_travel_del_event(e) do { } while (0)
@@ -246,7 +518,8 @@ static int itimer_shutdown(struct clock_event_device *evt)
 	if (time_travel_mode != TT_MODE_OFF)
 		time_travel_del_event(&time_travel_timer_event);
 
-	if (time_travel_mode != TT_MODE_INFCPU)
+	if (time_travel_mode != TT_MODE_INFCPU &&
+	    time_travel_mode != TT_MODE_EXTERNAL)
 		os_timer_disable();
 
 	return 0;
@@ -265,7 +538,8 @@ static int itimer_set_periodic(struct clock_event_device *evt)
 				      time_travel_time + interval);
 	}
 
-	if (time_travel_mode != TT_MODE_INFCPU)
+	if (time_travel_mode != TT_MODE_INFCPU &&
+	    time_travel_mode != TT_MODE_EXTERNAL)
 		os_timer_set_interval(interval);
 
 	return 0;
@@ -284,7 +558,8 @@ static int itimer_next_event(unsigned long delta,
 				      time_travel_time + delta);
 	}
 
-	if (time_travel_mode != TT_MODE_INFCPU)
+	if (time_travel_mode != TT_MODE_INFCPU &&
+	    time_travel_mode != TT_MODE_EXTERNAL)
 		return os_timer_one_shot(delta);
 
 	return 0;
@@ -335,8 +610,14 @@ static u64 timer_read(struct clocksource *cs)
 		 * stuck in loops that expect time to move more than the
 		 * exact requested sleep amount, e.g. python's socket server,
 		 * see https://bugs.python.org/issue37026.
+		 *
+		 * However, don't do that when we're in interrupt or such as
+		 * then we might recurse into our own processing, and get to
+		 * even more waiting, and that's not good - it messes up the
+		 * "what do I do next" and onstack event we use to know when
+		 * to return from time_travel_update_time().
 		 */
-		if (!irqs_disabled())
+		if (!irqs_disabled() && !in_interrupt() && !in_softirq())
 			time_travel_update_time(time_travel_time +
 						TIMER_MULTIPLIER,
 						false);
@@ -383,6 +664,8 @@ void read_persistent_clock64(struct timespec64 *ts)
 
 	if (time_travel_start_set)
 		nsecs = time_travel_start + time_travel_time;
+	else if (time_travel_mode == TT_MODE_EXTERNAL)
+		nsecs = time_travel_ext_req(UM_TIMETRAVEL_GET_TOD, -1);
 	else
 		nsecs = os_persistent_clock_emulation();
 
@@ -399,7 +682,8 @@ void __init time_init(void)
 #ifdef CONFIG_UML_TIME_TRAVEL_SUPPORT
 unsigned long calibrate_delay_is_known(void)
 {
-	if (time_travel_mode == TT_MODE_INFCPU)
+	if (time_travel_mode == TT_MODE_INFCPU ||
+	    time_travel_mode == TT_MODE_EXTERNAL)
 		return 1;
 	return 0;
 }
@@ -413,6 +697,13 @@ int setup_time_travel(char *str)
 		return 1;
 	}
 
+	if (strncmp(str, "=ext:", 5) == 0) {
+		time_travel_mode = TT_MODE_EXTERNAL;
+		timer_clockevent.name = "time-travel-timer-external";
+		timer_clocksource.name = "time-travel-clock-external";
+		return time_travel_connect_external(str + 5);
+	}
+
 	if (!*str) {
 		time_travel_mode = TT_MODE_BASIC;
 		timer_clockevent.name = "time-travel-timer";
@@ -437,7 +728,15 @@ __uml_help(setup_time_travel,
 "are no wall clock timers, and any CPU processing happens - as seen from the\n"
 "guest - instantly. This can be useful for accurate simulation regardless of\n"
 "debug overhead, physical CPU speed, etc. but is somewhat dangerous as it can\n"
-"easily lead to getting stuck (e.g. if anything in the system busy loops).\n");
+"easily lead to getting stuck (e.g. if anything in the system busy loops).\n"
+"\n"
+"time-travel=ext:[ID:]/path/to/socket\n"
+"This enables time travel mode similar to =inf-cpu, except the system will\n"
+"use the given socket to coordinate with a central scheduler, in order to\n"
+"have more than one system simultaneously be on simulated time. The virtio\n"
+"driver code in UML knows about this so you can also simulate networks and\n"
+"devices using it, assuming the device has the right capabilities.\n"
+"The optional ID is a 64-bit integer that's sent to the central scheduler.\n");
 
 int setup_time_travel_start(char *str)
 {
diff --git a/arch/um/os-Linux/file.c b/arch/um/os-Linux/file.c
index 5133e3afb96f..408db12ea4ed 100644
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
@@ -664,3 +666,31 @@ int os_sendmsg_fds(int fd, const void *buf, unsigned int len, const int *fds,
 		return -errno;
 	return err;
 }
+
+int os_poll(unsigned int n, const int *fds)
+{
+	/* currently need 2 FDs at most so avoid dynamic allocation */
+	struct pollfd pollfds[2] = {};
+	unsigned int i;
+	int ret;
+
+	if (n > ARRAY_SIZE(pollfds))
+		return -EINVAL;
+
+	for (i = 0; i < n; i++) {
+		pollfds[i].fd = fds[i];
+		pollfds[i].events = POLLIN;
+	}
+
+	ret = poll(pollfds, n, -1);
+	if (ret < 0)
+		return -errno;
+
+	/* Return the index of the available FD */
+	for (i = 0; i < n; i++) {
+		if (pollfds[i].revents)
+			return i;
+	}
+
+	return -EIO;
+}
diff --git a/include/uapi/linux/um_timetravel.h b/include/uapi/linux/um_timetravel.h
new file mode 100644
index 000000000000..ca3238222b6d
--- /dev/null
+++ b/include/uapi/linux/um_timetravel.h
@@ -0,0 +1,128 @@
+/*
+ * Permission to use, copy, modify, and/or distribute this software for any
+ * purpose with or without fee is hereby granted, provided that the above
+ * copyright notice and this permission notice appear in all copies.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
+ * WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
+ * MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
+ * ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
+ * WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
+ * ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
+ * OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
+ *
+ * Copyright (C) 2019 Intel Corporation
+ */
+#ifndef _UAPI_LINUX_UM_TIMETRAVEL_H
+#define _UAPI_LINUX_UM_TIMETRAVEL_H
+#include <linux/types.h>
+
+/**
+ * struct um_timetravel_msg - UM time travel message
+ *
+ * This is the basic message type, going in both directions.
+ *
+ * This is the message passed between the host (user-mode Linux instance)
+ * and the calendar (the application on the other side of the socket) in
+ * order to implement common scheduling.
+ *
+ * Whenever UML has an event it will request runtime for it from the
+ * calendar, and then wait for its turn until it can run, etc. Note
+ * that it will only ever request the single next runtime, i.e. multiple
+ * REQUEST messages override each other.
+ */
+struct um_timetravel_msg {
+	/**
+	 * @op: operation value from &enum um_timetravel_ops
+	 */
+	__u32 op;
+
+	/**
+	 * @seq: sequence number for the message - shall be reflected in
+	 *	the ACK response, and should be checked while processing
+	 *	the response to see if it matches
+	 */
+	__u32 seq;
+
+	/**
+	 * @time: time in nanoseconds
+	 */
+	__u64 time;
+};
+
+/**
+ * enum um_timetravel_ops - Operation codes
+ */
+enum um_timetravel_ops {
+	/**
+	 * @UM_TIMETRAVEL_ACK: response (ACK) to any previous message,
+	 *	this usually doesn't carry any data in the 'time' field
+	 *	unless otherwise specified below
+	 */
+	UM_TIMETRAVEL_ACK		= 0,
+
+	/**
+	 * @UM_TIMETRAVEL_START: initialize the connection, the time
+	 *	field contains an (arbitrary) ID to possibly be able
+	 *	to distinguish the connections.
+	 */
+	UM_TIMETRAVEL_START		= 1,
+
+	/**
+	 * @UM_TIMETRAVEL_REQUEST: request to run at the given time
+	 *	(host -> calendar)
+	 */
+	UM_TIMETRAVEL_REQUEST		= 2,
+
+	/**
+	 * @UM_TIMETRAVEL_WAIT: Indicate waiting for the previously requested
+	 *	runtime, new requests may be made while waiting (e.g. due to
+	 *	interrupts); the time field is ignored. The calendar must process
+	 *	this message and later	send a %UM_TIMETRAVEL_RUN message when
+	 *	the host can run again.
+	 *	(host -> calendar)
+	 */
+	UM_TIMETRAVEL_WAIT		= 3,
+
+	/**
+	 * @UM_TIMETRAVEL_GET: return the current time from the calendar in the
+	 *	ACK message, the time in the request message is ignored
+	 *	(host -> calendar)
+	 */
+	UM_TIMETRAVEL_GET		= 4,
+
+	/**
+	 * @UM_TIMETRAVEL_UPDATE: time update to the calendar, must be sent e.g.
+	 *	before kicking an interrupt to another calendar
+	 *	(host -> calendar)
+	 */
+	UM_TIMETRAVEL_UPDATE		= 5,
+
+	/**
+	 * @UM_TIMETRAVEL_RUN: run time request granted, current time is in
+	 *	the time field
+	 *	(calendar -> host)
+	 */
+	UM_TIMETRAVEL_RUN		= 6,
+
+	/**
+	 * @UM_TIMETRAVEL_FREE_UNTIL: Enable free-running until the given time,
+	 *	this is a message from the calendar telling the host that it can
+	 *	freely do its own scheduling for anything before the indicated
+	 *	time.
+	 *	Note that if a calendar sends this message once, the host may
+	 *	assume that it will also do so in the future, if it implements
+	 *	wraparound semantics for the time field.
+	 *	(calendar -> host)
+	 */
+	UM_TIMETRAVEL_FREE_UNTIL	= 7,
+
+	/**
+	 * @UM_TIMETRAVEL_GET_TOD: Return time of day, typically used once at
+	 *	boot by the virtual machines to get a synchronized time from
+	 *	the simulation.
+	 */
+	UM_TIMETRAVEL_GET_TOD		= 8,
+};
+
+#endif /* _UAPI_LINUX_UM_TIMETRAVEL_H */
-- 
2.24.1


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

