Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <viro@ftp.linux.org.uk>) id 1Qu7wv-0003BC-Gn
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 18 Aug 2011 19:08:17 +0000
Received: from zeniv.linux.org.uk ([195.92.253.2])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Qu7wu-0000Fm-Jr
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 18 Aug 2011 19:08:17 +0000
Date: Thu, 18 Aug 2011 20:08:09 +0100
MIME-Version: 1.0
Message-Id: <E1Qu7wn-0007rS-OT@ZenIV.linux.org.uk>
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
Subject: [uml-devel] Subject: [PATCH 55/91] um: kill shared/mem_kern.h
To: richard@nod.at
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net


... nothing declared there exists

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/um/drivers/ubd_kern.c        |    1 -
 arch/um/include/shared/mem_kern.h |   20 --------------------
 2 files changed, 0 insertions(+), 21 deletions(-)
 delete mode 100644 arch/um/include/shared/mem_kern.h

diff --git a/arch/um/drivers/ubd_kern.c b/arch/um/drivers/ubd_kern.c
index 0136be1..b3c8545 100644
--- a/arch/um/drivers/ubd_kern.c
+++ b/arch/um/drivers/ubd_kern.c
@@ -53,7 +53,6 @@
 #include "ubd_user.h"
 #include "os.h"
 #include "mem.h"
-#include "mem_kern.h"
 #include "cow.h"
 
 enum ubd_req { UBD_READ, UBD_WRITE };
diff --git a/arch/um/include/shared/mem_kern.h b/arch/um/include/shared/mem_kern.h
deleted file mode 100644
index 69be0fd..0000000
--- a/arch/um/include/shared/mem_kern.h
+++ /dev/null
@@ -1,20 +0,0 @@
-/*
- * Copyright (C) 2003 Jeff Dike (jdike@addtoit.com)
- * Licensed under the GPL
- */
-
-#ifndef __MEM_KERN_H__
-#define __MEM_KERN_H__
-
-#include "linux/list.h"
-#include "linux/types.h"
-
-struct remapper {
-	struct list_head list;
-	int (*proc)(int, unsigned long, int, __u64);
-};
-
-extern void register_remapper(struct remapper *info);
-
-#endif
-
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

