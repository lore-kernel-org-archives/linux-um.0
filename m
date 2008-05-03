Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JsPKI-0002oI-3e for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 03 May 2008 14:31:26 -0700
Received: from static-71-162-243-5.phlapa.fios.verizon.net ([71.162.243.5]
	helo=grelber.thyrsus.com)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1JsPKH-0000O9-MX
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 03 May 2008 14:31:26 -0700
Received: from landley.net (localhost [127.0.0.1])
	by grelber.thyrsus.com (Postfix) with ESMTP id 78BC52C83E5
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sat,  3 May 2008 17:38:17 -0400 (EDT)
From: Rob Landley <rob@landley.net>
Date: Sat, 3 May 2008 15:18:10 -0500
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200805031518.11029.rob@landley.net>
Subject: [uml-devel] [PATCH] make quiet suppress parse_chan_pair boot messages
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
To: uml-devel <user-mode-linux-devel@lists.sourceforge.net>

From: Rob Landley <rob@landley.net>

I usually use UML as a better fakeroot, meaning I run it with a command line
like "rootfstype=hostfs rw quiet init=/path/to/some_shell_script.sh".  In this
context, filling the screen with parse_chan_pair error messages which don't
actually hurt anything defeats the purpose of "quiet".

The patch turns several KERN_ERR into KERN_WARNING.  While I was there, I
merged the redundant printk() statements into a function, and added one "else"
after a test-for-null that did a printk but didn't do a continue.

Signed-off-by: Rob Landley <rob@landley.net>
---

 arch/um/drivers/chan_kern.c |   31 +++++++++++++++----------------
 arch/um/drivers/line.c      |    4 ++--
 2 files changed, 17 insertions(+), 18 deletions(-)

diff -r 7c6e2a3db359 arch/um/drivers/chan_kern.c
--- a/arch/um/drivers/chan_kern.c	Wed Apr 30 11:52:52 2008 -0700
+++ b/arch/um/drivers/chan_kern.c	Sat May 03 15:03:20 2008 -0500
@@ -10,61 +10,60 @@
 #include "os.h"
 
 #ifdef CONFIG_NOCONFIG_CHAN
+
+static void not_configged_warn(void)
+{
+	printk(KERN_WARNING "Using a channel type which is configured out of "
+	       "UML\n");
+}
+
 static void *not_configged_init(char *str, int device,
 				const struct chan_opts *opts)
 {
-	printk(KERN_ERR "Using a channel type which is configured out of "
-	       "UML\n");
+	not_configged_warn();
 	return NULL;
 }
 
 static int not_configged_open(int input, int output, int primary, void *data,
 			      char **dev_out)
 {
-	printk(KERN_ERR "Using a channel type which is configured out of "
-	       "UML\n");
+	not_configged_warn();
 	return -ENODEV;
 }
 
 static void not_configged_close(int fd, void *data)
 {
-	printk(KERN_ERR "Using a channel type which is configured out of "
-	       "UML\n");
+	not_configged_warn();
 }
 
 static int not_configged_read(int fd, char *c_out, void *data)
 {
-	printk(KERN_ERR "Using a channel type which is configured out of "
-	       "UML\n");
+	not_configged_warn();
 	return -EIO;
 }
 
 static int not_configged_write(int fd, const char *buf, int len, void *data)
 {
-	printk(KERN_ERR "Using a channel type which is configured out of "
-	       "UML\n");
+	not_configged_warn();
 	return -EIO;
 }
 
 static int not_configged_console_write(int fd, const char *buf, int len)
 {
-	printk(KERN_ERR "Using a channel type which is configured out of "
-	       "UML\n");
+	not_configged_warn();
 	return -EIO;
 }
 
 static int not_configged_window_size(int fd, void *data, unsigned short *rows,
 				     unsigned short *cols)
 {
-	printk(KERN_ERR "Using a channel type which is configured out of "
-	       "UML\n");
+	not_configged_warn();
 	return -ENODEV;
 }
 
 static void not_configged_free(void *data)
 {
-	printk(KERN_ERR "Using a channel type which is configured out of "
-	       "UML\n");
+	not_configged_warn();
 }
 
 static const struct chan_ops not_configged_ops = {
diff -r 7c6e2a3db359 arch/um/drivers/line.c
--- a/arch/um/drivers/line.c	Wed Apr 30 11:52:52 2008 -0700
+++ b/arch/um/drivers/line.c	Sat May 03 15:03:20 2008 -0500
@@ -717,8 +717,8 @@
 		if (line->init_str == NULL)
 			printk(KERN_ERR "lines_init - kstrdup returned NULL\n");
 
-		if (parse_chan_pair(line->init_str, line, i, opts, &error)) {
-			printk(KERN_ERR "parse_chan_pair failed for "
+		else if (parse_chan_pair(line->init_str, line, i, opts, &error)) {
+			printk(KERN_WARNING "parse_chan_pair failed for "
 			       "device %d : %s\n", i, error);
 			line->valid = 0;
 		}

-- 
"One of my most productive days was throwing away 1000 lines of code."
  - Ken Thompson.

-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Don't miss this year's exciting event. There's still time to save $100. 
Use priority code J8TL2D2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
