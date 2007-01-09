Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1H46SO-0006ew-Tu for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 08 Jan 2007 18:11:21 -0800
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1H46SM-0000zH-A9
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 08 Jan 2007 18:11:20 -0800
Message-Id: <200701090205.l0925mTc024396@ccure.user-mode-linux.org>
Mime-Version: 1.0
Date: Mon, 08 Jan 2007 21:05:48 -0500
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] [PATCH 5/7] UML - Make signal handlers static
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

A bunch of the signal handlers can be made static.

Signed-off-by: Jeff Dike <jdike@addtoit.com>
--
 arch/um/include/kern_util.h |    4 ----
 arch/um/kernel/trap.c       |   28 ++++++++++++++--------------
 2 files changed, 14 insertions(+), 18 deletions(-)

Index: linux-2.6.18-mm/arch/um/include/kern_util.h
===================================================================
--- linux-2.6.18-mm.orig/arch/um/include/kern_util.h	2007-01-08 16:29:07.000000000 -0500
+++ linux-2.6.18-mm/arch/um/include/kern_util.h	2007-01-08 16:39:59.000000000 -0500
@@ -87,7 +87,6 @@ extern void timer_irq(union uml_pt_regs 
 extern void unprotect_stack(unsigned long stack);
 extern void do_uml_exitcalls(void);
 extern int attach_debugger(int idle_pid, int pid, int stop);
-extern void bad_segv(struct faultinfo fi, unsigned long ip);
 extern int config_gdb(char *str);
 extern int remove_gdb(void);
 extern char *uml_strdup(char *string);
@@ -103,8 +102,6 @@ extern int clear_user_proc(void *buf, in
 extern int copy_to_user_proc(void *to, void *from, int size);
 extern int copy_from_user_proc(void *to, void *from, int size);
 extern int strlen_user_proc(char *str);
-extern void bus_handler(int sig, union uml_pt_regs *regs);
-extern void winch(int sig, union uml_pt_regs *regs);
 extern long execute_syscall(void *r);
 extern int smp_sigio_handler(void);
 extern void *get_current(void);
@@ -119,7 +116,6 @@ extern void time_init_kern(void);
 
 /* Are we disallowed to sleep? Used to choose between GFP_KERNEL and GFP_ATOMIC. */
 extern int __cant_sleep(void);
-extern void segv_handler(int sig, union uml_pt_regs *regs);
 extern void sigio_handler(int sig, union uml_pt_regs *regs);
 
 #endif
Index: linux-2.6.18-mm/arch/um/kernel/trap.c
===================================================================
--- linux-2.6.18-mm.orig/arch/um/kernel/trap.c	2007-01-08 16:15:33.000000000 -0500
+++ linux-2.6.18-mm/arch/um/kernel/trap.c	2007-01-08 16:41:18.000000000 -0500
@@ -128,7 +128,18 @@ out_of_memory:
 	goto out;
 }
 
-void segv_handler(int sig, union uml_pt_regs *regs)
+static void bad_segv(struct faultinfo fi, unsigned long ip)
+{
+	struct siginfo si;
+
+	si.si_signo = SIGSEGV;
+	si.si_code = SEGV_ACCERR;
+	si.si_addr = (void __user *) FAULT_ADDRESS(fi);
+	current->thread.arch.faultinfo = fi;
+	force_sig_info(SIGSEGV, &si, current);
+}
+
+static void segv_handler(int sig, union uml_pt_regs *regs)
 {
 	struct faultinfo * fi = UPT_FAULTINFO(regs);
 
@@ -205,17 +216,6 @@ unsigned long segv(struct faultinfo fi, 
 	return(0);
 }
 
-void bad_segv(struct faultinfo fi, unsigned long ip)
-{
-	struct siginfo si;
-
-	si.si_signo = SIGSEGV;
-	si.si_code = SEGV_ACCERR;
-	si.si_addr = (void __user *) FAULT_ADDRESS(fi);
-	current->thread.arch.faultinfo = fi;
-	force_sig_info(SIGSEGV, &si, current);
-}
-
 void relay_signal(int sig, union uml_pt_regs *regs)
 {
 	if(arch_handle_signal(sig, regs))
@@ -232,14 +232,14 @@ void relay_signal(int sig, union uml_pt_
 	force_sig(sig, current);
 }
 
-void bus_handler(int sig, union uml_pt_regs *regs)
+static void bus_handler(int sig, union uml_pt_regs *regs)
 {
 	if(current->thread.fault_catcher != NULL)
 		do_longjmp(current->thread.fault_catcher, 1);
 	else relay_signal(sig, regs);
 }
 
-void winch(int sig, union uml_pt_regs *regs)
+static void winch(int sig, union uml_pt_regs *regs)
 {
 	do_IRQ(WINCH_IRQ, regs);
 }


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
