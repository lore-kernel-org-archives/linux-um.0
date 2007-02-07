Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HEssW-0003ri-0j for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 07 Feb 2007 11:54:52 -0800
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HEssU-0002yG-F6
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 07 Feb 2007 11:54:52 -0800
Message-Id: <200702071947.l17JllD3006615@ccure.user-mode-linux.org>
Mime-Version: 1.0
Date: Wed, 07 Feb 2007 14:47:47 -0500
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] [PATCH 4/7] UML - umid tidying
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

Add an error message when two umids are put on the command line.

umid.h is kind of pointless since it only declares one thing, and that
is already declared in os.h.

Commented the lack of locking of some data in os-Linux/umid.h.

Signed-off-by: Jeff Dike <jdike@addtoit.com>
--
 arch/um/drivers/mconsole_kern.c |    1 -
 arch/um/drivers/mconsole_user.c |    2 +-
 arch/um/include/umid.h          |   22 ----------------------
 arch/um/kernel/um_arch.c        |    1 -
 arch/um/kernel/umid.c           |    4 +++-
 arch/um/os-Linux/umid.c         |    3 ++-
 6 files changed, 6 insertions(+), 27 deletions(-)

Index: linux-2.6.18-mm/arch/um/kernel/umid.c
===================================================================
--- linux-2.6.18-mm.orig/arch/um/kernel/umid.c	2007-01-09 17:08:56.000000000 -0500
+++ linux-2.6.18-mm/arch/um/kernel/umid.c	2007-01-09 17:09:52.000000000 -0500
@@ -16,8 +16,10 @@ static int __init set_umid_arg(char *nam
 {
 	int err;
 
-	if(umid_inited)
+	if(umid_inited){
+		printf("umid already set\n");
 		return 0;
+	}
 
 	*add = 0;
 	err = set_umid(name);
Index: linux-2.6.18-mm/arch/um/drivers/mconsole_kern.c
===================================================================
--- linux-2.6.18-mm.orig/arch/um/drivers/mconsole_kern.c	2007-01-09 17:25:15.000000000 -0500
+++ linux-2.6.18-mm/arch/um/drivers/mconsole_kern.c	2007-01-10 12:37:00.000000000 -0500
@@ -33,7 +33,6 @@
 #include "irq_user.h"
 #include "init.h"
 #include "os.h"
-#include "umid.h"
 #include "irq_kern.h"
 #include "choose-mode.h"
 
Index: linux-2.6.18-mm/arch/um/drivers/mconsole_user.c
===================================================================
--- linux-2.6.18-mm.orig/arch/um/drivers/mconsole_user.c	2007-01-09 17:25:15.000000000 -0500
+++ linux-2.6.18-mm/arch/um/drivers/mconsole_user.c	2007-01-10 12:30:17.000000000 -0500
@@ -16,7 +16,7 @@
 #include "user.h"
 #include "sysdep/ptrace.h"
 #include "mconsole.h"
-#include "umid.h"
+#include "os.h"
 #include "user_util.h"
 
 static struct mconsole_command commands[] = {
Index: linux-2.6.18-mm/arch/um/include/umid.h
===================================================================
--- linux-2.6.18-mm.orig/arch/um/include/umid.h	2006-06-17 21:49:35.000000000 -0400
+++ /dev/null	1970-01-01 00:00:00.000000000 +0000
@@ -1,22 +0,0 @@
-/*
- * Copyright (C) 2001 Jeff Dike (jdike@karaya.com)
- * Licensed under the GPL
- */
-
-#ifndef __UMID_H__
-#define __UMID_H__
-
-extern int umid_file_name(char *name, char *buf, int len);
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
Index: linux-2.6.18-mm/arch/um/kernel/um_arch.c
===================================================================
--- linux-2.6.18-mm.orig/arch/um/kernel/um_arch.c	2007-01-09 17:25:16.000000000 -0500
+++ linux-2.6.18-mm/arch/um/kernel/um_arch.c	2007-01-10 12:36:46.000000000 -0500
@@ -30,7 +30,6 @@
 #include "kern.h"
 #include "mem_user.h"
 #include "mem.h"
-#include "umid.h"
 #include "initrd.h"
 #include "init.h"
 #include "os.h"
Index: linux-2.6.18-mm/arch/um/os-Linux/umid.c
===================================================================
--- linux-2.6.18-mm.orig/arch/um/os-Linux/umid.c	2006-09-24 22:23:24.000000000 -0400
+++ linux-2.6.18-mm/arch/um/os-Linux/umid.c	2007-01-10 12:28:40.000000000 -0500
@@ -18,7 +18,7 @@
 #define UMID_LEN 64
 
 /* Changed by set_umid, which is run early in boot */
-char umid[UMID_LEN] = { 0 };
+static char umid[UMID_LEN] = { 0 };
 
 /* Changed by set_uml_dir and make_uml_dir, which are run early in boot */
 static char *uml_dir = UML_DIR;
@@ -235,6 +235,7 @@ int __init set_umid(char *name)
 	return 0;
 }
 
+/* Changed in make_umid, which is called during early boot */
 static int umid_setup = 0;
 
 int __init make_umid(void)


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier.
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
