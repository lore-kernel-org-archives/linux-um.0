Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1H0RQz-0002xr-91 for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 29 Dec 2006 15:46:45 -0800
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1H0RQy-0007gv-57
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 29 Dec 2006 15:46:45 -0800
Message-Id: <200612292341.kBTNfR3s005529@ccure.user-mode-linux.org>
Mime-Version: 1.0
Date: Fri, 29 Dec 2006 18:41:27 -0500
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] [PATCH 1/6] UML - Console locking fixes
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

Clean up the console driver locking.  There are various problems here,
including sleeping under a spinlock and spinlock recursion, some of
which are fixed here.  This patch deals with the locking involved with
opens and closes.  The problem is that an mconsole request to change a
console's configuration can race with an open.  Changing a
configuration should only be done when a console isn't opened.  Also,
an open must be looking at a stable configuration.  In addition, a get
configuration request must observe the same locking since it must also
see a stable configuration.  With the old locking, it was possible for
this to hang indefinitely in some cases because open would block for a
long time waiting for a connection from the host while holding the
lock needed by the mconsole request.

As explained in the long comment, this is fixed by adding a spinlock
for the use count and configuration and a mutex for the actual open
and close.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

--
 arch/um/drivers/line.c          |  188 ++++++++++++++++++++++++++--------------
 arch/um/drivers/stdio_console.c |    6 -
 arch/um/include/line.h          |   14 +-
 3 files changed, 135 insertions(+), 73 deletions(-)

