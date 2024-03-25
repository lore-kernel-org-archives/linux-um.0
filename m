Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A02C7C6FD1F
	for <linux-um@archiver.kernel.org>; Mon, 25 Mar 2024 09:04:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JG20w7ybJ7RY38XLEtP4gguf6EE2tsVwqebAHrWoXys=; b=OJXVs8g0sOJlx2lLtMdKvVhti8
	DYHispifHlv5thWFR8Ib82k1M33EunMzWhxxznJLG1OPBcvebnwDGzTU/SSAHCYw+rC0fwBseTbUM
	JwqWQ3k+/F4tW9Lh3T160bZ6bJFeAC+80vTnQvHQ4lwQP105SHzrBFz3E1TM/YBid1HKnjEaEBC55
	vROsGc3y9YHOi+YNcJa0H/B4HQxDmY8gFd2rxN3dbdD0QTHqmmnbs3afeGtfIk0rj3lVrUY/q3OY0
	lLM9b8ImLRW1XGpyihiBNOrXfyjDA/IzLCOaS5mWTP6pAT6LRb6lVV76pInMBQVrqgEld08G82hDE
	11whoTKA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rogFw-0000000GKp8-0CCa;
	Mon, 25 Mar 2024 09:04:36 +0000
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rogFo-0000000GKik-02dv
	for linux-um@lists.infradead.org;
	Mon, 25 Mar 2024 09:04:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1711357464; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=JG20w7ybJ7RY38XLEtP4gguf6EE2tsVwqebAHrWoXys=;
	b=jUSUFD3xde8qvGrpQ1P42NsVoa090o/YsWI9WfO70v22wUKeV9+EDZ3mKv7nIM2us4cjdpvyJOgFMrJzIF3XxG3uoHN9SGAIrQabJbL83pcRFwUPwIeC4yGX+H0SMim6pNYAEwpfki381iPAuD93PGtJ2tN0xeGFVpD4CbuBF0M=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R691e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=26;SR=0;TI=SMTPD_---0W3DYllR_1711357462;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W3DYllR_1711357462)
          by smtp.aliyun-inc.com;
          Mon, 25 Mar 2024 17:04:23 +0800
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
Subject: [PATCH vhost v5 2/6] virtio: remove support for names array entries being null.
Date: Mon, 25 Mar 2024 17:04:15 +0800
Message-Id: <20240325090419.33677-3-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20240325090419.33677-1-xuanzhuo@linux.alibaba.com>
References: <20240325090419.33677-1-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
X-Git-Hash: f38b33f54e32
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240325_020428_442327_8808766E 
X-CRM114-Status: GOOD (  10.50  )
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
---
 arch/um/drivers/virtio_uml.c             | 5 -----
 drivers/platform/mellanox/mlxbf-tmfifo.c | 4 ----
 drivers/remoteproc/remoteproc_virtio.c   | 5 -----
 drivers/s390/virtio/virtio_ccw.c         | 5 -----
 drivers/virtio/virtio_mmio.c             | 5 -----
 drivers/virtio/virtio_pci_common.c       | 9 ---------
 drivers/virtio/virtio_vdpa.c             | 5 -----
 include/linux/virtio_config.h            | 1 -
 8 files changed, 39 deletions(-)

