Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DATdd-0003uz-La for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 13 Mar 2005 06:00:13 -0800
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1DATdb-0007px-Bd for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 13 Mar 2005 06:00:13 -0800
Message-Id: <200503130654.j2D6rrAM005199@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] Fixing the __gcov_init problem
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
Date: Sun, 13 Mar 2005 01:53:53 -0500
To: Blaisorblade <blaisorblade@yahoo.it>, Adrian Bunk <bunk@stusta.de>
Cc: user-mode-linux-devel@lists.sourceforge.net

OK, below is my latest attempt at getting this right.  It provides a weak
definition of __gcov_init for gcc's that don't generate it, while gcc's that
do will have their's override this one.

The patch is against -bk8.

				Jeff

# Try to finally fix the __gcov_init thing corectly.
# This patch makes a weak definition of __gcov_init, which will be used if
# there is no other definition, and which will be overridden if there is a
# real definition.  Thus, if it is not used, then the weak definition will
# satisfy the EXPORT_SYMBOL, and if it is, then the real one will.
Index: linux-2.6.11/arch/um/kernel/gmon_syms.c
===================================================================
--- linux-2.6.11.orig/arch/um/kernel/gmon_syms.c	2005-03-12 18:59:48.000000000 -0500
+++ linux-2.6.11/arch/um/kernel/gmon_syms.c	2005-03-12 22:44:31.000000000 -0500
@@ -10,17 +10,13 @@
 extern void __gcov_init(void *);
 EXPORT_SYMBOL(__gcov_init);
 #else
+#endif
+
 extern void __bb_init_func(void *);
 EXPORT_SYMBOL(__bb_init_func);
-#endif
 
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
+void  __attribute__((weak)) __gcov_init(void *arg)
+{
+}
+
+EXPORT_SYMBOL(__gcov_init);



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
