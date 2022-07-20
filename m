Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from out30-57.freemail.mail.aliyun.com ([115.124.30.57])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oE01q-00HEv8-TI
	for linux-um@lists.infradead.org; Wed, 20 Jul 2022 03:05:40 +0000
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: [PATCH v12 22/40] virtio_ring: introduce virtqueue_resize()
Date: Wed, 20 Jul 2022 11:04:18 +0800
Message-Id: <20220720030436.79520-23-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20220720030436.79520-1-xuanzhuo@linux.alibaba.com>
References: <20220720030436.79520-1-xuanzhuo@linux.alibaba.com>
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
To: virtualization@lists.linux-foundation.org
Cc: Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Hans de Goede <hdegoede@redhat.com>, Mark Gross <markgross@kernel.org>, Vadim Pasternak <vadimp@nvidia.com>, Bjorn Andersson <bjorn.andersson@linaro.org>, Mathieu Poirier <mathieu.poirier@linaro.org>, Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Vincent Whitchurch <vincent.whitchurch@axis.com>, linux-um@lists.infradead.org, netdev@vger.kernel.org, platform-driver-x86@vger.kernel.org, linux-remoteproc@vger.kernel.org, linux-s390@vger.kernel.org, kvm@vger.kernel.org, bpf@vger.kernel.org, kangjie.xu@linux.alibaba.com

Introduce virtqueue_resize() to implement the resize of vring.
Based on these, the driver can dynamically adjust the size of the vring.
For example: ethtool -G.

virtqueue_resize() implements resize based on the vq reset function. In
case of failure to allocate a new vring, it will give up resize and use
the original vring.

During this process, if the re-enable reset vq fails, the vq can no
longer be used. Although the probability of this situation is not high.

The parameter recycle is used to recycle the buffer that is no longer
used.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/virtio/virtio_ring.c | 69 ++++++++++++++++++++++++++++++++++++
 include/linux/virtio.h       |  3 ++
 2 files changed, 72 insertions(+)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index b092914e9dcd..cf4379175163 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -2545,6 +2545,75 @@ struct virtqueue *vring_create_virtqueue(
 }
 EXPORT_SYMBOL_GPL(vring_create_virtqueue);
 
+/**
+ * virtqueue_resize - resize the vring of vq
+ * @_vq: the struct virtqueue we're talking about.
+ * @num: new ring num
+ * @recycle: callback for recycle the useless buffer
+ *
+ * When it is really necessary to create a new vring, it will set the current vq
+ * into the reset state. Then call the passed callback to recycle the buffer
+ * that is no longer used. Only after the new vring is successfully created, the
+ * old vring will be released.
+ *
+ * Caller must ensure we don't call this with other virtqueue operations
+ * at the same time (except where noted).
+ *
+ * Returns zero or a negative error.
+ * 0: success.
+ * -ENOMEM: Failed to allocate a new ring, fall back to the original ring size.
+ *  vq can still work normally
+ * -EBUSY: Failed to sync with device, vq may not work properly
+ * -ENOENT: Transport or device not supported
+ * -E2BIG/-EINVAL: num error
+ * -EPERM: Operation not permitted
+ *
+ */
+int virtqueue_resize(struct virtqueue *_vq, u32 num,
+		     void (*recycle)(struct virtqueue *vq, void *buf))
+{
+	struct vring_virtqueue *vq = to_vvq(_vq);
+	struct virtio_device *vdev = vq->vq.vdev;
+	void *buf;
+	int err;
+
+	if (!vq->we_own_ring)
+		return -EPERM;
+
+	if (num > vq->vq.num_max)
+		return -E2BIG;
+
+	if (!num)
+		return -EINVAL;
+
+	if ((vq->packed_ring ? vq->packed.vring.num : vq->split.vring.num) == num)
+		return 0;
+
+	if (!vdev->config->disable_vq_and_reset)
+		return -ENOENT;
+
+	if (!vdev->config->enable_vq_after_reset)
+		return -ENOENT;
+
+	err = vdev->config->disable_vq_and_reset(_vq);
+	if (err)
+		return err;
+
+	while ((buf = virtqueue_detach_unused_buf(_vq)) != NULL)
+		recycle(_vq, buf);
+
+	if (vq->packed_ring)
+		err = virtqueue_resize_packed(_vq, num);
+	else
+		err = virtqueue_resize_split(_vq, num);
+
+	if (vdev->config->enable_vq_after_reset(_vq))
+		return -EBUSY;
+
+	return err;
+}
+EXPORT_SYMBOL_GPL(virtqueue_resize);
+
 /* Only available for split ring */
 struct virtqueue *vring_new_virtqueue(unsigned int index,
 				      unsigned int num,
diff --git a/include/linux/virtio.h b/include/linux/virtio.h
index 129bde7521e3..62e31bca5602 100644
--- a/include/linux/virtio.h
+++ b/include/linux/virtio.h
@@ -91,6 +91,9 @@ dma_addr_t virtqueue_get_desc_addr(struct virtqueue *vq);
 dma_addr_t virtqueue_get_avail_addr(struct virtqueue *vq);
 dma_addr_t virtqueue_get_used_addr(struct virtqueue *vq);
 
+int virtqueue_resize(struct virtqueue *vq, u32 num,
+		     void (*recycle)(struct virtqueue *vq, void *buf));
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

