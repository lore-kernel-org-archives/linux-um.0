Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58933C0218C
	for <linux-um@archiver.kernel.org>; Mon, 20 Jan 2025 06:01:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=V/9FDFFbTGgOECfx9E1KzmmWlTydkD+KFqPPHo/qkbE=; b=OcSvxRU7+rWlyr75K6+vlNSJ2C
	zOhdg3aap7rPut0d3gg87b8wnMZrgbcYvHHIkjB8AxUNEGzi5+Kn+DAfZeuyixMjExUseI/uJbQ4y
	VgKzGftk0M1FKEiVvXOSsh1mly+U31cCvJbS1foho6LPQLxDVJJKCP1s7eMEvIiAr9UWFKNtUIYcG
	4rQ7TQgpjy993fgeFs2mcgKN8oiDnkJPn7RPr1ObgcgsTF9gYQRCXqj/ELmGUoIg/rIV0OiVHUcGl
	4UXFxSrzS3T9aU3hwWKGs0Ur5N+G1FOZbo78KCiarbKEnwPW/0oDpIY0+WjaKGuytEjY6l5oo3gUk
	P+iYpYNA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tZkr1-00000004nOH-0O30;
	Mon, 20 Jan 2025 06:01:43 +0000
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tZkpt-00000004nEq-1QQa
	for linux-um@lists.infradead.org;
	Mon, 20 Jan 2025 06:00:34 +0000
Received: by mail-pj1-x102c.google.com with SMTP id 98e67ed59e1d1-2eed82ca5b4so7082178a91.2
        for <linux-um@lists.infradead.org>; Sun, 19 Jan 2025 22:00:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737352832; x=1737957632; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V/9FDFFbTGgOECfx9E1KzmmWlTydkD+KFqPPHo/qkbE=;
        b=E/uTaYgaKC7D2yXt9vEvHOT4ixzpPhayqufi799y71RgzWXDIGjij34QER4CNsC10e
         iM9ymyvGsqE5zigUuJEyf10ZbdnaQncw0mwYQPDLJT3vNQ5Xr9nRDBqBFChSq31X+Wlk
         BHHUUd5lveUZ4p/xzl6KddQeEyXjv+cgrp1DH7ByG9HrhGevQIZllb2agL1ABmBD1kEV
         btS07mp1ixdaKPSAvYOnTnd0HRDPFDO8JyOHSdmMUmKQ7d2EqPSMGMc+Bol1cQ1OiUAI
         GPF8jlntlAQq5PnZebFgdkSfqWS8rWF9XlIVmMZCfU7FnVZSr9iStZuwLqIFe0FT0QWe
         n4Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737352832; x=1737957632;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V/9FDFFbTGgOECfx9E1KzmmWlTydkD+KFqPPHo/qkbE=;
        b=BzJVfKIyy29AroiVSihq7BgbYW3iztAfRs+4EBVP4NMtEv9snqTSdWKwhbv5R+r6Q6
         jxUHAxfpA/tFyOj8RW2xwhm3p/QqqV6EUaUbdwnhCUGbvpUvqhV7D/bvbL9+devLe8Ug
         9eJNIsHRq8ZfeVrrBFy8BJMdWJfvujVd75odsWOMwZPrBZaW338ABqDxtEK6OB0s3mYK
         MW4zVyKHjzIzQzaewNgI0MR7bNA3OlJQrQYnemJVRGqIDRknawQhxl+Ie09zxx9N13mJ
         zki8g3yR1pOxNXlZ8Ra+suy4F1lGAKOKVloUkGu/nvTuAq8cmIqLoo5emgzuQRKllLrH
         gdig==
X-Gm-Message-State: AOJu0Yzfhc0ny4kCq6/C8RLyQhXfVhiL/dnLXF07XORF6uQq7C6naTWj
	7T4sg9uu/Z+0hIpgDMF22xk/U9pbpcbpDe2mFI5H1TahlNjZ0ngR
X-Gm-Gg: ASbGnctgBiSt2blrxCT0PEyjsnr0wBhpE/KPR0BE/KhaMZHLqqr+1CuMrS9X3BM2u2e
	nwhtQQRbqwP08/e0W9PYO0ZB4rQec/MoWSl6AY+tCHvttWjxtu7r2wQV4Gy/hyVAX0Rvbz2eQTV
	x6Y9aQiEWeVb9UwT4lXayyf9wCd/nVm/uxdRJKEO2LJJ1khb6/VdyAiZBSQi85e+40x+AiO+pSq
	uKALRGRxxZgz54IBkbuByNy/xPUPvN8vN9Nky6KL3Agwgl1094dOU3lStqAS9cQg7IkFMoOxSht
	ZUAuWpPSts4XoIvhMGknCrburjrTjzpXaXo5Qa6rdQ==
X-Google-Smtp-Source: AGHT+IGmFJ/NSW+E/2k8WD27rF4avs6IVPl63YAId0dFhOVe2KLIGcmgvi7+AB0g0GFBDYCkBaX1YA==
X-Received: by 2002:a17:90b:520d:b0:2ee:7411:ca99 with SMTP id 98e67ed59e1d1-2f782c4cb23mr15615759a91.1.1737352832195;
        Sun, 19 Jan 2025 22:00:32 -0800 (PST)
