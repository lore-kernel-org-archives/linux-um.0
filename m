Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oEuYx-007Mvu-Tm
	for linux-um@lists.infradead.org; Fri, 22 Jul 2022 15:27:38 +0000
Received: by mail-pf1-x434.google.com with SMTP id b9so4724569pfp.10
        for <linux-um@lists.infradead.org>; Fri, 22 Jul 2022 08:27:32 -0700 (PDT)
Date: Fri, 22 Jul 2022 08:27:31 -0700 (PDT)
Subject: Re: [PATCH v3 2/2] asm-generic: Add new pci.h and use it
In-Reply-To: <CAL_Jsq+_5-fhXddhxG2mr-4HD_brcKZExkZqvME1yEpa6dOGGg@mail.gmail.com>
From: Palmer Dabbelt <palmer@dabbelt.com>
Message-ID: <mhng-7e3146ca-79b8-4e16-98a9-e354fb6d03ba@palmer-mbp2014>
Mime-Version: 1.0 (MHng)
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: Rob Herring <robh@kernel.org>, bhelgaas@google.com, macro@orcam.me.uk
Cc: shorne@gmail.com, linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, catalin.marinas@arm.com, Will Deacon <will@kernel.org>, guoren@kernel.org, Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu, richard@nod.at, anton.ivanov@cambridgegreys.com, johannes@sipsolutions.net, linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org, linux-riscv@lists.infradead.org, linux-um@lists.infradead.org, linux-pci@vger.kernel.org, linux-arch@vger.kernel.org

