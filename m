Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EFfih-0006DJ-7b	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 14 Sep 2005 15:27:11 -0700
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by mail.sourceforge.net with esmtp (Exim 4.44)	id 1EFfig-0001Ei-1p
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 14 Sep 2005 15:27:11 -0700
Message-Id: <200509142155.j8ELtugo012137@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] [PATCH 3/10] UML - Remove a useless include
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
Date: Wed, 14 Sep 2005 17:55:56 -0400
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

linux/inet.h isn't needed, and on my system, is empty.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.13-mm1/arch/um/drivers/mcast_user.c
===================================================================
--- linux-2.6.13-mm1.orig/arch/um/drivers/mcast_user.c	2005-06-17 15:48:29.000000000 -0400
+++ linux-2.6.13-mm1/arch/um/drivers/mcast_user.c	2005-09-02 19:41:45.000000000 -0400
@@ -13,7 +13,6 @@
 
 #include <errno.h>
 #include <unistd.h>
-#include <linux/inet.h>
 #include <sys/socket.h>
 #include <sys/un.h>
 #include <sys/time.h>



-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
