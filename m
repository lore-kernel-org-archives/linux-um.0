Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <anton.ivanov@kot-begemot.co.uk>) id 1dX0Cs-0005lx-Rf
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 17 Jul 2017 07:12:38 +0000
Received: from ivanoab5.miniserver.com ([78.31.111.25]
	helo=www.kot-begemot.co.uk)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1dX0Cq-00085g-AB
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 17 Jul 2017 07:12:38 +0000
From: anton.ivanov@kot-begemot.co.uk
Date: Mon, 17 Jul 2017 07:29:11 +0100
Message-Id: <20170717062911.26576-4-anton.ivanov@kot-begemot.co.uk>
In-Reply-To: <20170717062911.26576-1-anton.ivanov@kot-begemot.co.uk>
References: <20170717062911.26576-1-anton.ivanov@kot-begemot.co.uk>
Subject: [uml-devel] [PATCH 3/3] Scatter Gather support for vector IO in UML
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/user-mode-linux-devel>,
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
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Anton Ivanov <anton.ivanov@cambridgegreys.com>

From: Anton Ivanov <anton.ivanov@cambridgegreys.com>

Adds scatter gather support to the vector network drivers.
Provides additional 55% performance improvement for most
network applications running in the UML instance.

Signed-off-by: Anton Ivanov <anton.ivanov@cambridgegreys.com>
---
 arch/um/drivers/vector_kern.c | 63 +++++++++++++++++++++++++++++++++----------
 arch/um/drivers/vector_kern.h |  4 ++-
 2 files changed, 52 insertions(+), 15 deletions(-)

diff --git a/arch/um/drivers/vector_kern.c b/arch/um/drivers/vector_kern.c
index ee61f1338b0f..4142a0a782bd 100644
--- a/arch/um/drivers/vector_kern.c
+++ b/arch/um/drivers/vector_kern.c
@@ -75,6 +75,7 @@ static void vector_eth_configure(int n, struct arglist *def);
 #define SAFETY_MARGIN 32
 #define DEFAULT_VECTOR_SIZE 64
 #define TX_SMALL_PACKET 128
+#define MAX_IOV_SIZE 8
 
 static const struct {
 	const char string[ETH_GSTRING_LEN];
@@ -90,7 +91,9 @@ static const struct {
 	{ "tx_flow_control_xon" },
 	{ "tx_flow_control_xoff" },
 	{ "rx_csum_offload_good" },
-	{ "rx_csum_offload_errors"}
+	{ "rx_csum_offload_errors"},
+	{ "sg_ok"},
+	{ "sg_linearized"},
 };
 
 #define VECTOR_NUM_STATS	ARRAY_SIZE(ethtool_stats_keys)
@@ -119,6 +122,8 @@ static void vector_reset_stats(struct vector_private *vp)
 	vp->estats.tx_kicks = 0;
 	vp->estats.tx_flow_control_xon = 0;
 	vp->estats.tx_flow_control_xoff = 0;
+	vp->estats.sg_ok = 0;
+	vp->estats.sg_linearized = 0;
 }
 
 static int get_mtu(struct arglist *def)
