Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Crxln-0000dL-4U for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 21 Jan 2005 04:20:07 -0800
Received: from hirsch.in-berlin.de ([192.109.42.6] ident=root)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41) id 1Crxll-0001uz-9S
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 21 Jan 2005 04:20:07 -0800
Received: from hirsch.in-berlin.de (localhost [127.0.0.1])
	by hirsch.in-berlin.de (8.13.2/8.13.2/Debian-1) with ESMTP id
	j0LCK1rj030434 for <user-mode-linux-devel@lists.sourceforge.net>;
	Fri, 21 Jan 2005 13:20:01 +0100
Received: (from uucp@localhost)
	by hirsch.in-berlin.de (8.13.2/8.13.2/Submit) with UUCP id
	j0LCK1H0030424 for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 21 Jan 2005 13:20:01 +0100
Received: from bytesex.org (localhost [127.0.0.1])
	by bytesex.org (8.12.10/8.12.10/SuSE Linux 0.7) with ESMTP id
	j0LCFWHs023362 for <user-mode-linux-devel@lists.sourceforge.net>;
	Fri, 21 Jan 2005 13:15:32 +0100
Received: (from kraxel@localhost)
	by bytesex.org (8.12.10/8.12.10/Submit) id j0LCFWNx023361
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 21 Jan 2005 13:15:32 +0100
From: Gerd Knorr <kraxel@bytesex.org>
Message-ID: <20050121121532.GA22707@bytesex>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [uml-devel] 2.6.11-rc1 ...
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
Date: Fri, 21 Jan 2005 13:15:32 +0100
To: uml devel <user-mode-linux-devel@lists.sourceforge.net>

  Hi,

Anyone looked at 2.6.11-rc1 for the host?  Some more ptrace cleanups
happened there, and one of the changes conflicts with the sysemu code in
the skas-v7 patch for 2.6.10.  To me it's not clear how to solve that
conflict as I'm not familier with the sysemu stuff and how these tree
trace flags (syscall, sysemu, singlestep) play together ...

The conflicting changeset is attached below for reference.  There are
also some more ptrace changes (for singlestep) which might need fixups
in sysemu.

  Gerd

# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2005/01/01 12:24:01-08:00 torvalds@evo.osdl.org 
#   x86: common send_sigtrap helper for debug event SIGTRAP's,
#   and use that for system call single-step events.
#   
#   This one also gets the user mode test right, and makes sure
#   the siginfo is not leaking any stack contents.
# 
# include/asm-i386/ptrace.h
#   2005/01/01 12:23:50-08:00 torvalds@evo.osdl.org +2 -0
#   x86: common send_sigtrap helper for debug event SIGTRAP's,
#   and use that for system call single-step events.
#   
#   This one also gets the user mode test right, and makes sure
#   the siginfo is not leaking any stack contents.
# 
# arch/i386/kernel/traps.c
#   2005/01/01 12:23:50-08:00 torvalds@evo.osdl.org +1 -13
#   x86: common send_sigtrap helper for debug event SIGTRAP's,
#   and use that for system call single-step events.
#   
#   This one also gets the user mode test right, and makes sure
#   the siginfo is not leaking any stack contents.
# 
# arch/i386/kernel/ptrace.c
#   2005/01/01 12:23:50-08:00 torvalds@evo.osdl.org +27 -5
#   x86: common send_sigtrap helper for debug event SIGTRAP's,
#   and use that for system call single-step events.
#   
#   This one also gets the user mode test right, and makes sure
#   the siginfo is not leaking any stack contents.
# 
diff -Nru a/arch/i386/kernel/ptrace.c b/arch/i386/kernel/ptrace.c
--- a/arch/i386/kernel/ptrace.c	2005-01-21 12:08:33 +01:00
+++ b/arch/i386/kernel/ptrace.c	2005-01-21 12:08:33 +01:00
@@ -553,6 +553,24 @@
 	return ret;
 }
 
