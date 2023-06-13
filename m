Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A96FEB64D8
	for <linux-um@archiver.kernel.org>; Tue, 13 Jun 2023 23:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Date:MIME-Version:References:Subject:Cc
	:To:From:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=aFnQuQLV6xAgQOW9K5wpmLvZ4e2KfQXYm4Ps4gaSejM=; b=WWZtqFwO99i1Wr
	IDcdLBS21HgnNagNAXh3FMl0tn+Zhp4G4DUcwGPItj7q1qIuC9s5VM6HKBI2C6YJKVRKq9kzoC9cU
	V/mYYyKizpMjIEPr/+GCGwXcDL87M7jocqpDi8T63rRxgRStU+6nZRp1Kxp8S2BaF/M2FSqpWP3HE
	TIje907L4+aHPWVBNzH1nsky2ngNzVP3Ac1n7yyuFMazZ2EnEC92tR4ZwHP6siauRkfnPOB0GMGM0
	/5sOPn8tbC60kNMAxFkzX49POLjggRxII9zZ9PFPZVEDIMiIG5gH7v54kEj94i3mQ4gucrU5x9Bgr
	1uQ6SF2CoIAIogl2gc+A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q9Dcd-009S0H-0D;
	Tue, 13 Jun 2023 23:40:23 +0000
Received: from galois.linutronix.de ([193.142.43.55])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q9Dbv-009RP4-2f;
	Tue, 13 Jun 2023 23:39:49 +0000
Message-ID: <20230613224545.553215951@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1686699578;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=k8gjwvZjutOT4dHhfWGxf+PGA1gm8Km0IyXoTok3KA4=;
	b=v8W2XlvrpPYRmnFVsA9HCf8AAEeUri3PKcSbwDBhRbwhqwQtRa3HmK1Q+2f3969zDWfvCU
	f+45JzSz4x2sdDMrg3PbRK6O6edSMK7X4fWklqVXtDdM8riwj3C1GuSs1kx0LdAlT//Eor
	bWuSkiP+eaVkqgryQSWe6lTFzhiT6zcxiSb48g5a2o3AOWjohXwIvwDSxjCOLeBhgj0rYc
	n9XKsHvBvxp6nhVkTdEQcV0esMuw3gJKVWlJUzMzD7i2EQ1VKtn2Y5gr3xWEUZBjeBe10Z
	BKcwkG0HAbUoDhfKVkxh2Ta5dC63PTBYjC0UsQ8d0hP2nAr1e5mgtdUqvnRrfg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1686699578;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=k8gjwvZjutOT4dHhfWGxf+PGA1gm8Km0IyXoTok3KA4=;
	b=9oeXgEFxRyb4tlolxuBtEo2cOgt2q8mFUTkLY9QzVOjoN+gPO7c+6pTf6+CANvmFHTzX+s
	vdUXlgL1JBLstfAQ==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: x86@kernel.org,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Nikolay Borisov <nik.borisov@suse.com>,
 "Ahmed S. Darwish" <darwi@linutronix.de>,
 Arnd Bergmann <arnd@arndb.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Chris Zankel <chris@zankel.net>,
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
 Tom Lendacky <thomas.lendacky@amd.com>
Subject: [patch 11/17] init: Remove check_bugs() leftovers
References: <20230613223827.532680283@linutronix.de>
MIME-Version: 1.0
Date: Wed, 14 Jun 2023 01:39:38 +0200 (CEST)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230613_163940_143595_1EC8AAB3 
X-CRM114-Status: GOOD (  11.36  )
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

Everything is converted over to arch_cpu_finalize_init(). Remove the
check_bugs() leftovers including the empty stubs in asm-generic, alpha,
parisc, powerpc and xtensa.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Richard Henderson <richard.henderson@linaro.org>
Cc: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Chris Zankel <chris@zankel.net>
---
 arch/alpha/include/asm/bugs.h   |   20 --------------------
 arch/parisc/include/asm/bugs.h  |   20 --------------------
 arch/powerpc/include/asm/bugs.h |   15 ---------------
 arch/xtensa/include/asm/bugs.h  |   18 ------------------
 include/asm-generic/bugs.h      |   11 -----------
 init/main.c                     |    5 -----
 6 files changed, 89 deletions(-)

--- a/arch/alpha/include/asm/bugs.h
+++ /dev/null
@@ -1,20 +0,0 @@
-/*
- *  include/asm-alpha/bugs.h
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
-/*
- * I don't know of any alpha bugs yet.. Nice chip
- */
-
-static void check_bugs(void)
-{
-}
--- a/arch/parisc/include/asm/bugs.h
+++ /dev/null
@@ -1,20 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/*
- *  include/asm-parisc/bugs.h
- *
- *  Copyright (C) 1999	Mike Shaver
- */
-
-/*
- * This is included by init/main.c to check for architecture-dependent bugs.
- *
- * Needs:
- *	void check_bugs(void);
- */
-
-#include <asm/processor.h>
-
-static inline void check_bugs(void)
-{
-//	identify_cpu(&boot_cpu_data);
-}
--- a/arch/powerpc/include/asm/bugs.h
+++ /dev/null
@@ -1,15 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-or-later */
-#ifndef _ASM_POWERPC_BUGS_H
-#define _ASM_POWERPC_BUGS_H
-
-/*
- */
-
-/*
- * This file is included by 'init/main.c' to check for
- * architecture-dependent bugs.
- */
-
-static inline void check_bugs(void) { }
-
-#endif	/* _ASM_POWERPC_BUGS_H */
--- a/arch/xtensa/include/asm/bugs.h
+++ /dev/null
@@ -1,18 +0,0 @@
-/*
- * include/asm-xtensa/bugs.h
- *
- * This is included by init/main.c to check for architecture-dependent bugs.
- *
- * Xtensa processors don't have any bugs.  :)
- *
- * This file is subject to the terms and conditions of the GNU General
- * Public License.  See the file "COPYING" in the main directory of
- * this archive for more details.
- */
-
-#ifndef _XTENSA_BUGS_H
-#define _XTENSA_BUGS_H
-
-static void check_bugs(void) { }
-
-#endif /* _XTENSA_BUGS_H */
--- a/include/asm-generic/bugs.h
+++ /dev/null
@@ -1,11 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef __ASM_GENERIC_BUGS_H
-#define __ASM_GENERIC_BUGS_H
-/*
- * This file is included by 'init/main.c' to check for
- * architecture-dependent bugs.
- */
-
-static inline void check_bugs(void) { }
-
-#endif	/* __ASM_GENERIC_BUGS_H */
--- a/init/main.c
+++ b/init/main.c
@@ -103,7 +103,6 @@
 #include <net/net_namespace.h>
 
 #include <asm/io.h>
-#include <asm/bugs.h>
 #include <asm/setup.h>
 #include <asm/sections.h>
 #include <asm/cacheflush.h>
@@ -1079,10 +1078,6 @@ asmlinkage __visible void __init __no_sa
 	delayacct_init();
 
 	arch_cpu_finalize_init();
-	/* Temporary conditional until everything has been converted */
-#ifndef CONFIG_ARCH_HAS_CPU_FINALIZE_INIT
-	check_bugs();
-#endif
 
 	acpi_subsystem_init();
 	arch_post_acpi_subsys_init();


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
