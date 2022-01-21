Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from ivanoab7.miniserver.com ([37.128.132.42]
 helo=www.kot-begemot.co.uk)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nArpr-00EkEU-IB
 for linux-um@lists.infradead.org; Fri, 21 Jan 2022 11:12:05 +0000
From: anton.ivanov@cambridgegreys.com
Subject: [PATCH v2] um: Migrate vector drivers to NAPI
Date: Fri, 21 Jan 2022 11:11:49 +0000
Message-Id: <20220121111149.1287874-1-anton.ivanov@cambridgegreys.com>
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
Cc: richard@nod.at, johannes@sipsolutions.net, Anton Ivanov <anton.ivanov@cambridgegreys.com>

From: Anton Ivanov <anton.ivanov@cambridgegreys.com>

Migrate UML vector drivers from a bespoke scheduling mechanism
to NAPI.

Signed-off-by: Anton Ivanov <anton.ivanov@cambridgegreys.com>
---
 arch/um/drivers/vector_kern.c | 105 ++++++++++++++++------------------
 arch/um/drivers/vector_kern.h |   3 +-
 2 files changed, 51 insertions(+), 57 deletions(-)

diff --git a/arch/um/drivers/vector_kern.c b/arch/um/drivers/vector_kern.c
index 4fc1a5d70dcf..1d6f6a66766c 100644
--- a/arch/um/drivers/vector_kern.c
+++ b/arch/um/drivers/vector_kern.c
@@ -67,6 +67,7 @@ static LIST_HEAD(vector_devices);
 static int driver_registered;
 
 static void vector_eth_configure(int n, struct arglist *def);
+static int vector_mmsg_rx(struct vector_private *vp, int budget);
 
 /* Argument accessors to set variables (and/or set default values)
  * mtu, buffer sizing, default headroom, etc
@@ -77,7 +78,6 @@ static void vector_eth_configure(int n, struct arglist *def);
 #define DEFAULT_VECTOR_SIZE 64
 #define TX_SMALL_PACKET 128
 #define MAX_IOV_SIZE (MAX_SKB_FRAGS + 1)
-#define MAX_ITERATIONS 64
 
 static const struct {
 	const char string[ETH_GSTRING_LEN];
@@ -458,7 +458,6 @@ static int vector_send(struct vector_queue *qi)
 					vp->estats.tx_queue_running_average =
 						(vp->estats.tx_queue_running_average + result) >> 1;
 				}
-				netif_trans_update(qi->dev);
 				netif_wake_queue(qi->dev);
 				/* if TX is busy, break out of the send loop,
 				 *  poll write IRQ will reschedule xmit for us
@@ -470,8 +469,6 @@ static int vector_send(struct vector_queue *qi)
 			}
 		}
 		spin_unlock(&qi->head_lock);
-	} else {
-		tasklet_schedule(&vp->tx_poll);
 	}
 	return queue_depth;
 }
@@ -608,7 +605,7 @@ static struct vector_queue *create_queue(
 
 /*
  * We do not use the RX queue as a proper wraparound queue for now
- * This is not necessary because the consumption via netif_rx()
+ * This is not necessary because the consumption via napi_gro_receive()
  * happens in-line. While we can try using the return code of
  * netif_rx() for flow control there are no drivers doing this today.
  * For this RX specific use we ignore the tail/head locks and
@@ -896,7 +893,7 @@ static int vector_legacy_rx(struct vector_private *vp)
 			skb->protocol = eth_type_trans(skb, skb->dev);
 			vp->dev->stats.rx_bytes += skb->len;
 			vp->dev->stats.rx_packets++;
-			netif_rx(skb);
+			napi_gro_receive(&vp->napi, skb);
 		} else {
 			dev_kfree_skb_irq(skb);
 		}
@@ -955,7 +952,7 @@ static int writev_tx(struct vector_private *vp, struct sk_buff *skb)
  * mmsg vector matched to an skb vector which we prepared earlier.
  */
 
