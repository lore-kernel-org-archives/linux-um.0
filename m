Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GRvIo-0004LL-M5 for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 25 Sep 2006 11:35:38 -0700
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1GRvIo-0005x9-4P
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 25 Sep 2006 11:35:38 -0700
Message-Id: <200609251834.k8PIYYOa005036@ccure.user-mode-linux.org>
Mime-Version: 1.0
Date: Mon, 25 Sep 2006 14:34:34 -0400
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] [PATCH 4/8] UML - Fix gcov support
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
Cc: Paolo Giarrusso <blaisorblade@yahoo.it>, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

Make __bb_init_func weak in order to avoid a link failure with some libcs
and/or gccs.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.17/arch/um/kernel/gmon_syms.c
===================================================================
--- linux-2.6.17.orig/arch/um/kernel/gmon_syms.c	2006-09-11 11:14:48.000000000 -0400
+++ linux-2.6.17/arch/um/kernel/gmon_syms.c	2006-09-11 11:28:21.000000000 -0400
@@ -5,7 +5,7 @@
 
 #include "linux/module.h"
 
-extern void __bb_init_func(void *);
+extern void __bb_init_func(void *)  __attribute__((weak));
 EXPORT_SYMBOL(__bb_init_func);
 
 /* This is defined (and referred to in profiling stub code) only by some GCC
@@ -21,14 +21,3 @@ EXPORT_SYMBOL(__gcov_init);
 
 extern void __gcov_merge_add(void *) __attribute__((weak));
 EXPORT_SYMBOL(__gcov_merge_add);
-
-/*
- * Overrides for Emacs so that we follow Linus's tabbing style.
- * Emacs will notice this stuff at the end of the file and automatically
- * adjust the settings for this buffer only.  This must remain at the end
- * of the file.
- * ---------------------------------------------------------------------------
- * Local variables:
- * c-file-style: "linux"
- * End:
- */


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
