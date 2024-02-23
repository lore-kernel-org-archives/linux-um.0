Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45E0AC54E4C
	for <linux-um@archiver.kernel.org>; Fri, 23 Feb 2024 09:34:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MiRsah0os+XN0E37SyZpCu/ggHFN/seKkb4xKfCwkhI=; b=UudqerQA972xyikWSomvfpCJpF
	VoVeiqVlX8ZkWrIV77H4HGp2Jf/RaFZ/9526FTpTBl5vV3BHULaDVvvmPoBTtRBmADslsDVK6rnzN
	/wusM/l61v+vo11XQu3gyoLn4ujDtqR1tINWHh+Ye3ieksbIMLtet/GfkAITa9WwrkXTPF/8w6w0i
	D9C3GbaQcHDsi0MwVt6QyYTL3Ib6DhRD7DJYouTv52BG6DhqwA+0IV7OQBcZdGiDgbYCw9UpBk95Y
	1y9PfYdDGom6ECuMLMZP5RJLZXx7BusR81lvHnFFgIcauFPzTMJvc2iwL2w7qOIWg+eeoFRwH8vO1
	6RQHXzPg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rdRxG-00000008hAu-3VhU;
	Fri, 23 Feb 2024 09:34:54 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rdQup-00000008TOQ-36oV
	for linux-um@bombadil.infradead.org;
	Fri, 23 Feb 2024 08:28:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=MiRsah0os+XN0E37SyZpCu/ggHFN/seKkb4xKfCwkhI=; b=ZHuIbWXHgD5sZCi+flO09YSXue
	5wlXx1xT0JKr8LqRP2JEtU3CIB7v/8pHxY56Fme/O89uN+/GrwuElH2avTJ0ZCcBCWLuxxPOtLpqV
	hNNoKSAfbECg0SelPGr/KudAI0dJKnYfAVxMg2DAojd4BQoKfnkP3IuyC9OwH060UIgfQcjwFfJlF
	XiD2stgaXiFMJ4tDEz/8VzWJRzAtHB5Ylq1WZ/f0k3xviK+88Imv+J8Tb1t5u+IoJ7g3E3Ss4lMbi
	KoYu6jDiQkRpvMAbyqxNcWtessxaVGIy4OFPLsfcObaadXyZ2D2EtqQksB1m4nVzaoxV8Bu4CC0qa
	9NXCIAkg==;
Received: from out30-98.freemail.mail.aliyun.com ([115.124.30.98])
	by casper.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rdQum-00000006KQw-0V78
	for linux-um@lists.infradead.org;
	Fri, 23 Feb 2024 08:28:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1708676871; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=MiRsah0os+XN0E37SyZpCu/ggHFN/seKkb4xKfCwkhI=;
	b=Vd1txi/BsfWyOKPzhDmvnRZig/M/KQkwWQgdC6ujUvXYuz+Kn+PKB2zG/o5Rgrs4TbhKWc3uSGN+qDIfTgZb3lWZdbViXkvd0PHDDAq9FA2YLhKKlAd7T7WEYslSB9aW38S16vQ9p5qYqEpYhFVrYCY6Q5IlwIF5hMD7q6A+rQw=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R211e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=35;SR=0;TI=SMTPD_---0W13ndPZ_1708676868;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W13ndPZ_1708676868)
          by smtp.aliyun-inc.com;
          Fri, 23 Feb 2024 16:27:49 +0800
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
	linux-um@lists.infradead.org,
	netdev@vger.kernel.org,
	platform-driver-x86@vger.kernel.org,
	linux-remoteproc@vger.kernel.org,
	linux-s390@vger.kernel.org,
	kvm@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH vhost v2 14/19] virtio_ring: remove api of setting vq premapped
Date: Fri, 23 Feb 2024 16:27:21 +0800
Message-Id: <20240223082726.52915-15-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20240223082726.52915-1-xuanzhuo@linux.alibaba.com>
References: <20240223082726.52915-1-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
X-Git-Hash: 510995f33855
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240223_082816_716037_966DF8FF 
X-CRM114-Status: GOOD (  11.14  )
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
index 103b06574e8b..63084487c171 100644
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
index 407277d5a16b..2167893313f6 100644
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


