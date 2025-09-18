Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73820CAC5A7
	for <linux-um@archiver.kernel.org>; Thu, 18 Sep 2025 05:16:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gGE/jcU6KuNdO8mMPcpFhWHkaPMHY5y6/wQ8dXBnUzI=; b=YRmPfX4fu5PjH9MzUGlLwba99O
	/Z9uSk15NcybwITth6FDXCEZIRTUpyfot1j772An6ECtv5ToUsfsLHnhgi+3cqLmA05jngOOdxIPq
	4xGZz1wGmuVX414MvVgPJdqLp8a0xZcjt59irIrlx/+HQt1531MmoeObl0yYWg2rIE+A0FkpExRzB
	bRKquAZ2cTVCengddfE7WUAfwgwqBNP4G7btAOdvWFgCcF11ElAD+I2CAxQ9IRfGdpkV+4ICkQHM8
	I0OY3tj0OS1W35rCJiUSTig/8jan0WqUcbNRmBxiSrmT0+DEHV4Xis+zo9jqDhPWtCqyPhW953elQ
	JT9Rc0bg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uz70i-0000000GIGy-0r4t;
	Thu, 18 Sep 2025 05:16:48 +0000
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uz70a-0000000GICJ-0I6W
	for linux-um@lists.infradead.org;
	Thu, 18 Sep 2025 05:16:41 +0000
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-25669596955so5362725ad.0
        for <linux-um@lists.infradead.org>; Wed, 17 Sep 2025 22:16:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758172599; x=1758777399; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gGE/jcU6KuNdO8mMPcpFhWHkaPMHY5y6/wQ8dXBnUzI=;
        b=UjSLvKq5qqpMqqWCJ/XVviAbLilHnIHRNs8BgmEP19VBvNfrY6qgPTRGk9truKD2G2
         l8iEjMFnDna0Lr3LGXqkpBzuQWQ51XmS3zjB/CKiAC2d+1xohfHosZQ5L5iXEUIp/AyJ
         JU0nS58iemFAFff9M7ztZTsXw6TbeEJIRTKBhCLn1rToZnlqPjVnmeixx26I/iSuZHKa
         5gXh0mhFoB+xIH08QaPaZNk3e/6VqwnCd6u0k5GY9+AO/gtOlie4Sxq9f/hZD0GWD/9X
         Fild+bzQRt2hLca7KTr28gnLHgeFCM3SlHXBFnx/aas/X6e0yD2VYTY0b2O1KG1Fzr/O
         0DTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758172599; x=1758777399;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gGE/jcU6KuNdO8mMPcpFhWHkaPMHY5y6/wQ8dXBnUzI=;
        b=kEMxUfpCdRYZ4ym2NM6fJMfznNzo6Rzarx0d6h4GWvhBftuE6WNdAWxIqSdmce6b7p
         +aDuVC4uyefU85km8e4yqELWqqEUc3jVkJbMNbRvHGDLFyHfXvgwKkqpJOcYxFahWVml
         M5sNwS3SN/ExB5foOvkxSfH7nailDTw+majPvfdU1i9jpfbmai0TWX/0CyDJSDhynBnP
         NmHOqUMag+R/C/ArK3m6vGLnNg86qmWXCW0PPzXyG4LylGUY9+wKTdkqLdOC056n/n0q
         LtkQNXVEFjspL3unCfASjzEaOilJb0UGu9P1MndAIQvQovgPZfjnYxhLbHFkG/IPqJ8Q
         XntA==
X-Gm-Message-State: AOJu0YxAU9YnbQvtC1j+9ucELbIAdVYpkOzYgKOVScZRisl2xXOIGV61
	eL+S5oBJLE5gCCQRbnoe34YPk26mTRbL1dpLjgrjHDnT7fXiEfdKlLI0pJH5Aw==
X-Gm-Gg: ASbGnctz3xaeXdrh8Z5S6UszK00TFeWsBym+qxnar5CxEagaqsHp0rgq9TQH/sgH+WF
	UGrnnA0FX3e5w2adebBgLlsXgcmZyzEL+3Ya6aVkDt3i7lEX1eXkh5QfiUplc9BuRudvCRfo6VO
	aBFUMD4/2v0cf5lScVSvj66uNkR3ZCxtLK36W7nPRsjaTYTC13kXJXcu/Z0KFmZxAFL7kJ/qhAK
	KgXUR7l96E0sg/DA7eAlmPZtSchSajrKztK8a4bRvNlJENBWRdLXBrzw3B2iJaWhRPLmnsAhlQh
	Ph/Qb0X8Qr0JUBtgqKtVfaYOm1Owh0SwfrdqBK8Uq8XiNPyqJc/TbZsyvb/rywSqwrXwJG3S2nI
	cGC+AfQq9LesqoCgns1EKsSOz0DAFXlpr5FdVZRfuYxxWHPAiWba2gZPkWIKFhCjeO8CN0PbuV+
	WA8kRe64C+vzQ=
X-Google-Smtp-Source: AGHT+IF1j90Ta1QtOnlayd+rOIMVjDlDgB9HTQ6NhnrPndZrudKEMwQBaDxvvy2pq+iS/ce/Fx31JA==
X-Received: by 2002:a17:902:f792:b0:264:4e4a:904a with SMTP id d9443c01a7336-26813cfeb3fmr56547865ad.53.1758172599048;
        Wed, 17 Sep 2025 22:16:39 -0700 (PDT)
Received: from ikb-h07-29-noble.in.iijlab.net ([202.214.97.5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-269803026e9sm12683435ad.107.2025.09.17.22.16.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 22:16:38 -0700 (PDT)
Received: by ikb-h07-29-noble.in.iijlab.net (Postfix, from userid 1010)
	id 006621061EEE; Thu, 18 Sep 2025 14:16:37 +0900 (JST)
From: Hajime Tazaki <thehajime@gmail.com>
To: linux-um@lists.infradead.org
Cc: thehajime@gmail.com,
	ricarkol@google.com,
	Liam.Howlett@oracle.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v11 07/14] x86/um: nommu: process/thread handling
Date: Thu, 18 Sep 2025 14:16:00 +0900
Message-ID: <5528885e35e11984cf2543665b4d92582f4b3ac1.1758171893.git.thehajime@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1758171893.git.thehajime@gmail.com>
References: <cover.1758171893.git.thehajime@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250917_221640_178611_503786F1 
X-CRM114-Status: GOOD (  18.29  )
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


