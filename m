Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26A2AC54E58
	for <linux-um@archiver.kernel.org>; Mon, 25 Mar 2024 09:04:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zH1bfqG7iyJRLFrnYFbUd+K/XLbnQYfUsfT+La4OOPE=; b=0QIMi45ZtjlRchlL36qcKv0MjX
	yjZA2mCSHJBCdPPHUvLCw/4pFUquW1PDHh1ErVsJSudsjaXb2nwF0XMDI3BGbaArCWDj8I++Ejoyb
	psKfjK/El0ermV7h45wp+8Tec3lSKaj5zHuD9VJyAedQvdMHNeTqg8LkGROgysNwv0Rq9WXqKkM/N
	0mMIrRokZ4OPADGeejHtscXQRqffZygGYQKJ2cI59PVBK121f1ggbgX2Ql5QNhFroZhiXl/dvdf2p
	mdkbS/N3SzLcVM+pATI+cxLELP5Tvq4CN0N7Txadz/Yl8/LFNRP6O3GbNLmrUelLwDb2T0T8b6p/a
	DtrBwiVA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rogFt-0000000GKng-3ceI;
	Mon, 25 Mar 2024 09:04:34 +0000
Received: from out30-118.freemail.mail.aliyun.com ([115.124.30.118])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rogFn-0000000GKiZ-34Le
	for linux-um@lists.infradead.org;
	Mon, 25 Mar 2024 09:04:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1711357463; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=zH1bfqG7iyJRLFrnYFbUd+K/XLbnQYfUsfT+La4OOPE=;
	b=b99YLM9D8oE2D2XNZ1b8DS5PglAxoFY/zw8HSPp8VZ+vH+KX3KnlOggkll20yfFIL5ilNFPxghpuIi5y8go+3I0lqi0T+H/bS5Z5iJWeOiY7CAI3XnXsp285wRDvyA2tXRdtk8TcAz/ytssA24GcUcx0mwDT4MGz6zViPg70NIo=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R431e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=26;SR=0;TI=SMTPD_---0W3DW6on_1711357461;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W3DW6on_1711357461)
          by smtp.aliyun-inc.com;
          Mon, 25 Mar 2024 17:04:22 +0800
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
Subject: [PATCH vhost v5 1/6] virtio_balloon: remove the dependence where names[] is null
Date: Mon, 25 Mar 2024 17:04:14 +0800
Message-Id: <20240325090419.33677-2-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20240325090419.33677-1-xuanzhuo@linux.alibaba.com>
References: <20240325090419.33677-1-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
X-Git-Hash: f38b33f54e32
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240325_020428_448006_7FC02C08 
X-CRM114-Status: GOOD (  11.82  )
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
 drivers/virtio/virtio_balloon.c | 46 +++++++++++++--------------------
 1 file changed, 18 insertions(+), 28 deletions(-)

diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
index 1f5b3dd31fcf..8409642e54d7 100644
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -531,49 +531,39 @@ static int init_vqs(struct virtio_balloon *vb)
 	struct virtqueue *vqs[VIRTIO_BALLOON_VQ_MAX];
 	vq_callback_t *callbacks[VIRTIO_BALLOON_VQ_MAX];
 	const char *names[VIRTIO_BALLOON_VQ_MAX];
-	int err;
+	int err, nvqs = 0, idx = 0;
 
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
+	callbacks[nvqs] = balloon_ack;
+	names[nvqs++] = "inflate";
+	callbacks[nvqs] = balloon_ack;
+	names[nvqs++] = "deflate";
 
 	if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_STATS_VQ)) {
-		names[VIRTIO_BALLOON_VQ_STATS] = "stats";
-		callbacks[VIRTIO_BALLOON_VQ_STATS] = stats_request;
+		names[nvqs] = "stats";
+		callbacks[nvqs++] = stats_request;
 	}
 
 	if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_FREE_PAGE_HINT)) {
-		names[VIRTIO_BALLOON_VQ_FREE_PAGE] = "free_page_vq";
-		callbacks[VIRTIO_BALLOON_VQ_FREE_PAGE] = NULL;
+		names[nvqs] = "free_page_vq";
+		callbacks[nvqs++] = NULL;
 	}
 
 	if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_REPORTING)) {
-		names[VIRTIO_BALLOON_VQ_REPORTING] = "reporting_vq";
-		callbacks[VIRTIO_BALLOON_VQ_REPORTING] = balloon_ack;
+		names[nvqs] = "reporting_vq";
+		callbacks[nvqs++] = balloon_ack;
 	}
 
-	err = virtio_find_vqs(vb->vdev, VIRTIO_BALLOON_VQ_MAX, vqs,
-			      callbacks, names, NULL);
+	err = virtio_find_vqs(vb->vdev, nvqs, vqs, callbacks, names, NULL);
 	if (err)
 		return err;
 
-	vb->inflate_vq = vqs[VIRTIO_BALLOON_VQ_INFLATE];
-	vb->deflate_vq = vqs[VIRTIO_BALLOON_VQ_DEFLATE];
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
@@ -593,10 +583,10 @@ static int init_vqs(struct virtio_balloon *vb)
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


