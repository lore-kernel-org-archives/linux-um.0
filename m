Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 334E9E6C5FB
	for <linux-um@archiver.kernel.org>; Tue,  3 Dec 2024 04:23:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vQGavwe9DxKBzUXwTk+JNQqc8DEOpWpnDYhGRs05zig=; b=wf/l/O11YKMATJt++XB1XQr8I1
	qS9kE1B4ir/EBzGPNMrNdby6/XNtsBDutLGCbM9mQ5bYDPEGaRyzWhruNUjDrhGVbMO9IN0a4fOMt
	gjnGTFwAA8sY49U9HYYIXBfe55wmj/8LUfTfYPQP+hJ+lsfrqUmrRgUSe74W06+ENZbC2XhdfTFPx
	syPVp0YeEvA08dmJkeB0dk+Pq+lNb0CUqlUxVtvRdgDzlRPrmb0BAU9tsRp4iZI4i5w7vovCz19id
	crLXPf8AmDroHlHeSarZXVXtYPDpCgahQGN2Nk9tt0gVixSvea003XWSVsbedny9etgtYfrC6EUuZ
	llWWu+wQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tIKRz-00000008DRC-42Cl;
	Tue, 03 Dec 2024 04:23:51 +0000
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tIKRx-00000008DPi-1fyt
	for linux-um@lists.infradead.org;
	Tue, 03 Dec 2024 04:23:50 +0000
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-215b4681c94so6491495ad.0
        for <linux-um@lists.infradead.org>; Mon, 02 Dec 2024 20:23:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733199828; x=1733804628; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vQGavwe9DxKBzUXwTk+JNQqc8DEOpWpnDYhGRs05zig=;
        b=IHIVv2uObMOnOg2hV9iiw6/9UoQeP47pWgHaA0YxOcx0YybmahBd10Fe/oyNbpvZ3w
         DSk46lofobT0OsbjQLTGicw3mEFSzb1OGR9SSDaLkPOcY3kQJ0lIthAaDEYkbXPRjx6V
         +U3HfK3gxgdGNjvMePvJpwtsrt145ajAdYVlo3PcsuiGQ/ioa7ho/Io/0Ksaw0HwVvz4
         JBtSMHemQDg0KUs2jt3KfLygEVu02p56v2JxHnNzcWP6KdkP9tiTe6aG2/9QPZjW2kIR
         ZDowP00ZYF0Y3DeU0WDEMVR4yBIwXIaOinbeaw2U2qXejbMtbplPbX5ez+Q4fn8tZUTx
         voLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733199828; x=1733804628;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vQGavwe9DxKBzUXwTk+JNQqc8DEOpWpnDYhGRs05zig=;
        b=P7a2QVcZ0gxrW73kGEm4E9nFqSdo/imsmTjmWiKfXOkBdLRP43LU0hxVgADBUrSCu/
         VoxkmZaMFkbsEs2bDOhcH7DRtEq0v6piuWYN0nf1zQJ7VxGjR9wLH8Us5j3uMcFmN/md
         gpsXyARheu1ylp7C4XcjUqgqZTtWmtlwr7VkNzBBV/fFKwwuW2Q71qkUIhR0XiqyxwD5
         Oa8yLnmk6jiSGOs+r3g3mXlkArxjsVQdSHhz1RbCvWUT+KNhQAfDRmIzEGVuYEtrkd4+
         qCddTS3/KeCc0WQIGK90BU5xJH4M5DMN6s8hDZ/LT7pvRLyAKh8GlkoW3OYezilWrdUE
         QPSg==
X-Gm-Message-State: AOJu0Yy+yL4N84hP1rZOyPhdQJTM4597RPuJjEO71uLJ7e2lJby8vo9Y
	Um12JhvFKtH5kKcpVb2KZhlqnoZvjy3N4ZNJhbd+8wIL7DgNee7dWqWUtA==
X-Gm-Gg: ASbGncuJxbNbkPlds3UxVTn1chBlMnnywKiw4Js0aVpuofC9w64W5bEWNzZrLhZM5et
	JSIHBM8h42Ng9UGsqg6+Zc/s7oEjq5zFnoM2GvcgFc0bZJU3vvlTMHau+fqH/UuRFPnW8Qei0xq
	HCmqil2JPVKYgnjlIMiPkInGupjiZ9HoLjSD9b3IFVXuHTo7LR2DFjghlp3oiExy50bJAj4yTS4
	ywqZL5Fy2PVErwGCl8gqziXuKqul9efJD95hDoK9hVbLPuufhhtXEWcegq9rZ/aPsphqFEphS8d
	EvkMaXUDGBpFMalsc1w3
