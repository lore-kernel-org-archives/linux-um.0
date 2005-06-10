Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DglWs-0000eo-B8	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 10 Jun 2005 08:34:42 -0700
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1DglWr-00058z-Ij	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 10 Jun 2005 08:34:42 -0700
Message-Id: <200506101529.j5AFTRhV008271@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] [PATCH 1/4] UML - Remove duplicate includes
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
Date: Fri, 10 Jun 2005 11:29:27 -0400
To: akpm@osdl.org, torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

[ Andrew, these four patches are 2.6.12 material ]

A few files include the same header twice.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.12-rc/arch/um/kernel/main.c
===================================================================
--- linux-2.6.12-rc.orig/arch/um/kernel/main.c	2005-06-08 14:33:10.000000000 -0400
+++ linux-2.6.12-rc/arch/um/kernel/main.c	2005-06-08 14:33:36.000000000 -0400
@@ -24,8 +24,6 @@
 #include "mode.h"
 #include "choose-mode.h"
 #include "uml-config.h"
-#include "irq_user.h"
-#include "time_user.h"
 #include "os.h"
 
 /* Set in set_stklim, which is called from main and __wrap_malloc.
Index: linux-2.6.12-rc/arch/um/kernel/process.c
===================================================================
--- linux-2.6.12-rc.orig/arch/um/kernel/process.c	2005-06-08 14:31:54.000000000 -0400
+++ linux-2.6.12-rc/arch/um/kernel/process.c	2005-06-08 14:33:13.000000000 -0400
@@ -30,7 +30,6 @@
 #include "init.h"
 #include "os.h"
 #include "uml-config.h"
-#include "ptrace_user.h"
 #include "choose-mode.h"
 #include "mode.h"
 #ifdef UML_CONFIG_MODE_SKAS
Index: linux-2.6.12-rc/arch/um/kernel/um_arch.c
===================================================================
--- linux-2.6.12-rc.orig/arch/um/kernel/um_arch.c	2005-06-08 14:31:54.000000000 -0400
+++ linux-2.6.12-rc/arch/um/kernel/um_arch.c	2005-06-08 14:33:13.000000000 -0400
@@ -26,7 +26,6 @@
 #include "asm/setup.h"
 #include "ubd_user.h"
 #include "asm/current.h"
-#include "asm/setup.h"
 #include "user_util.h"
 #include "kern_util.h"
 #include "kern.h"



-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.  How far can you shotput
a projector? How fast can you ride your desk chair down the office luge track?
If you want to score the big prize, get to know the little guy.  
Play to win an NEC 61" plasma display: http://www.necitguy.com/?r=20
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
