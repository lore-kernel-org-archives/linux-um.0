Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <anton.ivanov@kot-begemot.co.uk>) id 1XW6ts-0008MN-6E
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 22 Sep 2014 16:55:44 +0000
Received: from ivanoab3.miniserver.com ([89.200.143.206])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1XW6tq-0008MU-0G
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 22 Sep 2014 16:55:44 +0000
From: anton.ivanov@kot-begemot.co.uk
Date: Mon, 22 Sep 2014 17:53:23 +0100
Message-Id: <1411404804-871910-11-git-send-email-anton.ivanov@kot-begemot.co.uk>
In-Reply-To: <1411404804-871910-1-git-send-email-anton.ivanov@kot-begemot.co.uk>
References: <1411404804-871910-1-git-send-email-anton.ivanov@kot-begemot.co.uk>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
Subject: [uml-devel] [PATCH v4 10/11] High Resolution Timer subsystem for UML
To: user-mode-linux-devel@lists.sourceforge.net

From: Anton Ivanov <antivano@cisco.com>

This patch adds an extra timer source which has correct timing
and uses an up-to-date OS API and.

Results - correct kernel behaviour on timer related tasks.

    1. Improvement in network performance (TCP state machines
are now fed correct time).
    2. Correct QoS and traffic shaping.

This improvement does not (and cannot) fix UML userspace. Its
timer/time related behaviour is heavily dependent on getting
VTALRM pacing which is instantiated on a per userspace thread
basis. This patch does not fix this!!! It sorts out only the
kernel side - forwarding, qos, tcp, etc.

Signed-off-by: Anton Ivanov <antivano@cisco.com>
---

Issues addressed in this version:

1. Incorrect value for the hr timer interrupt mask resulting
in races and corruption

2. Missing enable/disable for the SIG used for hr interrupts

 arch/um/Makefile                        |    2 +-
 arch/um/include/asm/irq.h               |    3 +-
 arch/um/include/shared/kern_util.h      |    1 +
 arch/um/include/shared/os.h             |    5 +
 arch/um/include/shared/timer-internal.h |   19 +++
 arch/um/kernel/irq.c                    |   11 ++
 arch/um/kernel/process.c                |    9 +-
 arch/um/kernel/time.c                   |   43 +++++--
 arch/um/os-Linux/signal.c               |   49 +++++++-
 arch/um/os-Linux/skas/process.c         |   24 ++--
 arch/um/os-Linux/time.c                 |  196 +++++++++++++++++++++++--------
 11 files changed, 279 insertions(+), 83 deletions(-)
 create mode 100644 arch/um/include/shared/timer-internal.h

diff --git a/arch/um/Makefile b/arch/um/Makefile
index 133f7de..9864fb7 100644
--- a/arch/um/Makefile
+++ b/arch/um/Makefile
@@ -121,7 +121,7 @@ export LDS_ELF_FORMAT := $(ELF_FORMAT)
 # The wrappers will select whether using "malloc" or the kernel allocator.
 LINK_WRAPS = -Wl,--wrap,malloc -Wl,--wrap,free -Wl,--wrap,calloc
 
-LD_FLAGS_CMDLINE = $(foreach opt,$(LDFLAGS),-Wl,$(opt))
+LD_FLAGS_CMDLINE = $(foreach opt,$(LDFLAGS),-Wl,$(opt)) -lrt
 
 # Used by link-vmlinux.sh which has special support for um link
 export CFLAGS_vmlinux := $(LINK-y) $(LINK_WRAPS) $(LD_FLAGS_CMDLINE)
diff --git a/arch/um/include/asm/irq.h b/arch/um/include/asm/irq.h
index be9128b..4dd2f07 100644
--- a/arch/um/include/asm/irq.h
+++ b/arch/um/include/asm/irq.h
@@ -22,8 +22,9 @@
 #define TELNETD_IRQ 		UM_END_ETH_IRQ + 7
 #define XTERM_IRQ 		UM_END_ETH_IRQ + 8
 #define RANDOM_IRQ 		UM_END_ETH_IRQ + 9
