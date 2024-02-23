Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48A65C48BC4
	for <linux-um@archiver.kernel.org>; Fri, 23 Feb 2024 08:29:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5/H5nlAswdup+I0SCxn8A5NdgIxcS2d0JfKC/TbQdkU=; b=ooYF1twk9Bik8bqsn3K9ZAlex+
	yBEMU+1eEMmHpHgkI1uyGXqSM0u3bf1qGlRP7Kv4kWfzaqsiQcCq1k18Cq2tryWtwSGGiYpwQfU8l
	K07ax+xoJ16SdTm7uGdjpwTeIFLCxCdk2nu6xxv2/1edw98jkJtSjybfozOHIL+8S+2pFl87YQoAd
	DGTdICAsDR9xWAnKnUWlbERKqsQB547uPwVh/VMf38O63s1+T4VYOHIjsvBKLLgeVhznqmC4R6Zse
	OFMxe4Lw9E+1xTBNV4K1+rIDHMd8G3XqfL4sICZm0UdddxbaYXXTnFGgDMM6IQWHsf9ySgW9M1dx0
	P5SjHySg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rdQwJ-00000008Tqv-0hyl;
	Fri, 23 Feb 2024 08:29:51 +0000
Received: from out30-119.freemail.mail.aliyun.com ([115.124.30.119])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rdQuF-00000008T0Y-4BaH
	for linux-um@lists.infradead.org;
	Fri, 23 Feb 2024 08:27:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1708676854; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=5/H5nlAswdup+I0SCxn8A5NdgIxcS2d0JfKC/TbQdkU=;
	b=CrGowK/SEOPNwhfXIbMe6UzwOd4R5w3/67IxQyauhUE7MjDZtgMJ7RRf/goRBM0BKURVK9fOuJ2vQsrhx9Y9HLbJRh9CEXyP0CEOVcwAT2aVwljeTqCkVASKw+Iqp2vThnb4BL7OuoOrLTQv3Yph9wpnHX1Gw6xfH7pzGaTDHxU=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=35;SR=0;TI=SMTPD_---0W13nF1h_1708676849;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W13nF1h_1708676849)
          by smtp.aliyun-inc.com;
          Fri, 23 Feb 2024 16:27:30 +0800
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
Subject: [PATCH vhost v2 02/19] virtio_ring: packed: remove double check of the unmap ops
Date: Fri, 23 Feb 2024 16:27:09 +0800
Message-Id: <20240223082726.52915-3-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20240223082726.52915-1-xuanzhuo@linux.alibaba.com>
References: <20240223082726.52915-1-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
X-Git-Hash: 510995f33855
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240223_002746_091881_B8A1C936 
X-CRM114-Status: GOOD (  16.63  )
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

In the functions vring_unmap_extra_packed and vring_unmap_desc_packed,
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
 drivers/virtio/virtio_ring.c | 78 ++++++++++++++++++------------------
 1 file changed, 40 insertions(+), 38 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 21c461e2d851..98d27dfdcf16 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -1220,6 +1220,7 @@ static u16 packed_last_used(u16 last_used_idx)
 	return last_used_idx & ~(-(1 << VRING_PACKED_EVENT_F_WRAP_CTR));
 }
 
