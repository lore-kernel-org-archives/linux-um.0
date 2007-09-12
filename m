Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IVZZx-00025N-SM for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 12 Sep 2007 14:16:57 -0700
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1IVZZw-0004aj-5p
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 12 Sep 2007 14:16:57 -0700
Date: Wed, 12 Sep 2007 17:16:49 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20070912211649.GA10247@c2.user-mode-linux.org>
Mime-Version: 1.0
Content-Disposition: inline
Subject: [uml-devel] [PATCH 8/11] UML - Tickless support
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

Enable tickless support.

CONFIG_TICK_ONESHOT and CONFIG_NO_HZ are enabled.

itimer_clockevent gets CLOCK_EVT_FEAT_ONESHOT and an implementation of
.set_next_event.

CONFIG_UML_REAL_TIME_CLOCK goes away because it only makes sense when
there is a clock ticking away all the time.  timer_handler now just
calls do_IRQ once without trying to figure out how many ticks to
emulate.

The idle loop now needs to turn ticking on and off.

For now, process ticks are ignored.  This breaks userspace time
accounting and this will be fixed later.

Signed-off-by: Jeff Dike <jdike@linux.intel.com>
--
 arch/um/Kconfig                 |   12 ----------
 arch/um/defconfig               |    5 +---
 arch/um/include/os.h            |    1 
 arch/um/kernel/process.c        |    3 ++
 arch/um/kernel/time.c           |   45 ++++++++--------------------------------
 arch/um/os-Linux/skas/process.c |   11 ++++++---
 arch/um/os-Linux/time.c         |   29 ++++++++++++++++++++++++-
 7 files changed, 51 insertions(+), 55 deletions(-)

Index: linux-2.6.22/arch/um/kernel/time.c
===================================================================
--- linux-2.6.22.orig/arch/um/kernel/time.c	2007-09-12 15:12:35.000000000 -0400
+++ linux-2.6.22/arch/um/kernel/time.c	2007-09-12 15:15:48.000000000 -0400
@@ -20,41 +20,12 @@ unsigned long long sched_clock(void)
 	return (unsigned long long)jiffies_64 * (1000000000 / HZ);
 }
 
-#ifdef CONFIG_UML_REAL_TIME_CLOCK
-static unsigned long long prev_nsecs[NR_CPUS];
-static long long delta[NR_CPUS];		/* Deviation per interval */
-#endif
-
 void timer_handler(int sig, struct uml_pt_regs *regs)
 {
-	unsigned long long ticks = 0;
 	unsigned long flags;
-#ifdef CONFIG_UML_REAL_TIME_CLOCK
-	int c = cpu();
-	if (prev_nsecs[c]) {
-		/* We've had 1 tick */
-		unsigned long long nsecs = os_nsecs();
-
-		delta[c] += nsecs - prev_nsecs[c];
-		prev_nsecs[c] = nsecs;
-
-		/* Protect against the host clock being set backwards */
-		if (delta[c] < 0)
-			delta[c] = 0;
-
-		ticks += (delta[c] * HZ) / BILLION;
-		delta[c] -= (ticks * BILLION) / HZ;
-	}
-	else prev_nsecs[c] = os_nsecs();
-#else
-	ticks = 1;
-#endif
 
 	local_irq_save(flags);
-	while (ticks > 0) {
-		do_IRQ(TIMER_IRQ, regs);
-		ticks--;
-	}
+	do_IRQ(TIMER_IRQ, regs);
 	local_irq_restore(flags);
 }
 
@@ -68,10 +39,8 @@ static void itimer_set_mode(enum clock_e
 
 	case CLOCK_EVT_MODE_SHUTDOWN:
 	case CLOCK_EVT_MODE_UNUSED:
-		disable_timer();
-		break;
 	case CLOCK_EVT_MODE_ONESHOT:
-		BUG();
+		disable_timer();
 		break;
 
 	case CLOCK_EVT_MODE_RESUME:
@@ -79,13 +48,19 @@ static void itimer_set_mode(enum clock_e
 	}
 }
 
