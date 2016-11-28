Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.20.1611281437130.3512@nanos>
References: <20161128030521.4423-1-khuey@kylehuey.com> <20161128030521.4423-7-khuey@kylehuey.com>
 <alpine.DEB.2.20.1611281437130.3512@nanos>
From: Kyle Huey <me@kylehuey.com>
Date: Mon, 28 Nov 2016 08:13:49 -0800
Message-ID: <CAP045AqHDEKbVR3WuSoKukQU3J24_Gp4YmD-9Xht7+073g999Q@mail.gmail.com>
Subject: Re: [PATCH v13 6/8] x86/arch_prctl: Add ARCH_[GET|SET]_CPUID
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Robert O'Callahan <robert@ocallahan.org>, Andy Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Alexander Viro <viro@zeniv.linux.org.uk>, Shuah Khan <shuah@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, Borislav Petkov <bp@suse.de>, Peter Zijlstra <peterz@infradead.org>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Len Brown <len.brown@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Dmitry Safonov <dsafonov@virtuozzo.com>, David Matlack <dmatlack@google.com>, Nadav Amit <nadav.amit@gmail.com>, Andi Kleen <andi@firstfloor.org>, open list <linux-kernel@vger.kernel.org>, "open list:USER-MODE LINUX (UML)" <user-mode-linux-devel@lists.sourceforge.net>, "open list:USER-MODE LINUX (UML)" <user-mode-linux-user@lists.sourceforge.net>, "open list:FILESYSTEMS (VFS and infrastructure)" <linux-fsdevel@vger.kernel.org>, "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, kvm list <kvm@vger.kernel.org>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On Mon, Nov 28, 2016 at 6:06 AM, Thomas Gleixner <tglx@linutronix.de> wrote:
> On Sun, 27 Nov 2016, Kyle Huey wrote:
>> +DEFINE_PER_CPU(u64, msr_misc_features_shadow);
>> +
>> +static void set_cpuid_faulting(bool on)
>> +{
>> +     u64 msrval;
>> +
>> +     DEBUG_LOCKS_WARN_ON(!irqs_disabled());
>
> The arch_prctl code path does not have interrupts disabled and there is no
> reason why it should have.

Yes, indeed. Removed.

- Kyle

