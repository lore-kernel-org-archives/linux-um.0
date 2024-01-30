Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81479C48286
	for <linux-um@archiver.kernel.org>; Tue, 30 Jan 2024 03:06:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=z3UTRsbRsFcB2sqFN3XBDD7wrtKUw8K4tiUA1HwO3kw=; b=JJPg0cX0rNpt0/kviFcyw3jMxD
	P81NiwRC5CLNyJmnT3vMWcn9X159AxdZz5yLe9u1gq01Ralt+fCrbsc0dWWSUGrXtLl6Uu70lSzeY
	0Dm76++vrlLfndctkfzRpPBxj5VdBjEyrDA/bMNEMsEG+iJLJ1JQMDDVWmGyRhhWWOD7draeqr7/b
	xRe6C7AKAGJbfyfoNyKv6umDt9+6DuTzzQzqYwnHs6elbDe6MQccPOXR2mkx+xJMffGPLoV1SrF52
	aymsO3O4Jcjad9EWluwNa03716E+DmB9PzaONj7OBHpDcqY251N8lQM69pCfBoiAvAy9DJ7307ahC
	sfsrtLYw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rUeSB-0000000F3qw-36pb;
	Tue, 30 Jan 2024 03:06:27 +0000
Received: from out30-111.freemail.mail.aliyun.com ([115.124.30.111])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rUeS2-0000000F3jK-3zA1
	for linux-um@lists.infradead.org;
	Tue, 30 Jan 2024 03:06:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1706583976; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=z3UTRsbRsFcB2sqFN3XBDD7wrtKUw8K4tiUA1HwO3kw=;
	b=Hj3koiwO8iHFD0m5xzlwE8GYQFDHQ7bEldOE+q+irZoGNWNogbFo2TuLzeUjnw3RP4s/DfpX7pTWViwkGGjj1IFAqty2RB1GQ3CsMxnb4+Tsles431kGW2FRau1fysa7GilH6fLkWLpeYIRj3lAUg/kMgrU5jziQQybIwPpalRU=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=37;SR=0;TI=SMTPD_---0W.eeCAv_1706583973;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W.eeCAv_1706583973)
          by smtp.aliyun-inc.com;
          Tue, 30 Jan 2024 11:06:14 +0800
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
Subject: [PATCH 05/14] virtio_ring: split: structure the indirect desc table
Date: Tue, 30 Jan 2024 11:05:55 +0800
Message-Id: <20240130030604.108463-6-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20240130030604.108463-1-xuanzhuo@linux.alibaba.com>
References: <20240130030604.108463-1-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
X-Git-Hash: ce068f9b825d
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240129_190619_240170_9F3827A8 
X-CRM114-Status: GOOD (  16.33  )
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

This commit structure the indirect desc table.
Then we can get the desc num directly when doing unmap.

And save the dma info to the struct, then the indirect
will not use the dma fields of the desc_extra. The subsequent
commits will make the dma fields are optional. But for
the indirect case, we must record the dma info.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/virtio/virtio_ring.c | 86 ++++++++++++++++++++++--------------
 1 file changed, 52 insertions(+), 34 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 2b41fdbce975..831667a57429 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -67,9 +67,16 @@
 #define LAST_ADD_TIME_INVALID(vq)
 #endif
 
