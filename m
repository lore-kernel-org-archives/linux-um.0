Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Date: Tue, 8 Sep 2020 17:48:59 +0200
From: Alexander Gordeev <agordeev@linux.ibm.com>
Subject: Re: [RFC PATCH v2 3/3] mm: make generic pXd_addr_end() macros inline
 functions
Message-ID: <20200908154859.GA11583@oc3871087118.ibm.com>
References: <20200907180058.64880-1-gerald.schaefer@linux.ibm.com>
 <20200907180058.64880-4-gerald.schaefer@linux.ibm.com>
 <4c101685-5b29-dace-9dd2-b6f0ae193a9c@csgroup.eu>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4c101685-5b29-dace-9dd2-b6f0ae193a9c@csgroup.eu>
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
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Peter Zijlstra <peterz@infradead.org>, Catalin Marinas <catalin.marinas@arm.com>, Dave Hansen <dave.hansen@linux.intel.com>, linux-mm <linux-mm@kvack.org>, Paul Mackerras <paulus@samba.org>, linux-sparc <sparclinux@vger.kernel.org>, Claudio Imbrenda <imbrenda@linux.ibm.com>, Will Deacon <will@kernel.org>, linux-arch <linux-arch@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Richard Weinberger <richard@nod.at>, linux-x86 <x86@kernel.org>, Russell King <linux@armlinux.org.uk>, Jason Gunthorpe <jgg@ziepe.ca>, Ingo Molnar <mingo@redhat.com>, Andrey Ryabinin <aryabinin@virtuozzo.com>, Gerald Schaefer <gerald.schaefer@linux.ibm.com>, Jeff Dike <jdike@addtoit.com>, Arnd Bergmann <arnd@arndb.de>, John Hubbard <jhubbard@nvidia.com>, Heiko Carstens <hca@linux.ibm.com>, linux-um <linux-um@lists.infradead.org>, Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, linux-arm <linux-arm-kernel@lists.infradead.org>, Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, linux-power <linuxppc-dev@lists.ozlabs.org>, Mike Rapoport <rppt@kernel.org>

On Tue, Sep 08, 2020 at 07:19:38AM +0200, Christophe Leroy wrote:

[...]

> >diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
> >index 67ebc22cf83d..d9e7d16c2263 100644
> >--- a/include/linux/pgtable.h
> >+++ b/include/linux/pgtable.h
> >@@ -656,31 +656,35 @@ static inline int arch_unmap_one(struct mm_struct *mm,
> >   */
> >  #ifndef pgd_addr_end
> >-#define pgd_addr_end(pgd, addr, end)					\
> >-({	unsigned long __boundary = ((addr) + PGDIR_SIZE) & PGDIR_MASK;	\
> >-	(__boundary - 1 < (end) - 1)? __boundary: (end);		\
> >-})
> >+#define pgd_addr_end pgd_addr_end
> 
> I think that #define is pointless, usually there is no such #define
> for the default case.

Default pgd_addr_end() gets overriden on s390 (arch/s390/include/asm/pgtable.h):

#define pgd_addr_end pgd_addr_end
static inline unsigned long pgd_addr_end(pgd_t pgd, unsigned long addr, unsigned long end)
{
	return rste_addr_end_folded(pgd_val(pgd), addr, end);
}

> >+static inline unsigned long pgd_addr_end(pgd_t pgd, unsigned long addr, unsigned long end)
> >+{	unsigned long __boundary = (addr + PGDIR_SIZE) & PGDIR_MASK;
> >+	return (__boundary - 1 < end - 1) ? __boundary : end;
> >+}

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

