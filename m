Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Dk4LK-00041r-9e	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 19 Jun 2005 11:16:26 -0700
Received: from mail.dif.dk ([193.138.115.101] helo=saerimmer.dif.dk)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1Dk4LI-0004oV-Ma	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 19 Jun 2005 11:16:26 -0700
Received: from localhost (localhost [127.0.0.1])
	by saerimmer.dif.dk (Postfix) with ESMTP id DBAB2FFD88
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sun, 19 Jun 2005 20:24:30 +0200 (CEST)
Received: from saerimmer.dif.dk ([127.0.0.1])
 by localhost (saerimmer [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 25835-10 for <user-mode-linux-devel@lists.sourceforge.net>;
 Sun, 19 Jun 2005 20:24:21 +0200 (CEST)
Received: from diftmgw2.backbone.dif.dk (diftmgw2.backbone.dif.dk
	[10.227.136.246])
	by saerimmer.dif.dk (Postfix) with ESMTP id 29025FFD85
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sun, 19 Jun 2005 20:24:21 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
Message-ID: <Pine.LNX.4.62.0506192015220.2832@dragon.hyggekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Subject: [uml-devel] [PATCH] um: kfree() cleanup of daemon_user.c
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
Date: Sun, 19 Jun 2005 20:21:43 +0200 (CEST)
To: linux-kernel@vger.kernel.org
Cc: Jeff Dike <jdike@karaya.com>, user-mode-linux-devel@lists.sourceforge.net, Lennert Buytenhek <buytenh@gnu.org>, James Leu <jleu@mindspring.net>

Here's a small patch to remove a few unnessesary NULL pointer checks 
before kfree() in arch/um/drivers/daemon_user.c

Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>
---

 arch/um/drivers/daemon_user.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

--- linux-2.6.12-orig/arch/um/drivers/daemon_user.c	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6.12/arch/um/drivers/daemon_user.c	2005-06-19 20:13:34.000000000 +0200
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
