Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CUGY6-0001gm-Ry for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 16 Nov 2004 19:32:02 -0800
Received: from pool-151-203-245-3.bos.east.verizon.net ([151.203.245.3]
	helo=ccure.user-mode-linux.org)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.41) id 1CUGY5-0005Na-Be
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 16 Nov 2004 19:32:02 -0800
Message-Id: <200411170545.iAH5jQm7007146@ccure.user-mode-linux.org>
In-Reply-To: Your message of "Tue, 16 Nov 2004 13:41:11 GMT."
	<1100612471.24599.42.camel@imp.csi.cam.ac.uk> 
References: <1100612471.24599.42.camel@imp.csi.cam.ac.uk> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] Re: Another bug report for UML in latest Linux 2.6-BK
	repository.
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
Date: Wed, 17 Nov 2004 00:45:26 -0500
To: Anton Altaparmakov <aia21@cam.ac.uk>
Cc: user-mode-linux-devel@lists.sourceforge.net, lkml <linux-kernel@vger.kernel.org>

aia21@cam.ac.uk said:
> If I enable HIGHMEM in my .config (see my previous bug report for my
> .config and just change HIGHMEM to enabled) compilation fails: 

The patch below fixes it.

				Jeff

Index: 2.6.9/arch/um/Kconfig
===================================================================
--- 2.6.9.orig/arch/um/Kconfig	2004-11-16 21:25:38.000000000 -0500
+++ 2.6.9/arch/um/Kconfig	2004-11-16 21:44:53.000000000 -0500
@@ -224,7 +224,15 @@
 
 config HIGHMEM
 	bool "Highmem support"
-	depends on BROKEN
+	default n
+	help
+	This enables UML's highmem support.  This allows UML to have
+	more physical memory than it can map into its virtual address
+	space.  In tt mode, or with CONFIG_MODE_TT enabled, the limit is a
+	bit less than 512M.  With CONFIG_MODE_TT disabled and
+	CONFIG_LOAD_LOW and CONFIG_STATIC_LINK enabled, the limit is
+	around 2.75G.
+	Enabling this option slows down UML, signficantly in skas mode.
 
 config KERNEL_STACK_ORDER
 	int "Kernel stack size order"
Index: 2.6.9/arch/um/kernel/mem.c
===================================================================
--- 2.6.9.orig/arch/um/kernel/mem.c	2004-11-16 21:54:53.000000000 -0500
+++ 2.6.9/arch/um/kernel/mem.c	2004-11-16 21:55:45.000000000 -0500
@@ -68,7 +68,7 @@
 
 	max_low_pfn = (high_physmem - uml_physmem) >> PAGE_SHIFT;
 #ifdef CONFIG_HIGHMEM
-	highmem_start_page = phys_page(__pa(high_physmem));
+	highmem_start_page = pfn_to_page(phys_to_pfn(__pa(high_physmem)));
 #endif
 
         /* clear the zero-page */
@@ -140,7 +140,7 @@
 pgprot_t kmap_prot;
 
 #define kmap_get_fixmap_pte(vaddr)					\
-	pte_offset_kernel(pmd_offset(pml4_pgd_offset(pml4_offset_k(vaddr),
+	pte_offset_kernel(pmd_offset(pml4_pgd_offset(pml4_offset_k(vaddr), \
 						     vaddr), (vaddr)), (vaddr))
 
 void __init kmap_init(void)



-------------------------------------------------------
This SF.Net email is sponsored by: InterSystems CACHE
FREE OODBMS DOWNLOAD - A multidimensional database that combines
robust object and relational technologies, making it a perfect match
for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
