Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Kyle Huey <me@kylehuey.com>
Subject: [PATCH v15 8/9] KVM: x86: virtualize cpuid faulting
Date: Sat, 11 Mar 2017 11:47:01 -0800
Message-Id: <20170311194702.28754-9-khuey@kylehuey.com>
In-Reply-To: <20170311194702.28754-1-khuey@kylehuey.com>
References: <20170311194702.28754-1-khuey@kylehuey.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Robert O'Callahan <robert@ocallahan.org>, Thomas Gleixner <tglx@linutronix.de>, Andy Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Alexander Viro <viro@zeniv.linux.org.uk>, Shuah Khan <shuah@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, Borislav Petkov <bp@suse.de>, Peter Zijlstra <peterz@infradead.org>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Len Brown <len.brown@intel.com>, Dmitry Safonov <dsafonov@virtuozzo.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, David Matlack <dmatlack@google.com>, Nadav Amit <nadav.amit@gmail.com>, Andi Kleen <andi@firstfloor.org>
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, user-mode-linux-user@lists.sourceforge.net, linux-kselftest@vger.kernel.org, kvm@vger.kernel.org
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
@@ -607,16 +607,18 @@ struct kvm_vcpu_arch {
 	u64 pat;
 
 	unsigned switch_db_regs;
 	unsigned long db[KVM_NR_DB_REGS];
 	unsigned long dr6;
 	unsigned long dr7;
 	unsigned long eff_db[KVM_NR_DB_REGS];
 	unsigned long guest_debug_dr7;
+	u64 msr_platform_info;
+	u64 msr_misc_features_enables;
 
 	u64 mcg_cap;
 	u64 mcg_status;
 	u64 mcg_ctl;
 	u64 mcg_ext_ctl;
 	u64 *mce_banks;
 
 	/* Cache MMIO info */
diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index efde6cc50875..cb560a509041 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -871,16 +871,19 @@ void kvm_cpuid(struct kvm_vcpu *vcpu, u32 *eax, u32 *ebx, u32 *ecx, u32 *edx)
 	trace_kvm_cpuid(function, *eax, *ebx, *ecx, *edx);
 }
 EXPORT_SYMBOL_GPL(kvm_cpuid);
 
 int kvm_emulate_cpuid(struct kvm_vcpu *vcpu)
 {
 	u32 eax, ebx, ecx, edx;
 
+	if (cpuid_fault_enabled(vcpu) && !kvm_require_cpl(vcpu, 0))
+		return;
+
 	eax = kvm_register_read(vcpu, VCPU_REGS_RAX);
 	ecx = kvm_register_read(vcpu, VCPU_REGS_RCX);
 	kvm_cpuid(vcpu, &eax, &ebx, &ecx, &edx);
 	kvm_register_write(vcpu, VCPU_REGS_RAX, eax);
 	kvm_register_write(vcpu, VCPU_REGS_RBX, ebx);
 	kvm_register_write(vcpu, VCPU_REGS_RCX, ecx);
 	kvm_register_write(vcpu, VCPU_REGS_RDX, edx);
 	return kvm_skip_emulated_instruction(vcpu);
diff --git a/arch/x86/kvm/cpuid.h b/arch/x86/kvm/cpuid.h
index 35058c2c0eea..a6fd40aade7c 100644
--- a/arch/x86/kvm/cpuid.h
+++ b/arch/x86/kvm/cpuid.h
@@ -200,9 +200,20 @@ static inline int guest_cpuid_stepping(struct kvm_vcpu *vcpu)
 
 	best = kvm_find_cpuid_entry(vcpu, 0x1, 0);
 	if (!best)
 		return -1;
 
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
@@ -3849,16 +3849,23 @@ static int em_sti(struct x86_emulate_ctxt *ctxt)
 	ctxt->interruptibility = KVM_X86_SHADOW_INT_STI;
 	ctxt->eflags |= X86_EFLAGS_IF;
 	return X86EMUL_CONTINUE;
 }
 
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
 	ctxt->ops->get_cpuid(ctxt, &eax, &ebx, &ecx, &edx);
 	*reg_write(ctxt, VCPU_REGS_RAX) = eax;
 	*reg_write(ctxt, VCPU_REGS_RBX) = ebx;
 	*reg_write(ctxt, VCPU_REGS_RCX) = ecx;
 	*reg_write(ctxt, VCPU_REGS_RDX) = edx;
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 1faf620a6fdc..16d2082d85fb 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -1003,16 +1003,18 @@ static u32 emulated_msrs[] = {
 
 	MSR_IA32_TSC_ADJUST,
 	MSR_IA32_TSCDEADLINE,
 	MSR_IA32_MISC_ENABLE,
 	MSR_IA32_MCG_STATUS,
 	MSR_IA32_MCG_CTL,
 	MSR_IA32_MCG_EXT_CTL,
 	MSR_IA32_SMBASE,
+	MSR_PLATFORM_INFO,
+	MSR_MISC_FEATURES_ENABLES,
 };
 
 static unsigned num_emulated_msrs;
 
 bool kvm_valid_efer(struct kvm_vcpu *vcpu, u64 efer)
 {
 	if (efer & efer_reserved_bits)
 		return false;
@@ -2326,16 +2328,31 @@ int kvm_set_msr_common(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 			return 1;
 		vcpu->arch.osvw.length = data;
 		break;
 	case MSR_AMD64_OSVW_STATUS:
 		if (!guest_cpuid_has_osvw(vcpu))
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
 		if (kvm_pmu_is_valid_msr(vcpu, msr))
 			return kvm_pmu_set_msr(vcpu, msr_info);
 		if (!ignore_msrs) {
 			vcpu_debug_ratelimited(vcpu, "unhandled wrmsr: 0x%x data 0x%llx\n",
 				    msr, data);
@@ -2540,16 +2557,22 @@ int kvm_get_msr_common(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 			return 1;
 		msr_info->data = vcpu->arch.osvw.length;
 		break;
 	case MSR_AMD64_OSVW_STATUS:
 		if (!guest_cpuid_has_osvw(vcpu))
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
 		if (!ignore_msrs) {
 			vcpu_debug_ratelimited(vcpu, "unhandled rdmsr: 0x%x\n",
 					       msr_info->index);
 			return 1;
 		} else {
@@ -7719,16 +7742,19 @@ void kvm_vcpu_reset(struct kvm_vcpu *vcpu, bool init_event)
 
 	kvm_clear_async_pf_completion_queue(vcpu);
 	kvm_async_pf_hash_reset(vcpu);
 	vcpu->arch.apf.halted = false;
 
 	if (!init_event) {
 		kvm_pmu_reset(vcpu);
 		vcpu->arch.smbase = 0x30000;
+
+		vcpu->arch.msr_platform_info = MSR_PLATFORM_INFO_CPUID_FAULT;
+		vcpu->arch.msr_misc_features_enables = 0;
 	}
 
 	memset(vcpu->arch.regs, 0, sizeof(vcpu->arch.regs));
 	vcpu->arch.regs_avail = ~0;
 	vcpu->arch.regs_dirty = ~0;
 
 	kvm_x86_ops->vcpu_reset(vcpu, init_event);
 }
-- 
2.11.0


