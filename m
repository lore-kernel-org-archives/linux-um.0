Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5C81EB64DA
	for <linux-um@archiver.kernel.org>; Tue, 13 Jun 2023 23:39:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Date:MIME-Version:References:Subject:Cc
	:To:From:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=5pVQQ3qo36h6+IS0SXAEZRr2VphKd13ZTgRPDL6x/Lw=; b=YLdwO5RAWHtvYW
	N2Kl8uOaK6YYj5qMWfGGXAhUxAn7iLuy+n7mBQKAoB4q76Rmt06dZX+XrcCuCz3NVhR6D4qXabV3C
	d+e+CiHhukHzT3t6gB0cfXeLX5bZFWKAQgeJUSixTKZeH5fS7wKUL+d2rAXcUjcFHDsYKpCrMZumH
	Gxm0q1utxuPVqSpi0nrBmCJCU3NQ22dm+J5AdJOGiKdWF51IZM6dXQ+oNSbLCpF6WHYLIki8bqag3
	0ncyAGWDXNiZ9UxNDzxeR2b3RjxkRA4f+BrYmJaXsGcMg6/e5EmHGjhCLBoI6kAM9r2y+NCz3RimD
	CJi3yfJwM0pMWrn7sAFw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q9Dc5-009RZ1-1M;
	Tue, 13 Jun 2023 23:39:49 +0000
Received: from galois.linutronix.de ([2a0a:51c0:0:12e:550::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q9Dbl-009RES-0f;
	Tue, 13 Jun 2023 23:39:37 +0000
Message-ID: <20230613224545.137045745@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1686699567;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=DDD4mAWSMPbjAODBEDFm/GZSLXiwbvYxlB2kHZQV314=;
	b=wVvSy71gluUCZPIXgEtKPo8BBg7ieMdvjy41cFsDvAMwvS7sWiK2ivysp2uh7x/mxyaE2v
	lRpXB1T+7Rb6IhJgtH5Gh08EjeY+LV6qZp8KxcG+Mhf6mq4TcOLzZ/urF31L2Jq6vP8rGD
	O3sKohDckVTh89UONt6PufDlgq59mtO9ozxMIcgcJeJuYnkf5IiWhWBIszpLhkgYnocc/h
	xrbrRFzNmT23GfQzPff5kIDwltofebDY8pYCgfGaONVaucUAY1o15zJaZaeGbebvk8LdrS
	hHhnyxcZsRDg7D6qogYEDL7tYICUsTP9fXm2+DUkN6m2IpENljiliuemCZcuKg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1686699567;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=DDD4mAWSMPbjAODBEDFm/GZSLXiwbvYxlB2kHZQV314=;
	b=xCdom/FmXQFqzqnDxobvpXnmHuFNJaBHO2lxQlF4vIc3u28hxBBnrlvC4Zi9IVE9w6CRK5
	Ws8bEUww9+yjUQBg==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: x86@kernel.org,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Nikolay Borisov <nik.borisov@suse.com>,
 "Ahmed S. Darwish" <darwi@linutronix.de>,
 Arnd Bergmann <arnd@arndb.de>,
 linux-ia64@vger.kernel.org,
 Russell King <linux@armlinux.org.uk>,
 linux-arm-kernel@lists.infradead.org,
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
Subject: [patch 04/17] ia64/cpu: Switch to arch_cpu_finalize_init()
References: <20230613223827.532680283@linutronix.de>
MIME-Version: 1.0
Date: Wed, 14 Jun 2023 01:39:27 +0200 (CEST)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230613_163929_386966_2A7CC9FF 
X-CRM114-Status: UNSURE (   9.45  )
X-CRM114-Notice: Please train this message.
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
Cc: linux-ia64@vger.kernel.org
---
 arch/ia64/Kconfig            |    1 +
 arch/ia64/include/asm/bugs.h |   20 --------------------
 arch/ia64/kernel/setup.c     |    3 +--
 3 files changed, 2 insertions(+), 22 deletions(-)

--- a/arch/ia64/Kconfig
+++ b/arch/ia64/Kconfig
@@ -9,6 +9,7 @@ menu "Processor type and features"
 config IA64
 	bool
 	select ARCH_BINFMT_ELF_EXTRA_PHDRS
+	select ARCH_HAS_CPU_FINALIZE_INIT
 	select ARCH_HAS_DMA_MARK_CLEAN
 	select ARCH_HAS_STRNCPY_FROM_USER
 	select ARCH_HAS_STRNLEN_USER
--- a/arch/ia64/include/asm/bugs.h
+++ /dev/null
@@ -1,20 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/*
- * This is included by init/main.c to check for architecture-dependent bugs.
- *
- * Needs:
- *	void check_bugs(void);
- *
- * Based on <asm-alpha/bugs.h>.
- *
- * Modified 1998, 1999, 2003
- *	David Mosberger-Tang <davidm@hpl.hp.com>,  Hewlett-Packard Co.
- */
-#ifndef _ASM_IA64_BUGS_H
-#define _ASM_IA64_BUGS_H
-
-#include <asm/processor.h>
-
-extern void check_bugs (void);
-
-#endif /* _ASM_IA64_BUGS_H */
--- a/arch/ia64/kernel/setup.c
+++ b/arch/ia64/kernel/setup.c
@@ -1067,8 +1067,7 @@ cpu_init (void)
 	}
 }
 
-void __init
-check_bugs (void)
+void __init arch_cpu_finalize_init(void)
 {
 	ia64_patch_mckinley_e9((unsigned long) __start___mckinley_e9_bundles,
 			       (unsigned long) __end___mckinley_e9_bundles);


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
