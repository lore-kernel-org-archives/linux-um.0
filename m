Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8D15CAC5A8
	for <linux-um@archiver.kernel.org>; Thu, 18 Sep 2025 05:16:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MNruZWOB1A9W2xPWfDeeJw/PtthshopimV+lzxEm4to=; b=PqOfH2fHMaJaQDSKA4L230/syj
	0e3eSrOkHWogU/cJT9jHjrYeYVxxV+Cs+TGc16ZBXP8OUNkiV+R0g+DSDC/FIxEpEw06dmijiXl5Z
	Z9lbv6pDVm/khCfJFH7vcm9bX+F9KXqAQg9x+yAzaSF1n9cTZNdaFE7leO6DKHrxxHVqE6vTXRqeb
	HRzBt+xEkOMlV58UKB7r/gZE78Zkzzo7PvYaOGMnoHiQIVBf8zluwQjN+AgXhXu+zf46yULwmqwF1
	5kxnUUeiVueq6TLTodubs/7Zfr69kRqK11GqPVjuba3HL+T9G2ir8BMWdHd3XxKENivYGSRcuTCru
	9sgIN3UQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uz70X-0000000GI9r-2CyA;
	Thu, 18 Sep 2025 05:16:37 +0000
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uz70R-0000000GI66-2VA0
	for linux-um@lists.infradead.org;
	Thu, 18 Sep 2025 05:16:34 +0000
Received: by mail-pg1-x52f.google.com with SMTP id 41be03b00d2f7-b4755f37c3eso432520a12.3
        for <linux-um@lists.infradead.org>; Wed, 17 Sep 2025 22:16:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758172591; x=1758777391; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MNruZWOB1A9W2xPWfDeeJw/PtthshopimV+lzxEm4to=;
        b=KWSesbypweQKt0rqgQdv/q8TWzzlpKUk/ZTmG6Nb1zIKQg4ARHkOM3TnN7gxOTlqfj
         kgKZN/H3vcq/vsWTshH5ODRvdBXUgcxsbyGQ/xTzP3pQKYvpgNvw4tKXSQa5uBCnkfjv
         uVagusbCPJDcXWKXVtLJ2kDNkrKIb6kSK0Lp1BNvh2UT0l7lCxdBr2IxWePp6YZ4nigq
         mHS/8wcQb3tZmvNvRlEIrkWQLzuRUuN9d2FatpGkGYRTdjA604e67TfAn6X62qbqAbC0
         AfelepI1fsRY4dXLa8P29eaRiHkvLn5nTrrBeU/9oeQL2hbRBCmrIoT5jmfw8R4lyDSZ
         lXdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758172591; x=1758777391;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MNruZWOB1A9W2xPWfDeeJw/PtthshopimV+lzxEm4to=;
        b=QhNjlcHr8VDU9p6kvsdSfNi+DJSLw4zo9gGAhxTj+eX4ZAcB4eNggg4aXKg15oAt1n
         63H3JYXt4+/aFjfiXlHmGiYKf2+b+NoUmgwGjaUhqoC9YRFyxcgVOo4Q+3ZsdptUwQOk
         Mj0/NsXQaV5zaCQTP23G1eY0+iPjB1ZGG+2SOdlwn0R50wF4U9yC61lWUGfXsYD5RMRL
         KoxJYRoEnJ4c8KbbqZe8+mIwC0XoZ66oEfLXKH/fyH4X1l3jd8ZmFk2+VrgDPGCOXCbh
         UV7WJSGyyMEj88oj8my2c7jiElcnSuRC/5ZEpsV2OsxX6LrPYtP/8jFMacWwJAO20tj+
         pJMg==
X-Gm-Message-State: AOJu0YxpMaO2U95cPR4jpFG6jQqUk+k8db7UTymRv3KQRBWbCMpn1tF8
	tboKI8qAWu+cdKzv6JnCzuCM6MoXa8tuBSD6wIzKucBeWzpsIQgJLhZbsms/DA==
X-Gm-Gg: ASbGncu1hqHocHEdDw773YgR62CtU/P9YcPeOpbvf4sDeekv0/xBe0LouWujleTdUbq
	prHASDJv1obgsx+L9mH7rVVJFbMLgBGJIbFSsD6xG9cwW/Yicys2xxI6bSBzeBCkMlHc+uYCYKc
	b+A0YaRRliIMl0OtM9oQ4glAB1z4nHKiSt3CnHto90EsiNlVwEc0y4YgyOOzgMKSIJuJYgV3KR+
	S8Ev6EWn640mIN/+cZk3tZpu5KcFiNo6nJAlC2iI9zloqd1eaNuYSHtyDR4niEmFIJMMdzBYuOF
	LdYMgZtWeftdrNSpzXpO7hTr9RS2TgoOygR3STIzsUsD/cYIdO5fkKFNmmDNsuzOfLvUaLfDl1p
	rB9sOmJESCWUxgOV9Oe1BeYyy8xI64XZlaJDK5cVtOS3QE6CSVd2oTSF2qvdhbtAChN19rZyhtL
	jfv+LqSGpjrfoRJWDBO+sOyg==
X-Google-Smtp-Source: AGHT+IGDcPCTQRDQJloTH9BdqlAOj6e2/TUJJrtVUeXUVjBEic4MtyF8+jxmHyt7EO3Nq8kgKfGCdw==
X-Received: by 2002:a17:902:d504:b0:258:9d26:1860 with SMTP id d9443c01a7336-26813902e19mr67208525ad.40.1758172590685;
        Wed, 17 Sep 2025 22:16:30 -0700 (PDT)
Received: from ikb-h07-29-noble.in.iijlab.net ([202.214.97.5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-269802deeb1sm12286825ad.78.2025.09.17.22.16.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 22:16:30 -0700 (PDT)
Received: by ikb-h07-29-noble.in.iijlab.net (Postfix, from userid 1010)
	id 4EAD71061EE8; Thu, 18 Sep 2025 14:16:28 +0900 (JST)
From: Hajime Tazaki <thehajime@gmail.com>
To: linux-um@lists.infradead.org
Cc: thehajime@gmail.com,
	ricarkol@google.com,
	Liam.Howlett@oracle.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v11 04/14] x86/um: nommu: syscall handling
Date: Thu, 18 Sep 2025 14:15:57 +0900
Message-ID: <99a54b96cee85275692ca01fe4a0ef0d83996f0f.1758171893.git.thehajime@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1758171893.git.thehajime@gmail.com>
References: <cover.1758171893.git.thehajime@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250917_221631_644695_738081C3 
X-CRM114-Status: GOOD (  22.19  )
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


