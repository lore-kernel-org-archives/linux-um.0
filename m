Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.20.1703142112200.3770@nanos>
References: <20170311194702.28754-1-khuey@kylehuey.com> <20170311194702.28754-7-khuey@kylehuey.com>
 <alpine.DEB.2.20.1703142112200.3770@nanos>
From: Kyle Huey <me@kylehuey.com>
Date: Mon, 20 Mar 2017 01:01:54 -0700
Message-ID: <CAP045AoSC_KXrGyscnZiqnvtdr_e6PmmZ4RiD4CEgc_5RiHbhw@mail.gmail.com>
Subject: Re: [PATCH v15 6/9] x86/arch_prctl: Add ARCH_[GET|SET]_CPUID
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Robert O'Callahan <robert@ocallahan.org>, Andy Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Alexander Viro <viro@zeniv.linux.org.uk>, Shuah Khan <shuah@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, Borislav Petkov <bp@suse.de>, Peter Zijlstra <peterz@infradead.org>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Len Brown <len.brown@intel.com>, Dmitry Safonov <dsafonov@virtuozzo.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, David Matlack <dmatlack@google.com>, Nadav Amit <nadav.amit@gmail.com>, Andi Kleen <andi@firstfloor.org>, open list <linux-kernel@vger.kernel.org>, "open list:USER-MODE LINUX (UML)" <user-mode-linux-devel@lists.sourceforge.net>, "open list:USER-MODE LINUX (UML)" <user-mode-linux-user@lists.sourceforge.net>, "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, kvm list <kvm@vger.kernel.org>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On Tue, Mar 14, 2017 at 1:36 PM, Thomas Gleixner <tglx@linutronix.de> wrote:
> On Sat, 11 Mar 2017, Kyle Huey wrote:
>>  static void init_intel_misc_features(struct cpuinfo_x86 *c)
>>  {
>>       u64 msr;
>>
>> +     if (rdmsrl_safe(MSR_MISC_FEATURES_ENABLES, &msr))
>> +             return;
>> +
>> +     msr = 0;
>> +     wrmsrl(MSR_MISC_FEATURES_ENABLES, msr);
>> +     this_cpu_write(msr_misc_features_shadow, msr);
>> +
>>       if (!rdmsrl_safe(MSR_PLATFORM_INFO, &msr)) {
>>               if (msr & MSR_PLATFORM_INFO_CPUID_FAULT)
>>                       set_cpu_cap(c, X86_FEATURE_CPUID_FAULT);
>>       }
>>
>>       probe_xeon_phi_r3mwait(c);
>
> The way you are doing it breaks the ring3 mwait feature because you
> overwrite the R3MWAIT bit the first time you update the MSR on context
> switch.

Indeed.  Good catch.

- Kyle

