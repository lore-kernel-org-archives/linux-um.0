Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D9BMb-0002Do-7g for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 09 Mar 2005 16:17:17 -0800
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1D9BMZ-0001Lj-Ii for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 09 Mar 2005 16:17:17 -0800
Message-Id: <200503100216.j2A2G2DN015232@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] [PATCH 4/9] UML - Export gcov symbol based on gcc version
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
Date: Wed, 09 Mar 2005 21:16:02 -0500
To: torvalds@osdl.org
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

The init function called by gcc when gcov is enabled is __gcov_init or
__bb_init_func, depending on the gcc version.  Anton is using 3.3.4 and 
seeing __gcov_init.  I'm using 3.3.2 and seeing __bb_init_func, so we need
to close that gap a bit.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.11/arch/um/kernel/gmon_syms.c
===================================================================
--- linux-2.6.11.orig/arch/um/kernel/gmon_syms.c	2005-03-07 10:53:03.000000000 -0500
+++ linux-2.6.11/arch/um/kernel/gmon_syms.c	2005-03-07 16:29:37.000000000 -0500
@@ -5,8 +5,14 @@
 
 #include "linux/module.h"
 
+#if __GNUC__ > 3 || (__GNUC__ == 3 && __GNUC_MINOR__ > 3) || \
+	(__GNUC__ == 3 && __GNUC_MINOR__ == 3 && __GNUC_PATCHLEVEL__ >= 4)
+extern void __gcov_init(void *);
+EXPORT_SYMBOL(__gcov_init);
+#else
 extern void __bb_init_func(void *);
 EXPORT_SYMBOL(__bb_init_func);
+#endif
 
 /*
  * Overrides for Emacs so that we follow Linus's tabbing style.



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
