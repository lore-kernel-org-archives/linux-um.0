Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19484606A319
	for <linux-um@archiver.kernel.org>; Wed, 21 Oct 2026 13:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=sjNKeNt2
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=0k3tu4/56XhMO5CVcZP+vpcbcZSLy5CzqP+A0jx0HfU=; b=sjNKeNt2IKy8lKB6e/88oOwVbc
	qsuCs2Heca/s/JItDd0xfNnvUiAxDq/B0/1YMEq6V27/yRqthFFFdgu9NXwxWAGDEUurW+1U+C2GW
	nTeQWHGkA6N3Y/F5gjCH8U387MA8WOMyi73Jp5aJfuLSEaQt22xMHIuageAdLcR+wSjBVvEXDMojT
	+HBIh7wmGlROLiz7wVutEaVQujrv6sTtSQs7Ki8LSj5lxiscTqySTK/qgypsn0qRfcbtucmnJ1mS6
	Kw5dCCYyZuyXzV6lApydEn6HlUeqI9jq4TM1BuTE86Qe5bWjbHDhZ94yMTD5d33y1qUw3VVS9CIzk
	qrRgg+FQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJW2F-0000000BrZu-3cPk;
	Wed, 21 Oct 2026 13:07:15 +0000
Received: from ns1.kot-begemot.co.uk ([217.160.28.25] helo=www.kot-begemot.co.uk)
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJW2C-0000000BrZE-2C2R
	for linux-um@lists.infradead.org;
	Wed, 21 Oct 2026 13:07:14 +0000
Received: from [192.168.17.6] (helo=jain.kot-begemot.co.uk)
	by www.kot-begemot.co.uk with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <anton.ivanov@cambridgegreys.com>)
	id 1xJW26-008tGm-RN; Wed, 21 Oct 2026 13:07:07 +0000
Received: from [192.168.21.17] (helo=MrCrane.kot-begemot.co.uk)
	by jain.kot-begemot.co.uk with esmtp (Exim 4.98.2)
	(envelope-from <anton.ivanov@cambridgegreys.com>)
	id 1xJVj2-00000003Wtb-1CCx;
	Wed, 21 Oct 2026 14:07:04 +0100
From: anton.ivanov@cambridgegreys.com
To: linux-um@lists.infradead.org
Cc: richard@nod.at,
	johannes@sipsolutions.net,
	mst@redhat.com,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>
Subject: [PATCH] um: vector: Possible underflow and races fixes
Date: Wed, 21 Oct 2026 14:05:15 +0100
Message-ID: <20261021130648.3373281-1-anton.ivanov@cambridgegreys.com>
X-Mailer: git-send-email 2.47.3
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -1.0
X-Spam-Score: -1.0
X-Clacks-Overhead: GNU Terry Pratchett
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261021_060712_738376_9D247B59 
X-CRM114-Status: GOOD (  21.05  )
X-Spam-Score: -1.9 (-)
X-BeenThere: linux-um@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-um.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Anton Ivanov <anton.ivanov@cambridgegreys.com>

Michael S. Tsirkin while working on net virtio checksum hardening
discovered a number of issues in the uml vector driver. This patch
addresses these issues.

1. Use of header_size, not rx_header_size in some of the runt/underflow
checks. IPV6 raw socket API for protocols like GRE or L2TPV2 is asymmetric -
the header format and size in recv and send differ. All rx checks must use
the rx specific size.

2. Vector reuses rx and tx queue locks for stats. These queues are not
always allocated as some transports do not use them and they can be
disabled on the kernel command line. Resetting or accessing ethtool stats
in this case could lead to a null pointer dereference.

3. virtio_net_header processing was not up to date with all the GSO
additions and changes and was skipping necessary processing.

4. Missing barrier in vector_send().

5. Incorrect timer destruction in net_close()

Signed-off-by: Anton Ivanov <anton.ivanov@cambridgegreys.com>
---
 arch/um/drivers/vector_kern.c       | 65 +++++++++++++++++++----------
 arch/um/drivers/vector_kern.h       |  2 -
 arch/um/drivers/vector_transports.c |  3 --
 3 files changed, 43 insertions(+), 27 deletions(-)

