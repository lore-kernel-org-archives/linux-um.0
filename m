Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Ipplz-0000D4-6m for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 07 Nov 2007 10:37:07 -0800
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1Ipply-0007pA-8f
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 07 Nov 2007 10:37:06 -0800
Date: Wed, 7 Nov 2007 13:36:37 -0500
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20071107183637.GA8462@c2.user-mode-linux.org>
Mime-Version: 1.0
Content-Disposition: inline
Subject: [uml-devel] [PATCH 1/5] UML - Delete some unused headers
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
Cc: "Robert P. J. Day" <rpjday@crashcourse.ca>, LKML <linux-kernel@vger.kernel.org>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>

Robert Day noticed a few unused headers in UML, so this gets rid of them.

Cc: "Robert P. J. Day" <rpjday@crashcourse.ca>
Signed-off-by: Jeff Dike <jdike@linux.intel.com>
---
 arch/um/include/misc_constants.h |    6 ------
 arch/um/include/signal_kern.h    |   22 ----------------------
 arch/um/include/skas/mode-skas.h |   11 -----------
 3 files changed, 39 deletions(-)

Index: linux-2.6/arch/um/include/misc_constants.h
===================================================================
--- linux-2.6.orig/arch/um/include/misc_constants.h	2007-03-27 17:07:26.000000000 -0400
+++ /dev/null	1970-01-01 00:00:00.000000000 +0000
@@ -1,6 +0,0 @@
-#ifndef __MISC_CONSTANT_H_
-#define __MISC_CONSTANT_H_
-
-#include <user_constants.h>
-
-#endif
Index: linux-2.6/arch/um/include/signal_kern.h
===================================================================
--- linux-2.6.orig/arch/um/include/signal_kern.h	2007-03-27 17:07:26.000000000 -0400
+++ /dev/null	1970-01-01 00:00:00.000000000 +0000
@@ -1,22 +0,0 @@
-/* 
- * Copyright (C) 2001, 2002 Jeff Dike (jdike@karaya.com)
- * Licensed under the GPL
- */
-
-#ifndef __SIGNAL_KERN_H__
-#define __SIGNAL_KERN_H__
-
-extern int have_signals(void *t);
-
-#endif
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
Index: linux-2.6/arch/um/include/skas/mode-skas.h
===================================================================
--- linux-2.6.orig/arch/um/include/skas/mode-skas.h	2007-11-05 14:01:47.000000000 -0500
+++ /dev/null	1970-01-01 00:00:00.000000000 +0000
@@ -1,11 +0,0 @@
-/*
- * Copyright (C) 2002 - 2007 Jeff Dike (jdike@{linux.intel,addtoit}.com)
- * Licensed under the GPL
- */
-
-#ifndef __MODE_SKAS_H__
-#define __MODE_SKAS_H__
-
-extern void kill_off_processes_skas(void);
-
-#endif

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
