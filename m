Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3692BC48285
	for <linux-um@archiver.kernel.org>; Tue, 30 Jan 2024 11:42:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zz6HlhZ2m5QpUdXygmyUdjzYx5sKxdD3g1gFCx/3l2I=; b=Iv+gUK4Mmimn1saXT0m+uKsCkj
	X/upEicg4tn1LLISagW9cYXU5s3vVyK3M6lR1l/mhD6ZpVm3Ac8WKhnz3o10kYL01861C9eEPMt5Y
	3M0NCJcECD31Ys+/ThZ/cYzyaifKgMuQeXoxxUPb6asgUxs1I/OFEgIO9VbrvYEIVPWD+LwrvdvNT
	pHRwDXAz1ZgYg80pAFN/Cq1DLZKxzE5kK9Um5jLAosE5XDeTgbh4slevhv7gHp/VDCGPpYNF85oJJ
	RwcSMme88IflY9hCBgxPSO7otZFogU27CUBD9Hr9OjTyruJKMyV1CPiOAPO5rX3Q8WIraZ7s8yJ6A
	9+aWw/AQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rUmVy-0000000GWJ6-38sc;
	Tue, 30 Jan 2024 11:42:54 +0000
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rUmVu-0000000GWDP-1eot
	for linux-um@lists.infradead.org;
	Tue, 30 Jan 2024 11:42:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1706614968; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=zz6HlhZ2m5QpUdXygmyUdjzYx5sKxdD3g1gFCx/3l2I=;
	b=cjnh6DpbpET+bmMQsAh3eKNYNVFJ/LhFjlB4Fl9xkI8giEJLeR1krimEtZLDlueKZOO5MCsATUEpJjac3yZhcUmbvgYpLxXid9i8ke8MFL0GfbO7kIYHBSUzQ8/ViAlmhb4OnvbA225dTlVafGNj5NgS/+VBFeelW2qs/Tk5Amg=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=37;SR=0;TI=SMTPD_---0W.g5gDu_1706614964;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W.g5gDu_1706614964)
          by smtp.aliyun-inc.com;
          Tue, 30 Jan 2024 19:42:45 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: virtualization@lists.linux.dev
Cc: Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Hans de Goede <hdegoede@redhat.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Vadim Pasternak <vadimp@nvidia.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	Cornelia Huck <cohuck@redhat.com>,
	Halil Pasic <pasic@linux.ibm.com>,
	Eric Farman <farman@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Benjamin Berg <benjamin.berg@intel.com>,
	Yang Li <yang.lee@linux.alibaba.com>,
	linux-um@lists.infradead.org,
	netdev@vger.kernel.org,
	platform-driver-x86@vger.kernel.org,
	linux-remoteproc@vger.kernel.org,
	linux-s390@vger.kernel.org,
	kvm@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH vhost 12/17] virtio_net: set premapped mode by find_vqs()
Date: Tue, 30 Jan 2024 19:42:19 +0800
Message-Id: <20240130114224.86536-13-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20240130114224.86536-1-xuanzhuo@linux.alibaba.com>
References: <20240130114224.86536-1-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
X-Git-Hash: 239d1d475be4
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240130_034250_840559_9CDEB5B0 
X-CRM114-Status: GOOD (  16.18  )
X-BeenThere: linux-um@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

Now, the virtio core can set the premapped mode by find_vqs().
If the premapped can be enabled, the dma array will not be
allocated. So virtio-net use the api of find_vqs to enable the
premapped.

