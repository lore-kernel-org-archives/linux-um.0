Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.20.1611082002160.3501@nanos>
References: <20161108183956.4521-1-khuey@kylehuey.com> <20161108183956.4521-6-khuey@kylehuey.com>
 <alpine.DEB.2.20.1611082002160.3501@nanos>
From: Kyle Huey <me@kylehuey.com>
Date: Tue, 8 Nov 2016 11:38:25 -0800
Message-ID: <CAP045ApgFPBVoQLKyC0t46Axy=fYF53ToNM2AK1ghCqbGRi6TQ@mail.gmail.com>
Subject: Re: [PATCH v10 5/7] x86/cpufeature: Detect CPUID faulting support
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Robert O'Callahan <robert@ocallahan.org>, Andy Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Alexander Viro <viro@zeniv.linux.org.uk>, Shuah Khan <shuah@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, Borislav Petkov <bp@suse.de>, Peter Zijlstra <peterz@infradead.org>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Len Brown <len.brown@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Dmitry Safonov <dsafonov@virtuozzo.com>, David Matlack <dmatlack@google.com>, open list <linux-kernel@vger.kernel.org>, "open list:USER-MODE LINUX (UML)" <user-mode-linux-devel@lists.sourceforge.net>, "open list:USER-MODE LINUX (UML)" <user-mode-linux-user@lists.sourceforge.net>, "open list:FILESYSTEMS (VFS and infrastructure)" <linux-fsdevel@vger.kernel.org>, "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, kvm list <kvm@vger.kernel.org>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On Tue, Nov 8, 2016 at 11:06 AM, Thomas Gleixner <tglx@linutronix.de> wrote:
> On Tue, 8 Nov 2016, Kyle Huey wrote:
>
>> Intel supports faulting on the CPUID instruction beginning with Ivy Bridge.
>> When enabled, the processor will fault on attempts to execute the CPUID
>> instruction with CPL>0. This will allow a ptracer to emulate the CPUID
>> instruction.
>>
>> Bit 31 of MSR_PLATFORM_INFO advertises support for this feature. It is
>> documented in detail in Section 2.3.2 of
>> http://www.intel.com/content/dam/www/public/us/en/documents/application-notes/virtualization-technology-flexmigration-application-note.pdf

Done. https://bugzilla.kernel.org/attachment.cgi?id=243991

> Can you please stick that document into the kernel bugzilla, as it's going
> to be on a different place before this gets merged into Linus tree?
>
> See: http://lkml.kernel.org/r/1478631281-5061-1-git-send-email-kan.liang@intel.com
>
>> +     static const struct msr_bit msr_bits[] = {
>> +             { X86_FEATURE_CPUID_FAULT,      MSR_PLATFORM_INFO, 31 },
>
> Can you please make that PLATINFO_CPUID_FAULT_BIT instead of 31?

Sure.

- Kyle

