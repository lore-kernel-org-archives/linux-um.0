Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oDpcQ-00AKXl-Ev
	for linux-um@lists.infradead.org; Tue, 19 Jul 2022 15:58:48 +0000
Received: by mail-pj1-x1036.google.com with SMTP id bk6-20020a17090b080600b001f2138a2a7bso422886pjb.1
        for <linux-um@lists.infradead.org>; Tue, 19 Jul 2022 08:58:40 -0700 (PDT)
Date: Tue, 19 Jul 2022 08:58:39 -0700 (PDT)
Subject: Re: [PATCH v3 2/2] asm-generic: Add new pci.h and use it
In-Reply-To: <20220718004114.3925745-3-shorne@gmail.com>
From: Palmer Dabbelt <palmer@dabbelt.com>
Message-ID: <mhng-3ae42214-abe0-4fad-9fa9-8f19809fa4d9@palmer-mbp2014>
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
Cc: linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, shorne@gmail.com, catalin.marinas@arm.com, Will Deacon <will@kernel.org>, guoren@kernel.org, Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu, richard@nod.at, anton.ivanov@cambridgegreys.com, johannes@sipsolutions.net, bhelgaas@google.com, linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org, linux-riscv@lists.infradead.org, linux-um@lists.infradead.org, linux-pci@vger.kernel.org, linux-arch@vger.kernel.org

On Sun, 17 Jul 2022 17:41:14 PDT (-0700), shorne@gmail.com wrote:
> The asm/pci.h used for many newer architectures share similar
> definitions.  Move the common parts to asm-generic/pci.h to allow for
> sharing code.
>
> Two things to note are:
>
>  - isa_dma_bridge_buggy, traditionally this is defined in asm/dma.h but
>    these architectures avoid creating that file and add the definition
>    to asm/pci.h.
>  - ARCH_GENERIC_PCI_MMAP_RESOURCE, csky does not define this so we
>    undefine it after including asm-generic/pci.h.  Why doesn't csky
>    define it?
>  - pci_get_legacy_ide_irq, This function is only used on architectures
>    that support PNP.  It is only maintained for arm64, in other
>    architectures it is removed.
>
> Suggested-by: Arnd Bergmann <arnd@arndb.de>
> Link: https://lore.kernel.org/lkml/CAK8P3a0JmPeczfmMBE__vn=Jbvf=nkbpVaZCycyv40pZNCJJXQ@mail.gmail.com/
> Signed-off-by: Stafford Horne <shorne@gmail.com>
> ---
> Second note on isa_dma_bridge_buggy, this is set on x86 but it it also set in
> pci/quirks.c.  We discussed limiting it only to x86 though as its a general
> quick triggered by pci ids I think it will be more tricky than we thought so I
> will leave as is.  It might be nice to move it out of asm/dma.h and into
> asm/pci.h though.
>
> Since v2:
>  - Nothing
> Since v1:
>  - Remove definition of pci_get_legacy_ide_irq
>
>  arch/arm64/include/asm/pci.h | 12 +++---------
>  arch/csky/include/asm/pci.h  | 24 ++++--------------------
>  arch/riscv/include/asm/pci.h | 25 +++----------------------
>  arch/um/include/asm/pci.h    | 24 ++----------------------
>  include/asm-generic/pci.h    | 36 ++++++++++++++++++++++++++++++++++++
>  5 files changed, 48 insertions(+), 73 deletions(-)
>  create mode 100644 include/asm-generic/pci.h
>
> diff --git a/arch/arm64/include/asm/pci.h b/arch/arm64/include/asm/pci.h
> index b33ca260e3c9..1180e83712f5 100644
> --- a/arch/arm64/include/asm/pci.h
> +++ b/arch/arm64/include/asm/pci.h
> @@ -9,7 +9,6 @@
>  #include <asm/io.h>
>
>  #define PCIBIOS_MIN_IO		0x1000
> -#define PCIBIOS_MIN_MEM		0
>
>  /*
>   * Set to 1 if the kernel should re-assign all PCI bus numbers
> @@ -18,9 +17,6 @@
>  	(pci_has_flag(PCI_REASSIGN_ALL_BUS))
>
>  #define arch_can_pci_mmap_wc() 1
> -#define ARCH_GENERIC_PCI_MMAP_RESOURCE	1
> -
> -extern int isa_dma_bridge_buggy;
>
>  #ifdef CONFIG_PCI
>  static inline int pci_get_legacy_ide_irq(struct pci_dev *dev, int channel)
> @@ -28,11 +24,9 @@ static inline int pci_get_legacy_ide_irq(struct pci_dev *dev, int channel)
>  	/* no legacy IRQ on arm64 */
>  	return -ENODEV;
>  }
> -
> -static inline int pci_proc_domain(struct pci_bus *bus)
> -{
> -	return 1;
> -}
>  #endif  /* CONFIG_PCI */
>
> +/* Generic PCI */
> +#include <asm-generic/pci.h>
> +
>  #endif  /* __ASM_PCI_H */
> diff --git a/arch/csky/include/asm/pci.h b/arch/csky/include/asm/pci.h
> index ebc765b1f78b..44866c1ad461 100644
> --- a/arch/csky/include/asm/pci.h
> +++ b/arch/csky/include/asm/pci.h
> @@ -9,26 +9,10 @@
>
>  #include <asm/io.h>
>
> -#define PCIBIOS_MIN_IO		0
> -#define PCIBIOS_MIN_MEM		0
> +/* Generic PCI */
> +#include <asm-generic/pci.h>
>
> -/* C-SKY shim does not initialize PCI bus */
> -#define pcibios_assign_all_busses() 1
> -
> -extern int isa_dma_bridge_buggy;
> -
> -#ifdef CONFIG_PCI
> -static inline int pci_get_legacy_ide_irq(struct pci_dev *dev, int channel)
> -{
> -	/* no legacy IRQ on csky */
> -	return -ENODEV;
> -}
> -
> -static inline int pci_proc_domain(struct pci_bus *bus)
> -{
> -	/* always show the domain in /proc */
> -	return 1;
> -}
> -#endif  /* CONFIG_PCI */
> +/* csky doesn't use generic pci resource mapping */
> +#undef ARCH_GENERIC_PCI_MMAP_RESOURCE
>
>  #endif  /* __ASM_CSKY_PCI_H */
> diff --git a/arch/riscv/include/asm/pci.h b/arch/riscv/include/asm/pci.h
> index 7fd52a30e605..12ce8150cfb0 100644
> --- a/arch/riscv/include/asm/pci.h
> +++ b/arch/riscv/include/asm/pci.h
> @@ -12,29 +12,7 @@
>
>  #include <asm/io.h>
>
> -#define PCIBIOS_MIN_IO		0
> -#define PCIBIOS_MIN_MEM		0

