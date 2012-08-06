Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <renzo@cs.unibo.it>) id 1SyPeH-0002DI-Rz
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 06 Aug 2012 15:55:17 +0000
Received: from leb.cs.unibo.it ([130.136.1.102])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1SyPeD-0004k5-1L
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 06 Aug 2012 15:55:17 +0000
Date: Mon, 6 Aug 2012 17:37:28 +0200
From: Renzo Davoli <renzo@cs.unibo.it>
Message-ID: <20120806153728.GC25078@cs.unibo.it>
MIME-Version: 1.0
Content-Disposition: inline
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
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
Subject: [uml-devel] [patch] 3.6rc1 tracehook
To: user-mode-linux-devel@lists.sourceforge.net

Dear uml-developers,

I have seen that in 3.6 rc1 the management of ptrace has been changed:
the functions in arch/um/kernel/ptrace.c now call the tracehooks.

I have seen that the return value of tracehook_report_syscall_entry has not
been taken into account. 
(the return value should not be ignored, the header in 
include/linux/tracehook.h says:
  static inline __must_check int tracehook_report_syscall_entry
)
In the other architectures when tracehook_report_syscall_entry
returns a nonzero value (1) it means that the syscall must be skipped.

The patch here attached adds this behavior for ARCH=um.
(I have also deleted the definition of syscall_trace from
arch/um/include/shared/kern_util.h because the function does not
exist any more).

renzo

Signed-off-by: renzo davoli <renzo@cs.unibo.it>

---
diff -Naur linux-3.6-rc1/arch/um/include/asm/ptrace-generic.h linux-3.6-rc1.tracehook/arch/um/include/asm/ptrace-generic.h
--- linux-3.6-rc1/arch/um/include/asm/ptrace-generic.h	2012-08-03 01:38:10.000000000 +0200
+++ linux-3.6-rc1.tracehook/arch/um/include/asm/ptrace-generic.h	2012-08-06 14:43:01.000000000 +0200
@@ -37,7 +37,7 @@
 
 extern int arch_copy_tls(struct task_struct *new);
 extern void clear_flushed_tls(struct task_struct *task);
-extern void syscall_trace_enter(struct pt_regs *regs);
+extern int syscall_trace_enter(struct pt_regs *regs);
 extern void syscall_trace_leave(struct pt_regs *regs);
 
 #endif
diff -Naur linux-3.6-rc1/arch/um/include/shared/kern_util.h linux-3.6-rc1.tracehook/arch/um/include/shared/kern_util.h
--- linux-3.6-rc1/arch/um/include/shared/kern_util.h	2012-08-03 01:38:10.000000000 +0200
+++ linux-3.6-rc1.tracehook/arch/um/include/shared/kern_util.h	2012-08-06 14:43:40.000000000 +0200
@@ -57,7 +57,6 @@
 extern unsigned long to_irq_stack(unsigned long *mask_out);
 extern unsigned long from_irq_stack(int nested);
 
-extern void syscall_trace(struct uml_pt_regs *regs, int entryexit);
 extern int singlestepping(void *t);
 
 extern void segv_handler(int sig, struct siginfo *unused_si, struct uml_pt_regs *regs);
diff -Naur linux-3.6-rc1/arch/um/kernel/ptrace.c linux-3.6-rc1.tracehook/arch/um/kernel/ptrace.c
--- linux-3.6-rc1/arch/um/kernel/ptrace.c	2012-08-03 01:38:10.000000000 +0200
+++ linux-3.6-rc1.tracehook/arch/um/kernel/ptrace.c	2012-08-06 14:45:07.000000000 +0200
@@ -163,7 +163,7 @@
  * XXX Check PT_DTRACE vs TIF_SINGLESTEP for singlestepping check and
  * PT_PTRACED vs TIF_SYSCALL_TRACE for syscall tracing check
  */
-void syscall_trace_enter(struct pt_regs *regs)
+int syscall_trace_enter(struct pt_regs *regs)
 {
 	audit_syscall_entry(HOST_AUDIT_ARCH,
 			    UPT_SYSCALL_NR(&regs->regs),
@@ -173,9 +173,9 @@
 			    UPT_SYSCALL_ARG4(&regs->regs));
 
 	if (!test_thread_flag(TIF_SYSCALL_TRACE))
-		return;
+		return 0;
 
-	tracehook_report_syscall_entry(regs);
+	return tracehook_report_syscall_entry(regs);
 }
 
 void syscall_trace_leave(struct pt_regs *regs)
diff -Naur linux-3.6-rc1/arch/um/kernel/skas/syscall.c linux-3.6-rc1.tracehook/arch/um/kernel/skas/syscall.c
--- linux-3.6-rc1/arch/um/kernel/skas/syscall.c	2012-08-03 01:38:10.000000000 +0200
+++ linux-3.6-rc1.tracehook/arch/um/kernel/skas/syscall.c	2012-08-06 14:46:35.000000000 +0200
@@ -18,23 +18,24 @@
 	long result;
 	int syscall;
 
-	syscall_trace_enter(regs);
+	if (syscall_trace_enter(regs) == 0)
+	{
+		/*
+		 * This should go in the declaration of syscall, but when I do that,
+		 * strace -f -c bash -c 'ls ; ls' breaks, sometimes not tracing
+		 * children at all, sometimes hanging when bash doesn't see the first
+		 * ls exit.
+		 * The assembly looks functionally the same to me.  This is
+		 *     gcc version 4.0.1 20050727 (Red Hat 4.0.1-5)
+		 * in case it's a compiler bug.
+		 */
+		syscall = UPT_SYSCALL_NR(r);
+		if ((syscall >= NR_SYSCALLS) || (syscall < 0))
+			result = -ENOSYS;
+		else result = EXECUTE_SYSCALL(syscall, regs);
 
-	/*
-	 * This should go in the declaration of syscall, but when I do that,
-	 * strace -f -c bash -c 'ls ; ls' breaks, sometimes not tracing
-	 * children at all, sometimes hanging when bash doesn't see the first
-	 * ls exit.
-	 * The assembly looks functionally the same to me.  This is
-	 *     gcc version 4.0.1 20050727 (Red Hat 4.0.1-5)
-	 * in case it's a compiler bug.
-	 */
-	syscall = UPT_SYSCALL_NR(r);
-	if ((syscall >= NR_SYSCALLS) || (syscall < 0))
-		result = -ENOSYS;
-	else result = EXECUTE_SYSCALL(syscall, regs);
-
-	PT_REGS_SET_SYSCALL_RETURN(regs, result);
+		PT_REGS_SET_SYSCALL_RETURN(regs, result);
+	}
 
 	syscall_trace_leave(regs);
 }

------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

