Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9CB9C71157
	for <linux-um@archiver.kernel.org>; Thu, 19 Jun 2025 01:04:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=l1JpwCKV9cSghAwgpJmSpCtGipBuaO2tDQC5fW0CSv4=; b=I0DyN9KmWxNXnitRhV8brs1EzA
	MGk/PPuTHKshrV4tKpb8DVofax4mRNePZre4LI7fTGZo4jZBv/YIixAiEUtiNAylqA/aku84uEO/G
	nPAQmE3Gzero5b50wja1PheNk+Qa699+shJoJrk9sgJSU13cLu6xNbLDD/D6yoBHw18l8U91XoRSE
	9fMXVknnS70uMRu9NZLnfdP/SK9pdmc7NJOTtNTyRgZHrDwYunHXiDgIffVsleQ6gOs0/W9TXKL7X
	aQhwZjERmmMbxZk05m6YmR2Ec3g+vF1UHkq1NermAXMLbyd/IEv/mQY+4lA14JABI/bxq/ho9d3ft
	BVeUaXhg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uS3hz-0000000BggF-2wdt;
	Thu, 19 Jun 2025 01:04:51 +0000
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uS3hw-0000000BgcX-1GNz
	for linux-um@lists.infradead.org;
	Thu, 19 Jun 2025 01:04:50 +0000
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-22c33677183so2582715ad.2
        for <linux-um@lists.infradead.org>; Wed, 18 Jun 2025 18:04:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750295087; x=1750899887; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l1JpwCKV9cSghAwgpJmSpCtGipBuaO2tDQC5fW0CSv4=;
        b=jK/kBZQZeOyzv0ZyCOhpoaCoiiKIMQmA7Vc8YerZQbPhh72BDsGkxr1DuxpsP/HR/p
         JkvtucUAKT18zyr9THBgfBe/xV/SqbMR+1CTxVCHYTf1c1AaseVxj/Tgw5DkmtM8q+Jz
         3SBCR6LnhORy9Q2u/XI7MZ/di4fwRQPYvooMvJbzEzwLHI/NjzI3OeBxNOaGwHsaV2VF
         H2/Ug6RK1cbzcvZdaDSGWpzQllNxFNzbGTBUIVgWQROpgoImXrWpK20tOoYoLtArBA+V
         G2acnIi3l5qHdkpuQEo/BsIRxYX3ZPcIbuPyv31vH5tww+Oa7qHaRF7CAgba/nvemv+E
         9DMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750295087; x=1750899887;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l1JpwCKV9cSghAwgpJmSpCtGipBuaO2tDQC5fW0CSv4=;
        b=Fdp42rXb/R7rTgirIVDgyOGtMSrZQBDe554zI8aH1tIMXLtu0jn+79FepAskoF853c
         Uj9H03ovc0Y/CSfcGT/fzSZKiRaqQqwz98XtEG+uYB7cHad4YYo3/fbtICS0D34Ya158
         xOClslNPvVxnYolhwan9bBtsQNrlXecV5QCsMQy/axu0pa5rkQB5tnozse0+4Csb/BuC
         cgNbvkVV21puhMiUCH2Ga4Js9ngk3aPbmRZAPjAvvby30ifi7hOauRfAdrtqIitNdg71
         icSsXSjGxzRjPHjlvJu0oVGwNhkO9aDZ6/8etYAWs3sGQ35vz+zTLTyPlOKgJf5XPIcf
         rirw==
X-Gm-Message-State: AOJu0Yz5y4EfBQ4OvlZ7WHRlK810gGm3FCjT5q6Eb2Wn6XYsXnA16j9K
	uSWWYx4RnaLMsNczcALR8hiWwNM2/YKYTgeSb+/DSxKUOpf3M99UmnvZ
X-Gm-Gg: ASbGnctH15zGNEoW92U0kHMwcl8nnAfim4AnuQvTyTiWgf9QqgEiMRqAYuM6cPavNV+
	GYxCdL6mWsL4tWXrR+R8qC3cvI6bM/WQsbgyt5ht2kAYyD7Hc/ybVuzojJx9u0Qti4AhvzRkaRa
	Kp76fYulE6EXLxpLfOXt4s+0elq5t+IhIK0ecVBEphjDill53ED1Uxh8SSa21KlqLnsKDGV6VTG
	o6xYSx5eZXlY6MUMDZ8PtaDVzD/arOtLoFXjsvOP+m+Hm/BNs87MbQp2+Sec0s0fgs40/Iv+L9N
	rzS+ue6H8IIlt1CcgR4RkOn5Sh0HX10w9UgZZfB4VpQAeM9db5KU/S7e+y4NPcNy7G4KTPZzIBU
	71Sy20TUFlnkMAxilrGnxLBmPqa8Hy4T5
X-Google-Smtp-Source: AGHT+IHDigGDVi6Llb6rP2JHFHMbl9WEBfHRUW50U+jgVpWh5ds2qZPmAqsuS7zCc3upwEx3RuRZdg==
X-Received: by 2002:a17:902:e805:b0:234:c65f:6c0c with SMTP id d9443c01a7336-2366b00ed66mr294160555ad.15.1750295087364;
        Wed, 18 Jun 2025 18:04:47 -0700 (PDT)
Received: from ikb-h07-29-noble.in.iijlab.net ([202.214.97.5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2365de782bdsm108126865ad.113.2025.06.18.18.04.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jun 2025 18:04:46 -0700 (PDT)
Received: by ikb-h07-29-noble.in.iijlab.net (Postfix, from userid 1010)
	id DD028ED6534; Thu, 19 Jun 2025 10:04:44 +0900 (JST)
From: Hajime Tazaki <thehajime@gmail.com>
To: linux-um@lists.infradead.org
Cc: thehajime@gmail.com,
	ricarkol@google.com,
	Liam.Howlett@oracle.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v9 06/13] x86/um: nommu: process/thread handling
Date: Thu, 19 Jun 2025 10:04:10 +0900
Message-ID: <031503649a24799bff082cf917c36550f4820181.1750294482.git.thehajime@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1750294482.git.thehajime@gmail.com>
References: <cover.1750294482.git.thehajime@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250618_180448_387073_313BAF3C 
X-CRM114-Status: GOOD (  18.14  )
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


