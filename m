Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oaoC7-007rd9-Es
	for linux-um@lists.infradead.org; Wed, 21 Sep 2022 01:06:33 +0000
From: Yang Li <yang.lee@linux.alibaba.com>
Subject: [PATCH -next] um: remove unneeded semicolon
Date: Wed, 21 Sep 2022 09:06:09 +0800
Message-Id: <20220921010609.116496-1-yang.lee@linux.alibaba.com>
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
To: richard@nod.at
Cc: anton.ivanov@cambridgegreys.com, johannes@sipsolutions.net, linux-um@lists.infradead.org, linux-kernel@vger.kernel.org, Yang Li <yang.lee@linux.alibaba.com>, Abaci Robot <abaci@linux.alibaba.com>

while(){}, semicolon do not need to be appended.

Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=2237
Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 arch/um/drivers/virtio_uml.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/um/drivers/virtio_uml.c b/arch/um/drivers/virtio_uml.c
index 588930a0ced1..198aaed81ce6 100644
--- a/arch/um/drivers/virtio_uml.c
+++ b/arch/um/drivers/virtio_uml.c
@@ -412,7 +412,7 @@ static irqreturn_t vu_req_read_message(struct virtio_uml_device *vu_dev,
 		if (msg.msg.header.flags & VHOST_USER_FLAG_NEED_REPLY)
 			vhost_user_reply(vu_dev, &msg.msg, response);
 		irq_rc = IRQ_HANDLED;
-	};
+	}
 	/* mask EAGAIN as we try non-blocking read until socket is empty */
 	vu_dev->recv_rc = (rc == -EAGAIN) ? 0 : rc;
 	return irq_rc;
-- 
2.20.1.7.g153144c


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

