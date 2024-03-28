Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB94FCD11DD
	for <linux-um@archiver.kernel.org>; Thu, 28 Mar 2024 08:04:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=A20ilBuS95+IL4oQL/Qqdc3b/8fl7OanxZz0FlKBv28=; b=oyngcJP6a7TaYH7b5ikfP+KhNQ
	dwzTC8h/pL9NABb59fnRgMM7HfM9aizj0U4+iEavxLHVdqSCs1MmM+TGDNA+6S2byx3gPIHcJZ94K
	IdWdlJ6l5wSmTnkddRef/1bsdJT5aIixMZrTRJd1HSxGGyxMn14ctmQc/fbjk/oo2NwSIfHSK85sd
	3fY2c6/LVY9JLEgKCjxAmCdFpBbMRqCAAy1XBMpt33T8t8V3uqzE+8fUUxxOtmMFFpBmPAz8OawpG
	Ow19/ZlzAWkMe46F328uQlMmNCVwxXWMqXlksC0PZhN+yiOXr6nfBK3wqmEWlmQhaa+iWbHW20X7P
	jPd5wjVg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rpkk1-0000000D0Ce-2xIa;
	Thu, 28 Mar 2024 08:04:05 +0000
Received: from out199-15.us.a.mail.aliyun.com ([47.90.199.15])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rpkjv-0000000D04x-3VpN
	for linux-um@lists.infradead.org;
	Thu, 28 Mar 2024 08:04:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1711613034; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=A20ilBuS95+IL4oQL/Qqdc3b/8fl7OanxZz0FlKBv28=;
	b=O31cXQV1425KqhAwra2i6ijlR0mr67798sSSBSODBf+W58EvNDgQKLM4OWupoJ2f4GMNVD9E4lGFYfW4YCPmkvqizV8CKNzSpT4qLaicCVEB4VVXOoUBPBHVqZqzc2BXF3/q27sBgOAqw6Egm6Rl5QnNtsNYrTRZPHncvKERaI8=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=26;SR=0;TI=SMTPD_---0W3SYllq_1711613031;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W3SYllq_1711613031)
          by smtp.aliyun-inc.com;
          Thu, 28 Mar 2024 16:03:52 +0800
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
Subject: [PATCH vhost v7 2/6] virtio: remove support for names array entries being null.
Date: Thu, 28 Mar 2024 16:03:44 +0800
Message-Id: <20240328080348.3620-3-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20240328080348.3620-1-xuanzhuo@linux.alibaba.com>
References: <20240328080348.3620-1-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
X-Git-Hash: fc2c3bb8a235
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240328_010400_553691_6F72CCF7 
X-CRM114-Status: GOOD (  16.30  )
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

commit 6457f126c888 ("virtio: support reserved vqs") introduced this
support. Multiqueue virtio-net use 2N as ctrl vq finally, so the logic
doesn't apply. And not one uses this.

On the other side, that makes some trouble for us to refactor the
find_vqs() params.

So I remove this support.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Acked-by: Jason Wang <jasowang@redhat.com>
---
 arch/um/drivers/virtio_uml.c           |  8 ++++----
 drivers/remoteproc/remoteproc_virtio.c | 11 ++++-------
 drivers/s390/virtio/virtio_ccw.c       |  8 ++++----
 drivers/virtio/virtio_mmio.c           | 11 ++++-------
 drivers/virtio/virtio_pci_common.c     | 18 +++++++++---------
 drivers/virtio/virtio_vdpa.c           | 11 ++++-------
 include/linux/virtio_config.h          |  2 +-
 7 files changed, 30 insertions(+), 39 deletions(-)

