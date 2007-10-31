Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1InJjC-0005YA-Lp for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 31 Oct 2007 12:59:50 -0700
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1InJjC-0008Ep-5T
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 31 Oct 2007 12:59:50 -0700
Date: Wed, 31 Oct 2007 15:59:39 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20071031195939.GA9645@c2.user-mode-linux.org>
Mime-Version: 1.0
Content-Disposition: inline
Subject: [uml-devel] [PATCH 4/4] UML - Fix build for !CONFIG_PRINTK
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
Cc: LKML <linux-kernel@vger.kernel.org>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>, Magotari <magotari@gmail.com>

Handle the case of CONFIG_PRINTK being disabled.  This requires a
do-nothing stub to be present in arch/um/include/user.h so that we
don't get references to printk from libc code.

Signed-off-by: Jeff Dike <jdike@linux.intel.com>
---
 arch/um/include/user.h |   13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

Index: linux-2.6.22/arch/um/include/user.h
===================================================================
--- linux-2.6.22.orig/arch/um/include/user.h	2007-10-22 13:21:04.000000000 -0400
+++ linux-2.6.22/arch/um/include/user.h	2007-10-22 13:21:14.000000000 -0400
@@ -1,11 +1,13 @@
 /* 
- * Copyright (C) 2000 Jeff Dike (jdike@karaya.com)
+ * Copyright (C) 2000 - 2007 Jeff Dike (jdike@{addtoit,linux.intel}.com)
  * Licensed under the GPL
  */
 
 #ifndef __USER_H__
 #define __USER_H__
 
+#include "uml-config.h"
+
 /*
  * The usual definition - copied here because the kernel provides its own,
  * fancier, type-safe, definition.  Using that one would require
@@ -23,8 +25,17 @@
 
 extern void panic(const char *fmt, ...)
 	__attribute__ ((format (printf, 1, 2)));
+
+#ifdef UML_CONFIG_PRINTK
 extern int printk(const char *fmt, ...)
 	__attribute__ ((format (printf, 1, 2)));
+#else
+static inline int printk(const char *fmt, ...)
+{
+	return 0;
+}
+#endif
+
 extern void schedule(void);
 extern int in_aton(char *str);
 extern int open_gdb_chan(void);

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