+struct vring_split_desc_indir {
+	dma_addr_t addr;		/* Descriptor Array DMA addr. */
+	u32 len;			/* Descriptor Array length. */
+	u32 num;
+	struct vring_desc desc[];
+};
+
 struct vring_desc_state_split {
 	void *data;			/* Data for callback. */
-	struct vring_desc *indir_desc;	/* Indirect descriptor, if any. */
+	struct vring_split_desc_indir *indir_desc;	/* Indirect descriptor, if any. */
 };
 
 struct vring_packed_desc_indir {
@@ -478,12 +485,16 @@ static unsigned int vring_unmap_one_split(const struct vring_virtqueue *vq,
 	return extra[i].next;
 }
 
-static struct vring_desc *alloc_indirect_split(struct virtqueue *_vq,
-					       unsigned int total_sg,
-					       gfp_t gfp)
+static struct vring_split_desc_indir *alloc_indirect_split(struct virtqueue *_vq,
+							   unsigned int total_sg,
+							   gfp_t gfp)
 {
+	struct vring_split_desc_indir *in_desc;
 	struct vring_desc *desc;
 	unsigned int i;
+	u32 size;
+
+	size = struct_size(in_desc, desc, total_sg);
 
 	/*
 	 * We require lowmem mappings for the descriptors because
@@ -492,13 +503,16 @@ static struct vring_desc *alloc_indirect_split(struct virtqueue *_vq,
 	 */
 	gfp &= ~__GFP_HIGHMEM;
 
-	desc = kmalloc_array(total_sg, sizeof(struct vring_desc), gfp);
-	if (!desc)
+	in_desc = kmalloc(size, gfp);
+	if (!in_desc)
 		return NULL;
 
+	desc = in_desc->desc;
+
 	for (i = 0; i < total_sg; i++)
 		desc[i].next = cpu_to_virtio16(_vq->vdev, i + 1);
-	return desc;
+
+	return in_desc;
 }
 
 static inline unsigned int virtqueue_add_desc_split(struct virtqueue *vq,
@@ -540,6 +554,7 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
 				      gfp_t gfp)
 {
 	struct vring_virtqueue *vq = to_vvq(_vq);
+	struct vring_split_desc_indir *in_desc;
 	struct scatterlist *sg;
 	struct vring_desc *desc;
 	unsigned int i, n, avail, descs_used, prev, err_idx;
@@ -562,9 +577,13 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
 
 	head = vq->free_head;
 
-	if (virtqueue_use_indirect(vq, total_sg))
-		desc = alloc_indirect_split(_vq, total_sg, gfp);
-	else {
+	if (virtqueue_use_indirect(vq, total_sg)) {
+		in_desc = alloc_indirect_split(_vq, total_sg, gfp);
+		if (!in_desc)
+			desc = NULL;
+		else
+			desc = in_desc->desc;
+	} else {
 		desc = NULL;
 		WARN_ON_ONCE(total_sg > vq->split.vring.num && !vq->indirect);
 	}
@@ -637,10 +656,10 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
 			~VRING_DESC_F_NEXT;
 
 	if (indirect) {
+		u32 size = total_sg * sizeof(struct vring_desc);
+
 		/* Now that the indirect table is filled in, map it. */
-		dma_addr_t addr = vring_map_single(
-			vq, desc, total_sg * sizeof(struct vring_desc),
-			DMA_TO_DEVICE);
+		dma_addr_t addr = vring_map_single(vq, desc, size, DMA_TO_DEVICE);
 		if (vring_mapping_error(vq, addr)) {
 			if (!vring_need_unmap_buffer(vq))
 				goto free_indirect;
@@ -648,11 +667,17 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
 			goto unmap_release;
 		}
 
-		virtqueue_add_desc_split(_vq, vq->split.vring.desc,
-					 head, addr,
-					 total_sg * sizeof(struct vring_desc),
-					 VRING_DESC_F_INDIRECT,
-					 false);
+		desc = &vq->split.vring.desc[head];
+
+		desc->flags = cpu_to_virtio16(_vq->vdev, VRING_DESC_F_INDIRECT);
+		desc->addr = cpu_to_virtio64(_vq->vdev, addr);
+		desc->len = cpu_to_virtio32(_vq->vdev, size);
+
+		vq->split.desc_extra[head].flags = VRING_DESC_F_INDIRECT;
+
+		in_desc->addr = addr;
+		in_desc->len = size;
+		in_desc->num = total_sg;
 	}
 
 	/* We're using some buffers from the free list. */
@@ -667,7 +692,7 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
 	/* Store token and indirect buffer state. */
 	vq->split.desc_state[head].data = data;
 	if (indirect)
-		vq->split.desc_state[head].indir_desc = desc;
+		vq->split.desc_state[head].indir_desc = in_desc;
 	else
 		vq->split.desc_state[head].indir_desc = ctx;
 
@@ -717,7 +742,7 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
 
 free_indirect:
 	if (indirect)
-		kfree(desc);
+		kfree(in_desc);
 
 	END_USE(vq);
 	return -ENOMEM;
@@ -782,34 +807,27 @@ static void detach_buf_split(struct vring_virtqueue *vq, unsigned int head,
 		if (ctx)
 			*ctx = vq->split.desc_state[head].indir_desc;
 	} else {
-		struct vring_desc *indir_desc =
-				vq->split.desc_state[head].indir_desc;
-		u32 len;
+		struct vring_split_desc_indir *in_desc;
 
-		if (vq->use_dma_api) {
-			struct vring_desc_extra *extra = vq->split.desc_extra;
+		in_desc = vq->split.desc_state[head].indir_desc;
 
+		if (vq->use_dma_api) {
 			dma_unmap_single(vring_dma_dev(vq),
-					 extra[i].addr,
-					 extra[i].len,
+					 in_desc->addr, in_desc->len,
 					 (flags & VRING_DESC_F_WRITE) ?
 					 DMA_FROM_DEVICE : DMA_TO_DEVICE);
 		}
 
-		len = vq->split.desc_extra[head].len;
-
 		BUG_ON(!(vq->split.desc_extra[head].flags &
 				VRING_DESC_F_INDIRECT));
-		BUG_ON(len == 0 || len % sizeof(struct vring_desc));
 
 		if (vring_need_unmap_buffer(vq)) {
-			for (j = 0; j < len / sizeof(struct vring_desc); j++)
-				vring_unmap_one_split_indirect(vq, &indir_desc[j]);
+			for (j = 0; j < in_desc->num; j++)
+				vring_unmap_one_split_indirect(vq, &in_desc->desc[j]);
 		}
 
-		kfree(indir_desc);
+		kfree(in_desc);
 		vq->split.desc_state[head].indir_desc = NULL;
-
 	}
 
 	vq->split.desc_extra[i].next = vq->free_head;
-- 
2.32.0.3.g01195cf9f


