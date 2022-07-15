Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
References: <20220714214657.2402250-1-shorne@gmail.com> <20220714214657.2402250-3-shorne@gmail.com>
In-Reply-To: <20220714214657.2402250-3-shorne@gmail.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 15 Jul 2022 10:09:21 +0200
Message-ID: <CAK8P3a2_HKMf8nMcSkK1_jyCEHEdzz=YiRmPvN+ACbPTafXJzA@mail.gmail.com>
Subject: Re: [RFC PATCH 2/2] asm-generic: Add new pci.h and use it
Content-Type: text/plain; charset="UTF-8"
To: Stafford Horne <shorne@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, Bjorn Helgaas <bhelgaas@google.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>, linux-csky@vger.kernel.org, linux-riscv <linux-riscv@lists.infradead.org>, linux-um <linux-um@lists.infradead.org>, linux-pci <linux-pci@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, David Woodhouse <dwmw2@infradead.org>
List-ID: <linux-um.lists.infradead.org>

On Thu, Jul 14, 2022 at 11:46 PM Stafford Horne <shorne@gmail.com> wrote:
>
> The asm/pci.h used for many newer architectures share similar
> definitions.  Move the common parts to asm-generic/pci.h to allow for
> sharing code.

This looks very nice, thanks for doing it!

> Two things to note are:
>
>  - isa_dma_bridge_buggy, traditionally this is defined in asm/dma.h but
>    these architectures avoid creating that file and add the definition
>    to asm/pci.h.

I would prefer if we could just kill off this variable for non-x86, as it's
only set to a nonzero value in two implementations that are both
x86-specific and most of the references are gone. That does not have
to be part of this series though, if you don't want to address it here, just
add a comment to the new pci.h file.

>  - ARCH_GENERIC_PCI_MMAP_RESOURCE, csky does not define this so we
>    undefine it after including asm-generic/pci.h.  Why doesn't csky
>    define it?

Adding David Woodhouse to Cc, as he introduced this interface. As I
understand it, this was meant as a replacement for the old
architecture specific pci_mmap_page_range interface, and is ideally
used everywhere.

It's probably something that slipped through the review of csky and
should have been there.

As an aside, it seems the pci_mmap_page_range() cleanup was
left almost complete, with sparc being the only one left after
David Miller found a problem with the generic code. Not sure if
this was ever resolved:
https://lore.kernel.org/lkml/1519887203.622.3.camel@infradead.org/t/#u

> +#ifndef PCIBIOS_MIN_IO
> +#define PCIBIOS_MIN_IO         0
> +#endif
> +
> +#define PCIBIOS_MIN_MEM                0

We should probably #ifdef both of these for consistency.

> +static inline int pci_get_legacy_ide_irq(struct pci_dev *dev, int channel)
> +{
> +       /* no legacy ide irq support */
> +       return -ENODEV;
> +}

And this can just go away now, according to what we found.

        Arnd

