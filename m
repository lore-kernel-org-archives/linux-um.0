Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EE9iF-0006iP-7q	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 10 Sep 2005 11:04:27 -0700
Received: from ppp-62-11-72-160.dialup.tiscali.it ([62.11.72.160]
	helo=zion.home.lan)	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1EE9iD-0006nJ-A6	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 10 Sep 2005 11:04:27 -0700
Message-Id: <20050910174628.539817000@zion.home.lan>
References: <20050910174452.907256000@zion.home.lan>
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Content-Disposition: inline; filename=uml-inline-mk_pte
Subject: [uml-devel] [patch 4/7] uml: inline mk_pte and various friends
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
Date: Sat, 10 Sep 2005 19:44:56 +0200
To: Linus Torvalds <torvalds@osdl.org>
Cc: Jeff Dike <jdike@addtoit.com>, Paolo Blaisorblade Giarrusso <blaisorblade@yahoo.it>, LKML <linux-kernel@vger.kernel.org>, user-mode-linux-devel@lists.sourceforge.net

Turns out that, for UML, a *lot* of VM-related trivial functions are not
inlined but rather normal functions.

In other sections of UML code, this is justified by having files which
interact with the host and cannot therefore include kernel headers, but in
this case there's no such justification.

I've had to turn many of them to macros because of missing declarations. While
doing this, I've decided to reuse some already existing macros.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 arch/um/include/mem.h    |   12 +++++++++++-
 arch/um/kernel/ksyms.c   |    5 -----
 arch/um/kernel/physmem.c |   35 -----------------------------------
 include/asm-um/page.h    |    3 +--
 include/asm-um/pgtable.h |   16 +++++++++++-----
 5 files changed, 23 insertions(+), 48 deletions(-)

diff --git a/arch/um/include/mem.h b/arch/um/include/mem.h
--- a/arch/um/include/mem.h
+++ b/arch/um/include/mem.h
@@ -13,7 +13,17 @@ extern int physmem_subst_mapping(void *v
 extern int is_remapped(void *virt);
 extern int physmem_remove_mapping(void *virt);
 extern void physmem_forget_descriptor(int fd);
-extern unsigned long to_phys(void *virt);
+
+extern unsigned long uml_physmem;
+static inline unsigned long to_phys(void *virt)
+{
+	return(((unsigned long) virt) - uml_physmem);
+}
+
+static inline void *to_virt(unsigned long phys)
+{
+	return((void *) uml_physmem + phys);
+}
 
 #endif
 
diff --git a/arch/um/kernel/ksyms.c b/arch/um/kernel/ksyms.c
--- a/arch/um/kernel/ksyms.c
+++ b/arch/um/kernel/ksyms.c
@@ -34,14 +34,9 @@ EXPORT_SYMBOL(host_task_size);
 EXPORT_SYMBOL(arch_validate);
 EXPORT_SYMBOL(get_kmem_end);
 
-EXPORT_SYMBOL(page_to_phys);
-EXPORT_SYMBOL(phys_to_page);
 EXPORT_SYMBOL(high_physmem);
 EXPORT_SYMBOL(empty_zero_page);
 EXPORT_SYMBOL(um_virt_to_phys);
-EXPORT_SYMBOL(__virt_to_page);
-EXPORT_SYMBOL(to_phys);
-EXPORT_SYMBOL(to_virt);
 EXPORT_SYMBOL(mode_tt);
 EXPORT_SYMBOL(handle_page_fault);
 EXPORT_SYMBOL(find_iomem);
diff --git a/arch/um/kernel/physmem.c b/arch/um/kernel/physmem.c
--- a/arch/um/kernel/physmem.c
+++ b/arch/um/kernel/physmem.c
@@ -248,16 +248,6 @@ unsigned long high_physmem;
 
 extern unsigned long physmem_size;
 
-void *to_virt(unsigned long phys)
-{
-	return((void *) uml_physmem + phys);
-}
-
-unsigned long to_phys(void *virt)
-{
-	return(((unsigned long) virt) - uml_physmem);
-}
-
 int init_maps(unsigned long physmem, unsigned long iomem, unsigned long highmem)
 {
 	struct page *p, *map;
@@ -298,31 +288,6 @@ int init_maps(unsigned long physmem, uns
 	return(0);
 }
 
-struct page *phys_to_page(const unsigned long phys)
-{
-	return(&mem_map[phys >> PAGE_SHIFT]);
-}
-
-struct page *__virt_to_page(const unsigned long virt)
-{
-	return(&mem_map[__pa(virt) >> PAGE_SHIFT]);
-}
-
-phys_t page_to_phys(struct page *page)
-{
-	return((page - mem_map) << PAGE_SHIFT);
-}
-
-pte_t mk_pte(struct page *page, pgprot_t pgprot)
-{
-	pte_t pte;
-
-	pte_set_val(pte, page_to_phys(page), pgprot);
-	if(pte_present(pte))
-		pte_mknewprot(pte_mknewpage(pte));
-	return(pte);
-}
-
 /* Changed during early boot */
 static unsigned long kmem_top = 0;
 
diff --git a/include/asm-um/page.h b/include/asm-um/page.h
--- a/include/asm-um/page.h
+++ b/include/asm-um/page.h
@@ -96,8 +96,7 @@ extern unsigned long uml_physmem;
 
 #define __va_space (8*1024*1024)
 
-extern unsigned long to_phys(void *virt);
-extern void *to_virt(unsigned long phys);
+#include "mem.h"
 
 /* Cast to unsigned long before casting to void * to avoid a warning from
  * mmap_kmem about cutting a long long down to a void *.  Not sure that
diff --git a/include/asm-um/pgtable.h b/include/asm-um/pgtable.h
--- a/include/asm-um/pgtable.h
+++ b/include/asm-um/pgtable.h
@@ -326,14 +326,22 @@ static inline void set_pte(pte_t *pteptr
 }
 #define set_pte_at(mm,addr,ptep,pteval) set_pte(ptep,pteval)
 
-extern phys_t page_to_phys(struct page *page);
-
 /*
  * Conversion functions: convert a page and protection to a page entry,
  * and a page entry and page directory to the page they refer to.
  */
 
-extern pte_t mk_pte(struct page *page, pgprot_t pgprot);
+#define phys_to_page(phys) pfn_to_page(phys_to_pfn(phys))
+#define __virt_to_page(virt) phys_to_page(__pa(virt))
+#define page_to_phys(page) pfn_to_phys(page_to_pfn(page))
+
+#define mk_pte(page, pgprot) \
+	({ pte_t pte;					\
+							\
+	pte_set_val(pte, page_to_phys(page), (pgprot));	\
+	if (pte_present(pte))				\
+		pte_mknewprot(pte_mknewpage(pte));	\
+	pte;})
 
 static inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
 {
@@ -410,8 +418,6 @@ static inline pte_t pte_modify(pte_t pte
 #endif
 #endif
 
-extern struct page *phys_to_page(const unsigned long phys);
-extern struct page *__virt_to_page(const unsigned long virt);
 #define virt_to_page(addr) __virt_to_page((const unsigned long) addr)
 
 /*

--


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
