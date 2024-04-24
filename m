Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0145EC07E8E
	for <linux-um@archiver.kernel.org>; Wed, 24 Apr 2024 09:15:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uFRHL08YisCGy8GeaiyxV8AxhBzMdE8E0bvCSQlulIE=; b=D+hjtHISdBWTNPXkvnIsryZRu/
	bpdGp4xdW5Q3LzgGfM500xoBowpOMkNUh0ZXP5htkpgXdr2po7Hyao4lPLn93OEg4wV4vN8Z+B1KC
	nyuPKcutJC+Ze8p9gq1JLsX7ofPulul9iyKswWoNSRaxtAw07cD0wwyjOckS+zJV/LC5x0kweShld
	kEPb/bj2UbWxKvuFBlmvhem/V8vWT/nOHpDMDoxyyew9RuPoiUuGAwsq7FjGywvUcD3bhWh1txg2b
	T8RzcIX3ALO8TsPiIERsHqVIg/M/y/vj3RbTHNkFY5FyHKckjxzXDMThwMSIyEDI3as8Jm0Eec7q4
	2tvNS8tA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rzYjB-00000003STz-2hvD;
	Wed, 24 Apr 2024 09:15:45 +0000
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rzYj5-00000003SOW-3Kln
	for linux-um@lists.infradead.org;
	Wed, 24 Apr 2024 09:15:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1713950138; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=uFRHL08YisCGy8GeaiyxV8AxhBzMdE8E0bvCSQlulIE=;
	b=p8Wtd7t/fiFfJW3/r1rGvewytfET6d8FnC+JwjVLLejdOQjJx+EkmCKSaIyqWn2LZ0rFv4zjYyNqmYToVkEBRstuVzOcm8o4ZRylOinOyoLGwRp9r9lxAOEogGLuB9a9gyXNf5RNXNKcAvJBk7++ImK8Sr/7yz8LSHO+t90fYOQ=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R891e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045046011;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=26;SR=0;TI=SMTPD_---0W5BsEmw_1713950135;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W5BsEmw_1713950135)
          by smtp.aliyun-inc.com;
          Wed, 24 Apr 2024 17:15:36 +0800
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
Subject: [PATCH vhost v9 1/6] virtio_balloon: remove the dependence where names[] is null
Date: Wed, 24 Apr 2024 17:15:28 +0800
Message-Id: <20240424091533.86949-2-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20240424091533.86949-1-xuanzhuo@linux.alibaba.com>
References: <20240424091533.86949-1-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
X-Git-Hash: bdb00f35db89
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240424_021540_090356_2F981970 
X-CRM114-Status: GOOD (  13.82  )
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

Currently, the init_vqs function within the virtio_balloon driver relies
on the condition that certain names array entries are null in order to
skip the initialization of some virtual queues (vqs). This behavior is
unique to this part of the codebase. In an upcoming commit, we plan to
eliminate this dependency by removing the function entirely. Therefore,
with this change, we are ensuring that the virtio_balloon no longer
depends on the aforementioned function.

As specification 1.0-1.2, vq indexes should not be contiguous if some
vq does not exist. But currently the virtqueue index is contiguous for
all existing devices. The Linux kernel does not implement functionality
to allow vq indexes to be discontinuous. So the current behavior of the
virtio-balloon device is different for the spec. But this commit has no
functional changes.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Acked-by: David Hildenbrand <david@redhat.com>
Acked-by: Jason Wang <jasowang@redhat.com>
---
 drivers/virtio/virtio_balloon.c | 48 ++++++++++++++-------------------
 1 file changed, 20 insertions(+), 28 deletions(-)

diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
index c0a63638f95e..ccda6d08493f 100644
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -548,49 +548,41 @@ static int init_vqs(struct virtio_balloon *vb)
 	struct virtqueue *vqs[VIRTIO_BALLOON_VQ_MAX];
 	vq_callback_t *callbacks[VIRTIO_BALLOON_VQ_MAX];
 	const char *names[VIRTIO_BALLOON_VQ_MAX];
