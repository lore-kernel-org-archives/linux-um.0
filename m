Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20161118081444.GC15912@gmail.com>
References: <20161117020610.5302-1-khuey@kylehuey.com> <20161117020610.5302-7-khuey@kylehuey.com>
 <20161118081444.GC15912@gmail.com>
From: Kyle Huey <me@kylehuey.com>
Date: Fri, 18 Nov 2016 07:55:37 -0800
Message-ID: <CAP045Aor3ed63N9OEE=qz9YFaxD4xo2=rnzHoToyD-tQqO=bLA@mail.gmail.com>
Subject: Re: [PATCH v12 6/7] x86/arch_prctl: Add ARCH_[GET|SET]_CPUID
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Robert O'Callahan <robert@ocallahan.org>, Thomas Gleixner <tglx@linutronix.de>, Andy Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Alexander Viro <viro@zeniv.linux.org.uk>, Shuah Khan <shuah@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, Borislav Petkov <bp@suse.de>, Peter Zijlstra <peterz@infradead.org>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Len Brown <len.brown@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Dmitry Safonov <dsafonov@virtuozzo.com>, David Matlack <dmatlack@google.com>, Nadav Amit <nadav.amit@gmail.com>, open list <linux-kernel@vger.kernel.org>, "open list:USER-MODE LINUX (UML)" <user-mode-linux-devel@lists.sourceforge.net>, "open list:USER-MODE LINUX (UML)" <user-mode-linux-user@lists.sourceforge.net>, "open list:FILESYSTEMS (VFS and infrastructure)" <linux-fsdevel@vger.kernel.org>, "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, kvm list <kvm@vger.kernel.org>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On Fri, Nov 18, 2016 at 12:14 AM, Ingo Molnar <mingo@kernel.org> wrote:
>
> * Kyle Huey <me@kylehuey.com> wrote:
>
>> Intel supports faulting on the CPUID instruction beginning with Ivy Bridge.
>> When enabled, the processor will fault on attempts to execute the CPUID
>> instruction with CPL>0. Exposing this feature to userspace will allow a
>> ptracer to trap and emulate the CPUID instruction.
>>
>> When supported, this feature is controlled by toggling bit 0 of
>> MSR_MISC_FEATURES_ENABLES. It is documented in detail in Section 2.3.2 of
>> https://bugzilla.kernel.org/attachment.cgi?id=243991
>>
>> Implement a new pair of arch_prctls, available on both x86-32 and x86-64.
>>
>> ARCH_GET_CPUID: Returns the current CPUID faulting state, either
>>   ARCH_CPUID_ENABLE or ARCH_CPUID_SIGSEGV. arg2 must be 0.
>>
>> ARCH_SET_CPUID: Set the CPUID faulting state to arg2, which must be either
>>   ARCH_CPUID_ENABLE or ARCH_CPUID_SIGSEGV. Returns EINVAL if arg2 is
>>   another value or CPUID faulting is not supported on this system.
>
> So the interface is:
>
>> +#define ARCH_GET_CPUID 0x1005
>> +#define ARCH_SET_CPUID 0x1006
>> +#define ARCH_CPUID_ENABLE 1
>> +#define ARCH_CPUID_SIGSEGV 2
>
> Which maps to:
>
>    prctl(ARCH_SET_CPUID, 0); /* -EINVAL */
>    prctl(ARCH_SET_CPUID, 1); /* enable CPUID [i.e. make it work without faulting] */
>    prctl(ARCH_SET_CPUID, 2); /* disable CPUID [i.e. make it fault] */
>
>    ret = prctl(ARCH_GET_CPUID, 0); /* return current state: 1==on, 2==off */

arch_prctl in all cases, but yes.

> This is a very broken interface that makes very little sense.

It's copied from prctl(PR_SET/GET_TSC), for what that's worth.  I'm
happy to change this as long as nobody will complain about the
inconsistency :)

> It would be much better to use a more natural interface where 1/0 means on/off and
> where ARCH_GET_CPUID returns the current natural state:
>
>    prctl(ARCH_SET_CPUID, 0); /* disable CPUID [i.e. make it fault] */
>    prctl(ARCH_SET_CPUID, 1); /* enable CPUID [i.e. make it work without faulting] */
>
>    ret = prctl(ARCH_GET_CPUID); /* 1==enabled, 0==disabled */
>
> See how natural it is? The use of the ARCH_CPUID_SIGSEGV/ENABLED symbols can be
> avoided altogether. This will cut down on some of the ugliness in the kernel code
> as well - and clean up the argument name as well: instead of naming it 'int arg2'
> it can be named the more natural 'int cpuid_enabled'.
>
>> The state of the CPUID faulting flag is propagated across forks, but reset
>> upon exec.
>
> I don't think this is the natural API for propagating settings across exec().
> We should reset the flag on exec() only if security considerations require it -
> i.e. like perf events are cleared.

I had a discussion with Andy Lutomirski about this a couple months
ago. See https://lkml.org/lkml/2016/9/14/968.  So if you want to do
something different here I'd like the two of you to agree before I
change the code :)

