Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A43FC83F03
	for <linux-um@archiver.kernel.org>; Fri,  4 Jul 2025 11:53:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=B+C0/gM5J/uPpAADC/iJxiCPB0YlND9L3LLWkCMcsFY=; b=HssNPQW2xjFmN+DK9kXdDX2XM2
	hFSRMd+/OIVYitKT2aDmQ/XJ2rP64l58V2PY8TJvFTo7lzVvJG1bbTWz39aXva0WaA+Ct7gOuBbFm
	pj5qBlR2yzM7O18XGpCvD6w6FP2+rmacJorPzB9C1pg2ZnQvnyPi87g8nUUOPYKkWRDzRICvqkmtW
	ZFTjFuLYzeNIe74ZInQlnFth1Ut/rLZBdl0pyfIrM0xRf4WP0XyUulw9i9HpWa+RYGqZHWxqiwXkh
	ypLiGjWRG5MewzaFdpBRDLkDGRyg6J0oUJ7s+BUXqC7cwIi6vBJZTGp08fhYQiHQyMLKacpNsRHfb
	fA6WuqEA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uXeyo-0000000EIlf-42eA;
	Fri, 04 Jul 2025 11:53:22 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uXeby-0000000EElH-3L4w
	for linux-um@lists.infradead.org;
	Fri, 04 Jul 2025 11:29:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=B+C0/gM5J/uPpAADC/iJxiCPB0YlND9L3LLWkCMcsFY=; t=1751628585; x=1752838185; 
	b=BpDWxmO+3IhUh2yklJh05nObG1UGX9eln75kGbqjUEUfXprL24/OUCtp83mA+RRk0LiCIRYQsdY
	o71gR7iFOl2iOOxDVCkWUzOsj8/nDd1OIvb/vrAsKRfX67Gqa1dfxBsoY7w6X5RQrzp395vZMXRB/
	yVHStB/rkCbR86pb0B1sWRwSjeMvrB7CNr+KRQ5dmM+Mil6wa9UWc74AeeVuk8hs8rL0F9P9Xxd9Y
	cQB/HjFji2nEh20yejOVmQsqBgBIA7gcNSk46/0CAp3n8iLZPSuzlKs1KQ8sF1xQmNflBvUSNADBb
	YBzAac034vuUc/WqMn/onD2utW+lwL2aD/Fw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uXebu-00000006mPu-2ZIw;
	Fri, 04 Jul 2025 13:29:42 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-um@lists.infradead.org
Cc: =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH] um: simplify syscall header files
Date: Fri,  4 Jul 2025 13:29:40 +0200
Message-ID: <20250704132940.31db287f5b9d.If8587a4aafdb90644fc6d0b2f5e31a2d1887915f@changeid>
X-Mailer: git-send-email 2.50.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250704_042946_857751_3091F2E5 
X-CRM114-Status: GOOD (  11.43  )
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

From: Johannes Berg <johannes.berg@intel.com>

Since Thomas's recent commit, we now have two extern
declarations of the syscall table, one internal and
one external, and they don't even match on 32-bit.
Clean this up and remove all the extra code.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 arch/um/kernel/skas/syscall.c           | 11 ++++++++--
 arch/x86/um/shared/sysdep/ptrace.h      | 12 -----------
 arch/x86/um/shared/sysdep/syscalls.h    |  6 ------
 arch/x86/um/shared/sysdep/syscalls_32.h | 14 -------------
 arch/x86/um/shared/sysdep/syscalls_64.h | 28 -------------------------
 5 files changed, 9 insertions(+), 62 deletions(-)
 delete mode 100644 arch/x86/um/shared/sysdep/syscalls.h
 delete mode 100644 arch/x86/um/shared/sysdep/syscalls_32.h
 delete mode 100644 arch/x86/um/shared/sysdep/syscalls_64.h

diff --git a/arch/um/kernel/skas/syscall.c b/arch/um/kernel/skas/syscall.c
index a5beaea2967e..ba7494f9bfe4 100644
--- a/arch/um/kernel/skas/syscall.c
+++ b/arch/um/kernel/skas/syscall.c
@@ -9,8 +9,8 @@
 #include <kern_util.h>
 #include <sysdep/ptrace.h>
 #include <sysdep/ptrace_user.h>
-#include <sysdep/syscalls.h>
 #include <linux/time-internal.h>
+#include <asm/syscall.h>
 #include <asm/unistd.h>
 #include <asm/delay.h>
 
