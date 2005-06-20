Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DkRSn-0000uc-7M	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 20 Jun 2005 11:57:41 -0700
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1DkRSl-0007Zn-GR	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 20 Jun 2005 11:57:40 -0700
Message-Id: <200506201851.j5KIpDav008478@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] [PATCH 2/8] UML - kfree cleanup
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
Date: Mon, 20 Jun 2005 14:51:13 -0400
To: akpm@osdl.org, torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, juhl-lkml@dif.dk

Here's a small patch to remove a few unnessesary NULL pointer checks
before kfree() in arch/um/drivers/daemon_user.c

Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>
Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.12/arch/um/drivers/daemon_user.c
===================================================================
--- linux-2.6.12.orig/arch/um/drivers/daemon_user.c	2005-06-19 21:11:24.000000000 -0400
+++ linux-2.6.12/arch/um/drivers/daemon_user.c	2005-06-19 21:35:38.000000000 -0400
@@ -157,9 +157,9 @@ static void daemon_remove(void *data)
 
 	os_close_file(pri->fd);
 	os_close_file(pri->control);
-	if(pri->data_addr != NULL) kfree(pri->data_addr);
-	if(pri->ctl_addr != NULL) kfree(pri->ctl_addr);
-	if(pri->local_addr != NULL) kfree(pri->local_addr);
+	kfree(pri->data_addr);
+	kfree(pri->ctl_addr);
+	kfree(pri->local_addr);
 }
 
 int daemon_user_write(int fd, void *buf, int len, struct daemon_data *pri)



-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
