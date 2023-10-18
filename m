Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFF3CCDB484
	for <linux-um@archiver.kernel.org>; Wed, 18 Oct 2023 12:37:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=PVMApwm9KZtB1EL5IVBjbLN3fwlaRPAXoL+gJEaXbEk=; b=izLaH+P7GeAl5t
	QNxIbBbElaCTiWt46wris5yYflyHNhYKdqiCCG0+yCQiS98dq+g3FrF7Nb+jqzpSljAHu+ckcw36f
	K060CZJtsWnWj+6cGUnn3/iSXbjaIicMdw0Ru93hksMOMPfW+CNlYDqGsAepTHJRfmA7biFeHcwKA
	vsJEe2hO5eslXdKGZdZgB5WbUwG9DVBTOZnY2Lv4fIP7jQ9Qwjl8HzEL4RJ5asArelteakA2GQYIy
	uGXBVCTk4iuqj9chhhGuN0cr6l8zqYmCejdsn4xxqcU9WJd6X3LTXtzjoPXXPGbNOBhskVmWMj8Fz
	mpQ9fugZH3gwOOUxqCJA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qt5nK-00Eg4G-13;
	Wed, 18 Oct 2023 12:37:02 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qt5nG-00Eg1r-2g
	for linux-um@lists.infradead.org;
	Wed, 18 Oct 2023 12:37:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=OYyYkMMCZAHTuAovFUYHcyOKvmmGJRRujb7EkklnTqI=;
	t=1697632618; x=1698842218; b=ppbgQXiolU/Ug3Vfvhh747ApT8oh4FOdkbD45FnZCfr4zXO
	bvGYwSHLEOZN1QOFI1rDi41PYYa6J9c0D0h76d6cIQznXHbZjFzEyIpoOnvEQaoycj6UwcN2mzGf0
	GPUo8jI00gT4QNKLgZPaoaLmrmBZ1UcNYKeRLlBN49Wovbt7l4wJQINRgf8pyN3vvkiMpTmZXhnkM
	ksIQTbJtG0W/74mtXzS6Fqf3UT8y6537xOUDPKIH5jtDxp/oqRqsNmeOCbp0B322+HT+/aD8/uCf4
	Kv+btChZdBhd2nU2uH4TnXDGv2Vdzt6buQl3+yxES4JO4Nr+DMiRwGf10C6RZ3Sg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97-RC1)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1qt5nE-0000000Bo1V-1vE1;
	Wed, 18 Oct 2023 14:36:56 +0200
From: benjamin@sipsolutions.net
To: linux-um@lists.infradead.org
Cc: Benjamin Berg <benjamin.berg@intel.com>
Subject: [PATCH 4/4] um: chan: use blocking IO for console output for time-travel
Date: Wed, 18 Oct 2023 14:36:43 +0200
Message-ID: <20231018123643.1255813-4-benjamin@sipsolutions.net>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231018123643.1255813-1-benjamin@sipsolutions.net>
References: <20231018123643.1255813-1-benjamin@sipsolutions.net>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231018_053659_023511_DDF88C3B 
X-CRM114-Status: GOOD (  26.79  )
X-BeenThere: linux-um@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

From: Benjamin Berg <benjamin.berg@intel.com>

When in time-travel mode (infinite-cpu or external) time should not pass
for writing to the console. As such, it makes sense to put the FD for
the output side into blocking mode and simply let any write to it hang.

If we did not do this, then time could pass waiting for the console to
become writable again. This is not desirable as it has random effects on
the clock between runs.

Implement this by duplicating the FD if output is active in a relevant
mode and setting the duplicate to be blocking. This avoids changing the
input channel to be blocking should it exists. After this, use the
blocking FD for all write operations and do not allocate an IRQ it is
set.

Without time-travel mode fd_out will always match fd_in and IRQs are
registered.

Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
---
 arch/um/drivers/chan.h      |  3 +-
 arch/um/drivers/chan_kern.c | 81 ++++++++++++++++++++++++++++---------
 arch/um/include/shared/os.h |  1 +
 arch/um/os-Linux/file.c     | 10 +++++
 4 files changed, 74 insertions(+), 21 deletions(-)

