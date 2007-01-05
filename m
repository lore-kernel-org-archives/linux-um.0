Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1H2u6L-0001QR-N9 for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 05 Jan 2007 10:47:37 -0800
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1H2u6K-0007Rv-Qk
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 05 Jan 2007 10:47:37 -0800
Message-Id: <200701051842.l05IgEUd004622@ccure.user-mode-linux.org>
Mime-Version: 1.0
Date: Fri, 05 Jan 2007 13:42:14 -0500
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] [PATCH 4/9] UML - Mostly const a structure
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

The chan_opts structure is mostly const, and needs no locking.
Comment the lack of locking on the one field that can change.
Make all the other fields const.
It turned out that console_open_chan didn't use its chan_opts
argument, so that is deleted from the function and its callers.

Signed-off-by: Jeff Dike <jdike@addtoit.com>
--
 arch/um/drivers/chan_kern.c     |    5 ++---
 arch/um/drivers/ssl.c           |    3 ++-
 arch/um/drivers/stdio_console.c |    3 ++-
 arch/um/include/chan_kern.h     |    3 +--
 arch/um/include/chan_user.h     |    8 ++++----
 5 files changed, 11 insertions(+), 11 deletions(-)

Index: linux-2.6.18-mm/arch/um/drivers/chan_kern.c
===================================================================
--- linux-2.6.18-mm.orig/arch/um/drivers/chan_kern.c	2006-12-29 18:21:46.000000000 -0500
+++ linux-2.6.18-mm/arch/um/drivers/chan_kern.c	2007-01-01 13:20:04.000000000 -0500
@@ -354,8 +354,7 @@ int console_write_chan(struct list_head 
 	return ret;
 }
 
-int console_open_chan(struct line *line, struct console *co,
-		      const struct chan_opts *opts)
+int console_open_chan(struct line *line, struct console *co)
 {
 	int err;
 
@@ -363,7 +362,7 @@ int console_open_chan(struct line *line,
 	if(err)
 		return err;
 
-	printk("Console initialized on /dev/%s%d\n",co->name,co->index);
+	printk("Console initialized on /dev/%s%d\n", co->name, co->index);
 	return 0;
 }
 
Index: linux-2.6.18-mm/arch/um/drivers/ssl.c
===================================================================
--- linux-2.6.18-mm.orig/arch/um/drivers/ssl.c	2007-01-01 12:18:42.000000000 -0500
+++ linux-2.6.18-mm/arch/um/drivers/ssl.c	2007-01-01 13:20:25.000000000 -0500
@@ -38,6 +38,7 @@ static void ssl_announce(char *dev_name,
 	       dev_name);
 }
 
+/* Almost const, except that xterm_title may be changed in an initcall */
 static struct chan_opts opts = {
 	.announce 	= ssl_announce,
 	.xterm_title	= "Serial Line #%d",
@@ -171,7 +172,7 @@ static int ssl_console_setup(struct cons
 {
 	struct line *line = &serial_lines[co->index];
 
-	return console_open_chan(line, co, &opts);
+	return console_open_chan(line, co);
 }
 
 static struct console ssl_cons = {
Index: linux-2.6.18-mm/arch/um/include/chan_kern.h
===================================================================
--- linux-2.6.18-mm.orig/arch/um/include/chan_kern.h	2006-12-29 17:26:54.000000000 -0500
+++ linux-2.6.18-mm/arch/um/include/chan_kern.h	2007-01-01 13:20:20.000000000 -0500
@@ -36,8 +36,7 @@ extern int write_chan(struct list_head *
 			     int write_irq);
 extern int console_write_chan(struct list_head *chans, const char *buf, 
 			      int len);
-extern int console_open_chan(struct line *line, struct console *co,
-			     const struct chan_opts *opts);
+extern int console_open_chan(struct line *line, struct console *co);
 extern void deactivate_chan(struct list_head *chans, int irq);
 extern void reactivate_chan(struct list_head *chans, int irq);
 extern void chan_enable_winch(struct list_head *chans, struct tty_struct *tty);
Index: linux-2.6.18-mm/arch/um/drivers/stdio_console.c
===================================================================
--- linux-2.6.18-mm.orig/arch/um/drivers/stdio_console.c	2007-01-01 13:21:28.000000000 -0500
+++ linux-2.6.18-mm/arch/um/drivers/stdio_console.c	2007-01-01 13:21:48.000000000 -0500
@@ -42,6 +42,7 @@ void stdio_announce(char *dev_name, int 
 	       dev_name);
 }
 
+/* Almost const, except that xterm_title may be changed in an initcall */
 static struct chan_opts opts = {
 	.announce 	= stdio_announce,
 	.xterm_title	= "Virtual Console #%d",
@@ -145,7 +146,7 @@ static int uml_console_setup(struct cons
 {
 	struct line *line = &vts[co->index];
 
-	return console_open_chan(line, co, &opts);
+	return console_open_chan(line, co);
 }
 
 static struct console stdiocons = {
Index: linux-2.6.18-mm/arch/um/include/chan_user.h
===================================================================
--- linux-2.6.18-mm.orig/arch/um/include/chan_user.h	2007-01-01 11:32:21.000000000 -0500
+++ linux-2.6.18-mm/arch/um/include/chan_user.h	2007-01-01 13:24:50.000000000 -0500
@@ -9,11 +9,11 @@
 #include "init.h"
 
 struct chan_opts {
-	void (*announce)(char *dev_name, int dev);
+	void (*const announce)(char *dev_name, int dev);
 	char *xterm_title;
-	int raw;
-	unsigned long tramp_stack;
-	int in_kernel;
+	const int raw;
+	const unsigned long tramp_stack;
+	const int in_kernel;
 };
 
 enum chan_init_pri { INIT_STATIC, INIT_ALL, INIT_ONE };


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