@@ -43,7 +43,14 @@ void handle_syscall(struct uml_pt_regs *r)
 		tt_extra_sched_jiffies += 1;
 
 	if (syscall >= 0 && syscall < __NR_syscalls) {
-		unsigned long ret = EXECUTE_SYSCALL(syscall, regs);
+		unsigned long ret;
+
+		ret = (*sys_call_table[syscall])(UPT_SYSCALL_ARG1(&regs->regs),
+						 UPT_SYSCALL_ARG2(&regs->regs),
+						 UPT_SYSCALL_ARG3(&regs->regs),
+						 UPT_SYSCALL_ARG4(&regs->regs),
+						 UPT_SYSCALL_ARG5(&regs->regs),
+						 UPT_SYSCALL_ARG6(&regs->regs));
 
 		PT_REGS_SET_SYSCALL_RETURN(regs, ret);
 
diff --git a/arch/x86/um/shared/sysdep/ptrace.h b/arch/x86/um/shared/sysdep/ptrace.h
index 8f7476ff6e95..572ea2d79131 100644
--- a/arch/x86/um/shared/sysdep/ptrace.h
+++ b/arch/x86/um/shared/sysdep/ptrace.h
@@ -44,18 +44,6 @@
 #include "ptrace_64.h"
 #endif
 
-struct syscall_args {
-	unsigned long args[6];
-};
-
-#define SYSCALL_ARGS(r) ((struct syscall_args) \
-			 { .args = { UPT_SYSCALL_ARG1(r),	 \
-				     UPT_SYSCALL_ARG2(r),	 \
-				     UPT_SYSCALL_ARG3(r),	 \
-				     UPT_SYSCALL_ARG4(r),	 \
-				     UPT_SYSCALL_ARG5(r),	 \
-				     UPT_SYSCALL_ARG6(r) } } )
-
 extern unsigned long host_fp_size;
 
 struct uml_pt_regs {
diff --git a/arch/x86/um/shared/sysdep/syscalls.h b/arch/x86/um/shared/sysdep/syscalls.h
deleted file mode 100644
index b2060ac707f0..000000000000
--- a/arch/x86/um/shared/sysdep/syscalls.h
+++ /dev/null
@@ -1,6 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifdef __i386__
-#include "syscalls_32.h"
-#else
-#include "syscalls_64.h"
-#endif
diff --git a/arch/x86/um/shared/sysdep/syscalls_32.h b/arch/x86/um/shared/sysdep/syscalls_32.h
deleted file mode 100644
index f6e9f84397e7..000000000000
--- a/arch/x86/um/shared/sysdep/syscalls_32.h
+++ /dev/null
@@ -1,14 +0,0 @@
-/* 
- * Copyright (C) 2000 - 2008 Jeff Dike (jdike@{addtoit,linux.intel}.com)
- * Licensed under the GPL
- */
-
-#include <asm/unistd.h>
-#include <sysdep/ptrace.h>
-
-typedef long syscall_handler_t(struct syscall_args);
-
-extern syscall_handler_t *sys_call_table[];
-
-#define EXECUTE_SYSCALL(syscall, regs) \
-	((*sys_call_table[syscall]))(SYSCALL_ARGS(&regs->regs))
diff --git a/arch/x86/um/shared/sysdep/syscalls_64.h b/arch/x86/um/shared/sysdep/syscalls_64.h
deleted file mode 100644
index b6b997225841..000000000000
--- a/arch/x86/um/shared/sysdep/syscalls_64.h
+++ /dev/null
@@ -1,28 +0,0 @@
-/*
- * Copyright 2003 PathScale, Inc.
- *
- * Licensed under the GPL
- */
-
-#ifndef __SYSDEP_X86_64_SYSCALLS_H__
-#define __SYSDEP_X86_64_SYSCALLS_H__
-
-#include <linux/msg.h>
-#include <linux/shm.h>
-
-typedef long syscall_handler_t(long, long, long, long, long, long);
-
-extern syscall_handler_t *sys_call_table[];
-
-#define EXECUTE_SYSCALL(syscall, regs) \
-	(((*sys_call_table[syscall]))(UPT_SYSCALL_ARG1(&regs->regs), \
-		 		      UPT_SYSCALL_ARG2(&regs->regs), \
-				      UPT_SYSCALL_ARG3(&regs->regs), \
-				      UPT_SYSCALL_ARG4(&regs->regs), \
-				      UPT_SYSCALL_ARG5(&regs->regs), \
-				      UPT_SYSCALL_ARG6(&regs->regs)))
-
-extern syscall_handler_t sys_modify_ldt;
-extern syscall_handler_t sys_arch_prctl;
-
-#endif
-- 
2.50.0