@@ -247,14 +252,18 @@ static int vector_enqueue(struct vector_queue *qi, struct sk_buff *skb)
 {
 	struct vector_private *vp = netdev_priv(qi->dev);
 	int queue_depth;
+	int nr_frags, frag, packet_len;
 	struct mmsghdr *mmsg_vector = qi->mmsg_vector;
 	struct iovec *iov;
+	skb_frag_t *skb_frag;
 
 	spin_lock(&qi->tail_lock);
 	spin_lock(&qi->head_lock);
 	queue_depth = qi->queue_depth;
 	spin_unlock(&qi->head_lock);
 
+	if (skb)
+		packet_len = skb->len;
 
 	if (queue_depth < qi->max_depth) {
 
@@ -264,19 +273,41 @@ static int vector_enqueue(struct vector_queue *qi, struct sk_buff *skb)
 
 		mmsg_vector->msg_hdr.msg_name = vp->fds->remote_addr;
 		mmsg_vector->msg_hdr.msg_namelen = vp->fds->remote_addr_size;
+		nr_frags = skb_shinfo(skb)->nr_frags;
 		if (vp->header_size > 0) {
 			vp->form_header(iov->iov_base, skb, vp);
 			iov++;
-		}
+			mmsg_vector->msg_hdr.msg_iovlen = 2 + nr_frags;
+		} else
+			mmsg_vector->msg_hdr.msg_iovlen = 1 + nr_frags;
+		if (nr_frags > qi->max_iov_frags) {
+			if (skb_linearize(skb) != 0)
+				goto drop;
+			else
+				vp->estats.sg_linearized++;
+		} else
+			 vp->estats.sg_ok++;
 		iov->iov_base = skb->data;
-		iov->iov_len = skb->len;
-		queue_depth = vector_advancetail(qi, 1);
-	} else {
-		qi->dev->stats.tx_dropped++;
-		if (skb != NULL) {
-			dev_consume_skb_any(skb);
-			netdev_completed_queue(qi->dev, 1, skb->len);
+		if (nr_frags > 0)
+			iov->iov_len = skb->len - skb->data_len;
+		else
+			iov->iov_len = skb->len;
+		for (frag = 0; frag < nr_frags; frag++) {
+			iov++;
+			skb_frag = &skb_shinfo(skb)->frags[frag];
+			iov->iov_base = skb_frag_address_safe(skb_frag);
+			iov->iov_len = skb_frag_size(skb_frag);
 		}
+		queue_depth = vector_advancetail(qi, 1);
+	} else
+		goto drop;
+	spin_unlock(&qi->tail_lock);
+	return queue_depth;
+drop:
+	qi->dev->stats.tx_dropped++;
+	if (skb != NULL) {
+		dev_consume_skb_any(skb);
+		netdev_completed_queue(qi->dev, 1, packet_len);
 	}
 	spin_unlock(&qi->tail_lock);
 	return queue_depth;
@@ -424,7 +455,8 @@ static void destroy_queue(struct vector_queue *qi)
 static struct vector_queue *create_queue(
 	struct vector_private *vp,
 	int max_size,
-	int header_size)
+	int header_size,
+	int num_extra_frags)
 {
 	struct vector_queue *result;
 	int i;
@@ -455,9 +487,9 @@ static struct vector_queue *create_queue(
 	mmsg_vector = result->mmsg_vector;
 	for (i = 0; i < max_size; i++) {
 		if (vp->header_size > 0)
-			iov = kmalloc(sizeof(struct iovec) * 2, GFP_KERNEL);
+			iov = kmalloc(sizeof(struct iovec) * (2 + num_extra_frags), GFP_KERNEL);
 		else
-			iov = kmalloc(sizeof(struct iovec), GFP_KERNEL);
+			iov = kmalloc(sizeof(struct iovec) * (1 + num_extra_frags), GFP_KERNEL);
 		if (iov == NULL)
 			goto out_fail;
 		mmsg_vector->msg_hdr.msg_iov = iov;
@@ -1049,7 +1081,7 @@ static int vector_net_open(struct net_device *dev)
 		goto out_close;
 	if ((vp->options & VECTOR_RX) > 0) {
 		vp->rx_queue = create_queue(
-			vp, get_depth(vp->parsed), vp->rx_header_size);
+			vp, get_depth(vp->parsed), vp->rx_header_size, 0);
 		vp->rx_queue->queue_depth = get_depth(vp->parsed);
 	} else {
 		vp->header_rxbuffer = kmalloc(vp->rx_header_size, GFP_KERNEL);
@@ -1061,7 +1093,7 @@ static int vector_net_open(struct net_device *dev)
 			goto out_close;
 	if ((vp->options & VECTOR_TX) > 0)
 		vp->tx_queue = create_queue(
-			vp, get_depth(vp->parsed), vp->header_size);
+			vp, get_depth(vp->parsed), vp->header_size, MAX_IOV_SIZE);
 
 	/* READ IRQ */
 	err = um_request_irq(
@@ -1335,6 +1367,9 @@ static void vector_eth_configure(
 		.coalesce		= 2
 		});
 
+	/* if we can do vector TX, we can do scatter/gather too */
+	if ((vp->options & VECTOR_TX) > 0)
+		dev->features = NETIF_F_SG;
 	tasklet_init(&vp->tx_poll, vector_tx_poll, (unsigned long)vp);
 	INIT_WORK(&vp->reset_tx, vector_reset_tx);
 
diff --git a/arch/um/drivers/vector_kern.h b/arch/um/drivers/vector_kern.h
index 7505ed8a4e37..c10d746ae6e4 100644
--- a/arch/um/drivers/vector_kern.h
+++ b/arch/um/drivers/vector_kern.h
@@ -39,7 +39,7 @@ struct vector_queue {
 	struct net_device *dev;
 	spinlock_t head_lock;
 	spinlock_t tail_lock;
-	int queue_depth, head, tail, max_depth;
+	int queue_depth, head, tail, max_depth, max_iov_frags;
 	short options;
 };
 
@@ -56,6 +56,8 @@ struct vector_estats {
 	uint64_t tx_flow_control_xoff;
 	uint64_t rx_csum_offload_good;
 	uint64_t rx_csum_offload_errors;
+	uint64_t sg_ok;
+	uint64_t sg_linearized;
 };
 
 struct vector_private {
-- 
2.11.0


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

