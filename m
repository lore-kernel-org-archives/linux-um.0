Return-Path: <rppt@kernel.org>
From: Mike Rapoport <rppt@kernel.org>
Subject: [PATCH v2 04/12] csky: replace definitions of __pXd_offset() with pXd_index()
Date: Thu, 14 May 2020 20:03:19 +0300
Message-Id: <20200514170327.31389-5-rppt@kernel.org>
In-Reply-To: <20200514170327.31389-1-rppt@kernel.org>
References: <20200514170327.31389-1-rppt@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>, Brian Cain <bcain@codeaurora.org>, Catalin Marinas <catalin.marinas@arm.com>, Chris Zankel <chris@zankel.net>, "David S. Miller" <davem@davemloft.net>, Geert Uytterhoeven <geert@linux-m68k.org>, Greentime Hu <green.hu@gmail.com>, Greg Ungerer <gerg@linux-m68k.org>, Guan Xuetao <gxt@pku.edu.cn>, Guo Ren <guoren@kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, Helge Deller <deller@gmx.de>, Ingo Molnar <mingo@redhat.com>, Ley Foon Tan <ley.foon.tan@intel.com>, Mark Salter <msalter@redhat.com>, Matthew Wilcox <willy@infradead.org>, Matt Turner <mattst88@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, Michal Simek <monstr@monstr.eu>, Mike Rapoport <rppt@kernel.org>, Nick Hu <nickhu@andestech.com>, Paul Walmsley <paul.walmsley@sifive.com>, Richard Weinberger <richard@nod.at>, Rich Felker <dalias@libc.org>, Russell King <linux@armlinux.org.uk>, Stafford Horne <shorne@gmail.com>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Thomas Gleixner <tglx@linutronix.de>, Tony Luck <tony.luck@intel.com>, Vincent Chen <deanbo422@gmail.com>, Vineet Gupta <vgupta@synopsys.com>, Will Deacon <will@kernel.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, linux-alpha@vger.kernel.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-c6x-dev@linux-c6x.org, linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, linux-mm@kvack.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, linux-snps-arc@lists.infradead.org, linux-um@lists.infradead.org, linux-xtensa@linux-xtensa.org, openrisc@lists.librecores.org, sparclinux@vger.kernel.org, x86@kernel.org, Mike Rapoport <rppt@linux.ibm.com>
List-ID: <linux-um.lists.infradead.org>

From: Mike Rapoport <rppt@linux.ibm.com>

All architectures use pXd_index() to get an entry in the page table page
corresponding to a virtual address.

Align csky with other architectures.

Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
---
 arch/csky/include/asm/pgtable.h | 5 ++---
 arch/csky/mm/fault.c            | 2 +-
 arch/csky/mm/highmem.c          | 2 +-
 arch/csky/mm/init.c             | 6 +++---
 4 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/arch/csky/include/asm/pgtable.h b/arch/csky/include/asm/pgtable.h
index 9d2d16db237d..2eff4aea51b3 100644
--- a/arch/csky/include/asm/pgtable.h
+++ b/arch/csky/include/asm/pgtable.h
@@ -229,9 +229,8 @@ static inline pte_t pte_mkyoung(pte_t pte)
 	return pte;
 }
 
-#define __pgd_offset(address)	pgd_index(address)
-#define __pud_offset(address)	(((address) >> PUD_SHIFT) & (PTRS_PER_PUD-1))
-#define __pmd_offset(address)	(((address) >> PMD_SHIFT) & (PTRS_PER_PMD-1))
+#define pud_index(address)	(((address) >> PUD_SHIFT) & (PTRS_PER_PUD-1))
+#define pmd_index(address)	(((address) >> PMD_SHIFT) & (PTRS_PER_PMD-1))
 
 /* to find an entry in a kernel page-table-directory */
 #define pgd_offset_k(address)	pgd_offset(&init_mm, address)
diff --git a/arch/csky/mm/fault.c b/arch/csky/mm/fault.c
index 4e6dc68f3258..4055d430c0c8 100644
--- a/arch/csky/mm/fault.c
+++ b/arch/csky/mm/fault.c
@@ -78,7 +78,7 @@ asmlinkage void do_page_fault(struct pt_regs *regs, unsigned long write,
 		 * Do _not_ use "tsk" here. We might be inside
 		 * an interrupt in the middle of a task switch..
 		 */
-		int offset = __pgd_offset(address);
+		int offset = pgd_index(address);
 		pgd_t *pgd, *pgd_k;
 		pud_t *pud, *pud_k;
 		pmd_t *pmd, *pmd_k;
diff --git a/arch/csky/mm/highmem.c b/arch/csky/mm/highmem.c
index 3b3f622f5ae9..89ec32e602a1 100644
--- a/arch/csky/mm/highmem.c
+++ b/arch/csky/mm/highmem.c
@@ -92,7 +92,7 @@ static void __init kmap_pages_init(void)
 	vaddr = PKMAP_BASE;
 	fixrange_init(vaddr, vaddr + PAGE_SIZE*LAST_PKMAP, swapper_pg_dir);
 
-	pgd = swapper_pg_dir + __pgd_offset(vaddr);
+	pgd = swapper_pg_dir + pgd_index(vaddr);
 	pud = (pud_t *)pgd;
 	pmd = pmd_offset(pud, vaddr);
 	pte = pte_offset_kernel(pmd, vaddr);
diff --git a/arch/csky/mm/init.c b/arch/csky/mm/init.c
index eda2b4291485..af627128314f 100644
--- a/arch/csky/mm/init.c
+++ b/arch/csky/mm/init.c
@@ -157,9 +157,9 @@ void __init fixrange_init(unsigned long start, unsigned long end,
 	unsigned long vaddr;
 
 	vaddr = start;
-	i = __pgd_offset(vaddr);
-	j = __pud_offset(vaddr);
-	k = __pmd_offset(vaddr);
+	i = pgd_index(vaddr);
+	j = pud_index(vaddr);
+	k = pmd_index(vaddr);
 	pgd = pgd_base + i;
 
 	for ( ; (i < PTRS_PER_PGD) && (vaddr != end); pgd++, i++) {
-- 
2.26.2


