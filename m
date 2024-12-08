Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88D4BE77173
	for <linux-um@archiver.kernel.org>; Sun,  8 Dec 2024 10:16:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ANzLHPhvUvb9yEKgigzM5mkIBLQoa1J68xVJ3wb2agw=; b=1dIa5GbxiH9Z+uyoNEaoNwhVKj
	vP3gjj3eGKu8VEnHuq6z0Utsy17L456EgXYQpzCt1XTsckIDN54ZGvE8mZcrIW1umL0Zu2hyiBNSl
	aHqOL4Imc+DI/tV/+KNpIcq/7CJMIrsvGtK3iDBEnFDuFRxCxiwv7ehgwdMq8egMAAdjUHtaH83pt
	Or1saaggehSI9Y7+P+GuzNaY6c5ibpZG/GkqYmR8MhNcBz22UbGeMvrXQDdhIl5dPrYNvf0zQj5uL
	gaKmiZG7HyMyYQ6QRBKhE1VRYB49bjtK1WX1Z0IQA+vu681YGnbEmATfqGli/8L3kiAS4tcUV39FE
	nbAXQMdg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tKEKo-000000057bt-106U;
	Sun, 08 Dec 2024 10:16:18 +0000
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tKEKk-000000057aV-3AH4
	for linux-um@lists.infradead.org;
	Sun, 08 Dec 2024 10:16:16 +0000
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-725b3b9fa6cso2208879b3a.3
        for <linux-um@lists.infradead.org>; Sun, 08 Dec 2024 02:16:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733652974; x=1734257774; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ANzLHPhvUvb9yEKgigzM5mkIBLQoa1J68xVJ3wb2agw=;
        b=mga8/oG/IwMGogRt6SXFriGG3OqWn1fhBemQWXvV9DpUUBA4ZRwh3zkDQ6Qwgu9RrW
         6hfIPsGVdfv6iBs1Y4r3xwBbu9ggLJD2lbRUHTA4+k47G7xWyy2fQVTAcsfHVjJ/epbS
         jloxH0yqaG1j94eKhQyfds07156hIzDmiFRjpFiP47ONOXjEK5RYUI2KFh031UJS4Rmz
         lrkcU2Pbzc4e34x4oD3uwS5Y13mlKmPViSH5cQwQ5xHnZma1xhmgeDSHNz5D2y1vDFdp
         7vG66yvKT1jwItIjU9L7zzEiSblxtNNsfDO9cI6RmMlcWFcISy71eKFxnlk1+VAyDuf7
         2Xzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733652974; x=1734257774;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ANzLHPhvUvb9yEKgigzM5mkIBLQoa1J68xVJ3wb2agw=;
        b=OMpa/BKnI/bvY/pdE0JXS8wP7HC0Ub4h2E16ejFZiYrAvqP9RdxdMJMB5exuhFLk6j
         uK/nstlA/fvI/dgNUbQ/rtkb3trcm4aoL2zpqKNbZjM52f3ArmVD1nkieXtGkesnsDV3
         mRbPebQI8S+AzYyE9v6U0dc6HpW6QXaObeSHtsfVCyiXKnJnlnlv/NBBPU4abcdfZRG8
         6bpsOT/NMqy7g7B470+Qn9mrVLaWvW+23Mvb0GKviWEFq91qCW2R4Jxl9CPLGNF/rH5O
         LUf4B+3u7J0EkAivNbvbodF16IVh41uirFELTvwgHLJbyPIWCp12otUq6r18C6YBxVFi
         HhXQ==
X-Gm-Message-State: AOJu0Yzt49CFQc8LQeTP/UgQcBxTmNyxTopdXBuqjI9GEVEeC3u6LPq0
	nJBU7hbRjbr8ooFhrcfOHVhb/Zl+tsbq056KevH7ScKd12YraQdH
X-Gm-Gg: ASbGnctbZumS1csRhN7BQelYmKNyniabG3a0VPeo3bqh+CeMUch4w4oVDlcnJUs7rxj
	0u7vPRiBy5Xc5fydyGcfyGPgA1f7VGDTC3PABc2DjXfRaD3Ujz+eApZJF8fGVskvk1TXkXmWcu+
	ULU2VOWNr0sSt2bYn4C4Lh7xhDB4Jt1lAjI+32DdWsAMTJRMLILMwIJ+wzeBaur27Olj4S8IPpe
	7j6Uaw1hkd3Xah3Em1Cg7H9nyeX3fK/enQF2FrXtJ5P+jlz28S+NjzTKQVaUHHPBc/JAkF5zCxG
	xILEd+KH/x9DWbLta+AT
X-Google-Smtp-Source: AGHT+IF0p+Sq5/ZOrkm6KZo+Vn0ZwNLeiyMwwqRBFWEEFq28eBX2KNOwtKPxcghV5YtO3gmsq+TzVQ==
X-Received: by 2002:a05:6a00:4b03:b0:725:456e:76e with SMTP id d2e1a72fcca58-725b80feb59mr14456755b3a.6.1733652973702;
        Sun, 08 Dec 2024 02:16:13 -0800 (PST)
