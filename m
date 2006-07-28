Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1G6IfK-00051x-UF for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 27 Jul 2006 20:05:31 -0700
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1G6IfE-0002lS-7I
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 27 Jul 2006 20:05:25 -0700
Message-Id: <200607280304.k6S34j4R007921@ccure.user-mode-linux.org>
Mime-Version: 1.0
Date: Thu, 27 Jul 2006 23:04:44 -0400
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] [PATCH 1/7] UML - semaphore build fix
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

2.6.18-rc2-mm1 broke the UML build on i386.  The culprit was i386
moving kernel/semaphore.c to lib/semaphore.S.  I needed to change that
path, plus pull a couple of i386 headers to asm-um.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.18-mm/arch/um/sys-i386/Makefile
===================================================================
--- linux-2.6.18-mm.orig/arch/um/sys-i386/Makefile	2006-07-27 12:36:56.000000000 -0400
+++ linux-2.6.18-mm/arch/um/sys-i386/Makefile	2006-07-27 12:38:40.000000000 -0400
@@ -4,7 +4,7 @@ obj-y = bugs.o checksum.o delay.o fault.
 
 obj-$(CONFIG_MODE_SKAS) += stub.o stub_segv.o
 
-subarch-obj-y = lib/bitops.o kernel/semaphore.o
+subarch-obj-y = lib/bitops.o lib/semaphore.o
 subarch-obj-$(CONFIG_HIGHMEM) += mm/highmem.o
 subarch-obj-$(CONFIG_MODULES) += kernel/module.o
 
Index: linux-2.6.18-mm/include/asm-um/alternative-asm.i
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.18-mm/include/asm-um/alternative-asm.i	2006-07-27 12:38:40.000000000 -0400
@@ -0,0 +1,6 @@
+#ifndef __UM_ALTERNATIVE_ASM_I
+#define __UM_ALTERNATIVE_ASM_I
+
+#include "asm/arch/alternative-asm.i"
+
+#endif
Index: linux-2.6.18-mm/include/asm-um/frame.i
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.18-mm/include/asm-um/frame.i	2006-07-27 12:38:40.000000000 -0400
@@ -0,0 +1,6 @@
+#ifndef __UM_FRAME_I
+#define __UM_FRAME_I
+
+#include "asm/arch/frame.i"
+
+#endif


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
