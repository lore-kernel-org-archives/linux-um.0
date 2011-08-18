Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <viro@ftp.linux.org.uk>) id 1Qu7q9-0006g9-32
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 18 Aug 2011 19:01:17 +0000
Received: from zeniv.linux.org.uk ([195.92.253.2])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Qu7q8-0004h9-7T
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 18 Aug 2011 19:01:17 +0000
Date: Thu, 18 Aug 2011 20:01:09 +0100
MIME-Version: 1.0
Message-Id: <E1Qu7q1-0007Vf-7b@ZenIV.linux.org.uk>
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
Subject: [uml-devel] Subject: [PATCH 13/91] um: kill skas_ptregs.h
To: richard@nod.at
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net


It's a plain include of user_constants.h and all (2) users are
including user_constants.h directly prior to that.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/um/include/shared/skas_ptregs.h      |    6 ------
 arch/um/sys-i386/shared/sysdep/ptrace.h   |    2 --
 arch/um/sys-x86_64/shared/sysdep/ptrace.h |    2 --
 3 files changed, 0 insertions(+), 10 deletions(-)
 delete mode 100644 arch/um/include/shared/skas_ptregs.h

diff --git a/arch/um/include/shared/skas_ptregs.h b/arch/um/include/shared/skas_ptregs.h
deleted file mode 100644
index 73db19e..0000000
--- a/arch/um/include/shared/skas_ptregs.h
+++ /dev/null
@@ -1,6 +0,0 @@
-#ifndef __SKAS_PT_REGS_
-#define __SKAS_PT_REGS_
-
-#include <user_constants.h>
-
-#endif
diff --git a/arch/um/sys-i386/shared/sysdep/ptrace.h b/arch/um/sys-i386/shared/sysdep/ptrace.h
index d50e62e..06e03b8 100644
--- a/arch/um/sys-i386/shared/sysdep/ptrace.h
+++ b/arch/um/sys-i386/shared/sysdep/ptrace.h
@@ -24,8 +24,6 @@ void set_using_sysemu(int value);
 int get_using_sysemu(void);
 extern int sysemu_supported;
 
-#include "skas_ptregs.h"
-
 #define REGS_IP(r) ((r)[HOST_IP])
 #define REGS_SP(r) ((r)[HOST_SP])
 #define REGS_EFLAGS(r) ((r)[HOST_EFLAGS])
diff --git a/arch/um/sys-x86_64/shared/sysdep/ptrace.h b/arch/um/sys-x86_64/shared/sysdep/ptrace.h
index fdba545..096547b 100644
--- a/arch/um/sys-x86_64/shared/sysdep/ptrace.h
+++ b/arch/um/sys-x86_64/shared/sysdep/ptrace.h
@@ -14,8 +14,6 @@
 #define MAX_REG_OFFSET (UM_FRAME_SIZE)
 #define MAX_REG_NR ((MAX_REG_OFFSET) / sizeof(unsigned long))
 
-#include "skas_ptregs.h"
-
 #define REGS_IP(r) ((r)[HOST_IP])
 #define REGS_SP(r) ((r)[HOST_SP])
 
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

