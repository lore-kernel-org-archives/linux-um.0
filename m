Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00EF5EB64D7
	for <linux-um@archiver.kernel.org>; Tue, 13 Jun 2023 23:40:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Date:MIME-Version:References:Subject:Cc
	:To:From:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=qpk5E+7BV+wx7arGvKLJ0xJy4gxdo1YTvT9IevfWcSA=; b=nAC3zL/9ksMWgm
	vi6UjiHI12uk83aAQzAh9lguIGlNhDBeICxRDME4u5kMdUmFB4IGHCNH4XgJ3mQrs8EImvgPSIJOU
	NviCGTT4P7MJRuPYJbHH6vRpslF53oP/N1bCl/biNPrChtzU4nqDIQitInWjubBoNiR3cARvsZObf
	URPDEGXwGR/ydsRgBTeEa9STCLVgKPhhwHN5ZCi2ZiA7bCegzZNjj0NHh4LEAmzVYLtXH+fkI/RSl
	exQuphRUuMhXb2jLkKBY6JnQ3+p0YkIET9wMGsRjOLdL+IHaGE2KF318GcUrVQtVrZMFvCYmyHTFy
	4NXFCEYIW64UaSgWbIuA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q9DcG-009Ri2-1t;
	Tue, 13 Jun 2023 23:40:00 +0000
Received: from galois.linutronix.de ([2a0a:51c0:0:12e:550::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q9Dbo-009RGt-0h;
	Tue, 13 Jun 2023 23:39:38 +0000
Message-ID: <20230613224545.254342916@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1686699571;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=S1ZfOkoiJB2kbqQox9OxmAfYtyI5QC2rzE61oGY2waI=;
	b=vF5HDxYbH8punvcwCLqKLMPap6u7XVFG9M5EvE1E2tB0CBoFcslhDsWEOgEjR+ZvsUTSpQ
	zzhInPUPy6roQjFul3ergv18bmONVjj7gNedoZqv9o4IiuPaF4ueCxogB6kh2haB9erQ3w
	YkG+GUbwDxusli6NoMhxb0+PVh+MTuTLcrHtPMqmvSdDz+gxJqBvJ7g9SmHBia8x6Uwiky
	BlvQzkCIhGguRmFm2VGi3VJP3a5oe35HHlvt6P70AVcKGjy69E6Lo6e0jN5E60nOO0ak5M
	U3DCFcJmKFiD8pc97pHKSWH5p1GyWpENCSENgnVCNwX9keOG/JpHayojaCiMgQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1686699571;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=S1ZfOkoiJB2kbqQox9OxmAfYtyI5QC2rzE61oGY2waI=;
	b=SgpjluZPAEQtuKC4D/witxOPknzFWf9AB0QjDMq+evSyPu16vpYbAaf0xJhRGEtVEn2IUL
	tV683ff+pApvZSBg==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: x86@kernel.org,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Nikolay Borisov <nik.borisov@suse.com>,
 "Ahmed S. Darwish" <darwi@linutronix.de>,
 Arnd Bergmann <arnd@arndb.de>,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 linux-m68k@lists.linux-m68k.org,
 Russell King <linux@armlinux.org.uk>,
 linux-arm-kernel@lists.infradead.org,
 linux-ia64@vger.kernel.org,
 Huacai Chen <chenhuacai@kernel.org>,
 WANG Xuerui <kernel@xen0n.name>,
 loongarch@lists.linux.dev,
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
Subject: [patch 06/17] m68k/cpu: Switch to arch_cpu_finalize_init()
References: <20230613223827.532680283@linutronix.de>
MIME-Version: 1.0
Date: Wed, 14 Jun 2023 01:39:30 +0200 (CEST)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230613_163932_394056_9E819281 
X-CRM114-Status: GOOD (  11.56  )
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
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-m68k@lists.linux-m68k.org
---
 arch/m68k/Kconfig            |    1 +
 arch/m68k/include/asm/bugs.h |   21 ---------------------
 arch/m68k/kernel/setup_mm.c  |    3 ++-
 3 files changed, 3 insertions(+), 22 deletions(-)

--- a/arch/m68k/Kconfig
+++ b/arch/m68k/Kconfig
@@ -4,6 +4,7 @@ config M68K
 	default y
 	select ARCH_32BIT_OFF_T
 	select ARCH_HAS_BINFMT_FLAT
+	select ARCH_HAS_CPU_FINALIZE_INIT if MMU
 	select ARCH_HAS_CURRENT_STACK_POINTER
 	select ARCH_HAS_DMA_PREP_COHERENT if HAS_DMA && MMU && !COLDFIRE
 	select ARCH_HAS_SYNC_DMA_FOR_DEVICE if HAS_DMA
--- a/arch/m68k/include/asm/bugs.h
+++ /dev/null
@@ -1,21 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/*
- *  include/asm-m68k/bugs.h
- *
- *  Copyright (C) 1994  Linus Torvalds
- */
-
-/*
- * This is included by init/main.c to check for architecture-dependent bugs.
- *
- * Needs:
- *	void check_bugs(void);
- */
-
-#ifdef CONFIG_MMU
-extern void check_bugs(void);	/* in arch/m68k/kernel/setup.c */
-#else
-static void check_bugs(void)
-{
-}
-#endif
--- a/arch/m68k/kernel/setup_mm.c
+++ b/arch/m68k/kernel/setup_mm.c
@@ -10,6 +10,7 @@
  */
 
 #include <linux/kernel.h>
+#include <linux/cpu.h>
 #include <linux/mm.h>
 #include <linux/sched.h>
 #include <linux/delay.h>
@@ -504,7 +505,7 @@ static int __init proc_hardware_init(voi
 module_init(proc_hardware_init);
 #endif
 
-void check_bugs(void)
+void __init arch_cpu_finalize_init(void)
 {
 #if defined(CONFIG_FPU) && !defined(CONFIG_M68KFPU_EMU)
 	if (m68k_fputype == 0) {


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
