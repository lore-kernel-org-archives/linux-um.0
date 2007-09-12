Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IVZZt-000255-02 for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 12 Sep 2007 14:16:53 -0700
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1IVZZs-0004Yk-1b
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 12 Sep 2007 14:16:52 -0700
Date: Wed, 12 Sep 2007 17:16:47 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20070912211647.GA10277@c2.user-mode-linux.org>
Mime-Version: 1.0
Content-Disposition: inline
Subject: [uml-devel] [PATCH 6/11] UML - GENERIC_CLOCKEVENTS support
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Andrew Morton <akpm@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>

Enable CONFIG_GENERIC_CLOCKEVENTS.

timer_irq gets its name changed to timer_handler, and becomes the
recipient of timer signals.

The clock_event_device is set up to imitate the current ticking clock,
i.e. CLOCK_EVT_FEAT_ONESHOT is not enabled yet.

disable_timer now doesn't ignore SIGALRM and SIGVTALRM because that
breaks delay calibration.

Signed-off-by: Jeff Dike <jdike@linux.intel.com>
--
 arch/um/Kconfig         |    4 +
 arch/um/defconfig       |    3 +
 arch/um/kernel/time.c   |   99 ++++++++++++++++++++++--------------------------
 arch/um/os-Linux/time.c |    4 -
 4 files changed, 54 insertions(+), 56 deletions(-)

Index: linux-2.6.22/arch/um/Kconfig
===================================================================
--- linux-2.6.22.orig/arch/um/Kconfig	2007-09-12 16:03:44.000000000 -0400
+++ linux-2.6.22/arch/um/Kconfig	2007-09-12 16:04:24.000000000 -0400
@@ -59,6 +59,10 @@ config GENERIC_TIME
 	bool
 	default y
 
+config GENERIC_CLOCKEVENTS
+	bool
+	default y
+
 # Used in kernel/irq/manage.c and include/linux/irq.h
 config IRQ_RELEASE_METHOD
 	bool
Index: linux-2.6.22/arch/um/kernel/time.c
===================================================================
--- linux-2.6.22.orig/arch/um/kernel/time.c	2007-09-12 16:03:44.000000000 -0400
+++ linux-2.6.22/arch/um/kernel/time.c	2007-09-12 16:14:08.000000000 -0400
@@ -3,6 +3,7 @@
  * Licensed under the GPL
  */
 
+#include "linux/clockchips.h"
 #include "linux/interrupt.h"
 #include "linux/jiffies.h"
 #include "linux/threads.h"
