Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E444C8303D
	for <linux-um@archiver.kernel.org>; Fri,  4 Jul 2025 13:21:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=a9BYaiJVl4UmBwvlWnq9S5EZ3328SPmr1ThpPQ1D3oc=; b=NHdPWf7gqrHfwc/3iyZ8KHnv8e
	3dPg3J5pBH2vyEKvqtAp8+OGWgp8M83pm617bpvluOADnjtFHIqva83nKh+uaOaYe8cG+tZ+pSlTt
	JN2J81C0Lpireg9G+w/b/TC3NKSUUpi9GhajuWKxwnCzv41bQ5kQ8GcduheoL8S1SW21DJnP6NSZ5
	lh2cDNtfbw5/KK8j73avPLak+j14a6ofjBkSFdqOYhOYUE3xcZbcsVSkgrCAnZjWLWaHTyihKZETY
	L2XzooKfOptgxHW0e2LXV8Bl9cNCRIzKdtZFckRjUwO04Rp99EjcqXTr4SG/HZMm3Ry7pVNeHAZQ0
	ev3/DRiw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uXgM9-0000000EUl4-037p;
	Fri, 04 Jul 2025 13:21:33 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uXfHj-0000000EMuB-37dA
	for linux-um@bombadil.infradead.org;
	Fri, 04 Jul 2025 12:12:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=a9BYaiJVl4UmBwvlWnq9S5EZ3328SPmr1ThpPQ1D3oc=; b=Lsej/F4Gv0SKkP8L/j/vrfoKXj
	oMhw4bEszQ7sDS/82UeH8VJHWw7i36UFU342anBvtHqE0K/L0KbqDf6ZVSMMWAyt2jwUN3F02YZae
	UdEQHLltr8OfACS8ZTdJh9tgBMT3MdNj35iynPzmCdcfWgOkGBoyPqVGHwAxXeGpIDV5SAiYAjrJn
	Ywsi/Zx70qXrHosf/AVgiqj+oe/QdAtdlLqVUsyF8DfNDjLp5oMpqOaa8pDdi0oksXL0onPor2lwb
	0jqBjVmYaYC8b5GRgBS0BNFA0OmRVCuCIxlGTkxBb0Ot3fvWaYZk51CilxdsIz2Ns1MwmOXJVTLW2
	1D+5tNJQ==;
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by desiato.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uXfHg-00000007xpO-45CT
	for linux-um@lists.infradead.org;
	Fri, 04 Jul 2025 12:12:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=a9BYaiJVl4UmBwvlWnq9S5EZ3328SPmr1ThpPQ1D3oc=; t=1751631171; x=1752840771; 
	b=sMPzwpzzIbwWxmoVtDJCTcMa0rDZ1HrvO8x+OqKxZXDb2uWwIS9wo57oOW9wG362B/OCf7V7Cw8
	nZd7SShrTYmw4pF0oU3V+YxYog2a4jk1dwi2NWmGbeo6jFWba99EyPIzh+0atx//wyH+o9NayNM+L
	Ep4/+yBgbpiPMBf2yGxvyOIc1q9Vd3w/bCV8aLT/vMZW0PvobzbvnBKGLw5QmhPhThESH7Vh5I7mf
	XNaP+j1ajJci3nC48YNoIWz6Ek9Lg0xmFpsCs2HwYsHM1nZjplarAFUlbXkxEb6Q5BYS/mJedRgmz
	nAlxgszx7PScePHYDGDMrVHmum0iqvOj6qrQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uXfHc-00000006pGq-0bdH;
	Fri, 04 Jul 2025 14:12:48 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-um@lists.infradead.org
Cc: =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH v2] um: simplify syscall header files
Date: Fri,  4 Jul 2025 14:12:42 +0200
Message-ID: <20250704141243.a68366f6acc3.If8587a4aafdb90644fc6d0b2f5e31a2d1887915f@changeid>
X-Mailer: git-send-email 2.50.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250704_131253_187296_E98F6F6C 
X-CRM114-Status: GOOD (  11.81  )
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

Since Thomas's recent commit 2af10530639b ("um/x86: Add
system call table to header file") , we now have two
extern declarations of the syscall table, one internal
and one external, and they don't even match on 32-bit.
Clean this up and remove all the extra code.

Reviewed-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
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


