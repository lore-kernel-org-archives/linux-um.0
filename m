Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-qt1-x843.google.com ([2607:f8b0:4864:20::843])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kGotx-0003m0-Al
 for linux-um@lists.infradead.org; Fri, 11 Sep 2020 19:40:06 +0000
Received: by mail-qt1-x843.google.com with SMTP id n18so8846106qtw.0
 for <linux-um@lists.infradead.org>; Fri, 11 Sep 2020 12:40:03 -0700 (PDT)
Date: Fri, 11 Sep 2020 16:40:00 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH] mm/gup: fix gup_fast with dynamic page table folding
Message-ID: <20200911194000.GB1221970@ziepe.ca>
References: <20200911070939.GB1362448@hirez.programming.kicks-ass.net>
 <patch.git-2c4880212370.your-ad-here.call-01599849957-ext-4686@work.hours>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <patch.git-2c4880212370.your-ad-here.call-01599849957-ext-4686@work.hours>
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
To: Vasily Gorbik <gor@linux.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Dave Hansen <dave.hansen@linux.intel.com>, linux-mm <linux-mm@kvack.org>, Paul Mackerras <paulus@samba.org>, linux-sparc <sparclinux@vger.kernel.org>, Alexander Gordeev <agordeev@linux.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, Will Deacon <will@kernel.org>, linux-arch <linux-arch@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Richard Weinberger <richard@nod.at>, linux-x86 <x86@kernel.org>, Russell King <linux@armlinux.org.uk>, Christian Borntraeger <borntraeger@de.ibm.com>, Ingo Molnar <mingo@redhat.com>, Catalin Marinas <catalin.marinas@arm.com>, Andrey Ryabinin <aryabinin@virtuozzo.com>, Gerald Schaefer <gerald.schaefer@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>, John Hubbard <jhubbard@nvidia.com>, Jeff Dike <jdike@addtoit.com>, linux-um <linux-um@lists.infradead.org>, Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, linux-arm <linux-arm-kernel@lists.infradead.org>, Dave Hansen <dave.hansen@intel.com>, linux-power <linuxppc-dev@lists.ozlabs.org>, LKML <linux-kernel@vger.kernel.org>, Michael Ellerman <mpe@ellerman.id.au>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Mike Rapoport <rppt@kernel.org>

On Fri, Sep 11, 2020 at 09:03:06PM +0200, Vasily Gorbik wrote:
> diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
> index e8cbc2e795d5..e899d3506671 100644
> +++ b/include/linux/pgtable.h
> @@ -1427,6 +1427,16 @@ typedef unsigned int pgtbl_mod_mask;
>  #define mm_pmd_folded(mm)	__is_defined(__PAGETABLE_PMD_FOLDED)
>  #endif
>  
> +#ifndef p4d_offset_lockless
> +#define p4d_offset_lockless(pgdp, pgd, address) p4d_offset(&pgd, address)
> +#endif
> +#ifndef pud_offset_lockless
> +#define pud_offset_lockless(p4dp, p4d, address) pud_offset(&p4d, address)
> +#endif
> +#ifndef pmd_offset_lockless
> +#define pmd_offset_lockless(pudp, pud, address) pmd_offset(&pud, address)

Needs brackets: &(pgd) 

These would probably be better as static inlines though, as only s390
compiles will type check pudp like this.

Jason

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

