Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C32B5CCF9E3
	for <linux-um@archiver.kernel.org>; Sun,  2 Nov 2025 09:49:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MNruZWOB1A9W2xPWfDeeJw/PtthshopimV+lzxEm4to=; b=s2uYsnEscFk9/J7w+XRs3QBdRY
	M/Vsijzx7t1YrJV2WRSjWUA5AY8YEVzGHKW33ihi4jD+rHwvNMzFNLL8V39GsLntULkitZgSNWFGI
	3GE/9LYqEJgvZG/0uFJKp+/38s0PzjyE3+jlJ8Zjju+IrB/dab52uhEr+F2NqG6T1Y8ztCnugbXPE
	9wkfanK2i6d6wY11BAkFmma4GYeVhysqFOZzg5dyVymQQgfWzV0QDZvU2UUwCqyWVhL+YkwyWKcUS
	U3JFKO++83B7x4Gu7CHJxoQjR73Axr8PHZGC4+9VL1+ETX6ZICRts/dcc97CVWOabu8MKjjH4sPlW
	VFtGTZ7g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vFUij-00000008RoP-2Hcb;
	Sun, 02 Nov 2025 09:49:57 +0000
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vFUih-00000008Rmk-2WTC
	for linux-um@lists.infradead.org;
	Sun, 02 Nov 2025 09:49:57 +0000
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-290aaff555eso32065015ad.2
        for <linux-um@lists.infradead.org>; Sun, 02 Nov 2025 01:49:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762076995; x=1762681795; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MNruZWOB1A9W2xPWfDeeJw/PtthshopimV+lzxEm4to=;
        b=JazGACRrAgvfKhJyTL6c8U0gseVx8vyXYfCpmsNBDtszQAyjV+eBFYlBo0aVgyseZo
         sr+0CCW3tlC7bpMING78Ap9c+deG0OVeOXjhaBdMS6UBkX9tHT2QzugboMIXi7YvU5Nr
         YE4twDIMAHmSD+zg4mjBf4RPJq6aBo1Vc590F+xUM5EUiWXkPt+0QPZ/22hezAQphnTq
         z62wbhTbF1juRQ9ziq/kbRbgMRWYERhax0cIV9oWFCok5yqt74g5ujLiWyWO1Z8qHwYI
         Qp+rzsTNygjeFnkbtK851U4U9pj88FFdm1vm/wL3sGpEph9WIZo3uUjKW/HiMW8fVDq5
         haJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762076995; x=1762681795;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MNruZWOB1A9W2xPWfDeeJw/PtthshopimV+lzxEm4to=;
        b=IZYKlAgvMBxYFbHHyZJ8q0os1vxgj1LTy1ZpmcUn6GFmrBr2+qNq6lmowsDvmPr2MD
         zrjlolcvdoQlDf23aCb8aqb3xeYL7USxt5b5jKCpN+LjZfHmZBqy4xlAcHmFR0Lc/kFd
         WXjK6MRHA+ITbUCLo8o0iDNh2aML2kCID+Arq7+ho6E19ZJJ6xieEZGzCQGLw6gBdU/U
         6cFddkNTN/9AMKiw7JATq3WJAOvzs/q6tJiFeGFsHUUh5zXJKLvZBNB/hV/uQ5VYfgoX
         PbVhQ1bNQK8fUrtCePDm7sOGtZk9eR+tYhnl21f+HifWLOcAyXZVXgG5JwOhHeMwetK/
         c8pA==
X-Gm-Message-State: AOJu0Yw3f8feZ8RR+0KTkMkhDPr/0hweNR+RO04+ZY8l5yFD/Vdvmgq0
	/Lod8YK3POScPMYU9QFhl7KF2dZ52KsgLlfFp/2nZQ+2qo3OndVnhy+8
X-Gm-Gg: ASbGnctmQNfLW7+ywJgdifQ49TERxT4jLoq5GY7LsxfVrpYSzQVfic4FM2+LO7Xjm45
	WdoKVvKtwRaq6Slwsa+jbO0P06ysjk3tutcfsX+KTQCDBfEDrNY/QB+pSeSYGi8ilo7+5yNdn+q
	qky7ABdg+BqQgEq07BUE/bjKiJEk5q0GHrf55RZsd2gUopgXgttG7eVzoJwyqSvDopKi5fFikmL
	WtU4Kgu9FZa6iOoGi2YOx2DDXxfTd4jFvX8u4YictMwm+5U9kv+mV+Cgex87xSdZfxn7lXjYa0v
	yU2nm0hGc88jQjT2f3sVvhJFjqRO+r303MFmkujIyaIH0MXW9DlCqjBVT0TmYEOE2RR0RfltKNQ
	aTgOK7cdH9ZnBTF+C+BFNKCthV1R5oSPPYIa+xcJh2QSKXlJ35h5byriPg0vKhlurqvM63UElK8
	QgZrfs9BU6NKOz0ppJwFUegXrPqOukM2kfcQEhgTTxn/n4mR6/vhmJp+EF
