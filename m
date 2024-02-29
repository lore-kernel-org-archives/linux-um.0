Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91CB2C54E55
	for <linux-um@archiver.kernel.org>; Thu, 29 Feb 2024 07:21:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6IMo6cIkJbw27Q1oQFwPBSLp5dDwzhNSd1jF51DsYTA=; b=Z9Klgsfaa1dS1tvfa+Js8waE9t
	U4tP8YG3kdanCeX56nsmKgji/M83qCKm20HPW6QCcouy3W2ANgxrrbtYEjywawi7gQy9Y7lFaAyRC
	zSOOoS+64C4miP7Qe/rS4smVa91F9MGsXgSw5GHMZ/0v4o8wbPL9kWMs3uXrtJY+e6v4Y0fessdVC
	0OdmL6Ct+1E0YA7fC6ydYnCk9Umby/iFbxnBm4GwsJTg3U4KMqziFPlzSF2EWyJxxVQohLiIaf8O4
	JAXQ1Fgu0VY854AKkRExycho/ALAqzbk5ALODstjBzBREWAZR5E9DcnEjTA76YxJwJLfM2vdJLAT7
	PXVdx1uA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rfaj0-0000000CRxw-0KXa;
	Thu, 29 Feb 2024 07:21:02 +0000
Received: from out30-118.freemail.mail.aliyun.com ([115.124.30.118])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rfaiv-0000000CRtf-1mJj
	for linux-um@lists.infradead.org;
	Thu, 29 Feb 2024 07:21:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1709191254; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=6IMo6cIkJbw27Q1oQFwPBSLp5dDwzhNSd1jF51DsYTA=;
	b=EGYeDeKQ7oIbsBb/RKPZWvFTs31odbZIWo/bbw9GbI72EkvDTbLjAvFT4lZON+9ewVrNQcB9atugpeCuv5qHr0byZvKIhzosRkyKC18IQskXMzYkkmU8OUa4lm3rI2wiUeSvKEKcEFUY9pQalOr0wGJ2oE+9jp2i7zXEEK+tXkE=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R991e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=35;SR=0;TI=SMTPD_---0W1SDP65_1709191251;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W1SDP65_1709191251)
          by smtp.aliyun-inc.com;
          Thu, 29 Feb 2024 15:20:52 +0800
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
	linux-um@lists.infradead.org,
	netdev@vger.kernel.org,
	platform-driver-x86@vger.kernel.org,
	linux-remoteproc@vger.kernel.org,
	linux-s390@vger.kernel.org,
	kvm@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH vhost v3 04/19] virtio_ring: split: remove double check of the unmap ops
Date: Thu, 29 Feb 2024 15:20:29 +0800
Message-Id: <20240229072044.77388-5-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20240229072044.77388-1-xuanzhuo@linux.alibaba.com>
References: <20240229072044.77388-1-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
X-Git-Hash: e3a3e51d6b70
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240228_232057_671234_10E9C15F 
X-CRM114-Status: GOOD (  14.77  )
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

In the functions vring_unmap_one_split and
vring_unmap_one_split_indirect,
multiple checks are made whether unmap is performed and whether it is
INDIRECT.

These two functions are usually called in a loop, and we should put the
check outside the loop.

And we unmap the descs with VRING_DESC_F_INDIRECT on the same path with
other descs, that make the thing more complex. If we distinguish the
descs with VRING_DESC_F_INDIRECT before unmap, thing will be clearer.

