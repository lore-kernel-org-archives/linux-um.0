Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GedNN-0005Ay-4i for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 30 Oct 2006 12:04:53 -0800
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1GedNJ-0004ZF-Gg
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 30 Oct 2006 12:04:53 -0800
Message-Id: <200610302103.k9UL304S006244@ccure.user-mode-linux.org>
Mime-Version: 1.0
Date: Mon, 30 Oct 2006 16:03:00 -0500
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] [PATCH 3/3] UML - fix ->set_termios declaration
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

The 'old' argument of tty_operations->set_termios changed from struct
termios to struct ktermios.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.18-mm/arch/um/drivers/line.c
===================================================================
--- linux-2.6.18-mm.orig/arch/um/drivers/line.c	2006-10-30 12:57:27.000000000 -0500
+++ linux-2.6.18-mm/arch/um/drivers/line.c	2006-10-30 12:59:16.000000000 -0500
@@ -246,7 +246,7 @@ out_up:
 	return ret;
 }
 
-void line_set_termios(struct tty_struct *tty, struct termios * old)
+void line_set_termios(struct tty_struct *tty, struct ktermios * old)
 {
 	/* nothing */
 }
Index: linux-2.6.18-mm/arch/um/include/line.h
===================================================================
--- linux-2.6.18-mm.orig/arch/um/include/line.h	2006-10-30 12:57:26.000000000 -0500
+++ linux-2.6.18-mm/arch/um/include/line.h	2006-10-30 12:59:16.000000000 -0500
@@ -76,7 +76,7 @@ extern int line_setup(struct line *lines
 extern int line_write(struct tty_struct *tty, const unsigned char *buf,
 		      int len);
 extern void line_put_char(struct tty_struct *tty, unsigned char ch);
-extern void line_set_termios(struct tty_struct *tty, struct termios * old);
+extern void line_set_termios(struct tty_struct *tty, struct ktermios * old);
 extern int line_chars_in_buffer(struct tty_struct *tty);
 extern void line_flush_buffer(struct tty_struct *tty);
 extern void line_flush_chars(struct tty_struct *tty);


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
