Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from out199-5.us.a.mail.aliyun.com ([47.90.199.5])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nRZ3z-004N8z-JH
 for linux-um@lists.infradead.org; Tue, 08 Mar 2022 12:35:42 +0000
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: [PATCH v7 06/26] virtio_ring: packed: extract the logic of creating
 vring
Date: Tue,  8 Mar 2022 20:34:58 +0800
Message-Id: <20220308123518.33800-7-xuanzhuo@linux.alibaba.com>
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

Separate the logic of packed to create vring queue.

For the convenience of passing parameters, add a structure
vring_packed.

This feature is required for subsequent virtuqueue reset vring.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/virtio/virtio_ring.c | 121 ++++++++++++++++++++++++++---------
 1 file changed, 92 insertions(+), 29 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index dc6313b79305..1af98b112996 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -92,6 +92,18 @@ struct vring_split {
 	struct vring vring;
 };
 
+struct vring_packed {
+	u32 num;
+	struct vring_packed_desc *ring;
+	struct vring_packed_desc_event *driver;
+	struct vring_packed_desc_event *device;
+	dma_addr_t ring_dma_addr;
+	dma_addr_t driver_event_dma_addr;
+	dma_addr_t device_event_dma_addr;
+	size_t ring_size_in_bytes;
+	size_t event_size_in_bytes;
+};
+
 struct vring_virtqueue {
 	struct virtqueue vq;
 
@@ -1683,45 +1695,101 @@ static struct vring_desc_extra *vring_alloc_desc_extra(struct vring_virtqueue *v
 	return desc_extra;
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
+static void vring_free_vring_packed(struct vring_packed *vring,
+				    struct virtio_device *vdev)
+{
+	dma_addr_t ring_dma_addr, driver_event_dma_addr, device_event_dma_addr;
+	struct vring_packed_desc_event *driver, *device;
+	size_t ring_size_in_bytes, event_size_in_bytes;
+	struct vring_packed_desc *ring;
+
+	ring                  = vring->ring;
+	driver                = vring->driver;
+	device                = vring->device;
+	ring_size_in_bytes    = vring->ring_size_in_bytes;
+	event_size_in_bytes   = vring->event_size_in_bytes;
+	ring_dma_addr         = vring->ring_dma_addr;
+	driver_event_dma_addr = vring->driver_event_dma_addr;
+	device_event_dma_addr = vring->device_event_dma_addr;
+
+	if (device)
+		vring_free_queue(vdev, event_size_in_bytes, device, device_event_dma_addr);
+
+	if (driver)
+		vring_free_queue(vdev, event_size_in_bytes, driver, driver_event_dma_addr);
+
+	if (ring)
+		vring_free_queue(vdev, ring_size_in_bytes, ring, ring_dma_addr);
+}
+
+static int vring_create_vring_packed(struct vring_packed *vring,
+				    struct virtio_device *vdev,
+				    u32 num)
 {
-	struct vring_virtqueue *vq;
 	struct vring_packed_desc *ring;
 	struct vring_packed_desc_event *driver, *device;
 	dma_addr_t ring_dma_addr, driver_event_dma_addr, device_event_dma_addr;
 	size_t ring_size_in_bytes, event_size_in_bytes;
 
+	memset(vring, 0, sizeof(*vring));
+
 	ring_size_in_bytes = num * sizeof(struct vring_packed_desc);
 
 	ring = vring_alloc_queue(vdev, ring_size_in_bytes,
 				 &ring_dma_addr,
 				 GFP_KERNEL|__GFP_NOWARN|__GFP_ZERO);
 	if (!ring)
-		goto err_ring;
+		goto err;
+
+	vring->num = num;
+	vring->ring = ring;
+	vring->ring_size_in_bytes = ring_size_in_bytes;
+	vring->ring_dma_addr = ring_dma_addr;
 
 	event_size_in_bytes = sizeof(struct vring_packed_desc_event);
+	vring->event_size_in_bytes = event_size_in_bytes;
 
 	driver = vring_alloc_queue(vdev, event_size_in_bytes,
 				   &driver_event_dma_addr,
 				   GFP_KERNEL|__GFP_NOWARN|__GFP_ZERO);
 	if (!driver)
-		goto err_driver;
+		goto err;
+
+	vring->driver = driver;
+	vring->driver_event_dma_addr = driver_event_dma_addr;
 
 	device = vring_alloc_queue(vdev, event_size_in_bytes,
 				   &device_event_dma_addr,
 				   GFP_KERNEL|__GFP_NOWARN|__GFP_ZERO);
 	if (!device)
-		goto err_device;
+		goto err;
+
+	vring->device = device;
+	vring->device_event_dma_addr = device_event_dma_addr;
+	return 0;
+
+err:
+	vring_free_vring_packed(vring, vdev);
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
+	struct vring_virtqueue *vq;
+	struct vring_packed vring;
+
+	if (vring_create_vring_packed(&vring, vdev, num))
+		goto err_vq;
 
 	vq = kmalloc(sizeof(*vq), GFP_KERNEL);
 	if (!vq)
@@ -1753,17 +1821,17 @@ static struct virtqueue *vring_create_virtqueue_packed(
 	if (virtio_has_feature(vdev, VIRTIO_F_ORDER_PLATFORM))
 		vq->weak_barriers = false;
 
-	vq->packed.ring_dma_addr = ring_dma_addr;
-	vq->packed.driver_event_dma_addr = driver_event_dma_addr;
-	vq->packed.device_event_dma_addr = device_event_dma_addr;
+	vq->packed.ring_dma_addr = vring.ring_dma_addr;
+	vq->packed.driver_event_dma_addr = vring.driver_event_dma_addr;
+	vq->packed.device_event_dma_addr = vring.device_event_dma_addr;
 
-	vq->packed.ring_size_in_bytes = ring_size_in_bytes;
-	vq->packed.event_size_in_bytes = event_size_in_bytes;
+	vq->packed.ring_size_in_bytes = vring.ring_size_in_bytes;
+	vq->packed.event_size_in_bytes = vring.event_size_in_bytes;
 
 	vq->packed.vring.num = num;
-	vq->packed.vring.desc = ring;
-	vq->packed.vring.driver = driver;
-	vq->packed.vring.device = device;
+	vq->packed.vring.desc = vring.ring;
+	vq->packed.vring.driver = vring.driver;
+	vq->packed.vring.device = vring.device;
 
 	vq->packed.next_avail_idx = 0;
 	vq->packed.avail_wrap_counter = 1;
@@ -1804,12 +1872,7 @@ static struct virtqueue *vring_create_virtqueue_packed(
 err_desc_state:
 	kfree(vq);
 err_vq:
-	vring_free_queue(vdev, event_size_in_bytes, device, device_event_dma_addr);
-err_device:
-	vring_free_queue(vdev, event_size_in_bytes, driver, driver_event_dma_addr);
-err_driver:
-	vring_free_queue(vdev, ring_size_in_bytes, ring, ring_dma_addr);
-err_ring:
+	vring_free_vring_packed(&vring, vdev);
 	return NULL;
 }
 
-- 
2.31.0


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