X-Google-Smtp-Source: AGHT+IFkoW2S8Nm2549TybzP/Qjnm/HVrzvPiD3jHPwRPqbA7kzapN9ZpSAsI/ISg985qkSCINlgQQ==
X-Received: by 2002:a17:902:f68f:b0:261:6d61:f28d with SMTP id d9443c01a7336-2951a4aa201mr116295275ad.50.1762076994796;
        Sun, 02 Nov 2025 01:49:54 -0800 (PST)
Received: from ikb-h07-29-noble.in.iijlab.net ([202.214.97.5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29564fb531asm38273845ad.14.2025.11.02.01.49.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Nov 2025 01:49:54 -0800 (PST)
Received: by ikb-h07-29-noble.in.iijlab.net (Postfix, from userid 1010)
	id 0686F1123805; Sun,  2 Nov 2025 18:49:48 +0900 (JST)
From: Hajime Tazaki <thehajime@gmail.com>
To: linux-um@lists.infradead.org
Cc: thehajime@gmail.com,
	ricarkol@google.com,
	Liam.Howlett@oracle.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v12 04/13] x86/um: nommu: syscall handling
Date: Sun,  2 Nov 2025 18:49:29 +0900
Message-ID: <c4609c653db31ec3a6595bb03f34d2331cf9d543.1762075876.git.thehajime@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1762075876.git.thehajime@gmail.com>
References: <cover.1762075876.git.thehajime@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251102_014955_650268_3A77CA46 
X-CRM114-Status: GOOD (  21.72  )
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
 arch/x86/um/Makefile              |   4 ++
 arch/x86/um/asm/syscall.h         |   6 ++
 arch/x86/um/nommu/Makefile        |   8 +++
 arch/x86/um/nommu/do_syscall_64.c |  32 +++++++++
 arch/x86/um/nommu/entry_64.S      | 112 ++++++++++++++++++++++++++++++
 arch/x86/um/nommu/syscalls.h      |  16 +++++
 6 files changed, 178 insertions(+)
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
diff --git a/arch/x86/um/asm/syscall.h b/arch/x86/um/asm/syscall.h
index d6208d0fad51..bb4f6f011667 100644
--- a/arch/x86/um/asm/syscall.h
+++ b/arch/x86/um/asm/syscall.h
@@ -20,4 +20,10 @@ static inline int syscall_get_arch(struct task_struct *task)
 #endif
 }
 
+#ifndef CONFIG_MMU
+extern void do_syscall_64(struct pt_regs *regs);
+extern long __kernel_vsyscall(int64_t a0, int64_t a1, int64_t a2, int64_t a3,
+			      int64_t a4, int64_t a5, int64_t a6);
+#endif
+
 #endif /* __UM_ASM_SYSCALL_H */
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
index 000000000000..292d7c578622
--- /dev/null
+++ b/arch/x86/um/nommu/do_syscall_64.c
@@ -0,0 +1,32 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/kernel.h>
+#include <linux/ptrace.h>
+#include <kern_util.h>
+#include <asm/syscall.h>
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
+		unsigned long ret;
+
+		ret = (*sys_call_table[syscall])(UPT_SYSCALL_ARG1(&regs->regs),
+						 UPT_SYSCALL_ARG2(&regs->regs),
+						 UPT_SYSCALL_ARG3(&regs->regs),
+						 UPT_SYSCALL_ARG4(&regs->regs),
+						 UPT_SYSCALL_ARG5(&regs->regs),
+						 UPT_SYSCALL_ARG6(&regs->regs));
+		PT_REGS_SET_SYSCALL_RETURN(regs, ret);
+	}
+
+	PT_REGS_SYSCALL_RET(regs) = regs->regs.gp[HOST_AX];
+
+	/* handle tasks and signals at the end */
+	interrupt_end();
+}
diff --git a/arch/x86/um/nommu/entry_64.S b/arch/x86/um/nommu/entry_64.S
new file mode 100644
index 000000000000..485c578aae64
--- /dev/null
+++ b/arch/x86/um/nommu/entry_64.S
@@ -0,0 +1,112 @@
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
+	jmp	userspace
+
+END(__kernel_vsyscall)
+
+/*
+ * common userspace returning routine
+ *
+ * all procedures like syscalls, signal handlers, umh processes, will gate
+ * this routine to properly configure registers/stacks.
+ *
+ * void userspace(struct uml_pt_regs *regs)
+ */
+ENTRY(userspace)
+
+	/* clear direction flag to meet ABI */
+	cld
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
+END(userspace)
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
-- 
2.43.0