Judge the premapped mode by the vq->premapped instead of saving
local variable.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/net/virtio_net.c      | 57 +++++++++++++++++------------------
 include/linux/virtio_config.h | 16 ++--------
 2 files changed, 29 insertions(+), 44 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 51b1868d2f22..12961fc0879e 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -196,9 +196,6 @@ struct receive_queue {
 
 	/* Record the last dma info to free after new pages is allocated. */
 	struct virtnet_rq_dma *last_dma;
-
-	/* Do dma by self */
-	bool do_dma;
 };
 
 /* This structure can contain rss message with maximum settings for indirection table and keysize
@@ -638,7 +635,7 @@ static void *virtnet_rq_get_buf(struct receive_queue *rq, u32 *len, void **ctx)
 	void *buf;
 
 	buf = virtqueue_get_buf_ctx(rq->vq, len, ctx);
-	if (buf && rq->do_dma)
+	if (buf && rq->vq->premapped)
 		virtnet_rq_unmap(rq, buf, *len);
 
 	return buf;
@@ -651,7 +648,7 @@ static void virtnet_rq_init_one_sg(struct receive_queue *rq, void *buf, u32 len)
 	u32 offset;
 	void *head;
 
-	if (!rq->do_dma) {
+	if (!rq->vq->premapped) {
 		sg_init_one(rq->sg, buf, len);
 		return;
 	}
@@ -681,7 +678,7 @@ static void *virtnet_rq_alloc(struct receive_queue *rq, u32 size, gfp_t gfp)
 
 	head = page_address(alloc_frag->page);
 
-	if (rq->do_dma) {
+	if (rq->vq->premapped) {
 		dma = head;
 
 		/* new pages */
@@ -727,22 +724,6 @@ static void *virtnet_rq_alloc(struct receive_queue *rq, u32 size, gfp_t gfp)
 	return buf;
 }
 
