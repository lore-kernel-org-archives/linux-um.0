Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lI9RW-00Ewnb-3v
 for linux-um@lists.infradead.org; Fri, 05 Mar 2021 12:20:32 +0000
From: Johannes Berg <johannes@sipsolutions.net>
Subject: [PATCH v4 6/9] um: time-travel/signals: fix ndelay() in interrupt
Date: Fri,  5 Mar 2021 13:19:56 +0100
Message-Id: <20210305131934.863e58ef45ea.I3507b456d425cb95a092eb50b6cb491fe8575c50@changeid>
In-Reply-To: <20210305122010.442577-1-johannes@sipsolutions.net>
References: <20210305122010.442577-1-johannes@sipsolutions.net>
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

We should be able to ndelay() from any context, even from an
interrupt context! However, this is broken (not functionally,
but locking-wise) in time-travel because we'll get into the
time-travel code and enable interrupts to handle messages on
other time-travel aware subsystems (only virtio for now).

Luckily, I've already reworked the time-travel aware signal
(interrupt) delivery for suspend/resume to have a time travel
handler, which runs directly in the context of the signal and
not from the Linux interrupt.

In order to fix this time-travel issue then, we need to do a
few things:

 1) rework the signal handling code to call time-travel handlers
    (only) if interrupts are disabled but signals aren't blocked,
    instead of marking it only pending there. This is needed to
    not deadlock other communication.
 2) rework time-travel to not enable interrupts while it's
    waiting for a message;
 3) rework time-travel to not (just) disable interrupts but
    rather block signals at a lower level while it needs them
    disabled for communicating with the controller.

Finally, since now we can actually spend even virtual time
in interrupts-disabled sections, the delay warning when we
deliver a time-travel delayed interrupt is no longer valid,
things can (and should) now get delayed.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
v2:
 - check for signals_enabled as well as irqs_suspended
   to see if only time-travel handlers should be called
v3:
 - rework the delivery-while-irqs-disabled completely to
   fix time-travel!=ext modes and to simplify the code
---
 arch/um/include/shared/irq_user.h |  1 +
 arch/um/include/shared/os.h       |  3 ++
 arch/um/kernel/irq.c              | 35 ++++++++++++++++----
 arch/um/kernel/time.c             | 35 +++++++-------------
 arch/um/os-Linux/signal.c         | 55 ++++++++++++++++++++++++++++---
 5 files changed, 96 insertions(+), 33 deletions(-)

