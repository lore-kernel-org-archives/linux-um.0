Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nbwam-003e1k-RI
 for linux-um@lists.infradead.org; Wed, 06 Apr 2022 03:44:28 +0000
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: [PATCH v9 15/32] virtio_ring: packed: extract the logic of vq init
Date: Wed,  6 Apr 2022 11:43:29 +0800
Message-Id: <20220406034346.74409-16-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20220406034346.74409-1-xuanzhuo@linux.alibaba.com>
References: <20220406034346.74409-1-xuanzhuo@linux.alibaba.com>
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
Cc: Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Hans de Goede <hdegoede@redhat.com>, Mark Gross <markgross@kernel.org>, Vadim Pasternak <vadimp@nvidia.com>, Bjorn Andersson <bjorn.andersson@linaro.org>, Mathieu Poirier <mathieu.poirier@linaro.org>, Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, Johannes Berg <johannes.berg@intel.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Vincent Whitchurch <vincent.whitchurch@axis.com>, linux-um@lists.infradead.org, netdev@vger.kernel.org, platform-driver-x86@vger.kernel.org, linux-remoteproc@vger.kernel.org, linux-s390@vger.kernel.org, kvm@vger.kernel.org, bpf@vger.kernel.org

Separate the logic of initializing vq, and subsequent patches will call
it separately.

The characteristic of this part of the logic is that it does not depend
on the information passed by the upper layer, and can be called
repeatedly.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/virtio/virtio_ring.c | 71 ++++++++++++++++++++----------------
 1 file changed, 39 insertions(+), 32 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 80d446fa8d16..c783eb272468 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -1933,6 +1933,44 @@ static void vring_virtqueue_attach_packed(struct vring_virtqueue *vq,
 	vq->packed.desc_extra = extra;
 }
 
+static void vring_virtqueue_init_packed(struct vring_virtqueue *vq,
+					struct virtio_device *vdev)
+{
+	vq->vq.num_free = vq->packed.vring.num;
+	vq->we_own_ring = true;
+	vq->broken = false;
+	vq->last_used_idx = 0;
+	vq->event_triggered = false;
+	vq->num_added = 0;
+	vq->packed_ring = true;
+	vq->use_dma_api = vring_use_dma_api(vdev);
+#ifdef DEBUG
+	vq->in_use = false;
+	vq->last_add_time_valid = false;
+#endif
+
+	vq->event = virtio_has_feature(vdev, VIRTIO_RING_F_EVENT_IDX);
+
+	if (virtio_has_feature(vdev, VIRTIO_F_ORDER_PLATFORM))
+		vq->weak_barriers = false;
+
+	vq->packed.next_avail_idx = 0;
+	vq->packed.avail_wrap_counter = 1;
+	vq->packed.used_wrap_counter = 1;
+	vq->packed.event_flags_shadow = 0;
+	vq->packed.avail_used_flags = 1 << VRING_PACKED_DESC_F_AVAIL;
+
+	/* Put everything in free lists. */
+	vq->free_head = 0;
+
+	/* No callback?  Tell other side not to bother us. */
+	if (!vq->vq.callback) {
+		vq->packed.event_flags_shadow = VRING_PACKED_EVENT_FLAG_DISABLE;
+		vq->packed.vring.driver->flags =
+			cpu_to_le16(vq->packed.event_flags_shadow);
+	}
+}
+
 static struct virtqueue *vring_create_virtqueue_packed(
 	unsigned int index,
 	unsigned int num,
@@ -1968,34 +2006,12 @@ static struct virtqueue *vring_create_virtqueue_packed(
 	vq->vq.callback = callback;
 	vq->vq.vdev = vdev;
 	vq->vq.name = name;
-	vq->vq.num_free = num;
 	vq->vq.index = index;
-	vq->we_own_ring = true;
 	vq->notify = notify;
 	vq->weak_barriers = weak_barriers;
-	vq->broken = false;
-	vq->last_used_idx = 0;
-	vq->event_triggered = false;
-	vq->num_added = 0;
-	vq->packed_ring = true;
-	vq->use_dma_api = vring_use_dma_api(vdev);
-#ifdef DEBUG
-	vq->in_use = false;
-	vq->last_add_time_valid = false;
-#endif
 
 	vq->indirect = virtio_has_feature(vdev, VIRTIO_RING_F_INDIRECT_DESC) &&
 		!context;
-	vq->event = virtio_has_feature(vdev, VIRTIO_RING_F_EVENT_IDX);
-
-	if (virtio_has_feature(vdev, VIRTIO_F_ORDER_PLATFORM))
-		vq->weak_barriers = false;
-
-	vq->packed.next_avail_idx = 0;
-	vq->packed.avail_wrap_counter = 1;
-	vq->packed.used_wrap_counter = 1;
-	vq->packed.event_flags_shadow = 0;
-	vq->packed.avail_used_flags = 1 << VRING_PACKED_DESC_F_AVAIL;
 
 	err = vring_alloc_state_extra_packed(num, &state, &extra);
 	if (err)
@@ -2005,16 +2021,7 @@ static struct virtqueue *vring_create_virtqueue_packed(
 				      ring_dma_addr, driver_event_dma_addr,
 				      device_event_dma_addr, ring_size_in_bytes,
 				      event_size_in_bytes, state, extra);
-
-	/* Put everything in free lists. */
-	vq->free_head = 0;
-
-	/* No callback?  Tell other side not to bother us. */
-	if (!callback) {
-		vq->packed.event_flags_shadow = VRING_PACKED_EVENT_FLAG_DISABLE;
-		vq->packed.vring.driver->flags =
-			cpu_to_le16(vq->packed.event_flags_shadow);
-	}
+	vring_virtqueue_init_packed(vq, vdev);
 
 	spin_lock(&vdev->vqs_list_lock);
 	list_add_tail(&vq->vq.list, &vdev->vqs);
-- 
2.31.0


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

