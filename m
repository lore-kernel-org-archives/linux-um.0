Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C818BCE8E6F
	for <linux-um@archiver.kernel.org>; Thu, 24 Oct 2024 12:11:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OpT83Y9t1QnvPqILOaYReQujm77/DkJoRta+WWn6wAk=; b=lbifq3LlDcN5AufhljtNK2abdu
	Z0bbTbxf2bxuCJ1/omFulPHw2dBS9NDBWXSclhaeXWAHIq7OVrVPj+7aPH6GpKh1rVkyZlo9YCU43
	kKSW9BovXmPqEjRpLHuJgJKZOXqT/QIjr00ftwDlimoQCtdWXG96yZR/OE6kDAbGCp2NlZimxKP0b
	2PHGBqrwCWgMIG9HlxaYa4ULcvjd1iHD7dVj2mjUr0RpDjBGDKM+sPERPM13TSDd7FAFB5yeALuHo
	2RjLrW8IK5b/fy2mvi7o3lG6q4zNe0+DNolJgUOk7phonLirBc8sLgc1v0XNNn+jUi4AJCi5myrQD
	OFaXgrsA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t3wgU-00000000IqN-2CCe;
	Thu, 24 Oct 2024 12:11:22 +0000
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t3wfN-00000000IcI-0osz
	for linux-um@lists.infradead.org;
	Thu, 24 Oct 2024 12:10:14 +0000
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-71f5208217dso518004b3a.2
        for <linux-um@lists.infradead.org>; Thu, 24 Oct 2024 05:10:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729771812; x=1730376612; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OpT83Y9t1QnvPqILOaYReQujm77/DkJoRta+WWn6wAk=;
        b=I6RVwEys5iZGIEY6dipKC1RH3p5sLbN3R5i0LHMsl4yvY5gjqEFacNH0Ay6PImGwgB
         +LXQdO/Al1fHoCJhokdAVU/H/RBy2426IafMb6q412ZJn23rbNpkI/cuDzHfRJNX3aTG
         /bTxgQKFV6iHLgLdg85+DdqPglBwcOQXo6vXDlXedGnJPp84qdARcH40H5WA16Qskh/Z
         DNRuDaM/q+I81iy8nEzFsHkcb6A1faOk/nVdTDSqGx0/75IoTpTSQF/s7YtZJX/1onGE
         2RojeSb4BKef9HxQYINsH6akwcoXFXAEnp/YdfLqpvOvgc9rLVeNBv/4oU99g8r4DO9F
         xmNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729771812; x=1730376612;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OpT83Y9t1QnvPqILOaYReQujm77/DkJoRta+WWn6wAk=;
        b=lLFz1ZiQ5XEbUFxH1AkNY4CZ1LVuvGxAX/u0TShJsBiOPXeOfyl844Deav1tQR0oeY
         5K01OOOax/qDXCuPTOrMbw5B5pAHOKSJdnSnNBgm3I3Ln8fYUd4qw/p6BeOJ2p/h75C2
         A9GkgkBrEGMbHOaKMIXFZmg7zBDxJBqUQQP0E/K6faBRTMZo5e1bjo6G589I9vP6wJam
         qAh0s5+0zr5DLAuykNdBB7MvIVWHxN/wwARrtiHhNxOsnSXpM8+ip0A3Dafw+x/dtuCS
         ADhrThSn20GeFuL/TlbLkhbdTqHsQFTJmFsU1zm7LEcRXldUkSezZELL6W/JxD4UbtIf
         F33Q==
X-Gm-Message-State: AOJu0YxSC7c78G8rAAiQDXOdU0h1DchIpkqoeYo5fH5mrGdAjahtUXYu
	K2pqIDwHGy1Hxc4rHvma01oSCvSB6wvapZ3Dd8zxUNam5GB1lunoekLoPHYH
X-Google-Smtp-Source: AGHT+IG/QjEhps/8VYImYrcIArMZ54fTCi02v+n+DUmJjAsw1jvmTFT+ZU1+lLG3Dc9D3+sJv3r1qg==
X-Received: by 2002:a05:6a00:13a3:b0:71e:6e4a:507a with SMTP id d2e1a72fcca58-72045e239edmr1754097b3a.3.1729771811803;
        Thu, 24 Oct 2024 05:10:11 -0700 (PDT)