Received: from ikb-h07-29-noble.in.iijlab.net ([202.214.97.5])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fd41ff3e42sm1081908a12.66.2024.12.08.02.16.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Dec 2024 02:16:13 -0800 (PST)
Received: by ikb-h07-29-noble.in.iijlab.net (Postfix, from userid 1010)
	id 174EBDDB02C; Sun,  8 Dec 2024 19:16:11 +0900 (JST)
From: Hajime Tazaki <thehajime@gmail.com>
To: linux-um@lists.infradead.org
Cc: thehajime@gmail.com,
	ricarkol@google.com,
	Liam.Howlett@oracle.com
Subject: [PATCH v4 07/13] x86/um: nommu: process/thread handling
Date: Sun,  8 Dec 2024 19:15:34 +0900
Message-ID: <b8520d88457ecbd8ad2b1d0c59906da6f846e9e0.1733652929.git.thehajime@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1733652929.git.thehajime@gmail.com>
References: <cover.1733652929.git.thehajime@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241208_021614_798762_B51869D8 
X-CRM114-Status: GOOD (  24.42  )
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
 arch/um/os-Linux/process.c              |  6 ++++
 arch/x86/um/Makefile                    |  3 +-
 arch/x86/um/nommu/Makefile              |  2 +-
 arch/x86/um/nommu/do_syscall_64.c       | 26 +++++++++++++++
 arch/x86/um/nommu/entry_64.S            | 24 ++++++++++++++
 arch/x86/um/nommu/process.c             | 35 ++++++++++++++++++++
 arch/x86/um/nommu/syscalls_64.c         | 44 +++++++++++++++++++++++++
 arch/x86/um/shared/sysdep/syscalls_64.h |  1 +
 8 files changed, 139 insertions(+), 2 deletions(-)
 create mode 100644 arch/x86/um/nommu/process.c
 create mode 100644 arch/x86/um/nommu/syscalls_64.c

diff --git a/arch/um/os-Linux/process.c b/arch/um/os-Linux/process.c
index e2dc00fc84c0..49aa8e92205e 100644
--- a/arch/um/os-Linux/process.c
+++ b/arch/um/os-Linux/process.c
@@ -28,6 +28,9 @@ int unscheduled_userspace_iterations;
 
 void os_alarm_process(int pid)
 {
+	if (pid <= 0)
+		return;
+
 	kill(pid, SIGALRM);
 }
 