diff --git a/arch/um/drivers/vector_kern.c b/arch/um/drivers/vector_kern.c
index 8a70b3a62553..b8e3cc21d7da 100644
--- a/arch/um/drivers/vector_kern.c
+++ b/arch/um/drivers/vector_kern.c
@@ -108,22 +108,26 @@ static void vector_reset_stats(struct vector_private *vp)
 	/* We reuse the existing queue locks for stats */
 
 	/* RX stats are modified with RX head_lock held
-	 * in vector_poll.
+	 * in vector_poll when using vector RX.
 	 */
 
-	spin_lock(&vp->rx_queue->head_lock);
+	if (vp->rx_queue)
+		spin_lock(&vp->rx_queue->head_lock);
+
 	vp->estats.rx_queue_max = 0;
 	vp->estats.rx_queue_running_average = 0;
 	vp->estats.rx_encaps_errors = 0;
 	vp->estats.sg_ok = 0;
 	vp->estats.sg_linearized = 0;
-	spin_unlock(&vp->rx_queue->head_lock);
+	if (vp->rx_queue)
+		spin_unlock(&vp->rx_queue->head_lock);
 
 	/* TX stats are modified with TX head_lock held
-	 * in vector_send.
+	 * in vector_send when doing vector TX.
 	 */
 
-	spin_lock(&vp->tx_queue->head_lock);
+	if (vp->tx_queue)
+		spin_lock(&vp->tx_queue->head_lock);
 	vp->estats.tx_timeout_count = 0;
 	vp->estats.tx_restart_queue = 0;
 	vp->estats.tx_kicks = 0;
@@ -131,7 +135,9 @@ static void vector_reset_stats(struct vector_private *vp)
 	vp->estats.tx_flow_control_xoff = 0;
 	vp->estats.tx_queue_max = 0;
 	vp->estats.tx_queue_running_average = 0;
-	spin_unlock(&vp->tx_queue->head_lock);
+	if (vp->tx_queue)
+		spin_unlock(&vp->tx_queue->head_lock);
+
 }
 
 static int get_mtu(struct arglist *def)
@@ -226,6 +232,11 @@ static int get_transport_options(struct arglist *def)
 		}
 	}
 
+	if (get_depth(def) <= 0) {
+		vec_rx = 0;
+		vec_tx = 0;
+	}
+
 	if (get_bpf_flash(def))
 		result = VECTOR_BPF_FLASH;
 
