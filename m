Return-Path: <helgaas@kernel.org>
Date: Wed, 20 Jul 2022 17:42:38 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: [PATCH v4 3/3] asm-generic: Add new pci.h and use it
Message-ID: <20220720224238.GA1666095@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220720131934.373932-4-shorne@gmail.com>
To: Stafford Horne <shorne@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Pierre Morel <pmorel@linux.ibm.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, Bjorn Helgaas <bhelgaas@google.com>, linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org, linux-riscv@lists.infradead.org, linux-um@lists.infradead.org, linux-pci@vger.kernel.org, linux-arch@vger.kernel.org
List-ID: <linux-um.lists.infradead.org>

On Wed, Jul 20, 2022 at 10:19:34PM +0900, Stafford Horne wrote:
> The asm/pci.h used for many newer architectures share similar
> definitions.  Move the common parts to asm-generic/pci.h to allow for
> sharing code.
> 
> One thing to note:
> 
>  - ARCH_GENERIC_PCI_MMAP_RESOURCE, csky does not define this so we
>    undefine it after including asm-generic/pci.h.  Why doesn't csky
>    define it?
> 
> Suggested-by: Arnd Bergmann <arnd@arndb.de>
> Link: https://lore.kernel.org/lkml/CAK8P3a0JmPeczfmMBE__vn=Jbvf=nkbpVaZCycyv40pZNCJJXQ@mail.gmail.com/
> Acked-by: Pierre Morel <pmorel@linux.ibm.com>
> Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Signed-off-by: Stafford Horne <shorne@gmail.com>

> diff --git a/arch/arm64/include/asm/pci.h b/arch/arm64/include/asm/pci.h
> index 0aebc3488c32..016eb6b46dc0 100644
> --- a/arch/arm64/include/asm/pci.h
> +++ b/arch/arm64/include/asm/pci.h

> -extern int isa_dma_bridge_buggy;

Shouldn't this go in the previous patch?  The only definition of a
isa_dma_bridge_buggy variable is in drivers/pci/pci.c, and it's under
#ifdef CONFIG_X86_32.

Same for csky, riscv, um?

