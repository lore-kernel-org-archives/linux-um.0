Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DGiHX-000158-L3 for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 30 Mar 2005 10:51:11 -0800
Received: from mail-relay-3.tiscali.it ([213.205.33.43])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1DGiHV-0002Zm-UQ for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 30 Mar 2005 10:51:11 -0800
From: blaisorblade@yahoo.it
Message-Id: <20050330173352.720FDEFED2@zion>
Subject: [uml-devel] [patch 4/8] uml: fixes a build failure with
	CONFIG_MODE_SKAS disabled [for 2.6.12]
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
Date: Wed, 30 Mar 2005 19:33:52 +0200
To: torvalds@osdl.org
Cc: akpm@osdl.org, jdike@addtoit.com, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, blaisorblade@yahoo.it


This fixes a build failure (and also some warnings) when CONFIG_MODE_SKAS is
disabled.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 linux-2.6.11-paolo/arch/um/include/sysdep-i386/ptrace.h   |   16 +++++++-------
 linux-2.6.11-paolo/arch/um/include/sysdep-x86_64/ptrace.h |    6 ++---
 2 files changed, 11 insertions(+), 11 deletions(-)

diff -puN arch/um/include/sysdep-i386/ptrace.h~uml-fix-comp-failure-config-mode-skas-disabled arch/um/include/sysdep-i386/ptrace.h
--- linux-2.6.11/arch/um/include/sysdep-i386/ptrace.h~uml-fix-comp-failure-config-mode-skas-disabled	2005-03-29 17:02:34.000000000 +0200
+++ linux-2.6.11-paolo/arch/um/include/sysdep-i386/ptrace.h	2005-03-29 17:02:34.000000000 +0200
@@ -9,15 +9,11 @@
 #include "uml-config.h"
 #include "user_constants.h"
 
-#ifdef UML_CONFIG_MODE_TT
-#include "sysdep/sc.h"
-#endif
-
-#ifdef UML_CONFIG_MODE_SKAS
-
 #define MAX_REG_NR (UM_FRAME_SIZE / sizeof(unsigned long))
 #define MAX_REG_OFFSET (UM_FRAME_SIZE)
 
+extern void update_debugregs(int seq);
+
 /* syscall emulation path in ptrace */
 
 #ifndef PTRACE_SYSEMU
@@ -28,9 +24,13 @@ void set_using_sysemu(int value);
 int get_using_sysemu(void);
 extern int sysemu_supported;
 
-#include "skas_ptregs.h"
+#ifdef UML_CONFIG_MODE_TT
+#include "sysdep/sc.h"
+#endif
 
-extern void update_debugregs(int seq);
+#ifdef UML_CONFIG_MODE_SKAS
+
+#include "skas_ptregs.h"
 
 #define REGS_IP(r) ((r)[HOST_IP])
 #define REGS_SP(r) ((r)[HOST_SP])
diff -puN arch/um/include/sysdep-x86_64/ptrace.h~uml-fix-comp-failure-config-mode-skas-disabled arch/um/include/sysdep-x86_64/ptrace.h
--- linux-2.6.11/arch/um/include/sysdep-x86_64/ptrace.h~uml-fix-comp-failure-config-mode-skas-disabled	2005-03-29 17:02:34.000000000 +0200
+++ linux-2.6.11-paolo/arch/um/include/sysdep-x86_64/ptrace.h	2005-03-29 17:02:34.000000000 +0200
@@ -10,6 +10,9 @@
 #include "uml-config.h"
 #include "user_constants.h"
 
+#define MAX_REG_OFFSET (UM_FRAME_SIZE)
+#define MAX_REG_NR ((MAX_REG_OFFSET) / sizeof(unsigned long))
+
 #ifdef UML_CONFIG_MODE_TT
 #include "sysdep/sc.h"
 #endif
@@ -17,9 +20,6 @@
 #ifdef UML_CONFIG_MODE_SKAS
 #include "skas_ptregs.h"
 
-#define MAX_REG_OFFSET (UM_FRAME_SIZE)
-#define MAX_REG_NR ((MAX_REG_OFFSET) / sizeof(unsigned long))
-
 #define REGS_IP(r) ((r)[HOST_IP])
 #define REGS_SP(r) ((r)[HOST_SP])
 
_


-------------------------------------------------------
This SF.net email is sponsored by Demarc:
A global provider of Threat Management Solutions.
Download our HomeAdmin security software for free today!
http://www.demarc.com/info/Sentarus/hamr30
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
