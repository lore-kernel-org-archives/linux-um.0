Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F8D9606A914
	for <linux-um@archiver.kernel.org>; Thu,  5 Nov 2026 16:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=EJRizoYm;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kx5ZUZUv
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=WQLMY9Ei1cnXuIMWJwlXIP3m5euCfIhv8afPdvpr2S8=; b=EJRizoYmv6L5TU
	vsKCEx2Qp0Fcq27KatNayfcHTC8opVhuds4zVprBuNWaMU1+b8ZCDllioc7dGhq3BT0xBt8YZMDFb
	0KlBu9zVNuxcQD7N6UQt+wD48gI5QVmaXseE8IkxNWRUe7K2lLXStitRLRGhMJtCwAKBsBZWrDqu/
	/tm2B0cB1Yt2a9w6p3XBuUd2Q/iPVkt6iyUOd6bkfe+lkZne3cWI275ny6SB7HJTm+X6x0gUd34LZ
	NTudVmqdeA9OUpBdr/0+Y83GrQjFpVPEJiEL26OMMiK30hFsidrOpr94wr48E7/D24+yvXaXfm0li
	f/QAN+9jGG2GApwIdnMw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xP0R5-00000009eiK-1UUQ;
	Thu, 05 Nov 2026 16:35:35 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xP0Qq-00000009ecn-1vjm
	for linux-um@lists.infradead.org;
	Thu, 05 Nov 2026 16:35:24 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id E13D460A4A;
	Thu,  5 Nov 2026 16:35:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E4CA1F00919;
	Thu,  5 Nov 2026 16:35:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793896519;
	bh=WQLMY9Ei1cnXuIMWJwlXIP3m5euCfIhv8afPdvpr2S8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kx5ZUZUvkO3l1wWGrOAIXBDcLFwL7cCI8sn9VTDYHflEbI8YOrksv06+H5753tLMT
	 ekrlOYRV0Ap8Pdqbuo9OgJwND0MOG6TLMtjpSuV09RWyhUZyabTB1T0hQJJyCavVwN
	 Gk3ll1eFoLjOAJr9y4zqOWPXDVlurOObWVGkibhEgAWcsOVnRxGP3dyBfK3wqj4rku
	 TdOJ0+VEHvFnmJQvbU1y4/M5svdoPRaTuja9Zg6YDryDY0c4skMxO2LeyaK+GvY+ns
	 VlICKmRiCd2t3Upq0HNHgQCniVrYMq5TiW4SFAJREi5kp73/9doMM+jvalKRqXTf3l
	 wMMYahwi8Yo/Q==
From: Arnd Bergmann <arnd@kernel.org>
To: Ingo Molnar <mingo@redhat.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Thomas Gleixner <tglx@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Will Deacon <will@kernel.org>,
	Boqun Feng <boqun@kernel.org>,
	Gary Guo <gary@garyguo.net>,
	Yury Norov <yury.norov@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	Alexander Usyskin <alexander.usyskin@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	x86@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-um@lists.infradead.org
Subject: [PATCH 6/7] x86: remove dependencies on per-CPU options
Date: Thu,  5 Nov 2026 17:34:37 +0100
Message-ID: <20261105163440.2381661-7-arnd@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261105163440.2381661-1-arnd@kernel.org>
References: <20261105163440.2381661-1-arnd@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: linux-um@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-um.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Arnd Bergmann <arnd@arndb.de>

A few CPU feature options are defined in terms of CONFIG_Mxxx
CPU selection options.

This conflicts with the idea of CONFIG_X86_GENERIC allowing
one to build a kernel that works with multiple slightly
incompatible CPUs.

As a simplification, change all of these to be enabled in terms
of either 586-class or 686-class builds.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/x86/Kconfig.cpu            | 14 ++++----------
 arch/x86/Kconfig.cpufeatures    |  8 +-------
 arch/x86/include/asm/bitops.h   |  4 ++--
 arch/x86/include/asm/debugreg.h | 10 ++++------
 arch/x86/include/asm/ptrace.h   |  6 +-----
 5 files changed, 12 insertions(+), 30 deletions(-)

diff --git a/arch/x86/Kconfig.cpu b/arch/x86/Kconfig.cpu
index 382c9023c855..21026e0cb569 100644
--- a/arch/x86/Kconfig.cpu
+++ b/arch/x86/Kconfig.cpu
@@ -253,8 +253,7 @@ config X86_L1_CACHE_SHIFT
 	default "6"
 
 config X86_F00F_BUG
-	def_bool y
-	depends on M586MMX || M586TSC || M586
+	def_bool X86_MINIMUM_CPU_FAMILY=5 && CPU_SUP_INTEL
 
 config X86_ALIGNMENT_16
 	def_bool y
@@ -272,12 +271,6 @@ config X86_HAVE_PAE
 	def_bool y
 	depends on MCRUSOE || MEFFICEON || MCYRIXIII || MPENTIUM4 || MPENTIUMM || MPENTIUMIII || MPENTIUMII || M686 || MVIAC7 || MATOM || X86_64
 
-# this should be set for all -march=.. options where the compiler
-# generates cmov.
-config X86_CMOV
-	def_bool y
-	depends on (MK7 || MPENTIUM4 || MPENTIUMM || MPENTIUMIII || MPENTIUMII || M686 || MVIAC3_2 || MVIAC7 || MCRUSOE || MEFFICEON || MATOM || MGEODE_LX || X86_64)
-
 config X86_MINIMUM_CPU_FAMILY
 	int
 	default "64" if X86_64
