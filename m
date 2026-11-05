Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29D9F606A328
	for <linux-um@archiver.kernel.org>; Thu,  5 Nov 2026 20:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=o6m7nPtJ;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=c0bf6ZHI
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Unsubscribe-Post:List-Owner;
	bh=gCnltw4xBZg9rf91kbCMq2uc9N/TBEgzKyF8/A/W2/A=; b=o6m7nPtJZxoDu6PWLtOOvDdbvT
	37cwmBwyv3HfxHbYT8YxxS1oI7Nd5EqE7SphmhxIhn8p2xznlL+rkpQFscJd3vjte9/Z156DLOtPs
	DJ9mgpEh19lEAmd3uel2tWbilbH3j1BPcsHTjfpV5VtF7b97IOoaVZvqaV2S3lj9Kt98hJw3Gndan
	dhUivmHnHhhlrMeMRg10k1QsQio3r022gTHLZsu2OIpySewOG4bLEFf15yw39x/wComQ6ZWyhMfkk
	GgB8eoSRJYcByhO9IJU7Zus7mE3NbtInSg5368sQZZcRmh3/BPSVZdaVL8lMrwWikxkHLAm0JmxV9
	iz8jcWYw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xP3EY-0000000AMb8-1FZa;
	Thu, 05 Nov 2026 19:34:50 +0000
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xP3EP-0000000AMZ3-2NRM
	for linux-um@lists.infradead.org;
	Thu, 05 Nov 2026 19:34:48 +0000
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-48e00eee27dso1413137f8f.0
        for <linux-um@lists.infradead.org>; Thu, 05 Nov 2026 11:34:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793907275; x=1794512075; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=gCnltw4xBZg9rf91kbCMq2uc9N/TBEgzKyF8/A/W2/A=;
        b=c0bf6ZHIBR6SQpw5AX3MT1TCpj0xTyCglJPJ8vE/hwBkxDcJMXklQ3ry5ZGTIfEx/t
         eTsh2q1mb3iNz5uwgiKMF8mkz/AOymcufN6IAMY6OHFfU8LAVE45leVOa33TAwVKK7VK
         O16r7BJJoeFTxQGZQf//2sHHZ093NXeTQ4MhD0kHNeeJpgQW+wXYF+7/xrOZvXYX7/qY
         nSU9Ho1TWj25wTO64Ri5DI6PIzW43lSvBCoe9Kh/tbc12OAbQnuB1sNqgLy4G/gzyeDM
         faFo/+IU4dZQhbkoqk4Jgnj+BBMLd1+eeN/6lmvOrtbSTHyGo9q6Q5b5kt5Yk2PXdOFF
         jO6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793907275; x=1794512075;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gCnltw4xBZg9rf91kbCMq2uc9N/TBEgzKyF8/A/W2/A=;
        b=EMhgCN05905yuc2IEFCcISh968djD1Kutv6jL/AE0uXV4++McTe7kh/Q1GW3Qwl2K/
         h7UuxNxuZQM6uRmlAD38Opq1r8qyPz6VoO9C8/dLQXFQM0O0xeT8O+Cjb20+5qV31OOA
         JY/KIGvVLso+T38qlKPXgQwoEAXxiKF9YiYEXq7FZUmOStSqT8fPJiVFdvpI2VgzS2Oh
         tWwBfDsF9iFGsnar238ZNgwfCnyOh6KlszaIUJ0qJGnANHGi2iGLtje8FHNqiM/vkmqn
         7BWh1IOSi2bBpSyanMT+9fCquudQWphIkf9C0exqKMId3lDAaIpGl924DDedGHVNcc2F
         VKPQ==
X-Forwarded-Encrypted: i=1; AKwUvBxHfgy5Bn81VuNTmfrGcYImUCfyjrwRETky7F2SgrBrfGYAM2i6cssT2d/6tupqTJlq5tSKGnXMrw==@lists.infradead.org
X-Gm-Message-State: APuU4Z+GNrIjfrZwEK9SSKFGchEUJPOu5JN3IpbASub8f/NIk/6wZZvS
	0Kt8SpGY1ht3f3g5bi/6hVgB5vE4UYoGSehu7Jkbxpuv3bT2dMpS0V5CWGUDF69d86o=
