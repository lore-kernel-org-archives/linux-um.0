Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33F7AC7EE39
	for <linux-um@archiver.kernel.org>; Sun, 22 Jun 2025 21:34:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MWmA09AalrKCKqNdOimE9etFAWoYaJVH+yPCouYXbe4=; b=lPtJbUhcZdsFwYavJSKztGOnX6
	W2VH2vjbJFvBd3yyRuA8mmx/0uJNTn64AXhv79CtQKNZ8Yz0z8Ty/U9awcb3kpXOIaw/vxr1tZjw1
	0CFwMZzH3WDY3/28ocHluOn5T+mIX+w4ZPmzcjnIr9ODTY5mEX4Nlo57oriskbQc04TUbv8H0VPi1
	ytXd6IwTCgQJQr5W7WKvO8BDvAJ7uyyNkhqGafHatWdrSQEzhrnhHjxpwEi7AUMJ92vwVoMbLwm4J
	alxqphnkBMlb/BBgEXKaYDPHrygF1fP/98qNFETFZoGDnQV5syqUHavs245ktCSSjFw4/diS1Yj/s
	o1vtQ9Qg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uTSKH-00000001F59-03LO;
	Sun, 22 Jun 2025 21:34:09 +0000
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uTSJi-00000001EtL-2KYC
	for linux-um@lists.infradead.org;
	Sun, 22 Jun 2025 21:33:36 +0000
Received: by mail-pg1-x52a.google.com with SMTP id 41be03b00d2f7-b2fca9dc5f8so2737145a12.1
        for <linux-um@lists.infradead.org>; Sun, 22 Jun 2025 14:33:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750628014; x=1751232814; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MWmA09AalrKCKqNdOimE9etFAWoYaJVH+yPCouYXbe4=;
        b=U7gfu6mqKeRTggYfKlflRfuFbUzxg6wimQknQc9g5fTdEOyuHgJ7hXB3n4rLJQow+E
         MFkWiOBGCRj/4tfyV0GmXar2523ZtD+GLZeFO3Op39LQCmJEHIj0gQvk87LfNQ1ymW+0
         I5ykKIPHtUqck6loZAF7Y+BVn/p+1ecs0opyGaRdWT6m9S06nmSKn/oyG7z84j2yVuOS
         XMc+fBdGlqGhyH2TA+QMgW57SY77Ver5FseOIXlUKpGZzHcp7FwjF5ttY4DS2puuk9+S
         d0zkEqenIavv2k+8PRggQRTqOdx9vx8djyf6g8d9uP/GIHJH8qYh1aViTYgyPTk/0iEK
         Lopw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750628014; x=1751232814;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MWmA09AalrKCKqNdOimE9etFAWoYaJVH+yPCouYXbe4=;
        b=VgS+FNgkaOZ0RfOxDwjpHxqEnxg/Ky5au2k0ko6RNncUxS/34HBDUwzARHSiyCHOcJ
         Kj7B30Fq04MvoMmmyWIg/4s90TQRspJbA8wLsTGNL8LsxySM1R7NMKu5RH1slqF8gh4D
         P4ujZMEE40cfNVLPaGIqqu5DVuFyEDtxXf1KAHzvcCj+ipGTRCIvUyf5fCts969jm6Gn
         WskUsM+AT8AK70c7as+gMFD2uODuoXhENJ8BOoAbO92ENrZNQoIcihnneZlQzTLRN42F
         keI8oD78+zSWAYWUpR7EGg70+9pKSaw0FmAlkXvZLsaCw1cDtMOjjiHfHTVUT9Bn8Mry
         oq+g==
X-Gm-Message-State: AOJu0Yy8AFmmXi9TzbpdmgfcJ9qinAt7Fg1frwstn89hHoj4gVCuieBH
	rH/bA302xRanuvR7DTV+B9Ckd1q+qRVtP28XA8hQUe3OYsblcQOQlb2t3+RF5w==
