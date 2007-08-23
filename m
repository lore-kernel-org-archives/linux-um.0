Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IOMNv-00011F-5f for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 23 Aug 2007 16:46:43 -0700
Received: from fk-out-0910.google.com ([209.85.128.189])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1IOMNt-00026G-R2
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 23 Aug 2007 16:46:43 -0700
Received: by fk-out-0910.google.com with SMTP id 19so551130fkr
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Thu, 23 Aug 2007 16:46:40 -0700 (PDT)
Resent-To: Jesper Juhl <jesper.juhl@gmail.com>
Resent-Message-ID: <200708240142.34082.jesper.juhl@gmail.com>
Message-Id: <9c32c87607b7e38a8bdfd5a9e536d42f259c7f64.1187912217.git.jesper.juhl@gmail.com>
In-Reply-To: <1554af80879a7ef2f78a4d654f23c248203500d9.1187912217.git.jesper.juhl@gmail.com>
References: <1554af80879a7ef2f78a4d654f23c248203500d9.1187912217.git.jesper.juhl@gmail.com>
From: Jesper Juhl <jesper.juhl@gmail.com>
Date: Fri, 24 Aug 2007 01:43:49 +0200
MIME-Version: 1.0
Content-Disposition: inline
Subject: [uml-devel] [PATCH 03/30] um: Don't unnecessarily cast allocation
	return value in ubd_kern.c
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
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Jeff Dike <jdike@karaya.com>, Jesper Juhl <jesper.juhl@gmail.com>, user-mode-linux-devel@lists.sourceforge.net

vmalloc() returns a void pointer, so casting to (void *) is pretty pointless.

Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
---
 arch/um/drivers/ubd_kern.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/um/drivers/ubd_kern.c b/arch/um/drivers/ubd_kern.c
index 0eabe73..25b248a 100644
--- a/arch/um/drivers/ubd_kern.c
+++ b/arch/um/drivers/ubd_kern.c
@@ -615,7 +615,7 @@ static int ubd_open_dev(struct ubd *ubd_dev)
 		blk_queue_max_sectors(ubd_dev->queue, 8 * sizeof(long));
 
 		err = -ENOMEM;
-		ubd_dev->cow.bitmap = (void *) vmalloc(ubd_dev->cow.bitmap_len);
+		ubd_dev->cow.bitmap = vmalloc(ubd_dev->cow.bitmap_len);
 		if(ubd_dev->cow.bitmap == NULL){
 			printk(KERN_ERR "Failed to vmalloc COW bitmap\n");
 			goto error;
-- 
1.5.2.2


-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
