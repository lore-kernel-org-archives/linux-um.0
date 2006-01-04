Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EtvqK-00048P-1Q for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 03 Jan 2006 15:45:28 -0800
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1EtvqI-0000h4-No
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 03 Jan 2006 15:45:28 -0800
Message-Id: <200601040037.k040bmls012576@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] [PATCH 11/12] UML - Fix flip_buf full handling
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
Date: Tue, 03 Jan 2006 19:37:48 -0500
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

When the tty flip_buf is full, it's a good idea to delay the input
processing for a jiffy, rather than just scheduling the tasklet
immediately.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.15/arch/um/drivers/chan_kern.c
===================================================================
--- linux-2.6.15.orig/arch/um/drivers/chan_kern.c	2005-12-25 22:35:58.000000000 -0500
+++ linux-2.6.15/arch/um/drivers/chan_kern.c	2005-12-25 22:42:14.000000000 -0500
@@ -629,7 +629,7 @@ void chan_interrupt(struct list_head *ch
 		do {
 			if((tty != NULL) &&
 			   (tty->flip.count >= TTY_FLIPBUF_SIZE)){
-				schedule_work(task);
+				schedule_delayed_work(task, 1);
 				goto out;
 			}
 			err = chan->ops->read(chan->fd, &c, chan->data);



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
