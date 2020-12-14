Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1komed-0005J2-3M
 for linux-um@lists.infradead.org; Mon, 14 Dec 2020 12:08:41 +0000
From: Johannes Berg <johannes@sipsolutions.net>
Subject: [PATCH 3/4] um: time-travel: rework interrupt handling in ext mode
Date: Mon, 14 Dec 2020 13:08:25 +0100
Message-Id: <20201214130826.256439c864b0.I1a38036a693dccc9da905e47f1b4dc933ac305cf@changeid>
In-Reply-To: <20201214130826.5c1b7720a11b.Ibacb1cbbdd1fa7ae866f0c3c94488dcbae01b39b@changeid>
References: <20201214130826.5c1b7720a11b.Ibacb1cbbdd1fa7ae866f0c3c94488dcbae01b39b@changeid>
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

In external time-travel mode, where time is controlled via the
controller application socket, interrupt handling is a little
tricky. For example on virtio, the following happens:
 * we receive a message (that requires an ACK) on the vhost-user socket
 * we add a time-travel event to handle the interrupt
   (this causes communication on the time socket)
 * we ACK the original vhost-user message
 * we then handle the interrupt once the event is triggered

This protocol ensures that the sender of the interrupt only continues
to run in the simulation when the time-travel event has been added.

So far, this was only done in the virtio driver, but it was actually
wrong, because only virtqueue interrupts were handled this way, and
config change interrupts were handled immediately. Additionally, the
messages were actually handled in the real Linux interrupt handler,
but Linux interrupt handlers are part of the simulation and shouldn't
run while there's no time event.

To really do this properly and only handle all kinds of interrupts in
the time-travel event when we are scheduled to run in the simulation,
rework this to plug in to the lower interrupt layers in UML directly:

Add a um_request_irq_tt() function that let's a time-travel aware
driver request an interrupt with an additional timetravel_handler()
that is called outside of the context of the simulation, to handle
the message only. It then adds an event to the time-travel calendar
if necessary, and no "real" Linux code runs outside of the time
simulation.

This also hooks in with suspend/resume properly now, since this new
timetravel_handler() can run while Linux is suspended and interrupts
are disabled, and decide to wake up (or not) the system based on the
message it received. Importantly in this case, it ACKs the message
before the system even resumes and interrupts are re-enabled, thus
allowing the simulation to progress properly.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 arch/um/drivers/virtio_uml.c          |  92 +++++++-------
 arch/um/include/linux/time-internal.h |   6 +
 arch/um/include/shared/irq_kern.h     |  60 +++++++++
 arch/um/kernel/irq.c                  | 171 ++++++++++++++++++++++----
 arch/um/kernel/time.c                 |   7 ++
 5 files changed, 267 insertions(+), 69 deletions(-)

diff --git a/arch/um/drivers/virtio_uml.c b/arch/um/drivers/virtio_uml.c
index c400a8e64f7c..781c3943a5bd 100644
--- a/arch/um/drivers/virtio_uml.c
+++ b/arch/um/drivers/virtio_uml.c
@@ -55,16 +55,14 @@ struct virtio_uml_device {
 	u64 protocol_features;
 	u8 status;
 	u8 registered:1;
+
+	u8 config_changed_irq:1;
+	uint64_t vq_irq_vq_map;
 };
 
 struct virtio_uml_vq_info {
 	int kick_fd, call_fd;
 	char name[32];
-#ifdef CONFIG_UML_TIME_TRAVEL_SUPPORT
-	struct virtqueue *vq;
-	vq_callback_t *callback;
-	struct time_travel_event defer;
-#endif
 	bool suspended;
 };
 
@@ -348,9 +346,9 @@ static void vhost_user_reply(struct virtio_uml_device *vu_dev,
 		       rc, size);
 }
 
