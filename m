Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard@nod.at>) id 1Yb6sr-0007Zf-5e
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 26 Mar 2015 12:27:37 +0000
Received: from mail.sigma-star.at ([95.130.255.111])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Yb6sp-0005UK-Qd for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 26 Mar 2015 12:27:37 +0000
From: Richard Weinberger <richard@nod.at>
Date: Thu, 26 Mar 2015 13:27:17 +0100
Message-Id: <1427372838-16605-6-git-send-email-richard@nod.at>
In-Reply-To: <1427372838-16605-1-git-send-email-richard@nod.at>
References: <1427372838-16605-1-git-send-email-richard@nod.at>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
Subject: [uml-devel] [PATCH 6/7] um: Remove broken highmem support
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Richard Weinberger <richard@nod.at>, linux-kernel@vger.kernel.org

Highmem was always buggy and experimental on UML(i386).
In times where 64 bit computers are default we can
remove that experimental code.

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 arch/um/Kconfig.um            | 12 --------
 arch/um/include/asm/fixmap.h  |  4 ---
 arch/um/include/asm/pgtable.h |  6 +---
 arch/um/kernel/mem.c          | 66 -------------------------------------------
 arch/um/kernel/um_arch.c      |  5 ----
 arch/x86/um/Makefile          |  1 -
 6 files changed, 1 insertion(+), 93 deletions(-)

diff --git a/arch/um/Kconfig.um b/arch/um/Kconfig.um
index ff86fbe..8c46978f 100644
--- a/arch/um/Kconfig.um
+++ b/arch/um/Kconfig.um
@@ -95,18 +95,6 @@ config MAGIC_SYSRQ
 	  The keys are documented in <file:Documentation/sysrq.txt>. Don't say Y
 	  unless you really know what this hack does.
 
-config HIGHMEM
-	bool "Highmem support"
-	depends on !64BIT && BROKEN
-	default n
-	help
-	  This was used to allow UML to run with big amounts of memory.
-	  Currently it is unstable, so if unsure say N.
-
-	  To use big amounts of memory, it is recommended enable static
-	  linking (i.e. CONFIG_STATIC_LINK) - this should allow the
-	  guest to use up to 2.75G of memory.
-
 config KERNEL_STACK_ORDER
 	int "Kernel stack size order"
 	default 1 if 64BIT
diff --git a/arch/um/include/asm/fixmap.h b/arch/um/include/asm/fixmap.h
index 3094ea3c..1761fd7 100644
--- a/arch/um/include/asm/fixmap.h
+++ b/arch/um/include/asm/fixmap.h
@@ -33,10 +33,6 @@
  * fix-mapped?
  */
 enum fixed_addresses {
-#ifdef CONFIG_HIGHMEM
-	FIX_KMAP_BEGIN,	/* reserved pte's for temporary kernel mappings */
-	FIX_KMAP_END = FIX_KMAP_BEGIN+(KM_TYPE_NR*NR_CPUS)-1,
-#endif
 	__end_of_fixed_addresses
 };
 
diff --git a/arch/um/include/asm/pgtable.h b/arch/um/include/asm/pgtable.h
index 2324b62..18eb992 100644
--- a/arch/um/include/asm/pgtable.h
+++ b/arch/um/include/asm/pgtable.h
@@ -47,11 +47,7 @@ extern unsigned long end_iomem;
 #define VMALLOC_OFFSET	(__va_space)
 #define VMALLOC_START ((end_iomem + VMALLOC_OFFSET) & ~(VMALLOC_OFFSET-1))
 #define PKMAP_BASE ((FIXADDR_START - LAST_PKMAP * PAGE_SIZE) & PMD_MASK)
-#ifdef CONFIG_HIGHMEM
-# define VMALLOC_END	(PKMAP_BASE-2*PAGE_SIZE)
-#else
-# define VMALLOC_END	(FIXADDR_START-2*PAGE_SIZE)
-#endif
+#define VMALLOC_END	(FIXADDR_START-2*PAGE_SIZE)
 #define MODULES_VADDR	VMALLOC_START
 #define MODULES_END	VMALLOC_END
 #define MODULES_LEN	(MODULES_VADDR - MODULES_END)
diff --git a/arch/um/kernel/mem.c b/arch/um/kernel/mem.c
index 8636e90..b2a2dff 100644
--- a/arch/um/kernel/mem.c
+++ b/arch/um/kernel/mem.c
@@ -38,19 +38,6 @@ int kmalloc_ok = 0;
 /* Used during early boot */
 static unsigned long brk_end;
 
