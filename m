Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EI8iI-00049Q-Ag	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 21 Sep 2005 10:48:58 -0700
Received: from [151.97.230.9] (helo=ssc.unict.it)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44)	id 1EI8iH-0001Ie-LH
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 21 Sep 2005 10:48:58 -0700
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Message-Id: <20050921172936.10219.33013.stgit@zion.home.lan>
In-Reply-To: <200509211923.21861.blaisorblade@yahoo.it>
References: <200509211923.21861.blaisorblade@yahoo.it>
Subject: [uml-devel] [PATCH 10/10] uml: replace printk with "stack-friendly"
	printf - to report console failure
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
Date: Wed, 21 Sep 2005 19:29:36 +0200
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Jeff Dike <jdike@addtoit.com>, user-mode-linux-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org

From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

User get *a lot* confused when consoles don't work but we don't report anything.
And, as reported in the comment, using printk to report "your console doesn't
work" isn't likely to go that far.

Fix the problem on the base of this: stack consumption by host printf(). Use
kernel sprintf() and os_write_file, using a wild guess that one page will be
enough for the message, to preallocate the buffer with kmalloc().

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 arch/um/drivers/chan_kern.c |   58 +++++++++++++++++++++++++++++++------------
 1 files changed, 42 insertions(+), 16 deletions(-)

diff --git a/arch/um/drivers/chan_kern.c b/arch/um/drivers/chan_kern.c
--- a/arch/um/drivers/chan_kern.c
+++ b/arch/um/drivers/chan_kern.c
@@ -19,18 +19,44 @@
 #include "line.h"
 #include "os.h"
 
-#ifdef CONFIG_NOCONFIG_CHAN
+/* XXX: could well be moved to somewhere else, if needed. */
+static int my_printf(const char * fmt, ...)
+	__attribute__ ((format (printf, 1, 2)));
+
+static int my_printf(const char * fmt, ...)
+{
+	/* Yes, can be called on atomic context.*/
+	char *buf = kmalloc(4096, GFP_ATOMIC);
+	va_list args;
+	int r;
+
+	if (!buf) {
+		/* We print directly fmt.
+		 * Yes, yes, yes, feel free to complain. */
+		r = strlen(fmt);
+	} else {
+		va_start(args, fmt);
+		r = vsprintf(buf, fmt, args);
+		va_end(args);
+		fmt = buf;
+	}
+
+	if (r)
+		r = os_write_file(1, fmt, r);
+	return r;
 
-/* The printk's here are wrong because we are complaining that there is no
- * output device, but printk is printing to that output device.  The user will
- * never see the error.  printf would be better, except it can't run on a
- * kernel stack because it will overflow it.
- * Use printk for now since that will avoid crashing.
- */
+}
+
+#ifdef CONFIG_NOCONFIG_CHAN
+/* Despite its name, there's no added trailing newline. */
+static int my_puts(const char * buf)
+{
+	return os_write_file(1, buf, strlen(buf));
+}
 
 static void *not_configged_init(char *str, int device, struct chan_opts *opts)
 {
-	printk(KERN_ERR "Using a channel type which is configured out of "
+	my_puts("Using a channel type which is configured out of "
 	       "UML\n");
 	return(NULL);
 }
@@ -38,27 +64,27 @@ static void *not_configged_init(char *st
 static int not_configged_open(int input, int output, int primary, void *data,
 			      char **dev_out)
 {
-	printk(KERN_ERR "Using a channel type which is configured out of "
+	my_puts("Using a channel type which is configured out of "
 	       "UML\n");
 	return(-ENODEV);
 }
 
 static void not_configged_close(int fd, void *data)
 {
-	printk(KERN_ERR "Using a channel type which is configured out of "
+	my_puts("Using a channel type which is configured out of "
 	       "UML\n");
 }
 
 static int not_configged_read(int fd, char *c_out, void *data)
 {
-	printk(KERN_ERR "Using a channel type which is configured out of "
+	my_puts("Using a channel type which is configured out of "
 	       "UML\n");
 	return(-EIO);
 }
 
 static int not_configged_write(int fd, const char *buf, int len, void *data)
 {
-	printk(KERN_ERR "Using a channel type which is configured out of "
+	my_puts("Using a channel type which is configured out of "
 	       "UML\n");
 	return(-EIO);
 }
@@ -66,7 +92,7 @@ static int not_configged_write(int fd, c
 static int not_configged_console_write(int fd, const char *buf, int len,
 				       void *data)
 {
-	printk(KERN_ERR "Using a channel type which is configured out of "
+	my_puts("Using a channel type which is configured out of "
 	       "UML\n");
 	return(-EIO);
 }
@@ -74,14 +100,14 @@ static int not_configged_console_write(i
 static int not_configged_window_size(int fd, void *data, unsigned short *rows,
 				     unsigned short *cols)
 {
-	printk(KERN_ERR "Using a channel type which is configured out of "
+	my_puts("Using a channel type which is configured out of "
 	       "UML\n");
 	return(-ENODEV);
 }
 
 static void not_configged_free(void *data)
 {
-	printf(KERN_ERR "Using a channel type which is configured out of "
+	my_puts("Using a channel type which is configured out of "
 	       "UML\n");
 }
 
@@ -457,7 +483,7 @@ static struct chan *parse_chan(char *str
 		}
 	}
 	if(ops == NULL){
-		printk(KERN_ERR "parse_chan couldn't parse \"%s\"\n", 
+		my_printf("parse_chan couldn't parse \"%s\"\n", 
 		       str);
 		return(NULL);
 	}



-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
