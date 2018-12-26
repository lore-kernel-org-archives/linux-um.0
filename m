Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from smtp02.smtpout.orange.fr ([80.12.242.124]
 helo=smtp.smtpout.orange.fr)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gcotx-0001tR-Ap
 for linux-um@lists.infradead.org; Fri, 28 Dec 2018 09:57:59 +0000
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH 1/2] um: vector: Fix a potential NULL pointer dereference in
 'vector_net_open()'
Date: Wed, 26 Dec 2018 08:54:36 +0100
Message-Id: <20181226075436.11018-1-christophe.jaillet@wanadoo.fr>
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
To: jdike@addtoit.com, richard@nod.at, anton.ivanov@cambridgegreys.com, rppt@linux.vnet.ibm.com, akpm@linux-foundation.org, yuehaibing@huawei.com, keescook@chromium.org
Cc: kernel-janitors@vger.kernel.org, Christophe JAILLET <christophe.jaillet@wanadoo.fr>, linux-um@lists.infradead.org, linux-kernel@vger.kernel.org

'create_queue()' returns NULL in case of memory allocation failure. So we
must check if it succeeds in order to avoid potential NULL pointer
dereference.

For 'vp->rx_queue', the dereference would occur just one line after the
failed allocation. For 'vp->tx_queue', it would occur later during normal
processing.

Fixes: 49da7e64f33e ("High Performance UML Vector Network Driver")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 arch/um/drivers/vector_kern.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/um/drivers/vector_kern.c b/arch/um/drivers/vector_kern.c
index 046fa9ea0ccc..5b917716289d 100644
--- a/arch/um/drivers/vector_kern.c
+++ b/arch/um/drivers/vector_kern.c
@@ -1182,6 +1182,8 @@ static int vector_net_open(struct net_device *dev)
 			vp->rx_header_size,
 			MAX_IOV_SIZE
 		);
+		if (!vp->rx_queue)
+			goto out_close;
 		vp->rx_queue->queue_depth = get_depth(vp->parsed);
 	} else {
 		vp->header_rxbuffer = kmalloc(
@@ -1198,6 +1200,8 @@ static int vector_net_open(struct net_device *dev)
 			vp->header_size,
 			MAX_IOV_SIZE
 		);
+		if (!vp->tx_queue)
+			goto out_close;
 	} else {
 		vp->header_txbuffer = kmalloc(vp->header_size, GFP_KERNEL);
 		if (vp->header_txbuffer == NULL)
-- 
2.19.1


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