-#ifdef CONFIG_HIGHMEM
-static void setup_highmem(unsigned long highmem_start,
-			  unsigned long highmem_len)
-{
-	unsigned long highmem_pfn;
-	int i;
-
-	highmem_pfn = __pa(highmem_start) >> PAGE_SHIFT;
-	for (i = 0; i < highmem_len >> PAGE_SHIFT; i++)
-		free_highmem_page(&mem_map[highmem_pfn + i]);
-}
-#endif
-
 void __init mem_init(void)
 {
 	/* clear the zero-page */
@@ -67,9 +54,6 @@ void __init mem_init(void)
 	/* this will put all low memory onto the freelists */
 	free_all_bootmem();
 	max_low_pfn = totalram_pages;
-#ifdef CONFIG_HIGHMEM
-	setup_highmem(end_iomem, highmem);
-#endif
 	max_pfn = totalram_pages;
 	mem_init_print_info(NULL);
 	kmalloc_ok = 1;
@@ -127,49 +111,6 @@ static void __init fixrange_init(unsigned long start, unsigned long end,
 	}
 }
 
-#ifdef CONFIG_HIGHMEM
-pte_t *kmap_pte;
-pgprot_t kmap_prot;
-
-#define kmap_get_fixmap_pte(vaddr)					\
-	pte_offset_kernel(pmd_offset(pud_offset(pgd_offset_k(vaddr), (vaddr)),\
-				     (vaddr)), (vaddr))
-
-static void __init kmap_init(void)
-{
-	unsigned long kmap_vstart;
-
-	/* cache the first kmap pte */
-	kmap_vstart = __fix_to_virt(FIX_KMAP_BEGIN);
-	kmap_pte = kmap_get_fixmap_pte(kmap_vstart);
-
-	kmap_prot = PAGE_KERNEL;
-}
-
-static void __init init_highmem(void)
-{
-	pgd_t *pgd;
-	pud_t *pud;
-	pmd_t *pmd;
-	pte_t *pte;
-	unsigned long vaddr;
-
-	/*
-	 * Permanent kmaps:
-	 */
-	vaddr = PKMAP_BASE;
-	fixrange_init(vaddr, vaddr + PAGE_SIZE*LAST_PKMAP, swapper_pg_dir);
-
-	pgd = swapper_pg_dir + pgd_index(vaddr);
-	pud = pud_offset(pgd, vaddr);
-	pmd = pmd_offset(pud, vaddr);
-	pte = pte_offset_kernel(pmd, vaddr);
-	pkmap_page_table = pte;
-
-	kmap_init();
-}
-#endif /* CONFIG_HIGHMEM */
-
 static void __init fixaddr_user_init( void)
 {
 #ifdef CONFIG_ARCH_REUSE_HOST_VSYSCALL_AREA
@@ -211,9 +152,6 @@ void __init paging_init(void)
 
 	zones_size[ZONE_NORMAL] = (end_iomem >> PAGE_SHIFT) -
 		(uml_physmem >> PAGE_SHIFT);
-#ifdef CONFIG_HIGHMEM
-	zones_size[ZONE_HIGHMEM] = highmem >> PAGE_SHIFT;
-#endif
 	free_area_init(zones_size);
 
 	/*
@@ -224,10 +162,6 @@ void __init paging_init(void)
 	fixrange_init(vaddr, FIXADDR_TOP, swapper_pg_dir);
 
 	fixaddr_user_init();
-
-#ifdef CONFIG_HIGHMEM
-	init_highmem();
-#endif
 }
 
 /*
diff --git a/arch/um/kernel/um_arch.c b/arch/um/kernel/um_arch.c
index cd09285..9b06957 100644
--- a/arch/um/kernel/um_arch.c
+++ b/arch/um/kernel/um_arch.c
@@ -301,11 +301,6 @@ int __init linux_main(int argc, char **argv)
 	if (physmem_size + iomem_size > max_physmem) {
 		highmem = physmem_size + iomem_size - max_physmem;
 		physmem_size -= highmem;
-#ifndef CONFIG_HIGHMEM
-		highmem = 0;
-		printf("CONFIG_HIGHMEM not enabled - physical memory shrunk "
-		       "to %Lu bytes\n", physmem_size);
-#endif
 	}
 
 	high_physmem = uml_physmem + physmem_size;
diff --git a/arch/x86/um/Makefile b/arch/x86/um/Makefile
index eafa324..acb384d 100644
--- a/arch/x86/um/Makefile
+++ b/arch/x86/um/Makefile
@@ -21,7 +21,6 @@ obj-$(CONFIG_BINFMT_ELF) += elfcore.o
 
 subarch-y = ../lib/string_32.o ../lib/atomic64_32.o ../lib/atomic64_cx8_32.o
 subarch-$(CONFIG_RWSEM_XCHGADD_ALGORITHM) += ../lib/rwsem.o
-subarch-$(CONFIG_HIGHMEM) += ../mm/highmem_32.o
 
 else
 
-- 
1.8.4.5


------------------------------------------------------------------------------
Dive into the World of Parallel Programming The Go Parallel Website, sponsored
by Intel and developed in partnership with Slashdot Media, is your hub for all
things parallel software development, from weekly thought leadership blogs to
news, videos, case studies, tutorials and more. Take a look and join the 
conversation now. http://goparallel.sourceforge.net/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