-static int vector_mmsg_rx(struct vector_private *vp)
+static int vector_mmsg_rx(struct vector_private *vp, int budget)
 {
 	int packet_count, i;
 	struct vector_queue *qi = vp->rx_queue;
@@ -972,6 +969,9 @@ static int vector_mmsg_rx(struct vector_private *vp)
 
 	/* Fire the Lazy Gun - get as many packets as we can in one go. */
 
+	if (budget > qi->max_depth)
+		budget = qi->max_depth;
+
 	packet_count = uml_vector_recvmmsg(
 		vp->fds->rx_fd, qi->mmsg_vector, qi->max_depth, 0);
 
@@ -1021,7 +1021,7 @@ static int vector_mmsg_rx(struct vector_private *vp)
 			 */
 			vp->dev->stats.rx_bytes += skb->len;
 			vp->dev->stats.rx_packets++;
-			netif_rx(skb);
+			napi_gro_receive(&vp->napi, skb);
 		} else {
 			/* Overlay header too short to do anything - discard.
 			 * We can actually keep this skb and reuse it,
@@ -1044,23 +1044,6 @@ static int vector_mmsg_rx(struct vector_private *vp)
 	return packet_count;
 }
 
-static void vector_rx(struct vector_private *vp)
-{
-	int err;
-	int iter = 0;
-
-	if ((vp->options & VECTOR_RX) > 0)
-		while (((err = vector_mmsg_rx(vp)) > 0) && (iter < MAX_ITERATIONS))
-			iter++;
-	else
-		while (((err = vector_legacy_rx(vp)) > 0) && (iter < MAX_ITERATIONS))
-			iter++;
-	if ((err != 0) && net_ratelimit())
-		netdev_err(vp->dev, "vector_rx: error(%d)\n", err);
-	if (iter == MAX_ITERATIONS)
-		netdev_err(vp->dev, "vector_rx: device stuck, remote end may have closed the connection\n");
-}
-
 static int vector_net_start_xmit(struct sk_buff *skb, struct net_device *dev)
 {
 	struct vector_private *vp = netdev_priv(dev);
@@ -1085,25 +1068,15 @@ static int vector_net_start_xmit(struct sk_buff *skb, struct net_device *dev)
 	netdev_sent_queue(vp->dev, skb->len);
 	queue_depth = vector_enqueue(vp->tx_queue, skb);
 
-	/* if the device queue is full, stop the upper layers and
-	 * flush it.
-	 */
-
-	if (queue_depth >= vp->tx_queue->max_depth - 1) {
-		vp->estats.tx_kicks++;
-		netif_stop_queue(dev);
-		vector_send(vp->tx_queue);
-		return NETDEV_TX_OK;
-	}
-	if (netdev_xmit_more()) {
+	if (queue_depth < vp->tx_queue->max_depth && netdev_xmit_more()) {
 		mod_timer(&vp->tl, vp->coalesce);
 		return NETDEV_TX_OK;
+	} else {
+		queue_depth = vector_send(vp->tx_queue);
+		if (queue_depth > 0)
+			napi_schedule(&vp->napi);
 	}
-	if (skb->len < TX_SMALL_PACKET) {
-		vp->estats.tx_kicks++;
-		vector_send(vp->tx_queue);
-	} else
-		tasklet_schedule(&vp->tx_poll);
+
 	return NETDEV_TX_OK;
 }
 
@@ -1114,7 +1087,7 @@ static irqreturn_t vector_rx_interrupt(int irq, void *dev_id)
 
 	if (!netif_running(dev))
 		return IRQ_NONE;
-	vector_rx(vp);
+	napi_schedule(&vp->napi);
 	return IRQ_HANDLED;
 
 }
@@ -1133,8 +1106,7 @@ static irqreturn_t vector_tx_interrupt(int irq, void *dev_id)
 	 * tweaking the IRQ mask less costly
 	 */
 
-	if (vp->in_write_poll)
-		tasklet_schedule(&vp->tx_poll);
+	napi_schedule(&vp->napi);
 	return IRQ_HANDLED;
 
 }
@@ -1161,7 +1133,8 @@ static int vector_net_close(struct net_device *dev)
 		um_free_irq(vp->tx_irq, dev);
 		vp->tx_irq = 0;
 	}
-	tasklet_kill(&vp->tx_poll);
+	napi_disable(&vp->napi);
+	netif_napi_del(&vp->napi);
 	if (vp->fds->rx_fd > 0) {
 		if (vp->bpf)
 			uml_vector_detach_bpf(vp->fds->rx_fd, vp->bpf);
@@ -1193,15 +1166,32 @@ static int vector_net_close(struct net_device *dev)
 	return 0;
 }
 
