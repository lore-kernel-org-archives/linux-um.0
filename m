Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <6F48D384-B29C-41B4-83F1-B02FC2480205@amacapital.net>
References: <20170208080917.24320-1-khuey@kylehuey.com> <20170208080917.24320-9-khuey@kylehuey.com>
 <CALCETrVS8ch-1harGv2NUy83ZLna8Vde1zNLxPTPaxuMexQMjw@mail.gmail.com>
 <CALMp9eSyJep6UPxeiZRWPrdzwvvcqJEbPPZ6C61EeHsvdyhMLg@mail.gmail.com> <6F48D384-B29C-41B4-83F1-B02FC2480205@amacapital.net>
From: Jim Mattson <jmattson@google.com>
Date: Fri, 27 Jul 2018 14:03:52 -0700
Message-ID: <CALMp9eQDWWAgmwnzZ0iTa2w+7-d_MjyOByOdfN0MjiHzaQWyEw@mail.gmail.com>
Subject: Re: [PATCH v14 8/9] KVM: x86: virtualize cpuid faulting
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Lutomirski <luto@amacapital.net>
Cc: Andy Lutomirski <luto@kernel.org>, Kyle Huey <me@kylehuey.com>, Robert O'Callahan <robert@ocallahan.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Alexander Viro <viro@zeniv.linux.org.uk>, Shuah Khan <shuah@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, Borislav Petkov <bp@suse.de>, Peter Zijlstra <peterz@infradead.org>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Len Brown <len.brown@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Dmitry Safonov <dsafonov@virtuozzo.com>, David Matlack <dmatlack@google.com>, Nadav Amit <nadav.amit@gmail.com>, Andi Kleen <andi@firstfloor.org>, LKML <linux-kernel@vger.kernel.org>, user-mode-linux-devel@lists.sourceforge.net, "open list:USER-MODE LINUX (UML)" <user-mode-linux-user@lists.sourceforge.net>, Linux FS Devel <linux-fsdevel@vger.kernel.org>, "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, kvm list <kvm@vger.kernel.org>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On Fri, Jul 27, 2018 at 1:46 PM, Andy Lutomirski <luto@amacapital.net> wrot=
e:
>> On Jul 27, 2018, at 1:28 PM, Jim Mattson <jmattson@google.com> wrote:
>> Initializing this bit to zero helps with migration, but then if the
>> CPUID faulting bits in both MSRs are set, userspace has to take pains
>> to ensure that MSR_PLATFORM_INFO is restored first, or the
>> MSR_MISC_FEATURES_ENABLES value will be rejected.
>
> The code could drop the constraint and just let the entry possibly fail i=
f the MSRs are set wrong

That would be an improvement, I think.

>> I'm also concerned about the 0 in the "Maximum Non-Turbo Ratio" field
>> feeding into someone's calculated TSC frequency.
>
> Hmm. I don=E2=80=99t have a good answer to that. Are there any real CPUs =
that have this MSR but don=E2=80=99t have that field?

No. The reason I bring this up is that a customer has code that
expects to be able to derive the TSC frequency from this MSR (per
Intel's instructions in SDM volume 3, section 18.7.3), and they were
surprised to find that the MSR raises #GP on our platform. We're
looking into cherry-picking this support from upstream as a start, but
I know the customer would be unhappy to read zero from bits 15:8.

