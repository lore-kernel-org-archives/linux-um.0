Return-Path: <schnelle@linux.ibm.com>
Message-ID: <e5ec2e3be2e70e690bd9112bd23297d05a2993e6.camel@linux.ibm.com>
Subject: Re: [PATCH] parport_pc: Also enable driver for PCI systems
From: Niklas Schnelle <schnelle@linux.ibm.com>
Date: Mon, 14 Feb 2022 09:37:43 +0100
In-Reply-To: <CAMuHMdW-utcFzCZTgqONjxs=U662nF0=aBQu7Zi7FBQouwiA3g@mail.gmail.com>
References: <alpine.DEB.2.21.2202122313460.34636@angie.orcam.me.uk>
	 <CAMuHMdW-utcFzCZTgqONjxs=U662nF0=aBQu7Zi7FBQouwiA3g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
To: Geert Uytterhoeven <geert@linux-m68k.org>, "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc: Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>, linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org, linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, linux-um@lists.infradead.org, linux-xtensa@linux-xtensa.org, linux-kernel@vger.kernel.org
List-ID: <linux-um.lists.infradead.org>

On Mon, 2022-02-14 at 09:20 +0100, Geert Uytterhoeven wrote:
> Hi Maciej,
> 
> CC Niklas
> 
> On Sun, Feb 13, 2022 at 1:45 PM Maciej W. Rozycki <macro@orcam.me.uk> wrote:
> > Nowadays PC-style parallel ports come in the form of PCI and PCIe option
> > cards and there are some combined parallel/serial option cards as well
> > that we handle in the parport subsystem.  There is nothing in particular
> > that would prevent them from being used in any system equipped with PCI
> > or PCIe connectivity, except that we do not permit the PARPORT_PC config
> > option to be selected for platforms for which ARCH_MIGHT_HAVE_PC_PARPORT
> > has not been set for.
> > 
> > The only PCI platforms that actually can't make use of PC-style parallel
> > port hardware are those newer PCIe systems that have no support for I/O
> > cycles in the host bridge, required by such parallel ports.  An example
> > of such a host bridge is the POWER9 PHB4 device, but it is an exception
> > rather than the norm.  Also it is not clear whether the serial port side
> 
> Note that this hardware dependency is being addressed in
> "[RFC 00/32] Kconfig: Introduce HAS_IOPORT and LEGACY_PCI options"
> https://lore.kernel.org/all/20211227164317.4146918-1-schnelle@linux.ibm.com/

Thanks, for Cc'ing me. Note that this series is currently in kind of a
hold as we haven't yet found a clear direction yet. There was some
clear opposition for the LEGACY_PCI option introduced in that series
and only little support for HAS_IOPORT.

> 
> > --- linux-macro.orig/drivers/parport/Kconfig
> > +++ linux-macro/drivers/parport/Kconfig
> > @@ -42,7 +42,7 @@ if PARPORT
> > 
> >  config PARPORT_PC
> >         tristate "PC-style hardware"
> > -       depends on ARCH_MIGHT_HAVE_PC_PARPORT
> > +       depends on ARCH_MIGHT_HAVE_PC_PARPORT || PCI

This would allow selecting PARPORT_PC on s390 e.g. for allyesconfig and
randconfig and like POWER9 we definitely do not support I/O port
access.

We will also get warnings when compiling with clang. A problem my
series was originally started to address. So I'd really like to see a
better solution here for such a change. With the HAS_IOPORT option from
my series this would be simple but we don't currently have that though
maybe this is also an argument for introducing HAS_IOPORT even if we
don't add the LEGACY_PCI option.

> >         help
> >           You should say Y here if you have a PC-style parallel port. All
> >           IBM PC compatible computers and some Alphas have PC-style
> > @@ -77,7 +77,7 @@ config PARPORT_PC_FIFO
> > 
> >  config PARPORT_PC_SUPERIO
> >         bool "SuperIO chipset support"
> > -       depends on PARPORT_PC && !PARISC
> > +       depends on ARCH_MIGHT_HAVE_PC_PARPORT && PARPORT_PC && !PARISC
> >         help
> >           Saying Y here enables some probes for Super-IO chipsets in order to
> >           find out things like base addresses, IRQ lines and DMA channels.  It
> > 
> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds



