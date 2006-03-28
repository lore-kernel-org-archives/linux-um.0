Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FON9D-0005a5-FA for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 28 Mar 2006 14:58:47 -0800
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1FON9C-00058j-B6
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 28 Mar 2006 14:58:47 -0800
Message-Id: <200603282300.k2SMxxOe022962@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] [PATCH 1/10] UML - Redeclare highmem
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
Date: Tue, 28 Mar 2006 17:59:59 -0500
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

The earlier printf patch missed a corresponding change in the printed
variable.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.16-mm/arch/um/include/user_util.h
===================================================================
--- linux-2.6.16-mm.orig/arch/um/include/user_util.h	2006-03-28 09:30:36.000000000 -0500
+++ linux-2.6.16-mm/arch/um/include/user_util.h	2006-03-28 15:59:38.000000000 -0500
@@ -31,7 +31,7 @@ extern unsigned long uml_physmem;
 extern unsigned long uml_reserved;
 extern unsigned long end_vm;
 extern unsigned long start_vm;
-extern unsigned long highmem;
+extern unsigned long long highmem;
 
 extern char host_info[];
 
Index: linux-2.6.16-mm/arch/um/kernel/mem.c
===================================================================
--- linux-2.6.16-mm.orig/arch/um/kernel/mem.c	2006-03-28 15:55:28.000000000 -0500
+++ linux-2.6.16-mm/arch/um/kernel/mem.c	2006-03-28 15:59:33.000000000 -0500
@@ -30,7 +30,7 @@ extern char __binary_start;
 unsigned long *empty_zero_page = NULL;
 unsigned long *empty_bad_page = NULL;
 pgd_t swapper_pg_dir[PTRS_PER_PGD];
-unsigned long highmem;
+unsigned long long highmem;
 int kmalloc_ok = 0;
 
 static unsigned long brk_end;



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