My for-next changes these in bb356ddb78b2 ("RISC-V: PCI: Avoid handing 
out address 0 to devices").  Do you mind either splitting out the 
arch/riscv bits or having this in via some sort of shared tag?

> -
> -/* RISC-V shim does not initialize PCI bus */
> -#define pcibios_assign_all_busses() 1
> -
> -#define ARCH_GENERIC_PCI_MMAP_RESOURCE 1
> -
> -extern int isa_dma_bridge_buggy;
> -
>  #ifdef CONFIG_PCI
> -static inline int pci_get_legacy_ide_irq(struct pci_dev *dev, int channel)
> -{
> -	/* no legacy IRQ on risc-v */
> -	return -ENODEV;
> -}
> -
> -static inline int pci_proc_domain(struct pci_bus *bus)
> -{
> -	/* always show the domain in /proc */
> -	return 1;
> -}
> -
>  #ifdef	CONFIG_NUMA
>
>  static inline int pcibus_to_node(struct pci_bus *bus)
> @@ -50,4 +28,7 @@ static inline int pcibus_to_node(struct pci_bus *bus)
>
>  #endif  /* CONFIG_PCI */
>
> +/* Generic PCI */
> +#include <asm-generic/pci.h>
> +
>  #endif  /* _ASM_RISCV_PCI_H */
> diff --git a/arch/um/include/asm/pci.h b/arch/um/include/asm/pci.h
> index da13fd5519ef..34fe4921b5fa 100644
> --- a/arch/um/include/asm/pci.h
> +++ b/arch/um/include/asm/pci.h
> @@ -4,28 +4,8 @@
>  #include <linux/types.h>
>  #include <asm/io.h>
>
> -#define PCIBIOS_MIN_IO		0
> -#define PCIBIOS_MIN_MEM		0
> -
> -#define pcibios_assign_all_busses() 1
> -
> -extern int isa_dma_bridge_buggy;
> -
> -#ifdef CONFIG_PCI
> -static inline int pci_get_legacy_ide_irq(struct pci_dev *dev, int channel)
> -{
> -	/* no legacy IRQs */
> -	return -ENODEV;
> -}
> -#endif
> -
> -#ifdef CONFIG_PCI_DOMAINS
> -static inline int pci_proc_domain(struct pci_bus *bus)
> -{
> -	/* always show the domain in /proc */
> -	return 1;
> -}
> -#endif  /* CONFIG_PCI */
> +/* Generic PCI */
> +#include <asm-generic/pci.h>
>
>  #ifdef CONFIG_PCI_MSI_IRQ_DOMAIN
>  /*
> diff --git a/include/asm-generic/pci.h b/include/asm-generic/pci.h
> new file mode 100644
> index 000000000000..fbc25741696a
> --- /dev/null
> +++ b/include/asm-generic/pci.h
> @@ -0,0 +1,36 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +
> +#ifndef __ASM_GENERIC_PCI_H
> +#define __ASM_GENERIC_PCI_H
> +
> +#include <linux/types.h>
> +
> +#ifndef PCIBIOS_MIN_IO
> +#define PCIBIOS_MIN_IO		0
> +#endif
> +
> +#ifndef PCIBIOS_MIN_MEM
> +#define PCIBIOS_MIN_MEM		0
> +#endif
> +
> +#ifndef pcibios_assign_all_busses
> +/* For bootloaders that do not initialize the PCI bus */
> +#define pcibios_assign_all_busses() 1
> +#endif
> +
> +extern int isa_dma_bridge_buggy;
> +
> +/* Enable generic resource mapping code in drivers/pci/ */
> +#define ARCH_GENERIC_PCI_MMAP_RESOURCE
> +
> +#ifdef CONFIG_PCI
> +
> +static inline int pci_proc_domain(struct pci_bus *bus)
> +{
> +	/* always show the domain in /proc */
> +	return 1;
> +}
> +
> +#endif /* CONFIG_PCI */
> +
> +#endif /* __ASM_GENERIC_PCI_H */

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

