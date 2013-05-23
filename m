MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <20130523090534.GJ18614@n2100.arm.linux.org.uk>
References: <519DCBEF.3090208@asianux.com>
	<CAMuHMdU7QuzgmWCH145p8PVebBzPo8DBAvbY+0AZa2cmGXmRHw@mail.gmail.com>
	<20130523090534.GJ18614@n2100.arm.linux.org.uk>
Date: Thu, 23 May 2013 11:12:56 +0200
Message-ID: <CAMuHMdWez-j1Maa3BD7ucmzv0_zFJnChERQiHFmkCaZUzG0_AA@mail.gmail.com>
Subject: Re: [PATCH] arch: configuration, deleting 'CONFIG_BUG' since always
 need it.
From: Geert Uytterhoeven <geert@linux-m68k.org>
Content-Type: text/plain; charset=UTF-8
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Chen Gang <gang.chen@asianux.com>, =?UTF-8?Q?H=C3=A5vard_Skinnemoen?= <hskinnemoen@gmail.com>, Hans-Christian Egtvedt <egtvedt@samfundet.no>, Mike Frysinger <vapier@gentoo.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, Richard Kuo <rkuo@codeaurora.org>, "James E.J. Bottomley" <jejb@parisc-linux.org>, Helge Deller <deller@gmx.de>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, "paulus@samba.org" <paulus@samba.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux390@de.ibm.com, Paul Mundt <lethal@linux-sh.org>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Thomas Gleixner <tglx@linutronix.de>, "mingo@redhat.com" <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, the arch/x86 maintainers <x86@kernel.org>, Arnd Bergmann <arnd@arndb.de>, "Eric W. Biederman" <ebiederm@xmission.com>, Serge Hallyn <serge.hallyn@canonical.com>, Paul McKenney <paulmck@linux.vnet.ibm.com>, Frederic Weisbecker <fweisbec@gmail.com>, David Miller <davem@davemloft.net>, Andrew Morton <akpm@linux-foundation.org>, Akinobu Mita <akinobu.mita@gmail.com>, Catalin Marinas <Catalin.Marinas@arm.com>, Michel Lespinasse <walken@google.com>, Will Deacon <will.deacon@arm.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "uclinux-dist-devel@blackfin.uclinux.org" <uclinux-dist-devel@blackfin.uclinux.org>, linux-hexagon@vger.kernel.org, Parisc List <linux-parisc@vger.kernel.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, linux-s390@vger.kernel.org, Linux-sh list <linux-sh@vger.kernel.org>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>, uml-user <user-mode-linux-user@lists.sourceforge.net>, Linux-Arch <linux-arch@vger.kernel.org>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On Thu, May 23, 2013 at 11:05 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Thu, May 23, 2013 at 10:40:29AM +0200, Geert Uytterhoeven wrote:
>> On Thu, May 23, 2013 at 9:57 AM, Chen Gang <gang.chen@asianux.com> wrote:
>> > -config BUG
>> > -       bool "BUG() support" if EXPERT
>> > -       default y
>> > -       help
>> > -          Disabling this option eliminates support for BUG and WARN, reducing
>> > -          the size of your kernel image and potentially quietly ignoring
>> > -          numerous fatal conditions. You should only consider disabling this
>> > -          option for embedded systems with no facilities for reporting errors.
>> > -          Just say Y.
>>
>> ... It's about reducing memory size on devices where you can't show bug or
>> warning messages.
>
> And turning off CONFIG_BUG causes lots of warning messages at compile time
> about functions which are returning nothing which shouldn't.
>
> The problem is: trying to fix that _will_ mean the result is a larger
> kernel than if you just do the usual arch-implemented thing of placing
> an defined faulting instruction at the BUG() site - which defeats the
> purpose of turning off CONFIG_BUG.

Is __builtin_unreachable() working well these days?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

