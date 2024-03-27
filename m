Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E752CD1288
	for <linux-um@archiver.kernel.org>; Wed, 27 Mar 2024 09:57:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HnxiJm9cCKGDKkwrU5NSdhFE/Ow7xzM7IdVbEz3eXUQ=; b=XKyJa4C/1RDLBzuo67UVO+jmOT
	zihO/1YS2Jf20OAlNh9M7UFHp9hzSlD+LbQT2k4jzqv/1tL3ybyrFOeWtQ23VOPX6+a89y0moR4ky
	gXPyzmPHg3u90lbbN91NJ+X3wZZc23xPmMly/J7THhZKRxWfPeApMx8zjmWZOHYaw9IPKQUN7UaIM
	b0L2xTOxHal/sxpCIxGd2SekZs4WuJn6DyX3RMCzPajaCZtsEeZs8MHUEgag8dpJsV38yaMZCHkKE
	cQsegg3bpQEOHFgqM3EfKVwc5GW9b0aj336tnDfh49dfIFTFppxFKf+XQvJgFvtQNPf5yIE1WjCYc
	EYJ2jbBw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rpQ2g-00000008J1J-3C0e;
	Wed, 27 Mar 2024 09:57:58 +0000
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rpQ2a-00000008IvW-0kG6
	for linux-um@lists.infradead.org;
	Wed, 27 Mar 2024 09:57:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1711533469; h=From:To:Subject:Date:Message-Id:MIME-Version:Content-Type;
	bh=HnxiJm9cCKGDKkwrU5NSdhFE/Ow7xzM7IdVbEz3eXUQ=;
	b=I9lPPmJPyXzzj5Zfz1NhbCSVgSMNPVz4UE6UnwocPvl6LWuGOXYzWrJVFbEAvShz2efv1UdX+yxdMC4DQB6DkGJTzpmjQmOTxz9k/Y8Vr0byddxfXLctAuTraldwkQXfIQ7OFnUXI1oJUmVXY0LJdQN1zFi4Ze1yyiYWYFZm7w8=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R591e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=26;SR=0;TI=SMTPD_---0W3OJje2_1711533466;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W3OJje2_1711533466)
          by smtp.aliyun-inc.com;
          Wed, 27 Mar 2024 17:57:47 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: virtualization@lists.linux.dev
Cc: Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
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
	"Michael S. Tsirkin" <mst@redhat.com>,
	David Hildenbrand <david@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	linux-um@lists.infradead.org,
	platform-driver-x86@vger.kernel.org,
	linux-remoteproc@vger.kernel.org,
	linux-s390@vger.kernel.org,
	kvm@vger.kernel.org
Subject: [PATCH vhost v6 4/6] virtio: vring_create_virtqueue: pass struct instead of multi parameters
Date: Wed, 27 Mar 2024 17:57:39 +0800
Message-Id: <20240327095741.88135-5-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20240327095741.88135-1-xuanzhuo@linux.alibaba.com>
References: <20240327095741.88135-1-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Git-Hash: f3c3b67ebbb4
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240327_025752_570728_11A02080 
X-CRM114-Status: GOOD (  20.95  )
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

Now, we pass multi parameters to vring_create_virtqueue. These parameters
may from transport or from driver.

vring_create_virtqueue is called by many places.
Every time, we try to add a new parameter, that is difficult.

If parameters from the driver, that should directly be passed to vring.
Then the vring can access the config from driver directly.

If parameters from the transport, we squish the parameters to a
structure. That will be helpful to add new parameter.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Acked-by: Johannes Berg <johannes@sipsolutions.net>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 arch/um/drivers/virtio_uml.c       | 14 +++++---
 drivers/s390/virtio/virtio_ccw.c   | 14 ++++----
 drivers/virtio/virtio_mmio.c       | 14 ++++----
 drivers/virtio/virtio_pci_legacy.c | 15 ++++----
 drivers/virtio/virtio_pci_modern.c | 15 ++++----
 drivers/virtio/virtio_ring.c       | 57 ++++++++++++------------------
 drivers/virtio/virtio_vdpa.c       | 21 +++++------
 include/linux/virtio_ring.h        | 51 +++++++++++++-------------
 8 files changed, 101 insertions(+), 100 deletions(-)

