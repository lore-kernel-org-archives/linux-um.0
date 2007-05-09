Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Hlspx-0008K7-C0 for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 09 May 2007 13:32:37 -0700
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1Hlspu-0003VY-37
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 09 May 2007 13:32:37 -0700
Date: Wed, 9 May 2007 16:27:21 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20070509202721.GA22454@c2.user-mode-linux.org>
Mime-Version: 1.0
Content-Disposition: inline
Subject: [uml-devel] [PATCH 3/6] UML - Tidy IRQ code
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
To: Andrew Morton <akpm@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>

Some tidying of the irq code before introducing irq stacks.  Mostly
style fixes, but the timer handler calls the timer code directly
rather than going through the generic sig_handler_common_skas.

Signed-off-by: Jeff Dike <jdike@linux.intel.com>
--
 arch/um/kernel/init_task.c      |   11 -----------
 arch/um/kernel/irq.c            |    4 ++--
 arch/um/os-Linux/signal.c       |   10 +++++++---
 arch/um/os-Linux/skas/process.c |    6 ++++--
 4 files changed, 13 insertions(+), 18 deletions(-)

Index: linux-2.6.21-mm/arch/um/kernel/init_task.c
===================================================================
--- linux-2.6.21-mm.orig/arch/um/kernel/init_task.c	2007-05-07 14:52:28.000000000 -0400
+++ linux-2.6.21-mm/arch/um/kernel/init_task.c	2007-05-07 14:56:24.000000000 -0400
@@ -46,14 +46,3 @@ void unprotect_stack(unsigned long stack
 {
 	os_protect_memory((void *) stack, THREAD_SIZE, 1, 1, 0);
 }
-
-/*
- * Overrides for Emacs so that we follow Linus's tabbing style.
- * Emacs will notice this stuff at the end of the file and automatically
- * adjust the settings for this buffer only.  This must remain at the end
- * of the file.
- * ---------------------------------------------------------------------------
- * Local variables:
- * c-file-style: "linux"
- * End:
- */
Index: linux-2.6.21-mm/arch/um/kernel/irq.c
===================================================================
--- linux-2.6.21-mm.orig/arch/um/kernel/irq.c	2007-05-07 14:52:28.000000000 -0400
+++ linux-2.6.21-mm/arch/um/kernel/irq.c	2007-05-07 14:56:24.000000000 -0400
@@ -1,4 +1,4 @@
-/* 
+/*
  * Copyright (C) 2000 Jeff Dike (jdike@karaya.com)
  * Licensed under the GPL
  * Derived (i.e. mostly copied) from arch/i386/kernel/irq.c:
@@ -53,7 +53,7 @@ int show_interrupts(struct seq_file *p, 
 	if (i < NR_IRQS) {
 		spin_lock_irqsave(&irq_desc[i].lock, flags);
 		action = irq_desc[i].action;
-		if (!action) 
+		if (!action)
 			goto skip;
 		seq_printf(p, "%3d: ",i);
 #ifndef CONFIG_SMP
Index: linux-2.6.21-mm/arch/um/os-Linux/signal.c
===================================================================
--- linux-2.6.21-mm.orig/arch/um/os-Linux/signal.c	2007-05-07 14:52:28.000000000 -0400
+++ linux-2.6.21-mm/arch/um/os-Linux/signal.c	2007-05-07 14:56:24.000000000 -0400
@@ -61,15 +61,19 @@ void sig_handler(int sig, struct sigcont
 
 static void real_alarm_handler(int sig, struct sigcontext *sc)
 {
+	union uml_pt_regs regs;
+
 	if(sig == SIGALRM)
 		switch_timers(0);
 
-	CHOOSE_MODE_PROC(sig_handler_common_tt, sig_handler_common_skas,
-			 sig, sc);
+	if(sc != NULL)
+		copy_sc(&regs, sc);
+	regs.skas.is_user = 0;
+	unblock_signals();
+	timer_handler(sig, &regs);
 
 	if(sig == SIGALRM)
 		switch_timers(1);
-
 }
 
 void alarm_handler(int sig, struct sigcontext *sc)
Index: linux-2.6.21-mm/arch/um/os-Linux/skas/process.c
===================================================================
--- linux-2.6.21-mm.orig/arch/um/os-Linux/skas/process.c	2007-05-07 14:52:28.000000000 -0400
+++ linux-2.6.21-mm/arch/um/os-Linux/skas/process.c	2007-05-07 14:56:24.000000000 -0400
@@ -288,7 +288,8 @@ int start_userspace(unsigned long stub_s
 void userspace(union uml_pt_regs *regs)
 {
 	int err, status, op, pid = userspace_pid[0];
-	int local_using_sysemu; /*To prevent races if using_sysemu changes under us.*/
+	/* To prevent races if using_sysemu changes under us.*/
+	int local_using_sysemu;
 
 	while(1){
 		restore_registers(pid, regs);
@@ -296,7 +297,8 @@ void userspace(union uml_pt_regs *regs)
 		/* Now we set local_using_sysemu to be used for one loop */
 		local_using_sysemu = get_using_sysemu();
 
-		op = SELECT_PTRACE_OPERATION(local_using_sysemu, singlestepping(NULL));
+		op = SELECT_PTRACE_OPERATION(local_using_sysemu,
+					     singlestepping(NULL));
 
 		err = ptrace(op, pid, 0, 0);
 		if(err)

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
