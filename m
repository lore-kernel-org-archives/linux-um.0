Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1H2u6U-0001RJ-Os for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 05 Jan 2007 10:47:46 -0800
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1H2u6U-0007Uh-1R
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 05 Jan 2007 10:47:46 -0800
Message-Id: <200701051842.l05IgHCa004637@ccure.user-mode-linux.org>
Mime-Version: 1.0
Date: Fri, 05 Jan 2007 13:42:16 -0500
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] [PATCH 7/9] UML - Fix previous console locking
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
Cc: Blaisorblade <blaisorblade@yahoo.it>, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

Eliminate the open_mutex after complaints from Blaisorblade.  It turns
out that the tty count provides the information needed to tell whether
we are the first opener or last closer.

Signed-off-by: Jeff Dike <jdike@addtoit.com>
--
 arch/um/drivers/line.c |   48 ++++++++----------------------------------------
 arch/um/include/line.h |    1 -
 2 files changed, 8 insertions(+), 41 deletions(-)
Index: linux-2.6.18-mm/arch/um/drivers/line.c
===================================================================
--- linux-2.6.18-mm.orig/arch/um/drivers/line.c	2007-01-03 12:08:02.000000000 -0500
+++ linux-2.6.18-mm/arch/um/drivers/line.c	2007-01-04 12:02:29.000000000 -0500
@@ -425,42 +425,15 @@ int line_setup_irq(int fd, int input, in
  * However, in this case, mconsole requests can come in "from the
  * side", and race with opens and closes.
  *
- * The problem comes from line_setup not wanting to sleep if
- * the device is open or being opened.  This can happen because the
- * first opener of a device is responsible for setting it up on the
- * host, and that can sleep.  The open of a port device will sleep
- * until someone telnets to it.
+ * mconsole config requests will want to be sure the device isn't in
+ * use, and get_config, open, and close will want a stable
+ * configuration.  The checking and modification of the configuration
+ * is done under a spinlock.  Checking whether the device is in use is
+ * line->tty->count > 1, also under the spinlock.
  *
- * The obvious solution of putting everything under a mutex fails
- * because then trying (and failing) to change the configuration of an
- * open(ing) device will block until the open finishes.  The right
- * thing to happen is for it to fail immediately.
- *
- * We can put the opening (and closing) of the host device under a
- * separate lock, but that has to be taken before the count lock is
- * released.  Otherwise, you open a window in which another open can
- * come through and assume that the host side is opened and working.
- *
- * So, if the tty count is one, open will take the open mutex
- * inside the count lock.  Otherwise, it just returns. This will sleep
- * if the last close is pending, and will block a setup or get_config,
- * but that should not last long.
- *
- * So, what we end up with is that open and close take the count lock.
- * If the first open or last close are happening, then the open mutex
- * is taken inside the count lock and the host opening or closing is done.
- *
- * setup and get_config only take the count lock.  setup modifies the
- * device configuration only if the open count is zero.  Arbitrarily
- * long blocking of setup doesn't happen because something would have to be
- * waiting for an open to happen.  However, a second open with
- * tty->count == 1 can't happen, and a close can't happen until the open
- * had finished.
- *
- * We can't maintain our own count here because the tty layer doesn't
- * match opens and closes.  It will call close if an open failed, and
- * a tty hangup will result in excess closes.  So, we rely on
- * tty->count instead.  It is one on both the first open and last close.
+ * tty->count serves to decide whether the device should be enabled or
+ * disabled on the host.  If it's equal to 1, then we are doing the
+ * first open or last close.  Otherwise, open and close just return.
  */
 
 int line_open(struct line *lines, struct tty_struct *tty)
@@ -476,7 +449,6 @@ int line_open(struct line *lines, struct
 	if(tty->count > 1)
 		goto out_unlock;
 
-	mutex_lock(&line->open_mutex);
 	spin_unlock(&line->count_lock);
 
 	tty->driver_data = line;
@@ -493,7 +465,6 @@ int line_open(struct line *lines, struct
 	chan_window_size(&line->chan_list, &tty->winsize.ws_row,
 			 &tty->winsize.ws_col);
 
-	mutex_unlock(&line->open_mutex);
 	return err;
 
 out_unlock:
@@ -523,7 +494,6 @@ void line_close(struct tty_struct *tty, 
 	if(tty->count > 1)
 		goto out_unlock;
 
-	mutex_lock(&line->open_mutex);
 	spin_unlock(&line->count_lock);
 
 	line->tty = NULL;
@@ -534,7 +504,6 @@ void line_close(struct tty_struct *tty, 
 		line->sigio = 0;
         }
 
-	mutex_unlock(&line->open_mutex);
 	return;
 
 out_unlock:
@@ -755,7 +724,6 @@ void lines_init(struct line *lines, int 
 	for(i = 0; i < nlines; i++){
 		line = &lines[i];
 		INIT_LIST_HEAD(&line->chan_list);
-		mutex_init(&line->open_mutex);
 
 		if(line->init_str == NULL)
 			continue;
Index: linux-2.6.18-mm/arch/um/include/line.h
===================================================================
--- linux-2.6.18-mm.orig/arch/um/include/line.h	2007-01-02 13:29:54.000000000 -0500
+++ linux-2.6.18-mm/arch/um/include/line.h	2007-01-03 16:31:32.000000000 -0500
@@ -35,7 +35,6 @@ struct line {
 	spinlock_t count_lock;
 	int valid;
 
-	struct mutex open_mutex;
 	char *init_str;
 	int init_pri;
 	struct list_head chan_list;


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