X-Gm-Gg: ASbGncsr/7NGJd5hH5gLd3ZCdkcAelpOrQNx8md8G5VY0lZX+Ctzrqb7y1Xx7jfvZa3
	e2N2JV/6wn7BKSqwRIsy+qkdDriWFEWz6EX9v5f5egi9N2NUdRqqY5agBjgDE3MwY0WtRSt0/s1
	WVNqxEFYsU5kb9afrFYusa2kpooRUWQqwNdG7Ow+eJml0QTpCha1ICtfjFMvtORSfTc23aBf7nr
	C3Iga0edNTSarDE07BXlFPBgBleRWXba8+4aLhZVqM5HAxA5YyzDvQE+8mQmHg+kM09APkJJ0Eh
	ioZLpUXh7UcxeakO/5FiC6t3uOm9IfDo+F4iwr55gMyGYFhO94taol7ol8hTT4tAzO6knhE3/vI
	FvllohF+3aF1my17AmvA8Sp+nA5cs8KIRqmb4GUltp0o=
X-Google-Smtp-Source: AGHT+IFahGSpnoHBpn2Cds8cB3SpBCFDv0BojRPvfSRb4pA+F4Lk4gBS9gdDKoH1fQRiUwr1fYoqQg==
X-Received: by 2002:a17:903:1aa7:b0:234:8a4a:adad with SMTP id d9443c01a7336-237d98f9968mr163441015ad.26.1750628013744;
        Sun, 22 Jun 2025 14:33:33 -0700 (PDT)
