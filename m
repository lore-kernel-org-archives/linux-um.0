Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E705CE8E6C
	for <linux-um@archiver.kernel.org>; Thu, 24 Oct 2024 12:11:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BoodVqZ2VjHIx4powPVz+FSv414293W5ryCMxg5XJYw=; b=miU+7Quv0rPBrhG0xeo7WHkjLJ
	1eGu7OJ9AgWk1fKpSPhS5IgOziu/sb3g3qQPI4ZIZNgnZzwuxJZr4IQwvMSaJQV/X/scy6C7MvY8e
	UM9VU6jTaoiLlQao1vpeu4iAadzmGCNRpqhzECUFOdcfII75WRAFRccBWQyi7ITetj/D510YGynmC
	3uh0zwodvnPnwrsXnmNZT/7ZMEzAY9Gwf30fkPz5b9TyUKcfRei15oYOfsh6aShop/yJPXSvXwMyQ
	ZO5KbZXmT4FbF85YcVqL+qCNGAzBDhRn85skZ088GVc+8NQ+P8OupaohN6DhTOYM91eJw4A5jOzTr
	McFvzs+Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t3wgT-00000000Iph-3Cge;
	Thu, 24 Oct 2024 12:11:21 +0000
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t3wfG-00000000IZi-3iXo
	for linux-um@lists.infradead.org;
	Thu, 24 Oct 2024 12:10:08 +0000
Received: by mail-pg1-x52e.google.com with SMTP id 41be03b00d2f7-7d4f85766f0so505254a12.2
        for <linux-um@lists.infradead.org>; Thu, 24 Oct 2024 05:10:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729771805; x=1730376605; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BoodVqZ2VjHIx4powPVz+FSv414293W5ryCMxg5XJYw=;
        b=JN9EiOOfo5ZgNRhGKttkxeWGq9V3cWlMTeiXAdLbtnDaxn1kpd3f6P7Y5tqlKxNbMO
         DoRWhF67eFrgawNVNpTZvtKdUNia44fjKph1GpAUcY5ESvLPVgbxK9lnQmUCegACKM2H
         KdkT47CnJvXeltY/Pv5Ri96UriqRgKYRQq4uUUMO82vWbE2F4Yv2o3ccx0SiTM65VOuA
         o0nzFMqMz5ffCAOBdu9NfFE09uTcy99ysELmaVXqwAm9E0252Sqa+xM7VPO6krS+Bod/
         eA4m2SxKICWzxZQDw5geTE1etjo6Qk5p3TS/YGaaNaVSk5CPfzBKmBFdHqpprcgBFbS3
         y4lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729771805; x=1730376605;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BoodVqZ2VjHIx4powPVz+FSv414293W5ryCMxg5XJYw=;
        b=sy1eIxFRyvTaHMSHTJKNtZHAoRWEQEoK565UwobH4CCuaDH2yz7eO576v0QY59DLG5
         3N2IxsbsiMA52Iq1ui4opXcuFto0VPfdwiplQcbrU5T1nAnMvmmZxR60Wyx0iOta6Gwp
         A/EFBycMAaD3a662G9RPdWxtVl0hjlywNEkSKiSNxjFELwCVTGTYQDvXL/o7zhs1cChI
         /eMnkE0zJi0qXoee9hNx4sDOqvgP0xPbJn25pbRiyvA1aC/PUk2mVxSC1YLQw21A4q/p
         XyTgN7ZRp56vGSxp5PsCh+MaboSdVmgF0j7o8XWcyi3qY894MF/oaGcP12ZoTqK6tvL1
         F/Ug==
X-Gm-Message-State: AOJu0Yxf2xZfFKEwzzFkKIoYIooOW0bep0wTnPOqZQPeZwy8HBphNCjM
	1vu8NYx57Nyya4izMuiBmTYZ5oIAafkhZB9Srwab18qbOw+QtdqD
X-Google-Smtp-Source: AGHT+IGZV2ufoDfakISlsysWeCNgFzYWzL411Fm66lvWYdEYTgfCvTS5HotsnoLsc0UW4k9QzC/QDg==
X-Received: by 2002:a05:6a21:3984:b0:1d9:275b:4ee9 with SMTP id adf61e73a8af0-1d978af6913mr6782716637.15.1729771805492;
        Thu, 24 Oct 2024 05:10:05 -0700 (PDT)
Received: from ikb-h07-29-noble.in.iijlab.net ([202.214.97.5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71ec140781fsm7864893b3a.185.2024.10.24.05.10.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 05:10:04 -0700 (PDT)
Received: by ikb-h07-29-noble.in.iijlab.net (Postfix, from userid 1010)
	id A948FD5124F; Thu, 24 Oct 2024 21:10:02 +0900 (JST)
From: Hajime Tazaki <thehajime@gmail.com>
To: linux-um@lists.infradead.org,
	jdike@addtoit.com,
	richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net
Cc: thehajime@gmail.com,
	ricarkol@google.com
Subject: [RFC PATCH 04/13] x86/um: nommu: syscall handling
Date: Thu, 24 Oct 2024 21:09:12 +0900
Message-ID: <1a39a239b4a34d2f613ab1ffc62c80967a2f57fb.1729770373.git.thehajime@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1729770373.git.thehajime@gmail.com>
References: <cover.1729770373.git.thehajime@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241024_051006_988305_0005CE25 
X-CRM114-Status: GOOD (  20.57  )
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
 arch/x86/um/do_syscall_64.c             | 42 ++++++++++++
 arch/x86/um/entry_64.S                  | 88 +++++++++++++++++++++++++
 arch/x86/um/shared/sysdep/syscalls_64.h |  4 ++
 3 files changed, 134 insertions(+)
 create mode 100644 arch/x86/um/do_syscall_64.c
 create mode 100644 arch/x86/um/entry_64.S

diff --git a/arch/x86/um/do_syscall_64.c b/arch/x86/um/do_syscall_64.c
new file mode 100644
index 000000000000..7af6e881ad58
--- /dev/null
+++ b/arch/x86/um/do_syscall_64.c
@@ -0,0 +1,42 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/kernel.h>
+#include <linux/ptrace.h>
+#include <kern_util.h>
+#include <sysdep/syscalls.h>
+#include <os.h>
+
+#ifndef CONFIG_MMU
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
+	if (syscall == __NR_execve && regs->regs.gp[HOST_AX] == 0) {
+		userspace(&current->thread.regs.regs,
+			current_thread_info()->aux_fp_regs);
+	}
+}
+#endif
diff --git a/arch/x86/um/entry_64.S b/arch/x86/um/entry_64.S
new file mode 100644
index 000000000000..12e11ac03543
--- /dev/null
+++ b/arch/x86/um/entry_64.S
@@ -0,0 +1,88 @@
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
+#ifndef CONFIG_MMU
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
index b6b997225841..31aa0694cec0 100644
--- a/arch/x86/um/shared/sysdep/syscalls_64.h
+++ b/arch/x86/um/shared/sysdep/syscalls_64.h
@@ -25,4 +25,8 @@ extern syscall_handler_t *sys_call_table[];
 extern syscall_handler_t sys_modify_ldt;
 extern syscall_handler_t sys_arch_prctl;
 
+__visible void do_syscall_64(struct pt_regs *regs);
+extern long __kernel_vsyscall(int64_t a0, int64_t a1, int64_t a2, int64_t a3,
+			      int64_t a4, int64_t a5, int64_t a6);
+
 #endif
-- 
2.43.0


