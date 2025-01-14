Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A58D8C02183
	for <linux-um@archiver.kernel.org>; Tue, 14 Jan 2025 11:32:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/S39BYTXgQcSrzSwc29SvRTt61wzYeoNwCcpdEkLhcY=; b=eZGeW+QyJAI4d37BdUmFD5Bcea
	8fSWR58MClEbaZoYd0uTW/XMmqrYHTOkVw7d0epz0Jvyh+l4AyiRcWqBFbFY2RudtGej4WXJEhqxG
	IPVl6yYrllhPKHKhRS/2eHmOhXsXNS29ppodL4ERCfxQTw8Buvh02AA8UxUlcDNa/w+hDYqYBX0Z8
	vfCoox4ZUllXSONdNeEYV74t8bW1GbZdNjmqQL+I/UxDu7sHfL/BzSBWe96KuWfuQOdLrEBZwF3YP
	duQdceS9aHlZzeHxcJi9mEytccpiSmZfXZBX6rpL14QlfJDM+zIlhBbQZxW4BDNPC9k0VXq57OgQp
	B/oKLsjA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tXf9c-00000008GL5-1FkL;
	Tue, 14 Jan 2025 11:32:16 +0000
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tXf8d-00000008G5c-1NYP
	for linux-um@lists.infradead.org;
	Tue, 14 Jan 2025 11:31:16 +0000
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-215770613dbso64128085ad.2
        for <linux-um@lists.infradead.org>; Tue, 14 Jan 2025 03:31:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736854275; x=1737459075; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/S39BYTXgQcSrzSwc29SvRTt61wzYeoNwCcpdEkLhcY=;
        b=iGp4Xn7j3V6xQQyBbNoWeJAfu7POTASoIIYSsGDMqTBQMTRE3Sh8WI/GuwukCACAJe
         lDL6uBnJL8+PgKV15C14/zWK17/4CyDjJD0SJAMVW3DsTa9yqoTMzH7xr+rHi0nFaO7J
         YZZaDUtgu/pHdsPxDcTm87sAVb1dEEkgJgCKSjAn3VS1sWQGEiD/EHhqhPWAWFjxNmMv
         THpP9vUOAKbJ9sE0Bq+gYlgAkQbZWcvEkEVgEmHklqEfMD3xWaEq1L+p5j/BANLQdRjm
         KnkbMsQdQuDrehX866+WuVgiEzZanho62azHhGxNfB13H0D2HHR9n+JaPWqNmfjDbDZU
         yXaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736854275; x=1737459075;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/S39BYTXgQcSrzSwc29SvRTt61wzYeoNwCcpdEkLhcY=;
        b=gCHmYP+LO+Da9l2MXLnrfRCvPVtxy/4fleL1o5tg1LtA6anuTF7LySJeNiGqQ9d1f/
         lr01Rk5P8NVBOdhtxtyioVK6yLgu4Do4CQ/u+wwcIk/sQi25oWJge7NC6NYpboucUjmi
         cSQmZ4PljPFnvWwswPrIMHPqWPJ58ygm6wSod6vtIi4LFCtRYh7MenpRUrs6xAdPUvVd
         mokcaoDyVJljmcILhvvSLor4Wydqv+zZlsy8jKBklcwSJARdw4P5QYD2CrGlISPaftDq
         K9OlSj6nOILlIZVrg2aEyABnUieo9zTamWu/fRRvDgKf3LZv3HmdqiIchIfzzWu77msi
         8wNA==
X-Gm-Message-State: AOJu0YzW5ZutzvTfbm1yP3buQh5T5WQNhtWoTuIFiiiV5w2V8rpnqC2Q
	BOEAlJ1SLw0+B/890XJwguPFWhpL5ljp3a9xmjfPlkncdMQ6pTQx
X-Gm-Gg: ASbGncswSq1pSy4spcgYs1fkdxVyXVhyXCxavSqMRivMCyhy1esHApslKA2fbH/n9Pq
	r9Sy+IvL4ue/C2kTB7sujKT89rRooWtbLqecgY9SZ+He8meioM3VOLEpddONTyHleH+UzuP0U04
	xhb+gBd/gAvI5ZljTDl+QAeY7p+bTnTkuprYhsGuFjjVn0UScQhnOXjaQmFqWkYPRC7WQT9Nego
	qz2fC5wVr7uv+1kARWXcD2tskswCsQHIlxAk4OXMd41wX03YQ+mLFmvEA7TQ8TxmwMJnGnRalqc
	QX7CGSLBZ+FngFs6uko5dWUKDTV2
X-Google-Smtp-Source: AGHT+IHRUxQBMZHwFhD/kJIxpHPlwUkACA77p2f7V2JYM5yc85wChJJNDbnNhpVJcL1hrpl3deHkCg==
X-Received: by 2002:a17:902:fc8f:b0:215:787a:f91a with SMTP id d9443c01a7336-21a83fd1e96mr426204055ad.44.1736854274581;
        Tue, 14 Jan 2025 03:31:14 -0800 (PST)
Received: from ikb-h07-29-noble.in.iijlab.net ([202.214.97.5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f55946081asm10257676a91.40.2025.01.14.03.31.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2025 03:31:13 -0800 (PST)
Received: by ikb-h07-29-noble.in.iijlab.net (Postfix, from userid 1010)
	id 8D77FE1AB5A; Tue, 14 Jan 2025 20:31:11 +0900 (JST)
From: Hajime Tazaki <thehajime@gmail.com>
To: linux-um@lists.infradead.org
Cc: thehajime@gmail.com,
	ricarkol@google.com,
	Liam.Howlett@oracle.com
Subject: [PATCH v6 07/13] x86/um: nommu: process/thread handling
Date: Tue, 14 Jan 2025 20:30:45 +0900
Message-ID: <52a489743f82d1889c7ece42e34d2f617c16129c.1736853926.git.thehajime@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1736853925.git.thehajime@gmail.com>
References: <cover.1736853925.git.thehajime@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250114_033115_369022_607439DA 
X-CRM114-Status: GOOD (  17.33  )
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