diff --git a/arch/um/include/shared/irq_user.h b/arch/um/include/shared/irq_user.h
index 07239e801a5b..065829f443ae 100644
--- a/arch/um/include/shared/irq_user.h
+++ b/arch/um/include/shared/irq_user.h
@@ -17,6 +17,7 @@ enum um_irq_type {
 
 struct siginfo;
 extern void sigio_handler(int sig, struct siginfo *unused_si, struct uml_pt_regs *regs);
+void sigio_run_timetravel_handlers(void);
 extern void free_irq_by_fd(int fd);
 extern void deactivate_fd(int fd, int irqnum);
 extern int deactivate_all_fds(void);
diff --git a/arch/um/include/shared/os.h b/arch/um/include/shared/os.h
index f9fbbddc38bb..453b13369533 100644
--- a/arch/um/include/shared/os.h
+++ b/arch/um/include/shared/os.h
@@ -242,6 +242,9 @@ extern int set_signals_trace(int enable);
 extern int os_is_signal_stack(void);
 extern void deliver_alarm(void);
 extern void register_pm_wake_signal(void);
+extern void block_signals_hard(void);
+extern void unblock_signals_hard(void);
+extern void mark_sigio_pending(void);
 
 /* util.c */
 extern void stack_protections(unsigned long address);
diff --git a/arch/um/kernel/irq.c b/arch/um/kernel/irq.c
index 82af5191e73d..1c448ea4729e 100644
--- a/arch/um/kernel/irq.c
+++ b/arch/um/kernel/irq.c
@@ -123,7 +123,8 @@ static bool irq_do_timetravel_handler(struct irq_entry *entry,
 #endif
 
 static void sigio_reg_handler(int idx, struct irq_entry *entry, enum um_irq_type t,
-			      struct uml_pt_regs *regs)
+			      struct uml_pt_regs *regs,
+			      bool timetravel_handlers_only)
 {
 	struct irq_reg *reg = &entry->reg[t];
 
@@ -136,18 +137,29 @@ static void sigio_reg_handler(int idx, struct irq_entry *entry, enum um_irq_type
 	if (irq_do_timetravel_handler(entry, t))
 		return;
 
-	if (irqs_suspended)
+	/*
+	 * If we're called to only run time-travel handlers then don't
+	 * actually proceed but mark sigio as pending (if applicable).
+	 * For suspend/resume, timetravel_handlers_only may be true
+	 * despite time-travel not being configured and used.
+	 */
+	if (timetravel_handlers_only) {
+#ifdef CONFIG_UML_TIME_TRAVEL_SUPPORT
+		mark_sigio_pending();
+#endif
 		return;
+	}
 
 	irq_io_loop(reg, regs);
 }
 
-void sigio_handler(int sig, struct siginfo *unused_si, struct uml_pt_regs *regs)
+static void _sigio_handler(struct uml_pt_regs *regs,
+			   bool timetravel_handlers_only)
 {
 	struct irq_entry *irq_entry;
 	int n, i;
 
-	if (irqs_suspended && !um_irq_timetravel_handler_used())
+	if (timetravel_handlers_only && !um_irq_timetravel_handler_used())
 		return;
 
 	while (1) {
@@ -172,14 +184,20 @@ void sigio_handler(int sig, struct siginfo *unused_si, struct uml_pt_regs *regs)
 			irq_entry = os_epoll_get_data_pointer(i);
 
 			for (t = 0; t < NUM_IRQ_TYPES; t++)
-				sigio_reg_handler(i, irq_entry, t, regs);
+				sigio_reg_handler(i, irq_entry, t, regs,
+						  timetravel_handlers_only);
 		}
 	}
 
-	if (!irqs_suspended)
+	if (!timetravel_handlers_only)
 		free_irqs();
 }
 
+void sigio_handler(int sig, struct siginfo *unused_si, struct uml_pt_regs *regs)
+{
+	_sigio_handler(regs, irqs_suspended);
+}
+
 static struct irq_entry *get_irq_entry_by_fd(int fd)
 {
 	struct irq_entry *walk;
@@ -467,6 +485,11 @@ int um_request_irq_tt(int irq, int fd, enum um_irq_type type,
 			       devname, dev_id, timetravel_handler);
 }
 EXPORT_SYMBOL(um_request_irq_tt);
+
+void sigio_run_timetravel_handlers(void)
+{
+	_sigio_handler(NULL, true);
+}
 #endif
 
 #ifdef CONFIG_PM_SLEEP
diff --git a/arch/um/kernel/time.c b/arch/um/kernel/time.c
index e0cdb9694fb8..fddd1dec27e6 100644
--- a/arch/um/kernel/time.c
+++ b/arch/um/kernel/time.c
@@ -68,23 +68,15 @@ static void time_travel_handle_message(struct um_timetravel_msg *msg,
 	int ret;
 
 	/*
-	 * Poll outside the locked section (if we're not called to only read
-	 * the response) so we can get interrupts for e.g. virtio while we're
-	 * here, but then we need to lock to not get interrupted between the
-	 * read of the message and write of the ACK.
+	 * We can't unlock here, but interrupt signals with a timetravel_handler
+	 * (see um_request_irq_tt) get to the timetravel_handler anyway.
 	 */
 	if (mode != TTMH_READ) {
-		bool disabled = irqs_disabled();
+		BUG_ON(mode == TTMH_IDLE && !irqs_disabled());
 
-		BUG_ON(mode == TTMH_IDLE && !disabled);
-
-		if (disabled)
-			local_irq_enable();
 		while (os_poll(1, &time_travel_ext_fd) != 0) {
 			/* nothing */
 		}
-		if (disabled)
-			local_irq_disable();
 	}
 
 	ret = os_read_file(time_travel_ext_fd, msg, sizeof(*msg));
@@ -123,15 +115,15 @@ static u64 time_travel_ext_req(u32 op, u64 time)
 		.time = time,
 		.seq = mseq,
 	};
-	unsigned long flags;
 
 	/*
-	 * We need to save interrupts here and only restore when we
-	 * got the ACK - otherwise we can get interrupted and send
-	 * another request while we're still waiting for an ACK, but
-	 * the peer doesn't know we got interrupted and will send
-	 * the ACKs in the same order as the message, but we'd need
-	 * to see them in the opposite order ...
+	 * We need to block even the timetravel handlers of SIGIO here and
+	 * only restore their use when we got the ACK - otherwise we may
+	 * (will) get interrupted by that, try to queue the IRQ for future
+	 * processing and thus send another request while we're still waiting
+	 * for an ACK, but the peer doesn't know we got interrupted and will
+	 * send the ACKs in the same order as the message, but we'd need to
+	 * see them in the opposite order ...
 	 *
 	 * This wouldn't matter *too* much, but some ACKs carry the
 	 * current time (for UM_TIMETRAVEL_GET) and getting another
@@ -140,7 +132,7 @@ static u64 time_travel_ext_req(u32 op, u64 time)
 	 * The sequence number assignment that happens here lets us
 	 * debug such message handling issues more easily.
 	 */
-	local_irq_save(flags);
+	block_signals_hard();
 	os_write_file(time_travel_ext_fd, &msg, sizeof(msg));
 
 	while (msg.op != UM_TIMETRAVEL_ACK)
@@ -152,7 +144,7 @@ static u64 time_travel_ext_req(u32 op, u64 time)
 
 	if (op == UM_TIMETRAVEL_GET)
 		time_travel_set_time(msg.time);
-	local_irq_restore(flags);
+	unblock_signals_hard();
 
 	return msg.time;
 }
