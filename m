Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AB14D12D77
	for <linux-um@archiver.kernel.org>; Mon, 11 Nov 2024 06:28:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=meRC4zEq37TyfhrYFoYjU8XELa8Mik0M7wCNHRqMtao=; b=g6Fo1JRw0HEDjrjy6aYPmF7+j0
	bPYS+HUwV+Br7hFe7137ZL9eAP6GzV6xTAlIgIWR3W1/FV4PVoe+5VD6jgjYbsAckUfrokiHV0kju
	MLCxJEZ//BIvoxFQmVHsNFGCfcAQLe9O9lcWlGAMna3/vzm+eumW5XAPGrtNOrnuDdtfvahHRqiD9
	RETSS09t/z6WBj/EeBNAPX+iFdWyEcJkOX40zHnWExV0W42cTNbJRwdYA3tRgHzmOT5FDA/5k16YS
	oaV4HMMHeJuVzuK1alv0lVCz5ddv+np5zOzPga56PCPLa1ql7aNENjc7EbACgh5VhPm6n/oltPtLU
	YTIupJ9g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tANuW-0000000GUGP-3zvy;
	Mon, 11 Nov 2024 06:28:28 +0000
Received: from mail-ot1-x330.google.com ([2607:f8b0:4864:20::330])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tANuT-0000000GUFt-2UQx
	for linux-um@lists.infradead.org;
	Mon, 11 Nov 2024 06:28:27 +0000
Received: by mail-ot1-x330.google.com with SMTP id 46e09a7af769-7180c7a4e02so2342029a34.0
        for <linux-um@lists.infradead.org>; Sun, 10 Nov 2024 22:28:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731306505; x=1731911305; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=meRC4zEq37TyfhrYFoYjU8XELa8Mik0M7wCNHRqMtao=;
        b=QXKrnmmW8Q6Z+4qjnr+tE9mE5gNAMwfiRwxT6gXBtQotgrR7XlBXXBushPOH9JBUe+
         jJCRsScgf9f155gB9ENt26q8Aco+E/TN8cAv60gR2GjfEQLiKnGqoevISWC/kFoLrswp
         3QbZ7xbuwyp3XnPXPh4Vido6mAPW1P+aMIIv7ginr7wQtFeW+ewQ3Jt1/hMknRUI+fZN
         w3OXAaulFbw91IKl4Zcq+HFu7UZYC2/2vXpp3zXhZQOIcRCjFuSXtzp/gBfdhidVT0/B
         VZHlhMFx5X2yM98xyqYWTlAJ52Y+n+FJ/Q3pyM+6CPXI57NWkzIg5IejCABUehpXtU1S
         1nTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731306505; x=1731911305;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=meRC4zEq37TyfhrYFoYjU8XELa8Mik0M7wCNHRqMtao=;
        b=GcHmxuNZ0VBkmZDmh/KlyULPNjO84JrtPYMt8A9ReuoQvzkZwWXNsO9z463772EPxW
         OxVz2uAozaA2oLu6XAZgNFL61jSAPeSJJ6FHabHZz32JLlWQ06yBF/aBRuu3+JNmZ6lR
         fuKTlT/aWbm+v330G8qr773RHxPGfXkPH3785ivIP2GA/Qca3qP82hQzwMdOkL2WTrQb
         RTXllelGPT7PiFw2upnQeBXDj6gSRKkojkxMvk6JYXSdl1pyXaxRU3oO+GqFrVrds1ko
         7T3fdFTmnY46SBaoNWSFJueTLC+8yzNv5n+x3GyAe4Xq02JIKtkRUv0eONAQouoRQW5n
         67uA==
X-Gm-Message-State: AOJu0YwB4CP2tBOD9ykwbgfDPeuMpngnoOTyZNIbg9iJTi3TO9cELcFJ
	L/hmB6Pq+0/pxLAwqAbL5GGLNvSyDqyQcUVzXTViOtppA9L/WG+HjskqVg==
X-Google-Smtp-Source: AGHT+IFLWxCd/FMsBpjE11NSml9TLL9peHSbfnNhDxS/95o6zyeoYcyqG1EnAyAzazUCGpz9ZJKOHg==
X-Received: by 2002:a05:6830:2a87:b0:718:ad8a:e2ce with SMTP id 46e09a7af769-71a1c24a724mr8805877a34.17.1731306504611;
        Sun, 10 Nov 2024 22:28:24 -0800 (PST)
Received: from ikb-h07-29-noble.in.iijlab.net ([202.214.97.5])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7f41f5c26a6sm7845568a12.30.2024.11.10.22.28.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Nov 2024 22:28:23 -0800 (PST)
Received: by ikb-h07-29-noble.in.iijlab.net (Postfix, from userid 1010)
	id 0B399DBA920; Mon, 11 Nov 2024 15:28:22 +0900 (JST)
From: Hajime Tazaki <thehajime@gmail.com>
To: linux-um@lists.infradead.org
Cc: thehajime@gmail.com,
	ricarkol@google.com,
	Liam.Howlett@oracle.com
Subject: [RFC PATCH v2 07/13] x86/um: nommu: process/thread handling
Date: Mon, 11 Nov 2024 15:27:07 +0900
Message-ID: <3c850be9ec2a50b1de7d42b0649f254fe8472527.1731290567.git.thehajime@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1731290567.git.thehajime@gmail.com>
References: <cover.1731290567.git.thehajime@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241110_222825_662662_10EA8832 
X-CRM114-Status: GOOD (  22.82  )
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
index 56e7e525fc91..b3708dceb731 100644
--- a/arch/um/kernel/process.c
+++ b/arch/um/kernel/process.c
@@ -116,13 +116,17 @@ void new_thread_handler(void)
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
@@ -133,6 +137,33 @@ static void fork_handler(void)
 
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
index ed3d99301dc8..5acf6d41a4c2 100644
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
index f683cfc9e51a..291136008431 100644
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
+#endif /* UML_CONFIG_MMU */
 
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
index a1189ddb2b50..203bacc4cb3c 100644
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
@@ -34,4 +66,8 @@ __visible void do_syscall_64(struct pt_regs *regs)
 	/* execve succeeded */
 	if (syscall == __NR_execve && regs->regs.gp[HOST_AX] == 0)
 		userspace(&current->thread.regs.regs);
+
+	/* only parents of vfork restores the contents of stack */
+	if (syscall == __NR_vfork && regs->regs.gp[HOST_AX] > 0)
+		vfork_restore_stack(stack_copy);
 }
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


