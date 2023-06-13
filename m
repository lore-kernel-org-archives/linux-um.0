Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A695CEB64DA
	for <linux-um@archiver.kernel.org>; Tue, 13 Jun 2023 23:39:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Date:MIME-Version:References:Subject:Cc
	:To:From:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=7359CdnfSk6wwd9gY+EOKpD3LYR8PZ8XvBv2SlxAo1E=; b=u1iXzVvsi8F43k
	09imcBwhGx4onmKDIGOOvtyP8J1uCp741GLf0PJDiaKHcqZ7BBZV+gxuemOo7FyQq/dlNt5QO6Fbp
	CQ2TR1skF9pctdORWHTeaPWwPa44Lw1T7aF+0jSQobnXJHl/WthBCRsgf1ct2HBjlhPColtuLuUoB
	OJpNfXiOgH7AKQZXQ7gFXjtm061eQKChMazWICTF8gAEqUT4Sf9FzvU1LSQE7c5dzk2NdHHDmKVdw
	1MgS1usjTL79JU2Lt1Q3brYspPRLUS4gBSVycMwqEg4Bf+eGOamKTfAX7a86m0ri+HcIIj/+i9hPm
	kcgQlRrx+Arss/ytRCAg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q9Dc8-009RbO-0d;
	Tue, 13 Jun 2023 23:39:52 +0000
Received: from galois.linutronix.de ([2a0a:51c0:0:12e:550::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q9Dbm-009RFQ-2E;
	Tue, 13 Jun 2023 23:39:38 +0000
Message-ID: <20230613224545.195288218@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1686699569;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=wAbnFBlurd+q5E9YGYWZQzKMTp8tWmNvPLQZMDxb/Z0=;
	b=Zbd+Ir52V2uzr84SvierPlBHrV4Z647TbDfnQDNmOz8wsBHhI1d0jbx2x2H4r0NktbREbQ
	28ckft5GWbaeip07ikMsd5MJbYiCi8IatCCi+2EN6HExK2NDajXlsCATRGvKhOVDcKhFmc
	9a2oImJ57XFcAA8hbs09AAGlr3jBInku7z1q9oOF9a/B7k1J9TPKJ9vYVxqApFK7CI/bd7
	xdpiBUxUZhxa6ZrUzVTUfs6hhkzmLmoqTMpmvK6zbWMJIBf/5rMs05SKGaoy2hbp/pGnKD
	ElHvnkYeIgDklS+Flj/Qcy1uzIc+V5Mhxk/nLp4THDyZxVhBIG24cKjKijysqg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1686699569;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=wAbnFBlurd+q5E9YGYWZQzKMTp8tWmNvPLQZMDxb/Z0=;
	b=AcuEE4hQ/G5Km4tkU+ef7uMrfhw8Xn+afVYkhiaEbiCBXOFGTRhMbw4Oh/nc0o3eWyoXw9
	9/6M+VRLTRLtIOAg==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: x86@kernel.org,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Nikolay Borisov <nik.borisov@suse.com>,
 "Ahmed S. Darwish" <darwi@linutronix.de>,
 Arnd Bergmann <arnd@arndb.de>,
 Huacai Chen <chenhuacai@kernel.org>,
 WANG Xuerui <kernel@xen0n.name>,
 loongarch@lists.linux.dev,
 Russell King <linux@armlinux.org.uk>,
 linux-arm-kernel@lists.infradead.org,
 linux-ia64@vger.kernel.org,
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
Subject: [patch 05/17] loongarch/cpu: Switch to arch_cpu_finalize_init()
References: <20230613223827.532680283@linutronix.de>
MIME-Version: 1.0
Date: Wed, 14 Jun 2023 01:39:28 +0200 (CEST)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230613_163930_873409_0C8E3CC8 
X-CRM114-Status: GOOD (  10.37  )
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
Cc: Huacai Chen <chenhuacai@kernel.org>
Cc: WANG Xuerui <kernel@xen0n.name>
Cc: loongarch@lists.linux.dev
---
 arch/loongarch/Kconfig            |    1 +
 arch/loongarch/include/asm/bugs.h |   15 ---------------
 arch/loongarch/kernel/setup.c     |    4 ++--
 3 files changed, 3 insertions(+), 17 deletions(-)

--- a/arch/loongarch/Kconfig
+++ b/arch/loongarch/Kconfig
@@ -10,6 +10,7 @@ config LOONGARCH
 	select ARCH_ENABLE_MEMORY_HOTPLUG
 	select ARCH_ENABLE_MEMORY_HOTREMOVE
 	select ARCH_HAS_ACPI_TABLE_UPGRADE	if ACPI
+	select ARCH_HAS_CPU_FINALIZE_INIT
 	select ARCH_HAS_FORTIFY_SOURCE
 	select ARCH_HAS_NMI_SAFE_THIS_CPU_OPS
 	select ARCH_HAS_PTE_SPECIAL
--- a/arch/loongarch/include/asm/bugs.h
+++ /dev/null
@@ -1,15 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/*
- * This is included by init/main.c to check for architecture-dependent bugs.
- *
- * Copyright (C) 2020-2022 Loongson Technology Corporation Limited
- */
-#ifndef _ASM_BUGS_H
-#define _ASM_BUGS_H
-
-#include <asm/cpu.h>
-#include <asm/cpu-info.h>
-
-extern void check_bugs(void);
-
-#endif /* _ASM_BUGS_H */
--- a/arch/loongarch/kernel/setup.c
+++ b/arch/loongarch/kernel/setup.c
@@ -12,6 +12,7 @@
  */
 #include <linux/init.h>
 #include <linux/acpi.h>
+#include <linux/cpu.h>
 #include <linux/dmi.h>
 #include <linux/efi.h>
 #include <linux/export.h>
@@ -37,7 +38,6 @@
 #include <asm/addrspace.h>
 #include <asm/alternative.h>
 #include <asm/bootinfo.h>
-#include <asm/bugs.h>
 #include <asm/cache.h>
 #include <asm/cpu.h>
 #include <asm/dma.h>
@@ -87,7 +87,7 @@ const char *get_system_type(void)
 	return "generic-loongson-machine";
 }
 
-void __init check_bugs(void)
+void __init arch_cpu_finalize_init(void)
 {
 	alternative_instructions();
 }


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
