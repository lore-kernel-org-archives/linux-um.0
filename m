Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard@nod.at>) id 1Qy4K7-0004MY-AT
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 29 Aug 2011 16:04:31 +0000
Received: from a.ns.miles-group.at ([95.130.255.143] helo=radon.swed.at)
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Qy4K3-0003Mc-AB
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 29 Aug 2011 16:04:31 +0000
From: Richard Weinberger <richard@nod.at>
Date: Mon, 29 Aug 2011 18:03:57 +0200
Message-Id: <1314633842-24515-5-git-send-email-richard@nod.at>
In-Reply-To: <1314633842-24515-1-git-send-email-richard@nod.at>
References: <1314633842-24515-1-git-send-email-richard@nod.at>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
Subject: [uml-devel] [PATCH 4/9] um: fix oopsable race in line_close()
To: akpm@linux-foundation.org
Cc: Richard Weinberger <richard@nod.at>, Al Viro <viro@zeniv.linux.org.uk>, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, Al Viro <viro@ftp.linux.org.uk>

From: Al Viro <viro@ftp.linux.org.uk>

tty->count is decremented only after ->close() had been called and several
tasks can hit it in parallel.  As the result, using tty->count to check if
you are the last one is broken.  We end up leaving line->tty not reset to
NULL and the next IRQ on that sucker will blow up trying to dereference
pointers from kfree'd struct tty.

Fix is obvious: we need to use a counter of our own.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Richard Weinberger <richard@nod.at>
---
 arch/um/drivers/line.c        |   25 ++++++++++++-------------
 arch/um/include/shared/line.h |    1 +
 2 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/arch/um/drivers/line.c b/arch/um/drivers/line.c
index d51c404..c5bff1d 100644
--- a/arch/um/drivers/line.c
+++ b/arch/um/drivers/line.c
@@ -399,8 +399,8 @@ int line_setup_irq(int fd, int input, int output, struct line *line, void *data)
  * is done under a spinlock.  Checking whether the device is in use is
  * line->tty->count > 1, also under the spinlock.
  *
- * tty->count serves to decide whether the device should be enabled or
- * disabled on the host.  If it's equal to 1, then we are doing the
+ * line->count serves to decide whether the device should be enabled or
+ * disabled on the host.  If it's equal to 0, then we are doing the
  * first open or last close.  Otherwise, open and close just return.
  */
 
@@ -414,16 +414,16 @@ int line_open(struct line *lines, struct tty_struct *tty)
 		goto out_unlock;
 
 	err = 0;
-	if (tty->count > 1)
+	if (line->count++)
 		goto out_unlock;
 
-	spin_unlock(&line->count_lock);
-
+	BUG_ON(tty->driver_data);
 	tty->driver_data = line;
 	line->tty = tty;
 
+	spin_unlock(&line->count_lock);
 	err = enable_chan(line);
-	if (err)
+	if (err) /* line_close() will be called by our caller */
 		return err;
 
 	INIT_DELAYED_WORK(&line->task, line_timer_cb);
@@ -436,7 +436,7 @@ int line_open(struct line *lines, struct tty_struct *tty)
 	chan_window_size(&line->chan_list, &tty->winsize.ws_row,
 			 &tty->winsize.ws_col);
 
-	return err;
+	return 0;
 
 out_unlock:
 	spin_unlock(&line->count_lock);
@@ -460,17 +460,16 @@ void line_close(struct tty_struct *tty, struct file * filp)
 	flush_buffer(line);
 
 	spin_lock(&line->count_lock);
-	if (!line->valid)
-		goto out_unlock;
+	BUG_ON(!line->valid);
 
-	if (tty->count > 1)
+	if (--line->count)
 		goto out_unlock;
 
-	spin_unlock(&line->count_lock);
-
 	line->tty = NULL;
 	tty->driver_data = NULL;
 
+	spin_unlock(&line->count_lock);
+
 	if (line->sigio) {
 		unregister_winch(tty);
 		line->sigio = 0;
@@ -498,7 +497,7 @@ static int setup_one_line(struct line *lines, int n, char *init, int init_prio,
 
 	spin_lock(&line->count_lock);
 
-	if (line->tty != NULL) {
+	if (line->count) {
 		*error_out = "Device is already open";
 		goto out;
 	}
diff --git a/arch/um/include/shared/line.h b/arch/um/include/shared/line.h
index 72f4f25..63df3ca 100644
--- a/arch/um/include/shared/line.h
+++ b/arch/um/include/shared/line.h
@@ -33,6 +33,7 @@ struct line_driver {
 struct line {
 	struct tty_struct *tty;
 	spinlock_t count_lock;
+	unsigned long count;
 	int valid;
 
 	char *init_str;
-- 
1.7.6.1


------------------------------------------------------------------------------
EMC VNX: the world's simplest storage, starting under $10K
The only unified storage solution that offers unified management 
Up to 160% more powerful than alternatives and 25% more efficient. 
Guaranteed. http://p.sf.net/sfu/emc-vnx-dev2dev
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

