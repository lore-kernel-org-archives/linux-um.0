Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2593DC369DC
	for <linux-um@archiver.kernel.org>; Wed, 30 Apr 2025 04:29:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Q5NKRA2Vd8iUo2TNfSXqtZxbhUvo/xKWVJfwrs+7skI=; b=o19OeGMk8w1lHmVD23ajLCeeia
	ysFs8aMH0UakSBru2/aRt/51AXd1OZc37kIeArPaGBd7sToPleK53asi3vLw1nuhxCqDM/gYs49AM
	K6ESOz13f/BVMQZNIOEmMy7i6zcH2mecb+R+AoIt++RR4uYCe9d0fTBZv05N8FCWdndu6G+SXGRq0
	om5Yi5BOv148cJg/J7/rlcF9duIgiidNxXA61dOjbQmLuUx/9TG+YnaQV/NmpTn1pPUvGKGEwdA95
	T/HIQ5wDleol4CvPKRRZOUXZ8FVa/NQMcVNfG8olndUIuUldZ3EwvRwroJ3lxKL7cCDtzVubEbQTC
	10IUPnVw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u9z4B-0000000Bfg2-2eJo;
	Wed, 30 Apr 2025 04:29:03 +0000
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u9z32-0000000BfRi-3CBM
	for linux-um@lists.infradead.org;
	Wed, 30 Apr 2025 04:27:53 +0000
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-22409077c06so109264315ad.1
        for <linux-um@lists.infradead.org>; Tue, 29 Apr 2025 21:27:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745987272; x=1746592072; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q5NKRA2Vd8iUo2TNfSXqtZxbhUvo/xKWVJfwrs+7skI=;
        b=CVWJ/W/Z6YOqEQS6w//VLoeUyMrR4TZvh3FB0cYzawLSyu22HWV/oAhbABEwL2Lx0Q
         R3EvKe3GfcgsSd3N1FgmmoSpXa+Bhh8XQSpgbAbseGUbe5iyO3ZUV22ySaQL7gPvCP4n
         v2KWTwCHLM4U8lqdYMzLw+gegiW+wVM/Il+HVGra4gkfWv/XDjUx30WJ4eUQRkpPY3JU
         ILm+zxEqf5Otdd2iHiFD/HfYe5lkGpw129qa+wgLYM0ghGwWZtdMJrQpKJunikxmHuQn
         IdMFpb9ihy87PtA8T2CyZDTE2D0WAy5Y73oGm/IEcIyyG+qMZYshTVAcNbsgt/htx6do
         6Ulg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745987272; x=1746592072;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q5NKRA2Vd8iUo2TNfSXqtZxbhUvo/xKWVJfwrs+7skI=;
        b=OxzgK9ejrkI+CSYk864qLYj+DP9eypxQqZJ0b956UoOsrgLx0+Aky6x7Luv0ImQHgo
         /lSfXz5zpy6kr6D2EAoFsCV0HL5EuvWvfbCX6H9CHf/vOVKhEj1Z+9llh8QU5aMG067V
         cWQw0TEW96XbsK7JFGoYz0mf5SL2BDTYAY3sZTfZjs/ls07ZEcb+Tbd43v+jfd5GAXvW
         +DrNim7ERyAbLgY3MNId59abAvpound7x36YcIkw2CxQpkvjsX3ieGTLaN8tCXpU8S7P
         o/YFpmTR7/tOCG3CsKDO3UWoSVs5N7CdwmRco/MaNLvGhY5GIedJbv8C1pLOs93tcG4d
         p6FQ==
X-Gm-Message-State: AOJu0Yxf3T+cEbLwHyLbsdoyQWBXjs6RreFHR2Ix1Jh/24a3aH5iVE3p
	YFx4GiFFoFHyQaR14QqE32YfP3mu5UCvqp0qhpfUdfcpxPDajipeXUsVoLF1
