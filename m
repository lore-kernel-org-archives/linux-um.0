Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 267BFEB64D8
	for <linux-um@archiver.kernel.org>; Tue, 13 Jun 2023 23:39:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Date:MIME-Version:References:Subject:Cc
	:To:From:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=PpFk+usNm4ZOZz+ltkhQGjJBhcBGN+RWEcyBPexnf6s=; b=Ij/EZXiO/koQ6L
	d5ltiwzBvgI9rZMrDPr3ZrcWkBQxTY7ayq7LjPbH03oL44CTUjLEiJy9agntNQvloM3euwbLdlJCa
	SHJtcmNq9c+KK08Nb1XdtuCvfOVcIs4N5pc9aVndp+tUFsrpXTgnzv8Yuq/odW9KHqipLzBG9tjaF
	A5IdO5IOKK1lmB25Mg94pJMJuO+I4e3WVekRh1km1NLTv/tPOSrkuhXtNmd/xiQNjjwtm/93S0syU
	/VNBFARiHyPsQQgYkPTNNvENZYFvjzBBMSEvEHfftRk2ImNy81a3UoEd13laCoz3hKzSSgbApqsiq
	/ZEUsIuLYxFwHLCBK0Cg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q9Dbm-009RGA-1t;
	Tue, 13 Jun 2023 23:39:30 +0000
Received: from galois.linutronix.de ([193.142.43.55])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q9Dbh-009RCp-2Q;
	Tue, 13 Jun 2023 23:39:28 +0000
Message-ID: <20230613224544.957805717@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1686699563;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=77AqRKQdSjaQjDGx40OLahyRXrEjSKh/Zvl13xpUqBI=;
	b=fnjAlb4buqGgk+rgrSCls7XVVnssMKtlFn2wVkNKc0rXqkoKriukti4plpA4B3XFF4TzZK
	HkCGTHa0kgSQScvJzMGd5ndETRmA+U3bEX7DbZ4/2do4EQ0DxEh5OrT0lEol4VvMYfuRS9
	HynlSeJlhLILNeJrnp5YyETdHndPSJ7O/5rI4vnEKgJp3QTTCjnHyKycf9vdAFNWo8H2rb
	OTqiVuHCxtKC1JhOpK0UDZj/7iiiakYdsll7mDRVfp6DDuS0PUAl8a0YNpVsMMsx4052en
	gUZVODYB997wOJEzzkrsE7bLzpx5hqFiHqP0cAfvYOr6EwF5Zzytu+rPbxhCmA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1686699563;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=77AqRKQdSjaQjDGx40OLahyRXrEjSKh/Zvl13xpUqBI=;
	b=NcUHkxGs2yX0+eW1fJGry5eTvk3bMCTGxKXUguMEnkfcS6GFg9bNcY/6dOYm0SDEPQHUZn
	lMvSic4+i4tjOCAw==
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
Subject: [patch 01/17] init: Provide arch_cpu_finalize_init()
References: <20230613223827.532680283@linutronix.de>
MIME-Version: 1.0
Date: Wed, 14 Jun 2023 01:39:22 +0200 (CEST)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230613_163925_940155_69CE8043 
X-CRM114-Status: GOOD (  10.24  )
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

check_bugs() has become a dump ground for all sorts of activities to
finalize the CPU initialization before running the rest of the init code.

Most are empty, a few do actual bug checks, some do alternative patching
and some cobble a CPU advertisment string together....

Aside of that the current implementation requires duplicated function
declaration and mostly empty header files for them.

Provide a new function arch_cpu_finalize_init(). Provide a generic
declaration if CONFIG_ARCH_HAS_CPU_FINALIZE_INIT is selected and a stub
inline otherwise.

This requires a temporary #ifdef in start_kernel() which will be removed
along with check_bugs() once the architectures are converted over.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/Kconfig        |    3 +++
 include/linux/cpu.h |    6 ++++++
 init/main.c         |    4 ++++
 3 files changed, 13 insertions(+)
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -285,6 +285,9 @@ config ARCH_HAS_DMA_SET_UNCACHED
 config ARCH_HAS_DMA_CLEAR_UNCACHED
 	bool
 
+config ARCH_HAS_CPU_FINALIZE_INIT
+	bool
+
 # Select if arch init_task must go in the __init_task_data section
 config ARCH_TASK_STRUCT_ON_STACK
 	bool
--- a/include/linux/cpu.h
+++ b/include/linux/cpu.h
@@ -184,6 +184,12 @@ void arch_cpu_idle_enter(void);
 void arch_cpu_idle_exit(void);
 void __noreturn arch_cpu_idle_dead(void);
 
+#ifdef CONFIG_ARCH_HAS_CPU_FINALIZE_INIT
+void arch_cpu_finalize_init(void);
+#else
+static inline void arch_cpu_finalize_init(void) { }
+#endif
+
 int cpu_report_state(int cpu);
 int cpu_check_up_prepare(int cpu);
 void cpu_set_state_online(int cpu);
--- a/init/main.c
+++ b/init/main.c
@@ -1078,7 +1078,11 @@ asmlinkage __visible void __init __no_sa
 	taskstats_init_early();
 	delayacct_init();
 
+	arch_cpu_finalize_init();
+	/* Temporary conditional until everything has been converted */
+#ifndef CONFIG_ARCH_HAS_CPU_FINALIZE_INIT
 	check_bugs();
+#endif
 
 	acpi_subsystem_init();
 	arch_post_acpi_subsys_init();


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
