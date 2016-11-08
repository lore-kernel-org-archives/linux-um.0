Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Kyle Huey <me@kylehuey.com>
Subject: [PATCH v9 7/7] KVM: x86: virtualize cpuid faulting
Date: Tue,  8 Nov 2016 09:58:24 -0800
Message-Id: <20161108175824.3532-2-khuey@kylehuey.com>
In-Reply-To: <20161108175824.3532-1-khuey@kylehuey.com>
References: <CAP045ApKtyuWUtOpiLPnvKqwBBugm6tN+CzPLgEWgaqSx0+BeQ@mail.gmail.com>
 <20161108175824.3532-1-khuey@kylehuey.com>
Sender: linux-kernel-owner@vger.kernel.org
To: David Matlack <dmatlack@google.com>
Cc: Robert O'Callahan <robert@ocallahan.org>, Thomas Gleixner <tglx@linutronix.de>, Andy Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Alexander Viro <viro@zeniv.linux.org.uk>, Shuah Khan <shuah@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, Borislav Petkov <bp@suse.de>, Peter Zijlstra <peterz@infradead.org>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Len Brown <len.brown@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Dmitry Safonov <dsafonov@virtuozzo.com>, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, user-mode-linux-user@lists.sourceforge.net, linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org, kvm@vger.kernel.org
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

Hardware support for faulting on the cpuid instruction is not required to
emulate it, because cpuid triggers a VM exit anyways. KVM handles the relevant
MSRs (MSR_PLATFORM_INFO and MSR_MISC_FEATURES_ENABLE) and upon a
cpuid-induced VM exit checks the cpuid faulting state and the CPL.
kvm_require_cpl is even kind enough to inject the GP fault for us.

Signed-off-by: Kyle Huey <khuey@kylehuey.com>
---
 arch/x86/include/asm/kvm_host.h |  2 ++
 arch/x86/kvm/cpuid.c            |  3 +++
 arch/x86/kvm/x86.c              | 26 ++++++++++++++++++++++++++
 3 files changed, 31 insertions(+)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index bdde807..4111b6a 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -592,16 +592,18 @@ struct kvm_vcpu_arch {
 	u64 pat;
 
 	unsigned switch_db_regs;
 	unsigned long db[KVM_NR_DB_REGS];
 	unsigned long dr6;
 	unsigned long dr7;
 	unsigned long eff_db[KVM_NR_DB_REGS];
 	unsigned long guest_debug_dr7;
+	u64 msr_platform_info;
+	bool cpuid_fault;
 
 	u64 mcg_cap;
 	u64 mcg_status;
 	u64 mcg_ctl;
 	u64 mcg_ext_ctl;
 	u64 *mce_banks;
 
 	/* Cache MMIO info */
diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index afa7bbb..ed8436a 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -862,16 +862,19 @@ void kvm_cpuid(struct kvm_vcpu *vcpu, u32 *eax, u32 *ebx, u32 *ecx, u32 *edx)
 	trace_kvm_cpuid(function, *eax, *ebx, *ecx, *edx);
 }
 EXPORT_SYMBOL_GPL(kvm_cpuid);
 
 void kvm_emulate_cpuid(struct kvm_vcpu *vcpu)
 {
 	u32 function, eax, ebx, ecx, edx;
 
+	if (vcpu->arch.cpuid_fault && !kvm_require_cpl(vcpu, 0))
+		return;
+
 	function = eax = kvm_register_read(vcpu, VCPU_REGS_RAX);
 	ecx = kvm_register_read(vcpu, VCPU_REGS_RCX);
 	kvm_cpuid(vcpu, &eax, &ebx, &ecx, &edx);
 	kvm_register_write(vcpu, VCPU_REGS_RAX, eax);
 	kvm_register_write(vcpu, VCPU_REGS_RBX, ebx);
 	kvm_register_write(vcpu, VCPU_REGS_RCX, ecx);
 	kvm_register_write(vcpu, VCPU_REGS_RDX, edx);
 	kvm_x86_ops->skip_emulated_instruction(vcpu);
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 3017de0..d116103 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -986,16 +986,18 @@ static u32 emulated_msrs[] = {
 
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
@@ -2269,16 +2271,29 @@ int kvm_set_msr_common(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
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
+		    data & ~PLATINFO_CPUID_FAULT ||
+		    (!(data & PLATINFO_CPUID_FAULT) && vcpu->arch.cpuid_fault))
+			return 1;
+		vcpu->arch.msr_platform_info = data;
+		break;
+	case MSR_MISC_FEATURES_ENABLES:
+		if (data & ~CPUID_FAULT_ENABLE ||
+		    !(vcpu->arch.msr_platform_info & PLATINFO_CPUID_FAULT))
+			return 1;
+		vcpu->arch.cpuid_fault = data & CPUID_FAULT_ENABLE;
+		break;
 	default:
 		if (msr && (msr == vcpu->kvm->arch.xen_hvm_config.msr))
 			return xen_hvm_config(vcpu, data);
 		if (kvm_pmu_is_valid_msr(vcpu, msr))
 			return kvm_pmu_set_msr(vcpu, msr_info);
 		if (!ignore_msrs) {
 			vcpu_unimpl(vcpu, "unhandled wrmsr: 0x%x data 0x%llx\n",
 				    msr, data);
@@ -2483,16 +2498,24 @@ int kvm_get_msr_common(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
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
+		msr_info->data = 0;
+		if (vcpu->arch.cpuid_fault)
+			msr_info->data |= CPUID_FAULT_ENABLE;
+		break;
 	default:
 		if (kvm_pmu_is_valid_msr(vcpu, msr_info->index))
 			return kvm_pmu_get_msr(vcpu, msr_info->index, &msr_info->data);
 		if (!ignore_msrs) {
 			vcpu_unimpl(vcpu, "unhandled rdmsr: 0x%x\n", msr_info->index);
 			return 1;
 		} else {
 			vcpu_unimpl(vcpu, "ignored rdmsr: 0x%x\n", msr_info->index);
@@ -7508,16 +7531,19 @@ void kvm_vcpu_reset(struct kvm_vcpu *vcpu, bool init_event)
 
 	kvm_clear_async_pf_completion_queue(vcpu);
 	kvm_async_pf_hash_reset(vcpu);
 	vcpu->arch.apf.halted = false;
 
 	if (!init_event) {
 		kvm_pmu_reset(vcpu);
 		vcpu->arch.smbase = 0x30000;
+
+		vcpu->arch.msr_platform_info = PLATINFO_CPUID_FAULT;
+		vcpu->arch.cpuid_fault = false;
 	}
 
 	memset(vcpu->arch.regs, 0, sizeof(vcpu->arch.regs));
 	vcpu->arch.regs_avail = ~0;
 	vcpu->arch.regs_dirty = ~0;
 
 	kvm_x86_ops->vcpu_reset(vcpu, init_event);
 }
-- 
2.10.2


