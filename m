Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from ivanoab7.miniserver.com ([37.128.132.42]
 helo=www.kot-begemot.co.uk)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iP8Sm-0004Vu-Cr
 for linux-um@lists.infradead.org; Mon, 28 Oct 2019 17:05:54 +0000
From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Subject: [PATCH] um: Entrust re-queue to the upper layers
Date: Mon, 28 Oct 2019 17:05:43 +0000
Message-Id: <20191028170543.27591-1-anton.ivanov@cambridgegreys.com>
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
Cc: axboe@kernel.dk, richard@nod.at, rrs@researchut.com, hch@lst.de, Anton Ivanov <anton.ivanov@cambridgegreys.com>

Fixes crashes due to ubd requeue logic conflicting with the block-mq
one.

Signed-off-by: Anton Ivanov <anton.ivanov@cambridgegreys.com>
---
 arch/um/drivers/ubd_kern.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/um/drivers/ubd_kern.c b/arch/um/drivers/ubd_kern.c
index 33c1cd6a12ac..3fe2a986f2c4 100644
--- a/arch/um/drivers/ubd_kern.c
+++ b/arch/um/drivers/ubd_kern.c
@@ -1404,7 +1404,7 @@ static blk_status_t ubd_queue_rq(struct blk_mq_hw_ctx *hctx,
 	spin_unlock_irq(&ubd_dev->lock);
 
 	if (ret < 0)
-		blk_mq_requeue_request(req, true);
+		return BLK_STS_DEV_RESOURCE;
 
 	return res;
 }
-- 
2.20.1


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

