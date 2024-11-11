Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77EA0D12D76
	for <linux-um@archiver.kernel.org>; Mon, 11 Nov 2024 06:28:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=h+MQ8LBXw5PDwKxMHEr82155zLkpbExofGKGEuLjFDA=; b=fJ+W4AJ8rSgwOLzHAfXkq7APez
	9KEnbYj2udNrJfJj5Jg3c3S1YxO+S+KgsTxtlslM4hPf3vnp7CLN9F5e3GcYy1de6p5Q+pWXvAgVb
	/OcR5awAgI/vQ1SN82HGHk6qR3CmLChxh7QxPgBA5u0RjIauQf3TT+IMa63CniZ5feWt77igY4tf8
	3A+49Xc0NIWZF5B74imtRISwzBpZJJTZzCkYKfOc44ZTmRWj9c4NROkKEWpInBsOYhoiFai5nLwg9
	Cm/ZgB9A5blf4WE/+Ote0XcYLCjtAl6TfTa9r+MkEYFGMO6uX0bO6mr9pPTOlQil2s26FdOOuQ5ej
	RyJg3kCw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tANuC-0000000GUCa-0qla;
	Mon, 11 Nov 2024 06:28:08 +0000
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tANu9-0000000GUC1-1jF4
	for linux-um@lists.infradead.org;
	Mon, 11 Nov 2024 06:28:06 +0000
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-720e94d36c8so4424917b3a.1
        for <linux-um@lists.infradead.org>; Sun, 10 Nov 2024 22:28:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731306484; x=1731911284; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h+MQ8LBXw5PDwKxMHEr82155zLkpbExofGKGEuLjFDA=;
        b=M5bgbaGiSWBCKNBSoeha2CTY5f16pijQXdV/bm1Z4G/7kpCO0iMSBv2zhh4gxid8Gy
         yHSTN3I15c1qPLS4eyJEaj5hQ269R4c2/klKs3AqeQkKPsW1uJmEEfLTr026OyRcF2S8
         cXKAOb1SGCwdoFAcBULdWYLs4g8EO0RiQGfqlepfYyT4GU803LRgvzzBL2x/5awbqSqk
         kziKg1ir/iNtpm1xvDRKUvBeLLEfqDMnnXm9oyaivQwqiOKUMs//nyoSVGHPOX52jx+Z
         1KgZZ5x4CsEY1hkUjQO25AkBkUKCx3C0eb+XqkVe8xxiqH1NxXbweza4VAUGvOduE1Ho
         BJnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731306484; x=1731911284;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h+MQ8LBXw5PDwKxMHEr82155zLkpbExofGKGEuLjFDA=;
        b=OL93gbnK+lKNH0wShJnr04FZY0qpvfviAqAQfiKOjw01tSzvx7WUocbKyX5p15kdps
         WLSV4qcg8G1Kj6Ppxn6rNNfGRqSRV0ZFn2wIJ596DV7Yh6n6ZKqpEMdAAHt7SmPWMEaS
         7SVrBDGwLuRUZ/9Leij43ajyaCcNEXAkVKq0uJ6nWejxvlHImUIhPlFBdCLlbPqdidaT
         DUsPgt9giD3XHJdsbGj8MgwlaQR82IpO4m+qOSQh4/x4tLID9qPIjaLjxogWXNU3lbh6
         WM/dFQ1WUmNwxNknD75ZbseEEljR+9Y3Z82HY3WwcGYfOl4dXBhyu95rA1I460slMk7Z
         AGuw==
X-Gm-Message-State: AOJu0Yxa97/08wnpZ8jwxT3Cm1ZiO9gB/P9HyWsrZ5cVlFEwkgIls/ZX
	ImBd7XtFs2Y639ymnvrehYjCg0vvOH5gKV1hlqHopZzYYPWnORLN
