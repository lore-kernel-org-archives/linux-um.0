Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62A17C0218E
	for <linux-um@archiver.kernel.org>; Mon, 20 Jan 2025 06:01:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jm6IxjOnnMbJUYZs2gNVL4tt81ftDTr84bAcBON9U+M=; b=prWPSgYf1ocuaNEbt47tInXg8m
	OKiAc2esKyIb5n6wCtiK9C8tmCx9u6KXOvyT4G4/YjE1t7XQ7ocieD+rgZuT62wVy/UYfhF6znuq7
	dRvnTk6X3QWTtIXB2rlWmS4Aig9+zqTPmrejQJwv1v3Ierma7Q7Y1HPSOy+Sb0mIABban7kpaEZsI
	gCxC90EtZnN+nHbfxFtTJtzby0xkZH8fJwmBIJhAb8AuX0hXnnpuGNB3kDJtWQTp74qxdFrvfn+D3
	4+4Opnl2HRGJeoBCgFrvG3vWvZ/zGmBilsRalCQW3ZoQMcczwbW5v8Sq44QfJLyIfP5w5JnOZ/w6P
	voVnzyQg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tZkr2-00000004nQ8-0RUV;
	Mon, 20 Jan 2025 06:01:44 +0000
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tZkpx-00000004nGJ-0yAr
	for linux-um@lists.infradead.org;
	Mon, 20 Jan 2025 06:00:38 +0000
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-2165cb60719so68697095ad.0
        for <linux-um@lists.infradead.org>; Sun, 19 Jan 2025 22:00:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737352836; x=1737957636; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jm6IxjOnnMbJUYZs2gNVL4tt81ftDTr84bAcBON9U+M=;
        b=FXOxiu7H4Rd5SUOmmLC3OxAqwgGUX0DfLXU17E/HZLOb5gof4cltrzeJyZPnQx3kv9
         LyKTleaXD8AuuHMR5jTtJzZh6QYNGjvtrLGSTwz/HmXMRtCmUXF73Vw/gik5BzbKqy9d
         KvYwKBfZWgJNFq91X5bP53CX+QKpUng1/3Kjtuoy/3HZvWJr6V1w4zNmHjTUv7hwJ/Y1
         p22Bh4xpGZcvU4YGOFIrE1htkT1BkBhpx7F2NyGBQbYBaoAysNuYlPAuKOsfF4IWXrkr
         HrQhLz366vM8mj9F6R2MMuHGkdTHEzZc/TVMpDoB9WAQYtOpG3tazPCfcnV+RdVptnHK
         vmow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737352836; x=1737957636;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jm6IxjOnnMbJUYZs2gNVL4tt81ftDTr84bAcBON9U+M=;
        b=Sk7oj6l9o8GcRB+Xo4wJbW4fX0jxqe5fdsTbspbYJmdfut2XqsyC/O1w1K/QzqxmRx
         nJoF36lUrsYtKXXT2FD9wvgp2n2HOWcymqcEp+GtE1DEJRAcQkpHao6qp7ixEg1AsMMS
         qj6otqZ6/ZFeV2mW+88FE/CSTxpGiyjTa2QSJZrjOByU6LcZQI4ZuNjsbYq/3rQ9szIb
         5PEdW9Lzdd5nOl/iOd0mmGAjnM2CSVHZr8L3QIUYr49534y0WdK+Aw1y+Wj93n6Pnd0X
         HVfeW8jkrZQ2dhDKXDXWVl2krV9eI/DhgBxQoFUh56LQf6Rt3rEbaY53OCNUq/8oOqIq
         NOEQ==
X-Gm-Message-State: AOJu0Yxadr+ywLRKEO1+JTv3ZNs13NHsnGf30qKgIf34/F4O7goAO5vc
	LgVhjVUN6Ag/o34jC9sFx2yXXwXu8ignlAGRcCUTaWryzjPMpwQb
X-Gm-Gg: ASbGncuOXMEvw38lqEYQoSWvEqRZ93tPL/X/hBy3IATdEUBgkTGfZ8ETte1JJwovyp1
	bREtaAZjyCs8msJ8yzSWoWcoZGYcM+pFuV1Yka+LeqPogjXWBv05GuhkMyUJPpnRR3rP0m/Zwqo
	Gw+P2NRYt5WfB4Ru14O83WUrGUSJU/hx0Ly7wZNP6oDzkPL2lyVv3bJp5j+LLVME+dU4aRBqTlm
	5xddkoAKK+fSiiuX/Z5KUoZqQ1EEpe197hnUA4cA99hNO3N24cNzY3UDLkOBUHPV3+Wezdh7puu
	sXx51Z1T10p4XXCgKZqY99N8xVV6FWcDlKd+jZzRUQ==
X-Google-Smtp-Source: AGHT+IGOEppRWtcvWytU0hNBFL1Yo+YpX8H0R96L1IP7qBE27bIuJFj22AYK14F3WHrDAFC9gIJhOw==
X-Received: by 2002:a17:903:1ca:b0:216:282d:c692 with SMTP id d9443c01a7336-21c355a4923mr177399535ad.34.1737352836284;
        Sun, 19 Jan 2025 22:00:36 -0800 (PST)
Received: from ikb-h07-29-noble.in.iijlab.net ([202.214.97.5])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-a9bdf0b7579sm5935175a12.73.2025.01.19.22.00.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jan 2025 22:00:35 -0800 (PST)
Received: by ikb-h07-29-noble.in.iijlab.net (Postfix, from userid 1010)
	id 1F597E27530; Mon, 20 Jan 2025 15:00:33 +0900 (JST)
From: Hajime Tazaki <thehajime@gmail.com>
To: linux-um@lists.infradead.org
Cc: thehajime@gmail.com,
	ricarkol@google.com,
	Liam.Howlett@oracle.com
Subject: [PATCH v7 07/13] x86/um: nommu: process/thread handling
Date: Mon, 20 Jan 2025 15:00:09 +0900
Message-ID: <ff6d5ab83baf97bc1a62d34f1ca1b45461bfe9fe.1737348400.git.thehajime@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1737348399.git.thehajime@gmail.com>
References: <cover.1737348399.git.thehajime@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250119_220037_272792_53FB8F00 
X-CRM114-Status: GOOD (  18.27  )
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
index e2dc00fc84c0..49aa8e92205e 100644
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


