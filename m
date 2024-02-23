Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41406C48BC4
	for <linux-um@archiver.kernel.org>; Fri, 23 Feb 2024 08:32:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=d8VgurjiHoufBNHjBHr2ztXStBXU+RItFeIKBycQigI=; b=38xBvoLvujI0r9j8eHxsuhtQaQ
	PjBP9ucLlyWZ5PYGEfRrd24DLnFDJCLwMpz1dvM2sfBtqooG968ZEsi57Lnx+A7tnscj2PGp7bnxK
	NA23/2YduJ3Vkld/me0AklHGzgTN8wKInimWXZmc+q+AP6Dwcyh4iFQkfuM1ePDFI6nw2WwqztqBj
	FaUp45ru/CMqO6Gg8f55raezLgrVawoqyZo1jox+Qt0PdHxclj0EJrRKRhxlLfQYEG/ZTAayS+9Z+
	wqweXuKzIueCHVpSj5RIVXKk8C3FDxXesGkMzoiTjgxmFKQ5P7+lRDM1QuE557qEYZI81xbZJNnOy
	kQcGcSYQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rdQyX-00000008UV1-0FIQ;
	Fri, 23 Feb 2024 08:32:09 +0000
Received: from out199-4.us.a.mail.aliyun.com ([47.90.199.4])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rdQub-00000008TIn-0jvz
	for linux-um@lists.infradead.org;
	Fri, 23 Feb 2024 08:28:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1708676874; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=d8VgurjiHoufBNHjBHr2ztXStBXU+RItFeIKBycQigI=;
	b=k2jgJx0wTKh22ktOdbDtoHvLiNlH2OR1X3oXOr142XHFAX3d6XsvfTuAwyIfdKTQGlSPlrkwpumDtp9Gldfl8C7Yb95G1bZ5nQ46IAx/ZpD6pfoQL9n/tYR8bVje0FAS9IvaWEC47NHJv0/mTFi3zFyiRGKpvIWLTfv/IB1WSWQ=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=35;SR=0;TI=SMTPD_---0W13gVCV_1708676871;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W13gVCV_1708676871)
          by smtp.aliyun-inc.com;
          Fri, 23 Feb 2024 16:27:52 +0800
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
Subject: [PATCH vhost v2 16/19] virtio_ring: introduce virtqueue_dma_map_sg_attrs
Date: Fri, 23 Feb 2024 16:27:23 +0800
Message-Id: <20240223082726.52915-17-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20240223082726.52915-1-xuanzhuo@linux.alibaba.com>
References: <20240223082726.52915-1-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
X-Git-Hash: 510995f33855
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240223_002806_982613_77726429 
X-CRM114-Status: GOOD (  10.23  )
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

Introduce a helper to do dma map for scatterlist.
That can be used by other drivers.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/virtio/virtio_ring.c | 32 ++++++++++++++++++++++++++++++++
 include/linux/virtio.h       |  3 +++
 2 files changed, 35 insertions(+)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index df7633155558..3f790fa3d56a 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -3187,6 +3187,38 @@ int virtqueue_dma_mapping_error(struct virtqueue *_vq, dma_addr_t addr)
 }
 EXPORT_SYMBOL_GPL(virtqueue_dma_mapping_error);
 
+/**
+ * virtqueue_dma_map_sg_attrs - map scatterlist addr DMA for _vq
+ * @_vq: the struct virtqueue we're talking about.
+ * @sg: the scatterlist to do dma
+ * @dir: DMA direction
+ * @attrs: DMA Attrs
+ *
+ * The caller calls this to do dma mapping in advance. The sg can be
+ * passed to this _vq when it is in pre-mapped mode.
+ *
+ * Returns zero or a negative error.
+ *   0: success
+ *   -ENOMEM: dma map error
+ */
+int virtqueue_dma_map_sg_attrs(struct virtqueue *_vq, struct scatterlist *sg,
+			       enum dma_data_direction dir, unsigned long attrs)
+{
+	dma_addr_t addr;
+	int err;
+
+	addr = virtqueue_dma_map_page_attrs(_vq, sg_page(sg), sg->offset,
+					    sg->length, dir, attrs);
+	err = virtqueue_dma_mapping_error(_vq, addr);
+	if (err)
+		return err;
+
+	sg->dma_address = addr;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(virtqueue_dma_map_sg_attrs);
+
 /**
  * virtqueue_dma_need_sync - check a dma address needs sync
  * @_vq: the struct virtqueue we're talking about.
diff --git a/include/linux/virtio.h b/include/linux/virtio.h
index b81b93b3eb27..5027eba82fda 100644
--- a/include/linux/virtio.h
+++ b/include/linux/virtio.h
@@ -233,6 +233,9 @@ void virtqueue_dma_unmap_page_attrs(struct virtqueue *_vq, dma_addr_t addr,
 				    unsigned long attrs);
 int virtqueue_dma_mapping_error(struct virtqueue *_vq, dma_addr_t addr);
 
+int virtqueue_dma_map_sg_attrs(struct virtqueue *_vq, struct scatterlist *sg,
+			       enum dma_data_direction dir, unsigned long attrs);
+
 bool virtqueue_dma_need_sync(struct virtqueue *_vq, dma_addr_t addr);
 void virtqueue_dma_sync_single_range_for_cpu(struct virtqueue *_vq, dma_addr_t addr,
 					     unsigned long offset, size_t size,
-- 
2.32.0.3.g01195cf9f


