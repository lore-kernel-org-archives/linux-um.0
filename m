Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.20.1703142106390.3770@nanos>
References: <20170311194702.28754-1-khuey@kylehuey.com> <20170311194702.28754-10-khuey@kylehuey.com>
 <alpine.DEB.2.20.1703142106390.3770@nanos>
From: Kyle Huey <me@kylehuey.com>
Date: Mon, 20 Mar 2017 01:01:29 -0700
Message-ID: <CAP045AowTekVEv0v04S2AbpO2MXsnOHmvmCLKKHz61++HwfWQQ@mail.gmail.com>
Subject: Re: [PATCH v15 9/9] x86/arch_prctl: Rename 'code' argument to 'option'
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Robert O'Callahan <robert@ocallahan.org>, Andy Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Alexander Viro <viro@zeniv.linux.org.uk>, Shuah Khan <shuah@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, Borislav Petkov <bp@suse.de>, Peter Zijlstra <peterz@infradead.org>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Len Brown <len.brown@intel.com>, Dmitry Safonov <dsafonov@virtuozzo.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, David Matlack <dmatlack@google.com>, Nadav Amit <nadav.amit@gmail.com>, Andi Kleen <andi@firstfloor.org>, open list <linux-kernel@vger.kernel.org>, "open list:USER-MODE LINUX (UML)" <user-mode-linux-devel@lists.sourceforge.net>, "open list:USER-MODE LINUX (UML)" <user-mode-linux-user@lists.sourceforge.net>, "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, kvm list <kvm@vger.kernel.org>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On Tue, Mar 14, 2017 at 1:07 PM, Thomas Gleixner <tglx@linutronix.de> wrote:
> On Sat, 11 Mar 2017, Kyle Huey wrote:
>
>> arch_prctl arbitrarily changed prctl's 'option' to 'code'. Now that we're
>> adding additional options, fix that.
>
> And why is that at the end of the series instead of being the first patch?

Laziness :)

Will fix.

- Kyle

