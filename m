Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by bombadil.infradead.org with esmtps (Exim 4.92.2 #3 (Red Hat Linux))
 id 1iADYv-0003CU-3r
 for linux-um@lists.infradead.org; Tue, 17 Sep 2019 13:30:38 +0000
From: Johannes Berg <johannes@sipsolutions.net>
Subject: [RFC v3 2/2] um: implement time-travel=ext
Date: Tue, 17 Sep 2019 15:29:44 +0200
Message-Id: <1568726354-I0c06fae89d77d5b272dfb4c7ea64641b597b5c7b@changeid>
In-Reply-To: <20190917132943.20102-1-johannes@sipsolutions.net>
References: <20190917132943.20102-1-johannes@sipsolutions.net>
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

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 arch/um/drivers/virtio_uml.c          |  59 +++++-
 arch/um/include/linux/time-internal.h |  28 +++
 arch/um/include/shared/os.h           |   1 +
 arch/um/kernel/skas/syscall.c         |   3 +-
 arch/um/kernel/time.c                 | 256 +++++++++++++++++++++++++-
 arch/um/os-Linux/file.c               |  30 +++
 include/uapi/linux/um_timetravel.h    | 107 +++++++++++
 7 files changed, 472 insertions(+), 12 deletions(-)
 create mode 100644 include/uapi/linux/um_timetravel.h

diff --git a/arch/um/drivers/virtio_uml.c b/arch/um/drivers/virtio_uml.c
index 23ed359618a7..6996ec682856 100644
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
@@ -67,6 +68,11 @@ struct virtio_uml_device {
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
@@ -124,7 +130,23 @@ static int vhost_user_recv(struct virtio_uml_device *vu_dev,
 			   size_t max_payload_size)
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
+	time_travel_wait_readable(fd);
+
+	rc = vhost_user_recv_header(fd, msg);
 
 	if (rc == -ECONNRESET) {
 		struct virtio_uml_platform_data *pdata;
@@ -708,6 +730,8 @@ static bool vu_notify(struct virtqueue *vq)
 	const uint64_t n = 1;
 	int rc;
 
+	time_travel_propagate_time();
+
 	if (info->kick_fd < 0) {
 		struct virtio_uml_device *vu_dev;
 
@@ -855,6 +879,23 @@ static int vu_setup_vq_call_fd(struct virtio_uml_device *vu_dev,
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
@@ -874,6 +915,19 @@ static struct virtqueue *vu_setup_vq(struct virtio_device *vdev,
 	snprintf(info->name, sizeof(info->name), "%s.%d-%s", pdev->name,
 		 pdev->id, name);
 
+#ifdef CONFIG_UML_TIME_TRAVEL_SUPPORT
+	/*
+	 * When we get an interrupt, we must bounce it through the simulation
+	 * calendar (the simtime device), except for the simtime device itself
+	 * since that's part of the simulation control.
+	 */
+	if (time_travel_mode == TT_MODE_EXTERNAL) {
+		info->callback = callback;
+		callback = vu_defer_irq_callback;
+		time_travel_set_event_fn(&info->defer, vu_defer_irq_handle);
+	}
+#endif
+
 	vq = vring_create_virtqueue(index, num, PAGE_SIZE, vdev, true, true,
 				    ctx, vu_notify, callback, info->name);
 	if (!vq) {
@@ -882,6 +936,9 @@ static struct virtqueue *vu_setup_vq(struct virtio_device *vdev,
 	}
 	vq->priv = info;
 	num = virtqueue_get_vring_size(vq);
+#ifdef CONFIG_UML_TIME_TRAVEL_SUPPORT
+	info->vq = vq;
+#endif
 
 	if (vu_dev->protocol_features &
 			BIT_ULL(VHOST_USER_PROTOCOL_F_INBAND_NOTIFICATIONS)) {
diff --git a/arch/um/include/linux/time-internal.h b/arch/um/include/linux/time-internal.h
index eb1f84616edb..c207f180111e 100644
--- a/arch/um/include/linux/time-internal.h
+++ b/arch/um/include/linux/time-internal.h
@@ -7,6 +7,7 @@
 #ifndef __TIMER_INTERNAL_H__
 #define __TIMER_INTERNAL_H__
 #include <linux/list.h>
+#include <linux/interrupt.h>
 
 #define TIMER_MULTIPLIER 256
 #define TIMER_MIN_DELTA  500
@@ -15,6 +16,7 @@ enum time_travel_mode {
 	TT_MODE_OFF,
 	TT_MODE_BASIC,
 	TT_MODE_INFCPU,
+	TT_MODE_EXTERNAL,
 };
 
 #ifdef CONFIG_UML_TIME_TRAVEL_SUPPORT
@@ -35,6 +37,24 @@ time_travel_set_event_fn(struct time_travel_event *e,
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
@@ -47,5 +67,13 @@ static inline void time_travel_sleep(unsigned long long duration)
 
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
index 58d40fe4f1aa..bc550bc1e497 100644
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
index cdebe96308d7..8a5ecf9b2f0e 100644
--- a/arch/um/kernel/time.c
+++ b/arch/um/kernel/time.c
@@ -15,11 +15,13 @@
 #include <linux/sched.h>
 #include <linux/spinlock.h>
 #include <linux/threads.h>
+#include <linux/module.h>
 #include <asm/irq.h>
 #include <asm/param.h>
 #include <kern_util.h>
 #include <os.h>
 #include <linux/time-internal.h>
+#include <linux/um_timetravel.h>
 #include <shared/init.h>
 
 #ifdef CONFIG_UML_TIME_TRAVEL_SUPPORT
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
@@ -41,6 +49,170 @@ static void time_travel_set_time(unsigned long long ns)
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
+static void time_travel_ext_req(u64 op, u64 time)
+{
+	struct um_timetravel_msg msg = {
+		.op = op,
+		.time = time,
+	};
+
+	os_write_file(time_travel_ext_fd, &msg, sizeof(msg));
+
+	while (msg.op != UM_TIMETRAVEL_ACK)
+		time_travel_handle_message(&msg, TTMH_POLL);
+
+	if (op == UM_TIMETRAVEL_GET)
+		time_travel_set_time(msg.time);
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
@@ -85,6 +257,7 @@ static void __time_travel_add_event(struct time_travel_event *e,
 		list_add_tail(&e->list, &time_travel_events);
 
 	tmp = time_travel_first_event();
+	time_travel_ext_update_request(tmp->time);
 	time_travel_next_event = tmp->time;
 }
 
@@ -106,8 +279,21 @@ void time_travel_periodic_timer(struct time_travel_event *e)
 
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
@@ -119,13 +305,13 @@ static bool time_travel_del_event(struct time_travel_event *e)
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
@@ -134,7 +320,7 @@ static void time_travel_update_time(unsigned long long next, bool retearly)
 		e = time_travel_first_event();
 
 		BUG_ON(!e);
-		time_travel_set_time(e->time);
+		__time_travel_update_time(e->time, idle);
 
 		/* new events may have been inserted while we were waiting */
 		if (e == time_travel_first_event()) {
@@ -150,11 +336,28 @@ static void time_travel_update_time(unsigned long long next, bool retearly)
 				time_travel_deliver_event(e);
 			}
 		}
+
+		e = time_travel_first_event();
+		if (e)
+			time_travel_ext_update_request(e->time);
 	} while (!finished);
 
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
+
 static void time_travel_oneshot_timer(struct time_travel_event *e)
 {
 	deliver_alarm();
@@ -199,6 +402,21 @@ static void time_travel_set_interval(unsigned long long interval)
 {
 	time_travel_timer_interval = interval;
 }
+
+static int time_travel_connect_external(const char *socket)
+{
+	int rc;
+
+	rc = os_connect_socket(socket);
+	if (rc < 0) {
+		panic("time-travel: failed to connect to external socket %s\n",
+		      socket);
+		return rc;
+	}
+
+	time_travel_ext_fd = rc;
+	return 1;
+}
 #else /* CONFIG_UML_TIME_TRAVEL_SUPPORT */
 #define time_travel_start_set 0
 #define time_travel_start 0
@@ -246,7 +464,8 @@ static int itimer_shutdown(struct clock_event_device *evt)
 	if (time_travel_mode != TT_MODE_OFF)
 		time_travel_del_event(&time_travel_timer_event);
 
-	if (time_travel_mode != TT_MODE_INFCPU)
+	if (time_travel_mode != TT_MODE_INFCPU &&
+	    time_travel_mode != TT_MODE_EXTERNAL)
 		os_timer_disable();
 
 	return 0;
@@ -265,7 +484,8 @@ static int itimer_set_periodic(struct clock_event_device *evt)
 				      time_travel_time + interval);
 	}
 
-	if (time_travel_mode != TT_MODE_INFCPU)
+	if (time_travel_mode != TT_MODE_INFCPU &&
+	    time_travel_mode != TT_MODE_EXTERNAL)
 		os_timer_set_interval(interval);
 
 	return 0;
@@ -284,7 +504,8 @@ static int itimer_next_event(unsigned long delta,
 				      time_travel_time + delta);
 	}
 
-	if (time_travel_mode != TT_MODE_INFCPU)
+	if (time_travel_mode != TT_MODE_INFCPU &&
+	    time_travel_mode != TT_MODE_EXTERNAL)
 		return os_timer_one_shot(delta);
 
 	return 0;
@@ -399,7 +620,8 @@ void __init time_init(void)
 #ifdef CONFIG_UML_TIME_TRAVEL_SUPPORT
 unsigned long calibrate_delay_is_known(void)
 {
-	if (time_travel_mode == TT_MODE_INFCPU)
+	if (time_travel_mode == TT_MODE_INFCPU ||
+	    time_travel_mode == TT_MODE_EXTERNAL)
 		return 1;
 	return 0;
 }
@@ -413,6 +635,13 @@ int setup_time_travel(char *str)
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
@@ -437,7 +666,14 @@ __uml_help(setup_time_travel,
 "are no wall clock timers, and any CPU processing happens - as seen from the\n"
 "guest - instantly. This can be useful for accurate simulation regardless of\n"
 "debug overhead, physical CPU speed, etc. but is somewhat dangerous as it can\n"
-"easily lead to getting stuck (e.g. if anything in the system busy loops).\n");
+"easily lead to getting stuck (e.g. if anything in the system busy loops).\n"
+"\n"
+"time-travel=ext:/path/to/socket\n"
+"This enables time travel mode similar to =inf-cpu, except the system will\n"
+"use the given socket to coordinate with a central scheduler, in order to\n"
+"have more than one system simultaneously be on simulated time. The virtio\n"
+"driver code in UML knows about this so you can also simulate networks and\n"
+"devices using it, assuming the device has the right capabilities.\n");
 
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
index 000000000000..3aaced426a92
--- /dev/null
+++ b/include/uapi/linux/um_timetravel.h
@@ -0,0 +1,107 @@
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
+	__u64 op;
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
+	 * @UM_TIMETRAVEL_REQUEST: request to run at the given time
+	 *	(host -> calendar)
+	 */
+	UM_TIMETRAVEL_REQUEST		= 1,
+
+	/**
+	 * @UM_TIMETRAVEL_WAIT: Indicate waiting for the previously requested
+	 *	runtime, new requests may be made while waiting (e.g. due to
+	 *	interrupts); the time field is ignored. The calendar must process
+	 *	this message and later	send a %UM_TIMETRAVEL_RUN message when
+	 *	the host can run again.
+	 *	(host -> calendar)
+	 */
+	UM_TIMETRAVEL_WAIT		= 2,
+
+	/**
+	 * @UM_TIMETRAVEL_GET: return the current time from the calendar in the
+	 *	ACK message, the time in the request message is ignored
+	 *	(host -> calendar)
+	 */
+	UM_TIMETRAVEL_GET		= 3,
+
+	/**
+	 * @UM_TIMETRAVEL_UPDATE: time update to the calendar, must be sent e.g.
+	 *	before kicking an interrupt to another calendar
+	 *	(host -> calendar)
+	 */
+	UM_TIMETRAVEL_UPDATE		= 4,
+
+	/**
+	 * @UM_TIMETRAVEL_RUN: run time request granted, current time is in
+	 *	the time field
+	 *	(calendar -> host)
+	 */
+	UM_TIMETRAVEL_RUN		= 5,
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
+	UM_TIMETRAVEL_FREE_UNTIL	= 6,
+};
+
+#endif /* _UAPI_LINUX_UM_TIMETRAVEL_H */
-- 
2.20.1


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

