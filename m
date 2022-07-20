Return-Path: <arnd@arndb.de>
MIME-Version: 1.0
References: <20220720131934.373932-1-shorne@gmail.com> <20220720131934.373932-4-shorne@gmail.com>
In-Reply-To: <20220720131934.373932-4-shorne@gmail.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 20 Jul 2022 17:12:27 +0200
Message-ID: <CAK8P3a1DMqdeawhjwCRd1W145J-NSr5c9B_waqsddGw3X_oZ_g@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] asm-generic: Add new pci.h and use it
Content-Type: text/plain; charset="UTF-8"
To: Stafford Horne <shorne@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Pierre Morel <pmorel@linux.ibm.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, Bjorn Helgaas <bhelgaas@google.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>, linux-csky@vger.kernel.org, linux-riscv <linux-riscv@lists.infradead.org>, linux-um <linux-um@lists.infradead.org>, linux-pci <linux-pci@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>
List-ID: <linux-um.lists.infradead.org>

On Wed, Jul 20, 2022 at 3:19 PM Stafford Horne <shorne@gmail.com> wrote:
>
> The asm/pci.h used for many newer architectures share similar
> definitions.  Move the common parts to asm-generic/pci.h to allow for
> sharing code.
>
> One thing to note:
>
>  - ARCH_GENERIC_PCI_MMAP_RESOURCE, csky does not define this so we
>    undefine it after including asm-generic/pci.h.  Why doesn't csky
>    define it?

If you want to resolve this, I think the easiest way is to add a patch
that sets this
in csky, I'm quite sure this was just a mistake on their end.

> Suggested-by: Arnd Bergmann <arnd@arndb.de>
> Link: https://lore.kernel.org/lkml/CAK8P3a0JmPeczfmMBE__vn=Jbvf=nkbpVaZCycyv40pZNCJJXQ@mail.gmail.com/
> Acked-by: Pierre Morel <pmorel@linux.ibm.com>
> Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Signed-off-by: Stafford Horne <shorne@gmail.com>

Either way:

Reviewed-by: Arnd Bergmann <arnd@arndb.de>

