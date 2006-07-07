Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1FyeHi-0006Zk-3p for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 06 Jul 2006 17:33:30 -0700
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1FyeHh-0006Xr-Gc
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 06 Jul 2006 17:33:30 -0700
Message-Id: <200607070033.k670XaAg008677@ccure.user-mode-linux.org>
Mime-Version: 1.0
Date: Thu, 06 Jul 2006 20:33:36 -0400
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] [PATCH 4/19] UML - timer initialization cleanup
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

This cleans up the mess that is the timer initialization.  There used
to be two timer handlers - one that basically ran during delay loop
calibration and one that handled the timer afterwards.  There were
also two sets of timer initialization code - one that starts in user
code and calls into the kernel side of the house, and one that starts
in kernel code and calls user code.

This eliminates one timer handler and consolidates the two sets of
initialization code.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.17/arch/um/kernel/time_kern.c
===================================================================
--- linux-2.6.17.orig/arch/um/kernel/time_kern.c	2006-07-06 13:36:47.000000000 -0400
+++ linux-2.6.17/arch/um/kernel/time_kern.c	2006-07-06 15:19:19.000000000 -0400
@@ -84,29 +84,6 @@ void timer_irq(union uml_pt_regs *regs)
 	}
 }
 
-
-void time_init_kern(void)
-{
-	long long nsecs;
-
-	nsecs = os_nsecs();
-	set_normalized_timespec(&wall_to_monotonic, -nsecs / BILLION,
-				-nsecs % BILLION);
-}
-
-void do_boot_timer_handler(struct sigcontext * sc)
-{
-	unsigned long flags;
-	struct pt_regs regs;
-
-	CHOOSE_MODE((void) (UPT_SC(&regs.regs) = sc),
-		    (void) (regs.regs.skas.is_user = 0));
-
-	write_seqlock_irqsave(&xtime_lock, flags);
-	do_timer(&regs);
-	write_sequnlock_irqrestore(&xtime_lock, flags);
-}
-
 static DEFINE_SPINLOCK(timer_spinlock);
 
 static unsigned long long local_offset = 0;
@@ -142,6 +119,32 @@ irqreturn_t um_timer(int irq, void *dev,
 	return IRQ_HANDLED;
 }
 
