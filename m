Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Etvq6-000472-Eb for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 03 Jan 2006 15:45:14 -0800
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1Etvq6-0001LY-2Z
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 03 Jan 2006 15:45:14 -0800
Message-Id: <200601040037.k040bZAa012540@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] [PATCH 4/12] UML - use ARRAY_SIZE
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
Date: Tue, 03 Jan 2006 19:37:35 -0500
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

This patch replaces instances of "sizeof(foo)/sizeof(foo[0])" with 
ARRAY_SIZE(foo), which expands to the same thing.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.15/arch/um/drivers/ssl.c
===================================================================
--- linux-2.6.15.orig/arch/um/drivers/ssl.c	2005-12-20 17:31:37.000000000 -0500
+++ linux-2.6.15/arch/um/drivers/ssl.c	2005-12-20 17:31:38.000000000 -0500
@@ -84,21 +84,18 @@ static struct lines lines = LINES_INIT(N
 
 static int ssl_config(char *str)
 {
-	return line_config(serial_lines,
-			   sizeof(serial_lines)/sizeof(serial_lines[0]), str);
+	return line_config(serial_lines, ARRAY_SIZE(serial_lines), str);
 }
 
 static int ssl_get_config(char *dev, char *str, int size, char **error_out)
 {
-	return line_get_config(dev, serial_lines,
-			       sizeof(serial_lines)/sizeof(serial_lines[0]),
-			       str, size, error_out);
+	return line_get_config(dev, serial_lines, ARRAY_SIZE(serial_lines), str,
+			       size, error_out);
 }
 
 static int ssl_remove(int n)
 {
-	return line_remove(serial_lines,
-			   sizeof(serial_lines)/sizeof(serial_lines[0]), n);
+	return line_remove(serial_lines, ARRAY_SIZE(serial_lines), n);
 }
 
 int ssl_open(struct tty_struct *tty, struct file *filp)
@@ -205,7 +202,7 @@ int ssl_init(void)
 					 serial_lines,
 					 ARRAY_SIZE(serial_lines));
 
-	lines_init(serial_lines, sizeof(serial_lines)/sizeof(serial_lines[0]));
+	lines_init(serial_lines, ARRAY_SIZE(serial_lines));
 
 	new_title = add_xterm_umid(opts.xterm_title);
 	if (new_title != NULL)
@@ -221,16 +218,13 @@ static void ssl_exit(void)
 {
 	if (!ssl_init_done)
 		return;
-	close_lines(serial_lines,
-		    sizeof(serial_lines)/sizeof(serial_lines[0]));
+	close_lines(serial_lines, ARRAY_SIZE(serial_lines));
 }
 __uml_exitcall(ssl_exit);
 
 static int ssl_chan_setup(char *str)
 {
-	return line_setup(serial_lines,
-			  sizeof(serial_lines)/sizeof(serial_lines[0]),
-			  str, 1);
+	return line_setup(serial_lines, ARRAY_SIZE(serial_lines), str, 1);
 }
 
 __setup("ssl", ssl_chan_setup);
Index: linux-2.6.15/arch/um/drivers/stdio_console.c
===================================================================
--- linux-2.6.15.orig/arch/um/drivers/stdio_console.c	2005-12-20 17:31:37.000000000 -0500
+++ linux-2.6.15/arch/um/drivers/stdio_console.c	2005-12-20 17:31:38.000000000 -0500
@@ -91,18 +91,17 @@ struct line vts[MAX_TTYS] = { LINE_INIT(
 
 static int con_config(char *str)
 {
-	return line_config(vts, sizeof(vts)/sizeof(vts[0]), str);
+	return line_config(vts, ARRAY_SIZE(vts), str);
 }
 
 static int con_get_config(char *dev, char *str, int size, char **error_out)
 {
-	return line_get_config(dev, vts, sizeof(vts)/sizeof(vts[0]), str,
-			       size, error_out);
+	return line_get_config(dev, vts, ARRAY_SIZE(vts), str, size, error_out);
 }
 
 static int con_remove(int n)
 {
-	return line_remove(vts, sizeof(vts)/sizeof(vts[0]), n);
+	return line_remove(vts, ARRAY_SIZE(vts), n);
 }
 
 static int con_open(struct tty_struct *tty, struct file *filp)
@@ -170,7 +169,7 @@ int stdio_init(void)
 		return -1;
 	printk(KERN_INFO "Initialized stdio console driver\n");
 
-	lines_init(vts, sizeof(vts)/sizeof(vts[0]));
+	lines_init(vts, ARRAY_SIZE(vts));
 
 	new_title = add_xterm_umid(opts.xterm_title);
 	if(new_title != NULL)
@@ -186,13 +185,13 @@ static void console_exit(void)
 {
 	if (!con_init_done)
 		return;
-	close_lines(vts, sizeof(vts)/sizeof(vts[0]));
+	close_lines(vts, ARRAY_SIZE(vts));
 }
 __uml_exitcall(console_exit);
 
 static int console_chan_setup(char *str)
 {
-	return line_setup(vts, sizeof(vts)/sizeof(vts[0]), str, 1);
+	return line_setup(vts, ARRAY_SIZE(vts), str, 1);
 }
 __setup("con", console_chan_setup);
 __channel_help(console_chan_setup, "con");



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
