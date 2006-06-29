Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Fw4BV-0006tH-MA for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 29 Jun 2006 14:36:25 -0700
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1Fw4BU-0005Kl-AO
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 29 Jun 2006 14:36:25 -0700
Message-Id: <200606292136.k5TLaTGc010802@ccure.user-mode-linux.org>
Mime-Version: 1.0
Date: Thu, 29 Jun 2006 17:36:29 -0400
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] [PATCH 3/9] UML - Remove pte_mkexec
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, ak@suse.de

Andi is making pte_mkexec go away, and UML had one of the last uses.

This removes the use and the definition.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.16-rc-mm/arch/um/kernel/skas/mmu.c
===================================================================
--- linux-2.6.16-rc-mm.orig/arch/um/kernel/skas/mmu.c	2006-06-26 14:49:53.000000000 -0400
+++ linux-2.6.16-rc-mm/arch/um/kernel/skas/mmu.c	2006-06-28 13:07:26.000000000 -0400
@@ -61,8 +61,10 @@ static int init_stub_pte(struct mm_struc
 #endif
 
 	*pte = mk_pte(virt_to_page(kernel), __pgprot(_PAGE_PRESENT));
-	*pte = pte_mkexec(*pte);
-	*pte = pte_wrprotect(*pte);
+	/* This is wrong for the code page, but it doesn't matter since the
+	 * stub is mapped by hand with the correct permissions.
+	 */
+	*pte = pte_mkwrite(*pte);
 	return(0);
 
  out_pmd:
Index: linux-2.6.16-rc-mm/include/asm-um/pgtable.h
===================================================================
--- linux-2.6.16-rc-mm.orig/include/asm-um/pgtable.h	2006-01-03 17:39:53.000000000 -0500
+++ linux-2.6.16-rc-mm/include/asm-um/pgtable.h	2006-06-26 14:54:42.000000000 -0400
@@ -274,12 +274,6 @@ static inline pte_t pte_mkread(pte_t pte
 	return(pte_mknewprot(pte)); 
 }
 
-static inline pte_t pte_mkexec(pte_t pte)
-{ 
-	pte_set_bits(pte, _PAGE_USER);
-	return(pte_mknewprot(pte)); 
-}
-
 static inline pte_t pte_mkdirty(pte_t pte)
 { 
 	pte_set_bits(pte, _PAGE_DIRTY);


Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
