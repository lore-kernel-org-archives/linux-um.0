Return-Path: <schnelle@linux.ibm.com>
Message-ID: <6caad65b6229e8e01ce4e125a40f8c1ad2007d39.camel@linux.ibm.com>
Subject: Re: [PATCH] parport_pc: Also enable driver for PCI systems
From: Niklas Schnelle <schnelle@linux.ibm.com>
Date: Mon, 14 Feb 2022 10:53:13 +0100
In-Reply-To: <alpine.DEB.2.21.2202140917540.34636@angie.orcam.me.uk>
References: <alpine.DEB.2.21.2202122313460.34636@angie.orcam.me.uk>
	 <CAMuHMdW-utcFzCZTgqONjxs=U662nF0=aBQu7Zi7FBQouwiA3g@mail.gmail.com>
	 <e5ec2e3be2e70e690bd9112bd23297d05a2993e6.camel@linux.ibm.com>
	 <alpine.DEB.2.21.2202140917540.34636@angie.orcam.me.uk>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
To: "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>, linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org, linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, linux-um@lists.infradead.org, linux-xtensa@linux-xtensa.org, linux-kernel@vger.kernel.org
List-ID: <linux-um.lists.infradead.org>

On Mon, 2022-02-14 at 09:21 +0000, Maciej W. Rozycki wrote:
> On Mon, 14 Feb 2022, Niklas Schnelle wrote:
> 
> > > > --- linux-macro.orig/drivers/parport/Kconfig
> > > > +++ linux-macro/drivers/parport/Kconfig
> > > > @@ -42,7 +42,7 @@ if PARPORT
> > > > 
> > > >  config PARPORT_PC
> > > >         tristate "PC-style hardware"
> > > > -       depends on ARCH_MIGHT_HAVE_PC_PARPORT
> > > > +       depends on ARCH_MIGHT_HAVE_PC_PARPORT || PCI
> > 
> > This would allow selecting PARPORT_PC on s390 e.g. for allyesconfig and
> > randconfig and like POWER9 we definitely do not support I/O port
> > access.
> 
>  I guess we'll have to stop it with !S390 then short-term.  I don't think 
> an issue with s390 should be blocking all the other platforms that can use 
> these drivers just fine.  I'll post v2 with that installed if you agree.
> 
>   Maciej

Though a bit ugly that sounds fine by me. Thanks.



