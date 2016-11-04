Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20161101013749.4003-8-khuey@kylehuey.com>
References: <20161101013749.4003-1-khuey@kylehuey.com> <20161101013749.4003-8-khuey@kylehuey.com>
From: David Matlack <dmatlack@google.com>
Date: Fri, 4 Nov 2016 13:34:31 -0700
Message-ID: <CALzav=ehOA3M513SFyRTT6kFx5ZD1U_jpo8CHKh3XvpcGA6A5Q@mail.gmail.com>
Subject: Re: [PATCH v8 7/7] KVM: x86: virtualize cpuid faulting
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
To: Kyle Huey <me@kylehuey.com>
Cc: Robert O'Callahan <robert@ocallahan.org>, Thomas Gleixner <tglx@linutronix.de>, Andy Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Alexander Viro <viro@zeniv.linux.org.uk>, Shuah Khan <shuah@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, Borislav Petkov <bp@suse.de>, Peter Zijlstra <peterz@infradead.org>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Len Brown <len.brown@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Dmitry Safonov <dsafonov@virtuozzo.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, user-mode-linux-devel@lists.sourceforge.net, user-mode-linux-user@lists.sourceforge.net, linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org, kvm list <kvm@vger.kernel.org>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On Mon, Oct 31, 2016 at 6:37 PM, Kyle Huey <me@kylehuey.com> wrote:
> Hardware support for faulting on the cpuid instruction is not required to
> emulate it, because cpuid triggers a VM exit anyways. KVM handles the relevant
> MSRs (MSR_PLATFORM_INFO and MSR_MISC_FEATURES_ENABLE) and upon a
> cpuid-induced VM exit checks the cpuid faulting state and the CPL.
> kvm_require_cpl is even kind enough to inject the GP fault for us.
>
> Signed-off-by: Kyle Huey <khuey@kylehuey.com>
> ---
>  arch/x86/include/asm/kvm_host.h |  1 +
>  arch/x86/kvm/cpuid.c            |  3 +++
>  arch/x86/kvm/x86.c              | 16 ++++++++++++++++
>  3 files changed, 20 insertions(+)
>
> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
> index 4b20f73..4a6e62b 100644
> --- a/arch/x86/include/asm/kvm_host.h
> +++ b/arch/x86/include/asm/kvm_host.h
> @@ -592,16 +592,17 @@ struct kvm_vcpu_arch {
>         u64 pat;
>
>         unsigned switch_db_regs;
>         unsigned long db[KVM_NR_DB_REGS];
>         unsigned long dr6;
>         unsigned long dr7;
>         unsigned long eff_db[KVM_NR_DB_REGS];
>         unsigned long guest_debug_dr7;
> +       bool cpuid_fault;
>
>         u64 mcg_cap;
>         u64 mcg_status;
>         u64 mcg_ctl;
>         u64 mcg_ext_ctl;
>         u64 *mce_banks;
>
>         /* Cache MMIO info */
> diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
> index afa7bbb..ed8436a 100644
> --- a/arch/x86/kvm/cpuid.c
> +++ b/arch/x86/kvm/cpuid.c
> @@ -862,16 +862,19 @@ void kvm_cpuid(struct kvm_vcpu *vcpu, u32 *eax, u32 *ebx, u32 *ecx, u32 *edx)
>         trace_kvm_cpuid(function, *eax, *ebx, *ecx, *edx);
>  }
>  EXPORT_SYMBOL_GPL(kvm_cpuid);
>
>  void kvm_emulate_cpuid(struct kvm_vcpu *vcpu)
>  {
>         u32 function, eax, ebx, ecx, edx;
>
> +       if (vcpu->arch.cpuid_fault && !kvm_require_cpl(vcpu, 0))
> +               return;
> +
>         function = eax = kvm_register_read(vcpu, VCPU_REGS_RAX);
>         ecx = kvm_register_read(vcpu, VCPU_REGS_RCX);
>         kvm_cpuid(vcpu, &eax, &ebx, &ecx, &edx);
>         kvm_register_write(vcpu, VCPU_REGS_RAX, eax);
>         kvm_register_write(vcpu, VCPU_REGS_RBX, ebx);
>         kvm_register_write(vcpu, VCPU_REGS_RCX, ecx);
>         kvm_register_write(vcpu, VCPU_REGS_RDX, edx);
>         kvm_x86_ops->skip_emulated_instruction(vcpu);
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index e375235..470c553 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -2269,16 +2269,21 @@ int kvm_set_msr_common(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
>                         return 1;
>                 vcpu->arch.osvw.length = data;
>                 break;
>         case MSR_AMD64_OSVW_STATUS:
>                 if (!guest_cpuid_has_osvw(vcpu))
>                         return 1;
>                 vcpu->arch.osvw.status = data;
>                 break;
> +       case MSR_MISC_FEATURES_ENABLES:
> +               if (data & ~CPUID_FAULT_ENABLE)
> +                       return 1;

(Due to my comments below, PLATINFO_CPUID_FAULT will not necessarily
be enabled for guests. So this code will need to check if the virtual CPU
supports PLATINFO_CPUID_FAULT before enabling CPUID faulting.)

> +               vcpu->arch.cpuid_fault = !!(data & CPUID_FAULT_ENABLE);
> +               break;
>         default:
>                 if (msr && (msr == vcpu->kvm->arch.xen_hvm_config.msr))
>                         return xen_hvm_config(vcpu, data);
>                 if (kvm_pmu_is_valid_msr(vcpu, msr))
>                         return kvm_pmu_set_msr(vcpu, msr_info);
>                 if (!ignore_msrs) {
>                         vcpu_unimpl(vcpu, "unhandled wrmsr: 0x%x data %llx\n",
>                                     msr, data);
> @@ -2483,16 +2488,25 @@ int kvm_get_msr_common(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
>                         return 1;
>                 msr_info->data = vcpu->arch.osvw.length;
>                 break;
>         case MSR_AMD64_OSVW_STATUS:
>                 if (!guest_cpuid_has_osvw(vcpu))
>                         return 1;
>                 msr_info->data = vcpu->arch.osvw.status;
>                 break;
> +       case MSR_PLATFORM_INFO:
> +               /* cpuid faulting is supported */
> +               msr_info->data = PLATINFO_CPUID_FAULT;
> +               break;

This could break save/restore, if for example, a VM is migrated to a
version of KVM without MSR_PLATFORM_INFO support. I think the way to
handle this is to make MSR_PLATFORM_INFO writeable (but only from
userspace) so that hypervisors can defend themselves (by setting this
MSR to 0).

> +       case MSR_MISC_FEATURES_ENABLES:
> +               msr_info->data = 0;
> +               if (vcpu->arch.cpuid_fault)
> +                       msr_info->data |= CPUID_FAULT_ENABLE;
> +               break;

MSR_MISC_FEATURES_ENABLES should be added to emulated_msrs[] so that
the hypervisor will maintain the value of CPUID_FAULT_ENABLE across a
save/restore.

>         default:
>                 if (kvm_pmu_is_valid_msr(vcpu, msr_info->index))
>                         return kvm_pmu_get_msr(vcpu, msr_info->index, &msr_info->data);
>                 if (!ignore_msrs) {
>                         vcpu_unimpl(vcpu, "unhandled rdmsr: 0x%x\n", msr_info->index);
>                         return 1;
>                 } else {
>                         vcpu_unimpl(vcpu, "ignored rdmsr: 0x%x\n", msr_info->index);
> @@ -7493,16 +7507,18 @@ void kvm_vcpu_reset(struct kvm_vcpu *vcpu, bool init_event)
>         kvm_update_dr0123(vcpu);
>         vcpu->arch.dr6 = DR6_INIT;
>         kvm_update_dr6(vcpu);
>         vcpu->arch.dr7 = DR7_FIXED_1;
>         kvm_update_dr7(vcpu);
>
>         vcpu->arch.cr2 = 0;
>
> +       vcpu->arch.cpuid_fault = false;
> +
>         kvm_make_request(KVM_REQ_EVENT, vcpu);
>         vcpu->arch.apf.msr_val = 0;
>         vcpu->arch.st.msr_val = 0;
>
>         kvmclock_reset(vcpu);
>
>         kvm_clear_async_pf_completion_queue(vcpu);
>         kvm_async_pf_hash_reset(vcpu);
> --
> 2.10.2
>
> --
> To unsubscribe from this list: send the line "unsubscribe kvm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

