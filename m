Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CAwes-0003yq-4c for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 24 Sep 2004 13:27:10 -0700
Received: from [12.177.129.25] (helo=ccure.user-mode-linux.org)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.41) id 1CAwep-0008Gb-TO
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 24 Sep 2004 13:27:09 -0700
Message-Id: <200409242132.i8OLWNZX003930@ccure.user-mode-linux.org>
Subject: Re: [uml-devel] Minor problems with interrupted systemcalls 
In-Reply-To: Your message of "Wed, 22 Sep 2004 19:12:37 +0200."
	<8B6FF516CBA0194AB0996705076B02520F7C38@ABGEX01E.abg.fsc.net> 
References: <8B6FF516CBA0194AB0996705076B02520F7C38@ABGEX01E.abg.fsc.net> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Fri, 24 Sep 2004 17:32:23 -0400
To: "Stroesser, Bodo" <Bodo.Stroesser@fujitsu-siemens.com>
Cc: user-mode-linux-devel@lists.sourceforge.net, BlaisorBlade <blaisorblade_spam@yahoo.it>

OK, following is my breakup of your signal patch.  It all looks right to me,
and cleans up that code nicely.  Let me know if you see any problems here.

These are also available from the incremental patches page
	http://user-mode-linux.sourceforge.net/patches.html
and I would appreciate testing.

This one changes the do_signal interface to eliminate its argument.  Also,
remove the calls from the system call handlers since they are redundant.  In
all cases, pending signals are checked for in the interrupt handler.
Temporarily, do_signal passes the current error to kern_do_signal.

				Jeff

Index: 2.6.9-rc/arch/um/include/kern_util.h
===================================================================
--- 2.6.9-rc.orig/arch/um/include/kern_util.h	2004-09-24 12:58:02.000000000 -0400
+++ 2.6.9-rc/arch/um/include/kern_util.h	2004-09-24 14:10:16.000000000 -0400
@@ -29,7 +29,7 @@
 extern void syscall_segv(int sig);
 extern int current_pid(void);
 extern unsigned long alloc_stack(int order, int atomic);
-extern int do_signal(int error);
+extern int do_signal(void);
 extern int is_stack_fault(unsigned long sp);
 extern unsigned long segv(unsigned long address, unsigned long ip, 
 			  int is_write, int is_user, void *sc);
Index: 2.6.9-rc/arch/um/kernel/process_kern.c
===================================================================
--- 2.6.9-rc.orig/arch/um/kernel/process_kern.c	2004-09-24 13:05:44.000000000 -0400
+++ 2.6.9-rc/arch/um/kernel/process_kern.c	2004-09-24 16:17:07.000000000 -0400
@@ -139,7 +139,7 @@
 void interrupt_end(void)
 {
 	if(need_resched()) schedule();
-	if(test_tsk_thread_flag(current, TIF_SIGPENDING)) do_signal(0);
+	if(test_tsk_thread_flag(current, TIF_SIGPENDING)) do_signal();
 }
 
 void release_thread(struct task_struct *task)
Index: 2.6.9-rc/arch/um/kernel/signal_kern.c
===================================================================
--- 2.6.9-rc.orig/arch/um/kernel/signal_kern.c	2004-09-24 13:05:44.000000000 -0400
+++ 2.6.9-rc/arch/um/kernel/signal_kern.c	2004-09-24 16:04:00.000000000 -0400
@@ -163,9 +163,10 @@
 	return(0);
 }
 
-int do_signal(int error)
+int do_signal(void)
 {
-	return(kern_do_signal(&current->thread.regs, NULL, error));
+	return(kern_do_signal(&current->thread.regs, NULL,
+			      PT_REGS_SYSCALL_RET(&current->thread.regs)));
 }
 
 /*
Index: 2.6.9-rc/arch/um/kernel/skas/syscall_user.c
===================================================================
--- 2.6.9-rc.orig/arch/um/kernel/skas/syscall_user.c	2004-09-13 22:37:13.000000000 -0400
+++ 2.6.9-rc/arch/um/kernel/skas/syscall_user.c	2004-09-24 14:10:16.000000000 -0400
@@ -10,10 +10,6 @@
 #include "sysdep/ptrace.h"
 #include "sysdep/sigcontext.h"
 
-/* XXX Bogus */
-#define ERESTARTSYS	512
-#define ERESTARTNOINTR	513
-#define ERESTARTNOHAND	514
 
 void handle_syscall(union uml_pt_regs *regs)
 {
@@ -26,9 +22,6 @@
 	result = execute_syscall(regs);
 
 	REGS_SET_SYSCALL_RETURN(regs->skas.regs, result);
-	if((result == -ERESTARTNOHAND) || (result == -ERESTARTSYS) || 
-	   (result == -ERESTARTNOINTR))
-		do_signal(result);
 
 	syscall_trace(regs, 0);
 	record_syscall_end(index, result);
Index: 2.6.9-rc/arch/um/kernel/tt/syscall_user.c
===================================================================
--- 2.6.9-rc.orig/arch/um/kernel/tt/syscall_user.c	2004-09-13 22:37:13.000000000 -0400
+++ 2.6.9-rc/arch/um/kernel/tt/syscall_user.c	2004-09-24 16:04:02.000000000 -0400
@@ -17,10 +17,6 @@
 #include "syscall_user.h"
 #include "tt.h"
 
-/* XXX Bogus */
-#define ERESTARTSYS	512
-#define ERESTARTNOINTR	513
-#define ERESTARTNOHAND	514
 
 void syscall_handler_tt(int sig, union uml_pt_regs *regs)
 {
@@ -42,9 +38,6 @@
 	UPT_SC(regs) = sc;
 
 	SC_SET_SYSCALL_RETURN(sc, result);
-	if((result == -ERESTARTNOHAND) || (result == -ERESTARTSYS) || 
-	   (result == -ERESTARTNOINTR))
-		do_signal(result);
 
 	syscall_trace(regs, 0);
 	record_syscall_end(index, result);



-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
