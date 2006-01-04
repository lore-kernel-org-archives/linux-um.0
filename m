Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EtvqC-00047V-Ds for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 03 Jan 2006 15:45:20 -0800
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1EtvqB-0001P0-St
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 03 Jan 2006 15:45:20 -0800
Message-Id: <200601040037.k040bdNZ012550@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] [PATCH 6/12] UML - Move mconsole support out of generic
	code
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
Date: Tue, 03 Jan 2006 19:37:39 -0500
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

A bit of restructuring which eliminates the all_allowed argument
(which is mconsole-specific) to line_setup.  That logic is moved to
the mconsole callback. 

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.15/arch/um/drivers/line.c
===================================================================
--- linux-2.6.15.orig/arch/um/drivers/line.c	2006-01-03 17:26:38.000000000 -0500
+++ linux-2.6.15/arch/um/drivers/line.c	2006-01-03 17:27:11.000000000 -0500
@@ -500,11 +500,9 @@ void close_lines(struct line *lines, int
 /* Common setup code for both startup command line and mconsole initialization.
  * @lines contains the the array (of size @num) to modify;
  * @init is the setup string;
- * @all_allowed is a boolean saying if we can setup the whole @lines
- * at once. For instance, it will be usually true for startup init. (where we
- * can use con=xterm) and false for mconsole.*/
+ */
 
-int line_setup(struct line *lines, unsigned int num, char *init, int all_allowed)
+int line_setup(struct line *lines, unsigned int num, char *init)
 {
 	int i, n;
 	char *end;
@@ -545,11 +543,6 @@ int line_setup(struct line *lines, unsig
 			}	
 		}
 	}
-	else if(!all_allowed){
-		printk("line_setup - can't configure all devices from "
-		       "mconsole\n");
-		return 0;
-	}
 	else {
 		for(i = 0; i < num; i++){
 			if(lines[i].init_pri <= INIT_ALL){
@@ -569,12 +562,18 @@ int line_config(struct line *lines, unsi
 {
 	char *new;
 
+	if(*str == '='){
+		printk("line_config - can't configure all devices from "
+		       "mconsole\n");
+		return 1;
+	}
+
 	new = kstrdup(str, GFP_KERNEL);
 	if(new == NULL){
 		printk("line_config - kstrdup failed\n");
 		return -ENOMEM;
 	}
-	return !line_setup(lines, num, new, 0);
+	return !line_setup(lines, num, new);
 }
 
 int line_get_config(char *name, struct line *lines, unsigned int num, char *str,
@@ -628,7 +627,7 @@ int line_remove(struct line *lines, unsi
 	char config[sizeof("conxxxx=none\0")];
 
 	sprintf(config, "%d=none", n);
-	return !line_setup(lines, num, config, 0);
+	return !line_setup(lines, num, config);
 }
 
 struct tty_driver *line_register_devfs(struct lines *set,
Index: linux-2.6.15/arch/um/drivers/ssl.c
===================================================================
--- linux-2.6.15.orig/arch/um/drivers/ssl.c	2006-01-03 17:24:52.000000000 -0500
+++ linux-2.6.15/arch/um/drivers/ssl.c	2006-01-03 17:27:11.000000000 -0500
@@ -224,7 +224,7 @@ __uml_exitcall(ssl_exit);
 
 static int ssl_chan_setup(char *str)
 {
-	return line_setup(serial_lines, ARRAY_SIZE(serial_lines), str, 1);
+	return line_setup(serial_lines, ARRAY_SIZE(serial_lines), str);
 }
 
 __setup("ssl", ssl_chan_setup);
Index: linux-2.6.15/arch/um/drivers/stdio_console.c
===================================================================
--- linux-2.6.15.orig/arch/um/drivers/stdio_console.c	2006-01-03 17:24:52.000000000 -0500
+++ linux-2.6.15/arch/um/drivers/stdio_console.c	2006-01-03 17:27:11.000000000 -0500
@@ -191,7 +191,7 @@ __uml_exitcall(console_exit);
 
 static int console_chan_setup(char *str)
 {
-	return line_setup(vts, ARRAY_SIZE(vts), str, 1);
+	return line_setup(vts, ARRAY_SIZE(vts), str);
 }
 __setup("con", console_chan_setup);
 __channel_help(console_chan_setup, "con");
Index: linux-2.6.15/arch/um/include/line.h
===================================================================
--- linux-2.6.15.orig/arch/um/include/line.h	2006-01-03 17:20:06.000000000 -0500
+++ linux-2.6.15/arch/um/include/line.h	2006-01-03 17:27:11.000000000 -0500
@@ -76,8 +76,8 @@ struct lines {
 extern void line_close(struct tty_struct *tty, struct file * filp);
 extern int line_open(struct line *lines, struct tty_struct *tty,
 		     struct chan_opts *opts);
-extern int line_setup(struct line *lines, unsigned int sizeof_lines, char *init,
-		      int all_allowed);
+extern int line_setup(struct line *lines, unsigned int sizeof_lines,
+		      char *init);
 extern int line_write(struct tty_struct *tty, const unsigned char *buf,
 		      int len);
 extern void line_put_char(struct tty_struct *tty, unsigned char ch);



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
