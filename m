Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Ip7c2-0006lF-Tb for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 05 Nov 2007 11:27:55 -0800
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1Ip7c2-00058I-0n
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 05 Nov 2007 11:27:54 -0800
Date: Mon, 5 Nov 2007 14:27:47 -0500
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20071105192747.GA8798@c2.user-mode-linux.org>
Mime-Version: 1.0
Content-Disposition: inline
Subject: [uml-devel] [PATCH 4/6] UML - Console driver cleanups
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
Cc: LKML <linux-kernel@vger.kernel.org>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>

Console driver cleanups -
	Changed an instance of foo = bar + foo to foo += bar
	Removed checks of tty->stopped - I don't think the low-level
driver has any business looking at that
	Removed an annoying warning

Signed-off-by: Jeff Dike <jdike@linux.intel.com>
---
 arch/um/drivers/line.c |   19 ++-----------------
 1 file changed, 2 insertions(+), 17 deletions(-)

Index: linux-2.6/arch/um/drivers/line.c
===================================================================
--- linux-2.6.orig/arch/um/drivers/line.c	2007-11-05 14:06:09.000000000 -0500
+++ linux-2.6/arch/um/drivers/line.c	2007-11-05 14:13:24.000000000 -0500
@@ -48,7 +48,7 @@ static int write_room(struct line *line)
 	n = line->head - line->tail;
 
 	if (n <= 0)
-		n = LINE_BUFSIZE + n; /* The other case */
+		n += LINE_BUFSIZE; /* The other case */
 	return n - 1;
 }
 
@@ -58,17 +58,10 @@ int line_write_room(struct tty_struct *t
 	unsigned long flags;
 	int room;
 
-	if (tty->stopped)
-		return 0;
-
 	spin_lock_irqsave(&line->lock, flags);
 	room = write_room(line);
 	spin_unlock_irqrestore(&line->lock, flags);
 
-	/*XXX: Warning to remove */
-	if (0 == room)
-		printk(KERN_DEBUG "%s: %s: no room left in buffer\n",
-		       __FUNCTION__,tty->name);
 	return room;
 }
 
@@ -79,8 +72,7 @@ int line_chars_in_buffer(struct tty_stru
 	int ret;
 
 	spin_lock_irqsave(&line->lock, flags);
-
-	/*write_room subtracts 1 for the needed NULL, so we readd it.*/
+	/* write_room subtracts 1 for the needed NULL, so we readd it.*/
 	ret = LINE_BUFSIZE - (write_room(line) + 1);
 	spin_unlock_irqrestore(&line->lock, flags);
 
@@ -184,10 +176,6 @@ void line_flush_buffer(struct tty_struct
 	unsigned long flags;
 	int err;
 
-	/*XXX: copied from line_write, verify if it is correct!*/
-	if (tty->stopped)
-		return;
-
 	spin_lock_irqsave(&line->lock, flags);
 	err = flush_buffer(line);
 	spin_unlock_irqrestore(&line->lock, flags);
@@ -213,9 +201,6 @@ int line_write(struct tty_struct *tty, c
 	unsigned long flags;
 	int n, ret = 0;
 
-	if (tty->stopped)
-		return 0;
-
 	spin_lock_irqsave(&line->lock, flags);
 	if (line->head != line->tail)
 		ret = buffer_data(line, buf, len);

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