Index: linux-2.6.18-mm/arch/um/drivers/line.c
===================================================================
--- linux-2.6.18-mm.orig/arch/um/drivers/line.c	2006-12-29 15:12:45.000000000 -0500
+++ linux-2.6.18-mm/arch/um/drivers/line.c	2006-12-29 17:26:26.000000000 -0500
@@ -191,7 +191,6 @@ void line_flush_buffer(struct tty_struct
 	/*XXX: copied from line_write, verify if it is correct!*/
 	if(tty->stopped)
 		return;
-		//return 0;
 
 	spin_lock_irqsave(&line->lock, flags);
 	err = flush_buffer(line);
@@ -421,42 +420,84 @@ int line_setup_irq(int fd, int input, in
 	return err;
 }
 
+/* Normally, a driver like this can rely mostly on the tty layer
+ * locking, particularly when it comes to the driver structure.
+ * However, in this case, mconsole requests can come in "from the
+ * side", and race with opens and closes.
+ *
+ * The problem comes from line_setup not wanting to sleep if
+ * the device is open or being opened.  This can happen because the
+ * first opener of a device is responsible for setting it up on the
+ * host, and that can sleep.  The open of a port device will sleep
+ * until someone telnets to it.
+ *
+ * The obvious solution of putting everything under a mutex fails
+ * because then trying (and failing) to change the configuration of an
+ * open(ing) device will block until the open finishes.  The right
+ * thing to happen is for it to fail immediately.
+ *
+ * We can put the opening (and closing) of the host device under a
+ * separate lock, but that has to be taken before the count lock is
+ * released.  Otherwise, you open a window in which another open can
+ * come through and assume that the host side is opened and working.
+ *
+ * So, if the tty count is one, open will take the open mutex
+ * inside the count lock.  Otherwise, it just returns. This will sleep
+ * if the last close is pending, and will block a setup or get_config,
+ * but that should not last long.
+ *
+ * So, what we end up with is that open and close take the count lock.
+ * If the first open or last close are happening, then the open mutex
+ * is taken inside the count lock and the host opening or closing is done.
+ *
+ * setup and get_config only take the count lock.  setup modifies the
+ * device configuration only if the open count is zero.  Arbitrarily
+ * long blocking of setup doesn't happen because something would have to be
+ * waiting for an open to happen.  However, a second open with
+ * tty->count == 1 can't happen, and a close can't happen until the open
+ * had finished.
+ *
+ * We can't maintain our own count here because the tty layer doesn't
+ * match opens and closes.  It will call close if an open failed, and
+ * a tty hangup will result in excess closes.  So, we rely on
+ * tty->count instead.  It is one on both the first open and last close.
+ */
+
 int line_open(struct line *lines, struct tty_struct *tty)
 {
-	struct line *line;
+	struct line *line = &lines[tty->index];
 	int err = -ENODEV;
 
-	line = &lines[tty->index];
-	tty->driver_data = line;
+	spin_lock(&line->count_lock);
+	if(!line->valid)
+		goto out_unlock;
+
+	err = 0;
+	if(tty->count > 1)
+		goto out_unlock;
 
-	/* The IRQ which takes this lock is not yet enabled and won't be run
-	 * before the end, so we don't need to use spin_lock_irq.*/
-	spin_lock(&line->lock);
+	mutex_lock(&line->open_mutex);
+	spin_unlock(&line->count_lock);
 
 	tty->driver_data = line;
 	line->tty = tty;
-	if(!line->valid)
-		goto out;
 
-	if(tty->count == 1){
-		/* Here the device is opened, if necessary, and interrupt
-		 * is registered.
-		 */
-		enable_chan(line);
-		INIT_DELAYED_WORK(&line->task, line_timer_cb);
-
-		if(!line->sigio){
-			chan_enable_winch(&line->chan_list, tty);
-			line->sigio = 1;
-		}
+	enable_chan(line);
+	INIT_DELAYED_WORK(&line->task, line_timer_cb);
 
-		chan_window_size(&line->chan_list, &tty->winsize.ws_row,
-				 &tty->winsize.ws_col);
+	if(!line->sigio){
+		chan_enable_winch(&line->chan_list, tty);
+		line->sigio = 1;
 	}
 
-	err = 0;
-out:
-	spin_unlock(&line->lock);
+	chan_window_size(&line->chan_list, &tty->winsize.ws_row,
+			 &tty->winsize.ws_col);
+
+	mutex_unlock(&line->open_mutex);
+	return err;
+
+out_unlock:
+	spin_unlock(&line->count_lock);
 	return err;
 }
 
@@ -466,25 +507,38 @@ void line_close(struct tty_struct *tty, 
 {
 	struct line *line = tty->driver_data;
 
-	/* XXX: I assume this should be called in process context, not with
-         *  interrupts disabled!
-         */
-	spin_lock_irq(&line->lock);
+	/* If line_open fails (and tty->driver_data is never set),
+	 * tty_open will call line_close.  So just return in this case.
+	 */
+	if(line == NULL)
+		return;
 
 	/* We ignore the error anyway! */
 	flush_buffer(line);
 
-	if(tty->count == 1){
-		line->tty = NULL;
-		tty->driver_data = NULL;
-
-		if(line->sigio){
-			unregister_winch(tty);
-			line->sigio = 0;
-		}
+	spin_lock(&line->count_lock);
+	if(!line->valid)
+		goto out_unlock;
+
+	if(tty->count > 1)
+		goto out_unlock;
+
+	mutex_lock(&line->open_mutex);
+	spin_unlock(&line->count_lock);
+
+	line->tty = NULL;
+	tty->driver_data = NULL;
+
+	if(line->sigio){
+		unregister_winch(tty);
+		line->sigio = 0;
         }
 
-	spin_unlock_irq(&line->lock);
+	mutex_unlock(&line->open_mutex);
+	return;
+
+out_unlock:
+	spin_unlock(&line->count_lock);
 }
 
 void close_lines(struct line *lines, int nlines)
@@ -495,6 +549,30 @@ void close_lines(struct line *lines, int
 		close_chan(&lines[i].chan_list, 0);
 }
 
+static void setup_one_line(struct line *lines, int n, char *init, int init_prio)
+{
+	struct line *line = &lines[n];
+
+	spin_lock(&line->count_lock);
+
+	if(line->tty != NULL){
+		printk("line_setup - device %d is open\n", n);
+		goto out;
+	}
+
+	if (line->init_pri <= init_prio){
+		line->init_pri = init_prio;
+		if (!strcmp(init, "none"))
+			line->valid = 0;
+		else {
+			line->init_str = init;
+			line->valid = 1;
+		}
+	}
+out:
+	spin_unlock(&line->count_lock);
+}
+
 /* Common setup code for both startup command line and mconsole initialization.
  * @lines contains the array (of size @num) to modify;
  * @init is the setup string;
@@ -526,32 +604,11 @@ int line_setup(struct line *lines, unsig
 		       n, num - 1);
 		return 0;
 	}
-	else if (n >= 0){
-		if (lines[n].tty != NULL) {
-			printk("line_setup - device %d is open\n", n);
-			return 0;
-		}
-		if (lines[n].init_pri <= INIT_ONE){
-			lines[n].init_pri = INIT_ONE;
-			if (!strcmp(init, "none"))
-				lines[n].valid = 0;
-			else {
-				lines[n].init_str = init;
-				lines[n].valid = 1;
-			}
-		}
-	}
+	else if (n >= 0)
+		setup_one_line(lines, n, init, INIT_ONE);
 	else {
-		for(i = 0; i < num; i++){
-			if(lines[i].init_pri <= INIT_ALL){
-				lines[i].init_pri = INIT_ALL;
-				if(!strcmp(init, "none")) lines[i].valid = 0;
-				else {
-					lines[i].init_str = init;
-					lines[i].valid = 1;
-				}
-			}
-		}
+		for(i = 0; i < num; i++)
+			setup_one_line(lines, i, init, INIT_ALL);
 	}
 	return n == -1 ? num : n;
 }
@@ -602,13 +659,13 @@ int line_get_config(char *name, struct l
 
 	line = &lines[dev];
 
-	spin_lock(&line->lock);
+	spin_lock(&line->count_lock);
 	if(!line->valid)
 		CONFIG_CHUNK(str, size, n, "none", 1);
 	else if(line->tty == NULL)
 		CONFIG_CHUNK(str, size, n, line->init_str, 1);
 	else n = chan_config_string(&line->chan_list, str, size, error_out);
-	spin_unlock(&line->lock);
+	spin_unlock(&line->count_lock);
 
 	return n;
 }
@@ -688,6 +745,7 @@ void lines_init(struct line *lines, int 
 	for(i = 0; i < nlines; i++){
 		line = &lines[i];
 		INIT_LIST_HEAD(&line->chan_list);
+		mutex_init(&line->open_mutex);
 
 		if(line->init_str == NULL)
 			continue;
Index: linux-2.6.18-mm/arch/um/drivers/stdio_console.c
===================================================================
--- linux-2.6.18-mm.orig/arch/um/drivers/stdio_console.c	2006-12-29 15:12:43.000000000 -0500
+++ linux-2.6.18-mm/arch/um/drivers/stdio_console.c	2006-12-29 17:26:26.000000000 -0500
@@ -83,9 +83,9 @@ static struct lines console_lines = LINE
 /* The array is initialized by line_init, which is an initcall.  The 
  * individual elements are protected by individual semaphores.
  */
-struct line vts[MAX_TTYS] = { LINE_INIT(CONFIG_CON_ZERO_CHAN, &driver),
-			      [ 1 ... MAX_TTYS - 1 ] =
-			      LINE_INIT(CONFIG_CON_CHAN, &driver) };
+static struct line vts[MAX_TTYS] = { LINE_INIT(CONFIG_CON_ZERO_CHAN, &driver),
+				     [ 1 ... MAX_TTYS - 1 ] =
+				     LINE_INIT(CONFIG_CON_CHAN, &driver) };
 
 static int con_config(char *str)
 {
Index: linux-2.6.18-mm/arch/um/include/line.h
===================================================================
--- linux-2.6.18-mm.orig/arch/um/include/line.h	2006-12-29 15:12:43.000000000 -0500
+++ linux-2.6.18-mm/arch/um/include/line.h	2006-12-29 17:26:26.000000000 -0500
@@ -11,6 +11,7 @@
 #include "linux/tty.h"
 #include "linux/interrupt.h"
 #include "linux/spinlock.h"
+#include "linux/mutex.h"
 #include "chan_user.h"
 #include "mconsole_kern.h"
 
@@ -32,15 +33,17 @@ struct line_driver {
 
 struct line {
 	struct tty_struct *tty;
+	spinlock_t count_lock;
+	int valid;
+
+	struct mutex open_mutex;
 	char *init_str;
 	int init_pri;
 	struct list_head chan_list;
-	int valid;
-	int count;
-	int throttled;
+
 	/*This lock is actually, mostly, local to*/
 	spinlock_t lock;
-
+	int throttled;
 	/* Yes, this is a real circular buffer.
 	 * XXX: And this should become a struct kfifo!
 	 *
@@ -57,7 +60,8 @@ struct line {
 };
 
 #define LINE_INIT(str, d) \
-	{ .init_str =	str, \
+	{ .count_lock =	SPIN_LOCK_UNLOCKED, \
+	  .init_str =	str,	\
 	  .init_pri =	INIT_STATIC, \
 	  .valid =	1, \
 	  .lock =	SPIN_LOCK_UNLOCKED, \


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
