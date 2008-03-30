Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Jg6Cl-0007Qy-7q for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 30 Mar 2008 15:40:47 -0700
Received: from smtp6.pp.htv.fi ([213.243.153.40])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1Jg6Ci-0000Qn-Qo
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 30 Mar 2008 15:40:47 -0700
Date: Mon, 31 Mar 2008 01:40:31 +0300
From: Adrian Bunk <bunk@kernel.org>
Message-ID: <20080330224031.GG28445@cs181133002.pp.htv.fi>
MIME-Version: 1.0
Content-Disposition: inline
Subject: [uml-devel] [2.6 patch] remove include/asm-um/keyboard.h
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
To: jdike@addtoit.com
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

This patch removes the unused and broken (the normal asm/keyboard.h 
files no longer exists) include/asm-um/keyboard.h

Signed-off-by: Adrian Bunk <bunk@kernel.org>

---

 include/asm-um/keyboard.h |    6 ------
 1 file changed, 6 deletions(-)

bd6cdb1ee8faecc525ce49b25115f2ca21be8981 diff --git a/include/asm-um/keyboard.h b/include/asm-um/keyboard.h
deleted file mode 100644
index ee2e230..0000000
--- a/include/asm-um/keyboard.h
+++ /dev/null
@@ -1,6 +0,0 @@
-#ifndef __UM_KEYBOARD_H
-#define __UM_KEYBOARD_H
-
-#include "asm/arch/keyboard.h"
-
-#endif


-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://ad.doubleclick.net/clk;164216239;13503038;w?http://sf.net/marketplace
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
