Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from ivanoab6.miniserver.com ([5.153.251.140]
 helo=www.kot-begemot.co.uk)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gyf54-0006If-1v
 for linux-um@lists.infradead.org; Tue, 26 Feb 2019 15:55:43 +0000
From: anton.ivanov@cambridgegreys.com
Subject: [PATCH] um: Fix for a possible OOPS in ubd initialization
Date: Tue, 26 Feb 2019 15:55:25 +0000
Message-Id: <20190226155525.30549-1-anton.ivanov@cambridgegreys.com>
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

If the ubd device failed to allocate a queue during
initialization it tried call blk_cleanup_queue resulting
in an oops.

This patch simplifies the cleanup logic and ensures that
blk_queue_cleanup is called only if there is a valid queue.

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Anton Ivanov <anton.ivanov@cambridgegreys.com>
---
 arch/um/drivers/ubd_kern.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/um/drivers/ubd_kern.c b/arch/um/drivers/ubd_kern.c
index a4a41421c5e2..aca09be2373e 100644
--- a/arch/um/drivers/ubd_kern.c
+++ b/arch/um/drivers/ubd_kern.c
@@ -938,7 +938,7 @@ static int ubd_add(int n, char **error_out)
 	ubd_dev->queue = blk_mq_init_queue(&ubd_dev->tag_set);
 	if (IS_ERR(ubd_dev->queue)) {
 		err = PTR_ERR(ubd_dev->queue);
-		goto out_cleanup;
+		goto out_cleanup_tags;
 	}
 
 	ubd_dev->queue->queuedata = ubd_dev;
@@ -968,8 +968,8 @@ static int ubd_add(int n, char **error_out)
 
 out_cleanup_tags:
 	blk_mq_free_tag_set(&ubd_dev->tag_set);
-out_cleanup:
-	blk_cleanup_queue(ubd_dev->queue);
+	if (!(IS_ERR(ubd_dev->queue)))
+		blk_cleanup_queue(ubd_dev->queue);
 	goto out;
 }
 
-- 
2.11.0


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

