Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Kyle Huey <me@kylehuey.com>
Subject: [PATCH v16 10/10] KVM: x86: virtualize cpuid faulting
Date: Mon, 20 Mar 2017 01:16:28 -0700
Message-Id: <20170320081628.18952-11-khuey@kylehuey.com>
In-Reply-To: <20170320081628.18952-1-khuey@kylehuey.com>
References: <20170320081628.18952-1-khuey@kylehuey.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Robert O'Callahan <robert@ocallahan.org>, Thomas Gleixner <tglx@linutronix.de>, Andy Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Alexander Viro <viro@zeniv.linux.org.uk>, Shuah Khan <shuah@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, Borislav Petkov <bp@suse.de>, Peter Zijlstra <peterz@infradead.org>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Len Brown <len.brown@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Dmitry Safonov <dsafonov@virtuozzo.com>, David Matlack <dmatlack@google.com>, Nadav Amit <nadav.amit@gmail.com>, Andi Kleen <andi@firstfloor.org>, Grzegorz Andrejczuk <grzegorz.andrejczuk@intel.com>
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, user-mode-linux-user@lists.sourceforge.net, linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org, kvm@vger.kernel.org
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

Hardware support for faulting on the cpuid instruction is not required to
emulate it, because cpuid triggers a VM exit anyways. KVM handles the relevant
MSRs (MSR_PLATFORM_INFO and MSR_MISC_FEATURES_ENABLE) and upon a
cpuid-induced VM exit checks the cpuid faulting state and the CPL.
kvm_require_cpl is even kind enough to inject the GP fault for us.

