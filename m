Return-Path: <mingo.kernel.org@gmail.com>
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Tue, 28 May 2013 10:19:10 +0200
From: Ingo Molnar <mingo@kernel.org>
Message-ID: <20130528081910.GA29557@gmail.com>
References: <519DCBEF.3090208@asianux.com>
 <20130523090534.GJ18614@n2100.arm.linux.org.uk>
 <CAMuHMdWez-j1Maa3BD7ucmzv0_zFJnChERQiHFmkCaZUzG0_AA@mail.gmail.com>
 <201305231139.38233.arnd@arndb.de>
 <20130523100409.GK18614@n2100.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20130523100409.GK18614@n2100.arm.linux.org.uk>
Subject: Re: [PATCH] arch: configuration, deleting 'CONFIG_BUG' since always
 need it.
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Arnd Bergmann <arnd@arndb.de>, Geert Uytterhoeven <geert@linux-m68k.org>, Chen Gang <gang.chen@asianux.com>, H?vard Skinnemoen <hskinnemoen@gmail.com>, Hans-Christian Egtvedt <egtvedt@samfundet.no>, Mike Frysinger <vapier@gentoo.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, Richard Kuo <rkuo@codeaurora.org>, "James E.J. Bottomley" <jejb@parisc-linux.org>, Helge Deller <deller@gmx.de>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, "paulus@samba.org" <paulus@samba.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux390@de.ibm.com, Paul Mundt <lethal@linux-sh.org>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Thomas Gleixner <tglx@linutronix.de>, "mingo@redhat.com" <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, the arch/x86 maintainers <x86@kernel.org>, "Eric W. Biederman" <ebiederm@xmission.com>, Serge Hallyn <serge.hallyn@canonical.com>, Paul McKenney <paulmck@linux.vnet.ibm.com>, Frederic Weisbecker <fweisbec@gmail.com>, David Miller <davem@davemloft.net>, Andrew Morton <akpm@linux-foundation.org>, Akinobu Mita <akinobu.mita@gmail.com>, Catalin Marinas <Catalin.Marinas@arm.com>, Michel Lespinasse <walken@google.com>, Will Deacon <will.deacon@arm.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "uclinux-dist-devel@blackfin.uclinux.org" <uclinux-dist-devel@blackfin.uclinux.org>, linux-hexagon@vger.kernel.org, Parisc List <linux-parisc@vger.kernel.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, linux-s390@vger.kernel.org, Linux-sh list <linux-sh@vger.kernel.org>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>, uml-user <user-mode-linux-user@lists.sourceforge.net>, Linux-Arch <linux-arch@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>


* Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:

> So, if you want to use this, then you should update the CONFIG_BUG text 
> to include a warning to this effect:
> 
>      Warning: if CONFIG_BUG is turned off, and control flow reaches
>      a BUG(), the system behaviour will be undefined.
> 
> so that people can make an informed choice about this, because at the
> moment:
> 
>           Disabling this option eliminates support for BUG and WARN, reducing
>           the size of your kernel image and potentially quietly ignoring
>           numerous fatal conditions. You should only consider disabling this
>           option for embedded systems with no facilities for reporting errors.
>           Just say Y.
> 
> will become completely misleading.  Turning this option off will _not_ 
> result in "quietly ignoring numerous fatal conditions".

I'm fine with adding your text as a clarification - but I think 'quietly 
ignoring fatal conditions' very much implies an undefined outcome if that 
unexpected condition does occur: the code might crash, it might corrupt 
memory or it might do some other unexpected thing.

There are many other places that do a BUG_ON() of a NULL pointer or so, or 
of a zero refcount, or a not held lock - and turning the BUG_ON() off 
makes the code unpredictable _anyway_ - even if the compiler does not 
notice an uninitialized variable.

So pretty much any weakening of BUG_ON() _will_ make the kernel more 
unpredictable.

> And I come back to one of my previous arguments - is it not better to 
> panic() if we hit one of these conditions so that the system can try to 
> do a panic-reboot rather than continue blindly into the unknown?

It will often continue blindly into the unknown even if the compiler is 
happy ...

The only difference is that it's "unpredictable" in a way not visible from 
the C code: the code won't necessarily fall through the BUG() when hitting 
that condition - although in practice it probably will.

So I think the same principle applies to it as to any other debugging 
code: it's fine to be able to turn debugging off. It's a performance 
versus kernel robustness/determinism trade-off.

Thanks,

	Ingo