@@ -286,7 +279,8 @@ config X86_MINIMUM_CPU_FAMILY
 
 config X86_DEBUGCTLMSR
 	def_bool y
-	depends on !(MK6 || MCYRIXIII || M586MMX || M586TSC || M586) && !UML
+	depends on !UML
+	depends on X86_MINIMUM_CPU_FAMILY=6
 
 config IA32_FEAT_CTL
 	def_bool y
@@ -318,7 +312,7 @@ config CPU_SUP_INTEL
 config CPU_SUP_CYRIX_32
 	default y
 	bool "Support Cyrix processors" if PROCESSOR_SELECT
-	depends on M586 || M586TSC || M586MMX || (EXPERT && !64BIT)
+	depends on X86_MINIMUM_CPU_FAMILY=5
 	help
 	  This enables detection, tunings and quirks for Cyrix processors
 
diff --git a/arch/x86/Kconfig.cpufeatures b/arch/x86/Kconfig.cpufeatures
index e0f2ff65377d..a0a1e838014d 100644
--- a/arch/x86/Kconfig.cpufeatures
+++ b/arch/x86/Kconfig.cpufeatures
@@ -44,13 +44,7 @@ config X86_REQUIRED_FEATURE_NOPL
 # generates cmov.
 config X86_REQUIRED_FEATURE_CMOV
 	def_bool y
-	depends on X86_CMOV
-
-# this should be set for all -march= options where the compiler
-# generates movbe.
-config X86_REQUIRED_FEATURE_MOVBE
-	def_bool y
-	depends on MATOM
+	depends on X86_MINIMUM_CPU_FAMILY >= 6
 
 config X86_REQUIRED_FEATURE_SYSFAST32
 	def_bool y
diff --git a/arch/x86/include/asm/bitops.h b/arch/x86/include/asm/bitops.h
index c2ce213f2b9b..f65872f67820 100644
--- a/arch/x86/include/asm/bitops.h
+++ b/arch/x86/include/asm/bitops.h
@@ -312,7 +312,7 @@ static __always_inline __attribute_const__ int variable_ffs(int x)
 	asm("bsfl %1,%0"
 	    : "=r" (r)
 	    : ASM_INPUT_RM (x), "0" (-1));
-#elif defined(CONFIG_X86_CMOV)
+#elif CONFIG_X86_MINIMUM_CPU_FAMILY >= 6
 	asm("bsfl %1,%0\n\t"
 	    "cmovzl %2,%0"
 	    : "=&r" (r) : "rm" (x), "r" (-1));
@@ -369,7 +369,7 @@ static __always_inline __attribute_const__ int fls(unsigned int x)
 	asm("bsrl %1,%0"
 	    : "=r" (r)
 	    : ASM_INPUT_RM (x), "0" (-1));
-#elif defined(CONFIG_X86_CMOV)
+#elif CONFIG_X86_MINIMUM_CPU_FAMILY >= 6
 	asm("bsrl %1,%0\n\t"
 	    "cmovzl %2,%0"
 	    : "=&r" (r) : "rm" (x), "rm" (-1));
diff --git a/arch/x86/include/asm/debugreg.h b/arch/x86/include/asm/debugreg.h
index 854d82b88ff4..90989e95cb8a 100644
--- a/arch/x86/include/asm/debugreg.h
+++ b/arch/x86/include/asm/debugreg.h
@@ -176,10 +176,9 @@ static inline unsigned long get_debugctlmsr(void)
 {
 	unsigned long debugctlmsr = 0;
 
-#ifndef CONFIG_X86_DEBUGCTLMSR
-	if (boot_cpu_data.x86 < 6)
+	if (CONFIG_X86_MINIMUM_CPU_FAMILY < 6 || boot_cpu_data.x86 < 6)
 		return 0;
-#endif
+
 	rdmsrq(MSR_IA32_DEBUGCTLMSR, debugctlmsr);
 
 	return debugctlmsr;
@@ -187,10 +186,9 @@ static inline unsigned long get_debugctlmsr(void)
 
 static inline void update_debugctlmsr(unsigned long debugctlmsr)
 {
-#ifndef CONFIG_X86_DEBUGCTLMSR
-	if (boot_cpu_data.x86 < 6)
+	if (CONFIG_X86_MINIMUM_CPU_FAMILY < 6 || boot_cpu_data.x86 < 6)
 		return;
-#endif
+
 	wrmsrq(MSR_IA32_DEBUGCTLMSR, debugctlmsr);
 }
 
diff --git a/arch/x86/include/asm/ptrace.h b/arch/x86/include/asm/ptrace.h
index 7bb7bd90355d..b1d881229fab 100644
--- a/arch/x86/include/asm/ptrace.h
+++ b/arch/x86/include/asm/ptrace.h
@@ -449,11 +449,7 @@ static inline unsigned long regs_get_kernel_argument(struct pt_regs *regs,
 }
 
 #define arch_has_single_step()	(1)
-#ifdef CONFIG_X86_DEBUGCTLMSR
-#define arch_has_block_step()	(1)
-#else
-#define arch_has_block_step()	(boot_cpu_data.x86 >= 6)
-#endif
+#define arch_has_block_step()	((CONFIG_X86_MINIMUM_CPU_FAMILY >= 6) || (boot_cpu_data.x86 >= 6))
 
 #define ARCH_HAS_USER_SINGLE_STEP_REPORT
 
-- 
2.53.0