Received: from ikb-h07-29-noble.in.iijlab.net ([202.214.97.5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71ec132ff11sm7839404b3a.47.2024.10.24.05.10.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 05:10:11 -0700 (PDT)
Received: by ikb-h07-29-noble.in.iijlab.net (Postfix, from userid 1010)
	id 4B950D51253; Thu, 24 Oct 2024 21:10:09 +0900 (JST)
From: Hajime Tazaki <thehajime@gmail.com>
To: linux-um@lists.infradead.org,
	jdike@addtoit.com,
	richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net
Cc: thehajime@gmail.com,
	ricarkol@google.com
Subject: [RFC PATCH 06/13] x86/um: nommu: process/thread handling
Date: Thu, 24 Oct 2024 21:09:14 +0900
Message-ID: <88b3cdd8cd1437e45184fd26c6df5d7ceb93de55.1729770373.git.thehajime@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1729770373.git.thehajime@gmail.com>
References: <cover.1729770373.git.thehajime@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241024_051013_260779_03E31A4A 
X-CRM114-Status: GOOD (  19.29  )
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
code path to invoke proceeses/threads; on an entry to the syscall
interface, the stack pointer should be manipulated to handle vfork(2)
return address, no external process is used, and need to properlly
configure some of registers (fs segment register for TLS, etc) on every
contex switch, etc.

Signals aren't delivered in non-ptrace syscall entry/leave so, we also
need to handle pending signal by ourselves.

Signed-off-by: Hajime Tazaki <thehajime@gmail.com>
Signed-off-by: Ricardo Koller <ricarkol@google.com>
---
 arch/um/kernel/exec.c           |  8 ++++++++
 arch/um/kernel/process.c        | 21 ++++++++++++++++++++-
 arch/um/os-Linux/process.c      |  6 ++++++
 arch/um/os-Linux/skas/process.c |  4 ++++
 arch/x86/um/asm/processor.h     | 12 ++++++++++++
 arch/x86/um/entry_64.S          | 22 ++++++++++++++++++++++
 arch/x86/um/syscalls_64.c       | 12 ++++++++++++
 7 files changed, 84 insertions(+), 1 deletion(-)

diff --git a/arch/um/kernel/exec.c b/arch/um/kernel/exec.c
index cb8b5cd9285c..fe7d776a5962 100644
--- a/arch/um/kernel/exec.c
+++ b/arch/um/kernel/exec.c
@@ -24,8 +24,10 @@ void flush_thread(void)
 {
 	arch_flush_thread(&current->thread.arch);
 
+#ifdef CONFIG_MMU
 	get_safe_registers(current_pt_regs()->regs.gp,
 			   current_pt_regs()->regs.fp);
+#endif
 
 	__switch_mm(&current->mm->context.id);
 }
@@ -35,5 +37,11 @@ void start_thread(struct pt_regs *regs, unsigned long eip, unsigned long esp)
 	PT_REGS_IP(regs) = eip;
 	PT_REGS_SP(regs) = esp;
 	clear_thread_flag(TIF_SINGLESTEP);
+#ifndef CONFIG_MMU
+	current->thread.regs.regs.gp[REGS_IP_INDEX] = eip;
+	current->thread.regs.regs.gp[REGS_SP_INDEX] = esp;
+	new_thread(task_stack_page(current), &current->thread.switch_buf,
+		   (void *)eip);
+#endif
 }
 EXPORT_SYMBOL(start_thread);
diff --git a/arch/um/kernel/process.c b/arch/um/kernel/process.c
index b1b608afa036..270b5bd476be 100644
--- a/arch/um/kernel/process.c
+++ b/arch/um/kernel/process.c
@@ -117,13 +117,17 @@ void new_thread_handler(void)
 	 * callback returns only if the kernel thread execs a process
 	 */
 	fn(arg);
+#ifndef CONFIG_MMU
+	arch_switch_to(current);
+#endif
 	userspace(&current->thread.regs.regs, current_thread_info()->aux_fp_regs);
 }
 
 /* Called magically, see new_thread_handler above */
 static void fork_handler(void)
 {
-	schedule_tail(current->thread.prev_sched);
+	if (current->thread.prev_sched != NULL)
+		schedule_tail(current->thread.prev_sched);
 
 	/*
 	 * XXX: if interrupt_end() calls schedule, this call to
@@ -134,6 +138,21 @@ static void fork_handler(void)
 
 	current->thread.prev_sched = NULL;
 
+#ifndef CONFIG_MMU
+	/*
+	 * This fork can only come from libc's vfork, which
+	 * does this:
+	 *	popq %%rdx;
+	 *	call *%0; // vsyscall
+	 *	pushq %%rdx;
+	 * %rdx stores the return address which is stored
+	 * at pt_regs[HOST_IP] at the moment. We still
+	 * need to pop the pushed address by "call" though,
+	 * so this is what this next line does.
+	 */
+	if (current->thread.regs.regs.gp[HOST_ORIG_AX] == __NR_vfork)
+		current->thread.regs.regs.gp[REGS_SP_INDEX] += 8;
+#endif
 	userspace(&current->thread.regs.regs, current_thread_info()->aux_fp_regs);
 }
 
