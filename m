Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CG0FM-0000Q7-Vi for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 08 Oct 2004 12:17:44 -0700
Received: from plam.fujitsu-siemens.com ([217.115.66.9])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1CG0FL-0006kl-OH for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 08 Oct 2004 12:17:44 -0700
Message-Id: <200410081912.i98JCUr20451@trolli.pdb.fsc.net>
From: bodo.stroesser@fujitsu-siemens.com
Subject: [uml-devel] Implement vsyscall/sysenter, patch 2/4
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
Date: Fri, 08 Oct 2004 21:12:29 +0200
To: user-mode-linux-devel@lists.sourceforge.net
Cc: jdike@addtoit.com, blaisorblade_spam@yahoo.it

To make the vsyscall-page available for copy_from_user() and
ptrace(), we should use kernel's "gate-vma" mechanism.
Therefore we need a valid page structure. To have this, one
page (or more) is allocated at boot time, the contents of the
vsyscall-page is copied into this page and the page's pte is
inserted in swapper's pagetables.
Now it will be copied into the pagetables of all processes.

Note: this alone doesn't work, since FIXADDR_USER_START and
      FIXADDR_USER_END are not yet defined correctly. Also
      access_ok_skas() does not yet grant read accesses to
      pages not in the normal user area.

Risks:
Please check the first hunk! I don't know, whether this change is OK.
Maybe fixrange_init() is wrong anyway with 3-level-pagetables?


Signed-off-by: Bodo Stroesser <bodo.stroesser@fujitsu-siemens.com>

---


--- linux-2.6.9-rc2-orig/arch/um/kernel/mem.c	2004-09-27 19:24:56.000000000 +0200
+++ linux-2.6.9-rc2/arch/um/kernel/mem.c	2004-10-05 15:36:57.032218318 +0200
@@ -121,7 +121,7 @@
 
 	for ( ; (i < PTRS_PER_PGD) && (vaddr < end); pgd++, i++) {
 		pmd = (pmd_t *)pgd;
-		for (; (j < PTRS_PER_PMD) && (vaddr != end); pmd++, j++) {
+		for (; (j < PTRS_PER_PMD) && (vaddr < end); pmd++, j++) {
 			if (pmd_none(*pmd)) {
 				pte = (pte_t *) alloc_bootmem_low_pages(PAGE_SIZE);
 				set_pmd(pmd, __pmd(_KERNPG_TABLE + 
@@ -175,6 +175,29 @@
 }
 #endif /* CONFIG_HIGHMEM */
 
+static void __init fixaddr_user_init( void)
+{
+	long size = FIXADDR_USER_END - FIXADDR_USER_START;
+	pgd_t *pgd;
+	pmd_t *pmd;
+	pte_t *pte;
+	unsigned long paddr, vaddr = FIXADDR_USER_START;
+
+	if (  ! size )
+		return;
+
+	fixrange_init( FIXADDR_USER_START, FIXADDR_USER_END, swapper_pg_dir);
+	paddr = (unsigned long)alloc_bootmem_low_pages( size);
+	memcpy( (void *)paddr, (void *)FIXADDR_USER_START, size);
+	paddr = __pa(paddr);
+	for ( ; size > 0; size-=PAGE_SIZE, vaddr+=PAGE_SIZE, paddr+=PAGE_SIZE) {
+		pgd = swapper_pg_dir + pgd_index(vaddr);
+		pmd = pmd_offset(pgd, vaddr);
+		pte = pte_offset_kernel(pmd, vaddr);
+		pte_set_val( (*pte), paddr, PAGE_READONLY);
+	}
+}
+
 void paging_init(void)
 {
 	unsigned long zones_size[MAX_NR_ZONES], vaddr;
@@ -195,6 +218,8 @@
 	vaddr = __fix_to_virt(__end_of_fixed_addresses - 1) & PMD_MASK;
 	fixrange_init(vaddr, FIXADDR_TOP, swapper_pg_dir);
 
+	fixaddr_user_init();
+
 #ifdef CONFIG_HIGHMEM
 	init_highmem();
 #endif


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