+/* caller must check vring_need_unmap_buffer() */
 static void vring_unmap_extra_packed(const struct vring_virtqueue *vq,
 				     const struct vring_desc_extra *extra)
 {
@@ -1227,33 +1228,18 @@ static void vring_unmap_extra_packed(const struct vring_virtqueue *vq,
 
 	flags = extra->flags;
 
-	if (flags & VRING_DESC_F_INDIRECT) {
-		if (!vq->use_dma_api)
-			return;
-
-		dma_unmap_single(vring_dma_dev(vq),
-				 extra->addr, extra->len,
-				 (flags & VRING_DESC_F_WRITE) ?
-				 DMA_FROM_DEVICE : DMA_TO_DEVICE);
-	} else {
-		if (!vring_need_unmap_buffer(vq))
-			return;
-
-		dma_unmap_page(vring_dma_dev(vq),
-			       extra->addr, extra->len,
-			       (flags & VRING_DESC_F_WRITE) ?
-			       DMA_FROM_DEVICE : DMA_TO_DEVICE);
-	}
+	dma_unmap_page(vring_dma_dev(vq),
+		       extra->addr, extra->len,
+		       (flags & VRING_DESC_F_WRITE) ?
+		       DMA_FROM_DEVICE : DMA_TO_DEVICE);
 }
 
+/* caller must check vring_need_unmap_buffer() */
 static void vring_unmap_desc_packed(const struct vring_virtqueue *vq,
 				    const struct vring_packed_desc *desc)
 {
 	u16 flags;
 
-	if (!vring_need_unmap_buffer(vq))
-		return;
-
 	flags = le16_to_cpu(desc->flags);
 
 	dma_unmap_page(vring_dma_dev(vq),
@@ -1329,7 +1315,7 @@ static int virtqueue_add_indirect_packed(struct vring_virtqueue *vq,
 			total_sg * sizeof(struct vring_packed_desc),
 			DMA_TO_DEVICE);
 	if (vring_mapping_error(vq, addr)) {
-		if (vq->premapped)
+		if (!vring_need_unmap_buffer(vq))
 			goto free_desc;
 
 		goto unmap_release;
@@ -1344,10 +1330,11 @@ static int virtqueue_add_indirect_packed(struct vring_virtqueue *vq,
 		vq->packed.desc_extra[id].addr = addr;
 		vq->packed.desc_extra[id].len = total_sg *
 				sizeof(struct vring_packed_desc);
-		vq->packed.desc_extra[id].flags = VRING_DESC_F_INDIRECT |
-						  vq->packed.avail_used_flags;
 	}
 
+	vq->packed.desc_extra[id].flags = VRING_DESC_F_INDIRECT |
+		vq->packed.avail_used_flags;
+
 	/*
 	 * A driver MUST NOT make the first descriptor in the list
 	 * available before all subsequent descriptors comprising
@@ -1388,6 +1375,8 @@ static int virtqueue_add_indirect_packed(struct vring_virtqueue *vq,
 unmap_release:
 	err_idx = i;
 
+	WARN_ON(!vring_need_unmap_buffer(vq));
+
 	for (i = 0; i < err_idx; i++)
 		vring_unmap_desc_packed(vq, &desc[i]);
 
@@ -1481,12 +1470,13 @@ static inline int virtqueue_add_packed(struct virtqueue *_vq,
 			desc[i].len = cpu_to_le32(sg->length);
 			desc[i].id = cpu_to_le16(id);
 
-			if (unlikely(vq->use_dma_api)) {
+			if (vring_need_unmap_buffer(vq)) {
 				vq->packed.desc_extra[curr].addr = addr;
 				vq->packed.desc_extra[curr].len = sg->length;
-				vq->packed.desc_extra[curr].flags =
-					le16_to_cpu(flags);
 			}
+
+			vq->packed.desc_extra[curr].flags = le16_to_cpu(flags);
+
 			prev = curr;
 			curr = vq->packed.desc_extra[curr].next;
 
@@ -1536,6 +1526,8 @@ static inline int virtqueue_add_packed(struct virtqueue *_vq,
 
 	vq->packed.avail_used_flags = avail_used_flags;
 
+	WARN_ON(!vring_need_unmap_buffer(vq));
+
 	for (n = 0; n < total_sg; n++) {
 		if (i == err_idx)
 			break;
@@ -1605,7 +1597,9 @@ static void detach_buf_packed(struct vring_virtqueue *vq,
 	struct vring_desc_state_packed *state = NULL;
 	struct vring_packed_desc *desc;
 	unsigned int i, curr;
+	u16 flags;
 
+	flags = vq->packed.desc_extra[id].flags;
 	state = &vq->packed.desc_state[id];
 
 	/* Clear data ptr. */
@@ -1615,22 +1609,32 @@ static void detach_buf_packed(struct vring_virtqueue *vq,
 	vq->free_head = id;
 	vq->vq.num_free += state->num;
 
-	if (unlikely(vq->use_dma_api)) {
-		curr = id;
-		for (i = 0; i < state->num; i++) {
-			vring_unmap_extra_packed(vq,
-						 &vq->packed.desc_extra[curr]);
-			curr = vq->packed.desc_extra[curr].next;
+	if (!(flags & VRING_DESC_F_INDIRECT)) {
+		if (vring_need_unmap_buffer(vq)) {
+			curr = id;
+			for (i = 0; i < state->num; i++) {
+				vring_unmap_extra_packed(vq,
+							 &vq->packed.desc_extra[curr]);
+				curr = vq->packed.desc_extra[curr].next;
+			}
 		}
-	}
 
-	if (vq->indirect) {
+		if (ctx)
+			*ctx = state->indir_desc;
+	} else {
+		const struct vring_desc_extra *extra;
 		u32 len;
 
+		if (vq->use_dma_api) {
+			extra = &vq->packed.desc_extra[id];
+			dma_unmap_single(vring_dma_dev(vq),
+					 extra->addr, extra->len,
+					 (flags & VRING_DESC_F_WRITE) ?
+					 DMA_FROM_DEVICE : DMA_TO_DEVICE);
+		}
+
 		/* Free the indirect table, if any, now that it's unmapped. */
 		desc = state->indir_desc;
-		if (!desc)
-			return;
 
 		if (vring_need_unmap_buffer(vq)) {
 			len = vq->packed.desc_extra[id].len;
@@ -1640,8 +1644,6 @@ static void detach_buf_packed(struct vring_virtqueue *vq,
 		}
 		kfree(desc);
 		state->indir_desc = NULL;
-	} else if (ctx) {
-		*ctx = state->indir_desc;
 	}
 }
 
-- 
2.32.0.3.g01195cf9f


