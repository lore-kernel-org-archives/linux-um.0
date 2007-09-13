Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IVvV1-0005s1-DC for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 13 Sep 2007 13:41:19 -0700
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1IVvUz-0007yG-OO
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 13 Sep 2007 13:41:19 -0700
Date: Thu, 13 Sep 2007 16:41:11 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20070913204111.GA9986@c2.user-mode-linux.org>
Mime-Version: 1.0
Content-Disposition: inline
Subject: [uml-devel] [PATCH 2/3] UML - Remove called-once function
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

init_irq_signals doesn't need to be called from the context of a new
process.  It initializes handlers, which are useless in process
context.  With that call gone, init_irq_signals has only one caller,
so it can be inlined into init_new_thread_signals.

Index: linux-2.6.22/arch/um/include/os.h
===================================================================
--- linux-2.6.22.orig/arch/um/include/os.h	2007-09-12 16:45:28.000000000 -0400
+++ linux-2.6.22/arch/um/include/os.h	2007-09-13 10:46:34.000000000 -0400
@@ -299,7 +299,6 @@ extern void os_free_irq_later(struct irq
 extern int os_get_pollfd(int i);
 extern void os_set_pollfd(int i, int fd);
 extern void os_set_ioignore(void);
-extern void init_irq_signals(int on_sigstack);
 
 /* sigio.c */
 extern int add_sigio_fd(int fd);
Index: linux-2.6.22/arch/um/os-Linux/irq.c
===================================================================
--- linux-2.6.22.orig/arch/um/os-Linux/irq.c	2007-09-12 16:44:34.000000000 -0400
+++ linux-2.6.22/arch/um/os-Linux/irq.c	2007-09-13 10:47:13.000000000 -0400
@@ -138,14 +138,3 @@ void os_set_ioignore(void)
 {
 	signal(SIGIO, SIG_IGN);
 }
-
-void init_irq_signals(int on_sigstack)
-{
-	int flags;
-
-	flags = on_sigstack ? SA_ONSTACK : 0;
-
-	set_handler(SIGIO, (__sighandler_t) sig_handler, flags | SA_RESTART,
-		    SIGUSR1, SIGIO, SIGWINCH, SIGVTALRM, -1);
-	signal(SIGWINCH, SIG_IGN);
-}
Index: linux-2.6.22/arch/um/os-Linux/process.c
===================================================================
--- linux-2.6.22.orig/arch/um/os-Linux/process.c	2007-09-12 16:44:34.000000000 -0400
+++ linux-2.6.22/arch/um/os-Linux/process.c	2007-09-13 10:46:34.000000000 -0400
@@ -249,7 +249,10 @@ void init_new_thread_signals(void)
 		    SIGUSR1, SIGIO, SIGWINCH, SIGVTALRM, -1);
 	signal(SIGHUP, SIG_IGN);
 
-	init_irq_signals(1);
+	set_handler(SIGIO, (__sighandler_t) sig_handler,
+		    SA_ONSTACK | SA_RESTART, SIGUSR1, SIGIO, SIGWINCH, SIGALRM,
+		    SIGVTALRM, -1);
+	signal(SIGWINCH, SIG_IGN);
 }
 
 int run_kernel_thread(int (*fn)(void *), void *arg, jmp_buf **jmp_ptr)
Index: linux-2.6.22/arch/um/os-Linux/skas/process.c
===================================================================
--- linux-2.6.22.orig/arch/um/os-Linux/skas/process.c	2007-09-13 10:45:15.000000000 -0400
+++ linux-2.6.22/arch/um/os-Linux/skas/process.c	2007-09-13 10:46:34.000000000 -0400
@@ -177,7 +177,6 @@ static int userspace_tramp(void *stack)
 
 	ptrace(PTRACE_TRACEME, 0, 0, 0);
 
-	init_new_thread_signals();
 	err = set_interval();
 	if (err)
 		panic("userspace_tramp - setting timer failed, errno = %d\n",

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
