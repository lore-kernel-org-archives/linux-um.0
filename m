Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1C4Ncg-0006ix-Pq for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 06 Sep 2004 10:49:46 -0700
Received: from mail-relay-3.tiscali.it ([213.205.33.43])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.34)
	id 1C4Ncd-0003aP-0w for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 06 Sep 2004 10:49:46 -0700
From: blaisorblade_spam@yahoo.it
Message-Id: <20040906174451.DCBD5BB21@zion.localdomain>
Subject: [uml-devel] [patch 3/3] uml-ubd-thread-start-fail-well
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
Date: Mon, 06 Sep 2004 19:44:51 +0200
To: akpm@osdl.org
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, blaisorblade_spam@yahoo.it


Correct the failure path in start_io_thread(), to return the correct error code.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade_spam@yahoo.it>
---

 uml-linux-2.6.8.1-paolo/arch/um/drivers/ubd_user.c |    1 +
 1 files changed, 1 insertion(+)

diff -puN arch/um/drivers/ubd_user.c~uml-ubd-thread-start-fail-well arch/um/drivers/ubd_user.c
--- uml-linux-2.6.8.1/arch/um/drivers/ubd_user.c~uml-ubd-thread-start-fail-well	2004-08-29 14:40:54.494927288 +0200
+++ uml-linux-2.6.8.1-paolo/arch/um/drivers/ubd_user.c	2004-08-29 14:40:54.496926984 +0200
@@ -353,6 +353,7 @@ int start_io_thread(unsigned long sp, in
 		    NULL);
 	if(pid < 0){
 		printk("start_io_thread - clone failed : errno = %d\n", errno);
+		err = -errno;
 		goto out_close;
 	}
 
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
