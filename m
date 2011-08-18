Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <viro@ftp.linux.org.uk>) id 1Qu7wR-000373-Ej
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 18 Aug 2011 19:07:47 +0000
Received: from zeniv.linux.org.uk ([195.92.253.2])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Qu7wQ-0000FA-MV
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 18 Aug 2011 19:07:47 +0000
Date: Thu, 18 Aug 2011 20:07:39 +0100
MIME-Version: 1.0
Message-Id: <E1Qu7wJ-0007oZ-NP@ZenIV.linux.org.uk>
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
Subject: [uml-devel] Subject: [PATCH 52/91] um: kill shared/task.h and
	HOST_TASK_REGS
To: richard@nod.at
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net


Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/um/include/shared/common-offsets.h |    1 -
 arch/um/include/shared/task.h           |    9 ---------
 arch/x86/um/bugs_32.c                   |    4 +++-
 3 files changed, 3 insertions(+), 11 deletions(-)
 delete mode 100644 arch/um/include/shared/task.h

diff --git a/arch/um/include/shared/common-offsets.h b/arch/um/include/shared/common-offsets.h
index 72009c7..d7fe563 100644
--- a/arch/um/include/shared/common-offsets.h
+++ b/arch/um/include/shared/common-offsets.h
@@ -2,7 +2,6 @@
 
 DEFINE(KERNEL_MADV_REMOVE, MADV_REMOVE);
 
-OFFSET(HOST_TASK_REGS, task_struct, thread.regs);
 OFFSET(HOST_TASK_PID, task_struct, pid);
 
 DEFINE(UM_KERN_PAGE_SIZE, PAGE_SIZE);
diff --git a/arch/um/include/shared/task.h b/arch/um/include/shared/task.h
deleted file mode 100644
index 3db6b58..0000000
--- a/arch/um/include/shared/task.h
+++ /dev/null
@@ -1,9 +0,0 @@
-#ifndef __TASK_H
-#define __TASK_H
-
-#include <generated/asm-offsets.h>
-
-#define TASK_REGS(task) ((struct uml_pt_regs *) &(((char *) (task))[HOST_TASK_REGS]))
-#define TASK_PID(task) *((int *) &(((char *) (task))[HOST_TASK_PID]))
-
-#endif
diff --git a/arch/x86/um/bugs_32.c b/arch/x86/um/bugs_32.c
index 7058e1f..a1fba5f 100644
--- a/arch/x86/um/bugs_32.c
+++ b/arch/x86/um/bugs_32.c
@@ -6,13 +6,15 @@
 #include <signal.h>
 #include "kern_util.h"
 #include "longjmp.h"
-#include "task.h"
 #include "sysdep/ptrace.h"
+#include <generated/asm-offsets.h>
 
 /* Set during early boot */
 static int host_has_cmov = 1;
 static jmp_buf cmov_test_return;
 
+#define TASK_PID(task) *((int *) &(((char *) (task))[HOST_TASK_PID]))
+
 static void cmov_sigill_test_handler(int sig)
 {
 	host_has_cmov = 0;
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