diff --git a/arch/um/drivers/chan.h b/arch/um/drivers/chan.h
index 3fec3b8406e9..1bb62f2d7716 100644
--- a/arch/um/drivers/chan.h
+++ b/arch/um/drivers/chan.h
@@ -22,7 +22,8 @@ struct chan {
 	unsigned int output:1;
 	unsigned int opened:1;
 	unsigned int enabled:1;
-	int fd;
+	int fd_in;
+	int fd_out; /* only different to fd_in if blocking output is needed */
 	const struct chan_ops *ops;
 	void *data;
 };
diff --git a/arch/um/drivers/chan_kern.c b/arch/um/drivers/chan_kern.c
index 26a702a06515..1eff939c7ebf 100644
--- a/arch/um/drivers/chan_kern.c
+++ b/arch/um/drivers/chan_kern.c
@@ -81,6 +81,12 @@ static const struct chan_ops not_configged_ops = {
 };
 #endif /* CONFIG_NOCONFIG_CHAN */
 
+static inline bool need_output_blocking(void)
+{
+	return time_travel_mode == TT_MODE_INFCPU ||
+	       time_travel_mode == TT_MODE_EXTERNAL;
+}
+
 static int open_one_chan(struct chan *chan)
 {
 	int fd, err;
@@ -96,15 +102,43 @@ static int open_one_chan(struct chan *chan)
 		return fd;
 
 	err = os_set_fd_block(fd, 0);
-	if (err) {
-		(*chan->ops->close)(fd, chan->data);
-		return err;
-	}
+	if (err)
+		goto out_close;
+
+	chan->fd_in = fd;
+	chan->fd_out = fd;
+
+	/*
+	 * In time-travel modes infinite-CPU and external we need to guarantee
+	 * that any writes to the output succeed immdiately from the point of
+	 * the VM. The best way to do this is to put the FD in blocking mode
+	 * and simply wait/retry until everything is written.
+	 * As every write is guaranteed to complete, we also do not need to
+	 * request an IRQ for the output.
+	 *
+	 * Note that input cannot happen in a time synchronized way. We permit
+	 * it, but time passes very quickly if anything waits for a read.
+	 */
+	if (chan->output && need_output_blocking()) {
+		err = os_dup_file(chan->fd_out);
+		if (err < 0)
+			goto out_close;
 
-	chan->fd = fd;
+		chan->fd_out = err;
+
+		err = os_set_fd_block(chan->fd_out, 1);
+		if (err) {
+			os_close_file(chan->fd_out);
+			goto out_close;
+		}
+	}
 
 	chan->opened = 1;
 	return 0;
+
+out_close:
+	(*chan->ops->close)(fd, chan->data);
+	return err;
 }
 
 static int open_chan(struct list_head *chans)
@@ -125,7 +159,7 @@ static int open_chan(struct list_head *chans)
 void chan_enable_winch(struct chan *chan, struct tty_port *port)
 {
 	if (chan && chan->primary && chan->ops->winch)
-		register_winch(chan->fd, port);
+		register_winch(chan->fd_in, port);
 }
 
 static void line_timer_cb(struct work_struct *work)
@@ -156,8 +190,9 @@ int enable_chan(struct line *line)
 
 		if (chan->enabled)
 			continue;
-		err = line_setup_irq(chan->fd, chan->input, chan->output, line,
-				     chan);
+		err = line_setup_irq(chan->fd_in, chan->input,
+				     chan->output && !need_output_blocking(),
+				     line, chan);
 		if (err)
 			goto out_close;
 
@@ -196,7 +231,8 @@ void free_irqs(void)
 
 		if (chan->input && chan->enabled)
 			um_free_irq(chan->line->read_irq, chan);
-		if (chan->output && chan->enabled)
+		if (chan->output && chan->enabled &&
+		    !need_output_blocking())
 			um_free_irq(chan->line->write_irq, chan);
 		chan->enabled = 0;
 	}
@@ -216,15 +252,19 @@ static void close_one_chan(struct chan *chan, int delay_free_irq)
 	} else {
 		if (chan->input && chan->enabled)
 			um_free_irq(chan->line->read_irq, chan);
-		if (chan->output && chan->enabled)
+		if (chan->output && chan->enabled &&
+		    !need_output_blocking())
 			um_free_irq(chan->line->write_irq, chan);
 		chan->enabled = 0;
 	}
+	if (chan->fd_out != chan->fd_in)
+		os_close_file(chan->fd_out);
 	if (chan->ops->close != NULL)
-		(*chan->ops->close)(chan->fd, chan->data);
+		(*chan->ops->close)(chan->fd_in, chan->data);
 
 	chan->opened = 0;
