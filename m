Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Kyle Huey <me@kylehuey.com>
Subject: [PATCH v8 5/7] x86/cpufeature: Detect CPUID faulting support
Date: Mon, 31 Oct 2016 18:37:47 -0700
Message-Id: <20161101013749.4003-6-khuey@kylehuey.com>
In-Reply-To: <20161101013749.4003-1-khuey@kylehuey.com>
References: <20161101013749.4003-1-khuey@kylehuey.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Robert O'Callahan <robert@ocallahan.org>, Thomas Gleixner <tglx@linutronix.de>, Andy Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Alexander Viro <viro@zeniv.linux.org.uk>, Shuah Khan <shuah@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, Borislav Petkov <bp@suse.de>, Peter Zijlstra <peterz@infradead.org>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Len Brown <len.brown@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Dmitry Safonov <dsafonov@virtuozzo.com>
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, user-mode-linux-user@lists.sourceforge.net, linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org, kvm@vger.kernel.org
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

Intel supports faulting on the CPUID instruction beginning with Ivy Bridge.
When enabled, the processor will fault on attempts to execute the CPUID
instruction with CPL>0. This will allow a ptracer to emulate the CPUID
instruction.

Bit 31 of MSR_PLATFORM_INFO advertises support for this feature. It is
documented in detail in Section 2.3.2 of
http://www.intel.com/content/dam/www/public/us/en/documents/application-notes/virtualization-technology-flexmigration-application-note.pdf

Detect support for this feature and expose it as X86_FEATURE_CPUID_FAULT.

Signed-off-by: Kyle Huey <khuey@kylehuey.com>
Reviewed-by: Andy Lutomirski <luto@kernel.org>
---
 arch/x86/include/asm/cpufeatures.h |  1 +
 arch/x86/include/asm/msr-index.h   |  2 ++
 arch/x86/kernel/cpu/scattered.c    | 22 +++++++++++++++++++++-
 3 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index a396292..62962e8 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -184,16 +184,17 @@
  * Auxiliary flags: Linux defined - For features scattered in various
  * CPUID levels like 0x6, 0xA etc, word 7.
  *
  * Reuse free bits when adding new feature flags!
  */
 
 #define X86_FEATURE_CPB		( 7*32+ 2) /* AMD Core Performance Boost */
 #define X86_FEATURE_EPB		( 7*32+ 3) /* IA32_ENERGY_PERF_BIAS support */
+#define X86_FEATURE_CPUID_FAULT ( 7*32+ 4) /* Intel CPUID faulting */
 
 #define X86_FEATURE_HW_PSTATE	( 7*32+ 8) /* AMD HW-PState */
 #define X86_FEATURE_PROC_FEEDBACK ( 7*32+ 9) /* AMD ProcFeedbackInterface */
 
 #define X86_FEATURE_INTEL_PT	( 7*32+15) /* Intel Processor Trace */
 #define X86_FEATURE_AVX512_4VNNIW (7*32+16) /* AVX-512 Neural Network Instructions */
 #define X86_FEATURE_AVX512_4FMAPS (7*32+17) /* AVX-512 Multiply Accumulation Single precision */
 
diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index 78f3760..97fb50b 100644
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
+#define PLATINFO_CPUID_FAULT_BIT	31
+#define PLATINFO_CPUID_FAULT		(1ULL << PLATINFO_CPUID_FAULT_BIT)
 
 #define MSR_NHM_SNB_PKG_CST_CFG_CTL	0x000000e2
 #define NHM_C3_AUTO_DEMOTE		(1UL << 25)
 #define NHM_C1_AUTO_DEMOTE		(1UL << 26)
 #define ATM_LNC_C6_AUTO_DEMOTE		(1UL << 25)
 #define SNB_C1_AUTO_UNDEMOTE		(1UL << 27)
 #define SNB_C3_AUTO_UNDEMOTE		(1UL << 28)
 
diff --git a/arch/x86/kernel/cpu/scattered.c b/arch/x86/kernel/cpu/scattered.c
index 1db8dc4..97a340d 100644
--- a/arch/x86/kernel/cpu/scattered.c
+++ b/arch/x86/kernel/cpu/scattered.c
@@ -19,41 +19,61 @@ struct cpuid_bit {
 
 enum cpuid_regs {
 	CR_EAX = 0,
 	CR_ECX,
 	CR_EDX,
 	CR_EBX
 };
 
+struct msr_bit {
+	u16 feature;
+	u16 msr;
+	u8 bit;
+};
+
 void init_scattered_cpuid_features(struct cpuinfo_x86 *c)
 {
+	const struct cpuid_bit *cb;
+	const struct msr_bit *mb;
 	u32 max_level;
 	u32 regs[4];
-	const struct cpuid_bit *cb;
+	u64 msrval;
 
 	static const struct cpuid_bit cpuid_bits[] = {
 		{ X86_FEATURE_INTEL_PT,		CR_EBX,25, 0x00000007, 0 },
 		{ X86_FEATURE_AVX512_4VNNIW,	CR_EDX, 2, 0x00000007, 0 },
 		{ X86_FEATURE_AVX512_4FMAPS,	CR_EDX, 3, 0x00000007, 0 },
 		{ X86_FEATURE_APERFMPERF,	CR_ECX, 0, 0x00000006, 0 },
 		{ X86_FEATURE_EPB,		CR_ECX, 3, 0x00000006, 0 },
 		{ X86_FEATURE_HW_PSTATE,	CR_EDX, 7, 0x80000007, 0 },
 		{ X86_FEATURE_CPB,		CR_EDX, 9, 0x80000007, 0 },
 		{ X86_FEATURE_PROC_FEEDBACK,	CR_EDX,11, 0x80000007, 0 },
 		{ 0, 0, 0, 0, 0 }
 	};
 
+	static const struct msr_bit msr_bits[] = {
+		{ X86_FEATURE_CPUID_FAULT,	MSR_PLATFORM_INFO, 31 },
+		{ 0, 0, 0 }
+	};
+
 	for (cb = cpuid_bits; cb->feature; cb++) {
 
 		/* Verify that the level is valid */
 		max_level = cpuid_eax(cb->level & 0xffff0000);
 		if (max_level < cb->level ||
 		    max_level > (cb->level | 0xffff))
 			continue;
 
 		cpuid_count(cb->level, cb->sub_leaf, &regs[CR_EAX],
 			    &regs[CR_EBX], &regs[CR_ECX], &regs[CR_EDX]);
 
 		if (regs[cb->reg] & (1 << cb->bit))
 			set_cpu_cap(c, cb->feature);
 	}
+
+	for (mb = msr_bits; mb->feature; mb++) {
+		if (rdmsrl_safe(mb->msr, &msrval))
+			continue;
+		if (msrval & (1ULL << mb->bit))
+			set_cpu_cap(c, mb->feature);
+	}
 }
-- 
2.10.2