X-Gm-Gg: AYBFou3zO8yK18MbbU/vvUv91GfpdZNUM/2XBzIMCoy/q/C5z264A/K9yO12vLPuXKo
	pz4JGuBGKyiWUa7dfbA+32nJQ7NVr7LbbMtW0YyWAQLOjKrkDTfXC/obbR37QrmZWCWUaMs1MaX
	6Tn/GSOlSfZaAHjUNCQ+8a9pnUkF4gXyRYJwuaBYfLMBM8O8rtdISTNHjT3CKd3/T/chWBVn1VD
	b4Z9tpMX5OgILBtDyO6UdYlMoZZCgVsHADDZ6DUk7U1Su+S0uHuGK4QPU7P8yqSEkwJn2t1BjNJ
	JBHKNczhanEZW9Rk3jpcpr8aoVaLns95giqhqNS3DSIvpKa0ZsHxW1YPEBuS0Q2lYSd8UYxldhz
	OjmKAqmSpKEj/FEmewYpyMrIIKnQ+hkwQZu2Cpx4hCsU+SVp7kttPmEtF3fPodEi2Hxij68PCBn
	hAW7AtTfZH8dVjhAL3flXNOrOWaIGwB8ASwT/zSjVULXdv6xS0uBOlkR0omaft7hr2J/+zh0haS
	tezKXGj5uvRE2z3gNpir1PhJMidR12F/I8x6gTmtNPJwwJvDaeMmcR3YD3psduN758aUziBQswu
	zmuRQ4D0SF07H8f16Vuf8ATL4jAAQyHZgISKUdSKVdc5QMFXD77cXIwyRbZYEAaBTmpjt+gbM0/
	D
X-Received: by 2002:a05:6000:2f83:b0:48c:4553:790b with SMTP id ffacd0b85a97d-4927fb63ecfmr790286f8f.48.1793907274442;
        Thu, 05 Nov 2026 11:34:34 -0800 (PST)
Received: from stjepan-Aspire-F5-573G.tailc0f20e.ts.net ([2a00:1bb8:118:d39e:452b:db14:9bf:f8a8])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48fea18104bsm12092866f8f.6.2026.11.05.11.34.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 11:34:33 -0800 (PST)
From: Stjepan Poljak <stjepan.poljak@gmail.com>
To: "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowangio@gmail.com>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Cornelia Huck <cohuck@redhat.com>,
	Halil Pasic <pasic@linux.ibm.com>,
	Eric Farman <farman@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Alexander Graf <graf@amazon.com>,
	virtualization@lists.linux.dev,
	linux-um@lists.infradead.org,
	linux-s390@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] virtio_ring: return an error pointer from vring_create_virtqueue()
Date: Thu,  5 Nov 2026 20:34:25 +0100
Message-ID: <20261105193426.2999631-1-stjepan.poljak@gmail.com>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261105_113441_776056_5183AA23 
X-CRM114-Status: GOOD (  19.87  )
X-Spam-Score: -2.1 (--)
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

vring_create_virtqueue() and vring_create_virtqueue_map() return NULL
on any failure, so the error returned from vring_alloc_queue_split()
is lost and turned into -ENOMEM. This is especially misleading if
vring_alloc_queue_split() rejects a queue size with -EINVAL (i.e. if
queue size is not a power of two):

  virtio_blk virtio0: Bad virtqueue length 100
  virtio_blk virtio0: probe with driver virtio_blk failed with error -12

So the error points whoever debugs it at an allocation failure that
never happened.

Return an ERR_PTR() instead: the error from vring_alloc_queue_split()
or vring_alloc_queue_packed(), or -ENOMEM when allocating the
virtqueue itself fails. Make the callers, virtio_pci (modern and
legacy), virtio_mmio, virtio_vdpa, virtio_ccw and virtio_uml, check
with IS_ERR() and pass the error on. The error path in virtio_ccw
deletes a non-NULL vq, so clear vq there before taking it.

Co-Authored-By: Claude Opus 5.5 <noreply@anthropic.com>
Signed-off-by: Stjepan Poljak <stjepan.poljak@gmail.com>
---
Tested on x86_64 with a virtio-mmio virtio-blk device offering a
100-entry queue: the probe now fails with -22 instead of -12, and a
128-entry queue probes as before. The other transports are only
compile-tested (x86_64, ARCH=um, s390 with clang, W=1).

