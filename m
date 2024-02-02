Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D20F6C48294
	for <linux-um@archiver.kernel.org>; Fri,  2 Feb 2024 09:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rnlb45VFZEdKkmqhCVNTWlXyfY5S86FPQZ5Re41VCT4=; b=CBetMlwzhTuuHXooOqV2J1wka9
	OkNj76l3FKxShZKj+TjXlaA6hgeX/Ptefg6bEtQAywaV0oYMAcjRVv/8TpZDDhholWmSzvmYOhOjo
	hNNMcyjovshFrPpp+PCLmjzVTIFvjcgNB4GQ3mLNVrv6EKn/icWHZX6ThIZn4TmZFebUV2lUlRWwC
	GAey9d8pnXTZl1Tccag2lWX+kPFLtOdYWRSp4ctH8jAm8F37vEzLc3OahgILNMfpnrjY6HKhfH3Iz
	tpsFu0LWWW4jTTRUDGvHvhATd6Fw84mgrL0vjlnXDrlHly/A+dUZ7Wqoy5Q4YG6OGQV9qN0lIv2g+
	gWhlfQAw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rVq20-0000000B0ZJ-14Nt;
	Fri, 02 Feb 2024 09:40:20 +0000
Received: from out30-110.freemail.mail.aliyun.com ([115.124.30.110])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rVq1u-0000000B0S0-0D6g
	for linux-um@lists.infradead.org;
	Fri, 02 Feb 2024 09:40:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1706866811; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=rnlb45VFZEdKkmqhCVNTWlXyfY5S86FPQZ5Re41VCT4=;
	b=bQITqOLF/PEejXP7QbuDWtFHYNZYVklaSa2vrqdh/UalQGzdx5ikhYhi8Kxi9EiQwiA61P8Ei2C/Qzfqq9EYsDPBCozQT0YpVEGVP2CgIfwTQ115+PG3ZFvDqSbdIu+kLoziGRYzfkdPM91OjBptPH7wv3xMGGjwiJ6Yzkz4+TA=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=36;SR=0;TI=SMTPD_---0W.wb-nk_1706866806;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W.wb-nk_1706866806)
          by smtp.aliyun-inc.com;
          Fri, 02 Feb 2024 17:40:07 +0800
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
	linux-um@lists.infradead.org,
	netdev@vger.kernel.org,
	platform-driver-x86@vger.kernel.org,
	linux-remoteproc@vger.kernel.org,
	linux-s390@vger.kernel.org,
	kvm@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH vhost v1 09/19] virtio: vring_new_virtqueue(): pass struct instead of multi parameters
Date: Fri,  2 Feb 2024 17:39:41 +0800
Message-Id: <20240202093951.120283-10-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20240202093951.120283-1-xuanzhuo@linux.alibaba.com>
References: <20240202093951.120283-1-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
X-Git-Hash: 4c7bacd05cb8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240202_014014_402321_94DA58AB 
X-CRM114-Status: GOOD (  14.64  )
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

Just like find_vqs(), it is time to refactor the
vring_new_virtqueue(). We pass the similar struct to
vring_new_virtqueue.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/platform/mellanox/mlxbf-tmfifo.c | 13 +++++---
 drivers/remoteproc/remoteproc_virtio.c   | 11 ++++---
 drivers/virtio/virtio_ring.c             | 29 +++++++++++-----
 include/linux/virtio_ring.h              | 42 +++++++++++++++++++-----
 tools/virtio/virtio_test.c               |  4 +--
 tools/virtio/vringh_test.c               | 28 ++++++++--------
 6 files changed, 85 insertions(+), 42 deletions(-)

