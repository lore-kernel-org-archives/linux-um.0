Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6506CCFA1A
	for <linux-um@archiver.kernel.org>; Sat,  8 Nov 2025 08:06:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fo64Q14KD7RJjz3s47AhqXDA7DbhSnhy3sX7mHpz33g=; b=w2W310HTW8M6a8qoA/yxT0jGjs
	/cOCvc2TJwxaxrg+Ts/Zg3olG7lowojs+M0wprU9TMVrUa7VqiCF65wmtc3xq9IG4s3QBs0w16IiY
	P41cqu1VbI1QP7WxfljSe82F7vPUmpAlQ9z4jvlt1SGfESXrTYGo7i1RCGGlpVlxDYIYRNBZdira+
	OGUEY+Q/M27/TcIBsqy6MJz3XaouhDZvPEz7JMFsuQ3L4+capOrZ4LG0/YBk+oyUWTH6/dw2x9s9I
	4ztgal5n0fmqomDTc1AaofCp4yMOWP1Sy7/7Z/c4MGn+I0Jwwhbxdjtsm9joPq2gitTku4bygVP5F
	1i1GLuCg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vHdxZ-00000002ivQ-2lgu;
	Sat, 08 Nov 2025 08:06:09 +0000
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vHdxX-00000002itY-1OPL
	for linux-um@lists.infradead.org;
	Sat, 08 Nov 2025 08:06:08 +0000
Received: by mail-pg1-x532.google.com with SMTP id 41be03b00d2f7-b9a5b5b47bfso833008a12.1
        for <linux-um@lists.infradead.org>; Sat, 08 Nov 2025 00:06:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762589166; x=1763193966; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fo64Q14KD7RJjz3s47AhqXDA7DbhSnhy3sX7mHpz33g=;
        b=leMQfBVGQZjwGztuR4TED5RRLIjoDfvQxG5VjxGq1YVbLQ8Hm2sQC+yFHU91s+liqm
         WhG5rmQGa3349bwLZWwk2g1LptGx/Z0mau810eLpN3n59AxZDlABFpTGZTkDlyXPFbH+
         Ijuq3uhSsPFqgoorULO6Og8+9bP/FLazHAhq4jlwFGW69Dndw0GZRs8Ps7l1snNtIk5T
         vdq1pzGRF7cPz4pvDr3uZ8/QdmmG6SfOK+DcMZ1acAqBBO7ccYLDE0dAQUH9jVlbaBj5
         9LVYnvPCBKfZ9zMNdZBZTayEGetAwqhNloglvYLEHXGdWkNnNFUlHGyc4gpO5K4ZSaXx
         Mpag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762589166; x=1763193966;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fo64Q14KD7RJjz3s47AhqXDA7DbhSnhy3sX7mHpz33g=;
        b=iLZIQVC5x3Lc8Kosu0AXDhlnx9KglUnt+HrvCPQ0r509artjrpCxByUPmomhmtwuRQ
         WOdQ1MECMaLayXpCSvNelpSbl28bo5H4bQs9JCAWKLF+SCq3aK77KuIlSY0vHX62tp5O
         43pQrbm3F8HRzJKQYJB8XIGThDJPVBz/unFavDY9qkLh+WuGhNGxJZfgc0kK5Z/1ZJ8G
         GK5dAvYc3mZiJCcy7jvRGdUdqNygZ57Xw+Jg6mwQkW0Vn0N9im9LGQXuNYgroxO8SV2X
         aetbjGl2dkl7QV/Hl4RmVPnesYc85PBGEv1EDeGNog35UWdW36avxzI8RIac/H/Dy564
         a7kg==
X-Gm-Message-State: AOJu0YyfT5AAZeOiofAOidc5F3Y0LY0d+/IdTO/PZikyRA5qiyI7/N3l
	Tr3eQTKirzzVdufA4azquCvs9KE7gsj4EDoizmPzLcc4xjdBhexttUsj
X-Gm-Gg: ASbGnctuam/3VG1JpDlUDgaqCn6JlN9iJxCwRJosYx7hsm55taJzxwaGfQeobkjUkpc
	C/A0+QEMaFXy71OICvJuJvvDi9XzwiPPiDCmxmFzvYl5rIv0/TYLI1owi0+8JColkagDThGSo5z
	Rscy4g25gZSULccyeiDaIj32QsxxpfXe0Nm2KauBwfj+9z68PdXJafEcwzjHK4KDIybqEcu54Lr
	udB46jpCxtUxPKtATLGinJ01C6ljkofdwAFCf4PME3hqq6xIt1cX4XHdN/xVTf2diKkj/Iecula
	PAw9aGg/l2leCBZUiPHxhxxo5U8nXuhOJdVRo4x9jKmHo9Y9tyGjc7wCpq6VAxm8J8cTZxfR7p6
	unVRYO5tkc8yDodPendxayjx4gSh0cMFthH6f2wUi3zOuRLdhkVLNu2laxlfmlqdyXghdaLo9nI
	EIeMSy7IpYhR91CM9Pr9BhOG2Pw+6dvFwXT5pcWa/+Eqp62Q==
X-Google-Smtp-Source: AGHT+IEuRYykMljnZYhL+TbH5FurVSKavUEug22jUuvZ3baInb7oeHFpVuOBsBNWV5IN8PKWIaLSRw==
X-Received: by 2002:a17:903:1b2e:b0:26c:e270:6dad with SMTP id d9443c01a7336-297e57151ecmr21195745ad.60.1762589166317;
        Sat, 08 Nov 2025 00:06:06 -0800 (PST)
Received: from ikb-h07-29-noble.in.iijlab.net ([202.214.97.5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29651cc6595sm81710455ad.98.2025.11.08.00.06.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Nov 2025 00:06:05 -0800 (PST)
Received: by ikb-h07-29-noble.in.iijlab.net (Postfix, from userid 1010)
	id B755E11388CD; Sat,  8 Nov 2025 17:06:03 +0900 (JST)
From: Hajime Tazaki <thehajime@gmail.com>
To: linux-um@lists.infradead.org
Cc: thehajime@gmail.com,
	ricarkol@google.com,
	Liam.Howlett@oracle.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v13 04/13] x86/um: nommu: syscall handling
Date: Sat,  8 Nov 2025 17:05:39 +0900
Message-ID: <b23f1464f32b0701b298b0f43bc0aa0e5de1e6f5.1762588860.git.thehajime@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1762588860.git.thehajime@gmail.com>
References: <cover.1762588860.git.thehajime@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251108_000607_385776_32615016 
X-CRM114-Status: GOOD (  21.55  )
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
index f9ea75bf43ac..39693807755a 100644
--- a/arch/x86/um/Makefile
+++ b/arch/x86/um/Makefile
@@ -31,6 +31,10 @@ obj-y += mem_64.o syscalls_64.o vdso/
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