X-Google-Smtp-Source: AGHT+IG0p6SmsMGlju7AwApfhh6pNKtJqguhCDFKzHE1G0OMj/khohP46XeiJIN5rXSzOf3KPYwq3Q==
X-Received: by 2002:a17:902:d4c3:b0:215:72a7:f38c with SMTP id d9443c01a7336-215bd0eea49mr15528975ad.25.1733199828228;
        Mon, 02 Dec 2024 20:23:48 -0800 (PST)
Received: from ikb-h07-29-noble.in.iijlab.net ([202.214.97.5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2157597c2f6sm37941805ad.204.2024.12.02.20.23.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 20:23:47 -0800 (PST)
Received: by ikb-h07-29-noble.in.iijlab.net (Postfix, from userid 1010)
	id 48AE3DD3A05; Tue,  3 Dec 2024 13:23:45 +0900 (JST)
From: Hajime Tazaki <thehajime@gmail.com>
To: linux-um@lists.infradead.org
Cc: thehajime@gmail.com,
	ricarkol@google.com,
	Liam.Howlett@oracle.com
Subject: [PATCH v3 07/13] x86/um: nommu: process/thread handling
Date: Tue,  3 Dec 2024 13:23:06 +0900
Message-ID: <7e909114324f92d37dbe0a2f58443cf5ba606c6d.1733199769.git.thehajime@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1733199769.git.thehajime@gmail.com>
References: <cover.1733199769.git.thehajime@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241202_202349_439252_D1C6134D 
X-CRM114-Status: GOOD (  22.92  )
X-BeenThere: linux-um@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

Since ptrace facility isn't used under !MMU of UML, there is different
code path to invoke processes/threads; on an entry to the syscall
interface, the stack pointer should be manipulated to handle vfork(2)
return address, no external process is used, and need to properly
configure some of registers (fs segment register for TLS, etc) on every
context switch, etc.

Signals aren't delivered in non-ptrace syscall entry/leave so, we also
need to handle pending signal by ourselves.

Signed-off-by: Hajime Tazaki <thehajime@gmail.com>
Signed-off-by: Ricardo Koller <ricarkol@google.com>
---
 arch/um/kernel/process.c        | 33 +++++++++++++++++++++++++++++-
 arch/um/os-Linux/process.c      |  6 ++++++
 arch/um/os-Linux/skas/process.c |  4 ++++
 arch/x86/um/asm/processor.h     | 12 +++++++++++
 arch/x86/um/do_syscall_64.c     | 36 +++++++++++++++++++++++++++++++++
 arch/x86/um/entry_64.S          | 21 +++++++++++++++++++
 arch/x86/um/syscalls_64.c       | 12 +++++++++++
 7 files changed, 123 insertions(+), 1 deletion(-)

diff --git a/arch/um/kernel/process.c b/arch/um/kernel/process.c
index 30bdc0a87dc8..865f3456f24b 100644
--- a/arch/um/kernel/process.c
+++ b/arch/um/kernel/process.c
@@ -117,13 +117,17 @@ void new_thread_handler(void)
 	 * callback returns only if the kernel thread execs a process
 	 */
 	fn(arg);
+#ifndef CONFIG_MMU
+	arch_switch_to(current);
+#endif
 	userspace(&current->thread.regs.regs);
 }
 
 /* Called magically, see new_thread_handler above */
 static void fork_handler(void)
 {
-	schedule_tail(current->thread.prev_sched);
+	if (current->thread.prev_sched)
+		schedule_tail(current->thread.prev_sched);
 
 	/*
 	 * XXX: if interrupt_end() calls schedule, this call to
@@ -134,6 +138,33 @@ static void fork_handler(void)
 
 	current->thread.prev_sched = NULL;
 
+#ifndef CONFIG_MMU
+	/*
+	 * child of vfork(2) comes here.
+	 * clone(2) also enters here but doesn't need to advance the %rsp.
+	 *
+	 * This fork can only come from libc's vfork, which
+	 * does this:
+	 *	popq %%rdx;
+	 *	call *%rax; // zpoline => __kernel_vsyscall
+	 *	pushq %%rdx;
+	 * %rcx stores the return address which is stored
+	 * at pt_regs[HOST_IP] at the moment.  As child returns
+	 * via userspace() with a jmp instruction (while parent
+	 * does via ret instruction in __kernel_vsyscall), we
+	 * need to pop (advance) the pushed address by "call"
+	 * though, so this is what this next line does.
+	 *
+	 * As a result of vfork return in child, stack contents
+	 * is overwritten by child (by pushq in vfork), which
+	 * makes the parent puzzled after child returns.
+	 *
+	 * thus the contents should be restored before vfork/parent
+	 * returns.  this is done in do_syscall_64().
+	 */
+	if (current->thread.regs.regs.gp[HOST_ORIG_AX] == __NR_vfork)
+		current->thread.regs.regs.gp[REGS_SP_INDEX] += 8;
+#endif
 	userspace(&current->thread.regs.regs);
 }
 
diff --git a/arch/um/os-Linux/process.c b/arch/um/os-Linux/process.c
index 4e0b21b4b00c..51473b834497 100644
--- a/arch/um/os-Linux/process.c
+++ b/arch/um/os-Linux/process.c
@@ -25,7 +25,10 @@
 
 void os_alarm_process(int pid)
 {
+/* !CONFIG_MMU doesn't send alarm signal to other processes */
+#ifdef CONFIG_MMU
 	kill(pid, SIGALRM);
+#endif
 }
 
 void os_kill_process(int pid, int reap_child)
@@ -42,11 +45,14 @@ void os_kill_process(int pid, int reap_child)
 
 void os_kill_ptraced_process(int pid, int reap_child)
 {
+/* !CONFIG_MMU doesn't have ptraced process */
+#ifdef CONFIG_MMU
 	kill(pid, SIGKILL);
 	ptrace(PTRACE_KILL, pid);
 	ptrace(PTRACE_CONT, pid);
 	if (reap_child)
 		CATCH_EINTR(waitpid(pid, NULL, __WALL));
+#endif
 }
 
 /* Don't use the glibc version, which caches the result in TLS. It misses some
diff --git a/arch/um/os-Linux/skas/process.c b/arch/um/os-Linux/skas/process.c
index f683cfc9e51a..80776bac168b 100644
--- a/arch/um/os-Linux/skas/process.c
+++ b/arch/um/os-Linux/skas/process.c
@@ -144,6 +144,7 @@ void wait_stub_done(int pid)
 
 extern unsigned long current_stub_stack(void);
 
+#ifdef CONFIG_MMU
 static void get_skas_faultinfo(int pid, struct faultinfo *fi)
 {
 	int err;
@@ -176,6 +177,7 @@ static void handle_trap(int pid, struct uml_pt_regs *regs)
 
 	handle_syscall(regs);
 }
+#endif
 
 extern char __syscall_stub_start[];
 
@@ -389,6 +391,7 @@ int start_userspace(unsigned long stub_stack)
 }
 
 int unscheduled_userspace_iterations;
+#ifdef CONFIG_MMU
 extern unsigned long tt_extra_sched_jiffies;
 
 void userspace(struct uml_pt_regs *regs)
@@ -550,6 +553,7 @@ void userspace(struct uml_pt_regs *regs)
 		}
 	}
 }
+#endif
 
 void new_thread(void *stack, jmp_buf *buf, void (*handler)(void))
 {
diff --git a/arch/x86/um/asm/processor.h b/arch/x86/um/asm/processor.h
index 478710384b34..d88d7d9d5c18 100644
--- a/arch/x86/um/asm/processor.h
+++ b/arch/x86/um/asm/processor.h
@@ -38,6 +38,18 @@ static __always_inline void cpu_relax(void)
 
 #define task_pt_regs(t) (&(t)->thread.regs)
 
+#ifndef CONFIG_MMU
+#define task_top_of_stack(task) \
+({									\
+	unsigned long __ptr = (unsigned long)task->stack;	\
+	__ptr += THREAD_SIZE;			\
+	__ptr;					\
+})
+
+extern long current_top_of_stack;
+extern long current_ptregs;
+#endif
+
 #include <asm/processor-generic.h>
 
 #endif
diff --git a/arch/x86/um/do_syscall_64.c b/arch/x86/um/do_syscall_64.c
index 5d0fa83e7fdc..ca468caff729 100644
--- a/arch/x86/um/do_syscall_64.c
+++ b/arch/x86/um/do_syscall_64.c
@@ -1,14 +1,43 @@
 // SPDX-License-Identifier: GPL-2.0
 
+//#define DEBUG 1
 #include <linux/kernel.h>
 #include <linux/ptrace.h>
 #include <kern_util.h>
 #include <sysdep/syscalls.h>
 #include <os.h>
 
+/*
+ * save/restore the return address stored in the stack, as the child overwrites
+ * the contents after returning to userspace (i.e., by push %rdx).
+ *
+ * see the detail in fork_handler().
+ */
+static void *vfork_save_stack(void)
+{
+	unsigned char *stack_copy;
+
+	stack_copy = kzalloc(8, GFP_KERNEL);
+	if (!stack_copy)
+		return NULL;
+
+	memcpy(stack_copy,
+	       (void *)current->thread.regs.regs.gp[HOST_SP], 8);
+
+	return stack_copy;
+}
+
+static void vfork_restore_stack(void *stack_copy)
+{
+	WARN_ON_ONCE(!stack_copy);
+	memcpy((void *)current->thread.regs.regs.gp[HOST_SP],
+	       stack_copy, 8);
+}
+
 __visible void do_syscall_64(struct pt_regs *regs)
 {
 	int syscall;
+	unsigned char *stack_copy = NULL;
 
 	syscall = PT_SYSCALL_NR(regs->regs.gp);
 	UPT_SYSCALL_NR(&regs->regs) = syscall;
@@ -17,6 +46,9 @@ __visible void do_syscall_64(struct pt_regs *regs)
 		 syscall, (unsigned long)current,
 		 (unsigned long)sys_call_table[syscall]);
 
+	if (syscall == __NR_vfork)
+		stack_copy = vfork_save_stack();
+
 	if (likely(syscall < NR_syscalls)) {
 		PT_REGS_SET_SYSCALL_RETURN(regs,
 				EXECUTE_SYSCALL(syscall, regs));
@@ -31,6 +63,10 @@ __visible void do_syscall_64(struct pt_regs *regs)
 	if (syscall == __NR_execve && regs->regs.gp[HOST_AX] == 0)
 		userspace(&current->thread.regs.regs);
 
+	/* only parents of vfork restores the contents of stack */
+	if (syscall == __NR_vfork && regs->regs.gp[HOST_AX] > 0)
+		vfork_restore_stack(stack_copy);
+
 	/* force do_signal() --> is_syscall() */
 	set_thread_flag(TIF_SIGPENDING);
 	interrupt_end();
diff --git a/arch/x86/um/entry_64.S b/arch/x86/um/entry_64.S
index 022a8122690b..32f5002e2eb0 100644
--- a/arch/x86/um/entry_64.S
+++ b/arch/x86/um/entry_64.S
@@ -85,3 +85,24 @@ ENTRY(__kernel_vsyscall)
 	ret
 
 END(__kernel_vsyscall)
+
+// void userspace(struct uml_pt_regs *regs)
+ENTRY(userspace)
+	/* align the stack for x86_64 ABI */
+	and     $-0x10, %rsp
+	/* Handle any immediate reschedules or signals */
+	call	interrupt_end
+
+	movq	current_ptregs, %rsp
+
+	POP_REGS
+
+	addq	$8, %rsp	/* skip orig_ax */
+	popq	%r11		/* pt_regs->ip */
+	addq	$8, %rsp	/* skip cs */
+	addq	$8, %rsp	/* skip flags */
+	popq	%rsp
+
+	jmp	*%r11
+
+END(userspace)
diff --git a/arch/x86/um/syscalls_64.c b/arch/x86/um/syscalls_64.c
index 6a00a28c9cca..edb17fc73e07 100644
--- a/arch/x86/um/syscalls_64.c
+++ b/arch/x86/um/syscalls_64.c
@@ -51,6 +51,18 @@ void arch_switch_to(struct task_struct *to)
 	 * Nothing needs to be done on x86_64.
 	 * The FS_BASE/GS_BASE registers are saved in the ptrace register set.
 	 */
+#ifndef CONFIG_MMU
+	current_top_of_stack = task_top_of_stack(to);
+	current_ptregs = (long)task_pt_regs(to);
+
+	if ((to->thread.regs.regs.gp[FS_BASE / sizeof(unsigned long)] == 0) ||
+	    (to->mm == NULL))
+		return;
+
+	/* this changes the FS on every context switch */
+	arch_prctl(to, ARCH_SET_FS,
+		   (void __user *) to->thread.regs.regs.gp[FS_BASE / sizeof(unsigned long)]);
+#endif
 }
 
 SYSCALL_DEFINE6(mmap, unsigned long, addr, unsigned long, len,
-- 
2.43.0


