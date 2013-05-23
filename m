MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <20130523125033.GP18614@n2100.arm.linux.org.uk>
References: <519DCBEF.3090208@asianux.com>
	<201305231259.43750.arnd@arndb.de>
	<20130523112401.GO18614@n2100.arm.linux.org.uk>
	<201305231409.02359.arnd@arndb.de>
	<20130523125033.GP18614@n2100.arm.linux.org.uk>
Date: Thu, 23 May 2013 16:10:04 +0200
Message-ID: <CAMuHMdUzcBuDupe4Fa6XieziGPMpPKC_k8X8gUUmDvLJ+Fe=Hg@mail.gmail.com>
Subject: Re: [PATCH] arch: configuration, deleting 'CONFIG_BUG' since always
 need it.
From: Geert Uytterhoeven <geert@linux-m68k.org>
Content-Type: text/plain; charset=UTF-8
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Arnd Bergmann <arnd@arndb.de>, Chen Gang <gang.chen@asianux.com>, =?UTF-8?Q?H=C3=A5vard_Skinnemoen?= <hskinnemoen@gmail.com>, Hans-Christian Egtvedt <egtvedt@samfundet.no>, Mike Frysinger <vapier@gentoo.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, Richard Kuo <rkuo@codeaurora.org>, "James E.J. Bottomley" <jejb@parisc-linux.org>, Helge Deller <deller@gmx.de>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, "paulus@samba.org" <paulus@samba.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux390@de.ibm.com, Paul Mundt <lethal@linux-sh.org>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Thomas Gleixner <tglx@linutronix.de>, "mingo@redhat.com" <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, the arch/x86 maintainers <x86@kernel.org>, "Eric W. Biederman" <ebiederm@xmission.com>, Serge Hallyn <serge.hallyn@canonical.com>, Paul McKenney <paulmck@linux.vnet.ibm.com>, Frederic Weisbecker <fweisbec@gmail.com>, David Miller <davem@davemloft.net>, Andrew Morton <akpm@linux-foundation.org>, Akinobu Mita <akinobu.mita@gmail.com>, Catalin Marinas <Catalin.Marinas@arm.com>, Michel Lespinasse <walken@google.com>, Will Deacon <will.deacon@arm.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "uclinux-dist-devel@blackfin.uclinux.org" <uclinux-dist-devel@blackfin.uclinux.org>, linux-hexagon@vger.kernel.org, Parisc List <linux-parisc@vger.kernel.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, linux-s390@vger.kernel.org, Linux-sh list <linux-sh@vger.kernel.org>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>, uml-user <user-mode-linux-user@lists.sourceforge.net>, Linux-Arch <linux-arch@vger.kernel.org>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On Thu, May 23, 2013 at 2:50 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Thu, May 23, 2013 at 02:09:02PM +0200, Arnd Bergmann wrote:
>> On Thursday 23 May 2013, Russell King - ARM Linux wrote:
>> > This is the problem you guys are missing - unreachable() means "we lose
>> > control of the CPU at this point".
>>
>> I'm absolutely aware of this. Again, the current behaviour of doing nothing
>> at all isn't very different from undefined behavior when you get when you
>> get to the end of a function returning a pointer without a "return" statement,
>> or when you return from a function that has determined that it is not safe
>> to continue.
>
> Running off the end of a function like that is a different kettle of fish.
> The execution path is still as the compiler intends - what isn't is that
> the data returned is likely to be random trash.
>
> That's _quite_ different from the CPU starting to execute the contents
> of a literal data pool.

I agree it's best to e.g. trap and reboot.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

