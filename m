Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EAxw9-0007HQ-R5	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 01 Sep 2005 15:53:37 -0700
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by mail.sourceforge.net with esmtp (Exim 4.44)	id 1EAxw9-0007SP-LZ
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 01 Sep 2005 15:53:38 -0700
Message-Id: <200509012216.j81MGnSH011518@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] [PATCH 1/12] UML - tty fix
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
Date: Thu, 01 Sep 2005 18:16:49 -0400
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, Alan Cox <alan@lxorguk.ukuu.org.uk>

This fixes a build breakage introduced by Alan's tty cleanups.  This should
be tied to that patch if possible.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.13-mm1/arch/um/drivers/chan_kern.c
===================================================================
--- linux-2.6.13-mm1.orig/arch/um/drivers/chan_kern.c	2005-09-01 15:52:25.000000000 -0400
+++ linux-2.6.13-mm1/arch/um/drivers/chan_kern.c	2005-09-01 15:52:31.000000000 -0400
@@ -161,9 +161,6 @@
 		}
 	}
 
-	if((tty->flip.flag_buf_ptr == NULL) || 
-	   (tty->flip.char_buf_ptr == NULL))
-		return;
 	tty_insert_flip_char(tty, ch, TTY_NORMAL);
 }
 
@@ -542,8 +539,8 @@
 		chan = list_entry(ele, struct chan, list);
 		if(!chan->input || (chan->ops->read == NULL)) continue;
 		do {
-			if((tty != NULL) && 
-			   (tty->flip.count >= TTY_FLIPBUF_SIZE)){
+			if((tty != NULL) &&
+			   !tty_buffer_request_room(tty, 1)){
 				schedule_work(task);
 				goto out;
 			}
@@ -572,14 +569,3 @@
  out:
 	if(tty) tty_flip_buffer_push(tty);
 }
-
-/*
- * Overrides for Emacs so that we follow Linus's tabbing style.
- * Emacs will notice this stuff at the end of the file and automatically
- * adjust the settings for this buffer only.  This must remain at the end
- * of the file.
- * ---------------------------------------------------------------------------
- * Local variables:
- * c-file-style: "linux"
- * End:
- */
 



-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
