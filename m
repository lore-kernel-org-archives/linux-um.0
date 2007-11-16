Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1It8xY-0000BS-6A for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 16 Nov 2007 13:42:44 -0800
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1It8xX-0000ep-E8
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 16 Nov 2007 13:42:44 -0800
Date: Fri, 16 Nov 2007 16:42:24 -0500
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20071116214224.GA13847@c2.user-mode-linux.org>
Mime-Version: 1.0
Content-Disposition: inline
Subject: [uml-devel] [PATCH 1/8] UML - Move um_virt_to_phys
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Andrew Morton <akpm@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>

This patchset makes UML build and run with three-level page tables on
32-bit hosts.  This is an uncommon use case, but the code here needed
fixing and cleaning up, so 32-bit three-level pages tables were tested
to make sure the changes are good.

Patch 1 - code movement
Patch 2 - header untangling
Patch 3 - style fixups in files affected so far
Patch 4 - clean up use of current.h
Patch 5 - fix sizes of types that are different between 2 and 3-level
	page tables - three-level page table support should build at
	this point
Patch 6 - tidy (i.e. eliminate much of) the code that figures out how
	big the address space is
Patch 7 - change um_virt_to_phys into virt_to_pte, clean its
	interface, and clean its (so far) one caller
Patch 8 - the stub pages are covered with a VMA, allowing some nasty
	code to be thrown out - three-level page tables now work

This patch:

um_virt_to_phys only has one user, so it can be moved to the same file
and made static.  Its declarations in pgtable.h and ksyms.c are also
gone.

current_cmd was another apparent user, but it itself isn't used, so it
is deleted.

Signed-off-by: Jeff Dike <jdike@linux.intel.com>
---
 arch/um/kernel/ksyms.c        |    1 
 arch/um/kernel/process.c      |   43 ------------------------------------------
 arch/um/kernel/skas/uaccess.c |   34 +++++++++++++++++++++++++++++++--
 include/asm-um/pgtable.h      |    3 --
 4 files changed, 32 insertions(+), 49 deletions(-)

Index: linux-2.6.22/arch/um/kernel/process.c
===================================================================
--- linux-2.6.22.orig/arch/um/kernel/process.c	2007-11-15 16:34:14.000000000 -0500
+++ linux-2.6.22/arch/um/kernel/process.c	2007-11-16 13:14:41.000000000 -0500
@@ -256,49 +256,6 @@ void cpu_idle(void)
 	default_idle();
 }
 
-void *um_virt_to_phys(struct task_struct *task, unsigned long addr,
-		      pte_t *pte_out)
-{
-	pgd_t *pgd;
-	pud_t *pud;
-	pmd_t *pmd;
-	pte_t *pte;
-	pte_t ptent;
-
-	if (task->mm == NULL)
-		return ERR_PTR(-EINVAL);
-	pgd = pgd_offset(task->mm, addr);
-	if (!pgd_present(*pgd))
-		return ERR_PTR(-EINVAL);
-
-	pud = pud_offset(pgd, addr);
-	if (!pud_present(*pud))
-		return ERR_PTR(-EINVAL);
-
-	pmd = pmd_offset(pud, addr);
-	if (!pmd_present(*pmd))
-		return ERR_PTR(-EINVAL);
-
-	pte = pte_offset_kernel(pmd, addr);
-	ptent = *pte;
-	if (!pte_present(ptent))
-		return ERR_PTR(-EINVAL);
-
-	if (pte_out != NULL)
-		*pte_out = ptent;
-	return (void *) (pte_val(ptent) & PAGE_MASK) + (addr & ~PAGE_MASK);
-}
-
-char *current_cmd(void)
-{
-#if defined(CONFIG_SMP) || defined(CONFIG_HIGHMEM)
-	return "(Unknown)";
-#else
-	void *addr = um_virt_to_phys(current, current->mm->arg_start, NULL);
-	return IS_ERR(addr) ? "(Unknown)": __va((unsigned long) addr);
-#endif
-}
-
 int __cant_sleep(void) {
 	return in_atomic() || irqs_disabled() || in_interrupt();
 	/* Is in_interrupt() really needed? */
Index: linux-2.6.22/arch/um/kernel/skas/uaccess.c
===================================================================
--- linux-2.6.22.orig/arch/um/kernel/skas/uaccess.c	2007-11-15 16:34:14.000000000 -0500
+++ linux-2.6.22/arch/um/kernel/skas/uaccess.c	2007-11-16 13:14:41.000000000 -0500
@@ -12,8 +12,38 @@
 #include "kern_util.h"
 #include "os.h"
 
-extern void *um_virt_to_phys(struct task_struct *task, unsigned long addr,
-			     pte_t *pte_out);
+static void *um_virt_to_phys(struct task_struct *task, unsigned long addr,
+			     pte_t *pte_out)
+{
+	pgd_t *pgd;
+	pud_t *pud;
+	pmd_t *pmd;
+	pte_t *pte;
+	pte_t ptent;
+
+	if (task->mm == NULL)
+		return ERR_PTR(-EINVAL);
+	pgd = pgd_offset(task->mm, addr);
+	if (!pgd_present(*pgd))
+		return ERR_PTR(-EINVAL);
+
+	pud = pud_offset(pgd, addr);
+	if (!pud_present(*pud))
+		return ERR_PTR(-EINVAL);
+
+	pmd = pmd_offset(pud, addr);
+	if (!pmd_present(*pmd))
+		return ERR_PTR(-EINVAL);
+
+	pte = pte_offset_kernel(pmd, addr);
+	ptent = *pte;
+	if (!pte_present(ptent))
+		return ERR_PTR(-EINVAL);
+
+	if (pte_out != NULL)
+		*pte_out = ptent;
+	return (void *) (pte_val(ptent) & PAGE_MASK) + (addr & ~PAGE_MASK);
+}
 
 static unsigned long maybe_map(unsigned long virt, int is_write)
 {
Index: linux-2.6.22/include/asm-um/pgtable.h
===================================================================
--- linux-2.6.22.orig/include/asm-um/pgtable.h	2007-11-15 16:34:14.000000000 -0500
+++ linux-2.6.22/include/asm-um/pgtable.h	2007-11-16 13:14:41.000000000 -0500
@@ -31,9 +31,6 @@
 
 extern pgd_t swapper_pg_dir[PTRS_PER_PGD];
 
-extern void *um_virt_to_phys(struct task_struct *task, unsigned long virt,
-			     pte_t *pte_out);
-
 /* zero page used for uninitialized stuff */
 extern unsigned long *empty_zero_page;
 
Index: linux-2.6.22/arch/um/kernel/ksyms.c
===================================================================
--- linux-2.6.22.orig/arch/um/kernel/ksyms.c	2007-11-15 16:34:14.000000000 -0500
+++ linux-2.6.22/arch/um/kernel/ksyms.c	2007-11-16 13:14:39.000000000 -0500
@@ -25,7 +25,6 @@ EXPORT_SYMBOL(get_kmem_end);
 
 EXPORT_SYMBOL(high_physmem);
 EXPORT_SYMBOL(empty_zero_page);
-EXPORT_SYMBOL(um_virt_to_phys);
 EXPORT_SYMBOL(handle_page_fault);
 EXPORT_SYMBOL(find_iomem);
 

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
