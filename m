Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <viro@ftp.linux.org.uk>) id 1Qu7vn-0008An-G2
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 18 Aug 2011 19:07:07 +0000
Received: from zeniv.linux.org.uk ([195.92.253.2])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Qu7vm-0002Qu-KE
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 18 Aug 2011 19:07:07 +0000
Date: Thu, 18 Aug 2011 20:06:59 +0100
MIME-Version: 1.0
Message-Id: <E1Qu7vf-0007nd-MV@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
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
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
Subject: [uml-devel] Subject: [PATCH 48/91] um: make load_initrd() static,
 kill shared/initrd.h
To: richard@nod.at
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net


Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/um/include/shared/initrd.h |   12 ------------
 arch/um/kernel/initrd.c         |    4 ++--
 2 files changed, 2 insertions(+), 14 deletions(-)
 delete mode 100644 arch/um/include/shared/initrd.h

diff --git a/arch/um/include/shared/initrd.h b/arch/um/include/shared/initrd.h
deleted file mode 100644
index 22673bc..0000000
--- a/arch/um/include/shared/initrd.h
+++ /dev/null
@@ -1,12 +0,0 @@
-/*
- * Copyright (C) 2000 Jeff Dike (jdike@karaya.com)
- * Licensed under the GPL
- */
-
-#ifndef __INITRD_USER_H__
-#define __INITRD_USER_H__
-
-extern int load_initrd(char *filename, void *buf, int size);
-
-#endif
-
diff --git a/arch/um/kernel/initrd.c b/arch/um/kernel/initrd.c
index d386c75..10cc18f 100644
--- a/arch/um/kernel/initrd.c
+++ b/arch/um/kernel/initrd.c
@@ -7,12 +7,12 @@
 #include "linux/bootmem.h"
 #include "linux/initrd.h"
 #include "asm/types.h"
-#include "initrd.h"
 #include "init.h"
 #include "os.h"
 
 /* Changed by uml_initrd_setup, which is a setup */
 static char *initrd __initdata = NULL;
+static int load_initrd(char *filename, void *buf, int size);
 
 static int __init read_initrd(void)
 {
@@ -62,7 +62,7 @@ __uml_setup("initrd=", uml_initrd_setup,
 "    name of the file containing the image.\n\n"
 );
 
-int load_initrd(char *filename, void *buf, int size)
+static int load_initrd(char *filename, void *buf, int size)
 {
 	int fd, n;
 
-- 
1.7.2.5



------------------------------------------------------------------------------
Get a FREE DOWNLOAD! and learn more about uberSVN rich system, 
user administration capabilities and model configuration. Take 
the hassle out of deploying and managing Subversion and the 
tools developers use with it. http://p.sf.net/sfu/wandisco-d2d-2
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

