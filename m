Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CALCETrVzH+9cJtxTHj300jDWx7S1bLxYCGX==7zHish9J5aFAQ@mail.gmail.com>
References: <20170208080917.24320-1-khuey@kylehuey.com> <20170208080917.24320-9-khuey@kylehuey.com>
 <CALCETrVS8ch-1harGv2NUy83ZLna8Vde1zNLxPTPaxuMexQMjw@mail.gmail.com>
 <CALMp9eSyJep6UPxeiZRWPrdzwvvcqJEbPPZ6C61EeHsvdyhMLg@mail.gmail.com>
 <6F48D384-B29C-41B4-83F1-B02FC2480205@amacapital.net> <CALMp9eQDWWAgmwnzZ0iTa2w+7-d_MjyOByOdfN0MjiHzaQWyEw@mail.gmail.com>
 <CALCETrVzH+9cJtxTHj300jDWx7S1bLxYCGX==7zHish9J5aFAQ@mail.gmail.com>
From: Jim Mattson <jmattson@google.com>
Date: Fri, 27 Jul 2018 14:30:24 -0700
Message-ID: <CALMp9eQ3VOOdQpZ2=rqB1W3=RnyZXDxrqXgADsDZ0eSH_8r9tQ@mail.gmail.com>
Subject: Re: [PATCH v14 8/9] KVM: x86: virtualize cpuid faulting
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Lutomirski <luto@kernel.org>
Cc: Kyle Huey <me@kylehuey.com>, Robert O'Callahan <robert@ocallahan.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Alexander Viro <viro@zeniv.linux.org.uk>, Shuah Khan <shuah@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, Borislav Petkov <bp@suse.de>, Peter Zijlstra <peterz@infradead.org>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Len Brown <len.brown@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Dmitry Safonov <dsafonov@virtuozzo.com>, David Matlack <dmatlack@google.com>, Nadav Amit <nadav.amit@gmail.com>, Andi Kleen <andi@firstfloor.org>, LKML <linux-kernel@vger.kernel.org>, user-mode-linux-devel@lists.sourceforge.net, "open list:USER-MODE LINUX (UML)" <user-mode-linux-user@lists.sourceforge.net>, Linux FS Devel <linux-fsdevel@vger.kernel.org>, "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, kvm list <kvm@vger.kernel.org>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On Fri, Jul 27, 2018 at 2:05 PM, Andy Lutomirski <luto@kernel.org> wrote:
> Does KVM *have* a concept of "maximum non-turbo frequency" of the
> guest that it would make sense to expose here?  If so, presumably the
> right solution is to expose it.

KVM has the concept of a guest's invariant TSC frequency. The Maximum
Non-Turbo Ratio is just some fraction of that. Sadly, the fraction is
100 MHz, 133.33MHz, or the "scalable bus frequency" from some other
MSR, depending on microarchitecture.