diff --git a/arch/um/drivers/virtio_uml.c b/arch/um/drivers/virtio_uml.c
index adc619362cc0..1ac8904b53c7 100644
--- a/arch/um/drivers/virtio_uml.c
+++ b/arch/um/drivers/virtio_uml.c
@@ -942,6 +942,7 @@ static struct virtqueue *vu_setup_vq(struct virtio_device *vdev,
 {
 	struct virtio_uml_device *vu_dev = to_virtio_uml_device(vdev);
 	struct platform_device *pdev = vu_dev->pdev;
+	struct vq_transport_config tp_cfg = {};
 	struct virtio_uml_vq_info *info;
 	struct virtqueue *vq;
 	int num = MAX_SUPPORTED_QUEUE_SIZE;
@@ -955,10 +956,15 @@ static struct virtqueue *vu_setup_vq(struct virtio_device *vdev,
 	snprintf(info->name, sizeof(info->name), "%s.%d-%s", pdev->name,
 		 pdev->id, cfg->names[index]);
 
-	vq = vring_create_virtqueue(index, num, PAGE_SIZE, vdev, true, true,
-				    cfg->ctx ? cfg->ctx[index] : false,
-				    vu_notify,
-				    cfg->callbacks[index], info->name);
+	tp_cfg.num = num;
+	tp_cfg.vring_align = PAGE_SIZE;
+	tp_cfg.weak_barriers = true;
+	tp_cfg.may_reduce_num = true;
+	tp_cfg.notify = vu_notify;
+
+	cfg->names[index] = info->name;
+
+	vq = vring_create_virtqueue(vdev, index, &tp_cfg, cfg);
 	if (!vq) {
 		rc = -ENOMEM;
 		goto error_create;
diff --git a/drivers/s390/virtio/virtio_ccw.c b/drivers/s390/virtio/virtio_ccw.c
index 3c78122f00f5..27f904d165ff 100644
--- a/drivers/s390/virtio/virtio_ccw.c
+++ b/drivers/s390/virtio/virtio_ccw.c
@@ -503,6 +503,7 @@ static struct virtqueue *virtio_ccw_setup_vq(struct virtio_device *vdev,
 					     struct virtio_vq_config *cfg)
 {
 	struct virtio_ccw_device *vcdev = to_vc_device(vdev);
+	struct vq_transport_config tp_cfg = {};
 	bool (*notify)(struct virtqueue *vq);
 	int err;
 	struct virtqueue *vq = NULL;
@@ -536,13 +537,14 @@ static struct virtqueue *virtio_ccw_setup_vq(struct virtio_device *vdev,
 		goto out_err;
 	}
 	may_reduce = vcdev->revision > 0;
-	vq = vring_create_virtqueue(i, info->num, KVM_VIRTIO_CCW_RING_ALIGN,
-				    vdev, true, may_reduce,
-				    cfg->ctx ? cfg->ctx[i] : false,
-				    notify,
-				    cfg->callbacks[i],
-				    cfg->names[i]);
 
+	tp_cfg.num = info->num;
+	tp_cfg.vring_align = KVM_VIRTIO_CCW_RING_ALIGN;
+	tp_cfg.weak_barriers = true;
+	tp_cfg.may_reduce_num = may_reduce;
+	tp_cfg.notify = notify;
+
+	vq = vring_create_virtqueue(vdev, i, &tp_cfg, cfg);
 	if (!vq) {
 		/* For now, we fail if we can't get the requested size. */
 		dev_warn(&vcdev->cdev->dev, "no vq\n");
diff --git a/drivers/virtio/virtio_mmio.c b/drivers/virtio/virtio_mmio.c
index 7f0fdc3f51cb..2820a9abe8f7 100644
--- a/drivers/virtio/virtio_mmio.c
+++ b/drivers/virtio/virtio_mmio.c
@@ -373,6 +373,7 @@ static struct virtqueue *vm_setup_vq(struct virtio_device *vdev, unsigned int in
 				     struct virtio_vq_config *cfg)
 {
 	struct virtio_mmio_device *vm_dev = to_virtio_mmio_device(vdev);
+	struct vq_transport_config tp_cfg = {};
 	bool (*notify)(struct virtqueue *vq);
 	struct virtio_mmio_vq_info *info;
 	struct virtqueue *vq;
@@ -408,13 +409,14 @@ static struct virtqueue *vm_setup_vq(struct virtio_device *vdev, unsigned int in
 		goto error_new_virtqueue;
 	}
 
+	tp_cfg.num = num;
+	tp_cfg.vring_align = VIRTIO_MMIO_VRING_ALIGN;
+	tp_cfg.weak_barriers = true;
+	tp_cfg.may_reduce_num = true;
+	tp_cfg.notify = notify;
+
 	/* Create the vring */
-	vq = vring_create_virtqueue(index, num, VIRTIO_MMIO_VRING_ALIGN, vdev,
-				    true, true,
-				    cfg->ctx ? cfg->ctx[index] : false,
-				    notify,
-				    cfg->callbacks[index],
-				    cfg->names[index]);
+	vq = vring_create_virtqueue(vdev, index, &tp_cfg, cfg);
 	if (!vq) {
 		err = -ENOMEM;
 		goto error_new_virtqueue;
diff --git a/drivers/virtio/virtio_pci_legacy.c b/drivers/virtio/virtio_pci_legacy.c
index a8de653dd7a7..6fe675b2a5e5 100644
--- a/drivers/virtio/virtio_pci_legacy.c
+++ b/drivers/virtio/virtio_pci_legacy.c
@@ -113,6 +113,7 @@ static struct virtqueue *setup_vq(struct virtio_pci_device *vp_dev,
 				  struct virtio_vq_config *cfg,
 				  u16 msix_vec)
 {
+	struct vq_transport_config tp_cfg = {};
 	struct virtqueue *vq;
 	u16 num;
 	int err;
@@ -125,14 +126,14 @@ static struct virtqueue *setup_vq(struct virtio_pci_device *vp_dev,
 
 	info->msix_vector = msix_vec;
 
+	tp_cfg.num = num;
+	tp_cfg.vring_align = VIRTIO_PCI_VRING_ALIGN;
+	tp_cfg.weak_barriers = true;
+	tp_cfg.may_reduce_num = false;
+	tp_cfg.notify = vp_notify;
+
 	/* create the vring */
-	vq = vring_create_virtqueue(index, num,
-				    VIRTIO_PCI_VRING_ALIGN, &vp_dev->vdev,
-				    true, false,
-				    cfg->ctx ? cfg->ctx[index] : false,
-				    vp_notify,
-				    cfg->callbacks[index],
-				    cfg->names[index]);
+	vq = vring_create_virtqueue(&vp_dev->vdev, index, &tp_cfg, cfg);
 	if (!vq)
 		return ERR_PTR(-ENOMEM);
 
diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
index bcb829ffec64..12130027d0c0 100644
--- a/drivers/virtio/virtio_pci_modern.c
+++ b/drivers/virtio/virtio_pci_modern.c
@@ -535,6 +535,7 @@ static struct virtqueue *setup_vq(struct virtio_pci_device *vp_dev,
 {
 
 	struct virtio_pci_modern_device *mdev = &vp_dev->mdev;
+	struct vq_transport_config tp_cfg = {};
 	bool (*notify)(struct virtqueue *vq);
 	struct virtqueue *vq;
 	bool is_avq;
@@ -558,14 +559,14 @@ static struct virtqueue *setup_vq(struct virtio_pci_device *vp_dev,
 
 	info->msix_vector = msix_vec;
 
+	tp_cfg.num = num;
+	tp_cfg.vring_align = SMP_CACHE_BYTES;
+	tp_cfg.weak_barriers = true;
+	tp_cfg.may_reduce_num = true;
+	tp_cfg.notify = notify;
+
 	/* create the vring */
-	vq = vring_create_virtqueue(index, num,
-				    SMP_CACHE_BYTES, &vp_dev->vdev,
-				    true, true,
-				    cfg->ctx ? cfg->ctx[index] : false,
-				    notify,
-				    cfg->callbacks[index],
-				    cfg->names[index]);
+	vq = vring_create_virtqueue(&vp_dev->vdev, index, &tp_cfg, cfg);
 	if (!vq)
 		return ERR_PTR(-ENOMEM);
 
diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 6f7e5010a673..b0e19a84644c 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -2662,43 +2662,32 @@ static struct virtqueue *__vring_new_virtqueue(unsigned int index,
 	return &vq->vq;
 }
 
-struct virtqueue *vring_create_virtqueue(
-	unsigned int index,
-	unsigned int num,
-	unsigned int vring_align,
-	struct virtio_device *vdev,
-	bool weak_barriers,
-	bool may_reduce_num,
-	bool context,
-	bool (*notify)(struct virtqueue *),
-	void (*callback)(struct virtqueue *),
-	const char *name)
+struct virtqueue *vring_create_virtqueue(struct virtio_device *vdev,
+					 unsigned int index,
+					 struct vq_transport_config *tp_cfg,
+					 struct virtio_vq_config *cfg)
 {
+	struct device *dma_dev;
+	unsigned int num;
+	unsigned int vring_align;
+	bool weak_barriers;
+	bool may_reduce_num;
+	bool context;
+	bool (*notify)(struct virtqueue *_);
+	void (*callback)(struct virtqueue *_);
+	const char *name;
 
-	if (virtio_has_feature(vdev, VIRTIO_F_RING_PACKED))
-		return vring_create_virtqueue_packed(index, num, vring_align,
-				vdev, weak_barriers, may_reduce_num,
-				context, notify, callback, name, vdev->dev.parent);
+	dma_dev = tp_cfg->dma_dev ? : vdev->dev.parent;
 
-	return vring_create_virtqueue_split(index, num, vring_align,
-			vdev, weak_barriers, may_reduce_num,
-			context, notify, callback, name, vdev->dev.parent);
-}
-EXPORT_SYMBOL_GPL(vring_create_virtqueue);
+	num            = tp_cfg->num;
+	vring_align    = tp_cfg->vring_align;
+	weak_barriers  = tp_cfg->weak_barriers;
+	may_reduce_num = tp_cfg->may_reduce_num;
+	notify         = tp_cfg->notify;
 
-struct virtqueue *vring_create_virtqueue_dma(
-	unsigned int index,
-	unsigned int num,
-	unsigned int vring_align,
-	struct virtio_device *vdev,
-	bool weak_barriers,
-	bool may_reduce_num,
-	bool context,
-	bool (*notify)(struct virtqueue *),
-	void (*callback)(struct virtqueue *),
-	const char *name,
-	struct device *dma_dev)
-{
+	name     = cfg->names[index];
+	callback = cfg->callbacks[index];
+	context  = cfg->ctx ? cfg->ctx[index] : false;
 
 	if (virtio_has_feature(vdev, VIRTIO_F_RING_PACKED))
 		return vring_create_virtqueue_packed(index, num, vring_align,
@@ -2709,7 +2698,7 @@ struct virtqueue *vring_create_virtqueue_dma(
 			vdev, weak_barriers, may_reduce_num,
 			context, notify, callback, name, dma_dev);
 }
-EXPORT_SYMBOL_GPL(vring_create_virtqueue_dma);
+EXPORT_SYMBOL_GPL(vring_create_virtqueue);
 
 /**
  * virtqueue_resize - resize the vring of vq
diff --git a/drivers/virtio/virtio_vdpa.c b/drivers/virtio/virtio_vdpa.c
index 6e7aafb42100..965936771645 100644
--- a/drivers/virtio/virtio_vdpa.c
+++ b/drivers/virtio/virtio_vdpa.c
@@ -146,8 +146,8 @@ virtio_vdpa_setup_vq(struct virtio_device *vdev, unsigned int index,
 {
 	struct virtio_vdpa_device *vd_dev = to_virtio_vdpa_device(vdev);
 	struct vdpa_device *vdpa = vd_get_vdpa(vdev);
-	struct device *dma_dev;
 	const struct vdpa_config_ops *ops = vdpa->config;
+	struct vq_transport_config tp_cfg = {};
 	struct virtio_vdpa_vq_info *info;
 	bool (*notify)(struct virtqueue *vq) = virtio_vdpa_notify;
 	struct vdpa_callback cb;
@@ -198,16 +198,17 @@ virtio_vdpa_setup_vq(struct virtio_device *vdev, unsigned int index,
 	align = ops->get_vq_align(vdpa);
 
 	if (ops->get_vq_dma_dev)
-		dma_dev = ops->get_vq_dma_dev(vdpa, index);
+		tp_cfg.dma_dev = ops->get_vq_dma_dev(vdpa, index);
 	else
-		dma_dev = vdpa_get_dma_dev(vdpa);
-	vq = vring_create_virtqueue_dma(index, max_num, align, vdev,
-					true, may_reduce_num,
-					cfg->ctx ? cfg->ctx[index] : false,
-					notify,
-					cfg->callbacks[index],
-					cfg->names[index],
-					dma_dev);
+		tp_cfg.dma_dev = vdpa_get_dma_dev(vdpa);
+
+	tp_cfg.num = max_num;
+	tp_cfg.vring_align = align;
+	tp_cfg.weak_barriers = true;
+	tp_cfg.may_reduce_num = may_reduce_num;
+	tp_cfg.notify = notify;
+
+	vq = vring_create_virtqueue(vdev, index, &tp_cfg, cfg);
 	if (!vq) {
 		err = -ENOMEM;
 		goto error_new_virtqueue;
diff --git a/include/linux/virtio_ring.h b/include/linux/virtio_ring.h
index 9b33df741b63..0a81f7f025ce 100644
--- a/include/linux/virtio_ring.h
+++ b/include/linux/virtio_ring.h
@@ -5,6 +5,7 @@
 #include <asm/barrier.h>
 #include <linux/irqreturn.h>
 #include <uapi/linux/virtio_ring.h>
+#include <linux/virtio_config.h>
 
 /*
  * Barriers in virtio are tricky.  Non-SMP virtio guests can't assume
@@ -60,38 +61,36 @@ struct virtio_device;
 struct virtqueue;
 struct device;
 
+/**
+ * struct vq_transport_config - Configuration for creating a new virtqueue (vq)
+ * @num: Number of descriptors in this virtqueue.
+ * @vring_align: Alignment size of this virtqueue's ring.
+ * @weak_barriers: Memory barrier strategy used within virtio_[rw]mb() to
+ *	enforce ordering of memory operations.
+ * @may_reduce_num: Indicates whether the number of descriptors can be reduced
+ *	if vring allocation fails.
+ * @notify: Callback function used to notify the device of certain events.
+ * @dma_dev: DMA device associated with this virtqueue, used by the DMA API.
+ */
+struct vq_transport_config {
+	unsigned int num;
+	unsigned int vring_align;
+	bool weak_barriers;
+	bool may_reduce_num;
+	bool (*notify)(struct virtqueue *vq);
+	struct device *dma_dev;
+};
+
 /*
  * Creates a virtqueue and allocates the descriptor ring.  If
  * may_reduce_num is set, then this may allocate a smaller ring than
  * expected.  The caller should query virtqueue_get_vring_size to learn
  * the actual size of the ring.
  */
-struct virtqueue *vring_create_virtqueue(unsigned int index,
-					 unsigned int num,
-					 unsigned int vring_align,
-					 struct virtio_device *vdev,
-					 bool weak_barriers,
-					 bool may_reduce_num,
-					 bool ctx,
-					 bool (*notify)(struct virtqueue *vq),
-					 void (*callback)(struct virtqueue *vq),
-					 const char *name);
-
-/*
- * Creates a virtqueue and allocates the descriptor ring with per
- * virtqueue DMA device.
- */
-struct virtqueue *vring_create_virtqueue_dma(unsigned int index,
-					     unsigned int num,
-					     unsigned int vring_align,
-					     struct virtio_device *vdev,
-					     bool weak_barriers,
-					     bool may_reduce_num,
-					     bool ctx,
-					     bool (*notify)(struct virtqueue *vq),
-					     void (*callback)(struct virtqueue *vq),
-					     const char *name,
-					     struct device *dma_dev);
+struct virtqueue *vring_create_virtqueue(struct virtio_device *vdev,
+					 unsigned int index,
+					 struct vq_transport_config *tp_cfg,
+					 struct virtio_vq_config *cfg);
 
 /*
  * Creates a virtqueue with a standard layout but a caller-allocated
-- 
2.32.0.3.g01195cf9f


