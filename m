Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1C4Nch-0006j1-D5 for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 06 Sep 2004 10:49:47 -0700
Received: from mail-relay-4.tiscali.it ([213.205.33.44])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.34)
	id 1C4Nce-0003al-N9 for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 06 Sep 2004 10:49:47 -0700
From: blaisorblade_spam@yahoo.it
Message-Id: <20040906174449.8CAAEBB1A@zion.localdomain>
Subject: [uml-devel] [patch 2/3] uml-ubd-any-elevator
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
Date: Mon, 06 Sep 2004 19:44:49 +0200
To: akpm@osdl.org
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, blaisorblade_spam@yahoo.it


Avoid forcing use of the no-op scheduler for UBD; this may uncover some bugs in the
UBD driver, and in fact uml-ubd-no-empty-queue.patch is needed to make this sure.
But as of now, no other bugs have been discovered, so this should be safe.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade_spam@yahoo.it>
---

 uml-linux-2.6.8.1-paolo/arch/um/drivers/ubd_kern.c |    2 --
 1 files changed, 2 deletions(-)

diff -puN arch/um/drivers/ubd_kern.c~uml-ubd-any-elevator arch/um/drivers/ubd_kern.c
--- uml-linux-2.6.8.1/arch/um/drivers/ubd_kern.c~uml-ubd-any-elevator	2004-08-29 14:40:53.731043416 +0200
+++ uml-linux-2.6.8.1-paolo/arch/um/drivers/ubd_kern.c	2004-08-29 14:40:53.733043112 +0200
@@ -749,8 +749,6 @@ int ubd_init(void)
 		return -1;
 	}
 		
-	elevator_init(ubd_queue, &elevator_noop);
-
 	if (fake_major != MAJOR_NR) {
 		char name[sizeof("ubd_nnn\0")];
 
_


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