Received: from ikb-h07-29-noble.in.iijlab.net ([202.214.97.5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-237d83936e1sm67971125ad.5.2025.06.22.14.33.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Jun 2025 14:33:29 -0700 (PDT)
Received: by ikb-h07-29-noble.in.iijlab.net (Postfix, from userid 1010)
	id 5F881EF1EB0; Mon, 23 Jun 2025 06:33:27 +0900 (JST)
From: Hajime Tazaki <thehajime@gmail.com>
To: linux-um@lists.infradead.org
Cc: thehajime@gmail.com,
	ricarkol@google.com,
	Liam.Howlett@oracle.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v10 06/13] x86/um: nommu: process/thread handling
Date: Mon, 23 Jun 2025 06:33:04 +0900
Message-ID: <92ad19005df45ac15452be94c9cb522c87c8ee1c.1750594487.git.thehajime@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1750594487.git.thehajime@gmail.com>
References: <cover.1750594487.git.thehajime@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250622_143334_593842_8AEA1991 
X-CRM114-Status: GOOD (  17.49  )
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

Since ptrace facility isn't used under !MMU of UML, there is different
code path to invoke processes/threads; there are no external process
used, and need to properly configure some of registers (fs segment
register for TLS, etc) on every context switch, etc.

Signals aren't delivered in non-ptrace syscall entry/leave so, we also
need to handle pending signal by ourselves.

ptrace related syscalls are not tested yet so, marked
arch_has_single_step() unsupported in !MMU environment.

Signed-off-by: Hajime Tazaki <thehajime@gmail.com>
Signed-off-by: Ricardo Koller <ricarkol@google.com>
---
 arch/um/include/asm/ptrace-generic.h |  2 +-
 arch/x86/um/Makefile                 |  3 +-
 arch/x86/um/nommu/Makefile           |  2 +-
 arch/x86/um/nommu/entry_64.S         | 22 ++++++++++++++
 arch/x86/um/nommu/syscalls_64.c      | 44 ++++++++++++++++++++++++++++
 5 files changed, 70 insertions(+), 3 deletions(-)
 create mode 100644 arch/x86/um/nommu/syscalls_64.c

diff --git a/arch/um/include/asm/ptrace-generic.h b/arch/um/include/asm/ptrace-generic.h
index 4ff844bcb1cd..a9778c9a59a3 100644
--- a/arch/um/include/asm/ptrace-generic.h
+++ b/arch/um/include/asm/ptrace-generic.h
@@ -14,7 +14,7 @@ struct pt_regs {
 	struct uml_pt_regs regs;
 };
 
-#define arch_has_single_step()	(1)
+#define arch_has_single_step()	(IS_ENABLED(CONFIG_MMU))
 
 #define EMPTY_REGS { .regs = EMPTY_UML_PT_REGS }
 
diff --git a/arch/x86/um/Makefile b/arch/x86/um/Makefile
index 227af2a987e2..53c9ebb3c41c 100644
--- a/arch/x86/um/Makefile
+++ b/arch/x86/um/Makefile
@@ -27,7 +27,8 @@ subarch-y += ../kernel/sys_ia32.o
 
 else
 
-obj-y += syscalls_64.o vdso/
+obj-y += vdso/
+obj-$(CONFIG_MMU) += syscalls_64.o
 
 subarch-y = ../lib/csum-partial_64.o ../lib/memcpy_64.o \
 	../lib/memmove_64.o ../lib/memset_64.o
diff --git a/arch/x86/um/nommu/Makefile b/arch/x86/um/nommu/Makefile
index ebe47d4836f4..4018d9e0aba0 100644
--- a/arch/x86/um/nommu/Makefile
+++ b/arch/x86/um/nommu/Makefile
@@ -5,4 +5,4 @@ else
 	BITS := 64
 endif
 
-obj-y = do_syscall_$(BITS).o entry_$(BITS).o os-Linux/
+obj-y = do_syscall_$(BITS).o entry_$(BITS).o syscalls_$(BITS).o os-Linux/
diff --git a/arch/x86/um/nommu/entry_64.S b/arch/x86/um/nommu/entry_64.S
index e9bfc7b93c84..950447dfa66b 100644
--- a/arch/x86/um/nommu/entry_64.S
+++ b/arch/x86/um/nommu/entry_64.S
@@ -89,3 +89,25 @@ ENTRY(__kernel_vsyscall)
 	jmp	*%rcx
 
 END(__kernel_vsyscall)
+
+// void userspace(struct uml_pt_regs *regs)
+ENTRY(userspace)
+
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
+	popq	%r11		/* pt_regs->ip */
+	addq	$8, %rsp	/* skip cs */
+	addq	$8, %rsp	/* skip flags */
+	popq	%rsp
+
+	jmp	*%r11
+
+END(userspace)
diff --git a/arch/x86/um/nommu/syscalls_64.c b/arch/x86/um/nommu/syscalls_64.c
new file mode 100644
index 000000000000..e88e93e9d80a
--- /dev/null
+++ b/arch/x86/um/nommu/syscalls_64.c
@@ -0,0 +1,44 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2003 - 2007 Jeff Dike (jdike@{addtoit,linux.intel}.com)
+ * Copyright 2003 PathScale, Inc.
+ *
+ * Licensed under the GPL
+ */
+
+#include <linux/sched.h>
+#include <linux/sched/mm.h>
+#include <linux/syscalls.h>
+#include <linux/uaccess.h>
+#include <asm/prctl.h> /* XXX This should get the constants from libc */
+#include <registers.h>
+#include <os.h>
+#include "syscalls.h"
+
+void arch_switch_to(struct task_struct *to)
+{
+	/*
+	 * In !CONFIG_MMU, it doesn't ptrace thus,
+	 * The FS_BASE registers are saved here.
+	 */
+	current_top_of_stack = task_top_of_stack(to);
+	current_ptregs = (long)task_pt_regs(to);
+
+	if ((to->thread.regs.regs.gp[FS_BASE / sizeof(unsigned long)] == 0) ||
+	    (to->mm == NULL))
+		return;
+
+	/* this changes the FS on every context switch */
+	arch_prctl(to, ARCH_SET_FS,
+		   (void __user *) to->thread.regs.regs.gp[FS_BASE / sizeof(unsigned long)]);
+}
+
+SYSCALL_DEFINE6(mmap, unsigned long, addr, unsigned long, len,
+		unsigned long, prot, unsigned long, flags,
+		unsigned long, fd, unsigned long, off)
+{
+	if (off & ~PAGE_MASK)
+		return -EINVAL;
+
+	return ksys_mmap_pgoff(addr, len, prot, flags, fd, off >> PAGE_SHIFT);
+}
-- 
2.43.0