+#define HRTIMER_IRQ             UM_END_ETH_IRQ + 10
 
-#define LAST_IRQ RANDOM_IRQ
+#define LAST_IRQ HRTIMER_IRQ
 #define NR_IRQS (LAST_IRQ + 1)
 
 #endif
diff --git a/arch/um/include/shared/kern_util.h b/arch/um/include/shared/kern_util.h
index 83a91f9..0282b36 100644
--- a/arch/um/include/shared/kern_util.h
+++ b/arch/um/include/shared/kern_util.h
@@ -37,6 +37,7 @@ extern void initial_thread_cb(void (*proc)(void *), void *arg);
 extern int is_syscall(unsigned long addr);
 
 extern void timer_handler(int sig, struct siginfo *unused_si, struct uml_pt_regs *regs);
+extern void hrtimer_handler(int sig, struct siginfo *unused_si, struct uml_pt_regs *regs);
 
 extern int start_uml(void);
 extern void paging_init(void);
diff --git a/arch/um/include/shared/os.h b/arch/um/include/shared/os.h
index d7bf791..404ba74c 100644
--- a/arch/um/include/shared/os.h
+++ b/arch/um/include/shared/os.h
@@ -222,6 +222,7 @@ extern char *get_umid(void);
 
 /* signal.c */
 extern void timer_init(void);
+extern void uml_hrtimer_init(void);
 extern void set_sigstack(void *sig_stack, int size);
 extern void remove_sigstack(void);
 extern void set_handler(int sig);
@@ -245,8 +246,12 @@ extern void idle_sleep(unsigned long long nsecs);
 extern int set_interval(void);
 extern int timer_one_shot(int ticks);
 extern long long disable_timer(void);
+extern long long timer_remain(void);
 extern void uml_idle_timer(void);
+extern long long persistent_clock_emulation(void);
 extern long long os_nsecs(void);