-	chan->fd = -1;
+	chan->fd_in = -1;
+	chan->fd_out = -1;
 }
 
 void close_chan(struct line *line)
@@ -244,7 +284,7 @@ void close_chan(struct line *line)
 void deactivate_chan(struct chan *chan, int irq)
 {
 	if (chan && chan->enabled)
-		deactivate_fd(chan->fd, irq);
+		deactivate_fd(chan->fd_in, irq);
 }
 
 int write_chan(struct chan *chan, const char *buf, int len,
@@ -255,7 +295,7 @@ int write_chan(struct chan *chan, const char *buf, int len,
 	if (len == 0 || !chan || !chan->ops->write)
 		return 0;
 
-	n = chan->ops->write(chan->fd, buf, len, chan->data);
+	n = chan->ops->write(chan->fd_out, buf, len, chan->data);
 	if (chan->primary) {
 		ret = n;
 	}
@@ -269,7 +309,7 @@ int console_write_chan(struct chan *chan, const char *buf, int len)
 	if (!chan || !chan->ops->console_write)
 		return 0;
 
-	n = chan->ops->console_write(chan->fd, buf, len);
+	n = chan->ops->console_write(chan->fd_out, buf, len);
 	if (chan->primary)
 		ret = n;
 	return ret;
@@ -297,14 +337,14 @@ int chan_window_size(struct line *line, unsigned short *rows_out,
 	if (chan && chan->primary) {
 		if (chan->ops->window_size == NULL)
 			return 0;
-		return chan->ops->window_size(chan->fd, chan->data,
+		return chan->ops->window_size(chan->fd_in, chan->data,
 					      rows_out, cols_out);
 	}
 	chan = line->chan_out;
 	if (chan && chan->primary) {
 		if (chan->ops->window_size == NULL)
 			return 0;
-		return chan->ops->window_size(chan->fd, chan->data,
+		return chan->ops->window_size(chan->fd_in, chan->data,
 					      rows_out, cols_out);
 	}
 	return 0;
@@ -320,7 +360,7 @@ static void free_one_chan(struct chan *chan)
 		(*chan->ops->free)(chan->data);
 
 	if (chan->primary && chan->output)
-		ignore_sigio_fd(chan->fd);
+		ignore_sigio_fd(chan->fd_in);
 	kfree(chan);
 }
 
@@ -479,7 +519,8 @@ static struct chan *parse_chan(struct line *line, char *str, int device,
 				 .output 	= 0,
 				 .opened  	= 0,
 				 .enabled  	= 0,
-				 .fd 		= -1,
+				 .fd_in		= -1,
+				 .fd_out	= -1,
 				 .ops 		= ops,
 				 .data 		= data });
 	return chan;
@@ -550,7 +591,7 @@ void chan_interrupt(struct line *line, int irq)
 			schedule_delayed_work(&line->task, 1);
 			goto out;
 		}
-		err = chan->ops->read(chan->fd, &c, chan->data);
+		err = chan->ops->read(chan->fd_in, &c, chan->data);
 		if (err > 0)
 			tty_insert_flip_char(port, c, TTY_NORMAL);
 	} while (err > 0);
diff --git a/arch/um/include/shared/os.h b/arch/um/include/shared/os.h
index 0df646c6651e..269373e16397 100644
--- a/arch/um/include/shared/os.h
+++ b/arch/um/include/shared/os.h
@@ -163,6 +163,7 @@ extern int os_set_fd_block(int fd, int blocking);
 extern int os_accept_connection(int fd);
 extern int os_create_unix_socket(const char *file, int len, int close_on_exec);
 extern int os_shutdown_socket(int fd, int r, int w);
+extern int os_dup_file(int fd);
 extern void os_close_file(int fd);
 extern int os_rcv_fd(int fd, int *helper_pid_out);
 extern int os_connect_socket(const char *name);
diff --git a/arch/um/os-Linux/file.c b/arch/um/os-Linux/file.c
index fc4450db59bd..abf8676b834c 100644
--- a/arch/um/os-Linux/file.c
+++ b/arch/um/os-Linux/file.c
@@ -240,6 +240,16 @@ int os_connect_socket(const char *name)
 	return err;
 }
 
+int os_dup_file(int fd)
+{
+	int new_fd = dup(fd);
+
+	if (new_fd < 0)
+		return -errno;
+
+	return new_fd;
+}
+
 void os_close_file(int fd)
 {
 	close(fd);
-- 
2.41.0


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
