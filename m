MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <CA+55aFy=i=er6kgW+y+Ai2fxfNX2N61ZfwJeKDOr-1On90HXug@mail.gmail.com>
References: <20170311194702.28754-1-khuey@kylehuey.com>
	<20170311194702.28754-7-khuey@kylehuey.com>
	<CA+55aFxGYA_MnVnmtqfX+AW3hE-KE9Bvev65urRKCA7BgmRiOA@mail.gmail.com>
	<87shmdjx4u.fsf@concordia.ellerman.id.au>
	<CAP045ArvvVVNOLDzMp=B_1AMsRBb9n2qkChkdB7gaEscTOh4Xg@mail.gmail.com>
	<CA+55aFy=i=er6kgW+y+Ai2fxfNX2N61ZfwJeKDOr-1On90HXug@mail.gmail.com>
Date: Fri, 17 Mar 2017 08:56:07 +0100
Message-ID: <CAMuHMdUtJbLHGZr+y_pDNY=HSjCaa5if5Ma8Ps1sKwuXJB0hjw@mail.gmail.com>
Subject: Re: [PATCH v15 6/9] x86/arch_prctl: Add ARCH_[GET|SET]_CPUID
From: Geert Uytterhoeven <geert@linux-m68k.org>
Content-Type: text/plain; charset=UTF-8
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Kyle Huey <me@kylehuey.com>, Michael Ellerman <mpe@ellerman.id.au>, Robert O'Callahan <robert@ocallahan.org>, Thomas Gleixner <tglx@linutronix.de>, Andy Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, the arch/x86 maintainers <x86@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Alexander Viro <viro@zeniv.linux.org.uk>, Shuah Khan <shuah@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, Borislav Petkov <bp@suse.de>, Peter Zijlstra <peterz@infradead.org>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Len Brown <len.brown@intel.com>, Dmitry Safonov <dsafonov@virtuozzo.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, David Matlack <dmatlack@google.com>, Nadav Amit <nadav.amit@gmail.com>, Andi Kleen <andi@firstfloor.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>, "open list:USER-MODE LINUX (UML)" <user-mode-linux-user@lists.sourceforge.net>, "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, KVM list <kvm@vger.kernel.org>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

Hi Linus,

On Thu, Mar 16, 2017 at 7:23 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Thu, Mar 16, 2017 at 7:30 AM, Kyle Huey <me@kylehuey.com> wrote:
>> On Thu, Mar 16, 2017 at 4:09 AM, Michael Ellerman <mpe@ellerman.id.au> wrote:
>>>
>>> Presumably he's done:
>>>
>>> $ git config diff.context 8
>>
>> Indeed.  In my case it dates back to my days hacking on Firefox, which
>> wants 8 lines of context for patches.  I'll remove it.
>
> You can make those kinds of options per-repository rather than
> user-global, so you can keep the 8-line thing for firefox without
> having it for the kernel.
>
> Not that it *hurts* for the kernel, but it just looked odd to me
> because the patch looked so much bigger. More context lines can
> obviously help with ambiguous cases, but we very seldom have that kind
> of ambiguity.

Having a larger default for DTS source files could be a good idea, though.
I regularly use -U10 to verify DTS patches were applied correctly.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