X-Gm-Gg: ASbGncslS406ek7Gp6V3iJznOQqNFbYKCLt1uH/1sRRv6fI6XvDnlOD8IzaQ4SupsA6
	PHJZRHwA1Ps0+UhWrBPzgRX0fFwwWgjJ7JGRa/2EA71vsej5GkUMbzAlqCnwlvGSHUVPWQbhijy
	v0hID501QRCjU44CJYzs/ZdBdPuduzndnvtzllTvE2oOR5paVk9pqie7JxoAlfUNoOkDHjIrfk4
	oHTqYuBUEDEeiz4/l95XqJrSBwpGaACYKK7NbORF6kfcrRD5NwqsWpG8zEj1btpHwA5gFFRnNss
	tPkdbDMs5/sfBLgOEBk4jgX6YQ5zEWyxMf4jm6/Cg9MUcsSkg54pkLaIIZN2gEjsP3bT0IZQQEo
	CYON+VrLgCm0=
X-Google-Smtp-Source: AGHT+IGOxIjchaID2CDqMQJI7v4ig2oBAAKA/o5gORT6xH9R/bvvse4aK4O3R8Prfqt9cmDnq/3Z6A==
X-Received: by 2002:a17:903:298e:b0:224:1c1:4ac1 with SMTP id d9443c01a7336-22df358f9c2mr28149925ad.47.1745987271755;
        Tue, 29 Apr 2025 21:27:51 -0700 (PDT)
Received: from ikb-h07-29-noble.in.iijlab.net ([202.214.97.5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22db50e7a33sm112187705ad.146.2025.04.29.21.27.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Apr 2025 21:27:51 -0700 (PDT)
Received: by ikb-h07-29-noble.in.iijlab.net (Postfix, from userid 1010)
	id C7F08E9481E; Wed, 30 Apr 2025 13:27:49 +0900 (JST)
From: Hajime Tazaki <thehajime@gmail.com>
To: linux-um@lists.infradead.org
Cc: thehajime@gmail.com,
	ricarkol@google.com,
	Liam.Howlett@oracle.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v8 06/12] x86/um: nommu: process/thread handling
Date: Wed, 30 Apr 2025 13:27:12 +0900
Message-ID: <71d4afcd72f3ea4a513c012c8bc6db04419f57e9.1745980082.git.thehajime@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1745980082.git.thehajime@gmail.com>
References: <cover.1745980082.git.thehajime@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250429_212752_797699_D7EEDCAA 
X-CRM114-Status: GOOD (  18.99  )
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
 arch/um/os-Linux/process.c           |  6 ++++
 arch/x86/um/Makefile                 |  3 +-
 arch/x86/um/nommu/Makefile           |  2 +-
 arch/x86/um/nommu/entry_64.S         | 22 ++++++++++++++
 arch/x86/um/nommu/syscalls_64.c      | 44 ++++++++++++++++++++++++++++
 6 files changed, 76 insertions(+), 3 deletions(-)
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
 
diff --git a/arch/um/os-Linux/process.c b/arch/um/os-Linux/process.c
index 8a615875d1a1..3ac01881e905 100644
--- a/arch/um/os-Linux/process.c
+++ b/arch/um/os-Linux/process.c
@@ -28,6 +28,9 @@ int unscheduled_userspace_iterations;
 
 void os_alarm_process(int pid)
 {
+	if (pid <= 0)
+		return;
+
 	kill(pid, SIGALRM);
 }
 
@@ -45,6 +48,9 @@ void os_kill_process(int pid, int reap_child)
 
 void os_kill_ptraced_process(int pid, int reap_child)
 {
+	if (pid <= 0)
+		return;
+
 	kill(pid, SIGKILL);
 	ptrace(PTRACE_KILL, pid);
 	ptrace(PTRACE_CONT, pid);
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
index 000000000000..c78c442aed1d
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
+	 * The FS_BASE/GS_BASE registers are saved here.
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


