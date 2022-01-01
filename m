Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from lithops.sigma-star.at ([195.201.40.130])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1n3mOU-007PKh-54
 for linux-um@lists.infradead.org; Sat, 01 Jan 2022 21:58:33 +0000
From: Richard Weinberger <richard@nod.at>
Subject: [PATCH 3/4] um: chan: Restore blocking mode upon exit
Date: Sat,  1 Jan 2022 22:58:09 +0100
Message-Id: <20220101215810.13260-4-richard@nod.at>
In-Reply-To: <20220101215810.13260-1-richard@nod.at>
References: <20220101215810.13260-1-richard@nod.at>
MIME-Version: 1.0
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
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: linux-um@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, johannes.berg@intel.com, anton.ivanov@cambridgegreys.com, Richard Weinberger <richard@nod.at>

Make sure that O_NONBLOCK is cleared upon exit if UML sets it.
Otherwise stdin/out behaves strange after UML terminates.

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 arch/um/drivers/chan.h      | 1 +
 arch/um/drivers/chan_kern.c | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/arch/um/drivers/chan.h b/arch/um/drivers/chan.h
index c37cc4f26f91..6b8c462f146e 100644
--- a/arch/um/drivers/chan.h
+++ b/arch/um/drivers/chan.h
@@ -22,6 +22,7 @@ struct chan {
 	unsigned int output:1;
 	unsigned int opened:1;
 	unsigned int enabled:1;
+	unsigned int fd_blocking:1;
 	int fd;
 	const struct chan_ops *ops;
 	void *data;
diff --git a/arch/um/drivers/chan_kern.c b/arch/um/drivers/chan_kern.c
index 86be115b5890..6d512589fa50 100644
--- a/arch/um/drivers/chan_kern.c
+++ b/arch/um/drivers/chan_kern.c
@@ -102,6 +102,7 @@ static int open_one_chan(struct chan *chan)
 	}
 
 	chan->fd = fd;
+	chan->fd_blocking = ret;
 
 	chan->opened = 1;
 	return 0;
@@ -223,6 +224,8 @@ static void close_one_chan(struct chan *chan, int delay_free_irq)
 	if (chan->ops->close != NULL)
 		(*chan->ops->close)(chan->fd, chan->data);
 
+	os_set_fd_block(chan->fd, chan->fd_blocking);
+
 	chan->opened = 0;
 	chan->fd = -1;
 }
-- 
2.26.2


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

