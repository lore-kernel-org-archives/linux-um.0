Return-Path: <linux+geert=linux-m68k.org@arm.linux.org.uk>
Date: Thu, 23 May 2013 11:29:34 +0100
From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Message-ID: <20130523102934.GN18614@n2100.arm.linux.org.uk>
References: <519DCBEF.3090208@asianux.com> <20130523090534.GJ18614@n2100.arm.linux.org.uk> <CAMuHMdWez-j1Maa3BD7ucmzv0_zFJnChERQiHFmkCaZUzG0_AA@mail.gmail.com> <201305231139.38233.arnd@arndb.de> <878v369fdd.fsf@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <878v369fdd.fsf@xmission.com>
Sender: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] arch: configuration, deleting 'CONFIG_BUG' since
	always need it.
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Geert Uytterhoeven <geert@linux-m68k.org>, Chen Gang <gang.chen@asianux.com>, =?iso-8859-1?Q?H=E5vard?= Skinnemoen <hskinnemoen@gmail.com>, Hans-Christian Egtvedt <egtvedt@samfundet.no>, Mike Frysinger <vapier@gentoo.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, Richard Kuo <rkuo@codeaurora.org>, "James E.J. Bottomley" <jejb@parisc-linux.org>, Helge Deller <deller@gmx.de>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, "paulus@samba.org" <paulus@samba.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux390@de.ibm.com, Paul Mundt <lethal@linux-sh.org>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Thomas Gleixner <tglx@linutronix.de>, "mingo@redhat.com" <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, the arch/x86 maintainers <x86@kernel.org>, Serge Hallyn <serge.hallyn@canonical.com>, Paul McKenney <paulmck@linux.vnet.ibm.com>, Frederic Weisbecker <fweisbec@gmail.com>, David Miller <davem@davemloft.net>, Andrew Morton <akpm@linux-foundation.org>, Akinobu Mita <akinobu.mita@gmail.com>, Catalin Marinas <Catalin.Marinas@arm.com>, Michel Lespinasse <walken@google.com>, Will Deacon <will.deacon@arm.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "uclinux-dist-devel@blackfin.uclinux.org" <uclinux-dist-devel@blackfin.uclinux.org>, linux-hexagon@vger.kernel.org, Parisc List <linux-parisc@vger.kernel.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, linux-s390@vger.kernel.org, Linux-sh list <linux-sh@vger.kernel.org>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>, uml-user <user-mode-linux-user@lists.sourceforge.net>, Linux-Arch <linux-arch@vger.kernel.org>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On Thu, May 23, 2013 at 03:09:50AM -0700, Eric W. Biederman wrote:
> Arnd Bergmann <arnd@arndb.de> writes:
> 
> > On Thursday 23 May 2013, Geert Uytterhoeven wrote:
> >> > The problem is: trying to fix that will mean the result is a larger
> >> > kernel than if you just do the usual arch-implemented thing of placing
> >> > an defined faulting instruction at the BUG() site - which defeats the
> >> > purpose of turning off CONFIG_BUG.
> >> 
> >> Is __builtin_unreachable() working well these days?
> >> 
> >
> > Hmm, I just tried the trivial patch below, which seemed to do the right thing.
> > Needs a little more investigation, but that might actually be the correct
> > solution. I thought that at some point __builtin_unreachable() was the same
> > as "do {} while (1)", but this is not the case with the gcc I was using --
> > it just tells gcc that we don't expect to ever get here.
> 
> Yes.
> 
> We already have this abstracted in compiler.h as the macro unreachable,
> so the slight modification of your patch below should handle this case.
> 
> For compilers without __builtin_unreachable() unreachable() expands to
> do {} while(1) but an infinite loop seems reasonable and preserves the
> semantics of the code, unlike the current noop that is do {} while(0).

Semantics of the code really don't come in to it if you use unreachable().
unreachable() is an effective do { } while (0) to the compiler.  It just
doesn't warn about it anymore.  It's actually worse than that - it's
permission to the compiler to just stop considering flow control at that
point and do anything it likes with the following instruction slot.

What __builtin_unreachable() means to the compiler is "we will *never*
get here".  That isn't the case for BUG() - BUG() means "we hope that
we will never get here, but we might, and if we do your data is in
grave danger."

We should either have something at that point (like a call to a function
which panics) or remove the ability to turn off CONFIG_BUG and anyone who
cares about kernel size needs to come up with a single trapping
instruction BUG() implementation.

