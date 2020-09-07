Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Date: Mon, 7 Sep 2020 23:12:56 +0300
From: Mike Rapoport <rppt@kernel.org>
Subject: Re: [RFC PATCH v2 0/3] mm/gup: fix gup_fast with dynamic page table
 folding
Message-ID: <20200907201256.GC1976319@kernel.org>
References: <20200907180058.64880-1-gerald.schaefer@linux.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200907180058.64880-1-gerald.schaefer@linux.ibm.com>
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
To: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Dave Hansen <dave.hansen@linux.intel.com>, linux-mm <linux-mm@kvack.org>, Paul Mackerras <paulus@samba.org>, linux-sparc <sparclinux@vger.kernel.org>, Alexander Gordeev <agordeev@linux.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, Will Deacon <will@kernel.org>, linux-arch <linux-arch@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Richard Weinberger <richard@nod.at>, linux-x86 <x86@kernel.org>, Russell King <linux@armlinux.org.uk>, Jason Gunthorpe <jgg@ziepe.ca>, Ingo Molnar <mingo@redhat.com>, Catalin Marinas <catalin.marinas@arm.com>, Andrey Ryabinin <aryabinin@virtuozzo.com>, Heiko Carstens <hca@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>, John Hubbard <jhubbard@nvidia.com>, Jeff Dike <jdike@addtoit.com>, linux-um <linux-um@lists.infradead.org>, Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, linux-arm <linux-arm-kernel@lists.infradead.org>, linux-power <linuxppc-dev@lists.ozlabs.org>, LKML <linux-kernel@vger.kernel.org>, Michael Ellerman <mpe@ellerman.id.au>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>

On Mon, Sep 07, 2020 at 08:00:55PM +0200, Gerald Schaefer wrote:
> This is v2 of an RFC previously discussed here:
> https://lore.kernel.org/lkml/20200828140314.8556-1-gerald.schaefer@linux.ibm.com/
> 
> Patch 1 is a fix for a regression in gup_fast on s390, after our conversion
> to common gup_fast code. It will introduce special helper functions
> pXd_addr_end_folded(), which have to be used in places where pagetable walk
> is done w/o lock and with READ_ONCE, so currently only in gup_fast.
> 
> Patch 2 is an attempt to make that more generic, i.e. change pXd_addr_end()
> themselves by adding an extra pXd value parameter. That was suggested by
> Jason during v1 discussion, because he is already thinking of some other
> places where he might want to switch to the READ_ONCE logic for pagetable
> walks. In general, that would be the cleanest / safest solution, but there
> is some impact on other architectures and common code, hence the new and
> greatly enlarged recipient list.
> 
> Patch 3 is a "nice to have" add-on, which makes pXd_addr_end() inline
> functions instead of #defines, so that we get some type checking for the
> new pXd value parameter.
> 
> Not sure about Fixes/stable tags for the generic solution. Only patch 1
> fixes a real bug on s390, and has Fixes/stable tags. Patches 2 + 3 might
> still be nice to have in stable, to ease future backports, but I guess
> "nice to have" does not really qualify for stable backports.

I also think that adding pXd parameter to pXd_addr_end() is a cleaner
way and with this patch 1 is not really required. I would even merge
patches 2 and 3 into a single patch and use only it as the fix.

[ /me apologises to stable@ team :-) ]

> Changes in v2:
> - Pick option 2 from v1 discussion (pXd_addr_end_folded helpers)
> - Add patch 2 + 3 for more generic approach
> 
> Alexander Gordeev (3):
>   mm/gup: fix gup_fast with dynamic page table folding
>   mm: make pXd_addr_end() functions page-table entry aware
>   mm: make generic pXd_addr_end() macros inline functions
> 
>  arch/arm/include/asm/pgtable-2level.h    |  2 +-
>  arch/arm/mm/idmap.c                      |  6 ++--
>  arch/arm/mm/mmu.c                        |  8 ++---
>  arch/arm64/kernel/hibernate.c            | 16 +++++----
>  arch/arm64/kvm/mmu.c                     | 16 ++++-----
>  arch/arm64/mm/kasan_init.c               |  8 ++---
>  arch/arm64/mm/mmu.c                      | 25 +++++++-------
>  arch/powerpc/mm/book3s64/radix_pgtable.c |  7 ++--
>  arch/powerpc/mm/hugetlbpage.c            |  6 ++--
>  arch/s390/include/asm/pgtable.h          | 42 ++++++++++++++++++++++++
>  arch/s390/mm/page-states.c               |  8 ++---
>  arch/s390/mm/pageattr.c                  |  8 ++---
>  arch/s390/mm/vmem.c                      |  8 ++---
>  arch/sparc/mm/hugetlbpage.c              |  6 ++--
>  arch/um/kernel/tlb.c                     |  8 ++---
>  arch/x86/mm/init_64.c                    | 15 ++++-----
>  arch/x86/mm/kasan_init_64.c              | 16 ++++-----
>  include/asm-generic/pgtable-nop4d.h      |  2 +-
>  include/asm-generic/pgtable-nopmd.h      |  2 +-
>  include/asm-generic/pgtable-nopud.h      |  2 +-
>  include/linux/pgtable.h                  | 38 ++++++++++++---------
>  mm/gup.c                                 |  8 ++---
>  mm/ioremap.c                             |  8 ++---
>  mm/kasan/init.c                          | 17 +++++-----
>  mm/madvise.c                             |  4 +--
>  mm/memory.c                              | 40 +++++++++++-----------
>  mm/mlock.c                               | 18 +++++++---
>  mm/mprotect.c                            |  8 ++---
>  mm/pagewalk.c                            |  8 ++---
>  mm/swapfile.c                            |  8 ++---
>  mm/vmalloc.c                             | 16 ++++-----
>  31 files changed, 219 insertions(+), 165 deletions(-)
> 
> -- 
> 2.17.1
> 

-- 
Sincerely yours,
Mike.

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

