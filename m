Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JFcU7-00018r-7w for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 17 Jan 2008 13:41:15 -0800
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1JFcU6-0001pM-HL
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 17 Jan 2008 13:41:15 -0800
Date: Thu, 17 Jan 2008 16:40:45 -0500
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20080117214045.GA6757@c2.user-mode-linux.org>
Mime-Version: 1.0
Content-Disposition: inline
Subject: [uml-devel] [PATCH 14/20] UML - Remove map_cb
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
Cc: John Reiser <jreiser@BitWagon.com>, LKML <linux-kernel@vger.kernel.org>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>

John Reiser noticed that a physical memory region was being mapped twice.

This patch fixes that, and it inlines the responsible function, as
that had only one caller.

Cc: John Reiser <jreiser@BitWagon.com>
Signed-off-by: Jeff Dike <jdike@linux.intel.com>
---
 arch/um/kernel/mem.c |    8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

Index: linux-2.6.22/arch/um/kernel/mem.c
===================================================================
--- linux-2.6.22.orig/arch/um/kernel/mem.c	2008-01-02 11:44:36.000000000 -0500
+++ linux-2.6.22/arch/um/kernel/mem.c	2008-01-02 12:08:45.000000000 -0500
@@ -36,11 +36,6 @@ int kmalloc_ok = 0;
 /* Used during early boot */
 static unsigned long brk_end;
 
-static void map_cb(void *unused)
-{
-	map_memory(brk_end, __pa(brk_end), uml_reserved - brk_end, 1, 1, 0);
-}
-
 #ifdef CONFIG_HIGHMEM
 static void setup_highmem(unsigned long highmem_start,
 			  unsigned long highmem_len)
@@ -68,8 +63,7 @@ void __init mem_init(void)
 	 * to be turned on.
 	 */
 	brk_end = (unsigned long) UML_ROUND_UP(sbrk(0));
-	map_cb(NULL);
-	initial_thread_cb(map_cb, NULL);
+	map_memory(brk_end, __pa(brk_end), uml_reserved - brk_end, 1, 1, 0);
 	free_bootmem(__pa(brk_end), uml_reserved - brk_end);
 	uml_reserved = brk_end;
 

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
