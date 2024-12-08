Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80F4AE77173
	for <linux-um@archiver.kernel.org>; Sun,  8 Dec 2024 10:16:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KaYTKVhbVioqVEgidynAWLBYqSObLQbp8Mdz5QpOLII=; b=oTNb/YqoITp2pmSmWJp5gm9sak
	KVzMckBJI3nIL/vXp1nXf2QSo4I+QRULP7B8EXI4BwYPc5hM4QenXbabyX/E+4PMIPhOhCfWq9IcB
	o5nmfF5JKb7+yUBPFE9KY4g9igJroYN9/bI11Djw8Uvo4v3cAkaRvznD81NN1CaDJpqut2TIkdyQl
	ncn86y3EpQrictZjGm3vpr6ijNFwG+Ad7tP+3Vr4A3d0sbKGiThw3dfvUy582Hi8TaUOeqouvI2Bk
	8aRLrVplGlf2HJIYxpp31u12rlh4oVHxDre3NZhyqbbul4SG3R3nHAsTkEZFGURx92VZdai4Xt8u0
	kMBpIc9Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tKEKf-000000057Yi-16Ns;
	Sun, 08 Dec 2024 10:16:09 +0000
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tKEKd-000000057XT-1c31
	for linux-um@lists.infradead.org;
	Sun, 08 Dec 2024 10:16:08 +0000
Received: by mail-pg1-x52c.google.com with SMTP id 41be03b00d2f7-7fd4c0220bbso101226a12.0
        for <linux-um@lists.infradead.org>; Sun, 08 Dec 2024 02:16:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733652966; x=1734257766; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KaYTKVhbVioqVEgidynAWLBYqSObLQbp8Mdz5QpOLII=;
        b=MfNQLTnCDz5h/qOgzqQka0LO7h891tlE7xD0egj0d51qz8PlZaytJwEg4Ya6Cce8PU
         UX4BK2igJ4hujO9vQm8ng7R0IkUaJ2/xUvPFjIrDbB+3CmjHm5lPocrd6u8dbHyUdeUP
         viH4XSvbkw6KBK0E2OaeGoOP4sOe0RxBlw2O9ZIbS3QQ2p6lU+aSGHn9TQl5fNK2stzY
         DR0zvDQ6bMDEea8doQKEfMIZrTy0TOXwcTlu4eQ6ro0t9Ox7lYTvSv8mUvmF/sEQQoWv
         fWCctPrz45K1y1VSTqrSf9bRrrGrgPjOJr4xhKIjSwrrD0UECp90fD5YUjFP3wBcP4Df
         eSCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733652966; x=1734257766;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KaYTKVhbVioqVEgidynAWLBYqSObLQbp8Mdz5QpOLII=;
        b=esNNAwYjx0MLvm1159Peh7lXJfJMjTzumYroUo3CWZ8wP6wsRWFy4e9ai3+cenOraV
         4mJe5D+OZFlvAQ6oKUcQcL0QFNLSbLeSsFATUDxNSCbtQqEFxPjcMHkNRTmf43lFzMud
         OMBSvC11t90ugCK4EsWQBXoDyTlxA3H9yd9ybBsdaO+8HRf6dqvBO3GCF5932sGk2Puq
         kXLZAtOBf/udyfDNXci/cphJKnAJJv5PO8mmkxxr/tL6b5rF7iYHkIia0ulw0jRJvd8B
         Ez1DlT//1cY6C+E6qZF9eu7wfVgo5uSfxZdahm1I5kKDCAGmBktWYKkca1h8/FSxjxRs
         OFCA==
X-Gm-Message-State: AOJu0YxJADZgk0/8OlZE2+8cNlMQtk03FAMEBblJkFMGtrvjdHwPkX8Z
	9207+dBxsjRs+ebztFbS8fF9Ge1GGv9kReobspwSpxY3hX3AoUKKgfrpaQ==
X-Gm-Gg: ASbGncuZZrquoLrQt7juDlHCY3WOiO5Fv4+anm7ZBZd+LTmNKR2SkYpMkncGuMeifwJ
	ye5mgv6J21Q6bHhc7sTagFA3v1/5zg6fdU0iJmVxuQK6rCGiwc4j508kbJxInXfp6flYs2FVQBP
	asWjOqbmcV7wwGD4Ub8ARyARHTu2lHFCpzGsIzefMzQmaPtKx3FNtYH9ulSleeL2Ty5e+GPN2Wp
	z1pYYddeH6+75GFx+ZwwHlKaxZ/gIu/M+AySLLNzGioPR1CyhuA34ZW6XCK41RXONCdRE4f5Exb
	RqXvI1O7nMJG8rsKN4Tv
X-Google-Smtp-Source: AGHT+IEyO5zkCdIXJAxR38NPafCES1idLeDN07L4x2zXLMNRkFtnQrGOYrfxVPH97jvgTyjRbTLE2w==
X-Received: by 2002:a05:6a20:8407:b0:1db:e0d7:675c with SMTP id adf61e73a8af0-1e1870bc3fdmr14230821637.13.1733652966399;
        Sun, 08 Dec 2024 02:16:06 -0800 (PST)
Received: from ikb-h07-29-noble.in.iijlab.net ([202.214.97.5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-725a29c5c00sm5633854b3a.1.2024.12.08.02.16.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Dec 2024 02:16:05 -0800 (PST)
Received: by ikb-h07-29-noble.in.iijlab.net (Postfix, from userid 1010)
	id 4E783DDB028; Sun,  8 Dec 2024 19:16:04 +0900 (JST)
From: Hajime Tazaki <thehajime@gmail.com>
To: linux-um@lists.infradead.org
Cc: thehajime@gmail.com,
	ricarkol@google.com,
	Liam.Howlett@oracle.com
Subject: [PATCH v4 05/13] x86/um: nommu: syscall handling
Date: Sun,  8 Dec 2024 19:15:32 +0900
Message-ID: <d6e76962e46960e3c77f8c75b0814987afb76ecc.1733652929.git.thehajime@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1733652929.git.thehajime@gmail.com>
References: <cover.1733652929.git.thehajime@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241208_021607_429713_AA852EA7 
X-CRM114-Status: GOOD (  20.67  )
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
 arch/x86/um/nommu/do_syscall_64.c       | 37 +++++++++++
 arch/x86/um/nommu/entry_64.S            | 87 +++++++++++++++++++++++++
 arch/x86/um/nommu/syscalls.h            | 16 +++++
 arch/x86/um/shared/sysdep/syscalls_64.h |  6 ++
 6 files changed, 158 insertions(+)
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
index 000000000000..c612a4c53c6f
--- /dev/null
+++ b/arch/x86/um/nommu/entry_64.S
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
+	addq	$8, %rsp	/* skip ip */
+	addq	$8, %rsp	/* skip cs */
+	addq	$8, %rsp	/* skip flags */
+	popq	%rsp
+
+	ret
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


