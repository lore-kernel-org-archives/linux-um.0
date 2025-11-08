Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B915FCCFA1A
	for <linux-um@archiver.kernel.org>; Sat,  8 Nov 2025 08:06:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LBx1RAda5jRhU5+5MRbhR+8InixhRX8igq/pYh2YNko=; b=J3ikmbnibBwO5CjnaYIJNWVPp0
	tKjNBNgd4HLz0OazCMUDzqp0jN00Nl7d10iRMxg36hXqmrVgVQzgb/wjmwbxhFBK2BCLWPnVFeO2d
	CWstN54/uoV8FG5hA1aJGPhOGIsFTufD+bTHxpGPWu+y06aKQe/DKjghgUbJbiMLFfNF0ck4+NBTt
	/k/q3TWaRF52KPKZwJSteQ7DdSbx6Pi2BelUo8/qzqxjBgbJAn+iP5XE+2dRLJbBqr1rMpnUN8bpc
	jAGcFukJA+gznIfphF7TS6szubd3mpPcYHs30i3NPS5LzEQwYHtXawsCdMr10nUOJmyoNxcZld0J3
	VsRfWr9g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vHdxf-00000002izC-27r6;
	Sat, 08 Nov 2025 08:06:15 +0000
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vHdxb-00000002iwM-2Emd
	for linux-um@lists.infradead.org;
	Sat, 08 Nov 2025 08:06:13 +0000
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-7a9c64dfa8aso1267488b3a.3
        for <linux-um@lists.infradead.org>; Sat, 08 Nov 2025 00:06:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762589171; x=1763193971; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LBx1RAda5jRhU5+5MRbhR+8InixhRX8igq/pYh2YNko=;
        b=EqkGJVcD5ZK4YX/jPSI1e5h+gfPSK55UKAYJUTqmqdzADm9oj8TXh2TFBdIDeLMuyN
         +2onN1k/IZFYnO64Ifpf2/JRUSsy4iGFmTSPGRItQCfR1/25huYanaZKPpqzasPf2A/6
         fvZ06n16G02entLsq34G77hZh5ragDO+1cuZSAtbjIJdoBpZ54FLNgwnpTwDelZEcw/n
         g8jr0grstQwv1MDZYjO0xEwxT6kTPhv6Z+ekwIU2QJe6ixYJWF//NyttxcLTaNMWTZc+
         4k8S4PQW4Lch9zA0OSkrpRJkSiUMqiui8cpzWym+vy50PJKOcQUqMq/k7L9wnTzzEkUU
         W6mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762589171; x=1763193971;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LBx1RAda5jRhU5+5MRbhR+8InixhRX8igq/pYh2YNko=;
        b=DnIQ0po8JYBZD9/jFRB98CFDmofueA74+1L1sgLp14VHCBfaiJ4RSgunc6HiRaQCkR
         Tc+KVsFGaiFaR5ocsRqzBSzs3TdaQ7jqkc3LqQq8awWgO+n0Cd2yhKbGKLN/GlhcaPyb
         wgLl0+wF+xQJWUmadYYlQwUMJXN30WedQ2OzkxLPxYoEKycuvX2Kzw2CO9sZxlw+irWQ
         eap621pgnaWB6IDulJdmR6zqnif8rZOh9eEaljxsc8OLtgAlTT4ecton76nDri5J4OTt
         YWdcU72Py5LoXyzolJUNbhLXHEeyelMY/SZ2Digs/HEMgSTW3/p5Hy1q0gsLih+pJxfw
         zquA==
X-Gm-Message-State: AOJu0YzQPvWfyhZf/2jgSJNSGPVFamYg8rfdlZej8uuIbgkGCFlhAcYi
	WP9V4UG4Ukp5fA5Icec/usjvyJUR0HfXSpC5awj2btqbhXiR50Rn0FC6
X-Gm-Gg: ASbGnctXQ0aRUZZqXPD7G0f7qWma8L8L50KMztATFxybEbJwAhvv6DQ9vVvggZmMMgB
	3F7iRqAforAGZ+CVVqLt3azW/KPe1LSeq1Je6HPhLcWtXY+Bv0zeT07ARlWPJurAKcnUYXFonge
	zf1l4saM/p4zrE17ZIO/F0xEZpNYgypcIJC2zHJGtAY5he28E5wxXUsG/b91p1/EGc8uCwF6qa5
	vHn5ODn7RuAMO1iCIpgArQoEFcC7XmTMuOzqZBDRSNMurA2RqmtPsg3/oRwoyV4vgOIPG1wvuTG
	dOWeJaJnIHTvXtbh+dFI85YIKJ+OQBw6daxQvQCp9bDxL9Xbj4mQFnofWaORMHsGfpfG5ByclS0
	YvJUc5NePw49XBcywKM9LB3Ja6F9oKAvqzj3Di3iUeTCuqQz3WTP8ILzahoFFO6PIvytUEy8U4T
	w5UmIQQkShpaFYOZLYhIGmZvoMQ5tSGfuJCLLFD+Qc2yMtHlrTcF1bjoua
X-Google-Smtp-Source: AGHT+IHzchLXWxzzDz1WxC3Dk4RM7G0kck5BQurVJPuk/UCkNNlsjtfs2t5XKr3BUU+NgfTwVrdmVA==
X-Received: by 2002:a05:6a21:6d83:b0:34e:7bef:e81d with SMTP id adf61e73a8af0-353a13a4dd7mr2538481637.8.1762589170593;
        Sat, 08 Nov 2025 00:06:10 -0800 (PST)
Received: from ikb-h07-29-noble.in.iijlab.net ([202.214.97.5])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ba8ffe3616fsm7280302a12.19.2025.11.08.00.06.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Nov 2025 00:06:09 -0800 (PST)
Received: by ikb-h07-29-noble.in.iijlab.net (Postfix, from userid 1010)
	id EE07211388D1; Sat,  8 Nov 2025 17:06:07 +0900 (JST)
From: Hajime Tazaki <thehajime@gmail.com>
To: linux-um@lists.infradead.org
Cc: thehajime@gmail.com,
	ricarkol@google.com,
	Liam.Howlett@oracle.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v13 06/13] x86/um: nommu: process/thread handling
Date: Sat,  8 Nov 2025 17:05:41 +0900
Message-ID: <ad45749c65e4d7316b1d52b0ef0ba3553c2f3ed9.1762588860.git.thehajime@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1762588860.git.thehajime@gmail.com>
References: <cover.1762588860.git.thehajime@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251108_000611_594157_74A36CEE 
X-CRM114-Status: GOOD (  17.57  )
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
index 39693807755a..98dc57afff83 100644
--- a/arch/x86/um/Makefile
+++ b/arch/x86/um/Makefile
@@ -26,7 +26,8 @@ subarch-y += ../kernel/sys_ia32.o
 
 else
 
-obj-y += mem_64.o syscalls_64.o vdso/
+obj-y += mem_64.o vdso/
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


