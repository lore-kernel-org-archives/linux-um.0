Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-io1-xd42.google.com ([2607:f8b0:4864:20::d42])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kIEXB-0008RF-E3
 for linux-um@lists.infradead.org; Tue, 15 Sep 2020 17:14:27 +0000
Received: by mail-io1-xd42.google.com with SMTP id z13so4920490iom.8
 for <linux-um@lists.infradead.org>; Tue, 15 Sep 2020 10:14:23 -0700 (PDT)
Date: Tue, 15 Sep 2020 14:14:20 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH v2] mm/gup: fix gup_fast with dynamic page table folding
Message-ID: <20200915171420.GK1221970@ziepe.ca>
References: <20200911200511.GC1221970@ziepe.ca>
 <patch.git-943f1e5dcff2.your-ad-here.call-01599856292-ext-8676@work.hours>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <patch.git-943f1e5dcff2.your-ad-here.call-01599856292-ext-8676@work.hours>
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

On Fri, Sep 11, 2020 at 10:36:43PM +0200, Vasily Gorbik wrote:
> Currently to make sure that every page table entry is read just once
> gup_fast walks perform READ_ONCE and pass pXd value down to the next
> gup_pXd_range function by value e.g.:
> 
> static int gup_pud_range(p4d_t p4d, unsigned long addr, unsigned long end,
>                          unsigned int flags, struct page **pages, int *nr)
> ...
>         pudp = pud_offset(&p4d, addr);
> 
> This function passes a reference on that local value copy to pXd_offset,
> and might get the very same pointer in return. This happens when the
> level is folded (on most arches), and that pointer should not be iterated.
> 
> On s390 due to the fact that each task might have different 5,4 or
> 3-level address translation and hence different levels folded the logic
> is more complex and non-iteratable pointer to a local copy leads to
> severe problems.
> 
> Here is an example of what happens with gup_fast on s390, for a task
> with 3-levels paging, crossing a 2 GB pud boundary:
> 
> // addr = 0x1007ffff000, end = 0x10080001000
> static int gup_pud_range(p4d_t p4d, unsigned long addr, unsigned long end,
>                          unsigned int flags, struct page **pages, int *nr)
> {
>         unsigned long next;
>         pud_t *pudp;
> 
>         // pud_offset returns &p4d itself (a pointer to a value on stack)
>         pudp = pud_offset(&p4d, addr);
>         do {
>                 // on second iteratation reading "random" stack value
>                 pud_t pud = READ_ONCE(*pudp);
> 
>                 // next = 0x10080000000, due to PUD_SIZE/MASK != PGDIR_SIZE/MASK on s390
>                 next = pud_addr_end(addr, end);
>                 ...
>         } while (pudp++, addr = next, addr != end); // pudp++ iterating over stack
> 
>         return 1;
> }
> 
> This happens since s390 moved to common gup code with
> commit d1874a0c2805 ("s390/mm: make the pxd_offset functions more robust")
> and commit 1a42010cdc26 ("s390/mm: convert to the generic
> get_user_pages_fast code"). s390 tried to mimic static level folding by
> changing pXd_offset primitives to always calculate top level page table
> offset in pgd_offset and just return the value passed when pXd_offset
> has to act as folded.
> 
> What is crucial for gup_fast and what has been overlooked is
> that PxD_SIZE/MASK and thus pXd_addr_end should also change
> correspondingly. And the latter is not possible with dynamic folding.
> 
> To fix the issue in addition to pXd values pass original
> pXdp pointers down to gup_pXd_range functions. And introduce
> pXd_offset_lockless helpers, which take an additional pXd
> entry value parameter. This has already been discussed in
> https://lkml.kernel.org/r/20190418100218.0a4afd51@mschwideX1
> 
> Cc: <stable@vger.kernel.org> # 5.2+
> Fixes: 1a42010cdc26 ("s390/mm: convert to the generic get_user_pages_fast code")
> Reviewed-by: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
> Reviewed-by: Alexander Gordeev <agordeev@linux.ibm.com>
> Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
> ---
> v2: added brackets &pgd -> &(pgd)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Regards,
Jason

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

