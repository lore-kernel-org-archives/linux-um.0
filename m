Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.20.1703201558450.3599@nanos>
References: <20170320081628.18952-1-khuey@kylehuey.com> <20170320081628.18952-9-khuey@kylehuey.com>
 <alpine.DEB.2.20.1703201558450.3599@nanos>
From: Kyle Huey <me@kylehuey.com>
Date: Mon, 20 Mar 2017 09:39:56 -0700
Message-ID: <CAP045AqMhLATXRdL=Ktar03L5pEE-P1MYpWdb1sCiFQ9CMCWBA@mail.gmail.com>
Subject: Re: [PATCH v16 08/10] x86/arch_prctl: Add ARCH_[GET|SET]_CPUID
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Robert O'Callahan <robert@ocallahan.org>, Andy Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Alexander Viro <viro@zeniv.linux.org.uk>, Shuah Khan <shuah@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, Borislav Petkov <bp@suse.de>, Peter Zijlstra <peterz@infradead.org>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Len Brown <len.brown@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Dmitry Safonov <dsafonov@virtuozzo.com>, David Matlack <dmatlack@google.com>, Nadav Amit <nadav.amit@gmail.com>, Andi Kleen <andi@firstfloor.org>, Grzegorz Andrejczuk <grzegorz.andrejczuk@intel.com>, open list <linux-kernel@vger.kernel.org>, "open list:USER-MODE LINUX (UML)" <user-mode-linux-devel@lists.sourceforge.net>, "open list:USER-MODE LINUX (UML)" <user-mode-linux-user@lists.sourceforge.net>, "open list:FILESYSTEMS (VFS and infrastructure)" <linux-fsdevel@vger.kernel.org>, "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, kvm list <kvm@vger.kernel.org>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On Mon, Mar 20, 2017 at 8:00 AM, Thomas Gleixner <tglx@linutronix.de> wrote:
> On Mon, 20 Mar 2017, Kyle Huey wrote:
>> --- a/arch/x86/include/uapi/asm/prctl.h
>> +++ b/arch/x86/include/uapi/asm/prctl.h
>> @@ -6,8 +6,17 @@
>>  #define ARCH_GET_FS 0x1003
>>  #define ARCH_GET_GS 0x1004
>>
>> +#define ARCH_GET_CPUID 0x1005
>> +#define ARCH_SET_CPUID 0x1006
>> +
>>  #define ARCH_MAP_VDSO_X32    0x2001
>>  #define ARCH_MAP_VDSO_32     0x2002
>>  #define ARCH_MAP_VDSO_64     0x2003
>>
>> +#ifdef CONFIG_CHECKPOINT_RESTORE
>> +# define ARCH_MAP_VDSO_X32   0x2001
>> +# define ARCH_MAP_VDSO_32    0x2002
>> +# define ARCH_MAP_VDSO_64    0x2003
>> +#endif
>
> That hunk is bogus in two aspects:
>      - It's just a copy of the above wrapped in a ifdef
>
>      - The ifdef is broken, because the UAPI headers do not know about
>        that.
>
> I dropped it.

Looks like that was introduced when I rebased over a01aa6c9f40f for
v14 and I didn't catch it manually.  Thanks for finding and fixing
that.

- Kyle