diff --git a/arch/um/os-Linux/process.c b/arch/um/os-Linux/process.c
index b164873da2db..f08bb20d95ec 100644
--- a/arch/um/os-Linux/process.c
+++ b/arch/um/os-Linux/process.c
@@ -92,7 +92,10 @@ int os_process_parent(int pid)
 
 void os_alarm_process(int pid)
 {
+/* !CONFIG_MMU doesn't send alarm signal to other processes */
+#ifdef UML_CONFIG_MMU
 	kill(pid, SIGALRM);
+#endif
 }
 
 void os_stop_process(int pid)
@@ -114,11 +117,14 @@ void os_kill_process(int pid, int reap_child)
 
 void os_kill_ptraced_process(int pid, int reap_child)
 {
+/* !CONFIG_MMU doesn't have ptraced process */
+#ifdef UML_CONFIG_MMU
 	kill(pid, SIGKILL);
 	ptrace(PTRACE_KILL, pid);
 	ptrace(PTRACE_CONT, pid);
 	if (reap_child)
 		CATCH_EINTR(waitpid(pid, NULL, __WALL));
+#endif
 }
 
 /* Don't use the glibc version, which caches the result in TLS. It misses some
diff --git a/arch/um/os-Linux/skas/process.c b/arch/um/os-Linux/skas/process.c
index b6f656bcffb1..2a0a20aa59b9 100644
--- a/arch/um/os-Linux/skas/process.c
+++ b/arch/um/os-Linux/skas/process.c
@@ -141,6 +141,7 @@ void wait_stub_done(int pid)
 
 extern unsigned long current_stub_stack(void);
 
+#ifdef UML_CONFIG_MMU
 static void get_skas_faultinfo(int pid, struct faultinfo *fi, unsigned long *aux_fp_regs)
 {
 	int err;
@@ -186,6 +187,7 @@ static void handle_trap(int pid, struct uml_pt_regs *regs)
 
 	handle_syscall(regs);
 }
+#endif
 
 extern char __syscall_stub_start[];
 
@@ -336,6 +338,7 @@ int start_userspace(unsigned long stub_stack)
 	return err;
 }
 
+#ifdef UML_CONFIG_MMU
 void userspace(struct uml_pt_regs *regs, unsigned long *aux_fp_regs)
 {
 	int err, status, op, pid = userspace_pid[0];
@@ -472,6 +475,7 @@ void userspace(struct uml_pt_regs *regs, unsigned long *aux_fp_regs)
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
diff --git a/arch/x86/um/entry_64.S b/arch/x86/um/entry_64.S
index 12e11ac03543..1fd5b3665efa 100644
--- a/arch/x86/um/entry_64.S
+++ b/arch/x86/um/entry_64.S
@@ -86,3 +86,25 @@ ENTRY(__kernel_vsyscall)
 	ret
 
 END(__kernel_vsyscall)
+
+// void userspace(struct uml_pt_regs *regs, unsigned long *aux_fp_regs)
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
+#endif // !CONFIG_MMU
diff --git a/arch/x86/um/syscalls_64.c b/arch/x86/um/syscalls_64.c
index 6a00a28c9cca..8abf2a679578 100644
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
+	if ((to->thread.regs.regs.gp[FS_BASE / sizeof(unsigned long)] == 0)
+	    || (to->mm == NULL))
+		return;
+
+	// rkj: this changes the FS on every context switch
+	arch_prctl(to, ARCH_SET_FS,
+		   (void __user *) to->thread.regs.regs.gp[FS_BASE / sizeof(unsigned long)]);
+#endif
 }
 
 SYSCALL_DEFINE6(mmap, unsigned long, addr, unsigned long, len,
-- 
2.43.0


