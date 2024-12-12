Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDECBE77186
	for <linux-um@archiver.kernel.org>; Thu, 12 Dec 2024 10:14:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/S39BYTXgQcSrzSwc29SvRTt61wzYeoNwCcpdEkLhcY=; b=KswZfwBx4oMK/8NYZsQSKxYIpP
	msQGJz3o9GFbMbazp3Zw41Udan+ZdRoeJFSOCSXNT19lnnH8+aAWv34p5DlUaHiYdUbPuGOjgJn+h
	TZ/EofFw2x1mdmugMk/sRb6YuPs0nvDX8QjXmrjYsDtn29b2VTWABDKZgT9zdHptDXPMXNKdL5yKs
	dqIFIaWHvS8Xk5xMhILQyac6CWr2+wdXf22bBFfWiTNFTP3xhUvA9YOkAFBouO+G43YurvVRfG0Ey
	+OdKf05DDmTODRyvNUJwe1KJw+xMqq/rIbxt4+//9/zRjgGTFYHCxFg52zAh7IP6fYIrsI5Z23sMg
	l9ARRlgA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tLgDf-000000001RV-1bxJ;
	Thu, 12 Dec 2024 10:14:55 +0000
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tLgDI-000000001KV-3epz
	for linux-um@lists.infradead.org;
	Thu, 12 Dec 2024 10:14:34 +0000
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-72739105e02so496789b3a.0
        for <linux-um@lists.infradead.org>; Thu, 12 Dec 2024 02:14:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733998472; x=1734603272; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/S39BYTXgQcSrzSwc29SvRTt61wzYeoNwCcpdEkLhcY=;
        b=dQTI0acKrC9isn2wuFJlRcehFAMjL3apLoipMZ+7VrL8pdWZ+RQm94M8AiVxd2SoER
         sAks44iaJEw+oz40tRNxfI4yqQgi7kpJMbZIUF+PZ76AO8hIBHHMKLlm11IXOesF1bTN
         F9skSIVXwP3pXcmoBn1V25spcyS4Zi2WL4GjMcPpmMBbpqZGjqdZleQXwLt4thMjbMtR
         jtfSMNWP47ufY0S00L9Sj70H+PrSbBELVgR6WfQ1rx03cUjbHLFZX9XvwVd9uzpc3BP+
         MUsaTPDwWBhqNVWHyXblSshtEQVDSUABgb0YvKqsgqRdeRTZ2fcV4UbKM5jQwY6F2ULh
         I2Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733998472; x=1734603272;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/S39BYTXgQcSrzSwc29SvRTt61wzYeoNwCcpdEkLhcY=;
        b=BofLiIDRKisjVnxVOkoXRXeAm0mn4pLSPfX0AY4+o47lT/a2apume6vf8JKxfWsKAG
         LgGGM6SAXozt6U9QKxVF3D0/DhQISWaY2pM2avvUDm1loD52+yFuu6ssFVzyhDT8J8lf
         sKpbEP2oOsHwlJbjSQLa1Vua1TTABInQF6UY2TH3gEKxczRqL3LXqKa+oQRWLwrnnyh7
         fPrfOYVNGDuBWBQYT9tU/7CxSfNzGHvTASBLlfpp0bekxHHAZaXM7R4zbpnaO6+Y5V+h
         kPeG4pBMrZVk/a/qG8vUUUvAzkbCAgomGRX99OYobRdwC5WRer5m6w9t4byJ3vPP773K
         8cIg==
X-Gm-Message-State: AOJu0YyZosg1/wgaYyt28Y0irqkG55CMdyNLIuEh0T0hlW8lo0QG8vsA
	biKG4CYavMiMFcWmpvuV8MOThLOjQdGm7P7LhR1ZWZYcr9AWkPGz
X-Gm-Gg: ASbGncuKxW0GRDCBuovE/YlkCgj/8T7/ZYKRwvW1oqnTW84RSlMV71/B7r0YnD1O/Vl
	FeItwS+OAhc9zsBy4ILygzDRwHoRDJmpHWwYEx4hGlNYFiuwa0u/FO9WlCJrNaGA1NMJtYB6n7U
	HkmmZ7xxIPLNBTidRwD3CQmq8J/SPMCTP1/uHrt1Zdwjf4iYqpDcCekZuQh3FZ+r1mfTp4jXQER
	I2xxX43X6Rnu3oJqFFW9GGxBjHkxuhDs0rp5hXiPGSSEPQ1Npliw8HsW76SD681EEI7g2unMHEZ
	QmVAXJxn5AL8RPrTl5AIGMq8lmY=
X-Google-Smtp-Source: AGHT+IG634k/43yRGTmlVZv/xWXyPFX3Rrnoru7H9Ut6VRe/Zah6k3+7q9VfrFulsUOJdEvxWkWm3w==
X-Received: by 2002:a05:6a00:9289:b0:725:b1df:2daa with SMTP id d2e1a72fcca58-728faaa862emr3470723b3a.20.1733998471921;
        Thu, 12 Dec 2024 02:14:31 -0800 (PST)
Received: from ikb-h07-29-noble.in.iijlab.net ([202.214.97.5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-725cc7fcfb2sm9613306b3a.141.2024.12.12.02.14.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2024 02:14:31 -0800 (PST)
Received: by ikb-h07-29-noble.in.iijlab.net (Postfix, from userid 1010)
	id 3C714DDEECA; Thu, 12 Dec 2024 19:14:29 +0900 (JST)
From: Hajime Tazaki <thehajime@gmail.com>
To: linux-um@lists.infradead.org
Cc: thehajime@gmail.com,
	ricarkol@google.com,
	Liam.Howlett@oracle.com
Subject: [PATCH v5 07/13] x86/um: nommu: process/thread handling
Date: Thu, 12 Dec 2024 19:12:14 +0900
Message-ID: <17a14e11567ed325d4255528ff69049072c22b30.1733998168.git.thehajime@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1733998168.git.thehajime@gmail.com>
References: <cover.1733998168.git.thehajime@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241212_021432_916110_6661F4A0 
X-CRM114-Status: GOOD (  17.20  )
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

Signed-off-by: Hajime Tazaki <thehajime@gmail.com>
Signed-off-by: Ricardo Koller <ricarkol@google.com>
---
 arch/um/os-Linux/process.c      |  6 +++++
 arch/x86/um/Makefile            |  3 ++-
 arch/x86/um/nommu/Makefile      |  2 +-
 arch/x86/um/nommu/entry_64.S    | 22 +++++++++++++++++
 arch/x86/um/nommu/syscalls_64.c | 44 +++++++++++++++++++++++++++++++++
 5 files changed, 75 insertions(+), 2 deletions(-)
 create mode 100644 arch/x86/um/nommu/syscalls_64.c

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


