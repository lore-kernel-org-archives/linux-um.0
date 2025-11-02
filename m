Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E035CCFA04
	for <linux-um@archiver.kernel.org>; Sun,  2 Nov 2025 09:50:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gGE/jcU6KuNdO8mMPcpFhWHkaPMHY5y6/wQ8dXBnUzI=; b=kB2vXx9rfFX0Jw9XaihFJnmA4S
	klSrVX2AeCVJV5sBSp11cb0WYpZN3/tLQ/BhiOKttDNvLBb3kak+KBbdKUHFGRMkkqtQKszk/XS/i
	mPOZ+cEbx6JdyAPyYnlUo+k7etsvahShkmB10LIuDrtGbmDV1dWNAUcdInFWj7I+0C1LLKeiUnsGg
	j3bH3fUaH+EPhkynWEWNOhkMGyWfsgGBWlxPm8gwkgyFdhurNX4xm+Rx6lX1CmF4JRL8cRHxmHy/N
	CEmZY98LSF4iXTgvx0ETA9Z8f/qe5okfgKhlecvQdXVRxR/rGy/bEhbaGgY5EFTIZpAoD2wIleYn7
	fQGHmGIQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vFUin-00000008RsY-0ReU;
	Sun, 02 Nov 2025 09:50:01 +0000
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vFUik-00000008Rox-0mmQ
	for linux-um@lists.infradead.org;
	Sun, 02 Nov 2025 09:49:59 +0000
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-2947d345949so30515315ad.3
        for <linux-um@lists.infradead.org>; Sun, 02 Nov 2025 01:49:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762076997; x=1762681797; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gGE/jcU6KuNdO8mMPcpFhWHkaPMHY5y6/wQ8dXBnUzI=;
        b=REJym45xMe9xXhz7BJvT4A21bWv3gMXY8jfcJgS8RJv9m3PXFGi3oKeB6BOgH9SaWl
         JP6qEkfHSzlKrK6yl7/k9dZZ6r88xwB0tYrECA2rcz/XGAj7xwCZhZ93F8LD3PBEtChk
         woXW/7AQ3Ay4fUqaQgk+tDhTChprrwAv9BlCBMfGjrTBZHeoss/HedAWSQn7INEBRAs+
         YAcNiY8ZabXV+xTc6gA77oaNhWd77x+o7jLjWzDZFdIesrfDpxVSBdaopIONDynvV3L7
         6Bq43XSgkfmnJabbyS6DXyDsdLw6cLlIjLudZFTsl0OCL5tnQCindUxTaifUXKxIGK0Z
         Kr/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762076997; x=1762681797;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gGE/jcU6KuNdO8mMPcpFhWHkaPMHY5y6/wQ8dXBnUzI=;
        b=Adb2w3bjiwcuIEP1tOV5D7Rjw/SY5SpjRsYSMZAWACxRkfwl70+2BL3889GsSnL9qt
         2ys4/e+6xJOyy9Axp0HPO5geRsvLwdZCXOrGkk5irwTf0P3TxYTeA6ER+YseoGJKAttf
         0woTokVd0yMelcrQJSc2rqL5YxbJGeohNsL1iPxYZetl13O1nPt3ZO23R3HZmvbiL5ba
         XPKRXlVgpvDDe1HUcIUFnqtIIjykaCxKphT6/TM0BRxaX4qzUrIh6OfrIQtwbq+vDrdu
         IiDChf5BjUwwiLtGmmIl5/2A5Bc9Y+mg4R9uyo1o5rhL1XFeqe8x0ncudOIcbDXw8L+Q
         FXMQ==
X-Gm-Message-State: AOJu0Yz8Dw5FiYYeJbdQ23MJXw39WgGE+iECZLOoselWHBn6Bd9TsMsV
	DzvlFmfDtjUzTlwFNugTYPgpYGN5GxaB7WKIoDevZHdt3sOSA1/FZasY
X-Gm-Gg: ASbGncvGY7L2+IKkwIw1+lBZrwaQ+vWe/uZpEfk5PEI1nxZtDg3hPGNe5MWm2QjbGF+
	Us7AzGWmXbwPm1fu1H0htuO4KoXQVuXBLNYJx1nFxuFUpjcN8Yy5opQ2aN+Dl5cWuNciSOcud41
	wKeWj5GuxxXjuj4NUMHm51VkDzLAmlu7pa/vtVukwSlqRuk2B0k12QPD3v4YB9soAOSHhh9tLMe
	alyMrxLPCdsVsnPry9YYqcUZK5i772vlPY/EaQke9lxvkdfkAakmPvLI0qVKm8o7NWBPF7lLA9I
	byqdPAx9y3l1cz3eHMlOqQXiu8XWvkeVaxvqfRV4UuHMYfbbiklikOBiSbpX53xJ6j9Q3BrRHWB
	Rk7WhcszKpD+Q/sRs66mgIPavnh//bKr8K2JX0QTjFpVJjb1d6FcWjXqAaYpDFA40VW8l+03O+Q
	LsVLUPygFDaFbEdUlbG80/SiQswAO13vP3Wn/DZyjInJfQQw==
X-Google-Smtp-Source: AGHT+IGReh0qFD9/25L9otnnAJhTMLHIgLD9016XRnct0oN/9kvWpTVLUAzzoVVdm/CxflS7aR3gmA==
X-Received: by 2002:a17:902:ecd2:b0:295:3e80:9aa4 with SMTP id d9443c01a7336-2953e809f54mr75897205ad.22.1762076997472;
        Sun, 02 Nov 2025 01:49:57 -0800 (PST)
Received: from ikb-h07-29-noble.in.iijlab.net ([202.214.97.5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2952810a664sm79134845ad.52.2025.11.02.01.49.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Nov 2025 01:49:56 -0800 (PST)
Received: by ikb-h07-29-noble.in.iijlab.net (Postfix, from userid 1010)
	id D365B1123809; Sun,  2 Nov 2025 18:49:50 +0900 (JST)
From: Hajime Tazaki <thehajime@gmail.com>
To: linux-um@lists.infradead.org
Cc: thehajime@gmail.com,
	ricarkol@google.com,
	Liam.Howlett@oracle.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v12 06/13] x86/um: nommu: process/thread handling
Date: Sun,  2 Nov 2025 18:49:31 +0900
Message-ID: <94b1c9a65af9d22e3f21d28bc0fad2f94e1e86cb.1762075876.git.thehajime@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1762075876.git.thehajime@gmail.com>
References: <cover.1762075876.git.thehajime@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251102_014958_230157_5092CE49 
X-CRM114-Status: GOOD (  17.91  )
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


