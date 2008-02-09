Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JNyF6-00078f-Vx for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 09 Feb 2008 14:32:25 -0800
Received: from mail.gmx.net ([213.165.64.20])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1JNyF2-0002of-8D
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 09 Feb 2008 14:32:13 -0800
From: Johann Felix Soden <johfel@gmx.de>
Date: Sat, 09 Feb 2008 23:31:54 +0100
Message-Id: <1202596314.22512.38.camel@localhost>
Mime-Version: 1.0
Subject: [uml-devel] [PATCH] uml: add missing include <linux/pagemap.h>
	to	include/asm-um/tlb.h
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
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Jeff Dike <jdike@linux.intel.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

From: Johann Felix Soden <johfel@users.sourceforge.net>

Reason is build error:
In file included from arch/um/kernel/smp.c:8:
include/asm/tlb.h: In function 'tlb_remove_page':
include/asm/tlb.h:101: error: implicit declaration of function 'page_cache_release'

Signed-off-by: Johann Felix Soden <johfel@users.sourceforge.net>
---
 include/asm-um/tlb.h |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/include/asm-um/tlb.h b/include/asm-um/tlb.h
index 39fc475..7febf85 100644
--- a/include/asm-um/tlb.h
+++ b/include/asm-um/tlb.h
@@ -2,6 +2,7 @@
 #define __UM_TLB_H
 
 #include <linux/swap.h>
+#include <linux/pagemap.h>
 #include <asm/percpu.h>
 #include <asm/pgalloc.h>
 #include <asm/tlbflush.h>
-- 
1.5.4




-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
