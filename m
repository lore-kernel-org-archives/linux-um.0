Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0E35C02187
	for <linux-um@archiver.kernel.org>; Tue, 14 Jan 2025 11:32:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=V/9FDFFbTGgOECfx9E1KzmmWlTydkD+KFqPPHo/qkbE=; b=Xq6JAkU5JTgN0MEOVuui6BM1me
	nuyie68cis1IArwzxTO3UJJ4jdpvlWetDIXU3U3awqo5eMIjoofDJ5vVzZg+HZx9NTDsWx4SWDclh
	28652lsQ6QRDNb5KrVHao7/s9228ATaUJUOX2Qm86z2MDSqIamjnwG+sXODjgPn/13/PdyjJhhWPa
	rCAz07YYHadImN4joql5VBjIuRRZgg5Eo33LnEVurj+dm1WxWufqeEr7xmh0ctNHAZRq6NnvXjWF1
	DmTaEttfchhpBHXLvEJH2S8VJq91BsxR2CxvKPZID+cTD/BkSx9mn4O15cIwI/FAV/vidrtbPvnMw
	CzXlfGEg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tXf9b-00000008GKI-1YpR;
	Tue, 14 Jan 2025 11:32:15 +0000
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tXf8Y-00000008G3P-3spA
	for linux-um@lists.infradead.org;
	Tue, 14 Jan 2025 11:31:12 +0000
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-2165448243fso113897585ad.1
        for <linux-um@lists.infradead.org>; Tue, 14 Jan 2025 03:31:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736854270; x=1737459070; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V/9FDFFbTGgOECfx9E1KzmmWlTydkD+KFqPPHo/qkbE=;
        b=Zc5AsbO1wDP7KeaFsa9yt4kHl35n89Coy8i60ajo8rnDLXAlnHiVNMXdLS2XT0Bsem
         MGXoZvUijWUtWgfsQty9ub25gE+v938GBEW2NJ/VvvBVLQJRKpw5hEAXZ3ZAwRUYk6Mb
         sVw4Zy8WRM0jgrvsaLia7y3ZZSPAqaaenzZ5Ri2pmMypspjFRHJwOPnLYFCzHj8/q5tn
         q72jh0mnkK8zYCGK0AJXoE81Gv4kBrGr1wiBkZGlnyPSl2UzwDV5AxDjJm+R8zBbbyV0
         SW81Hg06zBnEc6oJ9EpXJ3vn9eFEwr3fwWSAkyHw/94ziWnE+IJ7q7NGTbBNkNTzkmoM
         lCSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736854270; x=1737459070;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V/9FDFFbTGgOECfx9E1KzmmWlTydkD+KFqPPHo/qkbE=;
        b=pLBSrQ7HlXsmjoZXVGkzyOAqPLyqJ7yTcQiqigtWQ4w+texokaUwnhhx3NHPRWIdNB
         +yrd/ghTtl10vcKvSxY5pkuQxgRfDeJwenr/cTlvTBzhZssjs58ruVAxOIIgWtNt8Nx3
         CnQXw7KmH2aNBdTE+9Xv/jqo/jersgK4ivwP9YLyxHUSoZc5Hl5p3IQisSnPk57sliqB
         ObieXdKTbPvM3P973Vvih5Nkfxk6hKoBX3F/WNBTPDlWX7MgYEXh0FLdB0KM9d2T+jHM
         YNGxSX2l5IV3Kns+fDx9xdEiWyw5LEhq8FMYoUUaaoPO3+GoKX1bZaIClkQNlv8qW8F6
         2DSg==
X-Gm-Message-State: AOJu0YxWsTFE0OBrfa/AGBvSL1+VwB7DvQwyT+0qYFkk18J4m3TrtSsY
	n7nyaCX/W24esVfLkICGJwp5OyZjETrRMvv/A7Dcot82JZdACEyx
X-Gm-Gg: ASbGncuU7Syq1l9gsf6zTmLqhW5c3swykY9jrGtYMu/2WFQl4nH/I11dl8vOac7wd76
	6ain9d52AkswmNfxFN7TeIxFOBk7lXnpHBckPtwb4lxU5ncGDPVX6OTigHTudAnrIixGbgSW15o
	KhVJe3jBRthrNTSFUcFjGWIoaaChnqofz5AfPB2o6INx9QVflWKprGx4aJvNTCz2wrnmYZoGUtu
	E7Xc3ZOrPrlK22PaElryvNgwYd7XjEvkxAILgR8XIfC6qQHoomIL61pK28s29Mpd62c6zUz8jOj
	OBzAgG9s5jP2n8XUZfLOKkFtB5++
X-Google-Smtp-Source: AGHT+IF+N+VcjGTpCsdynfFFLiMyHCqzHYmRchLLGgt0UEqkGtBWXAjUuKerT08JmJ8pN2cDcW4u6A==
X-Received: by 2002:a05:6a21:99a7:b0:1e1:9f57:eaaf with SMTP id adf61e73a8af0-1e88d13b56dmr43513284637.6.1736854270059;
        Tue, 14 Jan 2025 03:31:10 -0800 (PST)
Received: from ikb-h07-29-noble.in.iijlab.net ([202.214.97.5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72d4056ef2bsm7175918b3a.71.2025.01.14.03.31.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2025 03:31:09 -0800 (PST)
Received: by ikb-h07-29-noble.in.iijlab.net (Postfix, from userid 1010)
	id D1FC8E1AB56; Tue, 14 Jan 2025 20:31:06 +0900 (JST)
From: Hajime Tazaki <thehajime@gmail.com>
To: linux-um@lists.infradead.org
Cc: thehajime@gmail.com,
	ricarkol@google.com,
	Liam.Howlett@oracle.com
Subject: [PATCH v6 05/13] x86/um: nommu: syscall handling
Date: Tue, 14 Jan 2025 20:30:43 +0900
Message-ID: <c91911eb35125a739293d0ff175f2303b37183cf.1736853926.git.thehajime@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1736853925.git.thehajime@gmail.com>
References: <cover.1736853925.git.thehajime@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250114_033110_968003_6C1700E6 
X-CRM114-Status: GOOD (  21.41  )
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


