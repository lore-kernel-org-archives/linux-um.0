Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard@nod.at>) id 1Sbdsb-0007za-8q
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 04 Jun 2012 20:27:57 +0000
Received: from a.ns.miles-group.at ([95.130.255.143] helo=radon.swed.at)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Sbdsa-0007J6-CE
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 04 Jun 2012 20:27:57 +0000
From: Richard Weinberger <richard@nod.at>
Date: Mon,  4 Jun 2012 22:27:33 +0200
Message-Id: <1338841657-30358-3-git-send-email-richard@nod.at>
In-Reply-To: <1338841657-30358-1-git-send-email-richard@nod.at>
References: <1338841657-30358-1-git-send-email-richard@nod.at>
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
Subject: [uml-devel] [PATCH 2/6] TTY: um/line, use tty from tty_port
To: jslaby@suse.cz
Cc: user-mode-linux-devel@lists.sourceforge.net, gregkh@linuxfoundation.org, Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk, Richard Weinberger <richard@nod.at>, alan@linux.intel.com

From: Jiri Slaby <jslaby@suse.cz>

This means switching to the tty refcounted model so that we will not
race with interrupts.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Cc: Jeff Dike <jdike@addtoit.com>
Cc: Richard Weinberger <richard@nod.at>
Cc: user-mode-linux-devel@lists.sourceforge.net
Signed-off-by: Richard Weinberger <richard@nod.at>
---
 arch/um/drivers/chan_kern.c |    4 +++-
 arch/um/drivers/line.c      |   25 ++++++++++++++++++-------
 arch/um/drivers/line.h      |    1 -
 3 files changed, 21 insertions(+), 9 deletions(-)

diff --git a/arch/um/drivers/chan_kern.c b/arch/um/drivers/chan_kern.c
index 45e248c..87eebfe 100644
--- a/arch/um/drivers/chan_kern.c
+++ b/arch/um/drivers/chan_kern.c
@@ -150,9 +150,11 @@ void chan_enable_winch(struct chan *chan, struct tty_struct *tty)
 static void line_timer_cb(struct work_struct *work)
 {
 	struct line *line = container_of(work, struct line, task.work);
+	struct tty_struct *tty = tty_port_tty_get(&line->port);
 
 	if (!line->throttled)
-		chan_interrupt(line, line->tty, line->driver->read_irq);
+		chan_interrupt(line, tty, line->driver->read_irq);
+	tty_kref_put(tty);
 }
 
 int enable_chan(struct line *line)
diff --git a/arch/um/drivers/line.c b/arch/um/drivers/line.c
index 482a7bd..fb6e4ea 100644
--- a/arch/um/drivers/line.c
+++ b/arch/um/drivers/line.c
@@ -19,9 +19,11 @@ static irqreturn_t line_interrupt(int irq, void *data)
 {
 	struct chan *chan = data;
 	struct line *line = chan->line;
+	struct tty_struct *tty = tty_port_tty_get(&line->port);
 
 	if (line)
-		chan_interrupt(line, line->tty, irq);
+		chan_interrupt(line, tty, irq);
+	tty_kref_put(tty);
 	return IRQ_HANDLED;
 }
 
@@ -333,7 +335,7 @@ static irqreturn_t line_write_interrupt(int irq, void *data)
 {
 	struct chan *chan = data;
 	struct line *line = chan->line;
-	struct tty_struct *tty = line->tty;
+	struct tty_struct *tty;
 	int err;
 
 	/*
@@ -352,10 +354,13 @@ static irqreturn_t line_write_interrupt(int irq, void *data)
 	}
 	spin_unlock(&line->lock);
 
+	tty = tty_port_tty_get(&line->port);
 	if (tty == NULL)
 		return IRQ_NONE;
 
 	tty_wakeup(tty);
+	tty_kref_put(tty);
+
 	return IRQ_HANDLED;
 }
 
@@ -409,7 +414,7 @@ int line_open(struct line *lines, struct tty_struct *tty)
 
 	BUG_ON(tty->driver_data);
 	tty->driver_data = line;
-	line->tty = tty;
+	tty_port_tty_set(&line->port, tty);
 
 	err = enable_chan(line);
 	if (err) /* line_close() will be called by our caller */
@@ -449,7 +454,7 @@ void line_close(struct tty_struct *tty, struct file * filp)
 	if (--line->port.count)
 		goto out_unlock;
 
-	line->tty = NULL;
+	tty_port_tty_set(&line->port, NULL);
 	tty->driver_data = NULL;
 
 	if (line->sigio) {
@@ -610,9 +615,15 @@ int line_get_config(char *name, struct line *lines, unsigned int num, char *str,
 	mutex_lock(&line->count_lock);
 	if (!line->valid)
 		CONFIG_CHUNK(str, size, n, "none", 1);
-	else if (line->tty == NULL)
-		CONFIG_CHUNK(str, size, n, line->init_str, 1);
-	else n = chan_config_string(line, str, size, error_out);
+	else {
+		struct tty_struct *tty = tty_port_tty_get(&line->port);
+		if (tty == NULL) {
+			CONFIG_CHUNK(str, size, n, line->init_str, 1);
+		} else {
+			n = chan_config_string(line, str, size, error_out);
+			tty_kref_put(tty);
+		}
+	}
 	mutex_unlock(&line->count_lock);
 
 	return n;
diff --git a/arch/um/drivers/line.h b/arch/um/drivers/line.h
index 0e06a1f..5b3d4fb 100644
--- a/arch/um/drivers/line.h
+++ b/arch/um/drivers/line.h
@@ -33,7 +33,6 @@ struct line_driver {
 
 struct line {
 	struct tty_port port;
-	struct tty_struct *tty;
 	struct mutex count_lock;
 	int valid;
 
-- 
1.7.7.3


------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

