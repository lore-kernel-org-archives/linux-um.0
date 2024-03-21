Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28FDDC54E68
	for <linux-um@archiver.kernel.org>; Thu, 21 Mar 2024 10:15:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lH6yRQu7rtWhDlXmo5ZUucMUfKGjgQV9jTrLIwthFpw=; b=vbKd6vO0513/RpM0Jd12KXO5Wf
	cC29A9i2QCzCEVk9ISerWh85urKhNWfT0t0McqhMOWfu76Vn5rwgLyAzBUcSdPwBoV1WcQ2T05sSE
	f4vIcslbMF/30RZyTrqgg3Q1odZd6R+QoISoAhc1qPI1admE2SrDMUIOfJG+qowixbWcSQ2s9WSUM
	OAJVSdMrRkxa4wGI5Dq9107DMyMOkxu31a0wHXZK30P1TSpj1d7DJdtFl3hQ9IpMheo6Z4fxhc8aR
	PqKyoTxz4X485YpjWr5767qxWhx/UkTwdXh5jfPDwJAH9eLJT//vysnlJsWKTJ9cQ/yv26W16NM+W
	953tXc4A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rnFSn-00000002bVU-30bW;
	Thu, 21 Mar 2024 10:15:57 +0000
Received: from out30-119.freemail.mail.aliyun.com ([115.124.30.119])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rnFSh-00000002bPD-21xM
	for linux-um@lists.infradead.org;
	Thu, 21 Mar 2024 10:15:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1711016136; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=lH6yRQu7rtWhDlXmo5ZUucMUfKGjgQV9jTrLIwthFpw=;
	b=W1kwEgEvLYPaX0R12Rhq0+LwsVBrubAqoVOJLxK3PDF79ryHAC1u7tsNOJeFxdP5TUPTowJ6oL3XWRYCjhaKuIgVKqSEsURAmMlxI3f5uUF+WigVRyRU9siEhrF44nF5+9ordPw++o0lzuH37NBjRnsAtMa127jVsX2+XsN9XXM=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=26;SR=0;TI=SMTPD_---0W3-Ms4H_1711016134;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W3-Ms4H_1711016134)
          by smtp.aliyun-inc.com;
          Thu, 21 Mar 2024 18:15:34 +0800
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
Subject: [PATCH vhost v4 1/6] virtio_balloon: remove the dependence where names[] is null
Date: Thu, 21 Mar 2024 18:15:27 +0800
Message-Id: <20240321101532.59272-2-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20240321101532.59272-1-xuanzhuo@linux.alibaba.com>
References: <20240321101532.59272-1-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
X-Git-Hash: 571c18a30348
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240321_031551_694999_732377CF 
X-CRM114-Status: GOOD (  11.33  )
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

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/virtio/virtio_balloon.c | 41 +++++++++++++++------------------
 1 file changed, 19 insertions(+), 22 deletions(-)

diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
index 1f5b3dd31fcf..becc12a05407 100644
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -531,49 +531,46 @@ static int init_vqs(struct virtio_balloon *vb)
 	struct virtqueue *vqs[VIRTIO_BALLOON_VQ_MAX];
 	vq_callback_t *callbacks[VIRTIO_BALLOON_VQ_MAX];
 	const char *names[VIRTIO_BALLOON_VQ_MAX];
-	int err;
+	int err, nvqs, idx;
 
-	/*
-	 * Inflateq and deflateq are used unconditionally. The names[]
-	 * will be NULL if the related feature is not enabled, which will
-	 * cause no allocation for the corresponding virtqueue in find_vqs.
-	 */
 	callbacks[VIRTIO_BALLOON_VQ_INFLATE] = balloon_ack;
 	names[VIRTIO_BALLOON_VQ_INFLATE] = "inflate";
 	callbacks[VIRTIO_BALLOON_VQ_DEFLATE] = balloon_ack;
 	names[VIRTIO_BALLOON_VQ_DEFLATE] = "deflate";
-	callbacks[VIRTIO_BALLOON_VQ_STATS] = NULL;
-	names[VIRTIO_BALLOON_VQ_STATS] = NULL;
-	callbacks[VIRTIO_BALLOON_VQ_FREE_PAGE] = NULL;
-	names[VIRTIO_BALLOON_VQ_FREE_PAGE] = NULL;
-	names[VIRTIO_BALLOON_VQ_REPORTING] = NULL;
+
+	nvqs = VIRTIO_BALLOON_VQ_DEFLATE + 1;
 
 	if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_STATS_VQ)) {
-		names[VIRTIO_BALLOON_VQ_STATS] = "stats";
-		callbacks[VIRTIO_BALLOON_VQ_STATS] = stats_request;
+		names[nvqs] = "stats";
+		callbacks[nvqs] = stats_request;
+		++nvqs;
 	}
 
 	if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_FREE_PAGE_HINT)) {
-		names[VIRTIO_BALLOON_VQ_FREE_PAGE] = "free_page_vq";
-		callbacks[VIRTIO_BALLOON_VQ_FREE_PAGE] = NULL;
+		names[nvqs] = "free_page_vq";
+		callbacks[nvqs] = NULL;
+		++nvqs;
 	}
 
 	if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_REPORTING)) {
-		names[VIRTIO_BALLOON_VQ_REPORTING] = "reporting_vq";
-		callbacks[VIRTIO_BALLOON_VQ_REPORTING] = balloon_ack;
+		names[nvqs] = "reporting_vq";
+		callbacks[nvqs] = balloon_ack;
+		++nvqs;
 	}
 
-	err = virtio_find_vqs(vb->vdev, VIRTIO_BALLOON_VQ_MAX, vqs,
-			      callbacks, names, NULL);
+	err = virtio_find_vqs(vb->vdev, nvqs, vqs, callbacks, names, NULL);
 	if (err)
 		return err;
 
 	vb->inflate_vq = vqs[VIRTIO_BALLOON_VQ_INFLATE];
 	vb->deflate_vq = vqs[VIRTIO_BALLOON_VQ_DEFLATE];
+
+	idx = VIRTIO_BALLOON_VQ_DEFLATE + 1;
+
 	if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_STATS_VQ)) {
 		struct scatterlist sg;
 		unsigned int num_stats;
-		vb->stats_vq = vqs[VIRTIO_BALLOON_VQ_STATS];
+		vb->stats_vq = vqs[idx++];
 
 		/*
 		 * Prime this virtqueue with one buffer so the hypervisor can
@@ -593,10 +590,10 @@ static int init_vqs(struct virtio_balloon *vb)
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


