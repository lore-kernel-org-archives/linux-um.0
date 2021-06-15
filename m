MIME-Version: 1.0
Date: Tue, 15 Jun 2021 13:41:53 +0200
References: <20210615110859.320299-1-aneesh.kumar@linux.ibm.com>
In-Reply-To: <20210615110859.320299-1-aneesh.kumar@linux.ibm.com>
Message-ID: <CAMuHMdVdG10w4mUP_nLpPkDCP-tb3waPg_AOSJPch9b7AsLGsw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] mm: rename pud_page_vaddr to pud_pgtable and make
 it return pmd_t *
From: Geert Uytterhoeven <geert@linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Cc: Linux MM <linux-mm@kvack.org>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, alpha <linux-alpha@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>, linux-m68k <linux-m68k@lists.linux-m68k.org>, "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>, Parisc List <linux-parisc@vger.kernel.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, linux-riscv <linux-riscv@lists.infradead.org>, Linux-sh list <linux-sh@vger.kernel.org>, sparclinux <sparclinux@vger.kernel.org>, linux-um <linux-um@lists.infradead.org>, Linux-Arch <linux-arch@vger.kernel.org>
List-ID: <linux-um.lists.infradead.org>

On Tue, Jun 15, 2021 at 1:32 PM Aneesh Kumar K.V
<aneesh.kumar@linux.ibm.com> wrote:
> No functional change in this patch.

> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>

>  arch/m68k/include/asm/motorola_pgtable.h     | 2 +-

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