-static irqreturn_t vu_req_interrupt(int irq, void *data)
+static irqreturn_t vu_req_read_message(struct virtio_uml_device *vu_dev,
+				       struct time_travel_event *ev)
 {
-	struct virtio_uml_device *vu_dev = data;
 	struct virtqueue *vq;
 	int response = 1;
 	struct {
@@ -368,14 +366,14 @@ static irqreturn_t vu_req_interrupt(int irq, void *data)
 
 	switch (msg.msg.header.request) {
 	case VHOST_USER_SLAVE_CONFIG_CHANGE_MSG:
-		virtio_config_changed(&vu_dev->vdev);
+		vu_dev->config_changed_irq = true;
 		response = 0;
 		break;
 	case VHOST_USER_SLAVE_VRING_CALL:
 		virtio_device_for_each_vq((&vu_dev->vdev), vq) {
 			if (vq->index == msg.msg.payload.vring_state.index) {
 				response = 0;
-				vring_interrupt(0 /* ignored */, vq);
+				vu_dev->vq_irq_vq_map |= BIT_ULL(vq->index);
 				break;
 			}
 		}
@@ -389,12 +387,45 @@ static irqreturn_t vu_req_interrupt(int irq, void *data)
 		       msg.msg.header.request);
 	}
 
+	if (ev)
+		time_travel_add_irq_event(ev);
+
 	if (msg.msg.header.flags & VHOST_USER_FLAG_NEED_REPLY)
 		vhost_user_reply(vu_dev, &msg.msg, response);
 
 	return IRQ_HANDLED;
 }
 