@@ -352,9 +344,6 @@ void deliver_time_travel_irqs(void)
 	while ((e = list_first_entry_or_null(&time_travel_irqs,
 					     struct time_travel_event,
 					     list))) {
-		WARN(e->time != time_travel_time,
-		     "time moved from %lld to %lld before IRQ delivery\n",
-		     time_travel_time, e->time);
 		list_del(&e->list);
 		e->pending = false;
 		e->fn(e);
diff --git a/arch/um/os-Linux/signal.c b/arch/um/os-Linux/signal.c
index 8c9d162e6c51..1d501acb22ee 100644
--- a/arch/um/os-Linux/signal.c
+++ b/arch/um/os-Linux/signal.c
@@ -18,6 +18,7 @@
 #include <sysdep/mcontext.h>
 #include <um_malloc.h>
 #include <sys/ucontext.h>
+#include <timetravel.h>
 
 void (*sig_info[NSIG])(int, struct siginfo *, struct uml_pt_regs *) = {
 	[SIGTRAP]	= relay_signal,
@@ -63,16 +64,29 @@ static void sig_handler_common(int sig, struct siginfo *si, mcontext_t *mc)
 #define SIGALRM_MASK (1 << SIGALRM_BIT)
 
 int signals_enabled;
+#ifdef UML_CONFIG_UML_TIME_TRAVEL_SUPPORT
+static int signals_blocked;
+#else
+#define signals_blocked false
+#endif
 static unsigned int signals_pending;
 static unsigned int signals_active = 0;
 
 void sig_handler(int sig, struct siginfo *si, mcontext_t *mc)
 {
-	int enabled;
+	int enabled = signals_enabled;
 
-	enabled = signals_enabled;
-	if (!enabled && (sig == SIGIO)) {
-		signals_pending |= SIGIO_MASK;
+	if ((signals_blocked || !enabled) && (sig == SIGIO)) {
+		/*
+		 * In TT_MODE_EXTERNAL, need to still call time-travel
+		 * handlers unless signals are also blocked for the
+		 * external time message processing. This will mark
+		 * signals_pending by itself (only if necessary.)
+		 */
+		if (!signals_blocked && time_travel_mode == TT_MODE_EXTERNAL)
+			sigio_run_timetravel_handlers();
+		else
+			signals_pending |= SIGIO_MASK;
 		return;
 	}
 
@@ -363,6 +377,39 @@ int set_signals_trace(int enable)
 	return ret;
 }
 
+#ifdef UML_CONFIG_UML_TIME_TRAVEL_SUPPORT
+void mark_sigio_pending(void)
+{
+	signals_pending |= SIGIO_MASK;
+}
+
+void block_signals_hard(void)
+{
+	if (signals_blocked)
+		return;
+	signals_blocked = 1;
+	barrier();
+}
+
+void unblock_signals_hard(void)
+{
+	if (!signals_blocked)
+		return;
+	/* Must be set to 0 before we check the pending bits etc. */
+	signals_blocked = 0;
+	barrier();
+
+	if (signals_pending && signals_enabled) {
+		/* this is a bit inefficient, but that's not really important */
+		block_signals();
+		unblock_signals();
+	} else if (signals_pending & SIGIO_MASK) {
+		/* we need to run time-travel handlers even if not enabled */
+		sigio_run_timetravel_handlers();
+	}
+}
+#endif
+
 int os_is_signal_stack(void)
 {
 	stack_t ss;
-- 
2.26.2


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

