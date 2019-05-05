Return-Path: <rppt@linux.ibm.com>
Date: Sun, 5 May 2019 09:15:26 +0300
From: Mike Rapoport <rppt@linux.ibm.com>
Subject: Re: [PATCH 01/15] asm-generic, x86: introduce generic
 pte_{alloc,free}_one[_kernel]
References: <1556810922-20248-1-git-send-email-rppt@linux.ibm.com>
 <1556810922-20248-2-git-send-email-rppt@linux.ibm.com>
 <20190502190310.voenw3pwgpelmdgw@pburton-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190502190310.voenw3pwgpelmdgw@pburton-laptop>
Message-Id: <20190505061525.GC15755@rapoport-lnx>
To: Paul Burton <paul.burton@mips.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>, Catalin Marinas <catalin.marinas@arm.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Greentime Hu <green.hu@gmail.com>, Guan Xuetao <gxt@pku.edu.cn>, Guo Ren <guoren@kernel.org>, Helge Deller <deller@gmx.de>, Ley Foon Tan <lftan@altera.com>, Matthew Wilcox <willy@infradead.org>, Matt Turner <mattst88@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, Michal Hocko <mhocko@suse.com>, Palmer Dabbelt <palmer@sifive.com>, Richard Kuo <rkuo@codeaurora.org>, Richard Weinberger <richard@nod.at>, Russell King <linux@armlinux.org.uk>, Sam Creasey <sammy@sammy.net>, "x86@kernel.org" <x86@kernel.org>, "linux-alpha@vger.kernel.org" <linux-alpha@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-hexagon@vger.kernel.org" <linux-hexagon@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-m68k@lists.linux-m68k.org" <linux-m68k@lists.linux-m68k.org>, "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>, "linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>, "linux-um@lists.infradead.org" <linux-um@lists.infradead.org>, "nios2-dev@lists.rocketboards.org" <nios2-dev@lists.rocketboards.org>
List-ID: <linux-um.lists.infradead.org>

On Thu, May 02, 2019 at 07:03:11PM +0000, Paul Burton wrote:
> Hi Mike,
> 
> On Thu, May 02, 2019 at 06:28:28PM +0300, Mike Rapoport wrote:
> > +/**
> > + * pte_free_kernel - free PTE-level user page table page
> > + * @mm: the mm_struct of the current context
> > + * @pte_page: the `struct page` representing the page table
> > + */
> > +static inline void pte_free(struct mm_struct *mm, struct page *pte_page)
> > +{
> > +	pgtable_page_dtor(pte_page);
> > +	__free_page(pte_page);
> > +}
> 
> Nit: the comment names the wrong function (s/pte_free_kernel/pte_free/).

Argh, evil copy-paste :)
Thanks!
 
> Thanks,
>     Paul
> 

-- 
Sincerely yours,
Mike.


