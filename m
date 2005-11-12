Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EaziB-0004gZ-SW for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 12 Nov 2005 10:02:47 -0800
Received: from host20-103.pool873.interbusiness.it ([87.3.103.20]
	helo=zion.home.lan) by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1EaziB-00020k-5d for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 12 Nov 2005 10:02:47 -0800
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Message-Id: <20051112180801.20133.67833.stgit@zion.home.lan>
In-Reply-To: <20051112180711.20133.68166.stgit@zion.home.lan>
References: <20051112180711.20133.68166.stgit@zion.home.lan>
Subject: [uml-devel] [PATCH 9/9] uml: fix daemon transport exit path bug
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
Date: Sat, 12 Nov 2005 19:08:03 +0100
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

Fix some exit path bugs in the daemon driver.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 arch/um/drivers/daemon_user.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/um/drivers/daemon_user.c b/arch/um/drivers/daemon_user.c
index c1b03f7..1bb085b 100644
--- a/arch/um/drivers/daemon_user.c
+++ b/arch/um/drivers/daemon_user.c
@@ -98,7 +98,7 @@ static int connect_to_switch(struct daem
 		printk("daemon_open : control setup request failed, err = %d\n",
 		       -n);
 		err = -ENOTCONN;
-		goto out;		
+		goto out_free;
 	}
 
 	n = os_read_file(pri->control, sun, sizeof(*sun));
@@ -106,12 +106,14 @@ static int connect_to_switch(struct daem
 		printk("daemon_open : read of data socket failed, err = %d\n",
 		       -n);
 		err = -ENOTCONN;
-		goto out_close;		
+		goto out_free;
 	}
 
 	pri->data_addr = sun;
 	return(fd);
 
+ out_free:
+	kfree(sun);
  out_close:
 	os_close_file(fd);
  out:



-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
