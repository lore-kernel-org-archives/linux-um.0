Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1H2u6L-0001QQ-Kk for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 05 Jan 2007 10:47:37 -0800
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1H2u6K-0005h9-OU
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 05 Jan 2007 10:47:37 -0800
Message-Id: <200701051842.l05IgGsU004632@ccure.user-mode-linux.org>
Mime-Version: 1.0
Date: Fri, 05 Jan 2007 13:42:16 -0500
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] [PATCH 6/9] UML - console locking commentary and code
	cleanup
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

Remove the last vestiges of devfs from console registration.  Change
the name of the function, plus remove a couple of unused fields from
the line_driver structure.

struct lines is no longer needed, all traces of it are gone.

The only way that I can see to mark a structure as being almost-const
is to individually const the fields.  This is the case for the
line_driver structure, which has only one modifiable field - a
list_head in a sub-structure.

Signed-off-by: Jeff Dike <jdike@addtoit.com>
--
 arch/um/drivers/line.c          |    7 +++----
 arch/um/drivers/ssl.c           |   16 +++++++---------
 arch/um/drivers/stdio_console.c |   17 +++++++----------
 arch/um/include/line.h          |   36 ++++++++++++++----------------------
 4 files changed, 31 insertions(+), 45 deletions(-)
Index: linux-2.6.18-mm/arch/um/drivers/line.c
===================================================================
--- linux-2.6.18-mm.orig/arch/um/drivers/line.c	2007-01-01 13:34:20.000000000 -0500
+++ linux-2.6.18-mm/arch/um/drivers/line.c	2007-01-02 13:27:16.000000000 -0500
@@ -707,10 +707,9 @@ int line_remove(struct line *lines, unsi
 	return err;
 }
 
