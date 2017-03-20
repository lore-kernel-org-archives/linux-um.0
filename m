Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Kyle Huey <me@kylehuey.com>
Subject: [PATCH v16 07/10] x86/cpufeature: Detect CPUID faulting support
Date: Mon, 20 Mar 2017 01:16:25 -0700
Message-Id: <20170320081628.18952-8-khuey@kylehuey.com>
In-Reply-To: <20170320081628.18952-1-khuey@kylehuey.com>
References: <20170320081628.18952-1-khuey@kylehuey.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Robert O'Callahan <robert@ocallahan.org>, Thomas Gleixner <tglx@linutronix.de>, Andy Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Alexander Viro <viro@zeniv.linux.org.uk>, Shuah Khan <shuah@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, Borislav Petkov <bp@suse.de>, Peter Zijlstra <peterz@infradead.org>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Len Brown <len.brown@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Dmitry Safonov <dsafonov@virtuozzo.com>, David Matlack <dmatlack@google.com>, Nadav Amit <nadav.amit@gmail.com>, Andi Kleen <andi@firstfloor.org>, Grzegorz Andrejczuk <grzegorz.andrejczuk@intel.com>
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
Reviewed-by: Borislav Petkov <bp@suse.de>
---
 arch/x86/include/asm/cpufeatures.h |  1 +
 arch/x86/include/asm/msr-index.h   |  2 ++
 arch/x86/kernel/cpu/intel.c        | 24 +++++++++++++++++++++++-
 3 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index b04bb6dfed7f..0fe00446f9ca 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -187,6 +187,7 @@
  * Reuse free bits when adding new feature flags!
  */
 #define X86_FEATURE_RING3MWAIT	( 7*32+ 0) /* Ring 3 MONITOR/MWAIT */
+#define X86_FEATURE_CPUID_FAULT ( 7*32+ 1) /* Intel CPUID faulting */
 #define X86_FEATURE_CPB		( 7*32+ 2) /* AMD Core Performance Boost */
 #define X86_FEATURE_EPB		( 7*32+ 3) /* IA32_ENERGY_PERF_BIAS support */
 #define X86_FEATURE_CAT_L3	( 7*32+ 4) /* Cache Allocation Technology L3 */
diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index f429b70ebaef..b1f75daca34b 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -45,6 +45,8 @@
 #define MSR_IA32_PERFCTR1		0x000000c2
 #define MSR_FSB_FREQ			0x000000cd
 #define MSR_PLATFORM_INFO		0x000000ce
+#define MSR_PLATFORM_INFO_CPUID_FAULT_BIT	31
+#define MSR_PLATFORM_INFO_CPUID_FAULT		BIT_ULL(MSR_PLATFORM_INFO_CPUID_FAULT_BIT)
 
 #define MSR_PKG_CST_CONFIG_CONTROL	0x000000e2
 #define NHM_C3_AUTO_DEMOTE		(1UL << 25)
diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index e229318d7230..a07f8295c9ed 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -488,6 +488,28 @@ static void intel_bsp_resume(struct cpuinfo_x86 *c)
 	init_intel_energy_perf(c);
 }
 
+static void init_cpuid_fault(struct cpuinfo_x86 *c)
+{
+	u64 msr;
+
+	if (!rdmsrl_safe(MSR_PLATFORM_INFO, &msr)) {
+		if (msr & MSR_PLATFORM_INFO_CPUID_FAULT)
+			set_cpu_cap(c, X86_FEATURE_CPUID_FAULT);
+	}
+}
+
+static void init_intel_misc_features(struct cpuinfo_x86 *c)
+{
+	u64 msr;
+
+	if (rdmsrl_safe(MSR_MISC_FEATURES_ENABLES, &msr))
+		return;
+
+	/* Check features and update capabilities */
+	init_cpuid_fault(c);
+	probe_xeon_phi_r3mwait(c);
+}
+
 static void init_intel(struct cpuinfo_x86 *c)
 {
 	unsigned int l2 = 0;
@@ -602,7 +624,7 @@ static void init_intel(struct cpuinfo_x86 *c)
 
 	init_intel_energy_perf(c);
 
-	probe_xeon_phi_r3mwait(c);
+	init_intel_misc_features(c);
 }
 
 #ifdef CONFIG_X86_32
-- 
2.11.0


