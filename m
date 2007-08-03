Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IH0uh-0001nb-Mr for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 03 Aug 2007 10:26:11 -0700
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1IH0uh-0000SX-1D
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 03 Aug 2007 10:26:11 -0700
Date: Fri, 3 Aug 2007 13:26:02 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20070803172602.GA8262@c2.user-mode-linux.org>
Mime-Version: 1.0
Content-Disposition: inline
Subject: [uml-devel] [PATCH 1/2] UML - Fix console writing bugs
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
To: Andrew Morton <akpm@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>, Miklos Szeredi <miklos@szeredi.hu>

The previous console cleanup patch switched generic_read and
generic_write from calling os_{read,write}_file to calling read and
write directly.  Because the calling convention is different, they
now need to get any error from errno rather than the return value.  I
did this for generic_read, but forgot about generic_write.

While chasing some output corruption, I noticed that line_write was
unnecessarily calling flush_buffer, and deleted it.  I don't understand
why, but the corruption disappeared.  This is unneeded because there
already is a perfectly good mechanism for finding out when the host
output device has some room to write data - there is an interrupt that
comes in when writes can happen again.  line_write calling
flush_buffer seemed to just be an attempt to opportunistically get some
data out to the host.

I also made write_chan short-circuit calling into the host-level code
for zero-length writes.  Calling libc write with a length of zero
conflated write not being able to write anything with asking it not to
write anything.  Better to just cut it off as soon as possible.

Signed-off-by: Jeff Dike <jdike@linux.intel.com>
--
 arch/um/drivers/chan_kern.c |    3 +++
 arch/um/drivers/chan_user.c |   11 ++++++++++-
 arch/um/drivers/line.c      |    5 +----
 3 files changed, 14 insertions(+), 5 deletions(-)

Index: linux-2.6.21-mm/arch/um/drivers/chan_kern.c
===================================================================
--- linux-2.6.21-mm.orig/arch/um/drivers/chan_kern.c	2007-08-02 10:51:14.000000000 -0400
+++ linux-2.6.21-mm/arch/um/drivers/chan_kern.c	2007-08-03 11:11:18.000000000 -0400
@@ -291,6 +291,9 @@ int write_chan(struct list_head *chans, 
 	struct chan *chan = NULL;
 	int n, ret = 0;
 
+	if (len == 0)
+		return 0;
+
 	list_for_each(ele, chans) {
 		chan = list_entry(ele, struct chan, list);
 		if (!chan->output || (chan->ops->write == NULL))
Index: linux-2.6.21-mm/arch/um/drivers/chan_user.c
===================================================================
--- linux-2.6.21-mm.orig/arch/um/drivers/chan_user.c	2007-08-03 11:02:42.000000000 -0400
+++ linux-2.6.21-mm/arch/um/drivers/chan_user.c	2007-08-03 11:04:23.000000000 -0400
@@ -38,7 +38,16 @@ int generic_read(int fd, char *c_out, vo
 
 int generic_write(int fd, const char *buf, int n, void *unused)
 {
-	return write(fd, buf, n);
+	int err;
+
+	err = write(fd, buf, n);
+	if (err > 0)
+		return err;
+	else if (errno == EAGAIN)
+		return 0;
+	else if (err == 0)
+		return -EIO;
+	return -errno;
 }
 
 int generic_window_size(int fd, void *unused, unsigned short *rows_out,
Index: linux-2.6.21-mm/arch/um/drivers/line.c
===================================================================
--- linux-2.6.21-mm.orig/arch/um/drivers/line.c	2007-08-03 13:00:30.000000000 -0400
+++ linux-2.6.21-mm/arch/um/drivers/line.c	2007-08-03 13:00:49.000000000 -0400
@@ -216,18 +216,15 @@ int line_write(struct tty_struct *tty, c
 {
 	struct line *line = tty->driver_data;
 	unsigned long flags;
-	int n, err, ret = 0;
+	int n, ret = 0;
 
 	if(tty->stopped)
 		return 0;
 
 	spin_lock_irqsave(&line->lock, flags);
-	if (line->head != line->tail) {
+	if (line->head != line->tail)
 		ret = buffer_data(line, buf, len);
-		err = flush_buffer(line);
-		if (err <= 0 && (err != -EAGAIN || !ret))
-			ret = err;
-	} else {
+	else {
 		n = write_chan(&line->chan_list, buf, len,
 			       line->driver->write_irq);
 		if (n < 0) {

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
