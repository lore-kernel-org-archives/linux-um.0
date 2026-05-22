Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1335CD5BB4
	for <linux-um@archiver.kernel.org>; Fri, 22 May 2026 14:20:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YLeNHXfk5ri37V6bCivr64eEC8uPp0jglG/OApryq3Y=; b=KjEtLf1hCUsCuEzFrQsu8YpoHz
	o/05tOEBJSZcSKcz9z6Bwg6f8E2tbn+SS3CmryucczpY8o/nyH2ABxzQfYWStxxgdFdJRCtzLvbb7
	sw94riCoPjNf6eaJvsXRrAfaGnpDjW3H8UAtGYg7OX+GK9MosULdkbQ10DrnIPkT5GAgI6qDitdTU
	prUdJkKTauzRWAKSDRqq5LUREKL6IkMqcF9dkGok6neqoiO5kYUPoc6DF/UJKZeZ2l1+RVPZ3o8/y
	SsG60yoIA3jSyF7QXNRGr/kZNo5P6TzpqD2MvzCqoryHpWZX/2kHuB4IvFZybX5gVtNDmLJIiixEf
	MOlTKfFA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wQQkE-0000000B7AX-2eUo;
	Fri, 22 May 2026 14:20:58 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wQQkD-0000000B79f-38zG
	for linux-um@lists.infradead.org;
	Fri, 22 May 2026 14:20:57 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 3222660138;
	Fri, 22 May 2026 14:20:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99B091F00A3E;
	Fri, 22 May 2026 14:20:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779459656;
	bh=YLeNHXfk5ri37V6bCivr64eEC8uPp0jglG/OApryq3Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=c6o2aRHkwI7WVIfoVomiuiFHkB3hrzBNyVOpEcXKPmVTSDYbGyDqI53D3L/hjdgrU
	 CNzd9VdnD6PHcFL973GMbWd9rBJ0yJjiIMfx6s6TPAPfbtHearZW/QHkLuBIJTYMc3
	 oMSHN8kSzBc4YoVsdxtbXR2+PN47g+Ttu25Mawyi+8bGcvurLCB//+rvRDrZz/6jjj
	 T1gaiUNXbBJtmyhTPDCemAUdNANRjBMjiei5dsnNXOMhHqt90qmuASTg22UgvftA82
	 8LUf1ZmeObBE7BjDHUe/dPyeg1pEqe7b5w8oCFkWbWmcsbyvllHq7Qj4TgZdxlWVXs
	 9Dp34M6v9XU5w==
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
Subject: [PATCH 7/8] x86: remove dependencies on per-CPU options
Date: Fri, 22 May 2026 16:19:58 +0200
Message-Id: <20260522141959.1071595-8-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260522141959.1071595-1-arnd@kernel.org>
References: <20260522141959.1071595-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

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
index 4991b633047e..979db473a41d 100644
--- a/arch/x86/Kconfig.cpu
+++ b/arch/x86/Kconfig.cpu
@@ -242,8 +242,7 @@ config X86_L1_CACHE_SHIFT
 	default "6"
 
 config X86_F00F_BUG
-	def_bool y
-	depends on M586MMX || M586TSC || M586
+	def_bool X86_MINIMUM_CPU_FAMILY=5 && CPU_SUP_INTEL
 
 config X86_ALIGNMENT_16
 	def_bool y
@@ -264,12 +263,6 @@ config X86_HAVE_PAE
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
@@ -278,7 +271,8 @@ config X86_MINIMUM_CPU_FAMILY
 
 config X86_DEBUGCTLMSR
 	def_bool y
-	depends on !(MK6 || MCYRIXIII || M586MMX || M586TSC || M586) && !UML
+	depends on !UML
+	depends on X86_MINIMUM_CPU_FAMILY=6
 
 config IA32_FEAT_CTL
 	def_bool y
@@ -314,7 +308,7 @@ config CPU_SUP_INTEL
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
index a2c1f2d24b64..3799b2bb27bc 100644
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
2.39.5