On Thu, 21 Jul 2022 16:06:52 PDT (-0700), Rob Herring wrote:
> On Tue, Jul 19, 2022 at 9:59 AM Palmer Dabbelt <palmer@dabbelt.com> wrote:
>>
>> On Sun, 17 Jul 2022 17:41:14 PDT (-0700), shorne@gmail.com wrote:
>> > The asm/pci.h used for many newer architectures share similar
>> > definitions.  Move the common parts to asm-generic/pci.h to allow for
>> > sharing code.
>> >
>> > Two things to note are:
>> >
>> >  - isa_dma_bridge_buggy, traditionally this is defined in asm/dma.h but
>> >    these architectures avoid creating that file and add the definition
>> >    to asm/pci.h.
>> >  - ARCH_GENERIC_PCI_MMAP_RESOURCE, csky does not define this so we
>> >    undefine it after including asm-generic/pci.h.  Why doesn't csky
>> >    define it?
>> >  - pci_get_legacy_ide_irq, This function is only used on architectures
>> >    that support PNP.  It is only maintained for arm64, in other
>> >    architectures it is removed.
>> >
>> > Suggested-by: Arnd Bergmann <arnd@arndb.de>
>> > Link: https://lore.kernel.org/lkml/CAK8P3a0JmPeczfmMBE__vn=Jbvf=nkbpVaZCycyv40pZNCJJXQ@mail.gmail.com/
>> > Signed-off-by: Stafford Horne <shorne@gmail.com>
>> > ---
>> > Second note on isa_dma_bridge_buggy, this is set on x86 but it it also set in
>> > pci/quirks.c.  We discussed limiting it only to x86 though as its a general
>> > quick triggered by pci ids I think it will be more tricky than we thought so I
>> > will leave as is.  It might be nice to move it out of asm/dma.h and into
>> > asm/pci.h though.
>> >
>> > Since v2:
>> >  - Nothing
>> > Since v1:
>> >  - Remove definition of pci_get_legacy_ide_irq
>> >
>> >  arch/arm64/include/asm/pci.h | 12 +++---------
>> >  arch/csky/include/asm/pci.h  | 24 ++++--------------------
>> >  arch/riscv/include/asm/pci.h | 25 +++----------------------
>> >  arch/um/include/asm/pci.h    | 24 ++----------------------
>> >  include/asm-generic/pci.h    | 36 ++++++++++++++++++++++++++++++++++++
>> >  5 files changed, 48 insertions(+), 73 deletions(-)
>> >  create mode 100644 include/asm-generic/pci.h
>> >
>> > diff --git a/arch/arm64/include/asm/pci.h b/arch/arm64/include/asm/pci.h
>> > index b33ca260e3c9..1180e83712f5 100644
>> > --- a/arch/arm64/include/asm/pci.h
>> > +++ b/arch/arm64/include/asm/pci.h
>> > @@ -9,7 +9,6 @@
>> >  #include <asm/io.h>
>> >
>> >  #define PCIBIOS_MIN_IO               0x1000
>> > -#define PCIBIOS_MIN_MEM              0
>> >
>> >  /*
>> >   * Set to 1 if the kernel should re-assign all PCI bus numbers
>> > @@ -18,9 +17,6 @@
>> >       (pci_has_flag(PCI_REASSIGN_ALL_BUS))
>> >
>> >  #define arch_can_pci_mmap_wc() 1
>> > -#define ARCH_GENERIC_PCI_MMAP_RESOURCE       1
>> > -
>> > -extern int isa_dma_bridge_buggy;
>> >
>> >  #ifdef CONFIG_PCI
>> >  static inline int pci_get_legacy_ide_irq(struct pci_dev *dev, int channel)
>> > @@ -28,11 +24,9 @@ static inline int pci_get_legacy_ide_irq(struct pci_dev *dev, int channel)
>> >       /* no legacy IRQ on arm64 */
>> >       return -ENODEV;
>> >  }
>> > -
>> > -static inline int pci_proc_domain(struct pci_bus *bus)
>> > -{
>> > -     return 1;
>> > -}
>> >  #endif  /* CONFIG_PCI */
>> >
>> > +/* Generic PCI */
>> > +#include <asm-generic/pci.h>
>> > +
>> >  #endif  /* __ASM_PCI_H */
>> > diff --git a/arch/csky/include/asm/pci.h b/arch/csky/include/asm/pci.h
>> > index ebc765b1f78b..44866c1ad461 100644
>> > --- a/arch/csky/include/asm/pci.h
>> > +++ b/arch/csky/include/asm/pci.h
>> > @@ -9,26 +9,10 @@
>> >
>> >  #include <asm/io.h>
>> >
>> > -#define PCIBIOS_MIN_IO               0
>> > -#define PCIBIOS_MIN_MEM              0
>> > +/* Generic PCI */
>> > +#include <asm-generic/pci.h>
>> >
>> > -/* C-SKY shim does not initialize PCI bus */
>> > -#define pcibios_assign_all_busses() 1
>> > -
>> > -extern int isa_dma_bridge_buggy;
>> > -
>> > -#ifdef CONFIG_PCI
>> > -static inline int pci_get_legacy_ide_irq(struct pci_dev *dev, int channel)
>> > -{
>> > -     /* no legacy IRQ on csky */
>> > -     return -ENODEV;
>> > -}
>> > -
>> > -static inline int pci_proc_domain(struct pci_bus *bus)
>> > -{
>> > -     /* always show the domain in /proc */
>> > -     return 1;
>> > -}
>> > -#endif  /* CONFIG_PCI */
>> > +/* csky doesn't use generic pci resource mapping */
>> > +#undef ARCH_GENERIC_PCI_MMAP_RESOURCE
>> >
>> >  #endif  /* __ASM_CSKY_PCI_H */
>> > diff --git a/arch/riscv/include/asm/pci.h b/arch/riscv/include/asm/pci.h
>> > index 7fd52a30e605..12ce8150cfb0 100644
>> > --- a/arch/riscv/include/asm/pci.h
>> > +++ b/arch/riscv/include/asm/pci.h
>> > @@ -12,29 +12,7 @@
>> >
>> >  #include <asm/io.h>
>> >
>> > -#define PCIBIOS_MIN_IO               0
>> > -#define PCIBIOS_MIN_MEM              0
>>
>> My for-next changes these in bb356ddb78b2 ("RISC-V: PCI: Avoid handing
>> out address 0 to devices").  Do you mind either splitting out the
>> arch/riscv bits or having this in via some sort of shared tag?
>
> Shouldn't the values not matter here if the IO and mem resources are
> described in the DT (and don't use 0)? The values of 4 and 16 look
> odd.

The linked thread has a fairly long discussion 
<https://lore.kernel.org/all/alpine.DEB.2.21.2202260044180.25061@angie.orcam.me.uk/>.  
I agree it's odd to have this in arch code: "don't hand out address 0" 
isn't really a RISC-V constraint (ie, we don't have architecture-defined 
limitations on these address spaces) but a constraint that comes from 
the generic port I/O functions and some other related PCI/resource code 
where the value 0 is a sentinel.

Maybe the right thing to do here is actually to make the default 
definitions of these macros non-zero, or to add some sort of ARCH_ 
flavor of them and move that non-zero requirement closer to where it 
comes from?  From the look of it any port that uses the generic port I/O 
functions and has 0 for these will be broken in the same way.

That said, I'm not really a PCI guy so maybe Bjorn or Maciej has a 
better idea?

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