@@ -406,6 +417,7 @@ static int vector_send(struct vector_queue *qi)
 		/* update queue_depth to current value */
 		while (atomic_read(&qi->queue_depth) > 0) {
 			/* Calculate the start of the vector */
+			smp_rmb();
 			send_len = atomic_read(&qi->queue_depth);
 			send_from = qi->mmsg_vector;
 			send_from += qi->head;
@@ -864,18 +876,17 @@ static int vector_legacy_rx(struct vector_private *vp)
 	}
 
 	if (skb != NULL) {
-		if (pkt_len > vp->header_size) {
-			if (vp->header_size > 0) {
+		if (pkt_len > vp->rx_header_size) {
+			if (vp->rx_header_size > 0) {
 				header_check = vp->verify_header(
 					vp->header_rxbuffer, skb, vp);
 				if (header_check < 0) {
 					dev_kfree_skb_irq(skb);
 					vp->dev->stats.rx_dropped++;
-					vp->estats.rx_encaps_errors++;
+					dev_kfree_skb_irq(skb);
 					return 0;
 				}
 				if (header_check > 0) {
-					vp->estats.rx_csum_offload_good++;
 					skb->ip_summed = CHECKSUM_UNNECESSARY;
 				}
 			}
@@ -980,7 +991,7 @@ static int vector_mmsg_rx(struct vector_private *vp, int budget)
 
 	for (i = 0; i < packet_count; i++) {
 		skb = (*skbuff_vector);
-		if (mmsg_vector->msg_len > vp->header_size) {
+		if (mmsg_vector->msg_len > vp->rx_header_size) {
 			if (vp->header_size > 0) {
 				header_check = vp->verify_header(
 					mmsg_vector->msg_hdr.msg_iov->iov_base,
@@ -1111,7 +1122,8 @@ static int vector_net_close(struct net_device *dev)
 	struct vector_private *vp = netdev_priv(dev);
 
 	netif_stop_queue(dev);
-	timer_delete(&vp->tl);
+	if (vp->options & VECTOR_TX)
+		timer_shutdown_sync(&vp->tl);
 
 	vp->opened = false;
 
@@ -1166,15 +1178,15 @@ static int vector_poll(struct napi_struct *napi, int budget)
 
 	if ((vp->options & VECTOR_TX) != 0)
 		tx_enqueued = (vector_send(vp->tx_queue) > 0);
-	spin_lock(&vp->rx_queue->head_lock);
-	if ((vp->options & VECTOR_RX) > 0)
+	if ((vp->options & VECTOR_RX) > 0) {
+		spin_lock(&vp->rx_queue->head_lock);
 		err = vector_mmsg_rx(vp, budget);
-	else {
+		spin_unlock(&vp->rx_queue->head_lock);
+	} else {
 		err = vector_legacy_rx(vp);
 		if (err > 0)
 			err = 1;
 	}
-	spin_unlock(&vp->rx_queue->head_lock);
 	if (err > 0)
 		work_done += err;
 
@@ -1242,9 +1254,13 @@ static int vector_net_open(struct net_device *dev)
 		if (vp->header_txbuffer == NULL)
 			goto out_close;
 	}
+	if ((vp->options & (VECTOR_TX | VECTOR_RX)) &&
+			(get_depth(vp->parsed) > (NAPI_POLL_WEIGHT << 2)))
+		netif_napi_add_weight(vp->dev, &vp->napi, vector_poll,
+				      get_depth(vp->parsed));
+	else
+		netif_napi_add_weight(vp->dev, &vp->napi, vector_poll, NAPI_POLL_WEIGHT);
 
-	netif_napi_add_weight(vp->dev, &vp->napi, vector_poll,
-			      get_depth(vp->parsed));
 	napi_enable(&vp->napi);
 
 	/* READ IRQ */
@@ -1302,6 +1318,7 @@ static int vector_net_open(struct net_device *dev)
 
 	if ((vp->options & VECTOR_TX) != 0)
 		add_timer(&vp->tl);
+
 	return 0;
 out_close:
 	vector_net_close(dev);
@@ -1469,11 +1486,15 @@ static void vector_get_ethtool_stats(struct net_device *dev,
 	 * to date.
 	 */
 
-	spin_lock(&vp->tx_queue->head_lock);
-	spin_lock(&vp->rx_queue->head_lock);
+	if (vp->tx_queue)
+		spin_lock(&vp->tx_queue->head_lock);
+	if (vp->rx_queue)
+		spin_lock(&vp->rx_queue->head_lock);
 	memcpy(tmp_stats, &vp->estats, sizeof(struct vector_estats));
-	spin_unlock(&vp->rx_queue->head_lock);
-	spin_unlock(&vp->tx_queue->head_lock);
+	if (vp->rx_queue)
+		spin_unlock(&vp->rx_queue->head_lock);
+	if (vp->tx_queue)
+		spin_unlock(&vp->tx_queue->head_lock);
 }
 
 static int vector_get_coalesce(struct net_device *netdev,
diff --git a/arch/um/drivers/vector_kern.h b/arch/um/drivers/vector_kern.h
index 417834793658..5f0ceb80779d 100644
--- a/arch/um/drivers/vector_kern.h
+++ b/arch/um/drivers/vector_kern.h
@@ -116,8 +116,6 @@ struct vector_private {
 	int (*verify_header)(uint8_t *header,
 		struct sk_buff *skb, struct vector_private *vp);
 
-	spinlock_t stats_lock;
-
 	bool rexmit_scheduled;
 	bool opened;
 	bool in_write_poll;
diff --git a/arch/um/drivers/vector_transports.c b/arch/um/drivers/vector_transports.c
index e1fb2a76fdff..786f6badc52d 100644
--- a/arch/um/drivers/vector_transports.c
+++ b/arch/um/drivers/vector_transports.c
@@ -206,9 +206,6 @@ static int raw_verify_header(
 				GSO_ERROR
 		);
 	}
-	if ((vheader->flags & VIRTIO_NET_HDR_F_DATA_VALID) > 0)
-		return 1;
-
 	skb_set_network_header(skb, ETH_HLEN);
 	virtio_net_hdr_to_skb(skb, vheader, virtio_legacy_is_little_endian());
 	return 0;
-- 
2.47.3


