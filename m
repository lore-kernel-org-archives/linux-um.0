Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93E4EE8B38A
	for <linux-um@archiver.kernel.org>; Wed,  4 Feb 2026 02:28:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RjNnT/qNufze77W5gRyvHPSLcanY/U9dlqiEm3iR1Nk=; b=4PxFMz8wPPXVCnMezyLtvir8uW
	2ECalTkVyheoz3CgDA0Fvx/L6tFPdp9Z+IZZHJscPLVmjU93NnQBqA4bGFqqn2sYpqL/cXcAnWm9W
	7p03xSVx2ZY6AOSjEJeq7hvkHeGunMZ++cZ5DGGhSY+G24CY0KBRrGOPgN4ZbPLKQGCxJqBtPp/U8
	zH5y2JDaWZhvSryG16OHzcAjySL2tFXbMjzFnLOI8Y3G2MLH7775+fQnN4i53eVf7rDxGT7nJ90Zi
	ssx81jEuLvqQwGFvSbZ8PHylHZSvcfVk2BWfJ+630F5ETQ0mmPH7BnU1+MMl2gjl2YZpy24XQ179a
	SItPMkpA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vnSd7-00000007mBd-1MB7;
	Wed, 04 Feb 2026 02:28:33 +0000
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vnSd2-00000007m6c-2Up4
	for linux-um@lists.infradead.org;
	Wed, 04 Feb 2026 02:28:30 +0000
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-823081bb15fso3354511b3a.3
        for <linux-um@lists.infradead.org>; Tue, 03 Feb 2026 18:28:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770172107; x=1770776907; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RjNnT/qNufze77W5gRyvHPSLcanY/U9dlqiEm3iR1Nk=;
        b=krAwnNqX78a+3brBafs5Cxb5FKNcNiIzMvc+ElqpOuXDrt7EPLuESYGw7QxZ8ABSUk
         j0gGvxP+jXGyIjDI6yI6NUdMLKmHFRM6Nbarcn4PvnNFczgO5nyqZ/xChc237R80VANG
         WRHtYw9Js5PlobKpBqayrXjGkNUHhAXKfFnsrK85/xhA/+Hcyvqk0NDzO81gcvtor6nl
         PZoUJsePmw1OZqsjrqYmJsiWzoVVdk6Xyw8PjLxG/K7lR7krlez+DUylHtwntMPzjg6b
         dVSfk47/6P+RgZUrve2IlFM7m++GJXmx/znTMH5iN2o2Iowl+g6OsfjZkjFsDFAHWL8Z
         /jbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770172107; x=1770776907;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RjNnT/qNufze77W5gRyvHPSLcanY/U9dlqiEm3iR1Nk=;
        b=Io14BViaKGwpwukaGaXyHRR9gQVuK1n7HGw2JQT7AMSmfJuW50bysy+aJyZPxmc59E
         YCgfnDmDtsj038JlBwcS/ohR9OEw2xPDHLcu9ucQh5/xA1EDiQnBndg45VvByo5PQBxq
         lfzOxcY3eVz9gE491ELNWJJbBQqY52kwVg6toMZuRk/fqjTCkCt2PHzodgxPvezwauC+
         LeXSuGMjzxOA39t3IMvHtwb5MpFX9UnP37KJiZTwIS19B6HvwRJsIZ5ROxGMq93SrL4U
         Xrexn1kQBW9+uvMdGwzrkCE8BVSO9h1/PKOOQ83nozbiYA7vDxrNviqDEAPaJssuzpZw
         pUZA==
X-Gm-Message-State: AOJu0YyWQcIVrJt/yDBbGqnB2z+W+jAxPhMFbl7WvxRygZ3Zaxl7ueIe
	ZTOESMNGXtsGC5TwNUCt2r2Al5BA6cerG8OehTPQAS2HR5cZ7aYuBnCc
X-Gm-Gg: AZuq6aKqmOq0RwVN/hirJ4IvT7usDNhvyFxbcDEhhT0PdgeXLTwkQF9bYpB6jiTGgMb
	bN5tZQKopBgg++h5b8k3muNpl0jb2L4FTL/4dhx97tq7VdXGcSocPAbixni4Vlu3EJMbHyPumVn
	XnA+aN+v9Wal//hXiseItq5pkQL78JvipGHFQBnfTKcnL8BTQEAfnmF2utudHCd//P7f5z5AJkS
	ViDc2IBlV0AKIhhlmmho2bIw5ICq8gCl0knfe3vssqJ1QD2LERIdp544zoVcn0tqiiIxuLm6QgI
	sXMxpv9vlJZM2srwYHa3VyKTD+FzEEYiO/m4xOA3HDJZK2Ym4gJpf2t0H4WQDMh+W2qdqPenyQG
	DjRbe4CkFr7c4MZz06H5sE78cNrlwfjS11uF04ROEFV3RfHZF0bxkYzwfkLDsbYL88fNw10SBNP
	R/WGkchm0bMgRodxEfP6Pv/7GIxFOfhX8zsRoXZoCuvm/+5A8TOBWWPMpXtzkUEDO/33Z1DtTxZ
	QZFqCvNrllbwB4J
