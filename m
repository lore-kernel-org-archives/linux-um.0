Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JFcTq-000121-0Q for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 17 Jan 2008 13:41:01 -0800
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1JFcTp-0001bL-5D
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 17 Jan 2008 13:40:57 -0800
Date: Thu, 17 Jan 2008 16:40:40 -0500
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20080117214040.GA6712@c2.user-mode-linux.org>
Mime-Version: 1.0
Content-Disposition: inline
Subject: [uml-devel] [PATCH 6/20] UML - DEBUG_SHIRQ fixes
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
Cc: LKML <linux-kernel@vger.kernel.org>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>, Karol Swietlicki <magotari@gmail.com>

A couple more DEBUG_SHIRQ fixes.

The previous mconsole blocking fix exposed the lack of O_NONBLOCK on
the mconsole socket.

Also, winch_interrupt started crashing because it is called at irq
free time and it tries to dereference tty->driver_data, which has
already been set to NULL.

I added some error cleanup in mconsole_init while I was there.

Cc: "Karol Swietlicki" <magotari@gmail.com>
Signed-off-by: Jeff Dike <jdike@linux.intel.com>
---
 arch/um/drivers/line.c          |    8 +++++---
 arch/um/drivers/mconsole_kern.c |    8 +++++++-
 2 files changed, 12 insertions(+), 4 deletions(-)

Index: linux-2.6.22/arch/um/drivers/line.c
===================================================================
--- linux-2.6.22.orig/arch/um/drivers/line.c	2007-12-14 11:28:06.000000000 -0500
+++ linux-2.6.22/arch/um/drivers/line.c	2007-12-14 12:47:43.000000000 -0500
@@ -774,9 +774,11 @@ static irqreturn_t winch_interrupt(int i
 	tty = winch->tty;
 	if (tty != NULL) {
 		line = tty->driver_data;
-		chan_window_size(&line->chan_list, &tty->winsize.ws_row,
-				 &tty->winsize.ws_col);
-		kill_pgrp(tty->pgrp, SIGWINCH, 1);
+		if (line != NULL) {
+			chan_window_size(&line->chan_list, &tty->winsize.ws_row,
+					 &tty->winsize.ws_col);
+			kill_pgrp(tty->pgrp, SIGWINCH, 1);
+		}
 	}
  out:
 	if (winch->fd != -1)
Index: linux-2.6.22/arch/um/drivers/mconsole_kern.c
===================================================================
--- linux-2.6.22.orig/arch/um/drivers/mconsole_kern.c	2007-12-14 11:28:06.000000000 -0500
+++ linux-2.6.22/arch/um/drivers/mconsole_kern.c	2007-12-14 12:53:49.000000000 -0500
@@ -792,6 +792,8 @@ static int __init mconsole_init(void)
 		printk(KERN_ERR "Failed to initialize management console\n");
 		return 1;
 	}
+	if (os_set_fd_block(sock, 0))
+		goto out;
 
 	register_reboot_notifier(&reboot_notifier);
 
@@ -800,7 +802,7 @@ static int __init mconsole_init(void)
 			     "mconsole", (void *)sock);
 	if (err) {
 		printk(KERN_ERR "Failed to get IRQ for management console\n");
-		return 1;
+		goto out;
 	}
 
 	if (notify_socket != NULL) {
@@ -816,6 +818,10 @@ static int __init mconsole_init(void)
 	printk(KERN_INFO "mconsole (version %d) initialized on %s\n",
 	       MCONSOLE_VERSION, mconsole_socket_name);
 	return 0;
+
+ out:
+	os_close_file(sock);
+	return 1;
 }
 
 __initcall(mconsole_init);

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
