Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KcfVf-0005iF-F7 for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 08 Sep 2008 05:06:25 -0700
Received: from mtagate7.de.ibm.com ([195.212.29.156])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1KcfVd-0000US-Lj
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 08 Sep 2008 05:06:22 -0700
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate7.de.ibm.com (8.13.8/8.13.8) with ESMTP id m88C67PY290858
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Mon, 8 Sep 2008 12:06:07 GMT
Received: from d12av04.megacenter.de.ibm.com (d12av04.megacenter.de.ibm.com
	[9.149.165.229])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.8/8.13.8/NCO v9.1) with
	ESMTP id m88C67xl3137736
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Mon, 8 Sep 2008 14:06:07 +0200
Received: from d12av04.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av04.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id m88C63D8029894 for <user-mode-linux-devel@lists.sourceforge.net>;
	Mon, 8 Sep 2008 14:06:04 +0200
Message-ID: <48C51439.7000706@linux.vnet.ibm.com>
Date: Mon, 08 Sep 2008 14:02:01 +0200
From: Pierre Morel <pmorel@linux.vnet.ibm.com>
MIME-Version: 1.0
Subject: [uml-devel] [PATCH 1/1] system call notification with self_ptrace
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
To: Andrew Morton <akpm@linux-foundation.org>
Cc: sameske@linux.vnet.ibm.com, uml-devel <user-mode-linux-devel@lists.sourceforge.net>, gregkh@suse.de, Heiko Carstens <heicars2@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org, Dave Hansen <dave@linux.vnet.ibm.com>, Daniel Lezcano <dlezcano@fr.ibm.com>, Cedric Le Goater <clg@fr.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Ingo Molnar <mingo@elte.hu>, Oleg Nesterov <oleg@tv-sign.ru>, Roland McGrath <roland@redhat.com>

Subject: [PATCH] system call notification with self_ptrace

From: Pierre Morel <pmorel@fr.ibm.com>


PTRACE SELF

This patch adds a new functionality to ptrace: system call notification to
the current process.
When a process requests self ptrace, with the new request PTRACE_SELF_ON:

 1.  the next system call performed by the process will not be executed
 2.  self ptrace will be disabled for the process
 3.  a SIGSYS signal will be sent to the process.

With an appropriate SIGSYS signal handler, the process can access its own
data structures to

 1.  get the system call number from the siginfo structure
 2.  get the system call arguments from the stack
 3.  instrument the system call with other system calls
 4.  emulate the system call with other system calls
 5.  change the arguments of the system call
 6.  perform the system call for good
 7.  change the return value of the system call
 8.  request self ptrace again before returning.

The new request PTRACE_SELF_OFF disables self ptrace.


Signed-off-by: Pierre Morel <pmorel@fr.ibm.com>
Signed-off-by: Volker Sameske <sameske@de.ibm.com>
---

 arch/s390/kernel/ptrace.c     |   16 ++++++++++++++++
 arch/s390/kernel/signal.c     |    5 +++++
 arch/x86/kernel/ptrace.c      |   29 +++++++++++++++++++++++++++++
 arch/x86/kernel/signal_32.c   |    5 +++++
 arch/x86/kernel/signal_64.c   |    5 +++++
 include/asm-generic/siginfo.h |    6 ++++++
 include/linux/ptrace.h        |   18 ++++++++++++++++++
 include/linux/sched.h         |    1 +
 kernel/ptrace.c               |   32 ++++++++++++++++++++++++++++++++
 9 files changed, 117 insertions(+)

