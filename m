Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1APNYC-0002o2-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Thu, 27 Nov 2003 06:55:24 -0800
Received: from hirsch.in-berlin.de ([192.109.42.6] ident=root)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.24)
	id 1APNYC-0007hN-6B
	for user-mode-linux-devel@lists.sourceforge.net; Thu, 27 Nov 2003 06:55:24 -0800
From: Gerd Knorr <kraxel@bytesex.org>
Message-ID: <20031127144016.GA29444@bytesex.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [uml-devel] [patch] Missing EXPORT_SYMBOL()s for UML
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: The user-mode Linux development list <user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Thu, 27 Nov 2003 15:40:16 +0100
To: Jeff Dike <jdike@addtoit.com>, uml devel <user-mode-linux-devel@lists.sourceforge.net>
Cc: agruen@sonycom.com

  Hi,

This adds some required needed symbols.

  Gerd

----- Forwarded message from Andreas Gruenbacher <agruen@suse.de> -----

Hi,

here are two additional exports that are needed in kernel modules. Could
you please send the patch upstream? Thanks!

Index: linux-2.6.0-test10/arch/um/kernel/mem.c
===================================================================
--- linux-2.6.0-test10.orig/arch/um/kernel/mem.c	2003-11-26 16:25:21.000000000 +0100
+++ linux-2.6.0-test10/arch/um/kernel/mem.c	2003-11-27 14:28:53.000000000 +0100
@@ -119,6 +119,7 @@ unsigned long get_kmem_end(void)
 		kmem_top = CHOOSE_MODE(kmem_end_tt, kmem_end_skas);
 	return(kmem_top);
 }
+EXPORT_SYMBOL(get_kmem_end);
 
 #ifdef CONFIG_HIGHMEM
 /* Changed during early boot */
@@ -714,6 +715,7 @@ struct page *pfn_to_page(unsigned long p
 
 	return(&mem_map[pfn - region->start_pfn]);
 }
+EXPORT_SYMBOL(pfn_to_page);
 
 unsigned long phys_to_pfn(unsigned long p)
 {


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
