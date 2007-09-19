Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IY2wY-0006Ow-9j for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 19 Sep 2007 10:02:30 -0700
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1IY2wX-0006tf-CD
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 19 Sep 2007 10:02:30 -0700
Date: Wed, 19 Sep 2007 13:02:24 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20070919170224.GA10176@c2.user-mode-linux.org>
Mime-Version: 1.0
Content-Disposition: inline
Subject: [uml-devel] [PATCH 4/11] UML - Separate timer initialization
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

Move timer signal initialization from init_irq_signals to a new
function, timer_init.

Signed-off-by: Jeff Dike <jdike@linux.intel.com>
---
 arch/um/include/os.h      |    1 +
 arch/um/kernel/time.c     |    2 ++
 arch/um/os-Linux/irq.c    |    4 ----
 arch/um/os-Linux/signal.c |   10 ++++++++++
 4 files changed, 13 insertions(+), 4 deletions(-)

Index: linux-2.6.20/arch/um/kernel/time.c
===================================================================
--- linux-2.6.20.orig/arch/um/kernel/time.c	2007-09-19 12:25:05.000000000 -0400
+++ linux-2.6.20/arch/um/kernel/time.c	2007-09-19 12:25:06.000000000 -0400
@@ -97,6 +97,8 @@ static void register_timer(void)
 {
 	int err;
 
+	timer_init();
+
 	err = request_irq(TIMER_IRQ, um_timer, IRQF_DISABLED, "timer", NULL);
 	if (err != 0)
 		printk(KERN_ERR "register_timer : request_irq failed - "
Index: linux-2.6.20/arch/um/os-Linux/irq.c
===================================================================
--- linux-2.6.20.orig/arch/um/os-Linux/irq.c	2007-09-19 12:24:52.000000000 -0400
+++ linux-2.6.20/arch/um/os-Linux/irq.c	2007-09-19 12:25:06.000000000 -0400
@@ -145,10 +145,6 @@ void init_irq_signals(int on_sigstack)
 
 	flags = on_sigstack ? SA_ONSTACK : 0;
 
-	set_handler(SIGVTALRM, (__sighandler_t) alarm_handler,
-		    flags | SA_RESTART, SIGUSR1, SIGIO, SIGWINCH, SIGALRM, -1);
-	set_handler(SIGALRM, (__sighandler_t) alarm_handler,
-		    flags | SA_RESTART, SIGUSR1, SIGIO, SIGWINCH, SIGALRM, -1);
 	set_handler(SIGIO, (__sighandler_t) sig_handler, flags | SA_RESTART,
 		    SIGUSR1, SIGIO, SIGWINCH, SIGALRM, SIGVTALRM, -1);
 	signal(SIGWINCH, SIG_IGN);
Index: linux-2.6.20/arch/um/include/os.h
===================================================================
--- linux-2.6.20.orig/arch/um/include/os.h	2007-09-19 12:25:05.000000000 -0400
+++ linux-2.6.20/arch/um/include/os.h	2007-09-19 12:25:06.000000000 -0400
@@ -227,6 +227,7 @@ extern int set_umid(char *name);
 extern char *get_umid(void);
 
 /* signal.c */
+extern void timer_init(void);
 extern void set_sigstack(void *sig_stack, int size);
 extern void remove_sigstack(void);
 extern void set_handler(int sig, void (*handler)(int), int flags, ...);
Index: linux-2.6.20/arch/um/os-Linux/signal.c
===================================================================
--- linux-2.6.20.orig/arch/um/os-Linux/signal.c	2007-09-19 12:25:05.000000000 -0400
+++ linux-2.6.20/arch/um/os-Linux/signal.c	2007-09-19 12:25:06.000000000 -0400
@@ -85,6 +85,16 @@ void alarm_handler(int sig, struct sigco
 	set_signals(enabled);
 }
 
+void timer_init(void)
+{
+	set_handler(SIGVTALRM, (__sighandler_t) alarm_handler,
+		    SA_ONSTACK | SA_RESTART, SIGUSR1, SIGIO, SIGWINCH,
+		    SIGALRM, -1);
+	set_handler(SIGALRM, (__sighandler_t) alarm_handler,
+		    SA_ONSTACK | SA_RESTART, SIGUSR1, SIGIO, SIGWINCH,
+		    SIGALRM, -1);
+}
+
 void set_sigstack(void *sig_stack, int size)
 {
 	stack_t stack = ((stack_t) { .ss_flags	= 0,

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