-	int err;
+	int err, idx = 0;
 
-	/*
-	 * Inflateq and deflateq are used unconditionally. The names[]
-	 * will be NULL if the related feature is not enabled, which will
-	 * cause no allocation for the corresponding virtqueue in find_vqs.
-	 */
-	callbacks[VIRTIO_BALLOON_VQ_INFLATE] = balloon_ack;
-	names[VIRTIO_BALLOON_VQ_INFLATE] = "inflate";
-	callbacks[VIRTIO_BALLOON_VQ_DEFLATE] = balloon_ack;
-	names[VIRTIO_BALLOON_VQ_DEFLATE] = "deflate";
-	callbacks[VIRTIO_BALLOON_VQ_STATS] = NULL;
-	names[VIRTIO_BALLOON_VQ_STATS] = NULL;
-	callbacks[VIRTIO_BALLOON_VQ_FREE_PAGE] = NULL;
-	names[VIRTIO_BALLOON_VQ_FREE_PAGE] = NULL;
-	names[VIRTIO_BALLOON_VQ_REPORTING] = NULL;
+	callbacks[idx] = balloon_ack;
+	names[idx++] = "inflate";
+	callbacks[idx] = balloon_ack;
+	names[idx++] = "deflate";
 
 	if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_STATS_VQ)) {
-		names[VIRTIO_BALLOON_VQ_STATS] = "stats";
-		callbacks[VIRTIO_BALLOON_VQ_STATS] = stats_request;
+		names[idx] = "stats";
+		callbacks[idx++] = stats_request;
 	}
 
 	if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_FREE_PAGE_HINT)) {
-		names[VIRTIO_BALLOON_VQ_FREE_PAGE] = "free_page_vq";
-		callbacks[VIRTIO_BALLOON_VQ_FREE_PAGE] = NULL;
+		names[idx] = "free_page_vq";
+		callbacks[idx++] = NULL;
 	}
 
 	if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_REPORTING)) {
-		names[VIRTIO_BALLOON_VQ_REPORTING] = "reporting_vq";
-		callbacks[VIRTIO_BALLOON_VQ_REPORTING] = balloon_ack;
+		names[idx] = "reporting_vq";
+		callbacks[idx++] = balloon_ack;
 	}
 
-	err = virtio_find_vqs(vb->vdev, VIRTIO_BALLOON_VQ_MAX, vqs,
-			      callbacks, names, NULL);
+	err = virtio_find_vqs(vb->vdev, idx, vqs, callbacks, names, NULL);
 	if (err)
 		return err;
 
-	vb->inflate_vq = vqs[VIRTIO_BALLOON_VQ_INFLATE];
-	vb->deflate_vq = vqs[VIRTIO_BALLOON_VQ_DEFLATE];
+	idx = 0;
+
+	vb->inflate_vq = vqs[idx++];
+	vb->deflate_vq = vqs[idx++];
+
 	if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_STATS_VQ)) {
 		struct scatterlist sg;
 		unsigned int num_stats;
-		vb->stats_vq = vqs[VIRTIO_BALLOON_VQ_STATS];
+		vb->stats_vq = vqs[idx++];
 
 		/*
 		 * Prime this virtqueue with one buffer so the hypervisor can
@@ -610,10 +602,10 @@ static int init_vqs(struct virtio_balloon *vb)
 	}
 
 	if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_FREE_PAGE_HINT))
-		vb->free_page_vq = vqs[VIRTIO_BALLOON_VQ_FREE_PAGE];
+		vb->free_page_vq = vqs[idx++];
 
 	if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_REPORTING))
-		vb->reporting_vq = vqs[VIRTIO_BALLOON_VQ_REPORTING];
+		vb->reporting_vq = vqs[idx++];
 
 	return 0;
 }
-- 
2.32.0.3.g01195cf9f


