Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1C8zs6-0006b8-8Q for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 19 Sep 2004 04:28:46 -0700
Received: from mail-relay-1.tiscali.it ([213.205.33.41])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1C8zs5-0002kp-1z for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 19 Sep 2004 04:28:46 -0700
From: blaisorblade_spam@yahoo.it
Message-Id: <20040919100618.55FC6BABD@zion.localdomain>
Subject: [uml-devel] [patch 1/2] Ptrace: adds the host SYSEMU -v4 support,
	for UML and general usage
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
Date: Sun, 19 Sep 2004 12:06:18 +0200
To: jdike@addtoit.com
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, blaisorblade_spam@yahoo.it, LaurentVivier@wanadoo.fr


From: Laurent Vivier <LaurentVivier@wanadoo.fr>, Jeff Dike <jdike@addtoit.com>, Paolo 'Blaisorblade' Giarrusso <blaisorblade_spam@yahoo.it>
Adds a new ptrace(2) mode, called PTRACE_SYSEMU (or PTRACE_SYSEMU, this is yet
to decide properly), resembling PTRACE_SYSCALL except that the kernel does not
execute the requested syscall; this is useful for virtual environments, like
UML, which want to run the syscall on their own.

This patch includes some suggestions of Jeff Dike to avoid adding any
instructions to the syscall fast path, plus some other little changes, by
myself, to make it work even when the syscall is executed with SYSENTER (but
I'm unsure about them).

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade_spam@yahoo.it>
---

 vanilla-linux-2.6.8.1-paolo/arch/i386/kernel/entry.S       |    9 ++++--
 vanilla-linux-2.6.8.1-paolo/arch/i386/kernel/ptrace.c      |   18 ++++++++++---
 vanilla-linux-2.6.8.1-paolo/include/asm-i386/thread_info.h |    4 ++
 vanilla-linux-2.6.8.1-paolo/include/linux/ptrace.h         |    1 
 vanilla-linux-2.6.8.1-paolo/kernel/fork.c                  |    1 
 5 files changed, 25 insertions(+), 8 deletions(-)

diff -puN arch/i386/kernel/entry.S~host-sysemu-2.6.7-4 arch/i386/kernel/entry.S
--- vanilla-linux-2.6.8.1/arch/i386/kernel/entry.S~host-sysemu-2.6.7-4	2004-09-19 12:03:10.375074144 +0200
+++ vanilla-linux-2.6.8.1-paolo/arch/i386/kernel/entry.S	2004-09-19 12:03:10.409068976 +0200
@@ -258,7 +258,7 @@ sysenter_past_esp:
 	cmpl $(nr_syscalls), %eax
 	jae syscall_badsys
 
-	testb $(_TIF_SYSCALL_TRACE|_TIF_SYSCALL_AUDIT),TI_flags(%ebp)
+	testb $(_TIF_SYSCALL_EMU|_TIF_SYSCALL_TRACE|_TIF_SYSCALL_AUDIT),TI_flags(%ebp)
 	jnz syscall_trace_entry
 	call *sys_call_table(,%eax,4)
 	movl %eax,EAX(%esp)
@@ -280,8 +280,8 @@ ENTRY(system_call)
 	GET_THREAD_INFO(%ebp)
 	cmpl $(nr_syscalls), %eax
 	jae syscall_badsys
-					# system call tracing in operation
-	testb $(_TIF_SYSCALL_TRACE|_TIF_SYSCALL_AUDIT),TI_flags(%ebp)
+					# system call tracing in operation / emulation
+	testb $(_TIF_SYSCALL_EMU|_TIF_SYSCALL_TRACE|_TIF_SYSCALL_AUDIT),TI_flags(%ebp)
 	jnz syscall_trace_entry
 syscall_call:
 	call *sys_call_table(,%eax,4)
@@ -340,6 +340,9 @@ syscall_trace_entry:
 	movl %esp, %eax
 	xorl %edx,%edx
 	call do_syscall_trace
+	cmpl $0, %eax
+	jne syscall_exit		# ret != 0 -> running under PTRACE_SCEMU,
+					# so must skip actual syscall
 	movl ORIG_EAX(%esp), %eax
 	cmpl $(nr_syscalls), %eax
 	jnae syscall_call
diff -puN arch/i386/kernel/ptrace.c~host-sysemu-2.6.7-4 arch/i386/kernel/ptrace.c
--- vanilla-linux-2.6.8.1/arch/i386/kernel/ptrace.c~host-sysemu-2.6.7-4	2004-09-19 12:03:10.377073840 +0200
+++ vanilla-linux-2.6.8.1-paolo/arch/i386/kernel/ptrace.c	2004-09-19 12:03:10.409068976 +0200
@@ -358,6 +358,7 @@ asmlinkage int sys_ptrace(long request, 
 		  }
 		  break;
 
+	case PTRACE_SCEMU: /* continue and replace next syscall */
 	case PTRACE_SYSCALL: /* continue and stop at next (return from) syscall */
 	case PTRACE_CONT: { /* restart after signal. */
 		long tmp;
@@ -365,6 +366,12 @@ asmlinkage int sys_ptrace(long request, 
 		ret = -EIO;
 		if ((unsigned long) data > _NSIG)
 			break;
+		if (request == PTRACE_SCEMU) {
+			set_tsk_thread_flag(child, TIF_SYSCALL_EMU);
+		}
+		else {
+			clear_tsk_thread_flag(child, TIF_SYSCALL_EMU);
+		}
 		if (request == PTRACE_SYSCALL) {
 			set_tsk_thread_flag(child, TIF_SYSCALL_TRACE);
 		}
@@ -405,6 +412,7 @@ asmlinkage int sys_ptrace(long request, 
 		ret = -EIO;
 		if ((unsigned long) data > _NSIG)
 			break;
+		clear_tsk_thread_flag(child, TIF_SYSCALL_EMU);
 		clear_tsk_thread_flag(child, TIF_SYSCALL_TRACE);
 		if ((child->ptrace & PT_DTRACE) == 0) {
 			/* Spurious delayed TF traps may occur */
@@ -575,7 +583,7 @@ out:
  * - triggered by current->work.syscall_trace
  */
 __attribute__((regparm(3)))
-void do_syscall_trace(struct pt_regs *regs, int entryexit)
+int do_syscall_trace(struct pt_regs *regs, int entryexit)
 {
 	if (unlikely(current->audit_context)) {
 		if (!entryexit)
@@ -586,10 +594,10 @@ void do_syscall_trace(struct pt_regs *re
 			audit_syscall_exit(current, regs->eax);
 	}
 
-	if (!test_thread_flag(TIF_SYSCALL_TRACE))
-		return;
+	if (!test_thread_flag(TIF_SYSCALL_TRACE) && !test_thread_flag(TIF_SYSCALL_EMU))
+		return 0;
 	if (!(current->ptrace & PT_PTRACED))
-		return;
+		return 0;
 	/* the 0x80 provides a way for the tracing parent to distinguish
 	   between a syscall stop and SIGTRAP delivery */
 	ptrace_notify(SIGTRAP | ((current->ptrace & PT_TRACESYSGOOD)
@@ -604,4 +612,6 @@ void do_syscall_trace(struct pt_regs *re
 		send_sig(current->exit_code, current, 1);
 		current->exit_code = 0;
 	}
+	/* != 0 if nullifying the syscall, 0 if running it normally */
+	return test_thread_flag(TIF_SYSCALL_EMU);
 }
diff -puN include/asm-i386/thread_info.h~host-sysemu-2.6.7-4 include/asm-i386/thread_info.h
--- vanilla-linux-2.6.8.1/include/asm-i386/thread_info.h~host-sysemu-2.6.7-4	2004-09-19 12:03:10.377073840 +0200
+++ vanilla-linux-2.6.8.1-paolo/include/asm-i386/thread_info.h	2004-09-19 12:03:10.410068824 +0200
@@ -143,6 +143,7 @@ static inline unsigned long current_stac
 #define TIF_NEED_RESCHED	3	/* rescheduling necessary */
 #define TIF_SINGLESTEP		4	/* restore singlestep on return to user mode */
 #define TIF_IRET		5	/* return with iret */
+#define TIF_SYSCALL_EMU		6	/* syscall emulation active */
 #define TIF_SYSCALL_AUDIT	7	/* syscall auditing active */
 #define TIF_POLLING_NRFLAG	16	/* true if poll_idle() is polling TIF_NEED_RESCHED */
 
@@ -152,12 +153,13 @@ static inline unsigned long current_stac
 #define _TIF_NEED_RESCHED	(1<<TIF_NEED_RESCHED)
 #define _TIF_SINGLESTEP		(1<<TIF_SINGLESTEP)
 #define _TIF_IRET		(1<<TIF_IRET)
+#define _TIF_SYSCALL_EMU	(1<<TIF_SYSCALL_EMU)
 #define _TIF_SYSCALL_AUDIT	(1<<TIF_SYSCALL_AUDIT)
 #define _TIF_POLLING_NRFLAG	(1<<TIF_POLLING_NRFLAG)
 
 /* work to do on interrupt/exception return */
 #define _TIF_WORK_MASK \
-  (0x0000FFFF & ~(_TIF_SYSCALL_TRACE|_TIF_SYSCALL_AUDIT))
+  (0x0000FFFF & ~(_TIF_SYSCALL_TRACE|_TIF_SYSCALL_AUDIT|_TIF_SYSCALL_EMU))
 #define _TIF_ALLWORK_MASK	0x0000FFFF	/* work to do on any return to u-space */
 
 /*
diff -puN include/linux/ptrace.h~host-sysemu-2.6.7-4 include/linux/ptrace.h
--- vanilla-linux-2.6.8.1/include/linux/ptrace.h~host-sysemu-2.6.7-4	2004-09-19 12:03:10.378073688 +0200
+++ vanilla-linux-2.6.8.1-paolo/include/linux/ptrace.h	2004-09-19 12:03:10.410068824 +0200
@@ -20,6 +20,7 @@
 #define PTRACE_DETACH		0x11
 
 #define PTRACE_SYSCALL		  24
+#define PTRACE_SCEMU		  31
 
 /* 0x4200-0x4300 are reserved for architecture-independent additions.  */
 #define PTRACE_SETOPTIONS	0x4200
diff -puN kernel/fork.c~host-sysemu-2.6.7-4 kernel/fork.c
--- vanilla-linux-2.6.8.1/kernel/fork.c~host-sysemu-2.6.7-4	2004-09-19 12:03:10.379073536 +0200
+++ vanilla-linux-2.6.8.1-paolo/kernel/fork.c	2004-09-19 12:03:10.410068824 +0200
@@ -1008,6 +1008,7 @@ struct task_struct *copy_process(unsigne
 	 * of CLONE_PTRACE.
 	 */
 	clear_tsk_thread_flag(p, TIF_SYSCALL_TRACE);
+	clear_tsk_thread_flag(p, TIF_SYSCALL_EMU);
 
 	/* Our parent execution domain becomes current domain
 	   These must match for thread signalling to apply */
_


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
