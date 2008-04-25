Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JpSAE-0003m9-Hg for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 25 Apr 2008 10:56:50 -0700
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1JpSA6-0005VG-N2
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 25 Apr 2008 10:56:50 -0700
Date: Fri, 25 Apr 2008 13:56:14 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20080425175614.GA11196@c2.user-mode-linux.org>
MIME-Version: 1.0
Content-Disposition: inline
Subject: [uml-devel] [PATCH 13/19] UML - Remove unused header
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
To: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>
Cc: Adrian Bunk <bunk@kernel.org>

From: Adrian Bunk <bunk@kernel.org>

This patch removes the unused and broken (the normal asm/keyboard.h 
files no longer exists) include/asm-um/keyboard.h

Signed-off-by: Adrian Bunk <bunk@kernel.org>
Signed-off-by: Jeff Dike <jdike@linux.intel.com>
---
 include/asm-um/keyboard.h |    6 ------
 1 file changed, 6 deletions(-)

Index: linux-2.6.22/include/asm-um/keyboard.h
===================================================================
--- linux-2.6.22.orig/include/asm-um/keyboard.h	2007-07-08 19:32:17.000000000 -0400
+++ /dev/null	1970-01-01 00:00:00.000000000 +0000
@@ -1,6 +0,0 @@
-#ifndef __UM_KEYBOARD_H
-#define __UM_KEYBOARD_H
-
-#include "asm/arch/keyboard.h"
-
-#endif

-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Don't miss this year's exciting event. There's still time to save $100. 
Use priority code J8TL2D2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
