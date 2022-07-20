Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oE01Y-00HEYc-S7
	for linux-um@lists.infradead.org; Wed, 20 Jul 2022 03:05:22 +0000
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: [PATCH v12 16/40] virtio_ring: packed: extract the logic of alloc queue
Date: Wed, 20 Jul 2022 11:04:12 +0800
Message-Id: <20220720030436.79520-17-xuanzhuo@linux.alibaba.com>
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

Separate the logic of packed to create vring queue.

For the convenience of passing parameters, add a structure
vring_packed.

This feature is required for subsequent virtuqueue reset vring.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/virtio/virtio_ring.c | 80 +++++++++++++++++++++++-------------
 1 file changed, 51 insertions(+), 29 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 207a2b57270c..a495f1cb7fe4 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -1854,19 +1854,10 @@ static void vring_free_packed(struct vring_virtqueue_packed *vring_packed,
 	kfree(vring_packed->desc_extra);
 }
 
-static struct virtqueue *vring_create_virtqueue_packed(
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
+static int vring_alloc_queue_packed(struct vring_virtqueue_packed *vring_packed,
+				    struct virtio_device *vdev,
+				    u32 num)
 {
-	struct vring_virtqueue *vq;
 	struct vring_packed_desc *ring;
 	struct vring_packed_desc_event *driver, *device;
 	dma_addr_t ring_dma_addr, driver_event_dma_addr, device_event_dma_addr;
@@ -1878,7 +1869,11 @@ static struct virtqueue *vring_create_virtqueue_packed(
 				 &ring_dma_addr,
 				 GFP_KERNEL|__GFP_NOWARN|__GFP_ZERO);
 	if (!ring)
-		goto err_ring;
+		goto err;
+
+	vring_packed->vring.desc         = ring;
+	vring_packed->ring_dma_addr      = ring_dma_addr;
+	vring_packed->ring_size_in_bytes = ring_size_in_bytes;
 
 	event_size_in_bytes = sizeof(struct vring_packed_desc_event);
 
@@ -1886,13 +1881,47 @@ static struct virtqueue *vring_create_virtqueue_packed(
 				   &driver_event_dma_addr,
 				   GFP_KERNEL|__GFP_NOWARN|__GFP_ZERO);
 	if (!driver)
-		goto err_driver;
+		goto err;
+
+	vring_packed->vring.driver          = driver;
+	vring_packed->event_size_in_bytes   = event_size_in_bytes;
+	vring_packed->driver_event_dma_addr = driver_event_dma_addr;
 
 	device = vring_alloc_queue(vdev, event_size_in_bytes,
 				   &device_event_dma_addr,
 				   GFP_KERNEL|__GFP_NOWARN|__GFP_ZERO);
 	if (!device)
-		goto err_device;
+		goto err;
+
+	vring_packed->vring.device          = device;
+	vring_packed->device_event_dma_addr = device_event_dma_addr;
+
+	vring_packed->vring.num = num;
+
+	return 0;
+
+err:
+	vring_free_packed(vring_packed, vdev);
+	return -ENOMEM;
+}
+
+static struct virtqueue *vring_create_virtqueue_packed(
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
+	struct vring_virtqueue_packed vring_packed = {};
+	struct vring_virtqueue *vq;
+
+	if (vring_alloc_queue_packed(&vring_packed, vdev, num))
+		goto err_ring;
 
 	vq = kmalloc(sizeof(*vq), GFP_KERNEL);
 	if (!vq)
@@ -1915,17 +1944,14 @@ static struct virtqueue *vring_create_virtqueue_packed(
 	vq->indirect = virtio_has_feature(vdev, VIRTIO_RING_F_INDIRECT_DESC) &&
 		!context;
 
-	vq->packed.ring_dma_addr = ring_dma_addr;
-	vq->packed.driver_event_dma_addr = driver_event_dma_addr;
-	vq->packed.device_event_dma_addr = device_event_dma_addr;
+	vq->packed.ring_dma_addr = vring_packed.ring_dma_addr;
+	vq->packed.driver_event_dma_addr = vring_packed.driver_event_dma_addr;
+	vq->packed.device_event_dma_addr = vring_packed.device_event_dma_addr;
 
-	vq->packed.ring_size_in_bytes = ring_size_in_bytes;
-	vq->packed.event_size_in_bytes = event_size_in_bytes;
+	vq->packed.ring_size_in_bytes = vring_packed.ring_size_in_bytes;
+	vq->packed.event_size_in_bytes = vring_packed.event_size_in_bytes;
 
-	vq->packed.vring.num = num;
-	vq->packed.vring.desc = ring;
-	vq->packed.vring.driver = driver;
-	vq->packed.vring.device = device;
+	vq->packed.vring = vring_packed.vring;
 
 	vq->packed.next_avail_idx = 0;
 	vq->packed.avail_wrap_counter = 1;
@@ -1964,11 +1990,7 @@ static struct virtqueue *vring_create_virtqueue_packed(
 err_desc_state:
 	kfree(vq);
 err_vq:
-	vring_free_queue(vdev, event_size_in_bytes, device, device_event_dma_addr);
-err_device:
-	vring_free_queue(vdev, event_size_in_bytes, driver, driver_event_dma_addr);
-err_driver:
-	vring_free_queue(vdev, ring_size_in_bytes, ring, ring_dma_addr);
+	vring_free_packed(&vring_packed, vdev);
 err_ring:
 	return NULL;
 }
-- 
2.31.0


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

