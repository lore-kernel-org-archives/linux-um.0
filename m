Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GrN2p-0001fh-Df for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 04 Dec 2006 15:16:20 -0800
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1GrN2o-0002pP-Ay
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 04 Dec 2006 15:16:18 -0800
Message-Id: <200612042312.kB4NCJ2Q024556@ccure.user-mode-linux.org>
Mime-Version: 1.0
Date: Mon, 04 Dec 2006 18:12:19 -0500
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] [PATCH 1/4] UML - include stddef.h correctly
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

We were not including stddef.h in files that used offsetof.

One file was also including linux/stddef.h for no perciptible reason.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.18-mm/arch/um/sys-i386/ldt.c
===================================================================
--- linux-2.6.18-mm.orig/arch/um/sys-i386/ldt.c	2006-12-04 14:25:45.000000000 -0500
+++ linux-2.6.18-mm/arch/um/sys-i386/ldt.c	2006-12-04 14:26:12.000000000 -0500
@@ -3,7 +3,6 @@
  * Licensed under the GPL
  */
 
-#include "linux/stddef.h"
 #include "linux/sched.h"
 #include "linux/slab.h"
 #include "linux/types.h"
Index: linux-2.6.18-mm/arch/um/sys-i386/ptrace_user.c
===================================================================
--- linux-2.6.18-mm.orig/arch/um/sys-i386/ptrace_user.c	2006-12-04 14:25:45.000000000 -0500
+++ linux-2.6.18-mm/arch/um/sys-i386/ptrace_user.c	2006-12-04 14:26:12.000000000 -0500
@@ -4,9 +4,9 @@
  */
 
 #include <stdio.h>
+#include <stddef.h>
 #include <errno.h>
 #include <unistd.h>
-#include <linux/stddef.h>
 #include "ptrace_user.h"
 /* Grr, asm/user.h includes asm/ptrace.h, so has to follow ptrace_user.h */
 #include <asm/user.h>
Index: linux-2.6.18-mm/arch/um/sys-i386/user-offsets.c
===================================================================
--- linux-2.6.18-mm.orig/arch/um/sys-i386/user-offsets.c	2006-12-04 14:25:45.000000000 -0500
+++ linux-2.6.18-mm/arch/um/sys-i386/user-offsets.c	2006-12-04 14:26:12.000000000 -0500
@@ -2,7 +2,7 @@
 #include <signal.h>
 #include <asm/ptrace.h>
 #include <asm/user.h>
-#include <linux/stddef.h>
+#include <stddef.h>
 #include <sys/poll.h>
 
 #define DEFINE(sym, val) \


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
