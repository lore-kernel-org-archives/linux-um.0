Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FCA5EB64DC
	for <linux-um@archiver.kernel.org>; Tue, 13 Jun 2023 23:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Date:MIME-Version:References:Subject:Cc
	:To:From:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=eMe5b9o70MPcO7F7yJkSo+ogNsYDLqDMUSQl01NQAGA=; b=NxSuJbbS/mOAiK
	OlnCXyngCCOdM3IAXyGuGaZqZ6R29Y/B77H0IFhIJpql/cVVuc1jm1hdg8LduURvaNrhML5WWqilI
	W5exeV6PT6YOy1ZUdsY+m8v7T7Kh/7h3+bum4sP4gZFScLH7sBaZ6G3hZxkDYiinWWj1dvkVc2SXO
	kJJXI4xXmFqCPMtmqtS9oyOCD5ptdi6WB8KhMKnul5wmqSTj7xsyKdZ2zrAVI5mvojHdwLQE1jFJM
	bBppEQzUQcSnburHjrUiphHgmh2W10G105YK5e8C9FWnz0xKqx+zs8r7Yu8vZuktCD8lWPJ25WE8v
	QJaMrmCxXDj1avHiTMow==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q9Dcf-009S3B-2N;
	Tue, 13 Jun 2023 23:40:25 +0000
Received: from galois.linutronix.de ([2a0a:51c0:0:12e:550::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q9Dc1-009RUX-2J;
	Tue, 13 Jun 2023 23:39:52 +0000
Message-ID: <20230613224545.783704297@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1686699584;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=Gb5sLOwcDGGXCtx9H68t6SKa9rJuuFgNMIgGpRA1Cww=;
	b=OnpchWKJJhpq6ONVVpZ9c6pjV8+YWD6D9ACsa/8z515oMg42/3uYESxEQtaaT0ZhA+Bg4D
	buKV/TS+gn3oROep32cD9pSlOuxkNN9gN1FI793/jM6gaP61aGgNBMspBhF24cVrqNkwmP
	6ZpLhrFqrdHTnl2F9db2HisP72PB5PFG31yDOZj7xCPFtzA0i/wVmqWvn4/B7KPU4C+g+A
	Hb0tBXmvL2dCVGkZKLYp8zxv+/uly8bkLAHYCsjdnPbgTYze9gOUtyNazJsma861n1vfxT
	FzX8CKJnzmPKSylUT3jSpbeQwCYY0b1DBlyPWRtKlKctXCqDI1gfU4iKjo3u0Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1686699584;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=Gb5sLOwcDGGXCtx9H68t6SKa9rJuuFgNMIgGpRA1Cww=;
	b=KeoNcLCZt1pscWtsZI+qPvC+QWWzBTddeaCrGnRrGuOteDQ3sqa2Z5VDUdEJeOoM1IwMZE
	+u5kYsrLmjkwanCA==
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
Subject: [patch 15/17] x86/fpu: Remove cpuinfo argument from init functions
References: <20230613223827.532680283@linutronix.de>
MIME-Version: 1.0
Date: Wed, 14 Jun 2023 01:39:43 +0200 (CEST)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230613_163945_929220_2B3459B6 
X-CRM114-Status: GOOD (  11.78  )
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

Nothing in the call chain requires it

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/include/asm/fpu/api.h |    2 +-
 arch/x86/kernel/cpu/common.c   |    2 +-
 arch/x86/kernel/fpu/init.c     |    6 +++---
 3 files changed, 5 insertions(+), 5 deletions(-)

--- a/arch/x86/include/asm/fpu/api.h
+++ b/arch/x86/include/asm/fpu/api.h
@@ -109,7 +109,7 @@ extern void fpu_reset_from_exception_fix
 
 /* Boot, hotplug and resume */
 extern void fpu__init_cpu(void);
-extern void fpu__init_system(struct cpuinfo_x86 *c);
+extern void fpu__init_system(void);
 extern void fpu__init_check_bugs(void);
 extern void fpu__resume_cpu(void);
 
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1604,7 +1604,7 @@ static void __init early_identify_cpu(st
 
 	sld_setup(c);
 
-	fpu__init_system(c);
+	fpu__init_system();
 
 #ifdef CONFIG_X86_32
 	/*
--- a/arch/x86/kernel/fpu/init.c
+++ b/arch/x86/kernel/fpu/init.c
@@ -71,7 +71,7 @@ static bool fpu__probe_without_cpuid(voi
 	return fsw == 0 && (fcw & 0x103f) == 0x003f;
 }
 
-static void fpu__init_system_early_generic(struct cpuinfo_x86 *c)
+static void fpu__init_system_early_generic(void)
 {
 	if (!boot_cpu_has(X86_FEATURE_CPUID) &&
 	    !test_bit(X86_FEATURE_FPU, (unsigned long *)cpu_caps_cleared)) {
@@ -211,10 +211,10 @@ static void __init fpu__init_system_xsta
  * Called on the boot CPU once per system bootup, to set up the initial
  * FPU state that is later cloned into all processes:
  */
-void __init fpu__init_system(struct cpuinfo_x86 *c)
+void __init fpu__init_system(void)
 {
 	fpstate_reset(&current->thread.fpu);
-	fpu__init_system_early_generic(c);
+	fpu__init_system_early_generic();
 
 	/*
 	 * The FPU has to be operational for some of the


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
