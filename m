Return-Path: <lee.jones@linaro.org>
Date: Thu, 5 Aug 2021 19:54:27 +0100
From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 1/3] arch: Export machine_restart() instances so they can
 be called from modules
Message-ID: <YQwz4xkuxvfrCnag@google.com>
References: <20210805075032.723037-1-lee.jones@linaro.org>
 <20210805075032.723037-2-lee.jones@linaro.org>
 <20210805173625.GH6719@arm.com>
 <YQww08x2whx/LIIT@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YQww08x2whx/LIIT@kroah.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Vineet Gupta <vgupta@synopsys.com>, Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, Brian Cain <bcain@codeaurora.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Michal Simek <monstr@monstr.eu>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, John Crispin <john@phrozen.org>, Ley Foon Tan <ley.foon.tan@intel.com>, Jonas Bonn <jonas@southpole.se>, Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>, Stafford Horne <shorne@gmail.com>, "James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>, Helge Deller <deller@gmx.de>, Michael Ellerman <mpe@ellerman.id.au>, Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Rich Felker <dalias@libc.org>, "David S . Miller" <davem@davemloft.net>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>, Sebastian Reichel <sre@kernel.org>, linux-snps-arc@lists.infradead.org, linux-csky@vger.kernel.org, uclinux-h8-devel@lists.sourceforge.jp, linux-hexagon@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, openrisc@lists.librecores.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-um@lists.infradead.org, linux-xtensa@linux-xtensa.org
List-ID: <linux-um.lists.infradead.org>

On Thu, 05 Aug 2021, Greg Kroah-Hartman wrote:

> On Thu, Aug 05, 2021 at 06:36:25PM +0100, Catalin Marinas wrote:
> > On Thu, Aug 05, 2021 at 08:50:30AM +0100, Lee Jones wrote:
> > > diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
> > > index b4bb67f17a2ca..cf89ce91d7145 100644
> > > --- a/arch/arm64/kernel/process.c
> > > +++ b/arch/arm64/kernel/process.c
> > > @@ -212,6 +212,7 @@ void machine_restart(char *cmd)
> > >  	printk("Reboot failed -- System halted\n");
> > >  	while (1);
> > >  }
> > > +EXPORT_SYMBOL(machine_restart);
> > 
> > Should we make this EXPORT_SYMBOL_GPL? I suppose it's not for general
> > use by out of tree drivers and it matches the other pm_power_off symbol
> > we export in this file.
> 
> Yes please.

Sure.

Thanks for the feedback.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog

