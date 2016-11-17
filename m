Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Kyle Huey <me@kylehuey.com>
Subject: [PATCH v12 5/7] x86/cpufeature: Detect CPUID faulting support
Date: Wed, 16 Nov 2016 18:06:08 -0800
Message-Id: <20161117020610.5302-6-khuey@kylehuey.com>
In-Reply-To: <20161117020610.5302-1-khuey@kylehuey.com>
References: <20161117020610.5302-1-khuey@kylehuey.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Robert O'Callahan <robert@ocallahan.org>, Thomas Gleixner <tglx@linutronix.de>, Andy Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Alexander Viro <viro@zeniv.linux.org.uk>, Shuah Khan <shuah@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, Borislav Petkov <bp@suse.de>, Peter Zijlstra <peterz@infradead.org>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Len Brown <len.brown@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Dmitry Safonov <dsafonov@virtuozzo.com>, David Matlack <dmatlack@google.com>, Nadav Amit <nadav.amit@gmail.com>
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, user-mode-linux-user@lists.sourceforge.net, linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org, kvm@vger.kernel.org
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

Intel supports faulting on the CPUID instruction beginning with Ivy Bridge.
When enabled, the processor will fault on attempts to execute the CPUID
instruction with CPL>0. This will allow a ptracer to emulate the CPUID
instruction.

Bit 31 of MSR_PLATFORM_INFO advertises support for this feature. It is
documented in detail in Section 2.3.2 of
https://bugzilla.kernel.org/attachment.cgi?id=243991

Detect support for this feature and expose it as X86_FEATURE_CPUID_FAULT.

Signed-off-by: Kyle Huey <khuey@kylehuey.com>
---
 arch/x86/include/asm/cpufeatures.h |  1 +
 arch/x86/include/asm/msr-index.h   |  2 ++
 arch/x86/kernel/cpu/intel.c        | 12 ++++++++++++
 3 files changed, 15 insertions(+)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index a396292..85f853f 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -182,16 +182,17 @@
 
 /*
  * Auxiliary flags: Linux defined - For features scattered in various
  * CPUID levels like 0x6, 0xA etc, word 7.
  *
  * Reuse free bits when adding new feature flags!
  */
 
+#define X86_FEATURE_CPUID_FAULT ( 7*32+ 0) /* Intel CPUID faulting */
 #define X86_FEATURE_CPB		( 7*32+ 2) /* AMD Core Performance Boost */
 #define X86_FEATURE_EPB		( 7*32+ 3) /* IA32_ENERGY_PERF_BIAS support */
 
 #define X86_FEATURE_HW_PSTATE	( 7*32+ 8) /* AMD HW-PState */
 #define X86_FEATURE_PROC_FEEDBACK ( 7*32+ 9) /* AMD ProcFeedbackInterface */
 
 #define X86_FEATURE_INTEL_PT	( 7*32+15) /* Intel Processor Trace */
 #define X86_FEATURE_AVX512_4VNNIW (7*32+16) /* AVX-512 Neural Network Instructions */
diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index 78f3760..3ac0acf 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -36,16 +36,18 @@
 #define EFER_LMSLE		(1<<_EFER_LMSLE)
 #define EFER_FFXSR		(1<<_EFER_FFXSR)
 
 /* Intel MSRs. Some also available on other CPUs */
 #define MSR_IA32_PERFCTR0		0x000000c1
 #define MSR_IA32_PERFCTR1		0x000000c2
 #define MSR_FSB_FREQ			0x000000cd
 #define MSR_PLATFORM_INFO		0x000000ce
+#define MSR_PLATFORM_INFO_CPUID_FAULT_BIT	31
+#define MSR_PLATFORM_INFO_CPUID_FAULT		BIT_ULL(MSR_PLATFORM_INFO_CPUID_FAULT_BIT)
 
 #define MSR_NHM_SNB_PKG_CST_CFG_CTL	0x000000e2
 #define NHM_C3_AUTO_DEMOTE		(1UL << 25)
 #define NHM_C1_AUTO_DEMOTE		(1UL << 26)
 #define ATM_LNC_C6_AUTO_DEMOTE		(1UL << 25)
 #define SNB_C1_AUTO_UNDEMOTE		(1UL << 27)
 #define SNB_C3_AUTO_UNDEMOTE		(1UL << 28)
 
diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index fcd484d..19b56b5 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -447,16 +447,26 @@ static void intel_bsp_resume(struct cpuinfo_x86 *c)
 {
 	/*
 	 * MSR_IA32_ENERGY_PERF_BIAS is lost across suspend/resume,
 	 * so reinitialize it properly like during bootup:
 	 */
 	init_intel_energy_perf(c);
 }
 
+static void init_intel_misc_features_enables(struct cpuinfo_x86 *c)
+{
+	u64 msr;
+
+	if (!rdmsrl_safe(MSR_PLATFORM_INFO, &msr)) {
+		if (msr & MSR_PLATFORM_INFO_CPUID_FAULT)
+			set_cpu_cap(c, X86_FEATURE_CPUID_FAULT);
+	}
+}
+
 static void init_intel(struct cpuinfo_x86 *c)
 {
 	unsigned int l2 = 0;
 
 	early_init_intel(c);
 
 	intel_workarounds(c);
 
@@ -560,16 +570,18 @@ static void init_intel(struct cpuinfo_x86 *c)
 
 	/* Work around errata */
 	srat_detect_node(c);
 
 	if (cpu_has(c, X86_FEATURE_VMX))
 		detect_vmx_virtcap(c);
 
 	init_intel_energy_perf(c);
+
+	init_intel_misc_features_enables(c);
 }
 
 #ifdef CONFIG_X86_32
 static unsigned int intel_size_cache(struct cpuinfo_x86 *c, unsigned int size)
 {
 	/*
 	 * Intel PIII Tualatin. This comes in two flavours.
 	 * One has 256kb of cache, the other 512. We have no way
-- 
2.10.2