Received: from ikb-h07-29-noble.in.iijlab.net ([202.214.97.5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f72c14ffaasm9794395a91.4.2025.01.19.22.00.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jan 2025 22:00:31 -0800 (PST)
Received: by ikb-h07-29-noble.in.iijlab.net (Postfix, from userid 1010)
	id 25698E2752C; Mon, 20 Jan 2025 15:00:29 +0900 (JST)
From: Hajime Tazaki <thehajime@gmail.com>
To: linux-um@lists.infradead.org
Cc: thehajime@gmail.com,
	ricarkol@google.com,
	Liam.Howlett@oracle.com
Subject: [PATCH v7 05/13] x86/um: nommu: syscall handling
Date: Mon, 20 Jan 2025 15:00:07 +0900
Message-ID: <c91911eb35125a739293d0ff175f2303b37183cf.1737348399.git.thehajime@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1737348399.git.thehajime@gmail.com>
References: <cover.1737348399.git.thehajime@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250119_220033_436109_353DFAB6 
X-CRM114-Status: GOOD (  21.30  )
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

This commit introduces an entry point of syscall interface for !MMU
mode. It uses an entry function, __kernel_vsyscall, a kernel-wide global
symbol accessible from any locations.

Although it isn't in the scope of this commit, it can be also exposed
via vdso image which is directly accessible from userspace. A standard
library (i.e., libc) can utilize this entry point to implement syscall
wrapper; we can also use this by hooking syscall for unmodified userspace
applications/libraries, which will be implemented in the subsequent
commit.

This only supports 64-bit mode of x86 architecture.

Signed-off-by: Hajime Tazaki <thehajime@gmail.com>
Signed-off-by: Ricardo Koller <ricarkol@google.com>
---
 arch/x86/um/Makefile                    |  4 ++
 arch/x86/um/nommu/Makefile              |  8 +++
 arch/x86/um/nommu/do_syscall_64.c       | 37 ++++++++++
 arch/x86/um/nommu/entry_64.S            | 91 +++++++++++++++++++++++++
 arch/x86/um/nommu/syscalls.h            | 16 +++++
 arch/x86/um/shared/sysdep/syscalls_64.h |  6 ++
 6 files changed, 162 insertions(+)
 create mode 100644 arch/x86/um/nommu/Makefile
 create mode 100644 arch/x86/um/nommu/do_syscall_64.c
 create mode 100644 arch/x86/um/nommu/entry_64.S
 create mode 100644 arch/x86/um/nommu/syscalls.h

diff --git a/arch/x86/um/Makefile b/arch/x86/um/Makefile
index b42c31cd2390..227af2a987e2 100644
--- a/arch/x86/um/Makefile
+++ b/arch/x86/um/Makefile
@@ -32,6 +32,10 @@ obj-y += syscalls_64.o vdso/
 subarch-y = ../lib/csum-partial_64.o ../lib/memcpy_64.o \
 	../lib/memmove_64.o ../lib/memset_64.o
 
+ifneq ($(CONFIG_MMU),y)
+obj-y += nommu/
+endif
+
 endif
 
 subarch-$(CONFIG_MODULES) += ../kernel/module.o
diff --git a/arch/x86/um/nommu/Makefile b/arch/x86/um/nommu/Makefile
new file mode 100644
index 000000000000..d72c63afffa5
--- /dev/null
+++ b/arch/x86/um/nommu/Makefile
@@ -0,0 +1,8 @@
+# SPDX-License-Identifier: GPL-2.0
+ifeq ($(CONFIG_X86_32),y)
+	BITS := 32
+else
+	BITS := 64
+endif
+
+obj-y = do_syscall_$(BITS).o entry_$(BITS).o
diff --git a/arch/x86/um/nommu/do_syscall_64.c b/arch/x86/um/nommu/do_syscall_64.c
new file mode 100644
index 000000000000..5d0fa83e7fdc
--- /dev/null
+++ b/arch/x86/um/nommu/do_syscall_64.c
@@ -0,0 +1,37 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/kernel.h>
+#include <linux/ptrace.h>
+#include <kern_util.h>
+#include <sysdep/syscalls.h>
+#include <os.h>
+
+__visible void do_syscall_64(struct pt_regs *regs)
+{
+	int syscall;
+
+	syscall = PT_SYSCALL_NR(regs->regs.gp);
+	UPT_SYSCALL_NR(&regs->regs) = syscall;
+
+	pr_debug("syscall(%d) (current=%lx) (fn=%lx)\n",
+		 syscall, (unsigned long)current,
+		 (unsigned long)sys_call_table[syscall]);
+
+	if (likely(syscall < NR_syscalls)) {
+		PT_REGS_SET_SYSCALL_RETURN(regs,
+				EXECUTE_SYSCALL(syscall, regs));
+	}
+
+	pr_debug("syscall(%d) --> %lx\n", syscall,
+		regs->regs.gp[HOST_AX]);
+
+	PT_REGS_SYSCALL_RET(regs) = regs->regs.gp[HOST_AX];
+
+	/* execve succeeded */
+	if (syscall == __NR_execve && regs->regs.gp[HOST_AX] == 0)
+		userspace(&current->thread.regs.regs);
+
+	/* force do_signal() --> is_syscall() */
+	set_thread_flag(TIF_SIGPENDING);
+	interrupt_end();
+}
diff --git a/arch/x86/um/nommu/entry_64.S b/arch/x86/um/nommu/entry_64.S
new file mode 100644
index 000000000000..e9bfc7b93c84
--- /dev/null
+++ b/arch/x86/um/nommu/entry_64.S
@@ -0,0 +1,91 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#include <asm/errno.h>
+
+#include <linux/linkage.h>
+#include <asm/percpu.h>
+#include <asm/desc.h>
+
+#include "../entry/calling.h"
+
+#ifdef CONFIG_SMP
+#error need to stash these variables somewhere else
+#endif
+
+#define UM_GLOBAL_VAR(x) .data; .align 8; .globl x; x:; .long 0
+
+UM_GLOBAL_VAR(current_top_of_stack)
+UM_GLOBAL_VAR(current_ptregs)
+
+.code64
+.section .entry.text, "ax"
+
+.align 8
+#undef ENTRY
+#define ENTRY(x) .text; .globl x; .type x,%function; x:
+#undef END
+#define END(x)   .size x, . - x
+
+/*
+ * %rcx has the return address (we set it before entering __kernel_vsyscall).
+ *
+ * Registers on entry:
+ * rax  system call number
+ * rcx  return address
+ * rdi  arg0
+ * rsi  arg1
+ * rdx  arg2
+ * r10  arg3
+ * r8   arg4
+ * r9   arg5
+ *
+ * (note: we are allowed to mess with r11: r11 is callee-clobbered
+ * register in C ABI)
+ */
+ENTRY(__kernel_vsyscall)
+
+	movq	%rsp, %r11
+
+	/* Point rsp to the top of the ptregs array, so we can
+           just fill it with a bunch of push'es. */
+	movq	current_ptregs, %rsp
+
+	/* 8 bytes * 20 registers (plus 8 for the push) */
+	addq	$168, %rsp
+
+	/* Construct struct pt_regs on stack */
+	pushq	$0		/* pt_regs->ss (index 20) */
+	pushq   %r11		/* pt_regs->sp */
+	pushfq			/* pt_regs->flags */
+	pushq	$0		/* pt_regs->cs */
+	pushq	%rcx		/* pt_regs->ip */
+	pushq	%rax		/* pt_regs->orig_ax */
+
+	PUSH_AND_CLEAR_REGS rax=$-ENOSYS
+
+	mov %rsp, %rdi
+
+	/*
+	 * Switch to current top of stack, so "current->" points
+	 * to the right task.
+	 */
+	movq	current_top_of_stack, %rsp
+
+	call	do_syscall_64
+
+	movq	current_ptregs, %rsp
+
+	POP_REGS
+
+	addq	$8, %rsp	/* skip orig_ax */
+	popq	%rcx		/* pt_regs->ip */
+	addq	$8, %rsp	/* skip cs */
+	addq	$8, %rsp	/* skip flags */
+	popq	%rsp
+
+	/*
+	* not return w/ ret but w/ jmp as the stack is already popped before
+	* entering __kernel_vsyscall
+	*/
+	jmp	*%rcx
+
+END(__kernel_vsyscall)
diff --git a/arch/x86/um/nommu/syscalls.h b/arch/x86/um/nommu/syscalls.h
new file mode 100644
index 000000000000..a2433756b1fc
--- /dev/null
+++ b/arch/x86/um/nommu/syscalls.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __UM_NOMMU_SYSCALLS_H
+#define __UM_NOMMU_SYSCALLS_H
+
+
+#define task_top_of_stack(task) \
+({									\
+	unsigned long __ptr = (unsigned long)task->stack;	\
+	__ptr += THREAD_SIZE;			\
+	__ptr;					\
+})
+
+extern long current_top_of_stack;
+extern long current_ptregs;
+
+#endif
diff --git a/arch/x86/um/shared/sysdep/syscalls_64.h b/arch/x86/um/shared/sysdep/syscalls_64.h
index b6b997225841..ffd80ee3b9dc 100644
--- a/arch/x86/um/shared/sysdep/syscalls_64.h
+++ b/arch/x86/um/shared/sysdep/syscalls_64.h
@@ -25,4 +25,10 @@ extern syscall_handler_t *sys_call_table[];
 extern syscall_handler_t sys_modify_ldt;
 extern syscall_handler_t sys_arch_prctl;
 
+#ifndef CONFIG_MMU
+extern void do_syscall_64(struct pt_regs *regs);
+extern long __kernel_vsyscall(int64_t a0, int64_t a1, int64_t a2, int64_t a3,
+			      int64_t a4, int64_t a5, int64_t a6);
+#endif
+
 #endif
-- 
2.43.0


