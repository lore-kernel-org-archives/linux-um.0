Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from ivanoab7.miniserver.com ([37.128.132.42]
 helo=www.kot-begemot.co.uk)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iPNZR-0000wD-1i
 for linux-um@lists.infradead.org; Tue, 29 Oct 2019 09:13:46 +0000
From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Subject: [PATCH v2] um: Entrust re-queue to the upper layers
Date: Tue, 29 Oct 2019 09:13:34 +0000
Message-Id: <20191029091334.3095-1-anton.ivanov@cambridgegreys.com>
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
Cc: axboe@kernel.dk, rrs@researchut.com, richard@nod.at, stable@vger.kernel.org, hch@lst.de, Anton Ivanov <anton.ivanov@cambridgegreys.com>

Fixes crashes due to ubd requeue logic conflicting with the block-mq
logic. Crash is reproducible in 5.0 - 5.3.

Fixes: 53766defb8c860a47e2a965f5b4b05ed2848e2d0
Signed-off-by: Anton Ivanov <anton.ivanov@cambridgegreys.com>
---
 arch/um/drivers/ubd_kern.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/um/drivers/ubd_kern.c b/arch/um/drivers/ubd_kern.c
index 33c1cd6a12ac..40ab9ad7aa96 100644
--- a/arch/um/drivers/ubd_kern.c
+++ b/arch/um/drivers/ubd_kern.c
@@ -1403,8 +1403,12 @@ static blk_status_t ubd_queue_rq(struct blk_mq_hw_ctx *hctx,
 
 	spin_unlock_irq(&ubd_dev->lock);
 
-	if (ret < 0)
-		blk_mq_requeue_request(req, true);
+	if (ret < 0) {
+		if (ret == -ENOMEM)
+			res = BLK_STS_RESOURCE;
+		else
+			res = BLK_STS_DEV_RESOURCE;
+	}
 
 	return res;
 }
-- 
2.20.1


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