-static void virtnet_rq_set_premapped(struct virtnet_info *vi)
-{
-	int i;
-
-	/* disable for big mode */
-	if (!vi->mergeable_rx_bufs && vi->big_packets)
-		return;
-
-	for (i = 0; i < vi->max_queue_pairs; i++) {
-		if (virtqueue_set_dma_premapped(vi->rq[i].vq))
-			continue;
-
-		vi->rq[i].do_dma = true;
-	}
-}
-
 static void virtnet_rq_unmap_free_buf(struct virtqueue *vq, void *buf)
 {
 	struct virtnet_info *vi = vq->vdev->priv;
@@ -751,7 +732,7 @@ static void virtnet_rq_unmap_free_buf(struct virtqueue *vq, void *buf)
 
 	rq = &vi->rq[i];
 
-	if (rq->do_dma)
+	if (rq->vq->premapped)
 		virtnet_rq_unmap(rq, buf, 0);
 
 	virtnet_rq_free_buf(vi, rq, buf);
@@ -1846,7 +1827,7 @@ static int add_recvbuf_small(struct virtnet_info *vi, struct receive_queue *rq,
 
 	err = virtqueue_add_inbuf_ctx(rq->vq, rq->sg, 1, buf, ctx, gfp);
 	if (err < 0) {
-		if (rq->do_dma)
+		if (rq->vq->premapped)
 			virtnet_rq_unmap(rq, buf, 0);
 		put_page(virt_to_head_page(buf));
 	}
@@ -1961,7 +1942,7 @@ static int add_recvbuf_mergeable(struct virtnet_info *vi,
 	ctx = mergeable_len_to_ctx(len + room, headroom);
 	err = virtqueue_add_inbuf_ctx(rq->vq, rq->sg, 1, buf, ctx, gfp);
 	if (err < 0) {
-		if (rq->do_dma)
+		if (rq->vq->premapped)
 			virtnet_rq_unmap(rq, buf, 0);
 		put_page(virt_to_head_page(buf));
 	}
@@ -4030,7 +4011,7 @@ static void free_receive_page_frags(struct virtnet_info *vi)
 	int i;
 	for (i = 0; i < vi->max_queue_pairs; i++)
 		if (vi->rq[i].alloc_frag.page) {
-			if (vi->rq[i].do_dma && vi->rq[i].last_dma)
+			if (vi->rq[i].vq->premapped && vi->rq[i].last_dma)
 				virtnet_rq_unmap(&vi->rq[i], vi->rq[i].last_dma, 0);
 			put_page(vi->rq[i].alloc_frag.page);
 		}
@@ -4094,11 +4075,13 @@ static unsigned int mergeable_min_buf_len(struct virtnet_info *vi, struct virtqu
 
 static int virtnet_find_vqs(struct virtnet_info *vi)
 {
+	struct virtio_vq_config cfg = {};
 	vq_callback_t **callbacks;
 	struct virtqueue **vqs;
 	int ret = -ENOMEM;
 	int i, total_vqs;
 	const char **names;
+	bool *premapped;
 	bool *ctx;
 
 	/* We expect 1 RX virtqueue followed by 1 TX virtqueue, followed by
@@ -4122,8 +4105,13 @@ static int virtnet_find_vqs(struct virtnet_info *vi)
 		ctx = kcalloc(total_vqs, sizeof(*ctx), GFP_KERNEL);
 		if (!ctx)
 			goto err_ctx;
+
+		premapped = kcalloc(total_vqs, sizeof(*ctx), GFP_KERNEL);
+		if (!ctx)
+			goto err_premapped;
 	} else {
 		ctx = NULL;
+		premapped = NULL;
 	}
 
 	/* Parameters for control virtqueue, if any */
@@ -4142,10 +4130,19 @@ static int virtnet_find_vqs(struct virtnet_info *vi)
 		names[txq2vq(i)] = vi->sq[i].name;
 		if (ctx)
 			ctx[rxq2vq(i)] = true;
+
+		if (premapped)
+			premapped[rxq2vq(i)] = true;
 	}
 
-	ret = virtio_find_vqs_ctx(vi->vdev, total_vqs, vqs, callbacks,
-				  names, ctx, NULL);
+	cfg.nvqs      = total_vqs;
+	cfg.vqs       = vqs;
+	cfg.callbacks = callbacks;
+	cfg.names     = names;
+	cfg.ctx       = ctx;
+	cfg.premapped = premapped;
+
+	ret = virtio_find_vqs_cfg(vi->vdev, &cfg);
 	if (ret)
 		goto err_find;
 
@@ -4165,6 +4162,8 @@ static int virtnet_find_vqs(struct virtnet_info *vi)
 
 
 err_find:
+	kfree(premapped);
+err_premapped:
 	kfree(ctx);
 err_ctx:
 	kfree(names);
@@ -4234,8 +4233,6 @@ static int init_vqs(struct virtnet_info *vi)
 	if (ret)
 		goto err_free;
 
-	virtnet_rq_set_premapped(vi);
-
 	cpus_read_lock();
 	virtnet_set_affinity(vi);
 	cpus_read_unlock();
diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
index f462c3f1691c..e8c4d2d7c827 100644
--- a/include/linux/virtio_config.h
+++ b/include/linux/virtio_config.h
@@ -256,21 +256,9 @@ int virtio_find_vqs(struct virtio_device *vdev, unsigned nvqs,
 }
 
 static inline
-int virtio_find_vqs_ctx(struct virtio_device *vdev, unsigned nvqs,
-			struct virtqueue *vqs[], vq_callback_t *callbacks[],
-			const char * const names[], const bool *ctx,
-			struct irq_affinity *desc)
+int virtio_find_vqs_cfg(struct virtio_device *vdev, struct virtio_vq_config *cfg)
 {
-	struct virtio_vq_config cfg = {};
-
-	cfg.nvqs = nvqs;
-	cfg.vqs = vqs;
-	cfg.callbacks = callbacks;
-	cfg.names = names;
-	cfg.ctx = ctx;
-	cfg.desc = desc;
-
-	return vdev->config->find_vqs(vdev, &cfg);
+	return vdev->config->find_vqs(vdev, cfg);
 }
 
 /**
-- 
2.32.0.3.g01195cf9f