+void send_sigtrap(struct task_struct *tsk, struct pt_regs *regs, int error_code)
+{
+	struct siginfo info;
+
+	tsk->thread.trap_no = 1;
+	tsk->thread.error_code = error_code;
+
+	memset(&info, 0, sizeof(info));
+	info.si_signo = SIGTRAP;
+	info.si_code = TRAP_BRKPT;
+
+	/* User-mode eip? */
+	info.si_addr = user_mode(regs) ? (void __user *) regs->eip : NULL;
+
+	/* Send us the fakey SIGTRAP */
+	force_sig_info(SIGTRAP, &info, tsk);
+}
+
 /* notification of system call entry/exit
  * - triggered by current->work.syscall_trace
  */
@@ -568,15 +586,19 @@
 			audit_syscall_exit(current, regs->eax);
 	}
 
-	if (!test_thread_flag(TIF_SYSCALL_TRACE) &&
-	    !test_thread_flag(TIF_SINGLESTEP))
-		return;
 	if (!(current->ptrace & PT_PTRACED))
 		return;
+
+	/* Fake a debug trap */
+	if (test_thread_flag(TIF_SINGLESTEP))
+		send_sigtrap(current, regs, 0);
+
+	if (!test_thread_flag(TIF_SYSCALL_TRACE))
+		return;
+
 	/* the 0x80 provides a way for the tracing parent to distinguish
 	   between a syscall stop and SIGTRAP delivery */
-	ptrace_notify(SIGTRAP | ((current->ptrace & PT_TRACESYSGOOD) &&
-				 !test_thread_flag(TIF_SINGLESTEP) ? 0x80 : 0));
+	ptrace_notify(SIGTRAP | ((current->ptrace & PT_TRACESYSGOOD) ? 0x80 : 0));
 
 	/*
 	 * this isn't the same as continuing with a signal, but it will do
diff -Nru a/arch/i386/kernel/traps.c b/arch/i386/kernel/traps.c
--- a/arch/i386/kernel/traps.c	2005-01-21 12:08:33 +01:00
+++ b/arch/i386/kernel/traps.c	2005-01-21 12:08:33 +01:00
@@ -682,7 +682,6 @@
 {
 	unsigned int condition;
 	struct task_struct *tsk = current;
-	siginfo_t info;
 
 	__asm__ __volatile__("movl %%db6,%0" : "=r" (condition));
 
@@ -723,18 +722,7 @@
 	}
 
 	/* Ok, finally something we can handle */
-	tsk->thread.trap_no = 1;
-	tsk->thread.error_code = error_code;
-	info.si_signo = SIGTRAP;
-	info.si_errno = 0;
-	info.si_code = TRAP_BRKPT;
-	
-	/* If this is a kernel mode trap, save the user PC on entry to 
-	 * the kernel, that's what the debugger can make sense of.
-	 */
-	info.si_addr = ((regs->xcs & 3) == 0) ? (void __user *)tsk->thread.eip
-	                                      : (void __user *)regs->eip;
-	force_sig_info(SIGTRAP, &info, tsk);
+	send_sigtrap(tsk, regs, error_code);
 
 	/* Disable additional traps. They'll be re-enabled when
 	 * the signal is delivered.
diff -Nru a/include/asm-i386/ptrace.h b/include/asm-i386/ptrace.h
--- a/include/asm-i386/ptrace.h	2005-01-21 12:08:33 +01:00
+++ b/include/asm-i386/ptrace.h	2005-01-21 12:08:33 +01:00
@@ -55,6 +55,8 @@
 #define PTRACE_SET_THREAD_AREA    26
 
 #ifdef __KERNEL__
+struct task_struct;
+extern void send_sigtrap(struct task_struct *tsk, struct pt_regs *regs, int error_code);
 #define user_mode(regs) ((VM_MASK & (regs)->eflags) || (3 & (regs)->xcs))
 #define instruction_pointer(regs) ((regs)->eip)
 #if defined(CONFIG_SMP) && defined(CONFIG_FRAME_POINTER)


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
