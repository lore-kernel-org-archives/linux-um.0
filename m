Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Date: Tue, 8 Sep 2020 19:59:44 +0200
From: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
Subject: Re: [RFC PATCH v2 1/3] mm/gup: fix gup_fast with dynamic page table
 folding
Message-ID: <20200908195944.1a25d1bb@thinkpad>
In-Reply-To: <0dbc6ec8-45ea-0853-4856-2bc1e661a5a5@intel.com>
References: <20200907180058.64880-1-gerald.schaefer@linux.ibm.com>
 <20200907180058.64880-2-gerald.schaefer@linux.ibm.com>
 <0dbc6ec8-45ea-0853-4856-2bc1e661a5a5@intel.com>
MIME-Version: 1.0
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
To: Dave Hansen <dave.hansen@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Dave Hansen <dave.hansen@linux.intel.com>, linux-mm <linux-mm@kvack.org>, Paul Mackerras <paulus@samba.org>, linux-sparc <sparclinux@vger.kernel.org>, Alexander Gordeev <agordeev@linux.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, Will Deacon <will@kernel.org>, linux-arch <linux-arch@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Richard Weinberger <richard@nod.at>, linux-x86 <x86@kernel.org>, Russell King <linux@armlinux.org.uk>, Jason Gunthorpe <jgg@ziepe.ca>, Ingo Molnar <mingo@redhat.com>, Catalin Marinas <catalin.marinas@arm.com>, Andrey Ryabinin <aryabinin@virtuozzo.com>, Heiko Carstens <hca@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>, John Hubbard <jhubbard@nvidia.com>, Jeff Dike <jdike@addtoit.com>, linux-um <linux-um@lists.infradead.org>, Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, linux-arm <linux-arm-kernel@lists.infradead.org>, linux-power <linuxppc-dev@lists.ozlabs.org>, LKML <linux-kernel@vger.kernel.org>, Michael Ellerman <mpe@ellerman.id.au>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Mike Rapoport <rppt@kernel.org>

On Tue, 8 Sep 2020 07:30:50 -0700
Dave Hansen <dave.hansen@intel.com> wrote:

> On 9/7/20 11:00 AM, Gerald Schaefer wrote:
> > Commit 1a42010cdc26 ("s390/mm: convert to the generic get_user_pages_fast
> > code") introduced a subtle but severe bug on s390 with gup_fast, due to
> > dynamic page table folding.
> 
> Would it be fair to say that the "fake" page table entries s390
> allocates on the stack are what's causing the trouble here?  That might
> be a nice thing to open up with here.  "Dynamic page table folding"
> really means nothing to me.

We do not really allocate anything on the stack, it is the generic logic
from gup_fast that passes over pXd values (read once before), and using
pointers to such (stack) variables instead of real pXd pointers.
That, combined with the fact that we just return the passed in pointer in
pXd_offset() for folded levels.

That works similar on x86 IIUC, but with static folding, and thus also
proper pXd_addr_end() results because of statically (and correspondingly)
defined Pxd_INDEX/SHIFT. We always have static 5-level PxD_INDEX/SHIFT, and
that cannot really be made dynamic, so we just make pXd_addr_end()
dynamic instead, and that requires the pXd value to determine the correct
pagetable level.

Still makes my head spin when trying to explain, sorry. It is a very
special s390 oddity, or lets call it "feature", because I don't think any
other architecture has "dynamic pagetable folding" capability, depending
on process requirements, for whatever it is worth...

> 
> > @@ -2521,7 +2521,7 @@ static int gup_pmd_range(pud_t pud, unsigned long addr, unsigned long end,
> >  	do {
> >  		pmd_t pmd = READ_ONCE(*pmdp);
> >  
> > -		next = pmd_addr_end(addr, end);
> > +		next = pmd_addr_end_folded(pmd, addr, end);
> >  		if (!pmd_present(pmd))
> >  			return 0;
> 
> It looks like you fix this up later, but this would be a problem if left
> this way.  There's no documentation for whether I use
> pmd_addr_end_folded() or pmd_addr_end() when writing a page table walker.

Yes, that is very unfortunate. We did have some lengthy comment in
include/linux/pgtable.h where the pXd_addr_end(_folded) were defined.
But that was moved to arch/s390/include/asm/pgtable.h in this version,
probably because we already had the generalization in mind, where we
would not need such explanation in common header any more.

So, it might help better understand the issue that we have with
dynamic page table folding and READ_ONCE-style pagetable walkers
when looking at that comment.

Thanks for pointing out, that comment should definitely go into
include/linux/pgtable.h again. At least if we would still go for
that "s390 fix first, generalization second" approach, but it
seems we have other / better options now.

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

