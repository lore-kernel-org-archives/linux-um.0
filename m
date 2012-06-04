Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard@nod.at>) id 1Sbdse-000804-4H
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 04 Jun 2012 20:28:00 +0000
Received: from a.ns.miles-group.at ([95.130.255.143] helo=radon.swed.at)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Sbdsd-0006Be-BX
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 04 Jun 2012 20:28:00 +0000
From: Richard Weinberger <richard@nod.at>
Date: Mon,  4 Jun 2012 22:27:35 +0200
Message-Id: <1338841657-30358-5-git-send-email-richard@nod.at>
In-Reply-To: <1338841657-30358-1-git-send-email-richard@nod.at>
References: <1338841657-30358-1-git-send-email-richard@nod.at>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
Subject: [uml-devel] [PATCH 4/6] um: Remove dead code
To: jslaby@suse.cz
Cc: user-mode-linux-devel@lists.sourceforge.net, Richard Weinberger <richard@nod.at>, linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk, gregkh@linuxfoundation.org, alan@linux.intel.com

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 arch/um/drivers/ssl.c |   26 --------------------------
 1 files changed, 0 insertions(+), 26 deletions(-)

diff --git a/arch/um/drivers/ssl.c b/arch/um/drivers/ssl.c
index a39d53e..cba95d9 100644
--- a/arch/um/drivers/ssl.c
+++ b/arch/um/drivers/ssl.c
@@ -98,27 +98,6 @@ static int ssl_open(struct tty_struct *tty, struct file *filp)
 	return err;
 }
 
-#if 0
-static void ssl_flush_buffer(struct tty_struct *tty)
-{
-	return;
-}
-
-static void ssl_stop(struct tty_struct *tty)
-{
-	printk(KERN_ERR "Someone should implement ssl_stop\n");
-}
-
-static void ssl_start(struct tty_struct *tty)
-{
-	printk(KERN_ERR "Someone should implement ssl_start\n");
-}
-
-void ssl_hangup(struct tty_struct *tty)
-{
-}
-#endif
-
 static const struct tty_operations ssl_ops = {
 	.open 	 		= ssl_open,
 	.close 	 		= line_close,
@@ -131,11 +110,6 @@ static const struct tty_operations ssl_ops = {
 	.set_termios 		= line_set_termios,
 	.throttle 		= line_throttle,
 	.unthrottle 		= line_unthrottle,
-#if 0
-	.stop 	 		= ssl_stop,
-	.start 	 		= ssl_start,
-	.hangup 	 	= ssl_hangup,
-#endif
 };
 
 /* Changed by ssl_init and referenced by ssl_exit, which are both serialized
-- 
1.7.7.3


------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

