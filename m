Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E546EE6C5FC
	for <linux-um@archiver.kernel.org>; Tue,  3 Dec 2024 04:23:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lfkW41GVXpdrGYNKLilpS1h/3SxPLSs2eiFFDXyWjBo=; b=GbwaL3x+30hhJDZTwqGjZp96XF
	FENS+UHGPsXKbLoE8z0kotZQVJwFtmf6c8ZxNMwyGVoBRqI4zU1lqOek5FXmagGk08esI72neFeup
	mbnkF37UslQ/uLCisrtzTLEVc1QjZnUZaPfmoMubbYsBUgXExXJ0QTIoWzHQ7LFGa7sUWNCB0mR6T
	TMONxkuSdwJA2l1FT3YFWzYGbOLaMUMWUrqWJZkrLogbghf+sw5jO2mhnPK1IeJQ5M8Q4JMa1Tpp+
	+fhM64GRXa42haUEPfvkaMCXwBe79nfNoeOhIO5P7aZPjkPuE+Qbg+8cn0DpTm4/9GDsPBcoRz1nN
	V45gkDrA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tIKRo-00000008DM9-2sUi;
	Tue, 03 Dec 2024 04:23:40 +0000
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tIKRm-00000008DKS-348K
	for linux-um@lists.infradead.org;
	Tue, 03 Dec 2024 04:23:39 +0000
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-21288ce11d7so46098325ad.2
        for <linux-um@lists.infradead.org>; Mon, 02 Dec 2024 20:23:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733199818; x=1733804618; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lfkW41GVXpdrGYNKLilpS1h/3SxPLSs2eiFFDXyWjBo=;
        b=AgVe1gnNVVPsd25mP0PzSM2U3I1tumZngElLXlsGUenKvf5CCVxryxAIdmUjJqVhos
         smp5QBGL32yqwJU5D53i9IEp3lDNNs8bXErYMAKbJFcFOvc9Yo/6PO9RTTVeKo+S24CB
         SAFsC2Lg3EGdoV27LK43khLVJaYHfEySeR+4RChmvAo0h/I7/2x5XtSwAC6l9R8SgsN4
         gOOU63EVt0RfoU4ubL6t/mJk5CAMURE5jYsR6oHlthI/Uwm7miGn0R4Co7+bm+DduNrT
         CRXVsIbhIBHToPKzJUfbCcKZynB4kcHCp3WWQWqsir8cjNBg2q2ir8I4Btr/9RaFVg0g
         uF/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733199818; x=1733804618;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lfkW41GVXpdrGYNKLilpS1h/3SxPLSs2eiFFDXyWjBo=;
        b=p8zbMgKJjWN5kRztTHRphproBxLRvNxZSkBqMQttkITULIW9WkuD1GO3ASY9Yyo2wj
         bQpuPxgJQTUu4gc9sj46rl7rOSLVitaFaqC33XjQpLW4EJvgje3OaLWRx4wgVv9oWJpw
         Cr+pPeXo0O5eEs7MnHkSxI1QpRSIgNIKZupAfTik1j+H3U0YGOiWVagFF53zHLgQsE/+
         PMc8wV5Z1mje5oL/YbEXqBgU0XRzcSYEoj79sST1HIBmmnddVZ4mLyu8kJ+joe4eLjC8
         ocF/F4T1oYzTA/orduhWf68w01N5jR+o31/mMexztsBe7zGWPEZPjojBJLrf8XWhkO4V
         F90Q==
X-Gm-Message-State: AOJu0YzzkdHQh2nFLVULg4j2z5tM9oJdd7+P6PkD0F6V8BuhYki9JzHj
	QHztCvhek4CDAAw8GEn9btHIF8BCx/iPPkL22AnG6oUWT02k34Yvgs6WUw==
X-Gm-Gg: ASbGncvwQMmHajLW/BSAUsy0j6Az2o1YWANTkK+bfRE39TI004IuQamAIHN3uGg/7Qp
	yh6Wrli73LEBPvCZnuu3D2SMQcFcGh/w0+r7KyCX/jQvq/nSQH5aljW7brxBj/0jKk+QpXUOL6x
	cM6trfCVIeFv7M7MRbdcuK4eF3nWhDXQRBOUS3lclhxdP9fvZauWBQuXWDRLn69IeAbFCD5ierv
	2SI4ihk0Zz0SKmcaMvwwQ8QyjiZh8MAc63Wa9u5JrgSkDDJX7yhz47SLqNKxhcCl+iZ45uO1Oqr
	6EtYfwuVn6/4YwbyIARa
X-Google-Smtp-Source: AGHT+IG3vH3vYvijVWmJPRq31jy2wHcUNseUvczrVo8pBhCXQpVB7XdJmll+Lkjo5mwNw6OH6QPOBA==
X-Received: by 2002:a17:902:f683:b0:215:b5c6:9ed3 with SMTP id d9443c01a7336-215bcfbc565mr13966595ad.12.1733199817787;
        Mon, 02 Dec 2024 20:23:37 -0800 (PST)
Received: from ikb-h07-29-noble.in.iijlab.net ([202.214.97.5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21548e144b0sm63688155ad.68.2024.12.02.20.23.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 20:23:37 -0800 (PST)
Received: by ikb-h07-29-noble.in.iijlab.net (Postfix, from userid 1010)
	id AD2D6DD39FF; Tue,  3 Dec 2024 13:23:35 +0900 (JST)
From: Hajime Tazaki <thehajime@gmail.com>
To: linux-um@lists.infradead.org
Cc: thehajime@gmail.com,
	ricarkol@google.com,
	Liam.Howlett@oracle.com
Subject: [PATCH v3 04/13] x86/um: nommu: syscall handling
Date: Tue,  3 Dec 2024 13:23:03 +0900
Message-ID: <682460c3db1967aaa041b7e14342d48be3604c04.1733199769.git.thehajime@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1733199769.git.thehajime@gmail.com>
References: <cover.1733199769.git.thehajime@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241202_202338_766300_8BA3B8E2 
X-CRM114-Status: GOOD (  20.49  )
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
index 000000000000..5d0fa83e7fdc
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
+	/* execve succeeded */
+	if (syscall == __NR_execve && regs->regs.gp[HOST_AX] == 0)
+		userspace(&current->thread.regs.regs);
+
+	/* force do_signal() --> is_syscall() */
+	set_thread_flag(TIF_SIGPENDING);
+	interrupt_end();
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


