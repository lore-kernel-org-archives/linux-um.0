Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IERfi-0003eL-Ov for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 27 Jul 2007 08:24:07 -0700
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1IERff-0005Yn-DC
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 27 Jul 2007 08:24:06 -0700
Date: Fri, 27 Jul 2007 11:23:44 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20070727152344.GA6776@c2.user-mode-linux.org>
Mime-Version: 1.0
Content-Disposition: inline
Subject: [uml-devel] [PATCH] UML - Console should handle spurious IRQS
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
To: Andrew Morton <akpm@osdl.org>
Cc: Eduard-Gabriel Munteanu <maxdamage@aladin.ro>, LKML <linux-kernel@vger.kernel.org>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>

The previous DEBUG_SHIRQ patch missed one case.  The console doesn't
set its host descriptors non-blocking.

Signed-off-by: Jeff Dike <jdike@linux.intel.com>
--
 arch/um/drivers/chan_kern.c |    9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

Index: linux-2.6.21-mm/arch/um/drivers/chan_kern.c
===================================================================
--- linux-2.6.21-mm.orig/arch/um/drivers/chan_kern.c	2007-07-27 10:52:02.000000000 -0400
+++ linux-2.6.21-mm/arch/um/drivers/chan_kern.c	2007-07-27 11:09:12.000000000 -0400
@@ -157,7 +157,7 @@ static void tty_receive_char(struct tty_
 
 static int open_one_chan(struct chan *chan)
 {
-	int fd;
+	int fd, err;
 
 	if(chan->opened)
 		return 0;
@@ -168,6 +168,13 @@ static int open_one_chan(struct chan *ch
 				     chan->data, &chan->dev);
 	if(fd < 0)
 		return fd;
+
+	err = os_set_fd_block(fd, 0);
+	if (err) {
+		(*chan->ops->close)(fd, chan->data);
+		return err;
+	}
+
 	chan->fd = fd;
 
 	chan->opened = 1;

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
