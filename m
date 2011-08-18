Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <viro@ftp.linux.org.uk>) id 1Qu7wl-00023a-Gr
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 18 Aug 2011 19:08:07 +0000
Received: from zeniv.linux.org.uk ([195.92.253.2])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Qu7wk-0004yF-MS
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 18 Aug 2011 19:08:07 +0000
Date: Thu, 18 Aug 2011 20:07:59 +0100
MIME-Version: 1.0
Message-Id: <E1Qu7wd-0007qe-PK@ZenIV.linux.org.uk>
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
Subject: [uml-devel] Subject: [PATCH 54/91] um: kill shared/tlb.h
To: richard@nod.at
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net


Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/um/include/shared/tlb.h |   13 -------------
 arch/um/kernel/process.c     |    2 +-
 arch/um/kernel/tlb.c         |    1 -
 3 files changed, 1 insertions(+), 15 deletions(-)
 delete mode 100644 arch/um/include/shared/tlb.h

diff --git a/arch/um/include/shared/tlb.h b/arch/um/include/shared/tlb.h
deleted file mode 100644
index 8a50ce1..0000000
--- a/arch/um/include/shared/tlb.h
+++ /dev/null
@@ -1,13 +0,0 @@
-/* 
- * Copyright (C) 2002 Jeff Dike (jdike@karaya.com)
- * Licensed under the GPL
- */
-
-#ifndef __TLB_H__
-#define __TLB_H__
-
-#include "um_mmu.h"
-
-extern void force_flush_all(void);
-
-#endif
diff --git a/arch/um/kernel/process.c b/arch/um/kernel/process.c
index fab4371..6f042e7 100644
--- a/arch/um/kernel/process.c
+++ b/arch/um/kernel/process.c
@@ -20,12 +20,12 @@
 #include <linux/threads.h>
 #include <asm/current.h>
 #include <asm/pgtable.h>
+#include <asm/mmu_context.h>
 #include <asm/uaccess.h>
 #include "as-layout.h"
 #include "kern_util.h"
 #include "os.h"
 #include "skas.h"
-#include "tlb.h"
 
 /*
  * This is a per-cpu array.  A processor only modifies its entry and it only
diff --git a/arch/um/kernel/tlb.c b/arch/um/kernel/tlb.c
index d1da8ac..11cadb2 100644
--- a/arch/um/kernel/tlb.c
+++ b/arch/um/kernel/tlb.c
@@ -11,7 +11,6 @@
 #include "mem_user.h"
 #include "os.h"
 #include "skas.h"
-#include "tlb.h"
 
 struct host_vm_change {
 	struct host_vm_op {
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