+extern long long os_vnsecs(void);
+extern int itimer_init(void);
 
 /* skas/mem.c */
 extern long run_syscall_stub(struct mm_id * mm_idp,
diff --git a/arch/um/include/shared/timer-internal.h b/arch/um/include/shared/timer-internal.h
new file mode 100644
index 0000000..3e78d83
--- /dev/null
+++ b/arch/um/include/shared/timer-internal.h
@@ -0,0 +1,19 @@
+/*
+ * Copyright (C) 2012 - 2014 Cisco Systems
+ * Copyright (C) 2000 - 2007 Jeff Dike (jdike@{addtoit,linux.intel}.com)
+ * Licensed under the GPL
+ */
+
+#ifndef __TIMER_INTERNAL_H__
+#define __TIMER_INTERNAL_H__
+
+#define TIMER_MULTIPLIER 256
+#define TIMER_MIN_DELTA 500
+
+extern void timer_lock(void);
+extern void timer_unlock(void);
+
+extern long long hrtimer_disable(void);
+extern long long tracingtimer_disable(void);
+
+#endif
diff --git a/arch/um/kernel/irq.c b/arch/um/kernel/irq.c
index 12cba21..519abc5 100644
--- a/arch/um/kernel/irq.c
+++ b/arch/um/kernel/irq.c
@@ -533,11 +533,22 @@ static struct irq_chip SIGVTALRM_irq_type = {
 	.irq_unmask = dummy,
 };
 
+static struct irq_chip SIGUSR2_irq_type = {
+	.name = "SIGUSR2",
+	.irq_disable = dummy,
+	.irq_enable = dummy,
+	.irq_ack = dummy,
+	.irq_mask = dummy,
+	.irq_unmask = dummy,
+};
+
+
 void __init init_IRQ(void)
 {
 	int i;
 
 	irq_set_chip_and_handler(TIMER_IRQ, &SIGVTALRM_irq_type, handle_edge_irq);
+	irq_set_chip_and_handler(HRTIMER_IRQ, &SIGUSR2_irq_type, handle_edge_irq);
 	for (i = 1; i < NR_IRQS - 1 ; i++)
 		irq_set_chip_and_handler(i, &normal_irq_type, handle_edge_irq);
 	os_setup_epoll(MAX_EPOLL_EVENTS);
diff --git a/arch/um/kernel/process.c b/arch/um/kernel/process.c
index bbcef52..3daf56b 100644
--- a/arch/um/kernel/process.c
+++ b/arch/um/kernel/process.c
@@ -27,6 +27,7 @@
 #include <kern_util.h>
 #include <os.h>
 #include <skas.h>
+#include <timer-internal.h>
 
 /*
  * This is a per-cpu array.  A processor only modifies its entry and it only
@@ -215,7 +216,13 @@ void arch_cpu_idle(void)
 	unsigned long long nsecs;
 
 	cpu_tasks[current_thread_info()->cpu].pid = os_getpid();
-	nsecs = disable_timer();
+
+	/* there is no benefit whatsoever in disabling a pending
+	* hrtimer and setting a nanowait for the same value instead
+	* so we do timer disable + wait only for the tracing one here
+	*/
+
+	nsecs = tracingtimer_disable();
 	idle_sleep(nsecs);
 	local_irq_enable();
 }
diff --git a/arch/um/kernel/time.c b/arch/um/kernel/time.c
index 117568d..e1546d9 100644
--- a/arch/um/kernel/time.c
+++ b/arch/um/kernel/time.c
@@ -1,4 +1,5 @@
 /*
+ * Copyright (C) 2012-2014 Cisco Systems
  * Copyright (C) 2000 - 2007 Jeff Dike (jdike@{addtoit,linux.intel}.com)
  * Licensed under the GPL
  */
@@ -8,10 +9,13 @@
 #include <linux/interrupt.h>
 #include <linux/jiffies.h>
 #include <linux/threads.h>
+#include <linux/spinlock.h>
 #include <asm/irq.h>
 #include <asm/param.h>
 #include <kern_util.h>
 #include <os.h>
+#include <timer-internal.h>
+
 
 void timer_handler(int sig, struct siginfo *unused_si, struct uml_pt_regs *regs)
 {
@@ -22,6 +26,15 @@ void timer_handler(int sig, struct siginfo *unused_si, struct uml_pt_regs *regs)
 	local_irq_restore(flags);
 }
 
+void hrtimer_handler(int sig, struct siginfo *unused_si, struct uml_pt_regs *regs)
+{
+	unsigned long flags;
+
+	local_irq_save(flags);
+	do_IRQ(HRTIMER_IRQ, regs);
+	local_irq_restore(flags);
+}
+
 static void itimer_set_mode(enum clock_event_mode mode,
 			    struct clock_event_device *evt)
 {
@@ -44,7 +57,7 @@ static void itimer_set_mode(enum clock_event_mode mode,
 static int itimer_next_event(unsigned long delta,
 			     struct clock_event_device *evt)
 {
-	return timer_one_shot(delta + 1);
+	return timer_one_shot(delta);
 }
 
 static struct clock_event_device itimer_clockevent = {
@@ -54,8 +67,11 @@ static struct clock_event_device itimer_clockevent = {
 	.features	= CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT,
 	.set_mode	= itimer_set_mode,
 	.set_next_event = itimer_next_event,
-	.shift		= 32,
+	.shift		= 0,
+	.max_delta_ns	= 0xffffffff,
+	.min_delta_ns	= TIMER_MIN_DELTA, //microsecond resolution should be enough for anyone, same as 640K RAM
 	.irq		= 0,
+	.mult		= 1,
 };
 
 static irqreturn_t um_timer(int irq, void *dev)
@@ -67,7 +83,7 @@ static irqreturn_t um_timer(int irq, void *dev)
 
 static cycle_t itimer_read(struct clocksource *cs)
 {
-	return os_nsecs() / 1000;
+	return os_nsecs() / TIMER_MULTIPLIER;
 }
 
 static struct clocksource itimer_clocksource = {
@@ -82,17 +98,21 @@ static void __init setup_itimer(void)
 {
 	int err;
 
-	err = request_irq(TIMER_IRQ, um_timer, 0, "timer", NULL);
+	err = request_irq(TIMER_IRQ, um_timer, IRQF_DISABLED, "timer", NULL);
+	if (err != 0)
+		printk(KERN_ERR "register_timer : request_irq failed - "
+		       "errno = %d\n", -err);
+	err = request_irq(HRTIMER_IRQ, um_timer, IRQF_DISABLED, "hr timer", NULL);
 	if (err != 0)
 		printk(KERN_ERR "register_timer : request_irq failed - "
 		       "errno = %d\n", -err);
+        err = itimer_init();
+
+	if (err != 0)
+		printk(KERN_ERR "init itimer failed - "
+		       "errno = %d\n", -err);
 
-	itimer_clockevent.mult = div_sc(HZ, NSEC_PER_SEC, 32);
-	itimer_clockevent.max_delta_ns =
-		clockevent_delta2ns(60 * HZ, &itimer_clockevent);
-	itimer_clockevent.min_delta_ns =
-		clockevent_delta2ns(1, &itimer_clockevent);
-	err = clocksource_register_hz(&itimer_clocksource, USEC_PER_SEC);
+	err = clocksource_register_hz(&itimer_clocksource, NSEC_PER_SEC/TIMER_MULTIPLIER);
 	if (err) {
 		printk(KERN_ERR "clocksource_register_hz returned %d\n", err);
 		return;
@@ -102,7 +122,7 @@ static void __init setup_itimer(void)
 
 void read_persistent_clock(struct timespec *ts)
 {
-	long long nsecs = os_nsecs();
+	long long nsecs = persistent_clock_emulation();
 
 	set_normalized_timespec(ts, nsecs / NSEC_PER_SEC,
 				nsecs % NSEC_PER_SEC);
@@ -111,5 +131,6 @@ void read_persistent_clock(struct timespec *ts)
 void __init time_init(void)
 {
 	timer_init();
+	uml_hrtimer_init();
 	late_time_init = setup_itimer;
 }
diff --git a/arch/um/os-Linux/signal.c b/arch/um/os-Linux/signal.c
index 905924b..1e528af 100644
--- a/arch/um/os-Linux/signal.c
+++ b/arch/um/os-Linux/signal.c
@@ -23,7 +23,8 @@ void (*sig_info[NSIG])(int, struct siginfo *, struct uml_pt_regs *) = {
 	[SIGBUS]	= bus_handler,
 	[SIGSEGV]	= segv_handler,
 	[SIGIO]		= sigio_handler,
-	[SIGVTALRM]	= timer_handler };
+	[SIGVTALRM]	= timer_handler,
+	[SIGUSR2]	= hrtimer_handler };
 
 static void sig_handler_common(int sig, struct siginfo *si, mcontext_t *mc)
 {
@@ -38,7 +39,7 @@ static void sig_handler_common(int sig, struct siginfo *si, mcontext_t *mc)
 	}
 
 	/* enable signals if sig isn't IRQ signal */
-	if ((sig != SIGIO) && (sig != SIGWINCH) && (sig != SIGVTALRM))
+	if ((sig != SIGIO) && (sig != SIGWINCH) && (sig != SIGVTALRM) && (sig != SIGUSR2))
 		unblock_signals();
 
 	(*sig_info[sig])(sig, si, &r);
@@ -58,6 +59,10 @@ static void sig_handler_common(int sig, struct siginfo *si, mcontext_t *mc)
 #define SIGVTALRM_BIT 1
 #define SIGVTALRM_MASK (1 << SIGVTALRM_BIT)
 
+#define SIGUSR2_BIT 2
+#define SIGUSR2_MASK (1 << SIGUSR2_BIT)
+
+
 static int signals_enabled;
 static unsigned int signals_pending;
 
@@ -89,6 +94,17 @@ static void real_alarm_handler(mcontext_t *mc)
 	timer_handler(SIGVTALRM, NULL, &regs);
 }
 
+static void real_hralarm_handler(mcontext_t *mc)
+{
+	struct uml_pt_regs regs;
+
+	if (mc != NULL)
+		get_regs_from_mc(&regs, mc);
+	regs.is_user = 0;
+	hrtimer_handler(SIGUSR2, NULL, &regs);
+}
+
+
 void alarm_handler(int sig, struct siginfo *unused_si, mcontext_t *mc)
 {
 	int enabled;
@@ -105,11 +121,33 @@ void alarm_handler(int sig, struct siginfo *unused_si, mcontext_t *mc)
 	set_signals(enabled);
 }
 
+void hralarm_handler(int sig, struct siginfo *unused_si, mcontext_t *mc)
+{
+	int enabled;
+
+	enabled = signals_enabled;
+	if (!signals_enabled) {
+		signals_pending |= SIGUSR2_MASK;
+		return;
+	}
+
+	block_signals();
+
+	real_hralarm_handler(mc);
+	set_signals(enabled);
+}
+
+
 void timer_init(void)
 {
 	set_handler(SIGVTALRM);
 }
 
+void uml_hrtimer_init(void)
+{
+	set_handler(SIGUSR2);
+}
+
 void set_sigstack(void *sig_stack, int size)
 {
 	stack_t stack = ((stack_t) { .ss_flags	= 0,
@@ -129,7 +167,8 @@ static void (*handlers[_NSIG])(int sig, struct siginfo *si, mcontext_t *mc) = {
 
 	[SIGIO] = sig_handler,
 	[SIGWINCH] = sig_handler,
-	[SIGVTALRM] = alarm_handler
+	[SIGVTALRM] = alarm_handler,
+	[SIGUSR2] = hralarm_handler
 };
 
 
@@ -189,6 +228,7 @@ void set_handler(int sig)
 	sigaddset(&action.sa_mask, SIGVTALRM);
 	sigaddset(&action.sa_mask, SIGIO);
 	sigaddset(&action.sa_mask, SIGWINCH);
+	sigaddset(&action.sa_mask, SIGUSR2);
 
 	if (sig == SIGSEGV)
 		flags |= SA_NODEFER;
@@ -283,6 +323,9 @@ void unblock_signals(void)
 
 		if (save_pending & SIGVTALRM_MASK)
 			real_alarm_handler(NULL);
+
+		if (save_pending & SIGUSR2_MASK)
+			real_hralarm_handler(NULL);
 	}
 }
 
diff --git a/arch/um/os-Linux/skas/process.c b/arch/um/os-Linux/skas/process.c
index d531879..3c8ca2a 100644
--- a/arch/um/os-Linux/skas/process.c
+++ b/arch/um/os-Linux/skas/process.c
@@ -47,7 +47,7 @@ static int ptrace_dump_regs(int pid)
  * Signals that are OK to receive in the stub - we'll just continue it.
  * SIGWINCH will happen when UML is inside a detached screen.
  */
-#define STUB_SIG_MASK ((1 << SIGVTALRM) | (1 << SIGWINCH))
+#define STUB_SIG_MASK ((1 << SIGVTALRM) | (1 << SIGWINCH) | (1 << SIGUSR2))
 
 /* Signals that the stub will finish with - anything else is an error */
 #define STUB_DONE_MASK (1 << SIGTRAP)
@@ -346,8 +346,7 @@ int start_userspace(unsigned long stub_stack)
 
 void userspace(struct uml_pt_regs *regs)
 {
-	struct itimerval timer;
-	unsigned long long nsecs, now;
+	unsigned long long nsecs;
 	int err, status, op, pid = userspace_pid[0];
 	/* To prevent races if using_sysemu changes under us.*/
 	int local_using_sysemu;
@@ -356,13 +355,11 @@ void userspace(struct uml_pt_regs *regs)
 	/* Handle any immediate reschedules or signals */
 	interrupt_end();
 
-	if (getitimer(ITIMER_VIRTUAL, &timer))
-		printk(UM_KERN_ERR "Failed to get itimer, errno = %d\n", errno);
-	nsecs = timer.it_value.tv_sec * UM_NSEC_PER_SEC +
-		timer.it_value.tv_usec * UM_NSEC_PER_USEC;
-	nsecs += os_nsecs();
-
 	while (1) {
+
+		nsecs = timer_remain();
+	        nsecs += os_nsecs();
+
 		/*
 		 * This can legitimately fail if the process loads a
 		 * bogus value into a segment register.  It will
@@ -434,23 +431,18 @@ void userspace(struct uml_pt_regs *regs)
 				relay_signal(SIGTRAP, (struct siginfo *)&si, regs);
 				break;
 			case SIGVTALRM:
-				now = os_nsecs();
-				if (now < nsecs)
+				if (nsecs < os_nsecs())
 					break;
 				block_signals();
 				(*sig_info[sig])(sig, (struct siginfo *)&si, regs);
 				unblock_signals();
-				nsecs = timer.it_value.tv_sec *
-					UM_NSEC_PER_SEC +
-					timer.it_value.tv_usec *
-					UM_NSEC_PER_USEC;
-				nsecs += os_nsecs();
 				break;
 			case SIGIO:
 			case SIGILL:
 			case SIGBUS:
 			case SIGFPE:
 			case SIGWINCH:
+			case SIGUSR2:
 				block_signals();
 				(*sig_info[sig])(sig, (struct siginfo *)&si, regs);
 				unblock_signals();
diff --git a/arch/um/os-Linux/time.c b/arch/um/os-Linux/time.c
index e9824d5..1dd9c53 100644
--- a/arch/um/os-Linux/time.c
+++ b/arch/um/os-Linux/time.c
@@ -1,4 +1,5 @@
 /*
+ * Copyright (C) 2012-2014 Cisco Systems
  * Copyright (C) 2000 - 2007 Jeff Dike (jdike{addtoit,linux.intel}.com)
  * Licensed under the GPL
  */
@@ -10,13 +11,59 @@
 #include <sys/time.h>
 #include <kern_util.h>
 #include <os.h>
+#include <string.h>
 #include "internal.h"
+#include <timer-internal.h>
+
+static timer_t event_high_res_timer = 0;
+
+static inline long long timeval_to_ns(const struct timeval *tv)
+{
+	return ((long long) tv->tv_sec * UM_NSEC_PER_SEC) +
+		tv->tv_usec * UM_NSEC_PER_USEC;
+}
+
+static inline long long timespec_to_ns(const struct timespec *ts)
+{
+	return ((long long) ts->tv_sec * UM_NSEC_PER_SEC) +
+		ts->tv_nsec;
+}
+
+long long  persistent_clock_emulation (void) {
+	struct timespec realtime_tp;
+
+	clock_gettime(CLOCK_REALTIME, &realtime_tp);
+	return timespec_to_ns(&realtime_tp);
+}
+
+
+int itimer_init(void) {
+	struct sigevent sev, bbev;
+	sev.sigev_notify = SIGEV_SIGNAL;
+	sev.sigev_signo = SIGUSR2; /* note - hrtimer now has its own signal */
+	sev.sigev_value.sival_ptr = &event_high_res_timer;
+	if (timer_create(
+		CLOCK_MONOTONIC,
+		&sev,
+		&event_high_res_timer) == -1
+	) {
+		printk("Failed to create Timer");
+		return -1;
+	} else {
+		printk("Event timer ID is 0x%lx\n", (long) event_high_res_timer);
+	}
+	return 0;
+}
+
+/*
+* This is used for tracing and cannot be removed at this point (TODO)
+*/
 
 int set_interval(void)
 {
 	int usec = UM_USEC_PER_SEC / UM_HZ;
 	struct itimerval interval = ((struct itimerval) { { 0, usec },
-							  { 0, usec } });
+							{ 0, usec } });
 
 	if (setitimer(ITIMER_VIRTUAL, &interval, NULL) == -1)
 		return -errno;
@@ -24,61 +71,104 @@ int set_interval(void)
 	return 0;
 }
 
-int timer_one_shot(int ticks)
+long long timer_remain (void)
 {
-	unsigned long usec = ticks * UM_USEC_PER_SEC / UM_HZ;
-	unsigned long sec = usec / UM_USEC_PER_SEC;
 	struct itimerval interval;
+	long long remain = 0;
+	if (getitimer(ITIMER_VIRTUAL, &interval)) {
+		printk(UM_KERN_ERR "Failed to get itimer, errno = %d\n", errno);
+	} else {
+		remain = timeval_to_ns(&interval.it_value);
+	}
+	return remain;
+}
 
-	usec %= UM_USEC_PER_SEC;
-	interval = ((struct itimerval) { { 0, 0 }, { sec, usec } });
+int timer_one_shot(int ticks)
+{
+	struct itimerspec its;
+	unsigned long long nsec;
+	unsigned long sec;
 
-	if (setitimer(ITIMER_VIRTUAL, &interval, NULL) == -1)
-		return -errno;
+
+        nsec = (ticks + 1);
+
+        sec = nsec / UM_NSEC_PER_SEC;
+
+	nsec = nsec % UM_NSEC_PER_SEC;
+
+	its.it_value.tv_sec = nsec / UM_NSEC_PER_SEC;
+	its.it_value.tv_nsec = nsec ;
+
+	its.it_interval.tv_sec = 0;
+	its.it_interval.tv_nsec = 0; // we cheat here
+
+	timer_settime(event_high_res_timer, 0, &its, NULL);
 
 	return 0;
 }
 
-/**
- * timeval_to_ns - Convert timeval to nanoseconds
- * @ts:		pointer to the timeval variable to be converted
- *
- * Returns the scalar nanosecond representation of the timeval
- * parameter.
- *
- * Ripped from linux/time.h because it's a kernel header, and thus
- * unusable from here.
- */
-static inline long long timeval_to_ns(const struct timeval *tv)
+long long hrtimer_disable(void)
 {
-	return ((long long) tv->tv_sec * UM_NSEC_PER_SEC) +
-		tv->tv_usec * UM_NSEC_PER_USEC;
+	struct itimerspec its;
+
+	memset(&its, 0, sizeof(struct itimerspec));
+	timer_settime(event_high_res_timer, 0, &its, &its);
+
+	return its.it_value.tv_sec * UM_NSEC_PER_SEC + its.it_value.tv_nsec;
+}
+
+long long tracingtimer_disable(void)
+{
+	struct itimerval itv;
+
+	memset(&itv, 0, sizeof(struct itimerval));
+	setitimer(ITIMER_VIRTUAL, &itv, &itv);
+
+	return itv.it_value.tv_sec * UM_NSEC_PER_SEC + itv.it_value.tv_usec * 1000;
 }
 
 long long disable_timer(void)
 {
-	struct itimerval time = ((struct itimerval) { { 0, 0 }, { 0, 0 } });
-	long long remain, max = UM_NSEC_PER_SEC / UM_HZ;
+	long long nsec;
+	long long tnsec;
+
+        /*
+	* This is now fixed in the main idle loop so we really kill
+	* both timers here to ensure that UML can exit cleanly and
+	* not die on a spurious SIG_VTALRM
+        */
+
+
+        nsec = hrtimer_disable();
+        tnsec = tracingtimer_disable();
+        if (nsec > tnsec) {
+		return tnsec;
+        } else {
+		return nsec;
+        }
+}
 
-	if (setitimer(ITIMER_VIRTUAL, &time, &time) < 0)
-		printk(UM_KERN_ERR "disable_timer - setitimer failed, "
-		       "errno = %d\n", errno);
+long long os_vnsecs(void)
+{
+	struct timespec ts;
 
-	remain = timeval_to_ns(&time.it_value);
-	if (remain > max)
-		remain = max;
+        clock_gettime(CLOCK_PROCESS_CPUTIME_ID,&ts);
+	return timespec_to_ns(&ts);
 
-	return remain;
 }
 
 long long os_nsecs(void)
 {
-	struct timeval tv;
 
-	gettimeofday(&tv, NULL);
-	return timeval_to_ns(&tv);
+	struct timespec ts;
+
+        clock_gettime(CLOCK_MONOTONIC,&ts);
+	return timespec_to_ns(&ts);
+
 }
 
+
+
 #ifdef UML_CONFIG_NO_HZ_COMMON
 static int after_sleep_interval(struct timespec *ts)
 {
@@ -140,12 +230,12 @@ static int after_sleep_interval(struct timespec *ts)
 	struct itimerval interval;
 
 	/*
-	 * It seems that rounding can increase the value returned from
-	 * setitimer to larger than the one passed in.  Over time,
-	 * this will cause the remaining time to be greater than the
-	 * tick interval.  If this happens, then just reduce the first
-	 * tick to the interval value.
-	 */
+	* It seems that rounding can increase the value returned from
+	* setitimer to larger than the one passed in.  Over time,
+	* this will cause the remaining time to be greater than the
+	* tick interval.  If this happens, then just reduce the first
+	* tick to the interval value.
+	*/
 	if (start_usecs > usec)
 		start_usecs = usec;
 
@@ -154,7 +244,7 @@ static int after_sleep_interval(struct timespec *ts)
 		start_usecs = 0;
 
 	tv = ((struct timeval) { .tv_sec  = start_usecs / UM_USEC_PER_SEC,
-				 .tv_usec = start_usecs % UM_USEC_PER_SEC });
+				.tv_usec = start_usecs % UM_USEC_PER_SEC });
 	interval = ((struct itimerval) { { 0, usec }, tv });
 
 	if (setitimer(ITIMER_VIRTUAL, &interval, NULL) == -1)
@@ -169,18 +259,24 @@ void idle_sleep(unsigned long long nsecs)
 	struct timespec ts;
 
 	/*
-	 * nsecs can come in as zero, in which case, this starts a
-	 * busy loop.  To prevent this, reset nsecs to the tick
-	 * interval if it is zero.
-	 */
-	if (nsecs == 0)
-		nsecs = UM_NSEC_PER_SEC / UM_HZ;
-
-	nsecs = sleep_time(nsecs);
+	*   We sleep here for an interval that is not greater than HZ
+	*   We did not disable the timer in "disable" so if there is a timer
+	*   active it will wake us up right on time instead of doing
+	*   stupid things trying to program nanosleep in a race condition
+	*   manner.
+	*/
+
+        if ((nsecs == 0) || (nsecs > UM_NSEC_PER_SEC / UM_HZ)) {
+		nsecs = UM_NSEC_PER_SEC / UM_HZ ;
+        }
+
 	ts = ((struct timespec) { .tv_sec	= nsecs / UM_NSEC_PER_SEC,
-				  .tv_nsec	= nsecs % UM_NSEC_PER_SEC });
+				.tv_nsec	= nsecs % UM_NSEC_PER_SEC });
+
 
-	if (nanosleep(&ts, &ts) == 0)
+	if (clock_nanosleep(CLOCK_MONOTONIC, 0, &ts, &ts) == 0) {
 		deliver_alarm();
+        }
+        set_interval();
 	after_sleep_interval(&ts);
 }
-- 
1.7.10.4


------------------------------------------------------------------------------
Meet PCI DSS 3.0 Compliance Requirements with EventLog Analyzer
Achieve PCI DSS 3.0 Compliant Status with Out-of-the-box PCI DSS Reports
Are you Audit-Ready for PCI DSS 3.0 Compliance? Download White paper
Comply to PCI DSS 3.0 Requirement 10 and 11.5 with EventLog Analyzer
http://pubads.g.doubleclick.net/gampad/clk?id=154622311&iu=/4140/ostg.clktrk
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

