Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <anton.ivanov@kot-begemot.co.uk>) id 1XPcGt-00055y-Hw
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 04 Sep 2014 19:00:39 +0000
Received: from ivanoab3.miniserver.com ([89.200.143.206])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1XPcGs-0002zr-92
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 04 Sep 2014 19:00:39 +0000
From: anton.ivanov@kot-begemot.co.uk
Date: Thu,  4 Sep 2014 20:00:19 +0100
Message-Id: <1409857227-717756-3-git-send-email-anton.ivanov@kot-begemot.co.uk>
In-Reply-To: <1409857227-717756-1-git-send-email-anton.ivanov@kot-begemot.co.uk>
References: <1409857227-717756-1-git-send-email-anton.ivanov@kot-begemot.co.uk>
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
Subject: [uml-devel] [PATCH v3 02/10] Remove unnecessary 'reactivate'
	statements
To: user-mode-linux-devel@lists.sourceforge.net

From: Anton Ivanov <antivano@cisco.com>

The epoll based controller has real (not emulated) edge and
level semantics and the edge/level is handled by epoll. There
is no toggling of the poll set any more, thus it is removed
throughout

Signed-off-by: Anton Ivanov <antivano@cisco.com>
---
 arch/um/drivers/chan_kern.c     |    2 --
 arch/um/drivers/line.c          |    2 --
 arch/um/drivers/mconsole_kern.c |    2 --
 arch/um/drivers/net_kern.c      |    2 --
 arch/um/drivers/port_kern.c     |    1 -
 arch/um/drivers/random.c        |    1 -
 arch/um/drivers/ubd_kern.c      |    1 -
 7 files changed, 11 deletions(-)

diff --git a/arch/um/drivers/chan_kern.c b/arch/um/drivers/chan_kern.c
index acbe6c6..db0ff51 100644
--- a/arch/um/drivers/chan_kern.c
+++ b/arch/um/drivers/chan_kern.c
@@ -564,8 +564,6 @@ void chan_interrupt(struct line *line, int irq)
 			tty_insert_flip_char(port, c, TTY_NORMAL);
 	} while (err > 0);
 
-	if (err == 0)
-		reactivate_fd(chan->fd, irq);
 	if (err == -EIO) {
 		if (chan->primary) {
 			tty_port_tty_hangup(&line->port, false);
diff --git a/arch/um/drivers/line.c b/arch/um/drivers/line.c
index 6c4511f..1e8df84 100644
--- a/arch/um/drivers/line.c
+++ b/arch/um/drivers/line.c
@@ -663,8 +663,6 @@ static irqreturn_t winch_interrupt(int irq, void *data)
 		tty_kref_put(tty);
 	}
  out:
-	if (winch->fd != -1)
-		reactivate_fd(winch->fd, WINCH_IRQ);
 	return IRQ_HANDLED;
 }
 
diff --git a/arch/um/drivers/mconsole_kern.c b/arch/um/drivers/mconsole_kern.c
index 3df3bd5..2b9bfa7 100644
--- a/arch/um/drivers/mconsole_kern.c
+++ b/arch/um/drivers/mconsole_kern.c
@@ -95,7 +95,6 @@ static irqreturn_t mconsole_interrupt(int irq, void *dev_id)
 	}
 	if (!list_empty(&mc_requests))
 		schedule_work(&mconsole_work);
-	reactivate_fd(fd, MCONSOLE_IRQ);
 	return IRQ_HANDLED;
 }
 
@@ -243,7 +242,6 @@ void mconsole_stop(struct mc_request *req)
 		(*req->cmd->handler)(req);
 	}
 	os_set_fd_block(req->originating_fd, 0);
-	reactivate_fd(req->originating_fd, MCONSOLE_IRQ);
 	mconsole_reply(req, "", 0, 0);
 }
 
diff --git a/arch/um/drivers/net_kern.c b/arch/um/drivers/net_kern.c
index 39f1862..64d8426 100644
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
index 40ca5cc..b0e9ff3 100644
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
index 9e3a722..ec3d788 100644
--- a/arch/um/drivers/random.c
+++ b/arch/um/drivers/random.c
@@ -72,7 +72,6 @@ static ssize_t rng_dev_read (struct file *filp, char __user *buf, size_t size,
 				return ret ? : -EAGAIN;
 
 			atomic_inc(&host_sleep_count);
-			reactivate_fd(random_fd, RANDOM_IRQ);
 			add_sigio_fd(random_fd);
 
 			add_wait_queue(&host_read_wait, &wait);
diff --git a/arch/um/drivers/ubd_kern.c b/arch/um/drivers/ubd_kern.c
index 3716e69..1cc72ae5 100644
--- a/arch/um/drivers/ubd_kern.c
+++ b/arch/um/drivers/ubd_kern.c
@@ -466,7 +466,6 @@ static void ubd_handler(void)
 		blk_end_request(req->req, 0, req->length);
 		kfree(req);
 	}
-	reactivate_fd(thread_fd, UBD_IRQ);
 
 	list_for_each_safe(list, next_ele, &restart){
 		ubd = container_of(list, struct ubd, restart);
-- 
1.7.10.4


------------------------------------------------------------------------------
Slashdot TV.  
Video for Nerds.  Stuff that matters.
http://tv.slashdot.org/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