diff --git a/arch/um/drivers/virtio_uml.c b/arch/um/drivers/virtio_uml.c
index 8adca2000e51..773f9fc4d582 100644
--- a/arch/um/drivers/virtio_uml.c
+++ b/arch/um/drivers/virtio_uml.c
@@ -1019,8 +1019,8 @@ static int vu_find_vqs(struct virtio_device *vdev, unsigned nvqs,
 		       struct irq_affinity *desc)
 {
 	struct virtio_uml_device *vu_dev = to_virtio_uml_device(vdev);
-	int i, queue_idx = 0, rc;
 	struct virtqueue *vq;
+	int i, rc;
 
 	/* not supported for now */
 	if (WARN_ON(nvqs > 64))
@@ -1032,11 +1032,11 @@ static int vu_find_vqs(struct virtio_device *vdev, unsigned nvqs,
 
 	for (i = 0; i < nvqs; ++i) {
 		if (!names[i]) {
-			vqs[i] = NULL;
-			continue;
+			rc = -EINVAL;
+			goto error_setup;
 		}
 
-		vqs[i] = vu_setup_vq(vdev, queue_idx++, callbacks[i], names[i],
+		vqs[i] = vu_setup_vq(vdev, i, callbacks[i], names[i],
 				     ctx ? ctx[i] : false);
 		if (IS_ERR(vqs[i])) {
 			rc = PTR_ERR(vqs[i]);
diff --git a/drivers/remoteproc/remoteproc_virtio.c b/drivers/remoteproc/remoteproc_virtio.c
index 83d76915a6ad..8fb5118b6953 100644
--- a/drivers/remoteproc/remoteproc_virtio.c
+++ b/drivers/remoteproc/remoteproc_virtio.c
@@ -119,9 +119,6 @@ static struct virtqueue *rp_find_vq(struct virtio_device *vdev,
 	if (id >= ARRAY_SIZE(rvdev->vring))
 		return ERR_PTR(-EINVAL);
 
-	if (!name)
-		return NULL;
-
 	/* Search allocated memory region by name */
 	mem = rproc_find_carveout_by_name(rproc, "vdev%dvring%d", rvdev->index,
 					  id);
@@ -187,15 +184,15 @@ static int rproc_virtio_find_vqs(struct virtio_device *vdev, unsigned int nvqs,
 				 const bool * ctx,
 				 struct irq_affinity *desc)
 {
-	int i, ret, queue_idx = 0;
+	int i, ret;
 
 	for (i = 0; i < nvqs; ++i) {
 		if (!names[i]) {
-			vqs[i] = NULL;
-			continue;
+			ret = -EINVAL;
+			goto error;
 		}
 
-		vqs[i] = rp_find_vq(vdev, queue_idx++, callbacks[i], names[i],
+		vqs[i] = rp_find_vq(vdev, i, callbacks[i], names[i],
 				    ctx ? ctx[i] : false);
 		if (IS_ERR(vqs[i])) {
 			ret = PTR_ERR(vqs[i]);
diff --git a/drivers/s390/virtio/virtio_ccw.c b/drivers/s390/virtio/virtio_ccw.c
index ac67576301bf..508154705554 100644
--- a/drivers/s390/virtio/virtio_ccw.c
+++ b/drivers/s390/virtio/virtio_ccw.c
@@ -659,7 +659,7 @@ static int virtio_ccw_find_vqs(struct virtio_device *vdev, unsigned nvqs,
 {
 	struct virtio_ccw_device *vcdev = to_vc_device(vdev);
 	unsigned long *indicatorp = NULL;
-	int ret, i, queue_idx = 0;
+	int ret, i;
 	struct ccw1 *ccw;
 
 	ccw = ccw_device_dma_zalloc(vcdev->cdev, sizeof(*ccw));
@@ -668,11 +668,11 @@ static int virtio_ccw_find_vqs(struct virtio_device *vdev, unsigned nvqs,
 
 	for (i = 0; i < nvqs; ++i) {
 		if (!names[i]) {
-			vqs[i] = NULL;
-			continue;
+			ret = -EINVAL;
+			goto out;
 		}
 
-		vqs[i] = virtio_ccw_setup_vq(vdev, queue_idx++, callbacks[i],
+		vqs[i] = virtio_ccw_setup_vq(vdev, i, callbacks[i],
 					     names[i], ctx ? ctx[i] : false,
 					     ccw);
 		if (IS_ERR(vqs[i])) {
diff --git a/drivers/virtio/virtio_mmio.c b/drivers/virtio/virtio_mmio.c
index 59892a31cf76..279b9c182113 100644
--- a/drivers/virtio/virtio_mmio.c
+++ b/drivers/virtio/virtio_mmio.c
@@ -386,9 +386,6 @@ static struct virtqueue *vm_setup_vq(struct virtio_device *vdev, unsigned int in
 	else
 		notify = vm_notify;
 
-	if (!name)
-		return NULL;
-
 	/* Select the queue we're interested in */
 	writel(index, vm_dev->base + VIRTIO_MMIO_QUEUE_SEL);
 
@@ -496,7 +493,7 @@ static int vm_find_vqs(struct virtio_device *vdev, unsigned int nvqs,
 {
 	struct virtio_mmio_device *vm_dev = to_virtio_mmio_device(vdev);
 	int irq = platform_get_irq(vm_dev->pdev, 0);
-	int i, err, queue_idx = 0;
+	int i, err;
 
 	if (irq < 0)
 		return irq;
@@ -511,11 +508,11 @@ static int vm_find_vqs(struct virtio_device *vdev, unsigned int nvqs,
 
 	for (i = 0; i < nvqs; ++i) {
 		if (!names[i]) {
-			vqs[i] = NULL;
-			continue;
+			vm_del_vqs(vdev);
+			return -EINVAL;
 		}
 
-		vqs[i] = vm_setup_vq(vdev, queue_idx++, callbacks[i], names[i],
+		vqs[i] = vm_setup_vq(vdev, i, callbacks[i], names[i],
 				     ctx ? ctx[i] : false);
 		if (IS_ERR(vqs[i])) {
 			vm_del_vqs(vdev);
diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
index b655fccaf773..eda71c6e87ee 100644
--- a/drivers/virtio/virtio_pci_common.c
+++ b/drivers/virtio/virtio_pci_common.c
@@ -292,7 +292,7 @@ static int vp_find_vqs_msix(struct virtio_device *vdev, unsigned int nvqs,
 {
 	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
 	u16 msix_vec;
-	int i, err, nvectors, allocated_vectors, queue_idx = 0;
+	int i, err, nvectors, allocated_vectors;
 
 	vp_dev->vqs = kcalloc(nvqs, sizeof(*vp_dev->vqs), GFP_KERNEL);
 	if (!vp_dev->vqs)
@@ -302,7 +302,7 @@ static int vp_find_vqs_msix(struct virtio_device *vdev, unsigned int nvqs,
 		/* Best option: one for change interrupt, one per vq. */
 		nvectors = 1;
 		for (i = 0; i < nvqs; ++i)
-			if (names[i] && callbacks[i])
+			if (callbacks[i])
 				++nvectors;
 	} else {
 		/* Second best: one for change, shared for all vqs. */
@@ -318,8 +318,8 @@ static int vp_find_vqs_msix(struct virtio_device *vdev, unsigned int nvqs,
 	allocated_vectors = vp_dev->msix_used_vectors;
 	for (i = 0; i < nvqs; ++i) {
 		if (!names[i]) {
-			vqs[i] = NULL;
-			continue;
+			err = -EINVAL;
+			goto error_find;
 		}
 
 		if (!callbacks[i])
@@ -328,7 +328,7 @@ static int vp_find_vqs_msix(struct virtio_device *vdev, unsigned int nvqs,
 			msix_vec = allocated_vectors++;
 		else
 			msix_vec = VP_MSIX_VQ_VECTOR;
-		vqs[i] = vp_setup_vq(vdev, queue_idx++, callbacks[i], names[i],
+		vqs[i] = vp_setup_vq(vdev, i, callbacks[i], names[i],
 				     ctx ? ctx[i] : false,
 				     msix_vec);
 		if (IS_ERR(vqs[i])) {
@@ -363,7 +363,7 @@ static int vp_find_vqs_intx(struct virtio_device *vdev, unsigned int nvqs,
 		const char * const names[], const bool *ctx)
 {
 	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
-	int i, err, queue_idx = 0;
+	int i, err;
 
 	vp_dev->vqs = kcalloc(nvqs, sizeof(*vp_dev->vqs), GFP_KERNEL);
 	if (!vp_dev->vqs)
@@ -378,10 +378,10 @@ static int vp_find_vqs_intx(struct virtio_device *vdev, unsigned int nvqs,
 	vp_dev->per_vq_vectors = false;
 	for (i = 0; i < nvqs; ++i) {
 		if (!names[i]) {
-			vqs[i] = NULL;
-			continue;
+			err = -EINVAL;
+			goto out_del_vqs;
 		}
-		vqs[i] = vp_setup_vq(vdev, queue_idx++, callbacks[i], names[i],
+		vqs[i] = vp_setup_vq(vdev, i, callbacks[i], names[i],
 				     ctx ? ctx[i] : false,
 				     VIRTIO_MSI_NO_VECTOR);
 		if (IS_ERR(vqs[i])) {
diff --git a/drivers/virtio/virtio_vdpa.c b/drivers/virtio/virtio_vdpa.c
index e803db0da307..e82cca24d6e6 100644
--- a/drivers/virtio/virtio_vdpa.c
+++ b/drivers/virtio/virtio_vdpa.c
@@ -161,9 +161,6 @@ virtio_vdpa_setup_vq(struct virtio_device *vdev, unsigned int index,
 	bool may_reduce_num = true;
 	int err;
 
-	if (!name)
-		return NULL;
-
 	if (index >= vdpa->nvqs)
 		return ERR_PTR(-ENOENT);
 
@@ -370,7 +367,7 @@ static int virtio_vdpa_find_vqs(struct virtio_device *vdev, unsigned int nvqs,
 	struct cpumask *masks;
 	struct vdpa_callback cb;
 	bool has_affinity = desc && ops->set_vq_affinity;
-	int i, err, queue_idx = 0;
+	int i, err;
 
 	if (has_affinity) {
 		masks = create_affinity_masks(nvqs, desc ? desc : &default_affd);
@@ -380,11 +377,11 @@ static int virtio_vdpa_find_vqs(struct virtio_device *vdev, unsigned int nvqs,
 
 	for (i = 0; i < nvqs; ++i) {
 		if (!names[i]) {
-			vqs[i] = NULL;
-			continue;
+			err = -EINVAL;
+			goto err_setup_vq;
 		}
 
-		vqs[i] = virtio_vdpa_setup_vq(vdev, queue_idx++,
+		vqs[i] = virtio_vdpa_setup_vq(vdev, i,
 					      callbacks[i], names[i], ctx ?
 					      ctx[i] : false);
 		if (IS_ERR(vqs[i])) {
diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
index da9b271b54db..1c79cec258f4 100644
--- a/include/linux/virtio_config.h
+++ b/include/linux/virtio_config.h
@@ -56,7 +56,7 @@ typedef void vq_callback_t(struct virtqueue *);
  *	callbacks: array of callbacks, for each virtqueue
  *		include a NULL entry for vqs that do not need a callback
  *	names: array of virtqueue names (mainly for debugging)
- *		include a NULL entry for vqs unused by driver
+ *		MUST NOT be NULL
  *	Returns 0 on success or error status
  * @del_vqs: free virtqueues found by find_vqs().
  * @synchronize_cbs: synchronize with the virtqueue callbacks (optional)
-- 
2.32.0.3.g01195cf9f