+static int itimer_next_event(unsigned long delta,
+			     struct clock_event_device *evt)
+{
+	return timer_one_shot(delta + 1);
+}
+
 static struct clock_event_device itimer_clockevent = {
 	.name		= "itimer",
 	.rating		= 250,
 	.cpumask	= CPU_MASK_ALL,
-	.features	= CLOCK_EVT_FEAT_PERIODIC,
+	.features	= CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT,
 	.set_mode	= itimer_set_mode,
-	.set_next_event = NULL,
+	.set_next_event = itimer_next_event,
 	.shift		= 32,
 	.irq		= 0,
 };
Index: linux-2.6.22/arch/um/os-Linux/time.c
===================================================================
--- linux-2.6.22.orig/arch/um/os-Linux/time.c	2007-09-12 14:56:38.000000000 -0400
+++ linux-2.6.22/arch/um/os-Linux/time.c	2007-09-12 15:15:48.000000000 -0400
@@ -26,6 +26,33 @@ int set_interval(void)
 	return 0;
 }
 
+int timer_one_shot(int ticks)
+{
+	unsigned long usec = ticks * 1000000 / UM_HZ;
+	unsigned long sec = usec / 1000000;
+	struct itimerval interval;
+
+	usec %= 1000000;
+	interval = ((struct itimerval) { { 0, 0 }, { sec, usec } });
+
+	if (setitimer(ITIMER_VIRTUAL, &interval, NULL) == -1)
+		return -errno;
+
+	return 0;
+}
+
+static inline unsigned long long tv_to_nsec(struct timeval *tv)
+{
+	/* Cast tv->tv_sec to a long long in order to force this whole
+	 * calculation to 64 bits.  Otherwise, we'll get a negative
+	 * 32-bit number getting cast to a very large 64-bit number on
+	 * return.
+	 */
+
+	return ((unsigned long long) tv->tv_sec) * BILLION +
+		tv->tv_usec * 1000;
+}
+
 void disable_timer(void)
 {
 	struct itimerval disable = ((struct itimerval) { { 0, 0 }, { 0, 0 }});
@@ -78,7 +105,7 @@ unsigned long long os_nsecs(void)
 	struct timeval tv;
 
 	gettimeofday(&tv, NULL);
-	return (unsigned long long) tv.tv_sec * BILLION + tv.tv_usec * 1000;
+	return tv_to_nsec(&tv);
 }
 
 void idle_sleep(int secs)
Index: linux-2.6.22/arch/um/include/os.h
===================================================================
--- linux-2.6.22.orig/arch/um/include/os.h	2007-09-12 15:15:43.000000000 -0400
+++ linux-2.6.22/arch/um/include/os.h	2007-09-12 15:15:48.000000000 -0400
@@ -255,6 +255,7 @@ extern void os_log_info(char *fmt, va_li
 extern int switch_timers(int to_real);
 extern void idle_sleep(int secs);
 extern int set_interval(void);
+extern int timer_one_shot(int ticks);
 extern void disable_timer(void);
 extern void uml_idle_timer(void);
 extern unsigned long long os_nsecs(void);
Index: linux-2.6.22/arch/um/defconfig
===================================================================
--- linux-2.6.22.orig/arch/um/defconfig	2007-09-12 15:12:04.000000000 -0400
+++ linux-2.6.22/arch/um/defconfig	2007-09-12 15:15:48.000000000 -0400
@@ -73,8 +73,8 @@ CONFIG_FLATMEM=y
 CONFIG_FLAT_NODE_MEM_MAP=y
 # CONFIG_SPARSEMEM_STATIC is not set
 CONFIG_SPLIT_PTLOCK_CPUS=4
-# CONFIG_TICK_ONESHOT is not set
-# CONFIG_NO_HZ is not set
+CONFIG_TICK_ONESHOT=y
+CONFIG_NO_HZ=y
 CONFIG_HIGH_RES_TIMERS=y
 CONFIG_LD_SCRIPT_DYN=y
 CONFIG_NET=y
@@ -87,7 +87,6 @@ CONFIG_MAGIC_SYSRQ=y
 CONFIG_NEST_LEVEL=0
 # CONFIG_HIGHMEM is not set
 CONFIG_KERNEL_STACK_ORDER=0
-CONFIG_UML_REAL_TIME_CLOCK=y
 
 #
 # Code maturity level options
Index: linux-2.6.22/arch/um/kernel/process.c
===================================================================
--- linux-2.6.22.orig/arch/um/kernel/process.c	2007-09-12 14:53:25.000000000 -0400
+++ linux-2.6.22/arch/um/kernel/process.c	2007-09-12 15:15:48.000000000 -0400
@@ -13,6 +13,7 @@
 #include "linux/ptrace.h"
 #include "linux/random.h"
 #include "linux/sched.h"
+#include "linux/tick.h"
 #include "linux/threads.h"
 #include "asm/pgtable.h"
 #include "asm/uaccess.h"
@@ -244,9 +245,11 @@ void default_idle(void)
 		if (need_resched())
 			schedule();
 
+		tick_nohz_stop_sched_tick();
 		switch_timers(1);
 		idle_sleep(10);
 		switch_timers(0);
+		tick_nohz_restart_sched_tick();
 	}
 }
 