> If binaries that assume a working CPUID are exec()-ed then CPUID can be enabled
> explicitly.

glibc's ld.so requires CPUID, so most binaries will.

> Clearing it automatically loses the ability of a pure no-CPUID environment to
> exec() a CPUID-safe binary.

I don't know that this will be particularly useful, given the above.

>> Signed-off-by: Kyle Huey <khuey@kylehuey.com>
>> ---
>>  arch/x86/include/asm/msr-index.h          |   3 +
>>  arch/x86/include/asm/processor.h          |   2 +
>>  arch/x86/include/asm/thread_info.h        |   6 +-
>>  arch/x86/include/uapi/asm/prctl.h         |   6 +
>>  arch/x86/kernel/cpu/intel.c               |   7 +
>>  arch/x86/kernel/process.c                 |  84 ++++++++++
>>  fs/exec.c                                 |   1 +
>>  include/linux/thread_info.h               |   4 +
>>  tools/testing/selftests/x86/Makefile      |   2 +-
>>  tools/testing/selftests/x86/cpuid-fault.c | 254 ++++++++++++++++++++++++++++++
>>  10 files changed, 367 insertions(+), 2 deletions(-)
>>  create mode 100644 tools/testing/selftests/x86/cpuid-fault.c
>
> Please put the self-test into a separate patch.

Ok.

>>  static void init_intel_misc_features_enables(struct cpuinfo_x86 *c)
>>  {
>>       u64 msr;
>>
>> +     if (rdmsrl_safe(MSR_MISC_FEATURES_ENABLES, &msr))
>> +             return;
>> +
>> +     msr = 0;
>> +     wrmsrl(MSR_MISC_FEATURES_ENABLES, msr);
>> +     this_cpu_write(msr_misc_features_enables_shadow, msr);
>> +
>>       if (!rdmsrl_safe(MSR_PLATFORM_INFO, &msr)) {
>>               if (msr & MSR_PLATFORM_INFO_CPUID_FAULT)
>>                       set_cpu_cap(c, X86_FEATURE_CPUID_FAULT);
>>       }
>>  }
>
> Sigh, so the Intel MSR index itself is grossly misnamed: MSR_MISC_FEATURES_ENABLES
> - plain reading of 'enables' suggests it's a verb, but in wants to be a noun. A
> better name would be MSR_MISC_FEATURES or so.
>
> So while for the MSR index we want to keep the Intel name, please drop that
> _enables() postfix from the kernel C function names such as this one - and from
> the shadow value name as well.

Ok.

>> +DEFINE_PER_CPU(u64, msr_misc_features_enables_shadow);
>> +
>> +static void set_cpuid_faulting(bool on)
>> +{
>> +     u64 msrval;
>> +
>> +     DEBUG_LOCKS_WARN_ON(!irqs_disabled());
>> +
>> +     msrval = this_cpu_read(msr_misc_features_enables_shadow);
>> +     msrval &= ~MSR_MISC_FEATURES_ENABLES_CPUID_FAULT;
>> +     msrval |= (on << MSR_MISC_FEATURES_ENABLES_CPUID_FAULT_BIT);
>> +     this_cpu_write(msr_misc_features_enables_shadow, msrval);
>> +     wrmsrl(MSR_MISC_FEATURES_ENABLES, msrval);
>
> This gets called from the context switch path and this looks pretty suboptimal,
> especially when combined with the TIF flag check:
>
>>  void __switch_to_xtra(struct task_struct *prev_p, struct task_struct *next_p,
>>                     struct tss_struct *tss)
>>  {
>>       struct thread_struct *prev, *next;
>>
>>       prev = &prev_p->thread;
>>       next = &next_p->thread;
>>
>> @@ -206,16 +278,21 @@ void __switch_to_xtra(struct task_struct *prev_p, struct task_struct *next_p,
>>
>>               debugctl &= ~DEBUGCTLMSR_BTF;
>>               if (test_tsk_thread_flag(next_p, TIF_BLOCKSTEP))
>>                       debugctl |= DEBUGCTLMSR_BTF;
>>
>>               update_debugctlmsr(debugctl);
>>       }
>>
>> +     if (test_tsk_thread_flag(prev_p, TIF_NOCPUID) ^
>> +         test_tsk_thread_flag(next_p, TIF_NOCPUID)) {
>> +             set_cpuid_faulting(test_tsk_thread_flag(next_p, TIF_NOCPUID));
>> +     }
>> +
>
> Why not cache the required MSR value in the task struct instead?
>
> That would allow something much more obvious and much faster, like:
>
>         if (prev_p->thread.misc_features_val != next_p->thread.misc_features_val)
>                 wrmsrl(MSR_MISC_FEATURES_ENABLES, next_p->thread.misc_features_val);
>
> (The TIF flag maintenance is still required to get into __switch_to_xtra().)
>
> It would also be easy to extend without extra overhead, should any other feature
> bit be added to the MSR in the future.

Thomas covered this one.

- Kyle

