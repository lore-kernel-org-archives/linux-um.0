Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55D8FC4828E
	for <linux-um@archiver.kernel.org>; Fri,  2 Feb 2024 09:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XwxucoBJyXK5Ypckln3RBEEy/W277PjCTbn/Ba+xv6k=; b=iJi6yrlkTgA2TldyZMW3wVVBzo
	5WGhKtAM3t6pDCFKrOb2CpwoUV7Jg/UbpfaU5hWdHc+K12vC5SCCdxfPhoqH13BtTk2mWzis/07XB
	Kh+Yxf1/yyLtpuSUJEvCLCbpUJLsqh7kKDoet9Pcxz6vZqgZhoHxO+srRqqrFRms+Jwpydg8XcG63
	TRmIr6M3SSQisiQrqBTQeqFJqEraJeo2+AwZRBqD8C+PB9j++mecoLeBIn/lmcDlcCMiHCWCl6Kkd
	MXL3prSzmaEliY24B5o6OfuCC5Mq9vcA/P5+PJ4i35XSe2xa1WY77bmYcSslsHHqGvDT42bQWgr1/
	jytpy9nw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rVq23-0000000B0cf-27fE;
	Fri, 02 Feb 2024 09:40:23 +0000
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rVq1y-0000000B0X9-42zN
	for linux-um@lists.infradead.org;
	Fri, 02 Feb 2024 09:40:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1706866817; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=XwxucoBJyXK5Ypckln3RBEEy/W277PjCTbn/Ba+xv6k=;
	b=LSHUT5JXs5VeQytMMY+PsPBEvYVfLeFC/DVej07CdXxVUGTsOrj+V95gGEAyyg4ldwXNd0gXkvc35IGbZ9XOml+1i3smN88ko7nmY/YLX201C0qgiR/oPusaLyL3BVUtL1EgKdDAoNTtejzte8HGV8UonacZmTZasIZ7QBK3AZI=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R471e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=36;SR=0;TI=SMTPD_---0W.wdbkN_1706866814;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W.wdbkN_1706866814)
          by smtp.aliyun-inc.com;
          Fri, 02 Feb 2024 17:40:15 +0800
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
Subject: [PATCH vhost v1 14/19] virtio_ring: remove api of setting vq premapped
Date: Fri,  2 Feb 2024 17:39:46 +0800
Message-Id: <20240202093951.120283-15-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20240202093951.120283-1-xuanzhuo@linux.alibaba.com>
References: <20240202093951.120283-1-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
X-Git-Hash: 4c7bacd05cb8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240202_014019_320052_22AC5865 
X-CRM114-Status: GOOD (  11.81  )
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

The virtio-net sets the premapped mode by find_vqs().

So the below API is not used by anyone, we remove it.

int virtqueue_set_dma_premapped(struct virtqueue *_vq);

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/virtio/virtio_ring.c | 56 ------------------------------------
 include/linux/virtio.h       |  2 --
 2 files changed, 58 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 4a5e54fdbf54..57b669180e6e 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -2775,62 +2775,6 @@ int virtqueue_resize(struct virtqueue *_vq, u32 num,
 }
 EXPORT_SYMBOL_GPL(virtqueue_resize);
 
-/**
- * virtqueue_set_dma_premapped - set the vring premapped mode
- * @_vq: the struct virtqueue we're talking about.
- *
- * Enable the premapped mode of the vq.
- *
- * The vring in premapped mode does not do dma internally, so the driver must
- * do dma mapping in advance. The driver must pass the dma_address through
- * dma_address of scatterlist. When the driver got a used buffer from
- * the vring, it has to unmap the dma address.
- *
- * This function must be called immediately after creating the vq, or after vq
- * reset, and before adding any buffers to it.
- *
- * Caller must ensure we don't call this with other virtqueue operations
- * at the same time (except where noted).
- *
- * Returns zero or a negative error.
- * 0: success.
- * -EINVAL: vring does not use the dma api, so we can not enable premapped mode.
- */
-int virtqueue_set_dma_premapped(struct virtqueue *_vq)
-{
-	struct vring_virtqueue *vq = to_vvq(_vq);
-	u32 num;
-
-	START_USE(vq);
-
-	num = vq->packed_ring ? vq->packed.vring.num : vq->split.vring.num;
-
-	if (num != vq->vq.num_free) {
-		END_USE(vq);
-		return -EINVAL;
-	}
-
-	if (!vq->use_dma_api) {
-		END_USE(vq);
-		return -EINVAL;
-	}
-
-	vq->vq.premapped = true;
-
-	if (vq->packed_ring) {
-		kfree(vq->packed.desc_dma);
-		vq->packed.desc_dma = NULL;
-	} else {
-		kfree(vq->split.desc_dma);
-		vq->split.desc_dma = NULL;
-	}
-
-	END_USE(vq);
-
-	return 0;
-}
-EXPORT_SYMBOL_GPL(virtqueue_set_dma_premapped);
-
 /**
  * virtqueue_reset - detach and recycle all unused buffers
  * @_vq: the struct virtqueue we're talking about.
diff --git a/include/linux/virtio.h b/include/linux/virtio.h
index 37ba44dc34de..7f16bacc6c49 100644
--- a/include/linux/virtio.h
+++ b/include/linux/virtio.h
@@ -82,8 +82,6 @@ bool virtqueue_enable_cb(struct virtqueue *vq);
 
 unsigned virtqueue_enable_cb_prepare(struct virtqueue *vq);
 
-int virtqueue_set_dma_premapped(struct virtqueue *_vq);
-
 bool virtqueue_poll(struct virtqueue *vq, unsigned);
 
 bool virtqueue_enable_cb_delayed(struct virtqueue *vq);
-- 
2.32.0.3.g01195cf9f


