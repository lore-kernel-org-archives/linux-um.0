Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1AFF8c-0003S9-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Thu, 30 Oct 2003 07:55:06 -0800
Received: from hirsch.in-berlin.de ([192.109.42.6] ident=root)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.24)
	id 1AFF8c-0001FM-6b
	for user-mode-linux-devel@lists.sourceforge.net; Thu, 30 Oct 2003 07:55:06 -0800
From: Gerd Knorr <kraxel@bytesex.org>
Message-ID: <20031030160500.GC19575@bytesex.org>
References: <20031030155757.GA19575@bytesex.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031030155757.GA19575@bytesex.org>
Subject: [uml-devel] [patch] serial console support
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: The user-mode Linux development list <user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Thu, 30 Oct 2003 17:05:00 +0100
To: Jeff Dike <jdike@addtoit.com>, uml devel <user-mode-linux-devel@lists.sourceforge.net>

  Hi,

This patch adds serial console support to the
uml virtual serial lines.

  Gerd

--- a/arch/um/drivers/ssl.c	2003-08-21 15:29:25.000000000 +0200
+++ b/arch/um/drivers/ssl.c	2003-09-11 13:22:03.000000000 +0200
@@ -10,6 +10,7 @@
 #include "linux/major.h"
 #include "linux/mm.h"
 #include "linux/init.h"
+#include "linux/console.h"
 #include "asm/termbits.h"
 #include "asm/irq.h"
 #include "line.h"
@@ -150,6 +151,8 @@
 	case TCSETSW:
 	case TCGETA:
 	case TIOCMGET:
+	case TCSBRK:
+	case TCSBRKP:
 		ret = -ENOIOCTLCMD;
 		break;
 	default:
@@ -213,6 +216,38 @@
  */
 static int ssl_init_done = 0;
 
+static void ssl_console_write(struct console *c, const char *string, 
+			      unsigned len)
+{
+	struct line *line = &serial_lines[c->index];
+
+	if(ssl_init_done)
+		down(&line->sem);
+	console_write_chan(&line->chan_list, string, len);
+	if(ssl_init_done)
+		up(&line->sem);
+}
+
+static struct tty_driver *ssl_console_device(struct console *c, int *index)
+{
+	*index = c->index;
+	return ssl_driver;
+}
+
+static int ssl_console_setup(struct console *co, char *options)
+{
+	return(0);
+}
+
+static struct console ssl_cons = {
+	name:		"ttyS",
+	write:		ssl_console_write,
+	device:		ssl_console_device,
+	setup:		ssl_console_setup,
+	flags:		CON_PRINTBUFFER,
+	index:		-1,
+};
+
 int ssl_init(void)
 {
 	char *new_title;
@@ -228,6 +263,7 @@
 	new_title = add_xterm_umid(opts.xterm_title);
 	if(new_title != NULL) opts.xterm_title = new_title;
 
+	register_console(&ssl_cons);
 	ssl_init_done = 1;
 	return(0);
 }


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?   SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
