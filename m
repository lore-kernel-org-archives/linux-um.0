Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1H46SR-0006f3-9s for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 08 Jan 2007 18:11:23 -0800
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1H46SQ-0000zY-Nd
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 08 Jan 2007 18:11:23 -0800
Message-Id: <200701090205.l0925nDL024406@ccure.user-mode-linux.org>
Mime-Version: 1.0
Date: Mon, 08 Jan 2007 21:05:49 -0500
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] [PATCH 7/7] UML - Remove code controlled by
	non-existent config option
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
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

CONFIG_HOST_TASK_SIZE doesn't exist any more.

Signed-off-by: Jeff Dike <jdike@addtoit.com>
--
 arch/um/kernel/skas/mem.c |    6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

Index: linux-2.6.18-mm/arch/um/kernel/skas/mem.c
===================================================================
--- linux-2.6.18-mm.orig/arch/um/kernel/skas/mem.c	2006-12-29 12:20:14.000000000 -0500
+++ linux-2.6.18-mm/arch/um/kernel/skas/mem.c	2007-01-08 16:48:42.000000000 -0500
@@ -14,13 +14,9 @@ unsigned long set_task_sizes_skas(unsign
 	unsigned long host_task_size = ROUND_4M((unsigned long)
 						&host_task_size);
 
-#ifdef CONFIG_HOST_TASK_SIZE
-	*host_size_out = ROUND_4M(CONFIG_HOST_TASK_SIZE);
-	*task_size_out = CONFIG_HOST_TASK_SIZE;
-#else
 	if (!skas_needs_stub)
 		*task_size_out = host_task_size;
 	else *task_size_out = CONFIG_STUB_START & PGDIR_MASK;
-#endif
+
 	return host_task_size;
 }


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
