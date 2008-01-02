Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JA9tX-0005WH-L8 for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 02 Jan 2008 12:08:56 -0800
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1JA9tW-0001Yz-Kf
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 02 Jan 2008 12:08:55 -0800
Date: Wed, 2 Jan 2008 15:08:52 -0500
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20080102200852.GA7944@c2.user-mode-linux.org>
Mime-Version: 1.0
Content-Disposition: inline
Subject: [uml-devel] [PATCH 2/7] UML - Remove current_thread
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

Tidy current-related stuff.  There was a comment in current.h saying
that current_thread was obsolete, so this patch turns all instances of
current_thread into current_thread_info().  There's some simplifying
of the result in arch/um/sys-i386/signal.c.

current.h and thread_info.h also get style cleanups.

Signed-off-by: Jeff Dike <jdike@linux.intel.com>
---
 arch/um/kernel/process.c     |    8 ++++----
 arch/um/sys-i386/signal.c    |   18 ++++++++----------
 arch/um/sys-x86_64/signal.c  |    4 ++--
 include/asm-um/current.h     |   23 ++---------------------
 include/asm-um/thread_info.h |    8 ++++----
 5 files changed, 20 insertions(+), 41 deletions(-)

Index: linux-2.6/arch/um/kernel/process.c
===================================================================
--- linux-2.6.orig/arch/um/kernel/process.c	2007-11-20 11:28:00.000000000 -0500
+++ linux-2.6/arch/um/kernel/process.c	2007-11-20 11:54:11.000000000 -0500
@@ -251,7 +251,7 @@ void default_idle(void)
 
 void cpu_idle(void)
 {
-	cpu_tasks[current_thread->cpu].pid = os_getpid();
+	cpu_tasks[current_thread_info()->cpu].pid = os_getpid();
 	default_idle();
 }
 
@@ -269,7 +269,7 @@ int user_context(unsigned long sp)
 	unsigned long stack;
 
 	stack = sp & (PAGE_MASK << CONFIG_KERNEL_STACK_ORDER);
-	return stack != (unsigned long) current_thread;
+	return stack != (unsigned long) current_thread_info();
 }
 
 extern exitcall_t __uml_exitcall_begin, __uml_exitcall_end;