Index: linux-2.6.22/arch/um/os-Linux/skas/process.c
===================================================================
--- linux-2.6.22.orig/arch/um/os-Linux/skas/process.c	2007-09-12 14:53:25.000000000 -0400
+++ linux-2.6.22/arch/um/os-Linux/skas/process.c	2007-09-12 15:15:48.000000000 -0400
@@ -333,8 +333,9 @@ void userspace(struct uml_pt_regs *regs)
 			case SIGTRAP:
 				relay_signal(SIGTRAP, regs);
 				break;
-			case SIGIO:
 			case SIGVTALRM:
+				break;
+			case SIGIO:
 			case SIGILL:
 			case SIGBUS:
 			case SIGFPE:
@@ -378,6 +379,8 @@ __initcall(init_thread_regs);
 
 int copy_context_skas0(unsigned long new_stack, int pid)
 {
+	struct timeval tv = { .tv_sec = 1000000 / UM_HZ,
+			      .tv_usec = 1000000 / UM_HZ };
 	int err;
 	unsigned long current_stack = current_stub_stack();
 	struct stub_data *data = (struct stub_data *) current_stack;
@@ -392,9 +395,9 @@ int copy_context_skas0(unsigned long new
 	*data = ((struct stub_data) { .offset	= MMAP_OFFSET(new_offset),
 				      .fd	= new_fd,
 				      .timer    = ((struct itimerval)
-					            { { 0, 1000000 / UM_HZ },
-						      { 0, 1000000 / UM_HZ }})
-				 });
+					           { .it_value = tv,
+						     .it_interval = tv }) });
+
 	err = ptrace_setregs(pid, thread_regs);
 	if (err < 0)
 		panic("copy_context_skas0 : PTRACE_SETREGS failed, "
Index: linux-2.6.22/arch/um/Kconfig
===================================================================
--- linux-2.6.22.orig/arch/um/Kconfig	2007-09-12 15:12:04.000000000 -0400
+++ linux-2.6.22/arch/um/Kconfig	2007-09-12 15:15:48.000000000 -0400
@@ -250,18 +250,6 @@ config KERNEL_STACK_ORDER
 	  be 1 << order pages.  The default is OK unless you're running Valgrind
 	  on UML, in which case, set this to 3.
 
-config UML_REAL_TIME_CLOCK
-	bool "Real-time Clock"
-	default y
-	help
-	  This option makes UML time deltas match wall clock deltas.  This
-	  should normally be enabled.  The exception would be if you are
-	  debugging with UML and spend long times with UML stopped at a
-	  breakpoint.  In this case, when UML is restarted, it will call the
-	  timer enough times to make up for the time spent at the breakpoint.
-	  This could result in a noticeable lag.  If this is a problem, then
-	  disable this option.
-
 endmenu
 
 source "init/Kconfig"

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
