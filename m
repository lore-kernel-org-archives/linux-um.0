Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EC9BC7EE30
	for <linux-um@archiver.kernel.org>; Sun, 22 Jun 2025 21:34:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5RAxhnmhedCbVcYMwch2f12BZ7LCLjFr4NInIHPP8YI=; b=eY6BeJApugzk4/qH+jKXfLj/WY
	LVBtWjwU+JSM6Nd4shkMa681c7P0DGus8+ObTLOkwIA0hvBCifGpMb1xHLTrLafyKPC5QWMuTRGKD
	P5vXy0vwl3aTEgGi5E3t8eatY0zqFeGxsB9f7d4+NZVcd9/j9j5LkKC+bd0rXHGJnmG1dHgKzg+Sc
	li2+uL6fheTX0xNa0nVkaVxQp5YkS7hTjPblgwul+ggSxXz1/zpB5Un2UcdOVMRgk7AMS9x+6VYfR
	uckxzof+ZrHBDVGpycdEqIHoWDQx4rbE4H2pXfr9nPhW7d4FoiXDe0chdbTi0//yDVPAxlVdzO9yt
	EZ5kKeKw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uTSKG-00000001F4h-1gph;
	Sun, 22 Jun 2025 21:34:08 +0000
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uTSJg-00000001EsL-0mOi
	for linux-um@lists.infradead.org;
	Sun, 22 Jun 2025 21:33:33 +0000
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-74801bc6dc5so2693913b3a.1
        for <linux-um@lists.infradead.org>; Sun, 22 Jun 2025 14:33:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750628011; x=1751232811; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5RAxhnmhedCbVcYMwch2f12BZ7LCLjFr4NInIHPP8YI=;
        b=RHGcnLLfMQq4Cz6fhEhx6XNk9iywSLzbt4lvhyPvaKHJyKSKMw4JHSxHywa3Drh9qs
         sKqBqvfMDW40iFpJ8iOanJ0/opkztS9169deUviXkEJRPFZ/ikbGWFEBK9CxPX6fOu/X
         RBu6Wl8BO5p3JrUkVm9l+oXSB3hsNFup9B4KKyFyuVAZ/F9xQYbVK2OGZ2UXapptNDaV
         u1y2Ojp/qyqs4Gk4GGdMRPv1Mi187evv631tPehSRWi0Txbayfld00FjzmftwMZOqios
         08H6IfgcLQJH3P17rfxhHRwzLq3iVFoqVMEf2+0EGanhZQNzYDgoGmqYWxsmdcLu9xvl
         j1kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750628011; x=1751232811;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5RAxhnmhedCbVcYMwch2f12BZ7LCLjFr4NInIHPP8YI=;
        b=rnrxsXngRuBE9XEIGzsXoVbxm5mG6yhUlzrUTB78NkCXB3Wh20RMUMUjxrTxbW82zV
         XjsPHF8fSdzn11jwUNmuroYMGKXRHP1nPwqcXUsmp2SICHS83eR2p9nA1lnukGTQB5QN
         0keCGo3V07Fs21WiFp1QhATg9S9y/tVhz07Zh7ijRKIWZnPeejFjvLi3TAeirnGqLVr5
         EJgLExKwFWCdZ1LbaQfFGLZ/dINS7E3cwqLj60fq8Lc60wpUZQOAWM03arj+Yhybwxkr
         4QQ3TqA55GKAtaRiyaB83mO9bH87kjDN8GvcZPdFMu03pSRVPu2fuzhadxR7Z3zSFY7L
         xGdQ==
X-Gm-Message-State: AOJu0YzH6PXb9QPQE7ESnw38/QaiuqYAUyR7tcMDL7KGCpqVXjPJnQy5
	tm7coLeokfD+Wb7DwJ5dfIfvqdj8sYDXSDI6qcJtQfZq+9e5unyZQWFC9Ha2jA==
X-Gm-Gg: ASbGncsntVJukdYXgcks1Sr9L7gMoZpTWiDF5Bp9sFWNo14C5JUbG6C1p5i5lOuo41y
	c3pCdLam9cLTuUo0v7ppTf8A+xU73eOw1596X9+2omn6jW2EiBGSNl3nxAMDggfnhossJB6zXUs
	QlzmCLgvZK/cWj2ecPxR76FNizFyG+hy9goyjI7sHhj+3B11tZjbCqhRVM8Z8jBT+4Y8b2HGC3E
	8t/NCKaO/R4cF9ud4iFBSGpoo+08TQFERJNO75aAXLihUHa57xSKD17wJg1gmgUDm2jpd5Tiswu
	5bi79c1J/BN3iIQfRpx+OtUjjD8h+E0/WKCLCFnHgPQCfPqCFNXnJ/f1B1J7eayf1kNrsblgfWx
	HMwSmsq5kHesQ49VhSpvMI9tzsD561MV+
X-Google-Smtp-Source: AGHT+IFUHlTqUevwTXQzSa064MISHkFpoSR4ppWu4XfsTFKtBWOzpZZHg8+BGawYS5MSiaj7gUKlUA==
X-Received: by 2002:a05:6a00:2e03:b0:748:a0b9:f873 with SMTP id d2e1a72fcca58-7490f548544mr13040845b3a.9.1750628011304;
        Sun, 22 Jun 2025 14:33:31 -0700 (PDT)
Received: from ikb-h07-29-noble.in.iijlab.net ([202.214.97.5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7490a621cd4sm6859224b3a.105.2025.06.22.14.33.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Jun 2025 14:33:29 -0700 (PDT)
Received: by ikb-h07-29-noble.in.iijlab.net (Postfix, from userid 1010)
	id A38BEEF1EAC; Mon, 23 Jun 2025 06:33:23 +0900 (JST)
From: Hajime Tazaki <thehajime@gmail.com>
To: linux-um@lists.infradead.org
Cc: thehajime@gmail.com,
	ricarkol@google.com,
	Liam.Howlett@oracle.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v10 04/13] x86/um: nommu: syscall handling
Date: Mon, 23 Jun 2025 06:33:02 +0900
Message-ID: <c208f207a42a5d7ae3aa15de94ff372f9d755630.1750594487.git.thehajime@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1750594487.git.thehajime@gmail.com>
References: <cover.1750594487.git.thehajime@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250622_143332_226932_93A3DBA5 
X-CRM114-Status: GOOD (  20.80  )
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
 arch/x86/um/nommu/do_syscall_64.c       | 25 +++++++
 arch/x86/um/nommu/entry_64.S            | 91 +++++++++++++++++++++++++
 arch/x86/um/nommu/syscalls.h            | 16 +++++
 arch/x86/um/shared/sysdep/syscalls_64.h |  6 ++
 6 files changed, 150 insertions(+)
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
index 000000000000..6b08daab6afe
--- /dev/null
+++ b/arch/x86/um/nommu/do_syscall_64.c
@@ -0,0 +1,25 @@
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
+	if (likely(syscall < NR_syscalls)) {
+		PT_REGS_SET_SYSCALL_RETURN(regs,
+				EXECUTE_SYSCALL(syscall, regs));
+	}
+
+	PT_REGS_SYSCALL_RET(regs) = regs->regs.gp[HOST_AX];
+
+	/* handle tasks and signals at the end */
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