diff --git a/drivers/platform/mellanox/mlxbf-tmfifo.c b/drivers/platform/mellanox/mlxbf-tmfifo.c
index a90d5da6200a..3a2013a63dda 100644
--- a/drivers/platform/mellanox/mlxbf-tmfifo.c
+++ b/drivers/platform/mellanox/mlxbf-tmfifo.c
@@ -992,6 +992,7 @@ static int mlxbf_tmfifo_virtio_find_vqs(struct virtio_device *vdev,
 					struct virtio_vq_config *cfg)
 {
 	struct mlxbf_tmfifo_vdev *tm_vdev = mlxbf_vdev_to_tmfifo(vdev);
+	struct vq_transport_config tp_cfg = {};
 	struct virtqueue **vqs = cfg->vqs;
 	struct mlxbf_tmfifo_vring *vring;
 	unsigned int nvqs = cfg->nvqs;
@@ -1011,10 +1012,14 @@ static int mlxbf_tmfifo_virtio_find_vqs(struct virtio_device *vdev,
 		/* zero vring */
 		size = vring_size(vring->num, vring->align);
 		memset(vring->va, 0, size);
-		vq = vring_new_virtqueue(i, vring->num, vring->align, vdev,
-					 false, false, vring->va,
-					 mlxbf_tmfifo_virtio_notify,
-					 cfg->callbacks[i], cfg->names[i]);
+
+		tp_cfg.num = vring->num;
+		tp_cfg.vring_align = vring->align;
+		tp_cfg.weak_barriers = false;
+		tp_cfg.notify = mlxbf_tmfifo_virtio_notify;
+
+		cfg->cfg_idx = i;
+		vq = vring_new_virtqueue(vdev, i, vring->va, &tp_cfg, cfg);
 		if (!vq) {
 			dev_err(&vdev->dev, "vring_new_virtqueue failed\n");
 			ret = -ENOMEM;
diff --git a/drivers/remoteproc/remoteproc_virtio.c b/drivers/remoteproc/remoteproc_virtio.c
index 57d51c9c7b63..70c32837f9dc 100644
--- a/drivers/remoteproc/remoteproc_virtio.c
+++ b/drivers/remoteproc/remoteproc_virtio.c
@@ -106,6 +106,7 @@ static struct virtqueue *rp_find_vq(struct virtio_device *vdev,
 {
 	struct rproc_vdev *rvdev = vdev_to_rvdev(vdev);
 	struct rproc *rproc = vdev_to_rproc(vdev);
+	struct vq_transport_config tp_cfg;
 	struct device *dev = &rproc->dev;
 	struct rproc_mem_entry *mem;
 	struct rproc_vring *rvring;
@@ -138,14 +139,16 @@ static struct virtqueue *rp_find_vq(struct virtio_device *vdev,
 	dev_dbg(dev, "vring%d: va %pK qsz %d notifyid %d\n",
 		id, addr, num, rvring->notifyid);
 
+	tp_cfg.num = num;
+	tp_cfg.vring_align = rvring->align;
+	tp_cfg.weak_barriers = false;
+	tp_cfg.notify = rproc_virtio_notify;
+
 	/*
 	 * Create the new vq, and tell virtio we're not interested in
 	 * the 'weak' smp barriers, since we're talking with a real device.
 	 */
-	vq = vring_new_virtqueue(id, num, rvring->align, vdev, false,
-				 cfg->ctx ? cfg->ctx[cfg->cfg_idx] : false,
-				 addr, rproc_virtio_notify, cfg->callbacks[cfg->cfg_idx],
-				 cfg->names[cfg->cfg_idx]);
+	vq = vring_new_virtqueue(vdev, id, addr, &tp_cfg, cfg);
 	if (!vq) {
 		dev_err(dev, "vring_new_virtqueue %s failed\n", cfg->names[cfg->cfg_idx]);
 		rproc_free_vring(rvring);
diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 09bba2ec7432..8ec1cd31680d 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -2909,18 +2909,29 @@ int virtqueue_reset(struct virtqueue *_vq,
 EXPORT_SYMBOL_GPL(virtqueue_reset);
 
 /* Only available for split ring */
-struct virtqueue *vring_new_virtqueue(unsigned int index,
-				      unsigned int num,
-				      unsigned int vring_align,
-				      struct virtio_device *vdev,
-				      bool weak_barriers,
-				      bool context,
+struct virtqueue *vring_new_virtqueue(struct virtio_device *vdev,
+				      unsigned int index,
 				      void *pages,
-				      bool (*notify)(struct virtqueue *vq),
-				      void (*callback)(struct virtqueue *vq),
-				      const char *name)
+				      struct vq_transport_config *tp_cfg,
+				      struct virtio_vq_config *cfg)
 {
 	struct vring_virtqueue_split vring_split = {};
+	unsigned int num;
+	unsigned int vring_align;
+	bool weak_barriers;
+	bool context;
+	bool (*notify)(struct virtqueue *_);
+	void (*callback)(struct virtqueue *_);
+	const char *name;
+
+	num            = tp_cfg->num;
+	vring_align    = tp_cfg->vring_align;
+	weak_barriers  = tp_cfg->weak_barriers;
+	notify         = tp_cfg->notify;
+
+	name     = cfg->names[cfg->cfg_idx];
+	callback = cfg->callbacks[cfg->cfg_idx];
+	context  = cfg->ctx ? cfg->ctx[cfg->cfg_idx] : false;
 
 	if (virtio_has_feature(vdev, VIRTIO_F_RING_PACKED))
 		return NULL;
diff --git a/include/linux/virtio_ring.h b/include/linux/virtio_ring.h
index cd8042c79814..616937780785 100644
--- a/include/linux/virtio_ring.h
+++ b/include/linux/virtio_ring.h
@@ -85,16 +85,40 @@ struct virtqueue *vring_create_virtqueue(struct virtio_device *vdev,
  * Creates a virtqueue with a standard layout but a caller-allocated
  * ring.
  */
-struct virtqueue *vring_new_virtqueue(unsigned int index,
-				      unsigned int num,
-				      unsigned int vring_align,
-				      struct virtio_device *vdev,
-				      bool weak_barriers,
-				      bool ctx,
+struct virtqueue *vring_new_virtqueue(struct virtio_device *vdev,
+				      unsigned int index,
 				      void *pages,
-				      bool (*notify)(struct virtqueue *vq),
-				      void (*callback)(struct virtqueue *vq),
-				      const char *name);
+				      struct vq_transport_config *tp_cfg,
+				      struct virtio_vq_config *cfg);
+
+static inline struct virtqueue *vring_new_virtqueue_one(unsigned int index,
+							unsigned int num,
+							unsigned int vring_align,
+							struct virtio_device *vdev,
+							bool weak_barriers,
+							bool context,
+							void *pages,
+							bool (*notify)(struct virtqueue *vq),
+							void (*callback)(struct virtqueue *vq),
+							const char *name)
+{
+	struct vq_transport_config tp_cfg = {};
+	struct virtio_vq_config cfg = {};
+	vq_callback_t *callbacks[] = { callback };
+	const char *names[] = { name };
+
+	tp_cfg.num = num;
+	tp_cfg.vring_align = vring_align;
+	tp_cfg.weak_barriers = weak_barriers;
+	tp_cfg.notify = notify;
+
+	cfg.nvqs = 1;
+	cfg.callbacks = callbacks;
+	cfg.names = names;
+	cfg.ctx = &context;
+
+	return vring_new_virtqueue(vdev, index, pages, &tp_cfg, &cfg);
+}
 
 /*
  * Destroys a virtqueue.  If created with vring_create_virtqueue, this
diff --git a/tools/virtio/virtio_test.c b/tools/virtio/virtio_test.c
index 028f54e6854a..e41300d71d5e 100644
--- a/tools/virtio/virtio_test.c
+++ b/tools/virtio/virtio_test.c
@@ -102,8 +102,8 @@ static void vq_reset(struct vq_info *info, int num, struct virtio_device *vdev)
 
 	memset(info->ring, 0, vring_size(num, 4096));
 	vring_init(&info->vring, num, info->ring, 4096);
-	info->vq = vring_new_virtqueue(info->idx, num, 4096, vdev, true, false,
-				       info->ring, vq_notify, vq_callback, "test");
+	info->vq = vring_new_virtqueue_one(info->idx, num, 4096, vdev, true, false,
+					   info->ring, vq_notify, vq_callback, "test");
 	assert(info->vq);
 	info->vq->priv = info;
 }
diff --git a/tools/virtio/vringh_test.c b/tools/virtio/vringh_test.c
index 98ff808d6f0c..040689111584 100644
--- a/tools/virtio/vringh_test.c
+++ b/tools/virtio/vringh_test.c
@@ -316,11 +316,11 @@ static int parallel_test(u64 features,
 		if (sched_setaffinity(getpid(), sizeof(cpu_set), &cpu_set))
 			err(1, "Could not set affinity to cpu %u", first_cpu);
 
-		vq = vring_new_virtqueue(0, RINGSIZE, ALIGN, &gvdev.vdev, true,
-					 false, guest_map,
-					 fast_vringh ? no_notify_host
-					 : parallel_notify_host,
-					 never_callback_guest, "guest vq");
+		vq = vring_new_virtqueue_one(0, RINGSIZE, ALIGN, &gvdev.vdev, true,
+					     false, guest_map,
+					     fast_vringh ? no_notify_host
+					     : parallel_notify_host,
+					     never_callback_guest, "guest vq");
 
 		/* Don't kfree indirects. */
 		__kfree_ignore_start = indirects;
@@ -485,10 +485,10 @@ int main(int argc, char *argv[])
 	memset(__user_addr_min, 0, vring_size(RINGSIZE, ALIGN));
 
 	/* Set up guest side. */
-	vq = vring_new_virtqueue(0, RINGSIZE, ALIGN, &vdev, true, false,
-				 __user_addr_min,
-				 never_notify_host, never_callback_guest,
-				 "guest vq");
+	vq = vring_new_virtqueue_one(0, RINGSIZE, ALIGN, &vdev, true, false,
+				     __user_addr_min,
+				     never_notify_host, never_callback_guest,
+				     "guest vq");
 
 	/* Set up host side. */
 	vring_init(&vrh.vring, RINGSIZE, __user_addr_min, ALIGN);
@@ -668,11 +668,11 @@ int main(int argc, char *argv[])
 
 		/* Force creation of direct, which we modify. */
 		__virtio_clear_bit(&vdev, VIRTIO_RING_F_INDIRECT_DESC);
-		vq = vring_new_virtqueue(0, RINGSIZE, ALIGN, &vdev, true,
-					 false, __user_addr_min,
-					 never_notify_host,
-					 never_callback_guest,
-					 "guest vq");
+		vq = vring_new_virtqueue_one(0, RINGSIZE, ALIGN, &vdev, true,
+					     false, __user_addr_min,
+					     never_notify_host,
+					     never_callback_guest,
+					     "guest vq");
 
 		sg_init_table(guest_sg, 4);
 		sg_set_buf(&guest_sg[0], d, sizeof(*d)*2);
-- 
2.32.0.3.g01195cf9f


