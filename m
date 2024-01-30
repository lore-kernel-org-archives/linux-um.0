Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7854C48286
	for <linux-um@archiver.kernel.org>; Tue, 30 Jan 2024 11:42:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IhSe/hckx6ypBcdE4k41LnQFuwciEnm8GoFA8OoZo2s=; b=gDcqouhrw5jbYAN2Eij+NcIcPm
	8+Xig77JRTg1ASLkX2mX/hgIBrmHeqnKTpa/PlAhTXQgBSZegiys/CC6Ea8MujSjhnfCWLAo17Uqx
	OumkcNZ1gioVvZpFF+6YIUhGK6eUUnk+mMCUA0reb/xDfb5qWdgRwPXXLj0kNjSD6ycPwpoL27+E/
	ZlkwUMzPe+pkbf+KjpR/N3uRx8Fm4bf3i7WenfyhYiVbJQTdI8pRwSh4FB+csIXmFE5mRZaCQOapa
	JnOTkF1707b5UK9+hPdGJcmi3xJddC74ZAkrxvnag/kUD+ZHc8bniYdc001rySpVjzS3x2RlRm/JW
	xBXvE95A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rUmVv-0000000GWGR-1wa9;
	Tue, 30 Jan 2024 11:42:51 +0000
Received: from out30-112.freemail.mail.aliyun.com ([115.124.30.112])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rUmVr-0000000GWC1-3D8n
	for linux-um@lists.infradead.org;
	Tue, 30 Jan 2024 11:42:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1706614966; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=IhSe/hckx6ypBcdE4k41LnQFuwciEnm8GoFA8OoZo2s=;
	b=DrButARUz/+I3T9d6zNlwa+hUKx1a1JltfDt48+/6UG4gpT1CYK4+4VION876n+nMapFMpy9eDgrqBN8LOHHHr3aKOgpyUW4l/ADAtuWYNXZjntWzmchm+InJZfyC0+dJQrYn+xAz8DF1eJTnSB2l3JgLzW9sumMhBF9ZpMKfPQ=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=37;SR=0;TI=SMTPD_---0W.g61W-_1706614962;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W.g61W-_1706614962)
          by smtp.aliyun-inc.com;
          Tue, 30 Jan 2024 19:42:43 +0800
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
Subject: [PATCH vhost 11/17] virtio_ring: export premapped to driver by struct virtqueue
Date: Tue, 30 Jan 2024 19:42:18 +0800
Message-Id: <20240130114224.86536-12-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20240130114224.86536-1-xuanzhuo@linux.alibaba.com>
References: <20240130114224.86536-1-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
X-Git-Hash: 239d1d475be4
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240130_034247_999486_9A4F5D3E 
X-CRM114-Status: GOOD (  12.12  )
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

Export the premapped to drivers, then drivers can check
the vq premapped mode after the find_vqs().
Because the find_vqs() just try to enable the vq premapped mode,
the driver must check that after find_vqs().

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/virtio/virtio_ring.c | 13 +++++--------
 include/linux/virtio.h       |  1 +
 2 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index e5e9672b4ab2..e7badc81642d 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -191,9 +191,6 @@ struct vring_virtqueue {
 	/* Host publishes avail event idx */
 	bool event;
 
-	/* Do DMA mapping by driver */
-	bool premapped;
-
 	/* Head of free buffer list. */
 	unsigned int free_head;
 	/* Number we've added since last sync. */
@@ -311,7 +308,7 @@ static bool vring_use_dma_api(const struct virtio_device *vdev)
 
 static bool vring_need_unmap_buffer(const struct vring_virtqueue *vring)
 {
-	return vring->use_dma_api && !vring->premapped;
+	return vring->use_dma_api && !vring->vq.premapped;
 }
 
 size_t virtio_max_dma_size(const struct virtio_device *vdev)
@@ -383,7 +380,7 @@ static struct device *vring_dma_dev(const struct vring_virtqueue *vq)
 static int vring_map_one_sg(const struct vring_virtqueue *vq, struct scatterlist *sg,
 			    enum dma_data_direction direction, dma_addr_t *addr)
 {
-	if (vq->premapped) {
+	if (vq->vq.premapped) {
 		*addr = sg_dma_address(sg);
 		return 0;
 	}
@@ -2145,7 +2142,7 @@ static struct virtqueue *vring_create_virtqueue_packed(struct virtio_device *vde
 	vq->packed_ring = true;
 	vq->dma_dev = dma_dev;
 	vq->use_dma_api = vring_use_dma_api(vdev);
-	vq->premapped = vq->use_dma_api && cfg_vq_get(cfg, premapped);
+	vq->vq.premapped = vq->use_dma_api && cfg_vq_get(cfg, premapped);
 
 	vq->indirect = virtio_has_feature(vdev, VIRTIO_RING_F_INDIRECT_DESC) &&
 		!cfg_vq_get(cfg, ctx);
@@ -2687,7 +2684,7 @@ static struct virtqueue *__vring_new_virtqueue(struct virtio_device *vdev,
 #endif
 	vq->dma_dev = tp_cfg->dma_dev;
 	vq->use_dma_api = vring_use_dma_api(vdev);
-	vq->premapped = vq->use_dma_api && cfg_vq_get(cfg, premapped);
+	vq->vq.premapped = vq->use_dma_api && cfg_vq_get(cfg, premapped);
 
 	vq->indirect = virtio_has_feature(vdev, VIRTIO_RING_F_INDIRECT_DESC) &&
 		!cfg_vq_get(cfg, ctx);
@@ -2818,7 +2815,7 @@ int virtqueue_set_dma_premapped(struct virtqueue *_vq)
 		return -EINVAL;
 	}
 
-	vq->premapped = true;
+	vq->vq.premapped = true;
 
 	if (vq->packed_ring) {
 		kfree(vq->packed.desc_dma);
diff --git a/include/linux/virtio.h b/include/linux/virtio.h
index 4cc614a38376..37ba44dc34de 100644
--- a/include/linux/virtio.h
+++ b/include/linux/virtio.h
@@ -36,6 +36,7 @@ struct virtqueue {
 	unsigned int num_free;
 	unsigned int num_max;
 	bool reset;
+	bool premapped;
 	void *priv;
 };
 
-- 
2.32.0.3.g01195cf9f