@@ -311,7 +311,7 @@ int strlen_user_proc(char __user *str)
 int smp_sigio_handler(void)
 {
 #ifdef CONFIG_SMP
-	int cpu = current_thread->cpu;
+	int cpu = current_thread_info()->cpu;
 	IPI_handler(cpu);
 	if (cpu != 0)
 		return 1;
@@ -321,7 +321,7 @@ int smp_sigio_handler(void)
 
 int cpu(void)
 {
-	return current_thread->cpu;
+	return current_thread_info()->cpu;
 }
 
 static atomic_t using_sysemu = ATOMIC_INIT(0);
Index: linux-2.6/arch/um/sys-i386/signal.c
===================================================================
--- linux-2.6.orig/arch/um/sys-i386/signal.c	2007-11-20 11:22:34.000000000 -0500
+++ linux-2.6/arch/um/sys-i386/signal.c	2007-11-20 11:54:11.000000000 -0500
@@ -168,12 +168,13 @@ static int copy_sc_from_user(struct pt_r
 			     struct sigcontext __user *from)
 {
 	struct sigcontext sc;
-	int err;
+	int err, pid;
 
 	err = copy_from_user(&sc, from, sizeof(sc));
 	if (err)
 		return err;
 
+	pid = userspace_pid[current_thread_info()->cpu];
 	copy_sc(&regs->regs, &sc);
 	if (have_fpx_regs) {
 		struct user_fxsr_struct fpx;
@@ -187,8 +188,7 @@ static int copy_sc_from_user(struct pt_r
 		if (err)
 			return 1;
 
-		err = restore_fpx_registers(userspace_pid[current_thread->cpu],
-					    (unsigned long *) &fpx);
+		err = restore_fpx_registers(pid, (unsigned long *) &fpx);
 		if (err < 0) {
 			printk(KERN_ERR "copy_sc_from_user - "
 			       "restore_fpx_registers failed, errno = %d\n",
@@ -204,8 +204,7 @@ static int copy_sc_from_user(struct pt_r
 		if (err)
 			return 1;
 
-		err = restore_fp_registers(userspace_pid[current_thread->cpu],
-					   (unsigned long *) &fp);
+		err = restore_fp_registers(pid, (unsigned long *) &fp);
 		if (err < 0) {
 			printk(KERN_ERR "copy_sc_from_user - "
 			       "restore_fp_registers failed, errno = %d\n",
@@ -223,7 +222,7 @@ static int copy_sc_to_user(struct sigcon
 {
 	struct sigcontext sc;
 	struct faultinfo * fi = &current->thread.arch.faultinfo;
-	int err;
+	int err, pid;
 
 	sc.gs = REGS_GS(regs->regs.gp);
 	sc.fs = REGS_FS(regs->regs.gp);
@@ -249,11 +248,11 @@ static int copy_sc_to_user(struct sigcon
 	to_fp = (to_fp ? to_fp : (struct _fpstate __user *) (to + 1));
 	sc.fpstate = to_fp;
 
+	pid = userspace_pid[current_thread_info()->cpu];
 	if (have_fpx_regs) {
 		struct user_fxsr_struct fpx;
 
-		err = save_fpx_registers(userspace_pid[current_thread->cpu],
-					 (unsigned long *) &fpx);
+		err = save_fpx_registers(pid, (unsigned long *) &fpx);
 		if (err < 0){
 			printk(KERN_ERR "copy_sc_to_user - save_fpx_registers "
 			       "failed, errno = %d\n", err);
@@ -276,8 +275,7 @@ static int copy_sc_to_user(struct sigcon
 	else {
 		struct user_i387_struct fp;
 
-		err = save_fp_registers(userspace_pid[current_thread->cpu],
-					(unsigned long *) &fp);
+		err = save_fp_registers(pid, (unsigned long *) &fp);
 		if (copy_to_user(to_fp, &fp, sizeof(struct user_i387_struct)))
 			return 1;
 	}
Index: linux-2.6/arch/um/sys-x86_64/signal.c
===================================================================
--- linux-2.6.orig/arch/um/sys-x86_64/signal.c	2007-11-20 11:22:34.000000000 -0500
+++ linux-2.6/arch/um/sys-x86_64/signal.c	2007-11-20 11:54:11.000000000 -0500
@@ -81,7 +81,7 @@ static int copy_sc_from_user(struct pt_r
 	if (err)
 		return 1;
 
-	err = restore_fp_registers(userspace_pid[current_thread->cpu],
+	err = restore_fp_registers(userspace_pid[current_thread_info()->cpu],
 				   (unsigned long *) &fp);
 	if (err < 0) {
 		printk(KERN_ERR "copy_sc_from_user - "
@@ -143,7 +143,7 @@ static int copy_sc_to_user(struct sigcon
 	if (err)
 		return 1;
 
-	err = save_fp_registers(userspace_pid[current_thread->cpu],
+	err = save_fp_registers(userspace_pid[current_thread_info()->cpu],
 				(unsigned long *) &fp);
 	if (err < 0) {
 		printk(KERN_ERR "copy_sc_from_user - restore_fp_registers "
Index: linux-2.6/include/asm-um/current.h
===================================================================
--- linux-2.6.orig/include/asm-um/current.h	2007-11-20 11:22:34.000000000 -0500
+++ linux-2.6/include/asm-um/current.h	2007-11-20 11:54:11.000000000 -0500
@@ -1,32 +1,13 @@
-/* 
- * Copyright (C) 2000 Jeff Dike (jdike@karaya.com)
+/*
+ * Copyright (C) 2000 - 2007 Jeff Dike (jdike@{addtoit,linux.intel}.com)
  * Licensed under the GPL
  */
 
 #ifndef __UM_CURRENT_H
 #define __UM_CURRENT_H
 
-#ifndef __ASSEMBLY__
-
-#include "asm/page.h"
 #include "linux/thread_info.h"
 
 #define current (current_thread_info()->task)
 
-/*Backward compatibility - it's used inside arch/um.*/
-#define current_thread current_thread_info()
-
-#endif /* __ASSEMBLY__ */
-
 #endif
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
Index: linux-2.6/include/asm-um/thread_info.h
===================================================================
--- linux-2.6.orig/include/asm-um/thread_info.h	2007-11-20 11:28:00.000000000 -0500
+++ linux-2.6/include/asm-um/thread_info.h	2007-11-20 11:54:11.000000000 -0500
@@ -1,5 +1,5 @@
-/* 
- * Copyright (C) 2002 Jeff Dike (jdike@karaya.com)
+/*
+ * Copyright (C) 2002 - 2007 Jeff Dike (jdike@{addtoit,linux.intel}.com)
  * Licensed under the GPL
  */
 
@@ -76,8 +76,8 @@ static inline struct thread_info *curren
 #define TIF_SYSCALL_TRACE	0	/* syscall trace active */
 #define TIF_SIGPENDING		1	/* signal pending */
 #define TIF_NEED_RESCHED	2	/* rescheduling necessary */
-#define TIF_POLLING_NRFLAG      3       /* true if poll_idle() is polling 
-					 * TIF_NEED_RESCHED 
+#define TIF_POLLING_NRFLAG      3       /* true if poll_idle() is polling
+					 * TIF_NEED_RESCHED
 					 */
 #define TIF_RESTART_BLOCK 	4
 #define TIF_MEMDIE	 	5

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