-struct tty_driver *line_register_devfs(struct lines *set,
-				       struct line_driver *line_driver,
-				       const struct tty_operations *ops,
-				       struct line *lines, int nlines)
+struct tty_driver *register_lines(struct line_driver *line_driver,
+				  const struct tty_operations *ops,
+				  struct line *lines, int nlines)
 {
 	int i;
 	struct tty_driver *driver = alloc_tty_driver(nlines);
Index: linux-2.6.18-mm/arch/um/drivers/ssl.c
===================================================================
--- linux-2.6.18-mm.orig/arch/um/drivers/ssl.c	2007-01-02 12:25:18.000000000 -0500
+++ linux-2.6.18-mm/arch/um/drivers/ssl.c	2007-01-02 13:31:38.000000000 -0500
@@ -51,6 +51,8 @@ static int ssl_config(char *str, char **
 static int ssl_get_config(char *dev, char *str, int size, char **error_out);
 static int ssl_remove(int n, char **error_out);
 
+
+/* Const, except for .mc.list */
 static struct line_driver driver = {
 	.name 			= "UML serial line",
 	.device_name 		= "ttyS",
@@ -62,8 +64,6 @@ static struct line_driver driver = {
 	.read_irq_name 		= "ssl",
 	.write_irq 		= SSL_WRITE_IRQ,
 	.write_irq_name 	= "ssl-write",
-	.symlink_from 		= "serial",
-	.symlink_to 		= "tts",
 	.mc  = {
 		.list		= LIST_HEAD_INIT(driver.mc.list),
 		.name  		= "ssl",
@@ -74,14 +74,12 @@ static struct line_driver driver = {
 	},
 };
 
-/* The array is initialized by line_init, which is an initcall.  The 
- * individual elements are protected by individual semaphores.
+/* The array is initialized by line_init, at initcall time.  The
+ * elements are locked individually as needed.
  */
 static struct line serial_lines[NR_PORTS] =
 	{ [0 ... NR_PORTS - 1] = LINE_INIT(CONFIG_SSL_CHAN, &driver) };
 
-static struct lines lines = LINES_INIT(NR_PORTS);
-
 static int ssl_config(char *str, char **error_out)
 {
 	return line_config(serial_lines, ARRAY_SIZE(serial_lines), str, &opts,
@@ -175,6 +173,7 @@ static int ssl_console_setup(struct cons
 	return console_open_chan(line, co);
 }
 
+/* No locking for register_console call - relies on single-threaded initcalls */
 static struct console ssl_cons = {
 	.name		= "ttyS",
 	.write		= ssl_console_write,
@@ -190,9 +189,8 @@ static int ssl_init(void)
 
 	printk(KERN_INFO "Initializing software serial port version %d\n",
 	       ssl_version);
-	ssl_driver = line_register_devfs(&lines, &driver, &ssl_ops,
-					 serial_lines,
-					 ARRAY_SIZE(serial_lines));
+	ssl_driver = register_lines(&driver, &ssl_ops, serial_lines,
+				    ARRAY_SIZE(serial_lines));
 
 	lines_init(serial_lines, ARRAY_SIZE(serial_lines), &opts);
 
Index: linux-2.6.18-mm/arch/um/drivers/stdio_console.c
===================================================================
--- linux-2.6.18-mm.orig/arch/um/drivers/stdio_console.c	2007-01-01 13:30:24.000000000 -0500
+++ linux-2.6.18-mm/arch/um/drivers/stdio_console.c	2007-01-02 13:31:51.000000000 -0500
@@ -55,6 +55,8 @@ static int con_config(char *str, char **
 static int con_get_config(char *dev, char *str, int size, char **error_out);
 static int con_remove(int n, char **con_remove);
 
+
+/* Const, except for .mc.list */
 static struct line_driver driver = {
 	.name 			= "UML console",
 	.device_name 		= "tty",
@@ -66,8 +68,6 @@ static struct line_driver driver = {
 	.read_irq_name 		= "console",
 	.write_irq 		= CONSOLE_WRITE_IRQ,
 	.write_irq_name 	= "console-write",
-	.symlink_from 		= "ttys",
-	.symlink_to 		= "vc",
 	.mc  = {
 		.list		= LIST_HEAD_INIT(driver.mc.list),
 		.name  		= "con",
@@ -78,10 +78,8 @@ static struct line_driver driver = {
 	},
 };
 
-static struct lines console_lines = LINES_INIT(MAX_TTYS);
-
-/* The array is initialized by line_init, which is an initcall.  The 
- * individual elements are protected by individual semaphores.
+/* The array is initialized by line_init, at initcall time.  The
+ * elements are locked individually as needed.
  */
 static struct line vts[MAX_TTYS] = { LINE_INIT(CONFIG_CON_ZERO_CHAN, &driver),
 				     [ 1 ... MAX_TTYS - 1 ] =
@@ -149,6 +147,7 @@ static int uml_console_setup(struct cons
 	return console_open_chan(line, co);
 }
 
+/* No locking for register_console call - relies on single-threaded initcalls */
 static struct console stdiocons = {
 	.name		= "tty",
 	.write		= uml_console_write,
@@ -156,16 +155,14 @@ static struct console stdiocons = {
 	.setup		= uml_console_setup,
 	.flags		= CON_PRINTBUFFER,
 	.index		= -1,
-	.data		= &vts,
 };
 
 int stdio_init(void)
 {
 	char *new_title;
 
-	console_driver = line_register_devfs(&console_lines, &driver,
-					     &console_ops, vts,
-					     ARRAY_SIZE(vts));
+	console_driver = register_lines(&driver, &console_ops, vts,
+					ARRAY_SIZE(vts));
 	if (console_driver == NULL)
 		return -1;
 	printk(KERN_INFO "Initialized stdio console driver\n");
Index: linux-2.6.18-mm/arch/um/include/line.h
===================================================================
--- linux-2.6.18-mm.orig/arch/um/include/line.h	2006-12-29 17:26:54.000000000 -0500
+++ linux-2.6.18-mm/arch/um/include/line.h	2007-01-02 13:29:54.000000000 -0500
@@ -15,19 +15,18 @@
 #include "chan_user.h"
 #include "mconsole_kern.h"
 
+/* There's only one modifiable field in this - .mc.list */
 struct line_driver {
-	char *name;
-	char *device_name;
-	short major;
-	short minor_start;
-	short type;
-	short subtype;
-	int read_irq;
-	char *read_irq_name;
-	int write_irq;
-	char *write_irq_name;
-	char *symlink_from;
-	char *symlink_to;
+	const char *name;
+	const char *device_name;
+	const short major;
+	const short minor_start;
+	const short type;
+	const short subtype;
+	const int read_irq;
+	const char *read_irq_name;
+	const int write_irq;
+	const char *write_irq_name;
 	struct mc_device mc;
 };
 
@@ -67,12 +66,6 @@ struct line {
 	  .lock =	SPIN_LOCK_UNLOCKED, \
 	  .driver =	d }
 
-struct lines {
-	int num;
-};
-
-#define LINES_INIT(n) {  .num =	n }
-
 extern void line_close(struct tty_struct *tty, struct file * filp);
 extern int line_open(struct line *lines, struct tty_struct *tty);
 extern int line_setup(struct line *lines, unsigned int sizeof_lines,
@@ -94,10 +87,9 @@ extern char *add_xterm_umid(char *base);
 extern int line_setup_irq(int fd, int input, int output, struct line *line,
 			  void *data);
 extern void line_close_chan(struct line *line);
-extern struct tty_driver * line_register_devfs(struct lines *set,
-					       struct line_driver *line_driver,
-					       const struct tty_operations *driver,
-					       struct line *lines, int nlines);
+extern struct tty_driver *register_lines(struct line_driver *line_driver,
+					 const struct tty_operations *driver,
+					 struct line *lines, int nlines);
 extern void lines_init(struct line *lines, int nlines, struct chan_opts *opts);
 extern void close_lines(struct line *lines, int nlines);
 


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
