Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from ivanoab6.miniserver.com ([5.153.251.140]
 helo=www.kot-begemot.co.uk)
 by casper.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gMaIi-0001Lz-Sv
 for linux-um@lists.infradead.org; Tue, 13 Nov 2018 15:08:26 +0000
From: anton.ivanov@cambridgegreys.com
Subject: [PATCH] um: Remove obsolete reenable_XX calls
Date: Tue, 13 Nov 2018 15:08:02 +0000
Message-Id: <20181113150802.27175-1-anton.ivanov@cambridgegreys.com>
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: linux-um@lists.infradead.org
Cc: richard@nod.at, Anton Ivanov <anton.ivanov@cambridgegreys.com>

From: Anton Ivanov <anton.ivanov@cambridgegreys.com>

reenable_fd has been a NOP since the introduction of the EPOLL
based interrupt controller.
reenable_channel() is no longer needed as the flow control is
now handled via the write IRQs on the channel.

Signed-off-by: Anton Ivanov <anton.ivanov@cambridgegreys.com>
---
 arch/um/drivers/chan_kern.c       | 10 ----------
 arch/um/drivers/line.c            | 10 ----------
 arch/um/drivers/mconsole_kern.c   |  2 --
 arch/um/drivers/net_kern.c        |  2 --
 arch/um/drivers/port_kern.c       |  1 -
 arch/um/drivers/random.c          |  1 -
 arch/um/drivers/ubd_kern.c        |  1 -
 arch/um/include/shared/irq_user.h |  1 -
 arch/um/kernel/irq.c              |  6 ------
 arch/um/kernel/sigio.c            |  1 -
 10 files changed, 35 deletions(-)

diff --git a/arch/um/drivers/chan_kern.c b/arch/um/drivers/chan_kern.c
index 05588f9466c7..a4e64edb8f38 100644
--- a/arch/um/drivers/chan_kern.c
+++ b/arch/um/drivers/chan_kern.c
@@ -211,12 +211,6 @@ void deactivate_chan(struct chan *chan, int irq)
 		deactivate_fd(chan->fd, irq);
 }
 
-void reactivate_chan(struct chan *chan, int irq)
-{
-	if (chan && chan->enabled)
-		reactivate_fd(chan->fd, irq);
-}
-
 int write_chan(struct chan *chan, const char *buf, int len,
 	       int write_irq)
 {
@@ -228,8 +222,6 @@ int write_chan(struct chan *chan, const char *buf, int len,
 	n = chan->ops->write(chan->fd, buf, len, chan->data);
 	if (chan->primary) {
 		ret = n;
-		if ((ret == -EAGAIN) || ((ret >= 0) && (ret < len)))
-			reactivate_fd(chan->fd, write_irq);
 	}
 	return ret;
 }
@@ -527,8 +519,6 @@ void chan_interrupt(struct line *line, int irq)
 			tty_insert_flip_char(port, c, TTY_NORMAL);
 	} while (err > 0);
 
-	if (err == 0)
-		reactivate_fd(chan->fd, irq);
 	if (err == -EIO) {
 		if (chan->primary) {
 			tty_port_tty_hangup(&line->port, false);
diff --git a/arch/um/drivers/line.c b/arch/um/drivers/line.c
index 7e524efed584..e0e63931fb2b 100644
--- a/arch/um/drivers/line.c
+++ b/arch/um/drivers/line.c
@@ -235,14 +235,6 @@ void line_unthrottle(struct tty_struct *tty)
 
 	line->throttled = 0;
 	chan_interrupt(line, line->driver->read_irq);
-
-	/*
-	 * Maybe there is enough stuff pending that calling the interrupt
-	 * throttles us again.  In this case, line->throttled will be 1
-	 * again and we shouldn't turn the interrupt back on.
-	 */
-	if (!line->throttled)
-		reactivate_chan(line->chan_in, line->driver->read_irq);
 }
 
 static irqreturn_t line_write_interrupt(int irq, void *data)
@@ -667,8 +659,6 @@ static irqreturn_t winch_interrupt(int irq, void *data)
 		tty_kref_put(tty);
 	}
  out:
-	if (winch->fd != -1)
-		reactivate_fd(winch->fd, WINCH_IRQ);
 	return IRQ_HANDLED;
 }
 
diff --git a/arch/um/drivers/mconsole_kern.c b/arch/um/drivers/mconsole_kern.c
index d5f9a2d1da1b..ff3ab72fd90f 100644
--- a/arch/um/drivers/mconsole_kern.c
+++ b/arch/um/drivers/mconsole_kern.c
@@ -96,7 +96,6 @@ static irqreturn_t mconsole_interrupt(int irq, void *dev_id)
 	}
 	if (!list_empty(&mc_requests))
 		schedule_work(&mconsole_work);
-	reactivate_fd(fd, MCONSOLE_IRQ);
 	return IRQ_HANDLED;
 }
 
