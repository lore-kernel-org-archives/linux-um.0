Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HhA85-0005FA-0t for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 26 Apr 2007 12:59:55 -0700
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1HhA7z-0002Fd-33
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 26 Apr 2007 12:59:43 -0700
Date: Thu, 26 Apr 2007 15:56:21 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20070426195621.GA9558@c2.user-mode-linux.org>
Mime-Version: 1.0
Content-Disposition: inline
Subject: [uml-devel] [PATCH 1/5] UML - Eliminate a piece of debugging code
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
To: Andrew Morton <akpm@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>

I missed removing another piece of debugging in an earlier patch.

Signed-off-by: Jeff Dike <jdike@linux.intel.com>
--
 arch/um/kernel/tlb.c |    1 -
 1 file changed, 1 deletion(-)

Index: linux-2.6.21-mm/arch/um/kernel/tlb.c
===================================================================
--- linux-2.6.21-mm.orig/arch/um/kernel/tlb.c	2007-04-25 13:34:08.000000000 -0400
+++ linux-2.6.21-mm/arch/um/kernel/tlb.c	2007-04-25 13:34:27.000000000 -0400
@@ -252,7 +252,6 @@ void fix_range_common(struct mm_struct *
 					    &op_index, force, mmu, &flush,
 					    do_ops);
 	} while (pgd++, addr = next, ((addr != end_addr) && !ret));
-	log_info("total flush time - %Ld nsecs\n", end_time - start_time);
 
 	if(!ret)
 		ret = (*do_ops)(mmu, ops, op_index, 1, &flush);

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
