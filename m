Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 525C9C369D9
	for <linux-um@archiver.kernel.org>; Wed, 30 Apr 2025 04:29:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=V/9FDFFbTGgOECfx9E1KzmmWlTydkD+KFqPPHo/qkbE=; b=XgyAgzXHGh6TnEESrgmXMPBpRt
	UoGBqR4gD8l9o+Wsabz5/r0eMID4XGRbHjdLMwhK/BR3Gq0fWDZx1q6eja5rv/LM9fuwPdn1h97pJ
	2k8j2RSBvgXy42KsE2qUqXwsItrY4qgJOIKJRiqZGoBkT4J2iy1itxDtphcYihstkhF2GXkesjg1d
	iKQ9I6tGfQAV9Ms20lAhAhi3LmUZWGVuAbZ+RuAOQ7lpQcYCZ6BjZmSUgWsR32xUCjCcJ1kcGTz3m
	YaAPqrhuDEQXn3uryB4dZsLbkLoe8g9lI9A2xDqSOVjG1bgm3MRk7AxfnUWSuBFiwI0KZ5JJNdcaK
	5WwokwyQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u9z4D-0000000BfkU-3nit;
	Wed, 30 Apr 2025 04:29:05 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u9z3N-0000000BfWo-3jJ1
	for linux-um@bombadil.infradead.org;
	Wed, 30 Apr 2025 04:28:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=V/9FDFFbTGgOECfx9E1KzmmWlTydkD+KFqPPHo/qkbE=; b=fs0Uue6Rq625beM4yqvMxmbnx8
	Vmq2QLO4Z8QXMCD9DgP3+exILlfEqMAxRtghwwiix8bv28YW1Nym3NR+I0mTyqGWtPqMWpDqnb+AF
	mig1fL1H0TJFsGae9SvQS3oBQ8KK2Lnt8tTWp6J2Ulkpjy7/h8iDrbu2zf9KA/u7Yd2hXCm7od0Sw
	6z/3muXBtBDMaUKkDROYerKpw+gi8tB0KbnK2IqqEMRLeefu3JqdNVvsCnYRYOGAybpxLM4adnqXd
	E/1tZnObJQpuS27kYmDpAe6Z8Fdj1/FEH2CyvGFI+XPJ6kLw6+umLgAhMO2sVaieezoe2ebs6ohoQ
	k692E+uQ==;
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
	by desiato.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u9z31-0000000DgC6-0Ply
	for linux-um@lists.infradead.org;
	Wed, 30 Apr 2025 04:28:10 +0000
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-2279915e06eso77945425ad.1
        for <linux-um@lists.infradead.org>; Tue, 29 Apr 2025 21:27:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745987267; x=1746592067; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V/9FDFFbTGgOECfx9E1KzmmWlTydkD+KFqPPHo/qkbE=;
        b=TpTGt3T8U32+fTk1tfdG3ytAisv4h9ptH3A78pAfHChQtHt9V6dCjjSZoXDQxYVTI4
         auKTFwcOmLsJdao+Cz3DdqWZsX9P343O0vyi75zhjutwqGIk6HMcgZotNVzU4xlrToLA
         aye1z+YNPSZWA5vS0vZYwyMqjWQzQrQ+XaWPE9J3nv24FOutj9PqSlh7fVURZxP6mYYY
         oWFi/S/vnQopOhzjumUjuOfOpGsyGnboJCWhvwPLSFco7sodOyq6zWJBBKmCFRZsPCF5
         h0Q/FP5HafHOtAyMX85fuyyKI5y7RyJpcCGHJt1LqY3j16jauJGkDbf3Dx0wgVqHn6Vz
         dB+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745987267; x=1746592067;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V/9FDFFbTGgOECfx9E1KzmmWlTydkD+KFqPPHo/qkbE=;
        b=L1d3bq1mCCNaBNMWuVAsMWWeo7M1bPGu4GtbV3TQOCd48ktBybYjmhkGPeIHtSpZC3
         VQ/YYvEiICnZ0JtyOFGXgbzKBMR0aZM8UHETBVrN3Kq5LbLTb75xEBfO5Zq4kSEMbCMA
         3B2z0dAUYJjF5m8IXXyF5OVSEH3cDUFkPqXgnUksLznl5eeL8Gh3l0n5wDYDq1Ux75Ey
         dvilHUoOWjiR4Y+Lmhu4Ex7cJJvwUfZJlBBDK8giVhnCfXu87jAaeHGxJAIxeHUCAzY8
         sjhehITFXeF8Qh55oRJBFTAuNJ6tCXDpjX3asljKvOyZ7MD/FQfzoBBs9GpIp3AyrjY+
         r1yA==
X-Gm-Message-State: AOJu0Yw732fN0pbEPnLmstwiO0PqBY4O5JOp9lfuS1Xg2ku3O8NCFPUN
	peysQNotwklaIL9NgqcDTzQIG4NewJVqc7Um1QqFHv0+ELOMVPK1ElM59x8a
X-Gm-Gg: ASbGncsSR6QhcD1jIXvdvoYo/TN5JaIPn7n+zUvcx0rohySpWw/Smq0020+1IHf7fj1
	vbFb6DJKw9V2cmjM4+HqTU8PAFuqm+yoO8LeolDpg7M3ZcaCA0tUwGaMYrA9T/+rxh6Pk+6jfJY
	Fp7rJljURXJ8o0uExPQYk4yHWb+rfSvEd6SYkmLkAPb/i+xU4u/4Q0C0NXrBW0FWDeNdXsZ8Tj3
	EL/eyDlJ1Shqz043S6AvG1ZUK0P8+LetwXMSrR2QpYW9zeAn+dSnGJp40X8e+0RE5PVFb1oRrz2
	Lvv6z6nSzItoxA7yoxOiL73RIX1u2hkLi0f7gphfZ/QMsc/mjeBvlMcmwPDztdeLke/fIP2NWDQ
	heLFVjgwg6n8=
X-Google-Smtp-Source: AGHT+IE1t3dxTA3D4yK2A7FdFXYVRfds1pPjBfcX/u2XIDgYkr+Ssgsi8tcGY9rf7mYw6fzn16NtDA==
X-Received: by 2002:a17:903:1946:b0:21f:5cd8:c67 with SMTP id d9443c01a7336-22df57d2db9mr17805125ad.31.1745987267296;
        Tue, 29 Apr 2025 21:27:47 -0700 (PDT)
Received: from ikb-h07-29-noble.in.iijlab.net ([202.214.97.5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22db50e766bsm112325805ad.149.2025.04.29.21.27.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Apr 2025 21:27:46 -0700 (PDT)
Received: by ikb-h07-29-noble.in.iijlab.net (Postfix, from userid 1010)
	id C0907E9481A; Wed, 30 Apr 2025 13:27:44 +0900 (JST)
From: Hajime Tazaki <thehajime@gmail.com>
To: linux-um@lists.infradead.org
Cc: thehajime@gmail.com,
	ricarkol@google.com,
	Liam.Howlett@oracle.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v8 04/12] x86/um: nommu: syscall handling
Date: Wed, 30 Apr 2025 13:27:10 +0900
Message-ID: <3ba48d392c14777c9a1723b61b7d743ec3a4c14b.1745980082.git.thehajime@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1745980082.git.thehajime@gmail.com>
References: <cover.1745980082.git.thehajime@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250430_052754_479725_264D4797 
X-CRM114-Status: GOOD (  21.90  )
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