1. only one desc of the desc table is used, we do not need the loop
2. the called unmap api is difference from the other desc
3. the vq->premapped is not needed to check
4. the vq->indirect is not needed to check
5. the state->indir_desc must not be null

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/virtio/virtio_ring.c | 79 +++++++++++++++++-------------------
 1 file changed, 38 insertions(+), 41 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 2d4d1417a1d6..194bd877ab5a 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -452,9 +452,6 @@ static void vring_unmap_one_split_indirect(const struct vring_virtqueue *vq,
 {
 	u16 flags;
 
-	if (!vring_need_unmap_buffer(vq))
-		return;
-
 	flags = virtio16_to_cpu(vq->vq.vdev, desc->flags);
 
 	dma_unmap_page(vring_dma_dev(vq),
@@ -472,27 +469,12 @@ static unsigned int vring_unmap_one_split(const struct vring_virtqueue *vq,
 
 	flags = extra[i].flags;
 
-	if (flags & VRING_DESC_F_INDIRECT) {
-		if (!vq->use_dma_api)
-			goto out;
-
-		dma_unmap_single(vring_dma_dev(vq),
-				 extra[i].addr,
-				 extra[i].len,
-				 (flags & VRING_DESC_F_WRITE) ?
-				 DMA_FROM_DEVICE : DMA_TO_DEVICE);
-	} else {
-		if (!vring_need_unmap_buffer(vq))
-			goto out;
-
-		dma_unmap_page(vring_dma_dev(vq),
-			       extra[i].addr,
-			       extra[i].len,
-			       (flags & VRING_DESC_F_WRITE) ?
-			       DMA_FROM_DEVICE : DMA_TO_DEVICE);
-	}
+	dma_unmap_page(vring_dma_dev(vq),
+		       extra[i].addr,
+		       extra[i].len,
+		       (flags & VRING_DESC_F_WRITE) ?
+		       DMA_FROM_DEVICE : DMA_TO_DEVICE);
 
-out:
 	return extra[i].next;
 }
 
@@ -660,7 +642,7 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
 			vq, desc, total_sg * sizeof(struct vring_desc),
 			DMA_TO_DEVICE);
 		if (vring_mapping_error(vq, addr)) {
-			if (vq->premapped)
+			if (!vring_need_unmap_buffer(vq))
 				goto free_indirect;
 
 			goto unmap_release;
@@ -713,6 +695,9 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
 	return 0;
 
 unmap_release:
+
+	WARN_ON(!vring_need_unmap_buffer(vq));
+
 	err_idx = i;
 
 	if (indirect)
@@ -774,34 +759,42 @@ static void detach_buf_split(struct vring_virtqueue *vq, unsigned int head,
 {
 	unsigned int i, j;
 	__virtio16 nextflag = cpu_to_virtio16(vq->vq.vdev, VRING_DESC_F_NEXT);
+	u16 flags;
 
 	/* Clear data ptr. */
 	vq->split.desc_state[head].data = NULL;
+	flags = vq->split.desc_extra[head].flags;
 
 	/* Put back on free list: unmap first-level descriptors and find end */
 	i = head;
 
-	while (vq->split.vring.desc[i].flags & nextflag) {
-		vring_unmap_one_split(vq, i);
-		i = vq->split.desc_extra[i].next;
-		vq->vq.num_free++;
-	}
-
-	vring_unmap_one_split(vq, i);
-	vq->split.desc_extra[i].next = vq->free_head;
-	vq->free_head = head;
+	if (!(flags & VRING_DESC_F_INDIRECT)) {
+		while (vq->split.vring.desc[i].flags & nextflag) {
+			if (vring_need_unmap_buffer(vq))
+				vring_unmap_one_split(vq, i);
+			i = vq->split.desc_extra[i].next;
+			vq->vq.num_free++;
+		}
 
-	/* Plus final descriptor */
-	vq->vq.num_free++;
+		if (vring_need_unmap_buffer(vq))
+			vring_unmap_one_split(vq, i);
 
-	if (vq->indirect) {
+		if (ctx)
+			*ctx = vq->split.desc_state[head].indir_desc;
+	} else {
 		struct vring_desc *indir_desc =
 				vq->split.desc_state[head].indir_desc;
 		u32 len;
 
-		/* Free the indirect table, if any, now that it's unmapped. */
-		if (!indir_desc)
-			return;
+		if (vq->use_dma_api) {
+			struct vring_desc_extra *extra = vq->split.desc_extra;
+
+			dma_unmap_single(vring_dma_dev(vq),
+					 extra[i].addr,
+					 extra[i].len,
+					 (flags & VRING_DESC_F_WRITE) ?
+					 DMA_FROM_DEVICE : DMA_TO_DEVICE);
+		}
 
 		len = vq->split.desc_extra[head].len;
 
@@ -816,9 +809,13 @@ static void detach_buf_split(struct vring_virtqueue *vq, unsigned int head,
 
 		kfree(indir_desc);
 		vq->split.desc_state[head].indir_desc = NULL;
-	} else if (ctx) {
-		*ctx = vq->split.desc_state[head].indir_desc;
 	}
+
+	vq->split.desc_extra[i].next = vq->free_head;
+	vq->free_head = head;
+
+	/* Plus final descriptor */
+	vq->vq.num_free++;
 }
 
 static bool more_used_split(const struct vring_virtqueue *vq)
-- 
2.32.0.3.g01195cf9f


