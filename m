Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C20CECAC5AA
	for <linux-um@archiver.kernel.org>; Thu, 18 Sep 2025 07:39:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gGE/jcU6KuNdO8mMPcpFhWHkaPMHY5y6/wQ8dXBnUzI=; b=1HnllVsQGtaamrSU+NHq7HJfoI
	VgeVg58K0H8v1fhPGrldXBsssX6YPSrl+5kaBiYEwKKQIu+McwuPIkoLiD/zSOUHNHLlEp5dVOHC4
	c+ddPGzBmGlmp8GJzs/y7HV+Yn6B2erlL+yDrEyv42ABmrGlfY/sfy2kdDQIL54NGiIHT2ITdDE7P
	t9Dcufsef9jNQTv90tR4J2f3NenXL5CUIy2DrZ+r1MBG64HAz9rJjM1t97CbK7qpeMlevr8C30V1H
	ptpMdp3Nzm/0tiaMhS3CxxxCtcWHFyVZKB7LOEuPIvhBZqohF+AfLYrrHGC4zVDlT4cMoFARNFlWE
	zvuMbX8A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uz9En-0000000GZB9-2Ge5;
	Thu, 18 Sep 2025 07:39:29 +0000
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uz9Ek-0000000GZ7l-0XCl
	for linux-um@lists.infradead.org;
	Thu, 18 Sep 2025 07:39:28 +0000
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-772301f8ae2so665126b3a.0
        for <linux-um@lists.infradead.org>; Thu, 18 Sep 2025 00:39:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758181165; x=1758785965; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gGE/jcU6KuNdO8mMPcpFhWHkaPMHY5y6/wQ8dXBnUzI=;
        b=fi41bIcMMF3M9np9QIsSJRSuYznLBiCcBukQLr5FkCGv+TWCZ26LsycgJLzpFVR34W
         MYK03Mzj9fWPEL8frGERmUKic+ton7L71ThFj/NjLd541wf6bxRskpi2/sSVS7ILq6bk
         dJALicPO28ilseOzbz5652vPitvz66VLc+MuoeTRkikmvfXSsPCtTp56tU2+ll85iVFu
         CpMSHry/JIBNT8FXJdfsRjLZkrehtczrBh72tJuK1LMTfHsV6NE71FKJo/Izm/Cn50ar
         ZSu0VIcAcG3rfpVLgjBI9YvH7rvrByZO4lwUs1Flx6RJnR9HlfIXUmQIQjkzBeMRSOn8
         4yzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758181165; x=1758785965;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gGE/jcU6KuNdO8mMPcpFhWHkaPMHY5y6/wQ8dXBnUzI=;
        b=LtVvi7SQcy97BJuTNnKvpP7FRng6S+wdaKI16NMzVekmFoZCcyLE26QfV96gFScTDW
         wIaBhSAN2IwZjazDGAvtOMTRqIT3GsqLpSjqtAehYSZ2bW/GHxzc2dNS7J0J/1wRLIPB
         s5bZaImOwdKhZEa5Ey0BgLOo3vm2NzTXlCFns25hG/epFqjq2pq/bp71dtmoZLW/Jr56
         20REXcVK7WgFQ/hAkBxlRkO8FJB3Rd7b4MslCE2tKADT1t9wOS7ToND5oytAFF1clPyG
         +P5jHxCFWIVvknyc9c9bztuJuaJ0HMMSyIlyRs70nl5a0kh9jrU/n08/mGAXiTbfjCPM
         eK7Q==
X-Gm-Message-State: AOJu0Yy0+tvZ9Pd7NxwF77K6Hn3vAtinUTjWSDfouegrMlfwiwTaRqe0
	zP1B/bYepQhaJ0Pvy/y3/kSxOF3xy7bEArqJChSP5S6Po6YAMZn3njzrsnNxGQ==
X-Gm-Gg: ASbGncuqh/uvUx4RNvlSBw6QPhbYLGhDe482E4CO7iIqTVCHttJtwreabraT/dAkIVT
	eRE0KFhovlUcjcXqhSRQj1weyKJ8U62v1hdFjM+aQx5BXwfgAhbBvV/nfXr4bqv708QkJ+VHd17
	goRxn35JZ8a9FBL13JTgefsFthCuyGtVLgCoVo2BG3ogGEgW1NFQfktnqD30sabKtidvLpUp3Ch
	diefmyUJBuwqKlV9yi+ZqfO7AY1RehoptxF68r6bD5hPR0F1I6U/J3RAqzbvkeHfbKJwJk30nua
	r74yehiujE8w8ZBnOlrlA2qdw1ctBYLI6HwmFUBPGIgm5IrQTHIE/hQyEOM3COFPPd6Jq5JZ5Uw
	FNyf/Teejmu+D22IgzNsFKTPXEE4NIsjOPuA7gCf/a0a9EoKX/49W2iRXWiy97iec7WXv6o0S3F
	SFIMCYHvyvNQw=
X-Google-Smtp-Source: AGHT+IEW5cCMKXIm+nzKIkKeGH7H3LKniIm9mBlWZr7k0aEOZl0QvIVtSPe8fhK1TP/J+mcsUGlRpA==
X-Received: by 2002:a05:6a20:a108:b0:277:f962:3163 with SMTP id adf61e73a8af0-27a94827d99mr7748359637.19.1758181165167;
        Thu, 18 Sep 2025 00:39:25 -0700 (PDT)
Received: from ikb-h07-29-noble.in.iijlab.net ([202.214.97.5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32ed273e51dsm4547321a91.14.2025.09.18.00.39.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 00:39:24 -0700 (PDT)
Received: by ikb-h07-29-noble.in.iijlab.net (Postfix, from userid 1010)
	id 06A791062106; Thu, 18 Sep 2025 16:39:23 +0900 (JST)
From: Hajime Tazaki <thehajime@gmail.com>
To: linux-um@lists.infradead.org
Cc: thehajime@gmail.com,
	ricarkol@google.com,
	Liam.Howlett@oracle.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH RESEND v11 06/13] x86/um: nommu: process/thread handling
Date: Thu, 18 Sep 2025 16:39:01 +0900
Message-ID: <5c56554cf8c0215ea378b4c5935664ebc7a27d50.1758181109.git.thehajime@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1758181109.git.thehajime@gmail.com>
References: <cover.1758181109.git.thehajime@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250918_003926_184055_5E2A4891 
X-CRM114-Status: GOOD (  18.24  )
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
 arch/x86/um/nommu/entry_64.S         |  2 ++
 arch/x86/um/nommu/syscalls.h         |  2 ++
 arch/x86/um/nommu/syscalls_64.c      | 50 ++++++++++++++++++++++++++++
 6 files changed, 58 insertions(+), 3 deletions(-)
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
index 000000000000..d56027ebc651
--- /dev/null
+++ b/arch/x86/um/nommu/syscalls_64.c
@@ -0,0 +1,50 @@
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