@@ -240,7 +239,6 @@ void mconsole_stop(struct mc_request *req)
 		(*req->cmd->handler)(req);
 	}
 	os_set_fd_block(req->originating_fd, 0);
-	reactivate_fd(req->originating_fd, MCONSOLE_IRQ);
 	mconsole_reply(req, "", 0, 0);
 }
 
diff --git a/arch/um/drivers/net_kern.c b/arch/um/drivers/net_kern.c
index 624cb47cc9cd..d80cfb1d9430 100644
--- a/arch/um/drivers/net_kern.c
+++ b/arch/um/drivers/net_kern.c
@@ -137,8 +137,6 @@ static irqreturn_t uml_net_interrupt(int irq, void *dev_id)
 		schedule_work(&lp->work);
 		goto out;
 	}
-	reactivate_fd(lp->fd, UM_ETH_IRQ);
-
 out:
 	spin_unlock(&lp->lock);
 	return IRQ_HANDLED;
diff --git a/arch/um/drivers/port_kern.c b/arch/um/drivers/port_kern.c
index 40ca5cc275e9..b0e9ff35daee 100644
--- a/arch/um/drivers/port_kern.c
+++ b/arch/um/drivers/port_kern.c
@@ -137,7 +137,6 @@ static void port_work_proc(struct work_struct *unused)
 		if (!port->has_connection)
 			continue;
 
-		reactivate_fd(port->fd, ACCEPT_IRQ);
 		while (port_accept(port))
 			;
 		port->has_connection = 0;
diff --git a/arch/um/drivers/random.c b/arch/um/drivers/random.c
index 778a0e52d5a5..1d5d3057e6f1 100644
--- a/arch/um/drivers/random.c
+++ b/arch/um/drivers/random.c
@@ -73,7 +73,6 @@ static ssize_t rng_dev_read (struct file *filp, char __user *buf, size_t size,
 				return ret ? : -EAGAIN;
 
 			atomic_inc(&host_sleep_count);
-			reactivate_fd(random_fd, RANDOM_IRQ);
 			add_sigio_fd(random_fd);
 
 			add_wait_queue(&host_read_wait, &wait);
diff --git a/arch/um/drivers/ubd_kern.c b/arch/um/drivers/ubd_kern.c
index 4fd4cb68f033..23232a3bb2f3 100644
--- a/arch/um/drivers/ubd_kern.c
+++ b/arch/um/drivers/ubd_kern.c
@@ -523,7 +523,6 @@ static void ubd_handler(void)
 			kfree(io_req);
 		}
 	}
-	reactivate_fd(thread_fd, UBD_IRQ);
 }
 
 static irqreturn_t ubd_intr(int irq, void *dev)
diff --git a/arch/um/include/shared/irq_user.h b/arch/um/include/shared/irq_user.h
index a7a6120f19d5..e7242a0ae489 100644
--- a/arch/um/include/shared/irq_user.h
+++ b/arch/um/include/shared/irq_user.h
@@ -31,7 +31,6 @@ struct irq_fd {
 struct siginfo;
 extern void sigio_handler(int sig, struct siginfo *unused_si, struct uml_pt_regs *regs);
 extern void free_irq_by_fd(int fd);
-extern void reactivate_fd(int fd, int irqnum);
 extern void deactivate_fd(int fd, int irqnum);
 extern int deactivate_all_fds(void);
 extern int activate_ipi(int fd, int pid);
diff --git a/arch/um/kernel/irq.c b/arch/um/kernel/irq.c
index 8360fa3f676d..f4874b7ec503 100644
--- a/arch/um/kernel/irq.c
+++ b/arch/um/kernel/irq.c
@@ -350,11 +350,6 @@ static void free_irq_by_irq_and_dev(unsigned int irq, void *dev)
 }
 
 
-void reactivate_fd(int fd, int irqnum)
-{
-	/** NOP - we do auto-EOI now **/
-}
-
 void deactivate_fd(int fd, int irqnum)
 {
 	struct irq_entry *to_free;
@@ -449,7 +444,6 @@ int um_request_irq(unsigned int irq, int fd, int type,
 }
 
 EXPORT_SYMBOL(um_request_irq);
-EXPORT_SYMBOL(reactivate_fd);
 
 /*
  * irq_chip must define at least enable/disable and ack when
diff --git a/arch/um/kernel/sigio.c b/arch/um/kernel/sigio.c
index b5e0cbb34382..3fb6a4041ed6 100644
--- a/arch/um/kernel/sigio.c
+++ b/arch/um/kernel/sigio.c
@@ -16,7 +16,6 @@ static irqreturn_t sigio_interrupt(int irq, void *data)
 	char c;
 
 	os_read_file(sigio_irq_fd, &c, sizeof(c));
-	reactivate_fd(sigio_irq_fd, SIGIO_WRITE_IRQ);
 	return IRQ_HANDLED;
 }
 
-- 
2.11.0


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