Index: linux-2.6.26/arch/s390/kernel/ptrace.c
===================================================================
--- linux-2.6.26.orig/arch/s390/kernel/ptrace.c
+++ linux-2.6.26/arch/s390/kernel/ptrace.c
@@ -583,6 +583,22 @@ syscall_trace(struct pt_regs *regs, int 

 	if (!test_thread_flag(TIF_SYSCALL_TRACE))
 		goto out;
+
+	if (is_self_ptracing(regs->gprs[2])) {
+		if (!entryexit) {
+			struct siginfo info;
+
+			memset(&info, 0, sizeof(struct siginfo));
+			info.si_signo = SIGSYS;
+			info.si_code = SYS_SYSCALL;
+			info.si_errno = regs->gprs[2];
+			info.si_addr = (void *)regs->orig_gpr2;
+			send_sig_info(SIGSYS, &info, current);
+			regs->gprs[2] = -1;
+		}
+		return;
+	}
+
 	if (!(current->ptrace & PT_PTRACED))
 		goto out;
 	ptrace_notify(SIGTRAP | ((current->ptrace & PT_TRACESYSGOOD)
Index: linux-2.6.26/arch/s390/kernel/signal.c
===================================================================
--- linux-2.6.26.orig/arch/s390/kernel/signal.c
+++ linux-2.6.26/arch/s390/kernel/signal.c
@@ -409,6 +409,11 @@ handle_signal(unsigned long sig, struct 
 		spin_unlock_irq(&current->sighand->siglock);
 	}

+	if (current->instrumentation) {
+		clear_thread_flag(TIF_SYSCALL_TRACE);
+		current->instrumentation &= ~PTS_SELF;
+	}
+
 	return ret;
 }

Index: linux-2.6.26/arch/x86/kernel/ptrace.c
===================================================================
--- linux-2.6.26.orig/arch/x86/kernel/ptrace.c
+++ linux-2.6.26/arch/x86/kernel/ptrace.c
@@ -1394,6 +1394,19 @@ int do_syscall_trace(struct pt_regs *reg
 	if (!entryexit)
 		secure_computing(regs->orig_ax);

+	if (is_self_ptracing(regs->orig_ax)) {
+		if (!entryexit) {
+			struct siginfo info;
+
+			memset(&info, 0, sizeof(struct siginfo));
+			info.si_signo = SIGSYS;
+			info.si_code = SYS_SYSCALL;
+			info.si_addr = (void *) regs->orig_ax;
+			send_sig_info(SIGSYS, &info, current);
+		}
+		return 1; /* Skip system call, deliver signal. */
+	}
+
 	if (unlikely(current->audit_context)) {
 		if (entryexit)
 			audit_syscall_exit(AUDITSC_RESULT(regs->ax),
@@ -1486,6 +1499,18 @@ asmlinkage void syscall_trace_enter(stru
 	/* do the secure computing check first */
 	secure_computing(regs->orig_ax);

+	if (is_self_ptracing(regs->orig_ax)) {
+		struct siginfo info;
+
+		memset(&info, 0, sizeof(struct siginfo));
+		info.si_signo = SIGSYS;
+		info.si_code = SYS_SYSCALL;
+		info.si_addr = (void *) regs->orig_ax;
+		send_sig_info(SIGSYS, &info, current);
+		regs->ax = -1 ;
+		return; /* Skip system call, deliver signal. */
+	}
+
 	if (test_thread_flag(TIF_SYSCALL_TRACE)
 	    && (current->ptrace & PT_PTRACED))
 		syscall_trace(regs);
@@ -1507,6 +1532,10 @@ asmlinkage void syscall_trace_enter(stru

 asmlinkage void syscall_trace_leave(struct pt_regs *regs)
 {
+	if (is_self_ptracing(regs->orig_ax)) {
+		regs->ax = -1 ;
+		return; /* Skip system call. */
+	}
 	if (unlikely(current->audit_context))
 		audit_syscall_exit(AUDITSC_RESULT(regs->ax), regs->ax);

Index: linux-2.6.26/arch/x86/kernel/signal_32.c
===================================================================
--- linux-2.6.26.orig/arch/x86/kernel/signal_32.c
+++ linux-2.6.26/arch/x86/kernel/signal_32.c
@@ -568,6 +568,11 @@ handle_signal(unsigned long sig, siginfo
 	recalc_sigpending();
 	spin_unlock_irq(&current->sighand->siglock);

+	if (current->instrumentation & PTS_SELF) {
+		clear_thread_flag(TIF_SYSCALL_TRACE);
+		current->instrumentation &= ~PTS_SELF;
+	}
+
 	return 0;
 }

Index: linux-2.6.26/arch/x86/kernel/signal_64.c
===================================================================
--- linux-2.6.26.orig/arch/x86/kernel/signal_64.c
+++ linux-2.6.26/arch/x86/kernel/signal_64.c
@@ -402,6 +402,11 @@ handle_signal(unsigned long sig, siginfo
 		spin_unlock_irq(&current->sighand->siglock);
 	}

+	if (current->instrumentation & PTS_SELF) {
+		clear_thread_flag(TIF_SYSCALL_TRACE);
+		current->instrumentation &= ~PTS_SELF;
+	}
+
 	return ret;
 }

Index: linux-2.6.26/include/asm-generic/siginfo.h
===================================================================
--- linux-2.6.26.orig/include/asm-generic/siginfo.h
+++ linux-2.6.26/include/asm-generic/siginfo.h
@@ -224,6 +224,12 @@ typedef struct siginfo {
 #define NSIGPOLL	6

 /*
+ * SIGSYS si_codes
+ */
+#define SYS_SYSCALL    (__SI_FAULT|1)  /* system call notification */
+#define NSIGSYS        1
+
+/*
  * sigevent definitions
  * 
  * It seems likely that SIGEV_THREAD will have to be handled from 
Index: linux-2.6.26/include/linux/ptrace.h
===================================================================
--- linux-2.6.26.orig/include/linux/ptrace.h
+++ linux-2.6.26/include/linux/ptrace.h
@@ -27,6 +27,10 @@
 #define PTRACE_GETSIGINFO	0x4202
 #define PTRACE_SETSIGINFO	0x4203

+/* PTRACE SELF requests					*/
+#define PTRACE_SELF_ON		0x4281
+#define PTRACE_SELF_OFF		0x4282
+
 /* options set using PTRACE_SETOPTIONS */
 #define PTRACE_O_TRACESYSGOOD	0x00000001
 #define PTRACE_O_TRACEFORK	0x00000002
@@ -78,7 +82,21 @@

 #include <linux/compiler.h>		/* For unlikely.  */
 #include <linux/sched.h>		/* For struct task_struct.  */
+#include <linux/unistd.h>		/* For syscall definitions  */
+
+#define PTS_INSTRUMENTED	0x00000001
+#define PTS_SELF	0x00000002

+static inline int is_self_ptracing(unsigned long syscall)
+{
+	if (!(current->instrumentation & PTS_SELF))
+		return 0;
+	if (syscall == __NR_rt_sigreturn)
+		return 0;
+	if (syscall == __NR_ptrace)
+		return 0;
+	return 1;
+}

 extern long arch_ptrace(struct task_struct *child, long request, long addr, long data);
 extern struct task_struct *ptrace_get_task_struct(pid_t pid);
Index: linux-2.6.26/kernel/ptrace.c
===================================================================
--- linux-2.6.26.orig/kernel/ptrace.c
+++ linux-2.6.26/kernel/ptrace.c
@@ -543,6 +543,38 @@ asmlinkage long sys_ptrace(long request,
 	 * This lock_kernel fixes a subtle race with suid exec
 	 */
 	lock_kernel();
+	if (request == PTRACE_SELF_ON) {
+		task_lock(current);
+		if (current->ptrace) {
+			task_unlock(current);
+			ret = -EPERM;
+			goto out;
+		}
+		set_thread_flag(TIF_SYSCALL_TRACE);
+		current->instrumentation |= PTS_INSTRUMENTED|PTS_SELF;
+		task_unlock(current);
+		ret = 0;
+		goto out;
+	}
+	if (request == PTRACE_SELF_OFF) {
+		task_lock(current);
+		if (current->ptrace) {
+			task_unlock(current);
+			ret = -EPERM;
+			goto out;
+		}
+		clear_thread_flag(TIF_SYSCALL_TRACE);
+		current->instrumentation &= ~PTS_SELF;
+		task_unlock(current);
+		ret = 0;
+		goto out;
+	}
+
+	if (current->instrumentation) {
+		ret = -EPERM;
+		goto out;
+	}
+
 	if (request == PTRACE_TRACEME) {
 		ret = ptrace_traceme();
 		if (!ret)
Index: linux-2.6.26/include/linux/sched.h
===================================================================
--- linux-2.6.26.orig/include/linux/sched.h
+++ linux-2.6.26/include/linux/sched.h
@@ -1303,6 +1303,7 @@ struct task_struct {
 	int latency_record_count;
 	struct latency_record latency_record[LT_SAVECOUNT];
 #endif
+	u64	instrumentation;
 };

 /*



-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