Signed-off-by: Kyle Huey <khuey@kylehuey.com>
Reviewed-by: David Matlack <dmatlack@google.com>
---
 arch/x86/include/asm/kvm_host.h |  2 ++
 arch/x86/kvm/cpuid.c            |  3 +++
 arch/x86/kvm/cpuid.h            | 11 +++++++++++
 arch/x86/kvm/emulate.c          |  7 +++++++
 arch/x86/kvm/x86.c              | 26 ++++++++++++++++++++++++++
 5 files changed, 49 insertions(+)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 74ef58c8ff53..df0c2bd970a4 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -612,6 +612,8 @@ struct kvm_vcpu_arch {
 	unsigned long dr7;
 	unsigned long eff_db[KVM_NR_DB_REGS];
 	unsigned long guest_debug_dr7;
+	u64 msr_platform_info;
+	u64 msr_misc_features_enables;
 
 	u64 mcg_cap;
 	u64 mcg_status;
diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index efde6cc50875..cb560a509041 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -876,6 +876,9 @@ int kvm_emulate_cpuid(struct kvm_vcpu *vcpu)
 {
 	u32 eax, ebx, ecx, edx;
 
+	if (cpuid_fault_enabled(vcpu) && !kvm_require_cpl(vcpu, 0))
+		return;
+
 	eax = kvm_register_read(vcpu, VCPU_REGS_RAX);
 	ecx = kvm_register_read(vcpu, VCPU_REGS_RCX);
 	kvm_cpuid(vcpu, &eax, &ebx, &ecx, &edx);
diff --git a/arch/x86/kvm/cpuid.h b/arch/x86/kvm/cpuid.h
index 35058c2c0eea..a6fd40aade7c 100644
--- a/arch/x86/kvm/cpuid.h
+++ b/arch/x86/kvm/cpuid.h
@@ -205,4 +205,15 @@ static inline int guest_cpuid_stepping(struct kvm_vcpu *vcpu)
 	return x86_stepping(best->eax);
 }
 
+static inline bool supports_cpuid_fault(struct kvm_vcpu *vcpu)
+{
+	return vcpu->arch.msr_platform_info & MSR_PLATFORM_INFO_CPUID_FAULT;
+}
+
+static inline bool cpuid_fault_enabled(struct kvm_vcpu *vcpu)
+{
+	return vcpu->arch.msr_misc_features_enables &
+		  MSR_MISC_FEATURES_ENABLES_CPUID_FAULT;
+}
+
 #endif
diff --git a/arch/x86/kvm/emulate.c b/arch/x86/kvm/emulate.c
index 45c7306c8780..6a2ea945d01f 100644
--- a/arch/x86/kvm/emulate.c
+++ b/arch/x86/kvm/emulate.c
@@ -3854,6 +3854,13 @@ static int em_sti(struct x86_emulate_ctxt *ctxt)
 static int em_cpuid(struct x86_emulate_ctxt *ctxt)
 {
 	u32 eax, ebx, ecx, edx;
+	u64 msr = 0;
+
+	ctxt->ops->get_msr(ctxt, MSR_MISC_FEATURES_ENABLES, &msr);
+	if (msr & MSR_MISC_FEATURES_ENABLES_CPUID_FAULT &&
+	    ctxt->ops->cpl(ctxt)) {
+		return emulate_gp(ctxt, 0);
+	}
 
 	eax = reg_read(ctxt, VCPU_REGS_RAX);
 	ecx = reg_read(ctxt, VCPU_REGS_RCX);
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 1faf620a6fdc..16d2082d85fb 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -1008,6 +1008,8 @@ static u32 emulated_msrs[] = {
 	MSR_IA32_MCG_CTL,
 	MSR_IA32_MCG_EXT_CTL,
 	MSR_IA32_SMBASE,
+	MSR_PLATFORM_INFO,
+	MSR_MISC_FEATURES_ENABLES,
 };
 
 static unsigned num_emulated_msrs;
@@ -2331,6 +2333,21 @@ int kvm_set_msr_common(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 			return 1;
 		vcpu->arch.osvw.status = data;
 		break;
+	case MSR_PLATFORM_INFO:
+		if (!msr_info->host_initiated ||
+		    data & ~MSR_PLATFORM_INFO_CPUID_FAULT ||
+		    (!(data & MSR_PLATFORM_INFO_CPUID_FAULT) &&
+		     cpuid_fault_enabled(vcpu)))
+			return 1;
+		vcpu->arch.msr_platform_info = data;
+		break;
+	case MSR_MISC_FEATURES_ENABLES:
+		if (data & ~MSR_MISC_FEATURES_ENABLES_CPUID_FAULT ||
+		    (data & MSR_MISC_FEATURES_ENABLES_CPUID_FAULT &&
+		     !supports_cpuid_fault(vcpu)))
+			return 1;
+		vcpu->arch.msr_misc_features_enables = data;
+		break;
 	default:
 		if (msr && (msr == vcpu->kvm->arch.xen_hvm_config.msr))
 			return xen_hvm_config(vcpu, data);
@@ -2545,6 +2562,12 @@ int kvm_get_msr_common(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 			return 1;
 		msr_info->data = vcpu->arch.osvw.status;
 		break;
+	case MSR_PLATFORM_INFO:
+		msr_info->data = vcpu->arch.msr_platform_info;
+		break;
+	case MSR_MISC_FEATURES_ENABLES:
+		msr_info->data = vcpu->arch.msr_misc_features_enables;
+		break;
 	default:
 		if (kvm_pmu_is_valid_msr(vcpu, msr_info->index))
 			return kvm_pmu_get_msr(vcpu, msr_info->index, &msr_info->data);
@@ -7724,6 +7747,9 @@ void kvm_vcpu_reset(struct kvm_vcpu *vcpu, bool init_event)
 	if (!init_event) {
 		kvm_pmu_reset(vcpu);
 		vcpu->arch.smbase = 0x30000;
+
+		vcpu->arch.msr_platform_info = MSR_PLATFORM_INFO_CPUID_FAULT;
+		vcpu->arch.msr_misc_features_enables = 0;
 	}
 
 	memset(vcpu->arch.regs, 0, sizeof(vcpu->arch.regs));
-- 
2.11.0


