Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.20.1611091425042.3501@nanos>
References: <20161108183956.4521-1-khuey@kylehuey.com> <20161108183956.4521-7-khuey@kylehuey.com>
 <alpine.DEB.2.20.1611082007010.3501@nanos> <20161109132114.3ujq2wkhsm4kcytz@pd.tnic>
 <alpine.DEB.2.20.1611091425042.3501@nanos>
From: Kyle Huey <me@kylehuey.com>
Date: Thu, 10 Nov 2016 15:38:41 -0800
Message-ID: <CAP045Arx_8XLGkrZdj4+ZOKeWhrbVM5CUbNbiPkdWjLQC4YkUw@mail.gmail.com>
Subject: Re: [PATCH v10 6/7] x86/arch_prctl: Add ARCH_[GET|SET]_CPUID
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Borislav Petkov <bp@suse.de>, Robert O'Callahan <robert@ocallahan.org>, Andy Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Alexander Viro <viro@zeniv.linux.org.uk>, Shuah Khan <shuah@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Len Brown <len.brown@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Dmitry Safonov <dsafonov@virtuozzo.com>, David Matlack <dmatlack@google.com>, open list <linux-kernel@vger.kernel.org>, "open list:USER-MODE LINUX (UML)" <user-mode-linux-devel@lists.sourceforge.net>, "open list:USER-MODE LINUX (UML)" <user-mode-linux-user@lists.sourceforge.net>, "open list:FILESYSTEMS (VFS and infrastructure)" <linux-fsdevel@vger.kernel.org>, "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, kvm list <kvm@vger.kernel.org>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On Wed, Nov 9, 2016 at 5:34 AM, Thomas Gleixner <tglx@linutronix.de> wrote:
> On Wed, 9 Nov 2016, Borislav Petkov wrote:
>> +static void init_misc_enables(struct cpuinfo_x86 *c)
>> +{
>> +     u64 val, misc_en;
>> +
>> +     if (rdmsrl_safe(MSR_MISC_FEATURES_ENABLES, &misc_en))
>> +             return;
>> +
>> +     misc_en &= ~MSR_MISC_ENABLES_CPUID_FAULT_ENABLE;
>
> I rather prefer to write this MSR to 0 right away and just enable the bits
> which we really support.

I've gone ahead and done this.

- Kyle