-/* TX tasklet */
-
-static void vector_tx_poll(struct tasklet_struct *t)
+static int vector_poll(struct napi_struct *napi, int budget)
 {
-	struct vector_private *vp = from_tasklet(vp, t, tx_poll);
+	struct vector_private *vp = container_of(napi, struct vector_private, napi);
+	int work_done = 0;
+	int err;
+	bool tx_enqueued = false;
 
-	vp->estats.tx_kicks++;
-	vector_send(vp->tx_queue);
+	if ((vp->options & VECTOR_TX) != 0)
+		tx_enqueued = (vector_send(vp->tx_queue) > 0);
+	if ((vp->options & VECTOR_RX) > 0)
+		err = vector_mmsg_rx(vp, budget);
+	else {
+		err = vector_legacy_rx(vp);
+		if (err > 0)
+			err = 1;
+	}
+	if (err > 0)
+		work_done += err;
+
+	if (tx_enqueued || err > 0)
+		napi_schedule(napi);
+	if (work_done < budget)
+		napi_complete_done(napi, work_done);
+	return work_done;
 }
+
 static void vector_reset_tx(struct work_struct *work)
 {
 	struct vector_private *vp =
@@ -1265,6 +1255,9 @@ static int vector_net_open(struct net_device *dev)
 			goto out_close;
 	}
 
+	netif_napi_add(vp->dev, &vp->napi, vector_poll, get_depth(vp->parsed));
+	napi_enable(&vp->napi);
+
 	/* READ IRQ */
 	err = um_request_irq(
 		irq_rr + VECTOR_BASE_IRQ, vp->fds->rx_fd,
@@ -1306,15 +1299,15 @@ static int vector_net_open(struct net_device *dev)
 		uml_vector_attach_bpf(vp->fds->rx_fd, vp->bpf);
 
 	netif_start_queue(dev);
+	vector_reset_stats(vp);
 
 	/* clear buffer - it can happen that the host side of the interface
 	 * is full when we get here. In this case, new data is never queued,
 	 * SIGIOs never arrive, and the net never works.
 	 */
 
-	vector_rx(vp);
+	napi_schedule(&vp->napi);
 
-	vector_reset_stats(vp);
 	vdevice = find_device(vp->unit);
 	vdevice->opened = 1;
 
@@ -1543,15 +1536,16 @@ static const struct net_device_ops vector_netdev_ops = {
 #endif
 };
 
-
 static void vector_timer_expire(struct timer_list *t)
 {
 	struct vector_private *vp = from_timer(vp, t, tl);
 
 	vp->estats.tx_kicks++;
-	vector_send(vp->tx_queue);
+	napi_schedule(&vp->napi);
 }
 
+
+
 static void vector_eth_configure(
 		int n,
 		struct arglist *def
@@ -1634,7 +1628,6 @@ static void vector_eth_configure(
 	});
 
 	dev->features = dev->hw_features = (NETIF_F_SG | NETIF_F_FRAGLIST);
-	tasklet_setup(&vp->tx_poll, vector_tx_poll);
 	INIT_WORK(&vp->reset_tx, vector_reset_tx);
 
 	timer_setup(&vp->tl, vector_timer_expire, 0);
diff --git a/arch/um/drivers/vector_kern.h b/arch/um/drivers/vector_kern.h
index 8fff93a75a92..2a1fa8e0f3e1 100644
--- a/arch/um/drivers/vector_kern.h
+++ b/arch/um/drivers/vector_kern.h
@@ -14,6 +14,7 @@
 #include <linux/ctype.h>
 #include <linux/workqueue.h>
 #include <linux/interrupt.h>
+
 #include "vector_user.h"
 
 /* Queue structure specially adapted for multiple enqueue/dequeue
@@ -72,6 +73,7 @@ struct vector_private {
 	struct list_head list;
 	spinlock_t lock;
 	struct net_device *dev;
+	struct napi_struct		napi	____cacheline_aligned;
 
 	int unit;
 
@@ -115,7 +117,6 @@ struct vector_private {
 
 	spinlock_t stats_lock;
 
-	struct tasklet_struct tx_poll;
 	bool rexmit_scheduled;
 	bool opened;
 	bool in_write_poll;
-- 
2.30.2


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

