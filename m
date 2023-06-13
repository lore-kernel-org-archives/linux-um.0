Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 993DAC001DD
	for <linux-um@archiver.kernel.org>; Tue, 13 Jun 2023 23:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Date:MIME-Version:References:Subject:Cc
	:To:From:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=vqvvtCDX2FDwWg32Au+BlPl2MEl3mRLD33JZJiyoDPk=; b=TedPoGlAplNWxV
	KD8+9MnXudwl1b1tzOS3h6nlu1uo7OKJrDY6yG+e+olhTF+tn7ymEzs/j1JvF2d1qYU10DZy5nQel
	lYTHX5iSJHzw3kvLA7J2B+TfTdHD7ndeK16YtHIUB4xYbhChdDnwyLDskyiWvCjQSafiWpLUMJsph
	fv3TxorK8Q3Ixp7TtKhygTLBAZBLwl+AAOk+Z54+MW4AShH3pPyPotDvJoJAIigI3zM6xF/V8fjKJ
	++wG4YKDyUmbaen8lVrz4GrSKRP4oc7FWwf3qAtv4EXjsCI29eOpmfDDloHOWmARUhzZLI2sYnS7Q
	5JJfmq2/K7EDg9ANzDfQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q9Dci-009S7g-39;
	Tue, 13 Jun 2023 23:40:28 +0000
Received: from galois.linutronix.de ([2a0a:51c0:0:12e:550::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q9Dc3-009RVs-0Z;
	Tue, 13 Jun 2023 23:39:57 +0000
Message-ID: <20230613224545.841685728@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1686699585;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=mdLair9MyWDVqPCo3VYZYQwXMBzE274L3lUc1PUjYzw=;
	b=tvknF4JQcwX0lM5O4DZTQuc30Yg9yiLzqRi4X2iQXF/rYttRwxZcIK6EcdK55DoYlMxRE5
	P0mkYs/iQ/cjRO8mk7MV5JkV9ZuQJgcw6JUtB19cZ9EwRnDimk9Xo7AZ4YRq3EGrHOt5Vb
	DNs4nYJlWr7TOx07NfCBW8Nrn51ARUbYjrw+8SDW/PGmeyNd2IDUAJhiC+0QYh3J9YfV+0
	/f5g54ndBGu+vtkKj+HwXcVCPNpr9uulVNkO8WM/YoNZsNhpzWGKWCdvrsa3VYL1p1Fo92
	IXzaQeVfRZJ2lNBrphRMdwLF4GZBfuZ5ZhQbSHtQVs0QBCTVHkh6rWWIAukLVg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1686699585;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=mdLair9MyWDVqPCo3VYZYQwXMBzE274L3lUc1PUjYzw=;
	b=weToH2Qa1SQqSJH8nQz8yPWHP67Y8ikgQP8AOS2+GL2sffNVONPBGYNLIgL4AGgEn4bpWa
	yxpMUxbA/N9sffBw==
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
Subject: [patch 16/17] x86/fpu: Mark init functions __init
References: <20230613223827.532680283@linutronix.de>
MIME-Version: 1.0
Date: Wed, 14 Jun 2023 01:39:45 +0200 (CEST)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230613_163947_359458_30E212F0 
X-CRM114-Status: UNSURE (   9.30  )
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

No point in keeping them around.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/kernel/fpu/init.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/arch/x86/kernel/fpu/init.c
+++ b/arch/x86/kernel/fpu/init.c
@@ -53,7 +53,7 @@ void fpu__init_cpu(void)
 	fpu__init_cpu_xstate();
 }
 
-static bool fpu__probe_without_cpuid(void)
+static bool __init fpu__probe_without_cpuid(void)
 {
 	unsigned long cr0;
 	u16 fsw, fcw;
@@ -71,7 +71,7 @@ static bool fpu__probe_without_cpuid(voi
 	return fsw == 0 && (fcw & 0x103f) == 0x003f;
 }
 
-static void fpu__init_system_early_generic(void)
+static void __init fpu__init_system_early_generic(void)
 {
 	if (!boot_cpu_has(X86_FEATURE_CPUID) &&
 	    !test_bit(X86_FEATURE_FPU, (unsigned long *)cpu_caps_cleared)) {


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
