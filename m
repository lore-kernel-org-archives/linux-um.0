Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Cx9d2-0004VW-0g for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 04 Feb 2005 12:00:32 -0800
Received: from www.ssc.unict.it ([151.97.230.9] helo=ssc.unict.it)
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.41)
	id 1Cx9d0-0000yO-RR for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 04 Feb 2005 12:00:31 -0800
From: blaisorblade@yahoo.it
Message-Id: <20050204183553.71E3C310C1@zion>
Subject: [uml-devel] [patch 6/8] uml: fix broken #ifdef clause causing crashes
	[before 2.6.11]
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
Date: Fri, 04 Feb 2005 19:35:53 +0100
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, jdike@addtoit.com, user-mode-linux-devel@lists.sourceforge.net, blaisorblade@yahoo.it


From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>, Jeff Dike <jdike@addtoit.com>

The previous ifdef to check whether to use the host's vsyscall page 
was buggy. This bug can cause crashes.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 linux-2.6.11-paolo/arch/um/Kconfig_i386   |    4 ++++
 linux-2.6.11-paolo/arch/um/Kconfig_x86_64 |    4 ++++
 linux-2.6.11-paolo/arch/um/kernel/mem.c   |   12 ++++++++----
 3 files changed, 16 insertions(+), 4 deletions(-)

diff -puN arch/um/Kconfig_i386~uml-vsyscall arch/um/Kconfig_i386
--- linux-2.6.11/arch/um/Kconfig_i386~uml-vsyscall	2005-02-04 06:22:14.731673232 +0100
+++ linux-2.6.11-paolo/arch/um/Kconfig_i386	2005-02-04 06:22:14.738672168 +0100
@@ -18,3 +18,7 @@ config 3_LEVEL_PGTABLES
 config ARCH_HAS_SC_SIGNALS
 	bool
 	default y
+
+config ARCH_REUSE_HOST_VSYSCALL_AREA
+	bool
+	default y
diff -puN arch/um/Kconfig_x86_64~uml-vsyscall arch/um/Kconfig_x86_64
--- linux-2.6.11/arch/um/Kconfig_x86_64~uml-vsyscall	2005-02-04 06:22:14.733672928 +0100
+++ linux-2.6.11-paolo/arch/um/Kconfig_x86_64	2005-02-04 06:22:14.739672016 +0100
@@ -9,3 +9,7 @@ config 3_LEVEL_PGTABLES
 config ARCH_HAS_SC_SIGNALS
 	bool
 	default n
+
+config ARCH_REUSE_HOST_VSYSCALL_AREA
+	bool
+	default n
diff -puN arch/um/kernel/mem.c~uml-vsyscall arch/um/kernel/mem.c
--- linux-2.6.11/arch/um/kernel/mem.c~uml-vsyscall	2005-02-04 06:22:14.735672624 +0100
+++ linux-2.6.11-paolo/arch/um/kernel/mem.c	2005-02-04 06:22:14.739672016 +0100
@@ -152,6 +152,7 @@ void __init kmap_init(void)
 static void init_highmem(void)
 {
 	pgd_t *pgd;
+	pud_t *pud;
 	pmd_t *pmd;
 	pte_t *pte;
 	unsigned long vaddr;
@@ -163,7 +164,8 @@ static void init_highmem(void)
 	fixrange_init(vaddr, vaddr + PAGE_SIZE*LAST_PKMAP, swapper_pg_dir);
 
 	pgd = swapper_pg_dir + pgd_index(vaddr);
-	pmd = pmd_offset(pgd, vaddr);
+	pud = pud_offset(pgd, vaddr);
+	pmd = pmd_offset(pud, vaddr);
 	pte = pte_offset_kernel(pmd, vaddr);
 	pkmap_page_table = pte;
 
@@ -173,9 +175,10 @@ static void init_highmem(void)
 
 static void __init fixaddr_user_init( void)
 {
-#if FIXADDR_USER_START != 0
+#if CONFIG_ARCH_REUSE_HOST_VSYSCALL_AREA
 	long size = FIXADDR_USER_END - FIXADDR_USER_START;
 	pgd_t *pgd;
+	pud_t *pud;
 	pmd_t *pmd;
 	pte_t *pte;
 	unsigned long paddr, vaddr = FIXADDR_USER_START;
@@ -187,9 +190,10 @@ static void __init fixaddr_user_init( vo
 	paddr = (unsigned long)alloc_bootmem_low_pages( size);
 	memcpy( (void *)paddr, (void *)FIXADDR_USER_START, size);
 	paddr = __pa(paddr);
-	for ( ; size > 0; size-=PAGE_SIZE, vaddr+=PAGE_SIZE, paddr+=PAGE_SIZE) {
+	for ( ; size > 0; size-=PAGE_SIZE, vaddr+=PAGE_SIZE, paddr+=PAGE_SIZE){
 		pgd = swapper_pg_dir + pgd_index(vaddr);
-		pmd = pmd_offset(pgd, vaddr);
+		pud = pud_offset(pgd, vaddr);
+		pmd = pmd_offset(pud, vaddr);
 		pte = pte_offset_kernel(pmd, vaddr);
 		pte_set_val( (*pte), paddr, PAGE_READONLY);
 	}
_


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