+static void register_timer(void)
+{
+	int err;
+
+	err = request_irq(TIMER_IRQ, um_timer, SA_INTERRUPT, "timer", NULL);
+	if(err != 0)
+		printk(KERN_ERR "timer_init : request_irq failed - "
+		       "errno = %d\n", -err);
+
+	timer_irq_inited = 1;
+
+	user_time_init();
+}
+
+extern void (*late_time_init)(void);
+
+void time_init(void)
+{
+	long long nsecs;
+
+	nsecs = os_nsecs();
+	set_normalized_timespec(&wall_to_monotonic, -nsecs / BILLION,
+				-nsecs % BILLION);
+	late_time_init = register_timer;
+}
+
 void do_gettimeofday(struct timeval *tv)
 {
 	unsigned long long nsecs = get_time();
@@ -189,18 +192,3 @@ void timer_handler(int sig, union uml_pt
 	if(current_thread->cpu == 0)
 		timer_irq(regs);
 }
-
-int __init timer_init(void)
-{
-	int err;
-
-	user_time_init();
-	err = request_irq(TIMER_IRQ, um_timer, IRQF_DISABLED, "timer", NULL);
-	if(err != 0)
-		printk(KERN_ERR "timer_init : request_irq failed - "
-		       "errno = %d\n", -err);
-	timer_irq_inited = 1;
-	return(0);
-}
-
-arch_initcall(timer_init);
Index: linux-2.6.17/arch/um/os-Linux/irq.c
===================================================================
--- linux-2.6.17.orig/arch/um/os-Linux/irq.c	2006-07-06 13:36:47.000000000 -0400
+++ linux-2.6.17/arch/um/os-Linux/irq.c	2006-07-06 15:19:18.000000000 -0400
@@ -142,17 +142,14 @@ void os_set_ioignore(void)
 
 void init_irq_signals(int on_sigstack)
 {
-	__sighandler_t h;
 	int flags;
 
 	flags = on_sigstack ? SA_ONSTACK : 0;
-	if (timer_irq_inited)
-		h = (__sighandler_t)alarm_handler;
-	else
-		h = boot_timer_handler;
 
-	set_handler(SIGVTALRM, h, flags | SA_RESTART,
-		    SIGUSR1, SIGIO, SIGWINCH, SIGALRM, -1);
+	set_handler(SIGVTALRM, (__sighandler_t) alarm_handler,
+		    flags | SA_RESTART, SIGUSR1, SIGIO, SIGWINCH, SIGALRM, -1);
+	set_handler(SIGALRM, (__sighandler_t) alarm_handler,
+		    flags | SA_RESTART, SIGUSR1, SIGIO, SIGWINCH, SIGALRM, -1);
 	set_handler(SIGIO, (__sighandler_t) sig_handler, flags | SA_RESTART,
 		    SIGUSR1, SIGIO, SIGWINCH, SIGALRM, SIGVTALRM, -1);
 	signal(SIGWINCH, SIG_IGN);
Index: linux-2.6.17/arch/um/os-Linux/signal.c
===================================================================
--- linux-2.6.17.orig/arch/um/os-Linux/signal.c	2006-07-06 13:36:47.000000000 -0400
+++ linux-2.6.17/arch/um/os-Linux/signal.c	2006-07-06 15:19:18.000000000 -0400
@@ -106,29 +106,6 @@ void alarm_handler(ARCH_SIGHDLR_PARAM)
 	set_signals(enabled);
 }
 
-extern void do_boot_timer_handler(struct sigcontext * sc);
-
-void boot_timer_handler(ARCH_SIGHDLR_PARAM)
-{
-	struct sigcontext *sc;
-	int enabled;
-
-	ARCH_GET_SIGCONTEXT(sc, sig);
-
-	enabled = signals_enabled;
-	if(!enabled){
-		if(sig == SIGVTALRM)
-			pending |= SIGVTALRM_MASK;
-		else pending |= SIGALRM_MASK;
-		return;
-	}
-
-	block_signals();
-
-	do_boot_timer_handler(sc);
-	set_signals(enabled);
-}
-
 void set_sigstack(void *sig_stack, int size)
 {
 	stack_t stack = ((stack_t) { .ss_flags	= 0,
Index: linux-2.6.17/arch/um/os-Linux/time.c
===================================================================
--- linux-2.6.17.orig/arch/um/os-Linux/time.c	2006-07-06 13:36:47.000000000 -0400
+++ linux-2.6.17/arch/um/os-Linux/time.c	2006-07-06 15:19:19.000000000 -0400
@@ -81,14 +81,6 @@ void uml_idle_timer(void)
 	set_interval(ITIMER_REAL);
 }
 
-void time_init(void)
-{
-	if(signal(SIGVTALRM, boot_timer_handler) == SIG_ERR)
-		panic("Couldn't set SIGVTALRM handler");
-	set_interval(ITIMER_VIRTUAL);
-	time_init_kern();
-}
-
 unsigned long long os_nsecs(void)
 {
 	struct timeval tv;
@@ -106,15 +98,7 @@ void idle_sleep(int secs)
 	nanosleep(&ts, NULL);
 }
 
-/* XXX This partly duplicates init_irq_signals */
-
 void user_time_init(void)
 {
-	set_handler(SIGVTALRM, (__sighandler_t) alarm_handler,
-		    SA_ONSTACK | SA_RESTART, SIGUSR1, SIGIO, SIGWINCH,
-		    SIGALRM, SIGUSR2, -1);
-	set_handler(SIGALRM, (__sighandler_t) alarm_handler,
-		    SA_ONSTACK | SA_RESTART, SIGUSR1, SIGIO, SIGWINCH,
-		    SIGVTALRM, SIGUSR2, -1);
 	set_interval(ITIMER_VIRTUAL);
 }
Index: linux-2.6.17/arch/um/include/kern_util.h
===================================================================
--- linux-2.6.17.orig/arch/um/include/kern_util.h	2006-07-06 15:19:19.000000000 -0400
+++ linux-2.6.17/arch/um/include/kern_util.h	2006-07-06 15:19:39.000000000 -0400
@@ -75,7 +75,6 @@ extern int hz(void);
 extern void uml_idle_timer(void);
 extern unsigned int do_IRQ(int irq, union uml_pt_regs *regs);
 extern int external_pid(void *t);
-extern void boot_timer_handler(int sig);
 extern void interrupt_end(void);
 extern void initial_thread_cb(void (*proc)(void *), void *arg);
 extern int debugger_signal(int status, int pid);


Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
