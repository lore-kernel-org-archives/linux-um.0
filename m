Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1FyeHi-0006a3-W7 for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 06 Jul 2006 17:33:31 -0700
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1FyeHh-0000fc-GC
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 06 Jul 2006 17:33:30 -0700
Message-Id: <200607070033.k670Xevv008697@ccure.user-mode-linux.org>
Mime-Version: 1.0
Date: Thu, 06 Jul 2006 20:33:40 -0400
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] [PATCH 8/19] UML - ifdef a mode-specific function
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

uml_idle_timer is tt-mode only, so ifdef it as such to make it easier
to spot when tt mode is killed.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.17/arch/um/include/kern_util.h
===================================================================
--- linux-2.6.17.orig/arch/um/include/kern_util.h
+++ linux-2.6.17/arch/um/include/kern_util.h
@@ -72,7 +72,6 @@ extern void init_flush_vm(void);
 extern void *syscall_sp(void *t);
 extern void syscall_trace(union uml_pt_regs *regs, int entryexit);
 extern int hz(void);
-extern void uml_idle_timer(void);
 extern unsigned int do_IRQ(int irq, union uml_pt_regs *regs);
 extern int external_pid(void *t);
 extern void interrupt_end(void);
Index: linux-2.6.17/arch/um/os-Linux/time.c
===================================================================
--- linux-2.6.17.orig/arch/um/os-Linux/time.c
+++ linux-2.6.17/arch/um/os-Linux/time.c
@@ -66,6 +66,7 @@ void switch_timers(int to_real)
 		       errno);
 }
 
+#ifdef UML_CONFIG_MODE_TT
 void uml_idle_timer(void)
 {
 	if(signal(SIGVTALRM, SIG_IGN) == SIG_ERR)
@@ -75,6 +76,7 @@ void uml_idle_timer(void)
 		    SA_RESTART, SIGUSR1, SIGIO, SIGWINCH, SIGVTALRM, -1);
 	set_interval(ITIMER_REAL);
 }
+#endif
 
 unsigned long long os_nsecs(void)
 {


Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