No Fixes: tag, since the error has been -ENOMEM since 2010 and nothing
regressed.

This conflicts trivially with patch 07/12 of Alexander Graf's "virtio:
support devices that own their virtqueue memory" v2:
https://lore.kernel.org/virtualization/20260818211425.91009-1-graf@amazon.com/
---
 arch/um/drivers/virtio_uml.c       |  4 ++--
 drivers/s390/virtio/virtio_ccw.c   |  5 +++--
 drivers/virtio/virtio_mmio.c       |  4 ++--
 drivers/virtio/virtio_pci_legacy.c |  4 ++--
 drivers/virtio/virtio_pci_modern.c |  4 ++--
 drivers/virtio/virtio_ring.c       | 12 +++++++-----
 drivers/virtio/virtio_vdpa.c       |  4 ++--
 include/linux/virtio_ring.h        |  6 +++++-
 8 files changed, 25 insertions(+), 18 deletions(-)

diff --git a/arch/um/drivers/virtio_uml.c b/arch/um/drivers/virtio_uml.c
index 881c34098a74..8b645523277f 100644
--- a/arch/um/drivers/virtio_uml.c
+++ b/arch/um/drivers/virtio_uml.c
@@ -984,8 +984,8 @@ static struct virtqueue *vu_setup_vq(struct virtio_device *vdev,
 
 	vq = vring_create_virtqueue(index, num, PAGE_SIZE, vdev, true, true,
 				    ctx, vu_notify, callback, info->name);
-	if (!vq) {
-		rc = -ENOMEM;
+	if (IS_ERR(vq)) {
+		rc = PTR_ERR(vq);
 		goto error_create;
 	}
 	vq->priv = info;
diff --git a/drivers/s390/virtio/virtio_ccw.c b/drivers/s390/virtio/virtio_ccw.c
index 552d77998012..c5a30f0a2bc2 100644
--- a/drivers/s390/virtio/virtio_ccw.c
+++ b/drivers/s390/virtio/virtio_ccw.c
@@ -590,10 +590,11 @@ static struct virtqueue *virtio_ccw_setup_vq(struct virtio_device *vdev,
 				    vdev, true, may_reduce, ctx,
 				    notify, callback, name);
 
-	if (!vq) {
+	if (IS_ERR(vq)) {
 		/* For now, we fail if we can't get the requested size. */
 		dev_warn(&vcdev->cdev->dev, "no vq\n");
-		err = -ENOMEM;
+		err = PTR_ERR(vq);
+		vq = NULL;
 		goto out_err;
 	}
 
diff --git a/drivers/virtio/virtio_mmio.c b/drivers/virtio/virtio_mmio.c
index e2ec0ec01d67..c403a025006e 100644
--- a/drivers/virtio/virtio_mmio.c
+++ b/drivers/virtio/virtio_mmio.c
@@ -396,8 +396,8 @@ static struct virtqueue *vm_setup_vq(struct virtio_device *vdev, unsigned int in
 	/* Create the vring */
 	vq = vring_create_virtqueue(index, num, VIRTIO_MMIO_VRING_ALIGN, vdev,
 				 true, true, ctx, notify, callback, name);
-	if (!vq) {
-		err = -ENOMEM;
+	if (IS_ERR(vq)) {
+		err = PTR_ERR(vq);
 		goto error_new_virtqueue;
 	}
 
diff --git a/drivers/virtio/virtio_pci_legacy.c b/drivers/virtio/virtio_pci_legacy.c
index 8115aa39e01e..9d94fffff344 100644
--- a/drivers/virtio/virtio_pci_legacy.c
+++ b/drivers/virtio/virtio_pci_legacy.c
@@ -130,8 +130,8 @@ static struct virtqueue *setup_vq(struct virtio_pci_device *vp_dev,
 				    VIRTIO_PCI_VRING_ALIGN, &vp_dev->vdev,
 				    true, false, ctx,
 				    vp_notify, callback, name);
-	if (!vq)
-		return ERR_PTR(-ENOMEM);
+	if (IS_ERR(vq))
+		return vq;
 
 	vq->num_max = num;
 
diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
index 922e2df027de..28ccb2130e27 100644
--- a/drivers/virtio/virtio_pci_modern.c
+++ b/drivers/virtio/virtio_pci_modern.c
@@ -720,8 +720,8 @@ static struct virtqueue *setup_vq(struct virtio_pci_device *vp_dev,
 				    SMP_CACHE_BYTES, &vp_dev->vdev,
 				    true, true, ctx,
 				    notify, callback, name);
-	if (!vq)
-		return ERR_PTR(-ENOMEM);
+	if (IS_ERR(vq))
+		return vq;
 
 	vq->num_max = num;
 
diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index f683a2d6a200..6dd4a7651bde 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -1421,13 +1421,13 @@ static struct virtqueue *vring_create_virtqueue_split(
 	err = vring_alloc_queue_split(&vring_split, vdev, num, vring_align,
 				      may_reduce_num, map);
 	if (err)
-		return NULL;
+		return ERR_PTR(err);
 
 	vq = __vring_new_virtqueue_split(index, &vring_split, vdev, weak_barriers,
 				   context, notify, callback, name, map);
 	if (!vq) {
 		vring_free_split(&vring_split, vdev, map);
-		return NULL;
+		return ERR_PTR(-ENOMEM);
 	}
 
 	to_vvq(vq)->we_own_ring = true;
@@ -2671,15 +2671,17 @@ static struct virtqueue *vring_create_virtqueue_packed(
 {
 	struct vring_virtqueue_packed vring_packed = {};
 	struct virtqueue *vq;
+	int err;
 
-	if (vring_alloc_queue_packed(&vring_packed, vdev, num, map))
-		return NULL;
+	err = vring_alloc_queue_packed(&vring_packed, vdev, num, map);
+	if (err)
+		return ERR_PTR(err);
 
 	vq = __vring_new_virtqueue_packed(index, &vring_packed, vdev, weak_barriers,
 					context, notify, callback, name, map);
 	if (!vq) {
 		vring_free_packed(&vring_packed, vdev, map);
-		return NULL;
+		return ERR_PTR(-ENOMEM);
 	}
 
 	to_vvq(vq)->we_own_ring = true;
diff --git a/drivers/virtio/virtio_vdpa.c b/drivers/virtio/virtio_vdpa.c
index f9559b6b2e0b..c1b6134b2267 100644
--- a/drivers/virtio/virtio_vdpa.c
+++ b/drivers/virtio/virtio_vdpa.c
@@ -208,8 +208,8 @@ virtio_vdpa_setup_vq(struct virtio_device *vdev, unsigned int index,
 	vq = vring_create_virtqueue_map(index, max_num, align, vdev,
 					true, may_reduce_num, ctx,
 					notify, callback, name, map);
-	if (!vq) {
-		err = -ENOMEM;
+	if (IS_ERR(vq)) {
+		err = PTR_ERR(vq);
 		goto error_new_virtqueue;
 	}
 
diff --git a/include/linux/virtio_ring.h b/include/linux/virtio_ring.h
index c97a12c1cda3..c808ca7e8d58 100644
--- a/include/linux/virtio_ring.h
+++ b/include/linux/virtio_ring.h
@@ -66,6 +66,9 @@ struct device;
  * may_reduce_num is set, then this may allocate a smaller ring than
  * expected.  The caller should query virtqueue_get_vring_size to learn
  * the actual size of the ring.
+ *
+ * Returns the virtqueue or an ERR_PTR() on failure: -EINVAL if num is
+ * not a valid ring size, -ENOMEM if the ring could not be allocated.
  */
 struct virtqueue *vring_create_virtqueue(unsigned int index,
 					 unsigned int num,
@@ -80,7 +83,8 @@ struct virtqueue *vring_create_virtqueue(unsigned int index,
 
 /*
  * Creates a virtqueue and allocates the descriptor ring with per
- * virtqueue mapping operations.
+ * virtqueue mapping operations.  Returns the virtqueue or an ERR_PTR()
+ * on failure, like vring_create_virtqueue().
  */
 struct virtqueue *vring_create_virtqueue_map(unsigned int index,
 					     unsigned int num,

base-commit: 1a577f9402c1780cc1e663f48d5dd54c02051b09
-- 
2.53.0


