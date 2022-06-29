Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from out199-9.us.a.mail.aliyun.com ([47.90.199.9])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o6Rda-009wGF-RX
	for linux-um@lists.infradead.org; Wed, 29 Jun 2022 06:57:25 +0000
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: [PATCH v11 08/40] virtio_ring: split: extract the logic of alloc queue
Date: Wed, 29 Jun 2022 14:56:24 +0800
Message-Id: <20220629065656.54420-9-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20220629065656.54420-1-xuanzhuo@linux.alibaba.com>
References: <20220629065656.54420-1-xuanzhuo@linux.alibaba.com>
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

Separate the logic of split to create vring queue.

This feature is required for subsequent virtuqueue reset vring.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/virtio/virtio_ring.c | 68 ++++++++++++++++++++++--------------
 1 file changed, 42 insertions(+), 26 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 49d61e412dc6..a9ceb9c16c54 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -949,28 +949,19 @@ static void vring_free_split(struct vring_virtqueue_split *vring,
 	kfree(vring->desc_extra);
 }
 
-static struct virtqueue *vring_create_virtqueue_split(
-	unsigned int index,
-	unsigned int num,
-	unsigned int vring_align,
-	struct virtio_device *vdev,
-	bool weak_barriers,
-	bool may_reduce_num,
-	bool context,
-	bool (*notify)(struct virtqueue *),
-	void (*callback)(struct virtqueue *),
-	const char *name)
+static int vring_alloc_queue_split(struct vring_virtqueue_split *vring,
+				   struct virtio_device *vdev,
+				   u32 num,
+				   unsigned int vring_align,
+				   bool may_reduce_num)
 {
-	struct virtqueue *vq;
 	void *queue = NULL;
 	dma_addr_t dma_addr;
-	size_t queue_size_in_bytes;
-	struct vring vring;
 
 	/* We assume num is a power of 2. */
 	if (num & (num - 1)) {
 		dev_warn(&vdev->dev, "Bad virtqueue length %u\n", num);
-		return NULL;
+		return -EINVAL;
 	}
 
 	/* TODO: allocate each queue chunk individually */
@@ -981,11 +972,11 @@ static struct virtqueue *vring_create_virtqueue_split(
 		if (queue)
 			break;
 		if (!may_reduce_num)
-			return NULL;
+			return -ENOMEM;
 	}
 
 	if (!num)
-		return NULL;
+		return -ENOMEM;
 
 	if (!queue) {
 		/* Try to get a single page. You are my only hope! */
@@ -993,21 +984,46 @@ static struct virtqueue *vring_create_virtqueue_split(
 					  &dma_addr, GFP_KERNEL|__GFP_ZERO);
 	}
 	if (!queue)
-		return NULL;
+		return -ENOMEM;
+
+	vring_init(&vring->vring, num, queue, vring_align);
 
-	queue_size_in_bytes = vring_size(num, vring_align);
-	vring_init(&vring, num, queue, vring_align);
+	vring->queue_dma_addr = dma_addr;
+	vring->queue_size_in_bytes = vring_size(num, vring_align);
+
+	return 0;
+}
+
+static struct virtqueue *vring_create_virtqueue_split(
+	unsigned int index,
+	unsigned int num,
+	unsigned int vring_align,
+	struct virtio_device *vdev,
+	bool weak_barriers,
+	bool may_reduce_num,
+	bool context,
+	bool (*notify)(struct virtqueue *),
+	void (*callback)(struct virtqueue *),
+	const char *name)
+{
+	struct vring_virtqueue_split vring = {};
+	struct virtqueue *vq;
+	int err;
+
+	err = vring_alloc_queue_split(&vring, vdev, num, vring_align,
+				      may_reduce_num);
+	if (err)
+		return NULL;
 
-	vq = __vring_new_virtqueue(index, vring, vdev, weak_barriers, context,
-				   notify, callback, name);
+	vq = __vring_new_virtqueue(index, vring.vring, vdev, weak_barriers,
+				   context, notify, callback, name);
 	if (!vq) {
-		vring_free_queue(vdev, queue_size_in_bytes, queue,
-				 dma_addr);
+		vring_free_split(&vring, vdev);
 		return NULL;
 	}
 
-	to_vvq(vq)->split.queue_dma_addr = dma_addr;
-	to_vvq(vq)->split.queue_size_in_bytes = queue_size_in_bytes;
+	to_vvq(vq)->split.queue_dma_addr = vring.queue_dma_addr;
+	to_vvq(vq)->split.queue_size_in_bytes = vring.queue_size_in_bytes;
 	to_vvq(vq)->we_own_ring = true;
 
 	return vq;
-- 
2.31.0


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