X-Google-Smtp-Source: AGHT+IH6zGwWwtO1PBvl6k5+HYdx3OYEFfDs7V+DGavgoUmFx683YIwE67DreBe3Ghq2AaSrJtyEiA==
X-Received: by 2002:a05:6a21:3391:b0:1d3:418a:e42 with SMTP id adf61e73a8af0-1dc23321c26mr17047533637.10.1731306484360;
        Sun, 10 Nov 2024 22:28:04 -0800 (PST)
Received: from ikb-h07-29-noble.in.iijlab.net ([202.214.97.5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724079a404csm8533066b3a.126.2024.11.10.22.28.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Nov 2024 22:28:03 -0800 (PST)
Received: by ikb-h07-29-noble.in.iijlab.net (Postfix, from userid 1010)
	id 6893FDBA91A; Mon, 11 Nov 2024 15:28:02 +0900 (JST)
From: Hajime Tazaki <thehajime@gmail.com>
To: linux-um@lists.infradead.org
Cc: thehajime@gmail.com,
	ricarkol@google.com,
	Liam.Howlett@oracle.com
Subject: [RFC PATCH v2 04/13] x86/um: nommu: syscall handling
Date: Mon, 11 Nov 2024 15:27:04 +0900
Message-ID: <3ddee75eda49da14d9584e6be683e4db7fabd478.1731290567.git.thehajime@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1731290567.git.thehajime@gmail.com>
References: <cover.1731290567.git.thehajime@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241110_222805_477494_A3B05422 
X-CRM114-Status: GOOD (  19.92  )
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
 arch/x86/um/do_syscall_64.c             | 37 +++++++++++
 arch/x86/um/entry_64.S                  | 87 +++++++++++++++++++++++++
 arch/x86/um/shared/sysdep/syscalls_64.h |  6 ++
 3 files changed, 130 insertions(+)
 create mode 100644 arch/x86/um/do_syscall_64.c
 create mode 100644 arch/x86/um/entry_64.S

diff --git a/arch/x86/um/do_syscall_64.c b/arch/x86/um/do_syscall_64.c
new file mode 100644
index 000000000000..a1189ddb2b50
--- /dev/null
+++ b/arch/x86/um/do_syscall_64.c
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
+	/* force do_signal() --> is_syscall() */
+	set_thread_flag(TIF_SIGPENDING);
+	interrupt_end();
+
+	/* execve succeeded */
+	if (syscall == __NR_execve && regs->regs.gp[HOST_AX] == 0)
+		userspace(&current->thread.regs.regs);
+}
diff --git a/arch/x86/um/entry_64.S b/arch/x86/um/entry_64.S
new file mode 100644
index 000000000000..022a8122690b
--- /dev/null
+++ b/arch/x86/um/entry_64.S
@@ -0,0 +1,87 @@
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
+ * %rcx has the return address (we set it like that in zpoline trampoline).
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
+	addq	$8, %rsp	/* skip ip */
+	addq	$8, %rsp	/* skip cs */
+	addq	$8, %rsp	/* skip flags */
+	popq	%rsp
+
+	ret
+
+END(__kernel_vsyscall)
diff --git a/arch/x86/um/shared/sysdep/syscalls_64.h b/arch/x86/um/shared/sysdep/syscalls_64.h
index b6b997225841..f3a4fd76673f 100644
--- a/arch/x86/um/shared/sysdep/syscalls_64.h
+++ b/arch/x86/um/shared/sysdep/syscalls_64.h
@@ -25,4 +25,10 @@ extern syscall_handler_t *sys_call_table[];
 extern syscall_handler_t sys_modify_ldt;
 extern syscall_handler_t sys_arch_prctl;
 
+#ifndef CONFIG_MMU
+__visible void do_syscall_64(struct pt_regs *regs);
+extern long __kernel_vsyscall(int64_t a0, int64_t a1, int64_t a2, int64_t a3,
+			      int64_t a4, int64_t a5, int64_t a6);
+#endif
+
 #endif
-- 
2.43.0


