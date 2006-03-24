Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FMqmh-0003Vl-Sw for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 24 Mar 2006 10:13:15 -0800
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1FMqmh-0001GF-7j
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 24 Mar 2006 10:13:15 -0800
Message-Id: <200603241814.k2OIEaZw005510@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] [PATCH 3/16] UML - Fix some printf formats
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
Date: Fri, 24 Mar 2006 13:14:36 -0500
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

Some printf formats are incorrect for large memory sizes.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.15-mm/arch/um/kernel/um_arch.c
===================================================================
--- linux-2.6.15-mm.orig/arch/um/kernel/um_arch.c	2006-02-21 17:40:12.000000000 -0500
+++ linux-2.6.15-mm/arch/um/kernel/um_arch.c	2006-02-21 17:59:39.000000000 -0500
@@ -421,7 +421,7 @@ int linux_main(int argc, char **argv)
 #ifndef CONFIG_HIGHMEM
 		highmem = 0;
 		printf("CONFIG_HIGHMEM not enabled - physical memory shrunk "
-		       "to %lu bytes\n", physmem_size);
+		       "to %Lu bytes\n", physmem_size);
 #endif
 	}
 
@@ -433,8 +433,8 @@ int linux_main(int argc, char **argv)
 
 	setup_physmem(uml_physmem, uml_reserved, physmem_size, highmem);
 	if(init_maps(physmem_size, iomem_size, highmem)){
-		printf("Failed to allocate mem_map for %lu bytes of physical "
-		       "memory and %lu bytes of highmem\n", physmem_size,
+		printf("Failed to allocate mem_map for %Lu bytes of physical "
+		       "memory and %Lu bytes of highmem\n", physmem_size,
 		       highmem);
 		exit(1);
 	}



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
