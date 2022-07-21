Return-Path: <shorne@gmail.com>
Date: Fri, 22 Jul 2022 06:58:43 +0900
From: Stafford Horne <shorne@gmail.com>
Subject: Re: [PATCH v5 4/4] asm-generic: Add new pci.h and use it
Message-ID: <YtnMEwh3U3Ng9q4a@antec>
References: <20220721134924.596152-5-shorne@gmail.com>
 <20220721173733.GA1731649@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220721173733.GA1731649@bhelgaas>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Pierre Morel <pmorel@linux.ibm.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, Bjorn Helgaas <bhelgaas@google.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org, linux-riscv@lists.infradead.org, linux-um@lists.infradead.org, linux-pci@vger.kernel.org, linux-arch@vger.kernel.org
List-ID: <linux-um.lists.infradead.org>

On Thu, Jul 21, 2022 at 12:37:33PM -0500, Bjorn Helgaas wrote:
> On Thu, Jul 21, 2022 at 10:49:24PM +0900, Stafford Horne wrote:
> > The asm/pci.h used for many newer architectures share similar
> > definitions.  Move the common parts to asm-generic/pci.h to allow for
> > sharing code.
> > 
> > Suggested-by: Arnd Bergmann <arnd@arndb.de>
> > Link: https://lore.kernel.org/lkml/CAK8P3a0JmPeczfmMBE__vn=Jbvf=nkbpVaZCycyv40pZNCJJXQ@mail.gmail.com/
> > Acked-by: Pierre Morel <pmorel@linux.ibm.com>
> > Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
> > Reviewed-by: Arnd Bergmann <arnd@arndb.de>
> > Signed-off-by: Stafford Horne <shorne@gmail.com>
> > ---
> > Since v4:
> >  - Add reviewed-by
> > 
> >  arch/arm64/include/asm/pci.h | 10 ++--------
> >  arch/csky/include/asm/pci.h  | 17 ++---------------
> >  arch/riscv/include/asm/pci.h | 23 ++++-------------------
> >  arch/um/include/asm/pci.h    | 14 ++------------
> >  include/asm-generic/pci.h    | 32 ++++++++++++++++++++++++++++++++
> >  5 files changed, 42 insertions(+), 54 deletions(-)
> >  create mode 100644 include/asm-generic/pci.h
> 
> > +++ b/include/asm-generic/pci.h
> > @@ -0,0 +1,32 @@
> > +/* SPDX-License-Identifier: GPL-2.0-only */
> > +
> > +#ifndef __ASM_GENERIC_PCI_H
> > +#define __ASM_GENERIC_PCI_H
> > +
> > +#include <linux/types.h>
> 
> Do we need <linux/types.h> here?  I don't see anything below that
> depends on it.

Thanks, you are right, I think some of the earlier functions may have needed it,
which is why I had it earlier.  But now that we have removed those we should be
able to remove this.

That said, I think some of the architecture includes could also be removed.  On
OpenRISC we are able to get away with only having the global asm-generic/pci.h
so we don't need a wrapper pci.h header at all.

However, I don't have everything setup to build all of those architectures so I
was being a bit conservative to remove headers.  I'll see what I can do in the
next version.

-Stafford

> > +#ifndef PCIBIOS_MIN_IO
> > +#define PCIBIOS_MIN_IO		0
> > +#endif
> > +
> > +#ifndef PCIBIOS_MIN_MEM
> > +#define PCIBIOS_MIN_MEM		0
> > +#endif
> > +
> > +#ifndef pcibios_assign_all_busses
> > +/* For bootloaders that do not initialize the PCI bus */
> > +#define pcibios_assign_all_busses() 1
> > +#endif
> > +
> > +/* Enable generic resource mapping code in drivers/pci/ */
> > +#define ARCH_GENERIC_PCI_MMAP_RESOURCE
> > +
> > +#ifdef CONFIG_PCI_DOMAINS
> > +static inline int pci_proc_domain(struct pci_bus *bus)
> > +{
> > +	/* always show the domain in /proc */
> > +	return 1;
> > +}
> > +#endif /* CONFIG_PCI_DOMAINS */
> > +
> > +#endif /* __ASM_GENERIC_PCI_H */
> > -- 
> > 2.36.1
> > 
> > 
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