@@ -45,6 +48,9 @@ void os_kill_process(int pid, int reap_child)
 
 void os_kill_ptraced_process(int pid, int reap_child)
 {
+	if (pid <= 0)
+		return;
+
 	kill(pid, SIGKILL);
 	ptrace(PTRACE_KILL, pid);
 	ptrace(PTRACE_CONT, pid);
diff --git a/arch/x86/um/Makefile b/arch/x86/um/Makefile
index 227af2a987e2..53c9ebb3c41c 100644
--- a/arch/x86/um/Makefile
+++ b/arch/x86/um/Makefile
@@ -27,7 +27,8 @@ subarch-y += ../kernel/sys_ia32.o
 
 else
 
-obj-y += syscalls_64.o vdso/
+obj-y += vdso/
+obj-$(CONFIG_MMU) += syscalls_64.o
 
 subarch-y = ../lib/csum-partial_64.o ../lib/memcpy_64.o \
 	../lib/memmove_64.o ../lib/memset_64.o
diff --git a/arch/x86/um/nommu/Makefile b/arch/x86/um/nommu/Makefile
index ebe47d4836f4..03865bf1428e 100644
--- a/arch/x86/um/nommu/Makefile
+++ b/arch/x86/um/nommu/Makefile
@@ -5,4 +5,4 @@ else
 	BITS := 64
 endif
 
-obj-y = do_syscall_$(BITS).o entry_$(BITS).o os-Linux/
+obj-y = do_syscall_$(BITS).o entry_$(BITS).o process.o syscalls_$(BITS).o os-Linux/
diff --git a/arch/x86/um/nommu/do_syscall_64.c b/arch/x86/um/nommu/do_syscall_64.c
index 5d0fa83e7fdc..d5fb849bb34b 100644
--- a/arch/x86/um/nommu/do_syscall_64.c
+++ b/arch/x86/um/nommu/do_syscall_64.c
@@ -6,9 +6,28 @@
 #include <sysdep/syscalls.h>
 #include <os.h>
 
+/*
+ * save/restore the return address stored in the stack, as the child overwrites
+ * the contents after returning to userspace (i.e., by push %rdx).
+ *
+ * see the detail in fork_handler().
+ */
+static void vfork_save_stack(void *stack)
+{
+	memcpy(stack,
+	       (void *)current->thread.regs.regs.gp[HOST_SP], 8);
+}
+
+static void vfork_restore_stack(void *stack_copy)
+{
+	memcpy((void *)current->thread.regs.regs.gp[HOST_SP],
+	       stack_copy, 8);
+}
+
 __visible void do_syscall_64(struct pt_regs *regs)
 {
 	int syscall;
+	unsigned long stack_copy;
 
 	syscall = PT_SYSCALL_NR(regs->regs.gp);
 	UPT_SYSCALL_NR(&regs->regs) = syscall;
@@ -17,6 +36,9 @@ __visible void do_syscall_64(struct pt_regs *regs)
 		 syscall, (unsigned long)current,
 		 (unsigned long)sys_call_table[syscall]);
 
+	if (syscall == __NR_vfork)
+		vfork_save_stack(&stack_copy);
+
 	if (likely(syscall < NR_syscalls)) {
 		PT_REGS_SET_SYSCALL_RETURN(regs,
 				EXECUTE_SYSCALL(syscall, regs));
@@ -31,6 +53,10 @@ __visible void do_syscall_64(struct pt_regs *regs)
 	if (syscall == __NR_execve && regs->regs.gp[HOST_AX] == 0)
 		userspace(&current->thread.regs.regs);
 
+	/* only parents of vfork restores the contents of stack */
+	if (syscall == __NR_vfork && regs->regs.gp[HOST_AX] > 0)
+		vfork_restore_stack(&stack_copy);
+
 	/* force do_signal() --> is_syscall() */
 	set_thread_flag(TIF_SIGPENDING);
 	interrupt_end();
diff --git a/arch/x86/um/nommu/entry_64.S b/arch/x86/um/nommu/entry_64.S
index c612a4c53c6f..cb0642172e00 100644
--- a/arch/x86/um/nommu/entry_64.S
+++ b/arch/x86/um/nommu/entry_64.S
@@ -85,3 +85,27 @@ ENTRY(__kernel_vsyscall)
 	ret
 
 END(__kernel_vsyscall)
+
+// void userspace(struct uml_pt_regs *regs)
+ENTRY(userspace)
+	/* fixup stack for vfork syscall*/
+	call	arch_fixup_stack
+
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
diff --git a/arch/x86/um/nommu/process.c b/arch/x86/um/nommu/process.c
new file mode 100644
index 000000000000..ad5487796329
--- /dev/null
+++ b/arch/x86/um/nommu/process.c
@@ -0,0 +1,35 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <asm/unistd.h>
+#include <sysdep/syscalls.h>
+#include <os.h>
+
+void arch_fixup_stack(struct uml_pt_regs *regs)
+{
+	/*
+	 * child of vfork(2) comes here.
+	 * clone(2) also enters here but doesn't need to advance the %rsp.
+	 *
+	 * This fork can only come from libc's vfork, which
+	 * does this:
+	 *	pop %%rdx;
+	 *	mov $58,%eax
+	 *	syscall   ; // hook => __kernel_vsyscall
+	 *	push %%rdx;
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
+	if (regs->gp[HOST_ORIG_AX] == __NR_vfork)
+		regs->gp[REGS_SP_INDEX] += 8;
+}
diff --git a/arch/x86/um/nommu/syscalls_64.c b/arch/x86/um/nommu/syscalls_64.c
new file mode 100644
index 000000000000..c78c442aed1d
--- /dev/null
+++ b/arch/x86/um/nommu/syscalls_64.c
@@ -0,0 +1,44 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2003 - 2007 Jeff Dike (jdike@{addtoit,linux.intel}.com)
+ * Copyright 2003 PathScale, Inc.
+ *
+ * Licensed under the GPL
+ */
+
+#include <linux/sched.h>
+#include <linux/sched/mm.h>
+#include <linux/syscalls.h>
+#include <linux/uaccess.h>
+#include <asm/prctl.h> /* XXX This should get the constants from libc */
+#include <registers.h>
+#include <os.h>
+#include "syscalls.h"
+
+void arch_switch_to(struct task_struct *to)
+{
+	/*
+	 * In !CONFIG_MMU, it doesn't ptrace thus,
+	 * The FS_BASE/GS_BASE registers are saved here.
+	 */
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
+}
+
+SYSCALL_DEFINE6(mmap, unsigned long, addr, unsigned long, len,
+		unsigned long, prot, unsigned long, flags,
+		unsigned long, fd, unsigned long, off)
+{
+	if (off & ~PAGE_MASK)
+		return -EINVAL;
+
+	return ksys_mmap_pgoff(addr, len, prot, flags, fd, off >> PAGE_SHIFT);
+}
diff --git a/arch/x86/um/shared/sysdep/syscalls_64.h b/arch/x86/um/shared/sysdep/syscalls_64.h
index ffd80ee3b9dc..9831ba8f5bcd 100644
--- a/arch/x86/um/shared/sysdep/syscalls_64.h
+++ b/arch/x86/um/shared/sysdep/syscalls_64.h
@@ -29,6 +29,7 @@ extern syscall_handler_t sys_arch_prctl;
 extern void do_syscall_64(struct pt_regs *regs);
 extern long __kernel_vsyscall(int64_t a0, int64_t a1, int64_t a2, int64_t a3,
 			      int64_t a4, int64_t a5, int64_t a6);
+extern void arch_fixup_stack(struct uml_pt_regs *regs);
 #endif
 
 #endif
-- 
2.43.0


