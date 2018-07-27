Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CALCETrVS8ch-1harGv2NUy83ZLna8Vde1zNLxPTPaxuMexQMjw@mail.gmail.com>
References: <20170208080917.24320-1-khuey@kylehuey.com> <20170208080917.24320-9-khuey@kylehuey.com>
 <CALCETrVS8ch-1harGv2NUy83ZLna8Vde1zNLxPTPaxuMexQMjw@mail.gmail.com>
From: Jim Mattson <jmattson@google.com>
Date: Fri, 27 Jul 2018 13:28:41 -0700
Message-ID: <CALMp9eSyJep6UPxeiZRWPrdzwvvcqJEbPPZ6C61EeHsvdyhMLg@mail.gmail.com>
Subject: Re: [PATCH v14 8/9] KVM: x86: virtualize cpuid faulting
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Lutomirski <luto@kernel.org>
Cc: Kyle Huey <me@kylehuey.com>, Robert O'Callahan <robert@ocallahan.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Alexander Viro <viro@zeniv.linux.org.uk>, Shuah Khan <shuah@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, Borislav Petkov <bp@suse.de>, Peter Zijlstra <peterz@infradead.org>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Len Brown <len.brown@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Dmitry Safonov <dsafonov@virtuozzo.com>, David Matlack <dmatlack@google.com>, Nadav Amit <nadav.amit@gmail.com>, Andi Kleen <andi@firstfloor.org>, LKML <linux-kernel@vger.kernel.org>, user-mode-linux-devel@lists.sourceforge.net, "open list:USER-MODE LINUX (UML)" <user-mode-linux-user@lists.sourceforge.net>, Linux FS Devel <linux-fsdevel@vger.kernel.org>, "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, kvm list <kvm@vger.kernel.org>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On Fri, Jul 27, 2018 at 12:41 PM, Andy Lutomirski <luto@kernel.org> wrote:
> On Wed, Feb 8, 2017 at 12:09 AM, Kyle Huey <me@kylehuey.com> wrote:
>> Hardware support for faulting on the cpuid instruction is not required to
>> emulate it, because cpuid triggers a VM exit anyways. KVM handles the relevant
>> MSRs (MSR_PLATFORM_INFO and MSR_MISC_FEATURES_ENABLE) and upon a
>> cpuid-induced VM exit checks the cpuid faulting state and the CPL.
>> kvm_require_cpl is even kind enough to inject the GP fault for us.
>>
>> Signed-off-by: Kyle Huey <khuey@kylehuey.com>
>> Reviewed-by: David Matlack <dmatlack@google.com>
>> ---
>> ...
>> @@ -7613,16 +7636,19 @@ void kvm_vcpu_reset(struct kvm_vcpu *vcpu, bool init_event)
>>
>>         kvm_clear_async_pf_completion_queue(vcpu);
>>         kvm_async_pf_hash_reset(vcpu);
>>         vcpu->arch.apf.halted = false;
>>
>>         if (!init_event) {
>>                 kvm_pmu_reset(vcpu);
>>                 vcpu->arch.smbase = 0x30000;
>> +
>> +               vcpu->arch.msr_platform_info = MSR_PLATFORM_INFO_CPUID_FAULT;
>> +               vcpu->arch.msr_misc_features_enables = 0;
>
> Jim, I assume you're worried about this bit?  It seems like
> msr_platform_info should maybe be initialized to zero to avoid causing
> an unintended migration issue.

Initializing this bit to zero helps with migration, but then if the
CPUID faulting bits in both MSRs are set, userspace has to take pains
to ensure that MSR_PLATFORM_INFO is restored first, or the
MSR_MISC_FEATURES_ENABLES value will be rejected.

I'm also concerned about the 0 in the "Maximum Non-Turbo Ratio" field
feeding into someone's calculated TSC frequency.

