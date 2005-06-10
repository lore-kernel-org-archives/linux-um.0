Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DglWs-0000ep-MU	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 10 Jun 2005 08:34:42 -0700
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1DglWr-000590-3i	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 10 Jun 2005 08:34:42 -0700
Message-Id: <200506101529.j5AFTSvl008276@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] [PATCH 2/4] UML - Build cleanups
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
Date: Fri, 10 Jun 2005 11:29:28 -0400
To: akpm@osdl.org, torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

Fix a build failure when CONFIG_MODE_SKAS is disabled and make a Makefile
comment fit in 80 columns.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.12-rc/arch/um/include/sysdep-i386/ptrace.h
===================================================================
--- linux-2.6.12-rc.orig/arch/um/include/sysdep-i386/ptrace.h	2005-06-07 12:23:54.000000000 -0400
+++ linux-2.6.12-rc/arch/um/include/sysdep-i386/ptrace.h	2005-06-07 12:35:21.000000000 -0400
@@ -8,6 +8,8 @@
 
 #include "uml-config.h"
 #include "user_constants.h"
+#include "sysdep/faultinfo.h"
+#include "choose-mode.h"
 
 #define MAX_REG_NR (UM_FRAME_SIZE / sizeof(unsigned long))
 #define MAX_REG_OFFSET (UM_FRAME_SIZE)
@@ -58,9 +60,6 @@ extern int sysemu_supported;
 #define PTRACE_SYSEMU_SINGLESTEP 32
 #endif
 
-#include "sysdep/faultinfo.h"
-#include "choose-mode.h"
-
 union uml_pt_regs {
 #ifdef UML_CONFIG_MODE_TT
 	struct tt_regs {
Index: linux-2.6.12-rc/arch/um/scripts/Makefile.rules
===================================================================
--- linux-2.6.12-rc.orig/arch/um/scripts/Makefile.rules	2005-06-07 12:23:54.000000000 -0400
+++ linux-2.6.12-rc/arch/um/scripts/Makefile.rules	2005-06-07 12:27:25.000000000 -0400
@@ -20,7 +20,7 @@ quiet_cmd_make_link = SYMLINK $@
 cmd_make_link       = ln -sf $(srctree)/arch/$(SUBARCH)/$($(notdir $@)-dir)/$(notdir $@) $@
 
 # this needs to be before the foreach, because targets does not accept
-# complete paths like $(obj)/$(f). To make sure this works, use a := assignment,
+# complete paths like $(obj)/$(f). To make sure this works, use a := assignment
 # or we will get $(obj)/$(f) in the "targets" value.
 # Also, this forces you to use the := syntax when assigning to targets.
 # Otherwise the line below will cause an infinite loop (if you don't know why,



-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.  How far can you shotput
a projector? How fast can you ride your desk chair down the office luge track?
If you want to score the big prize, get to know the little guy.  
Play to win an NEC 61" plasma display: http://www.necitguy.com/?r=20
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
