Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IVZZo-00024O-8u for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 12 Sep 2007 14:16:48 -0700
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1IVZZn-0000YM-K3
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 12 Sep 2007 14:16:48 -0700
Date: Wed, 12 Sep 2007 17:16:45 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20070912211645.GA10237@c2.user-mode-linux.org>
Mime-Version: 1.0
Content-Disposition: inline
Subject: [uml-devel] [PATCH 2/11] UML - Clean up switching between virtual
	and real timers
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

Fix up the switching between virtual and real timers.  The idle loop
sleeps, the timer at that point must be real time.  At all other
times, the timer must be virtual.  Even when userspace is running, and
the kernel is asleep, the virtual timer is correct because the process
timer will be running.

The timer switch used to be in the context switch and in the timer
handler code.  This is moved to the idle loop and the signal handler,
making it much more clear why it is happening.

switch_timers now returns the old timer type so that it may be
restored.  The signal handler uses this in order to restore the
previous timer type when it returns.

Signed-off-by: Jeff Dike <jdike@linux.intel.com>
--
 arch/um/include/os.h      |    2 +-
 arch/um/kernel/process.c  |    9 ++-------
 arch/um/os-Linux/signal.c |    9 +++------
 arch/um/os-Linux/time.c   |   27 ++++++++++++++++++++-------
 4 files changed, 26 insertions(+), 21 deletions(-)

Index: linux-2.6.22/arch/um/include/os.h
===================================================================
--- linux-2.6.22.orig/arch/um/include/os.h	2007-08-30 16:27:33.000000000 -0400
+++ linux-2.6.22/arch/um/include/os.h	2007-08-30 16:30:49.000000000 -0400
@@ -250,7 +250,7 @@ extern void os_dump_core(void);
 /* time.c */
 #define BILLION (1000 * 1000 * 1000)
 
-extern void switch_timers(int to_real);
+extern int switch_timers(int to_real);
 extern void idle_sleep(int secs);
 extern int set_interval(int is_virtual);
 extern void disable_timer(void);
Index: linux-2.6.22/arch/um/kernel/process.c
===================================================================
--- linux-2.6.22.orig/arch/um/kernel/process.c	2007-08-30 16:27:32.000000000 -0400
+++ linux-2.6.22/arch/um/kernel/process.c	2007-08-30 16:30:49.000000000 -0400
@@ -95,18 +95,11 @@ void *_switch_to(void *prev, void *next,
 	do {
 		current->thread.saved_task = NULL;
 
-		/* XXX need to check runqueues[cpu].idle */
-		if (current->pid == 0)
-			switch_timers(0);
-
 		switch_threads(&from->thread.switch_buf,
 			       &to->thread.switch_buf);
 
 		arch_switch_to(current->thread.prev_sched, current);
 
-		if (current->pid == 0)
-			switch_timers(1);
-
 		if (current->thread.saved_task)
 			show_regs(&(current->thread.regs));
 		next= current->thread.saved_task;
@@ -251,7 +244,9 @@ void default_idle(void)
 		if (need_resched())
 			schedule();
 
+		switch_timers(1);
 		idle_sleep(10);
+		switch_timers(0);
 	}
 }
 
Index: linux-2.6.22/arch/um/os-Linux/signal.c
===================================================================
--- linux-2.6.22.orig/arch/um/os-Linux/signal.c	2007-08-30 16:27:32.000000000 -0400
+++ linux-2.6.22/arch/um/os-Linux/signal.c	2007-08-30 16:30:49.000000000 -0400
@@ -59,17 +59,11 @@ static void real_alarm_handler(int sig, 
 {
 	struct uml_pt_regs regs;
 
-	if (sig == SIGALRM)
-		switch_timers(0);
-
 	if (sc != NULL)
 		copy_sc(&regs, sc);
 	regs.is_user = 0;
 	unblock_signals();
 	timer_handler(sig, &regs);
-
-	if (sig == SIGALRM)
-		switch_timers(1);
 }
 
 void alarm_handler(int sig, struct sigcontext *sc)
@@ -116,6 +110,7 @@ void (*handlers[_NSIG])(int sig, struct 
 void handle_signal(int sig, struct sigcontext *sc)
 {
 	unsigned long pending = 0;
+	int timer = switch_timers(0);
 
 	do {
 		int nested, bail;
@@ -152,6 +147,8 @@ void handle_signal(int sig, struct sigco
 		if (!nested)
 			pending = from_irq_stack(nested);
 	} while (pending);
+
+	switch_timers(timer);
 }
 
 extern void hard_handler(int sig);
Index: linux-2.6.22/arch/um/os-Linux/time.c
===================================================================
--- linux-2.6.22.orig/arch/um/os-Linux/time.c	2007-08-30 16:30:13.000000000 -0400
+++ linux-2.6.22/arch/um/os-Linux/time.c	2007-08-30 16:30:49.000000000 -0400
@@ -12,6 +12,8 @@
 #include "os.h"
 #include "user.h"
 
+static int is_real_timer = 0;
+
 int set_interval(int is_virtual)
 {
 	int usec = 1000000/UM_HZ;
@@ -39,12 +41,14 @@ void disable_timer(void)
 	signal(SIGVTALRM, SIG_IGN);
 }
 
-void switch_timers(int to_real)
+int switch_timers(int to_real)
 {
 	struct itimerval disable = ((struct itimerval) { { 0, 0 }, { 0, 0 }});
-	struct itimerval enable = ((struct itimerval) { { 0, 1000000/UM_HZ },
-							{ 0, 1000000/UM_HZ }});
-	int old, new;
+	struct itimerval enable;
+	int old, new, old_type = is_real_timer;
+
+	if(to_real == old_type)
+		return to_real;
 
 	if (to_real) {
 		old = ITIMER_VIRTUAL;
@@ -55,10 +59,19 @@ void switch_timers(int to_real)
 		new = ITIMER_VIRTUAL;
 	}
 
-	if ((setitimer(old, &disable, NULL) < 0) ||
-	    (setitimer(new, &enable, NULL)))
-		printk(UM_KERN_ERR "switch_timers - setitimer failed, "
+	if (setitimer(old, &disable, &enable) < 0)
+		printk(UM_KERN_ERR "switch_timers - setitimer disable failed, "
+		       "errno = %d\n", errno);
+
+	if((enable.it_value.tv_sec == 0) && (enable.it_value.tv_usec == 0))
+		enable.it_value = enable.it_interval;
+
+	if (setitimer(new, &enable, NULL))
+		printk(UM_KERN_ERR "switch_timers - setitimer enable failed, "
 		       "errno = %d\n", errno);
+
+	is_real_timer = to_real;
+	return old_type;
 }
 
 unsigned long long os_nsecs(void)

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