X-Received: by 2002:a05:6a00:2d10:b0:81f:be3c:8a24 with SMTP id d2e1a72fcca58-8241c5e9c88mr1483790b3a.36.1770172107592;
        Tue, 03 Feb 2026 18:28:27 -0800 (PST)
Received: from ikb-h07-29-noble.in.iijlab.net ([202.214.97.5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8241d4a5c28sm707551b3a.62.2026.02.03.18.28.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Feb 2026 18:28:26 -0800 (PST)
Received: by ikb-h07-29-noble.in.iijlab.net (Postfix, from userid 1010)
	id 0A3F21200C3B; Wed,  4 Feb 2026 11:28:24 +0900 (JST)
From: Hajime Tazaki <thehajime@gmail.com>
To: linux-um@lists.infradead.org
Cc: thehajime@gmail.com,
	ricarkol@google.com,
	Liam.Howlett@oracle.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v14 06/13] x86/um: nommu: process/thread handling
Date: Wed,  4 Feb 2026 11:28:04 +0900
Message-ID: <4a58e2e3f5a18c5bae50dd41dc0dc8ae901085ee.1770170302.git.thehajime@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1770170302.git.thehajime@gmail.com>
References: <cover.1770170302.git.thehajime@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260203_182828_667436_71B8FD26 
X-CRM114-Status: GOOD (  18.46  )
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
 arch/x86/um/nommu/Makefile           |  2 +-
 arch/x86/um/nommu/entry_64.S         |  2 ++
 arch/x86/um/nommu/syscalls.h         |  2 ++
 arch/x86/um/nommu/syscalls_64.c      | 40 ++++++++++++++++++++++++++++
 arch/x86/um/syscalls_64.c            |  2 +-
 6 files changed, 47 insertions(+), 3 deletions(-)
 create mode 100644 arch/x86/um/nommu/syscalls_64.c

diff --git a/arch/um/include/asm/ptrace-generic.h b/arch/um/include/asm/ptrace-generic.h
index 62e9916078ec..5aa38fe6b2fb 100644
--- a/arch/um/include/asm/ptrace-generic.h
+++ b/arch/um/include/asm/ptrace-generic.h
@@ -14,7 +14,7 @@ struct pt_regs {
 	struct uml_pt_regs regs;
 };
 
-#define arch_has_single_step()	(1)
+#define arch_has_single_step()	(IS_ENABLED(CONFIG_MMU))
 
 #define EMPTY_REGS { .regs = EMPTY_UML_PT_REGS }
 
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
index 485c578aae64..a58922fc81e5 100644
--- a/arch/x86/um/nommu/entry_64.S
+++ b/arch/x86/um/nommu/entry_64.S
@@ -86,6 +86,8 @@ END(__kernel_vsyscall)
  */
 ENTRY(userspace)
 
+	/* set stack and pt_regs to the current task */
+	call	arch_set_stack_to_current
 	/* clear direction flag to meet ABI */
 	cld
 	/* align the stack for x86_64 ABI */
diff --git a/arch/x86/um/nommu/syscalls.h b/arch/x86/um/nommu/syscalls.h
index a2433756b1fc..ce16bf8abd59 100644
--- a/arch/x86/um/nommu/syscalls.h
+++ b/arch/x86/um/nommu/syscalls.h
@@ -13,4 +13,6 @@
 extern long current_top_of_stack;
 extern long current_ptregs;
 
+void arch_set_stack_to_current(void);
+
 #endif
diff --git a/arch/x86/um/nommu/syscalls_64.c b/arch/x86/um/nommu/syscalls_64.c
new file mode 100644
index 000000000000..3b1610280110
--- /dev/null
+++ b/arch/x86/um/nommu/syscalls_64.c
@@ -0,0 +1,40 @@
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
+void arch_set_stack_to_current(void)
+{
+	current_top_of_stack = task_top_of_stack(current);
+	current_ptregs = (long)task_pt_regs(current);
+}
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
diff --git a/arch/x86/um/syscalls_64.c b/arch/x86/um/syscalls_64.c
index 6a00a28c9cca..9684850603a2 100644
--- a/arch/x86/um/syscalls_64.c
+++ b/arch/x86/um/syscalls_64.c
@@ -45,7 +45,7 @@ SYSCALL_DEFINE2(arch_prctl, int, option, unsigned long, arg2)
 	return arch_prctl(current, option, (unsigned long __user *) arg2);
 }
 
-void arch_switch_to(struct task_struct *to)
+__weak void arch_switch_to(struct task_struct *to)
 {
 	/*
 	 * Nothing needs to be done on x86_64.
-- 
2.43.0