diff --git a/arch/um/drivers/virtio_uml.c b/arch/um/drivers/virtio_uml.c
index 8adca2000e51..1d1e8654b7fc 100644
--- a/arch/um/drivers/virtio_uml.c
+++ b/arch/um/drivers/virtio_uml.c
@@ -1031,11 +1031,6 @@ static int vu_find_vqs(struct virtio_device *vdev, unsigned nvqs,
 		return rc;
 
 	for (i = 0; i < nvqs; ++i) {
-		if (!names[i]) {
-			vqs[i] = NULL;
-			continue;
-		}
-
 		vqs[i] = vu_setup_vq(vdev, queue_idx++, callbacks[i], names[i],
 				     ctx ? ctx[i] : false);
 		if (IS_ERR(vqs[i])) {
diff --git a/drivers/platform/mellanox/mlxbf-tmfifo.c b/drivers/platform/mellanox/mlxbf-tmfifo.c
index b8d1e32e97eb..f4639331f32e 100644
--- a/drivers/platform/mellanox/mlxbf-tmfifo.c
+++ b/drivers/platform/mellanox/mlxbf-tmfifo.c
@@ -1072,10 +1072,6 @@ static int mlxbf_tmfifo_virtio_find_vqs(struct virtio_device *vdev,
 		return -EINVAL;
 
 	for (i = 0; i < nvqs; ++i) {
-		if (!names[i]) {
-			ret = -EINVAL;
-			goto error;
-		}
 		vring = &tm_vdev->vrings[i];
 
 		/* zero vring */
diff --git a/drivers/remoteproc/remoteproc_virtio.c b/drivers/remoteproc/remoteproc_virtio.c
index 83d76915a6ad..cd71827d67af 100644
--- a/drivers/remoteproc/remoteproc_virtio.c
+++ b/drivers/remoteproc/remoteproc_virtio.c
@@ -190,11 +190,6 @@ static int rproc_virtio_find_vqs(struct virtio_device *vdev, unsigned int nvqs,
 	int i, ret, queue_idx = 0;
 
 	for (i = 0; i < nvqs; ++i) {
-		if (!names[i]) {
-			vqs[i] = NULL;
-			continue;
-		}
-
 		vqs[i] = rp_find_vq(vdev, queue_idx++, callbacks[i], names[i],
 				    ctx ? ctx[i] : false);
 		if (IS_ERR(vqs[i])) {
diff --git a/drivers/s390/virtio/virtio_ccw.c b/drivers/s390/virtio/virtio_ccw.c
index ac67576301bf..773f16c294d9 100644
--- a/drivers/s390/virtio/virtio_ccw.c
+++ b/drivers/s390/virtio/virtio_ccw.c
@@ -667,11 +667,6 @@ static int virtio_ccw_find_vqs(struct virtio_device *vdev, unsigned nvqs,
 		return -ENOMEM;
 
 	for (i = 0; i < nvqs; ++i) {
-		if (!names[i]) {
-			vqs[i] = NULL;
-			continue;
-		}
-
 		vqs[i] = virtio_ccw_setup_vq(vdev, queue_idx++, callbacks[i],
 					     names[i], ctx ? ctx[i] : false,
 					     ccw);
diff --git a/drivers/virtio/virtio_mmio.c b/drivers/virtio/virtio_mmio.c
index 59892a31cf76..a95c98cca63e 100644
--- a/drivers/virtio/virtio_mmio.c
+++ b/drivers/virtio/virtio_mmio.c
@@ -510,11 +510,6 @@ static int vm_find_vqs(struct virtio_device *vdev, unsigned int nvqs,
 		enable_irq_wake(irq);
 
 	for (i = 0; i < nvqs; ++i) {
-		if (!names[i]) {
-			vqs[i] = NULL;
-			continue;
-		}
-
 		vqs[i] = vm_setup_vq(vdev, queue_idx++, callbacks[i], names[i],
 				     ctx ? ctx[i] : false);
 		if (IS_ERR(vqs[i])) {
diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
index b655fccaf773..783758672ef9 100644
--- a/drivers/virtio/virtio_pci_common.c
+++ b/drivers/virtio/virtio_pci_common.c
@@ -317,11 +317,6 @@ static int vp_find_vqs_msix(struct virtio_device *vdev, unsigned int nvqs,
 	vp_dev->per_vq_vectors = per_vq_vectors;
 	allocated_vectors = vp_dev->msix_used_vectors;
 	for (i = 0; i < nvqs; ++i) {
-		if (!names[i]) {
-			vqs[i] = NULL;
-			continue;
-		}
-
 		if (!callbacks[i])
 			msix_vec = VIRTIO_MSI_NO_VECTOR;
 		else if (vp_dev->per_vq_vectors)
@@ -377,10 +372,6 @@ static int vp_find_vqs_intx(struct virtio_device *vdev, unsigned int nvqs,
 	vp_dev->intx_enabled = 1;
 	vp_dev->per_vq_vectors = false;
 	for (i = 0; i < nvqs; ++i) {
-		if (!names[i]) {
-			vqs[i] = NULL;
-			continue;
-		}
 		vqs[i] = vp_setup_vq(vdev, queue_idx++, callbacks[i], names[i],
 				     ctx ? ctx[i] : false,
 				     VIRTIO_MSI_NO_VECTOR);
diff --git a/drivers/virtio/virtio_vdpa.c b/drivers/virtio/virtio_vdpa.c
index e803db0da307..c1a3fbacd463 100644
--- a/drivers/virtio/virtio_vdpa.c
+++ b/drivers/virtio/virtio_vdpa.c
@@ -379,11 +379,6 @@ static int virtio_vdpa_find_vqs(struct virtio_device *vdev, unsigned int nvqs,
 	}
 
 	for (i = 0; i < nvqs; ++i) {
-		if (!names[i]) {
-			vqs[i] = NULL;
-			continue;
-		}
-
 		vqs[i] = virtio_vdpa_setup_vq(vdev, queue_idx++,
 					      callbacks[i], names[i], ctx ?
 					      ctx[i] : false);
diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
index da9b271b54db..d362a29550fa 100644
--- a/include/linux/virtio_config.h
+++ b/include/linux/virtio_config.h
@@ -56,7 +56,6 @@ typedef void vq_callback_t(struct virtqueue *);
  *	callbacks: array of callbacks, for each virtqueue
  *		include a NULL entry for vqs that do not need a callback
  *	names: array of virtqueue names (mainly for debugging)
- *		include a NULL entry for vqs unused by driver
  *	Returns 0 on success or error status
  * @del_vqs: free virtqueues found by find_vqs().
  * @synchronize_cbs: synchronize with the virtqueue callbacks (optional)
-- 
2.32.0.3.g01195cf9f


