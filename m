Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CdJCa-0005Fc-Hi for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 11 Dec 2004 18:11:12 -0800
Received: from mailout.stusta.mhn.de ([141.84.69.5])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.41)
	id 1CdJCZ-0004Oi-9o for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 11 Dec 2004 18:11:12 -0800
From: Adrian Bunk <bunk@stusta.de>
Message-ID: <20041212021056.GL22324@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [uml-devel] [2.6 patch] (mostly i386) mm cleanup
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Sun, 12 Dec 2004 03:10:56 +0100
To: Dave Hansen <haveblue@us.ibm.com>, linux-kernel@vger.kernel.org, paulus@samba.org, linuxppc-dev@ozlabs.org, jdike@karaya.com, user-mode-linux-devel@lists.sourceforge.net, dhowells@redhat.com

The patch below contains the following fixes:
- arch/i386/mm/boot_ioremap.c: make a variable static:
- frv/ppc highmem.c: remove stale kmap_init prototypes
- arch/um/kernel/mem.c: make kmap_init static
- arch/i386/mm/init.c: make five functions static.


diffstat output:
 arch/i386/mm/boot_ioremap.c |    4 ++--
 arch/i386/mm/init.c         |   10 +++++-----
 arch/um/kernel/mem.c        |    2 +-
 include/asm-frv/highmem.h   |    2 --
 include/asm-i386/highmem.h  |    2 --
 include/asm-ppc/highmem.h   |    2 --
 6 files changed, 8 insertions(+), 14 deletions(-)


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-rc2-mm4-full/arch/i386/mm/boot_ioremap.c.old	2004-12-11 23:55:28.000000000 +0100
+++ linux-2.6.10-rc2-mm4-full/arch/i386/mm/boot_ioremap.c	2004-12-11 23:55:49.000000000 +0100
@@ -61,8 +61,8 @@
 /* the virtual space we're going to remap comes from this array */
 #define BOOT_IOREMAP_PAGES 4
 #define BOOT_IOREMAP_SIZE (BOOT_IOREMAP_PAGES*PAGE_SIZE)
-__initdata char boot_ioremap_space[BOOT_IOREMAP_SIZE] 
-		__attribute__ ((aligned (PAGE_SIZE)));
+static __initdata char boot_ioremap_space[BOOT_IOREMAP_SIZE] 
+		       __attribute__ ((aligned (PAGE_SIZE)));
 
 /*
  * This only applies to things which need to ioremap before paging_init()
--- linux-2.6.10-rc2-mm4-full/include/asm-frv/highmem.h.old	2004-12-11 23:57:40.000000000 +0100
+++ linux-2.6.10-rc2-mm4-full/include/asm-frv/highmem.h	2004-12-11 23:57:51.000000000 +0100
@@ -44,8 +44,6 @@
 #define kmap_pte ______kmap_pte_in_TLB
 extern pte_t *pkmap_page_table;
 
-extern void kmap_init(void);
-
 #define flush_cache_kmaps()  do { } while (0)
 
 /*
--- linux-2.6.10-rc2-mm4-full/include/asm-ppc/highmem.h.old	2004-12-11 23:58:00.000000000 +0100
+++ linux-2.6.10-rc2-mm4-full/include/asm-ppc/highmem.h	2004-12-11 23:58:03.000000000 +0100
@@ -35,8 +35,6 @@
 extern pgprot_t kmap_prot;
 extern pte_t *pkmap_page_table;
 
-extern void kmap_init(void) __init;
-
 /*
  * Right now we initialize only a single pte table. It can be extended
  * easily, subsequent pte tables have to be allocated in one physical
--- linux-2.6.10-rc2-mm4-full/arch/um/kernel/mem.c.old	2004-12-11 23:58:14.000000000 +0100
+++ linux-2.6.10-rc2-mm4-full/arch/um/kernel/mem.c	2004-12-11 23:58:21.000000000 +0100
@@ -141,7 +141,7 @@
 	pte_offset_kernel(pmd_offset(pml4_pgd_offset(pml4_offset_k(vaddr), \
 						     vaddr), (vaddr)), (vaddr))
 
-void __init kmap_init(void)
+static void __init kmap_init(void)
 {
 	unsigned long kmap_vstart;
 
--- linux-2.6.10-rc2-mm4-full/include/asm-i386/highmem.h.old	2004-12-11 23:58:54.000000000 +0100
+++ linux-2.6.10-rc2-mm4-full/include/asm-i386/highmem.h	2004-12-11 23:58:57.000000000 +0100
@@ -33,8 +33,6 @@
 extern pgprot_t kmap_prot;
 extern pte_t *pkmap_page_table;
 
-extern void kmap_init(void);
-
 /*
  * Right now we initialize only a single pte table. It can be extended
  * easily, subsequent pte tables have to be allocated in one physical
--- linux-2.6.10-rc2-mm4-full/arch/i386/mm/init.c.old	2004-12-11 23:58:29.000000000 +0100
+++ linux-2.6.10-rc2-mm4-full/arch/i386/mm/init.c	2004-12-12 00:15:07.000000000 +0100
@@ -254,7 +254,7 @@
 #define kmap_get_fixmap_pte(vaddr)					\
 	pte_offset_kernel(pmd_offset(pml4_pgd_offset(pml4_offset_k(vaddr), vaddr), (vaddr)), (vaddr))
 
-void __init kmap_init(void)
+static void __init kmap_init(void)
 {
 	unsigned long kmap_vstart;
 
@@ -265,7 +265,7 @@
 	kmap_prot = PAGE_KERNEL;
 }
 
-void __init permanent_kmaps_init(pgd_t *pgd_base)
+static void __init permanent_kmaps_init(pgd_t *pgd_base)
 {
 	pgd_t *pgd;
 	pmd_t *pmd;
@@ -294,7 +294,7 @@
 }
 
 #ifndef CONFIG_DISCONTIGMEM
-void __init set_highmem_pages_init(int bad_ppro) 
+static void __init set_highmem_pages_init(int bad_ppro) 
 {
 	int pfn;
 	for (pfn = highstart_pfn; pfn < highend_pfn; pfn++)
@@ -408,7 +408,7 @@
 }
 
 #ifndef CONFIG_DISCONTIGMEM
-void __init zone_sizes_init(void)
+static void __init zone_sizes_init(void)
 {
 	unsigned long zones_size[MAX_NR_ZONES] = {0, 0, 0};
 	unsigned int max_dma, high, low;
@@ -545,7 +545,7 @@
  * but fortunately the switch to using exceptions got rid of all that.
  */
 
-void __init test_wp_bit(void)
+static void __init test_wp_bit(void)
 {
 	printk("Checking if this processor honours the WP bit even in supervisor mode... ");
 



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
