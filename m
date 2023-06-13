Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE679EB64DC
	for <linux-um@archiver.kernel.org>; Tue, 13 Jun 2023 23:39:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Date:MIME-Version:References:Subject:Cc
	:To:From:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=fS3K+qM6L5LK+YRmMF+1+CA8MdtbOWHGQhsnHHTQ+qk=; b=s906GhNos6ioS+
	JL7wBb8M394TFRNCYPTkrHJ0lZssltRZCvZNt3s2FIkUzQ293OKgU+MwQrlyqkxnlNKqWd9GseMO1
	XY6SsbDx2TFCBrPUPpjfKQdA5nypd37oVOTR+zxhLK/lMl/iHEvFNo0pgf0aWEN2udnjB2Js9AWn7
	9sefrbFl4V7cHsB0ikAsYjUfeF3hsybQUF2p4FQKIvvhMt21tx/bcNjso99tnQHlbzEza8sBBG+tg
	LT0gXz4OwWYVVUKRbTcTELKvG0OLOHo2QbKOfs5ysg9nvNQLsudOh8S1DRIoac0wn+Ck5ur2QMjsR
	iLdPPGcGT8O/Lg5yEsiA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q9Dbs-009RM8-1W;
	Tue, 13 Jun 2023 23:39:36 +0000
Received: from galois.linutronix.de ([2a0a:51c0:0:12e:550::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q9Dbj-009RDt-2O;
	Tue, 13 Jun 2023 23:39:33 +0000
Message-ID: <20230613224545.078124882@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1686699566;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=dVFthLCRReoMWN5sC8FHYm0TEZ3L3fBC7evr6n0+Mk4=;
	b=TpU4F3Cm21DA+wjsqv0/P+lCFo9Kph9tSJszuyDewJQpAkHNucWI6VQGH2ovheCCeLSwPM
	8L0zJwOQu4OwERTYKoBKWk8lYaWsIeNJKgE/BZ+3odqC4pib9gmV3UiyFV64EYaagE2pPe
	Exd1bgLoh+RHn42egy6GkWFY/dWoZ6kiRe8LYhwBFTmq/5hx2Xeu6+ayFJlro4BKpaVqTF
	hoqWbHNhlfn0CKlpuwRtoRE/a9lZ6ft1xMPStZm61XNHf4WWtkCgcdqEVZdekO3JFHK0bm
	4FNS7A0stNubNTTdH46Z7QDtve7F2+5WqKGyGo7lcEMug4LbJl6Tow46fGqshQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1686699566;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=dVFthLCRReoMWN5sC8FHYm0TEZ3L3fBC7evr6n0+Mk4=;
	b=n9/kemZ7bnQmtNpLkJz9kR9cP/+4kE35m9KdxwLlgsl/n5lmdDRb0Z74LTL1qsMW2Ghy/D
	ZsktOSy4OXsR84Bg==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: x86@kernel.org,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Nikolay Borisov <nik.borisov@suse.com>,
 "Ahmed S. Darwish" <darwi@linutronix.de>,
 Arnd Bergmann <arnd@arndb.de>,
 Russell King <linux@armlinux.org.uk>,
 linux-arm-kernel@lists.infradead.org,
 linux-ia64@vger.kernel.org,
 Huacai Chen <chenhuacai@kernel.org>,
 WANG Xuerui <kernel@xen0n.name>,
 loongarch@lists.linux.dev,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 linux-m68k@lists.linux-m68k.org,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 linux-mips@vger.kernel.org,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Rich Felker <dalias@libc.org>,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 linux-sh@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>,
 sparclinux@vger.kernel.org,
 Richard Weinberger <richard@nod.at>,
 Anton Ivanov <anton.ivanov@cambridgegreys.com>,
 Johannes Berg <johannes@sipsolutions.net>,
 linux-um@lists.infradead.org,
 Richard Henderson <richard.henderson@linaro.org>,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Chris Zankel <chris@zankel.net>,
 Tom Lendacky <thomas.lendacky@amd.com>
Subject: [patch 03/17] ARM: cpu: Switch to arch_cpu_finalize_init()
References: <20230613223827.532680283@linutronix.de>
MIME-Version: 1.0
Date: Wed, 14 Jun 2023 01:39:25 +0200 (CEST)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230613_163928_121741_A7302FDE 
X-CRM114-Status: GOOD (  12.03  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

check_bugs() is about to be phased out. Switch over to the new
arch_cpu_finalize_init() implementation.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-kernel@lists.infradead.org
---
 arch/arm/Kconfig            |    1 +
 arch/arm/include/asm/bugs.h |    4 ----
 arch/arm/kernel/bugs.c      |    3 ++-
 3 files changed, 3 insertions(+), 5 deletions(-)

--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -5,6 +5,7 @@ config ARM
 	select ARCH_32BIT_OFF_T
 	select ARCH_CORRECT_STACKTRACE_ON_KRETPROBE if HAVE_KRETPROBES && FRAME_POINTER && !ARM_UNWIND
 	select ARCH_HAS_BINFMT_FLAT
+	select ARCH_HAS_CPU_FINALIZE_INIT if MMU
 	select ARCH_HAS_CURRENT_STACK_POINTER
 	select ARCH_HAS_DEBUG_VIRTUAL if MMU
 	select ARCH_HAS_DMA_WRITE_COMBINE if !ARM_DMA_MEM_BUFFERABLE
--- a/arch/arm/include/asm/bugs.h
+++ b/arch/arm/include/asm/bugs.h
@@ -1,7 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0-only */
 /*
- *  arch/arm/include/asm/bugs.h
- *
  *  Copyright (C) 1995-2003 Russell King
  */
 #ifndef __ASM_BUGS_H
@@ -10,10 +8,8 @@
 extern void check_writebuffer_bugs(void);
 
 #ifdef CONFIG_MMU
-extern void check_bugs(void);
 extern void check_other_bugs(void);
 #else
-#define check_bugs() do { } while (0)
 #define check_other_bugs() do { } while (0)
 #endif
 
--- a/arch/arm/kernel/bugs.c
+++ b/arch/arm/kernel/bugs.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <linux/init.h>
+#include <linux/cpu.h>
 #include <asm/bugs.h>
 #include <asm/proc-fns.h>
 
@@ -11,7 +12,7 @@ void check_other_bugs(void)
 #endif
 }
 
-void __init check_bugs(void)
+void __init arch_cpu_finalize_init(void)
 {
 	check_writebuffer_bugs();
 	check_other_bugs();


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
