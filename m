Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nRZ47-004NJ0-OI
 for linux-um@lists.infradead.org; Tue, 08 Mar 2022 12:35:49 +0000
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: [PATCH v7 11/26] virtio_ring: introduce virtqueue_reset_vring()
Date: Tue,  8 Mar 2022 20:35:03 +0800
Message-Id: <20220308123518.33800-12-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20220308123518.33800-1-xuanzhuo@linux.alibaba.com>
References: <20220308123518.33800-1-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
Cc: Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Hans de Goede <hdegoede@redhat.com>, Mark Gross <markgross@kernel.org>, Vadim Pasternak <vadimp@nvidia.com>, Bjorn Andersson <bjorn.andersson@linaro.org>, Mathieu Poirier <mathieu.poirier@linaro.org>, Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, Johannes Berg <johannes.berg@intel.com>, Vincent Whitchurch <vincent.whitchurch@axis.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, linux-um@lists.infradead.org, platform-driver-x86@vger.kernel.org, linux-remoteproc@vger.kernel.org, linux-s390@vger.kernel.org, kvm@vger.kernel.org, bpf@vger.kernel.org

Introduce virtqueue_reset_vring() to implement the reset of vring during
the reset process.

If num is equal to 0 or equal to the original ring num, the original vring
will be used directly. The vring will not be reallocated. Otherwise, the
original vring will be released, and the vring will be re-allocated
based on num.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/virtio/virtio_ring.c | 30 ++++++++++++++++++++++++++++++
 include/linux/virtio.h       |  2 ++
 2 files changed, 32 insertions(+)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 5afcbabcfb1e..bbff9ba53f80 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -2534,6 +2534,36 @@ struct virtqueue *vring_create_virtqueue(
 }
 EXPORT_SYMBOL_GPL(vring_create_virtqueue);
 
+/**
+ * virtqueue_reset_vring - reset the vring of vq
+ * @vq: the struct virtqueue we're talking about.
+ * @num: new ring num
+ *
+ * If num is equal to 0 or equal to the original ring num, the original vring
+ * will be used directly. The vring will not be reallocated. Otherwise, the
+ * original vring will be released, and the vring will be re-allocated based on
+ * num.
+ *
+ * This function must be called after virtio_reset_vq(). For more information on
+ * vq reset see the description of virtio_reset_vq().
+ *
+ *
+ * Caller must ensure we don't call this with other virtqueue operations
+ * at the same time (except where noted).
+ *
+ * Returns zero or a negative error.
+ */
+int virtqueue_reset_vring(struct virtqueue *vq, u32 num)
+{
+	struct virtio_device *vdev = vq->vdev;
+
+	if (virtio_has_feature(vdev, VIRTIO_F_RING_PACKED))
+		return virtqueue_reset_vring_packed(vq, num);
+
+	return virtqueue_reset_vring_split(vq, num);
+}
+EXPORT_SYMBOL_GPL(virtqueue_reset_vring);
+
 /* Only available for split ring */
 struct virtqueue *vring_new_virtqueue(unsigned int index,
 				      unsigned int num,
diff --git a/include/linux/virtio.h b/include/linux/virtio.h
index e3714e6db330..7bf29f9e7491 100644
--- a/include/linux/virtio.h
+++ b/include/linux/virtio.h
@@ -99,6 +99,8 @@ dma_addr_t virtqueue_get_desc_addr(struct virtqueue *vq);
 dma_addr_t virtqueue_get_avail_addr(struct virtqueue *vq);
 dma_addr_t virtqueue_get_used_addr(struct virtqueue *vq);
 
+int virtqueue_reset_vring(struct virtqueue *vq, u32 num);
+
 /**
  * virtio_device - representation of a device using virtio
  * @index: unique position on the virtio bus
-- 
2.31.0


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