+static irqreturn_t vu_req_interrupt(int irq, void *data)
+{
+	struct virtio_uml_device *vu_dev = data;
+	irqreturn_t ret = IRQ_HANDLED;
+
+	if (!um_irq_timetravel_handler_used())
+		ret = vu_req_read_message(vu_dev, NULL);
+
+	if (vu_dev->vq_irq_vq_map) {
+		struct virtqueue *vq;
+
+		virtio_device_for_each_vq((&vu_dev->vdev), vq) {
+			if (vu_dev->vq_irq_vq_map & BIT_ULL(vq->index))
+				vring_interrupt(0 /* ignored */, vq);
+		}
+		vu_dev->vq_irq_vq_map = 0;
+	} else if (vu_dev->config_changed_irq) {
+		virtio_config_changed(&vu_dev->vdev);
+		vu_dev->config_changed_irq = false;
+	}
+
+	return ret;
+}
+
+static void vu_req_interrupt_comm_handler(int irq, int fd, void *data,
+					  struct time_travel_event *ev)
+{
+	vu_req_read_message(data, ev);
+}
+
 static int vhost_user_init_slave_req(struct virtio_uml_device *vu_dev)
 {
 	int rc, req_fds[2];
@@ -405,9 +436,10 @@ static int vhost_user_init_slave_req(struct virtio_uml_device *vu_dev)
 		return rc;
 	vu_dev->req_fd = req_fds[0];
 
-	rc = um_request_irq(UM_IRQ_ALLOC, vu_dev->req_fd, IRQ_READ,
-			    vu_req_interrupt, IRQF_SHARED,
-			    vu_dev->pdev->name, vu_dev);
+	rc = um_request_irq_tt(UM_IRQ_ALLOC, vu_dev->req_fd, IRQ_READ,
+			       vu_req_interrupt, IRQF_SHARED,
+			       vu_dev->pdev->name, vu_dev,
+			       vu_req_interrupt_comm_handler);
 	if (rc < 0)
 		goto err_close;
 
@@ -879,23 +911,6 @@ static int vu_setup_vq_call_fd(struct virtio_uml_device *vu_dev,
 	return rc;
 }
 
-#ifdef CONFIG_UML_TIME_TRAVEL_SUPPORT
-static void vu_defer_irq_handle(struct time_travel_event *d)
-{
-	struct virtio_uml_vq_info *info;
-
-	info = container_of(d, struct virtio_uml_vq_info, defer);
-	info->callback(info->vq);
-}
-
-static void vu_defer_irq_callback(struct virtqueue *vq)
-{
-	struct virtio_uml_vq_info *info = vq->priv;
-
-	time_travel_add_irq_event(&info->defer);
-}
-#endif
-
 static struct virtqueue *vu_setup_vq(struct virtio_device *vdev,
 				     unsigned index, vq_callback_t *callback,
 				     const char *name, bool ctx)
@@ -915,18 +930,6 @@ static struct virtqueue *vu_setup_vq(struct virtio_device *vdev,
 	snprintf(info->name, sizeof(info->name), "%s.%d-%s", pdev->name,
 		 pdev->id, name);
 
-#ifdef CONFIG_UML_TIME_TRAVEL_SUPPORT
-	/*
-	 * When we get an interrupt, we must bounce it through the simulation
-	 * calendar (the time-travel=ext:... socket).
-	 */
-	if (time_travel_mode == TT_MODE_EXTERNAL && callback) {
-		info->callback = callback;
-		callback = vu_defer_irq_callback;
-		time_travel_set_event_fn(&info->defer, vu_defer_irq_handle);
-	}
-#endif
-
 	vq = vring_create_virtqueue(index, num, PAGE_SIZE, vdev, true, true,
 				    ctx, vu_notify, callback, info->name);
 	if (!vq) {
@@ -935,9 +938,6 @@ static struct virtqueue *vu_setup_vq(struct virtio_device *vdev,
 	}
 	vq->priv = info;
 	num = virtqueue_get_vring_size(vq);
-#ifdef CONFIG_UML_TIME_TRAVEL_SUPPORT
-	info->vq = vq;
-#endif
 
 	if (vu_dev->protocol_features &
 			BIT_ULL(VHOST_USER_PROTOCOL_F_INBAND_NOTIFICATIONS)) {
@@ -996,6 +996,10 @@ static int vu_find_vqs(struct virtio_device *vdev, unsigned nvqs,
 	int i, queue_idx = 0, rc;
 	struct virtqueue *vq;
 
+	/* not supported for now */
+	if (WARN_ON(nvqs > 64))
+		return -EINVAL;
+
 	rc = vhost_user_set_mem_table(vu_dev);
 	if (rc)
 		return rc;
diff --git a/arch/um/include/linux/time-internal.h b/arch/um/include/linux/time-internal.h
index 088d6a4c0b9d..ee2ecddf6ca9 100644
--- a/arch/um/include/linux/time-internal.h
+++ b/arch/um/include/linux/time-internal.h
@@ -7,6 +7,7 @@
 #ifndef __TIMER_INTERNAL_H__
 #define __TIMER_INTERNAL_H__
 #include <linux/list.h>
+#include <asm/bug.h>
 
 #define TIMER_MULTIPLIER 256
 #define TIMER_MIN_DELTA  500
@@ -85,6 +86,11 @@ static inline void time_travel_wait_readable(int fd)
 extern void time_travel_not_configured(void);
 #define time_travel_add_event_rel(...) time_travel_not_configured()
 #define time_travel_del_event(...) time_travel_not_configured()
+
+static inline void time_travel_add_irq_event(struct time_travel_event *e)
+{
+	WARN_ON(1);
+}
 #endif /* CONFIG_UML_TIME_TRAVEL_SUPPORT */
 
 /*
diff --git a/arch/um/include/shared/irq_kern.h b/arch/um/include/shared/irq_kern.h
index 7807de593bda..f2dc817abb7c 100644
--- a/arch/um/include/shared/irq_kern.h
+++ b/arch/um/include/shared/irq_kern.h
@@ -7,6 +7,7 @@
 #define __IRQ_KERN_H__
 
 #include <linux/interrupt.h>
+#include <linux/time-internal.h>
 #include <asm/ptrace.h>
 #include "irq_user.h"
 
@@ -15,5 +16,64 @@
 int um_request_irq(int irq, int fd, enum um_irq_type type,
 		   irq_handler_t handler, unsigned long irqflags,
 		   const char *devname, void *dev_id);
+
+#ifdef CONFIG_UML_TIME_TRAVEL_SUPPORT
+/**
+ * um_request_irq_tt - request an IRQ with timetravel handler
+ *
+ * @irq: the IRQ number, or %UM_IRQ_ALLOC
+ * @fd: The file descriptor to request an IRQ for
+ * @type: read or write
+ * @handler: the (generic style) IRQ handler
+ * @irqflags: Linux IRQ flags
+ * @devname: name for this to show
+ * @dev_id: data pointer to pass to the IRQ handler
+ * @timetravel_handler: the timetravel interrupt handler, invoked with the IRQ
+ *	number, fd, dev_id and time-travel event pointer.
+ *
+ * Returns: The interrupt number assigned or a negative error.
+ *
+ * Note that the timetravel handler is invoked only if the time_travel_mode is
+ * %TT_MODE_EXTERNAL, and then it is invoked even while the system is suspended!
+ * This function must call time_travel_add_irq_event() for the event passed with
+ * an appropriate delay, before sending an ACK on the socket it was invoked for.
+ *
+ * If this was called while the system is suspended, then adding the event will
+ * cause the system to resume.
+ *
+ * Since this function will almost certainly have to handle the FD's condition,
+ * a read will consume the message, and after that it is up to the code using
+ * it to pass such a message to the @handler in whichever way it can.
+ *
+ * If time_travel_mode is not %TT_MODE_EXTERNAL the @timetravel_handler will
+ * not be invoked at all and the @handler must handle the FD becoming
+ * readable (or writable) instead. Use um_irq_timetravel_handler_used() to
+ * distinguish these cases.
+ *
+ * See virtio_uml.c for an example.
+ */
+int um_request_irq_tt(int irq, int fd, enum um_irq_type type,
+		      irq_handler_t handler, unsigned long irqflags,
+		      const char *devname, void *dev_id,
+		      void (*timetravel_handler)(int, int, void *,
+						 struct time_travel_event *));
+#else
+static inline
+int um_request_irq_tt(int irq, int fd, enum um_irq_type type,
+		      irq_handler_t handler, unsigned long irqflags,
+		      const char *devname, void *dev_id,
+		      void (*timetravel_handler)(int, int, void *,
+						 struct time_travel_event *))
+{
+	return um_request_irq(irq, fd, type, handler, irqflags,
+			      devname, dev_id);
+}
+#endif
+
+static inline bool um_irq_timetravel_handler_used(void)
+{
+	return time_travel_mode == TT_MODE_EXTERNAL;
+}
+
 void um_free_irq(int irq, void *dev_id);
 #endif
diff --git a/arch/um/kernel/irq.c b/arch/um/kernel/irq.c
index 3741d2380060..82af5191e73d 100644
--- a/arch/um/kernel/irq.c
+++ b/arch/um/kernel/irq.c
@@ -20,7 +20,7 @@
 #include <os.h>
 #include <irq_user.h>
 #include <irq_kern.h>
-#include <as-layout.h>
+#include <linux/time-internal.h>
 
 
 extern void free_irqs(void);
@@ -38,6 +38,12 @@ struct irq_reg {
 	bool active;
 	bool pending;
 	bool wakeup;
+#ifdef CONFIG_UML_TIME_TRAVEL_SUPPORT
+	bool pending_on_resume;
+	void (*timetravel_handler)(int, int, void *,
+				   struct time_travel_event *);
+	struct time_travel_event event;
+#endif
 };
 
 struct irq_entry {
@@ -51,6 +57,7 @@ struct irq_entry {
 static DEFINE_SPINLOCK(irq_lock);
 static LIST_HEAD(active_fds);
 static DECLARE_BITMAP(irqs_allocated, NR_IRQS);
+static bool irqs_suspended;
 
 static void irq_io_loop(struct irq_reg *irq, struct uml_pt_regs *regs)
 {
@@ -74,9 +81,65 @@ static void irq_io_loop(struct irq_reg *irq, struct uml_pt_regs *regs)
 	}
 }
 
-void sigio_handler_suspend(int sig, struct siginfo *unused_si, struct uml_pt_regs *regs)
+#ifdef CONFIG_UML_TIME_TRAVEL_SUPPORT
+static void irq_event_handler(struct time_travel_event *ev)
 {
-	/* nothing */
+	struct irq_reg *reg = container_of(ev, struct irq_reg, event);
+
+	/* do nothing if suspended - just to cause a wakeup */
+	if (irqs_suspended)
+		return;
+
+	generic_handle_irq(reg->irq);
+}
+
+static bool irq_do_timetravel_handler(struct irq_entry *entry,
+				      enum um_irq_type t)
+{
+	struct irq_reg *reg = &entry->reg[t];
+
+	if (!reg->timetravel_handler)
+		return false;
+
+	/* prevent nesting - we'll get it again later when we SIGIO ourselves */
+	if (reg->pending_on_resume)
+		return true;
+
+	reg->timetravel_handler(reg->irq, entry->fd, reg->id, &reg->event);
+
+	if (!reg->event.pending)
+		return false;
+
+	if (irqs_suspended)
+		reg->pending_on_resume = true;
+	return true;
+}
+#else
+static bool irq_do_timetravel_handler(struct irq_entry *entry,
+				      enum um_irq_type t)
+{
+	return false;
+}
+#endif
+
+static void sigio_reg_handler(int idx, struct irq_entry *entry, enum um_irq_type t,
+			      struct uml_pt_regs *regs)
+{
+	struct irq_reg *reg = &entry->reg[t];
+
+	if (!reg->events)
+		return;
+
+	if (os_epoll_triggered(idx, reg->events) <= 0)
+		return;
+
+	if (irq_do_timetravel_handler(entry, t))
+		return;
+
+	if (irqs_suspended)
+		return;
+
+	irq_io_loop(reg, regs);
 }
 
 void sigio_handler(int sig, struct siginfo *unused_si, struct uml_pt_regs *regs)
@@ -84,6 +147,9 @@ void sigio_handler(int sig, struct siginfo *unused_si, struct uml_pt_regs *regs)
 	struct irq_entry *irq_entry;
 	int n, i;
 
+	if (irqs_suspended && !um_irq_timetravel_handler_used())
+		return;
+
 	while (1) {
 		/* This is now lockless - epoll keeps back-referencesto the irqs
 		 * which have trigger it so there is no need to walk the irq
@@ -105,19 +171,13 @@ void sigio_handler(int sig, struct siginfo *unused_si, struct uml_pt_regs *regs)
 
 			irq_entry = os_epoll_get_data_pointer(i);
 
-			for (t = 0; t < NUM_IRQ_TYPES; t++) {
-				int events = irq_entry->reg[t].events;
-
-				if (!events)
-					continue;
-
-				if (os_epoll_triggered(i, events) > 0)
-					irq_io_loop(&irq_entry->reg[t], regs);
-			}
+			for (t = 0; t < NUM_IRQ_TYPES; t++)
+				sigio_reg_handler(i, irq_entry, t, regs);
 		}
 	}
 
-	free_irqs();
+	if (!irqs_suspended)
+		free_irqs();
 }
 
 static struct irq_entry *get_irq_entry_by_fd(int fd)
@@ -169,7 +229,9 @@ static void update_or_free_irq_entry(struct irq_entry *entry)
 		free_irq_entry(entry, false);
 }
 
-static int activate_fd(int irq, int fd, enum um_irq_type type, void *dev_id)
+static int activate_fd(int irq, int fd, enum um_irq_type type, void *dev_id,
+		       void (*timetravel_handler)(int, int, void *,
+						  struct time_travel_event *))
 {
 	struct irq_entry *irq_entry;
 	int err, events = os_event_mask(type);
@@ -206,6 +268,13 @@ static int activate_fd(int irq, int fd, enum um_irq_type type, void *dev_id)
 	irq_entry->reg[type].active = true;
 	irq_entry->reg[type].events = events;
 
+#ifdef CONFIG_UML_TIME_TRAVEL_SUPPORT
+	if (um_irq_timetravel_handler_used()) {
+		irq_entry->reg[type].timetravel_handler = timetravel_handler;
+		irq_entry->reg[type].event.fn = irq_event_handler;
+	}
+#endif
+
 	WARN_ON(!update_irq_entry(irq_entry));
 	spin_unlock_irqrestore(&irq_lock, flags);
 
@@ -339,9 +408,12 @@ void um_free_irq(int irq, void *dev)
 }
 EXPORT_SYMBOL(um_free_irq);
 
-int um_request_irq(int irq, int fd, enum um_irq_type type,
-		   irq_handler_t handler, unsigned long irqflags,
-		   const char *devname, void *dev_id)
+static int
+_um_request_irq(int irq, int fd, enum um_irq_type type,
+		irq_handler_t handler, unsigned long irqflags,
+		const char *devname, void *dev_id,
+		void (*timetravel_handler)(int, int, void *,
+					   struct time_travel_event *))
 {
 	int err;
 
@@ -360,7 +432,7 @@ int um_request_irq(int irq, int fd, enum um_irq_type type,
 		return -ENOSPC;
 
 	if (fd != -1) {
-		err = activate_fd(irq, fd, type, dev_id);
+		err = activate_fd(irq, fd, type, dev_id, timetravel_handler);
 		if (err)
 			goto error;
 	}
@@ -374,20 +446,41 @@ int um_request_irq(int irq, int fd, enum um_irq_type type,
 	clear_bit(irq, irqs_allocated);
 	return err;
 }
+
+int um_request_irq(int irq, int fd, enum um_irq_type type,
+		   irq_handler_t handler, unsigned long irqflags,
+		   const char *devname, void *dev_id)
+{
+	return _um_request_irq(irq, fd, type, handler, irqflags,
+			       devname, dev_id, NULL);
+}
 EXPORT_SYMBOL(um_request_irq);
 
+#ifdef CONFIG_UML_TIME_TRAVEL_SUPPORT
+int um_request_irq_tt(int irq, int fd, enum um_irq_type type,
+		      irq_handler_t handler, unsigned long irqflags,
+		      const char *devname, void *dev_id,
+		      void (*timetravel_handler)(int, int, void *,
+						 struct time_travel_event *))
+{
+	return _um_request_irq(irq, fd, type, handler, irqflags,
+			       devname, dev_id, timetravel_handler);
+}
+EXPORT_SYMBOL(um_request_irq_tt);
+#endif
+
 #ifdef CONFIG_PM_SLEEP
 void um_irqs_suspend(void)
 {
 	struct irq_entry *entry;
 	unsigned long flags;
 
-	sig_info[SIGIO] = sigio_handler_suspend;
+	irqs_suspended = true;
 
 	spin_lock_irqsave(&irq_lock, flags);
 	list_for_each_entry(entry, &active_fds, list) {
 		enum um_irq_type t;
-		bool wake = false;
+		bool clear = true;
 
 		for (t = 0; t < NUM_IRQ_TYPES; t++) {
 			if (!entry->reg[t].events)
@@ -400,13 +493,17 @@ void um_irqs_suspend(void)
 			 * any FDs that should be suspended.
 			 */
 			if (entry->reg[t].wakeup ||
-			    entry->reg[t].irq == SIGIO_WRITE_IRQ) {
-				wake = true;
+			    entry->reg[t].irq == SIGIO_WRITE_IRQ
+#ifdef CONFIG_UML_TIME_TRAVEL_SUPPORT
+			    || entry->reg[t].timetravel_handler
+#endif
+			    ) {
+				clear = false;
 				break;
 			}
 		}
 
-		if (!wake) {
+		if (clear) {
 			entry->suspended = true;
 			os_clear_fd_async(entry->fd);
 			entry->sigio_workaround =
@@ -421,7 +518,31 @@ void um_irqs_resume(void)
 	struct irq_entry *entry;
 	unsigned long flags;
 
-	spin_lock_irqsave(&irq_lock, flags);
+
+	local_irq_save(flags);
+#ifdef CONFIG_UML_TIME_TRAVEL_SUPPORT
+	/*
+	 * We don't need to lock anything here since we're in resume
+	 * and nothing else is running, but have disabled IRQs so we
+	 * don't try anything else with the interrupt list from there.
+	 */
+	list_for_each_entry(entry, &active_fds, list) {
+		enum um_irq_type t;
+
+		for (t = 0; t < NUM_IRQ_TYPES; t++) {
+			struct irq_reg *reg = &entry->reg[t];
+
+			if (reg->pending_on_resume) {
+				irq_enter();
+				generic_handle_irq(reg->irq);
+				irq_exit();
+				reg->pending_on_resume = false;
+			}
+		}
+	}
+#endif
+
+	spin_lock(&irq_lock);
 	list_for_each_entry(entry, &active_fds, list) {
 		if (entry->suspended) {
 			int err = os_set_fd_async(entry->fd);
@@ -437,7 +558,7 @@ void um_irqs_resume(void)
 	}
 	spin_unlock_irqrestore(&irq_lock, flags);
 
-	sig_info[SIGIO] = sigio_handler;
+	irqs_suspended = false;
 	send_sigio_to_self();
 }
 
diff --git a/arch/um/kernel/time.c b/arch/um/kernel/time.c
index 7de625be2a73..cad8d6d898b2 100644
--- a/arch/um/kernel/time.c
+++ b/arch/um/kernel/time.c
@@ -269,6 +269,7 @@ static void __time_travel_add_event(struct time_travel_event *e,
 {
 	struct time_travel_event *tmp;
 	bool inserted = false;
+	unsigned long flags;
 
 	if (e->pending)
 		return;
@@ -276,6 +277,7 @@ static void __time_travel_add_event(struct time_travel_event *e,
 	e->pending = true;
 	e->time = time;
 
+	local_irq_save(flags);
 	list_for_each_entry(tmp, &time_travel_events, list) {
 		/*
 		 * Add the new entry before one with higher time,
@@ -298,6 +300,7 @@ static void __time_travel_add_event(struct time_travel_event *e,
 	tmp = time_travel_first_event();
 	time_travel_ext_update_request(tmp->time);
 	time_travel_next_event = tmp->time;
+	local_irq_restore(flags);
 }
 
 static void time_travel_add_event(struct time_travel_event *e,
@@ -380,10 +383,14 @@ static void time_travel_deliver_event(struct time_travel_event *e)
 
 bool time_travel_del_event(struct time_travel_event *e)
 {
+	unsigned long flags;
+
 	if (!e->pending)
 		return false;
+	local_irq_save(flags);
 	list_del(&e->list);
 	e->pending = false;
+	local_irq_restore(flags);
 	return true;
 }
 
-- 
2.26.2


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

