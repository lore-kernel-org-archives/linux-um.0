Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94CC3EB64DB
	for <linux-um@archiver.kernel.org>; Tue, 13 Jun 2023 23:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Date:MIME-Version:References:Subject:Cc
	:To:From:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=ILkYzcvKZwR3cXXXLxmLWCzsBPSrsBM1rLxEB0xdbzE=; b=pVbUCRPvBRxepe
	DXYj0GVRBSXhyqTJGV9pqx/AhTeXkwm9rXF23tUa0bRs1dcLs6mYHRuTZEmTNTttNPizUZo5gB+EB
	f4DZWofghvhWOMWpfg+r50wK4PG42FDOc3vcSBxK8xH+zzjUyXCgzALWa2jYkY5QzVYpM0xM34MMy
	LKhorapYIv89ENLxkM0iEsgWNPScNcx2sdJuT09EFjCkNUqrA6/7FUktArWfiZs2of02YYCYqxZ4l
	VwnkKOcafVJryU7BVf++kuC2FbtYCx/RN8qRPeFdHeWoAhDmBEruOO48rAhuMnMf1+wdDyQac6HI7
	O+GHcK43cIKvZvfC/epw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q9Dcf-009S2m-0e;
	Tue, 13 Jun 2023 23:40:25 +0000
Received: from galois.linutronix.de ([193.142.43.55])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q9Dbx-009RQb-0w;
	Tue, 13 Jun 2023 23:39:52 +0000
Message-ID: <20230613224545.612182854@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1686699580;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=0VnFCDlFg0Z65xUPcTSUW8cd097ZM3tj8m6sSpK3s64=;
	b=2vIwQPIUp/HJUmCG4BQezI45Q367xKHJYYqLK7G4wdrDSn+cOBFzLkdHYUwzUXc6gDifT9
	rXY1lpsCnLehM7zAXb6roxx5XLRXYnCJR+grAmVc2dHif25zyPdBFAdRB8oZi5F8oDEYjX
	LfRMBrXHCi+WgVWwvhW/rD4N9Ur83iWtMYD/8dwxcO3p39WY5cZNs0IUmsHtiYOfpH2mPn
	zfJVRybOawF0SSzGOD7ZbR8K3/Wde2+WMR35K0mYj4U05gliICM7VVvC+XUr8nRG+osE42
	Jt6Rw45sBhht2PYfVT0AcDzOMXI7pmmP+pQ2CC66euAz7R6Cd8BF8y04Prxn9g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1686699580;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=0VnFCDlFg0Z65xUPcTSUW8cd097ZM3tj8m6sSpK3s64=;
	b=Xu1aR4gK/TE/PO7y3dM5tqNyYP8UwrzsrU8JCSaOdKEVqSuAOvhIQ2kubFuP8M//eeln2X
	Z4Xwxgc0BSAFJ1Bg==
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
Subject: [patch 12/17] init: Invoke arch_cpu_finalize_init() earlier
References: <20230613223827.532680283@linutronix.de>
MIME-Version: 1.0
Date: Wed, 14 Jun 2023 01:39:39 +0200 (CEST)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230613_163941_486715_E65B8498 
X-CRM114-Status: GOOD (  11.57  )
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

X86 is reworking the boot process so that initializations which are not
required during early boot can be moved into the late boot process and out
of the fragile and restricted initial boot phase.

arch_cpu_finalize_init() is the obvious place to do such initializations,
but arch_cpu_finalize_init() is invoked too late in start_kernel() e.g. for
initializing the FPU completely. fork_init() requires that the FPU is
initialized as the size of task_struct on X86 depends on the size of the
required FPU register buffer.

Fortunately none of the init calls between calibrate_delay() and
arch_cpu_finalize_init() is relevant for the functionality of
arch_cpu_finalize_init().

Invoke it right after calibrate_delay() where everything which is relevant
for arch_cpu_finalize_init() has been set up already.

No functional change intended.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 init/main.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/init/main.c
+++ b/init/main.c
@@ -1041,6 +1041,8 @@ asmlinkage __visible void __init __no_sa
 	sched_clock_init();
 	calibrate_delay();
 
+	arch_cpu_finalize_init();
+
 	/*
 	 * This needs to be called before any devices perform DMA
 	 * operations that might use the SWIOTLB bounce buffers. It will
@@ -1077,8 +1079,6 @@ asmlinkage __visible void __init __no_sa
 	taskstats_init_early();
 	delayacct_init();
 
-	arch_cpu_finalize_init();
-
 	acpi_subsystem_init();
 	arch_post_acpi_subsys_init();
 	kcsan_init();


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
