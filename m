Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CPWqi-0004hx-FF for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 03 Nov 2004 17:55:40 -0800
Received: from host157-148.pool8289.interbusiness.it ([82.89.148.157]
	helo=zion.localdomain)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1CPWqd-0004Hz-Iw for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 03 Nov 2004 17:55:40 -0800
From: blaisorblade_spam@yahoo.it
Message-Id: <20041103231728.550C64F6D2@zion.localdomain>
Subject: [uml-devel] [patch 06/20] uml: remove useless inclusion
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
Date: Thu, 04 Nov 2004 00:17:28 +0100
To: akpm@osdl.org
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, cw@f00f.org, blaisorblade_spam@yahoo.it


Avoid including some unused headers.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade_spam@yahoo.it>
---

 vanilla-linux-2.6.9-paolo/arch/um/kernel/main.c                  |    2 ++
 vanilla-linux-2.6.9-paolo/arch/um/kernel/skas/include/mmu-skas.h |    3 ---
 2 files changed, 2 insertions(+), 3 deletions(-)

diff -puN arch/um/kernel/skas/include/mmu-skas.h~uml-remove-useless-inclusion arch/um/kernel/skas/include/mmu-skas.h
--- vanilla-linux-2.6.9/arch/um/kernel/skas/include/mmu-skas.h~uml-remove-useless-inclusion	2004-11-03 23:44:58.287699040 +0100
+++ vanilla-linux-2.6.9-paolo/arch/um/kernel/skas/include/mmu-skas.h	2004-11-03 23:44:58.291698432 +0100
@@ -6,9 +6,6 @@
 #ifndef __SKAS_MMU_H
 #define __SKAS_MMU_H
 
-#include "linux/list.h"
-#include "linux/spinlock.h"
-
 struct mmu_context_skas {
 	int mm_fd;
 };
diff -puN arch/um/kernel/main.c~uml-remove-useless-inclusion arch/um/kernel/main.c
--- vanilla-linux-2.6.9/arch/um/kernel/main.c~uml-remove-useless-inclusion	2004-11-03 23:44:58.288698888 +0100
+++ vanilla-linux-2.6.9-paolo/arch/um/kernel/main.c	2004-11-03 23:44:58.291698432 +0100
@@ -17,6 +17,8 @@
 #include "kern_util.h"
 #include "mem_user.h"
 #include "signal_user.h"
+#include "time_user.h"
+#include "irq_user.h"
 #include "user.h"
 #include "init.h"
 #include "mode.h"
_


-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