@@ -24,9 +25,10 @@ static unsigned long long prev_nsecs[NR_
 static long long delta[NR_CPUS];		/* Deviation per interval */
 #endif
 
-void timer_irq(struct uml_pt_regs *regs)
+void timer_handler(int sig, struct uml_pt_regs *regs)
 {
 	unsigned long long ticks = 0;
+	unsigned long flags;
 #ifdef CONFIG_UML_REAL_TIME_CLOCK
 	int c = cpu();
 	if (prev_nsecs[c]) {
@@ -47,89 +49,82 @@ void timer_irq(struct uml_pt_regs *regs)
 #else
 	ticks = 1;
 #endif
+
+	local_irq_save(flags);
 	while (ticks > 0) {
 		do_IRQ(TIMER_IRQ, regs);
 		ticks--;
 	}
+	local_irq_restore(flags);
 }
 
-/* Protects local_offset */
-static DEFINE_SPINLOCK(timer_spinlock);
-static unsigned long long local_offset = 0;
-
-static inline unsigned long long get_time(void)
+static void itimer_set_mode(enum clock_event_mode mode,
+			    struct clock_event_device *evt)
 {
-	unsigned long long nsecs;
-	unsigned long flags;
-
-	spin_lock_irqsave(&timer_spinlock, flags);
-	nsecs = os_nsecs();
-	nsecs += local_offset;
-	spin_unlock_irqrestore(&timer_spinlock, flags);
+	switch(mode) {
+	case CLOCK_EVT_MODE_PERIODIC:
+		set_interval();
+		break;
+
+	case CLOCK_EVT_MODE_SHUTDOWN:
+	case CLOCK_EVT_MODE_UNUSED:
+		disable_timer();
+		break;
+	case CLOCK_EVT_MODE_ONESHOT:
+		BUG();
+		break;
 
-	return nsecs;
+	case CLOCK_EVT_MODE_RESUME:
+		break;
+	}
 }
 
-irqreturn_t um_timer(int irq, void *dev)
-{
-	unsigned long long nsecs;
-	unsigned long flags;
-
-	write_seqlock_irqsave(&xtime_lock, flags);
+static struct clock_event_device itimer_clockevent = {
+	.name		= "itimer",
+	.rating		= 250,
+	.cpumask	= CPU_MASK_ALL,
+	.features	= CLOCK_EVT_FEAT_PERIODIC,
+	.set_mode	= itimer_set_mode,
+	.set_next_event = NULL,
+	.shift		= 32,
+	.irq		= 0,
+};
 
-	do_timer(1);
-
-#ifdef CONFIG_UML_REAL_TIME_CLOCK
-	nsecs = get_time();
-#else
-	nsecs = (unsigned long long) xtime.tv_sec * BILLION + xtime.tv_nsec +
-		BILLION / HZ;
-#endif
-	xtime.tv_sec = nsecs / NSEC_PER_SEC;
-	xtime.tv_nsec = nsecs - xtime.tv_sec * NSEC_PER_SEC;
-
-	write_sequnlock_irqrestore(&xtime_lock, flags);
+static irqreturn_t um_timer(int irq, void *dev)
+{
+	(*itimer_clockevent.event_handler)(&itimer_clockevent);
 
 	return IRQ_HANDLED;
 }
 
-static void register_timer(void)
+static void __init setup_itimer(void)
 {
 	int err;
 
-	timer_init();
-
 	err = request_irq(TIMER_IRQ, um_timer, IRQF_DISABLED, "timer", NULL);
 	if (err != 0)
 		printk(KERN_ERR "register_timer : request_irq failed - "
 		       "errno = %d\n", -err);
 
-	err = set_interval();
-	if (err != 0)
-		printk(KERN_ERR "register_timer : set_interval failed - "
-		       "errno = %d\n", -err);
+	itimer_clockevent.mult = div_sc(HZ, NSEC_PER_SEC, 32);
+	itimer_clockevent.max_delta_ns =
+		clockevent_delta2ns(60 * HZ, &itimer_clockevent);
+	itimer_clockevent.min_delta_ns =
+		clockevent_delta2ns(1, &itimer_clockevent);
+	clockevents_register_device(&itimer_clockevent);
 }
 
 extern void (*late_time_init)(void);
 
-void time_init(void)
+void __init time_init(void)
 {
 	long long nsecs;
 
+	timer_init();
+
 	nsecs = os_nsecs();
 	set_normalized_timespec(&wall_to_monotonic, -nsecs / BILLION,
 				-nsecs % BILLION);
 	set_normalized_timespec(&xtime, nsecs / BILLION, nsecs % BILLION);
-	late_time_init = register_timer;
-}
-
-void timer_handler(int sig, struct uml_pt_regs *regs)
-{
-	if (current_thread->cpu == 0)
-		timer_irq(regs);
-	local_irq_disable();
-	irq_enter();
-	update_process_times(regs->is_user);
-	irq_exit();
-	local_irq_enable();
+	late_time_init = setup_itimer;
 }
Index: linux-2.6.22/arch/um/defconfig
===================================================================
--- linux-2.6.22.orig/arch/um/defconfig	2007-09-12 15:56:26.000000000 -0400
+++ linux-2.6.22/arch/um/defconfig	2007-09-12 16:04:24.000000000 -0400
@@ -73,6 +73,9 @@ CONFIG_FLATMEM=y
 CONFIG_FLAT_NODE_MEM_MAP=y
 # CONFIG_SPARSEMEM_STATIC is not set
 CONFIG_SPLIT_PTLOCK_CPUS=4
+# CONFIG_TICK_ONESHOT is not set
+# CONFIG_NO_HZ is not set
+CONFIG_HIGH_RES_TIMERS=y
 CONFIG_LD_SCRIPT_DYN=y
 CONFIG_NET=y
 CONFIG_BINFMT_ELF=y
Index: linux-2.6.22/arch/um/os-Linux/time.c
===================================================================
--- linux-2.6.22.orig/arch/um/os-Linux/time.c	2007-09-12 16:02:03.000000000 -0400
+++ linux-2.6.22/arch/um/os-Linux/time.c	2007-09-12 16:25:24.000000000 -0400
@@ -34,10 +34,6 @@ void disable_timer(void)
 	    (setitimer(ITIMER_REAL, &disable, NULL) < 0))
 		printk(UM_KERN_ERR "disable_timer - setitimer failed, "
 		       "errno = %d\n", errno);
-
-	/* If there are signals already queued, after unblocking ignore them */
-	signal(SIGALRM, SIG_IGN);
-	signal(SIGVTALRM, SIG_IGN);
 }
 
 int switch_timers(int to_real)

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
