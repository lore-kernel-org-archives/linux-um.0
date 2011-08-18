Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <viro@ftp.linux.org.uk>) id 1Qu7uM-0007Up-SA
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 18 Aug 2011 19:05:38 +0000
Received: from zeniv.linux.org.uk ([195.92.253.2])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Qu7uM-0000Ab-3d
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 18 Aug 2011 19:05:38 +0000
Date: Thu, 18 Aug 2011 20:05:29 +0100
MIME-Version: 1.0
Message-Id: <E1Qu7uD-0007hs-M2@ZenIV.linux.org.uk>
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
Subject: [uml-devel] Subject: [PATCH 39/91] um: shared/process.h is empty
	now; kill it
To: richard@nod.at
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net


Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/um/include/shared/process.h |    9 ---------
 arch/um/os-Linux/irq.c           |    1 -
 arch/um/os-Linux/process.c       |    1 -
 arch/um/os-Linux/sigio.c         |    1 -
 arch/um/os-Linux/signal.c        |    1 -
 arch/um/os-Linux/skas/process.c  |    1 -
 6 files changed, 0 insertions(+), 14 deletions(-)
 delete mode 100644 arch/um/include/shared/process.h

diff --git a/arch/um/include/shared/process.h b/arch/um/include/shared/process.h
deleted file mode 100644
index 2ba310e..0000000
--- a/arch/um/include/shared/process.h
+++ /dev/null
@@ -1,9 +0,0 @@
-/* 
- * Copyright (C) 2000 - 2008 Jeff Dike (jdike@{addtoit,linux.intel}.com)
- * Licensed under the GPL
- */
-
-#ifndef __PROCESS_H__
-#define __PROCESS_H__
-
-#endif
diff --git a/arch/um/os-Linux/irq.c b/arch/um/os-Linux/irq.c
index 59c592c..9a49908 100644
--- a/arch/um/os-Linux/irq.c
+++ b/arch/um/os-Linux/irq.c
@@ -10,7 +10,6 @@
 #include <string.h>
 #include "irq_user.h"
 #include "os.h"
-#include "process.h"
 #include "um_malloc.h"
 
 /*
diff --git a/arch/um/os-Linux/process.c b/arch/um/os-Linux/process.c
index e08fe30..307f173 100644
--- a/arch/um/os-Linux/process.c
+++ b/arch/um/os-Linux/process.c
@@ -15,7 +15,6 @@
 #include "init.h"
 #include "longjmp.h"
 #include "os.h"
-#include "process.h"
 #include "skas_ptrace.h"
 
 #define ARBITRARY_ADDR -1
diff --git a/arch/um/os-Linux/sigio.c b/arch/um/os-Linux/sigio.c
index 34bb59b..3c16121 100644
--- a/arch/um/os-Linux/sigio.c
+++ b/arch/um/os-Linux/sigio.c
@@ -14,7 +14,6 @@
 #include "kern_util.h"
 #include "init.h"
 #include "os.h"
-#include "process.h"
 #include "sigio.h"
 #include "um_malloc.h"
 
diff --git a/arch/um/os-Linux/signal.c b/arch/um/os-Linux/signal.c
index 9f2c222..4d31688 100644
--- a/arch/um/os-Linux/signal.c
+++ b/arch/um/os-Linux/signal.c
@@ -12,7 +12,6 @@
 #include "as-layout.h"
 #include "kern_util.h"
 #include "os.h"
-#include "process.h"
 #include "sysdep/barrier.h"
 #include "sysdep/mcontext.h"
 
diff --git a/arch/um/os-Linux/skas/process.c b/arch/um/os-Linux/skas/process.c
index 8a1ccc7..514683f 100644
--- a/arch/um/os-Linux/skas/process.c
+++ b/arch/um/os-Linux/skas/process.c
@@ -17,7 +17,6 @@
 #include "kern_util.h"
 #include "mem.h"
 #include "os.h"
-#include "process.h"
 #include "proc_mm.h"
 #include "ptrace_user.h"
 #include "registers.h"
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

