Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
MIME-Version: 1.0
References: <20220718004114.3925745-3-shorne@gmail.com> <mhng-3ae42214-abe0-4fad-9fa9-8f19809fa4d9@palmer-mbp2014>
 <CAL_Jsq+_5-fhXddhxG2mr-4HD_brcKZExkZqvME1yEpa6dOGGg@mail.gmail.com>
In-Reply-To: <CAL_Jsq+_5-fhXddhxG2mr-4HD_brcKZExkZqvME1yEpa6dOGGg@mail.gmail.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 22 Jul 2022 12:53:43 +0200
Message-ID: <CAK8P3a0FwLmFO6Ew6kkJv=rOGRdQ+cyXok4b1kRr1RQP499wKA@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] asm-generic: Add new pci.h and use it
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: Rob Herring <robh@kernel.org>
Cc: Palmer Dabbelt <palmer@dabbelt.com>, Stafford Horne <shorne@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>, Albert Ou <aou@eecs.berkeley.edu>, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, Bjorn Helgaas <bhelgaas@google.com>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-csky@vger.kernel.org, linux-riscv <linux-riscv@lists.infradead.org>, linux-um <linux-um@lists.infradead.org>, PCI <linux-pci@vger.kernel.org>, "open list:GENERIC INCLUDE/ASM HEADER FILES" <linux-arch@vger.kernel.org>

On Fri, Jul 22, 2022 at 1:06 AM Rob Herring <robh@kernel.org> wrote:
> On Tue, Jul 19, 2022 at 9:59 AM Palmer Dabbelt <palmer@dabbelt.com> wrote:
> > On Sun, 17 Jul 2022 17:41:14 PDT (-0700), shorne@gmail.com wrote:

> > > diff --git a/arch/riscv/include/asm/pci.h b/arch/riscv/include/asm/pci.h
> > > index 7fd52a30e605..12ce8150cfb0 100644
> > > --- a/arch/riscv/include/asm/pci.h
> > > +++ b/arch/riscv/include/asm/pci.h
> > > @@ -12,29 +12,7 @@
> > >
> > >  #include <asm/io.h>
> > >
> > > -#define PCIBIOS_MIN_IO               0
> > > -#define PCIBIOS_MIN_MEM              0
> >
> > My for-next changes these in bb356ddb78b2 ("RISC-V: PCI: Avoid handing
> > out address 0 to devices").  Do you mind either splitting out the
> > arch/riscv bits or having this in via some sort of shared tag?
>
> Shouldn't the values not matter here if the IO and mem resources are
> described in the DT (and don't use 0)? The values of 4 and 16 look
> odd.

I think it's different for the two types: For memory resources, this only
matters if the bus actually contains MMIO address zero. In most cases
the MMIO addresses are the same as the address seen by the CPU
and already nonzero based on the SoC design.

For the I/O port numbers, the port numbers tend to be more dynamic,
but you'd normally have addresses 0 through 0xffff on each PCI host
bridge with memory mapped I/O ports, so this can clearly happen.

Still, it seems better to not address the port zero issue in architecture
specific code but instead do it in the PCI core code. Ideally
we'd just use the 0x1000 minimum, which also helps stay out of
the ISA port numbers that may be used by things like
VGA or SATA adapters in legacy mode. The only reason I can
see for allowed smaller port numbers is for machines that have
a very limited I/O port window and do not have ports over
0x1000 at all.

        Arnd

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

