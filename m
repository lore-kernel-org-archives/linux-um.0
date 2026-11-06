Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2BF4606A326
	for <linux-um@archiver.kernel.org>; Fri,  6 Nov 2026 18:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=fq21Xaet
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Unsubscribe-Post:List-Owner;
	bh=mKL1MGb7HEavu99oAkkhNbhkK3hGCGcHWTdHqZ1B1gw=; b=fq21XaetS9DWeYeCN55YokX/1D
	oYtllQNaavSCN9fouM/HNij3B/1HLfCBUZJNl6Px6i+1Fyp2BTqx6Ucsp3P+OAUyNRERTByMrMG6+
	2PPKi45XmP+sbUkL2BS+ciaxLxDlNU4GsUqzeoX9X8tpJaT4nbFdwSE6/YDhRISksYcW5iw/6vP+3
	YskKl7K/MYbEU+CPMIDJ6Hc/5OsnfNdKTAX4WYk+sUUdXsySWnJE4p6sC1Hq61C2Pdlbrz6hRvYBR
	GMZIaSh1w0U+wgTv0/J/RmH/TNrOZwi/7flW3cPzHT3XndCEWkrgPNNe5Smb1RC+X1mBTg/3qRZsz
	t7GZYc2A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xPOYh-0000000DOCy-3111;
	Fri, 06 Nov 2026 18:21:03 +0000
Received: from ns3.kot-begemot.co.uk ([31.70.137.218])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xPOYf-0000000DOCL-1KL8
	for linux-um@lists.infradead.org;
	Fri, 06 Nov 2026 18:21:02 +0000
Received: from [192.168.19.6] (helo=jain.kot-begemot.co.uk)
	by ns3.kot-begemot.co.uk with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <anton.ivanov@cambridgegreys.com>)
	id 1xPOYZ-00000001Bh6-2c4p;
	Fri, 06 Nov 2026 18:20:55 +0000
Received: from madding.kot-begemot.co.uk ([192.168.3.98])
	by jain.kot-begemot.co.uk with esmtp (Exim 4.98.2)
	(envelope-from <anton.ivanov@cambridgegreys.com>)
	id 1xPORN-00000001Fyk-3y03;
	Fri, 06 Nov 2026 18:20:52 +0000
From: anton.ivanov@cambridgegreys.com
To: linux-um@lists.infradead.org
Cc: richard@nod.at,
	johannes@sipsolutions.net,
	mst@redhat.com,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>
Subject: [PATCH v2] um: vector: Possible underflow and races fixes
Date: Fri,  6 Nov 2026 18:19:14 +0000
Message-ID: <20261106182048.4019719-1-anton.ivanov@cambridgegreys.com>
X-Mailer: git-send-email 2.47.3
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -1.0
X-Spam-Score: -1.0
X-Clacks-Overhead: GNU Terry Pratchett
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261106_102101_380992_37BDE77B 
X-CRM114-Status: GOOD (  18.10  )
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
X-Spam-Status: No, score=-16.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

2. virtio_net_header processing was not up to date with all the GSO
additions and changes and was skipping necessary processing.

3. Missing barrier in vector_send().

4. Incorrect timer destruction in net_close()

Signed-off-by: Anton Ivanov <anton.ivanov@cambridgegreys.com>
---
 arch/um/drivers/vector_kern.c       | 47 ++++++++++++++++++-----------
 arch/um/drivers/vector_kern.h       |  2 --
 arch/um/drivers/vector_transports.c |  3 --
 3 files changed, 29 insertions(+), 23 deletions(-)

diff --git a/arch/um/drivers/vector_kern.c b/arch/um/drivers/vector_kern.c
index e902e78c5ff6..8008278ccee7 100644
--- a/arch/um/drivers/vector_kern.c
+++ b/arch/um/drivers/vector_kern.c
@@ -108,7 +108,7 @@ static void vector_reset_stats(struct vector_private *vp)
 	/* We reuse the existing queue locks for stats */
 
 	/* RX stats are modified with RX head_lock held
-	 * in vector_poll.
+	 * in vector_poll when using vector RX.
 	 */
 
 	if (vp->rx_queue)
@@ -119,18 +119,15 @@ static void vector_reset_stats(struct vector_private *vp)
 	vp->estats.rx_encaps_errors = 0;
 	vp->estats.sg_ok = 0;
 	vp->estats.sg_linearized = 0;
-
 	if (vp->rx_queue)
 		spin_unlock(&vp->rx_queue->head_lock);
 
-
 	/* TX stats are modified with TX head_lock held
-	 * in vector_send.
+	 * in vector_send when doing vector TX.
 	 */
 
 	if (vp->tx_queue)
 		spin_lock(&vp->tx_queue->head_lock);
-
 	vp->estats.tx_timeout_count = 0;
 	vp->estats.tx_restart_queue = 0;
 	vp->estats.tx_kicks = 0;
@@ -138,7 +135,6 @@ static void vector_reset_stats(struct vector_private *vp)
 	vp->estats.tx_flow_control_xoff = 0;
 	vp->estats.tx_queue_max = 0;
 	vp->estats.tx_queue_running_average = 0;
-
 	if (vp->tx_queue)
 		spin_unlock(&vp->tx_queue->head_lock);
 
@@ -236,6 +232,11 @@ static int get_transport_options(struct arglist *def)
 		}
 	}
 
+	if (get_depth(def) <= 0) {
+		vec_rx = 0;
+		vec_tx = 0;
+	}
+
 	if (get_bpf_flash(def))
 		result = VECTOR_BPF_FLASH;
 
@@ -416,6 +417,7 @@ static int vector_send(struct vector_queue *qi)
 		/* update queue_depth to current value */
 		while (atomic_read(&qi->queue_depth) > 0) {
 			/* Calculate the start of the vector */
+			smp_rmb();
 			send_len = atomic_read(&qi->queue_depth);
 			send_from = qi->mmsg_vector;
 			send_from += qi->head;
@@ -872,18 +874,17 @@ static int vector_legacy_rx(struct vector_private *vp)
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
@@ -988,7 +989,7 @@ static int vector_mmsg_rx(struct vector_private *vp, int budget)
 
 	for (i = 0; i < packet_count; i++) {
 		skb = (*skbuff_vector);
-		if (mmsg_vector->msg_len > vp->header_size) {
+		if (mmsg_vector->msg_len > vp->rx_header_size) {
 			if (vp->header_size > 0) {
 				header_check = vp->verify_header(
 					mmsg_vector->msg_hdr.msg_iov->iov_base,
@@ -1119,7 +1120,8 @@ static int vector_net_close(struct net_device *dev)
 	struct vector_private *vp = netdev_priv(dev);
 
 	netif_stop_queue(dev);
-	timer_delete(&vp->tl);
+	if (vp->options & VECTOR_TX)
+		timer_shutdown_sync(&vp->tl);
 
 	vp->opened = false;
 
@@ -1250,9 +1252,13 @@ static int vector_net_open(struct net_device *dev)
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
@@ -1310,6 +1316,7 @@ static int vector_net_open(struct net_device *dev)
 
 	if ((vp->options & VECTOR_TX) != 0)
 		add_timer(&vp->tl);
+
 	return 0;
 out_close:
 	vector_net_close(dev);
@@ -1477,11 +1484,15 @@ static void vector_get_ethtool_stats(struct net_device *dev,
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


