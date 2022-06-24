Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o4ZV0-00HUq5-4C
	for linux-um@lists.infradead.org; Fri, 24 Jun 2022 02:56:49 +0000
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: [PATCH v10 08/41] virtio_ring: introduce virtqueue_init()
Date: Fri, 24 Jun 2022 10:55:48 +0800
Message-Id: <20220624025621.128843-9-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20220624025621.128843-1-xuanzhuo@linux.alibaba.com>
References: <20220624025621.128843-1-xuanzhuo@linux.alibaba.com>
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

Separate the logic of virtqueue initialization. This logic is irrelevant
to ring layout.

This logic can be called independently when implementing resize/reset
later.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/virtio/virtio_ring.c | 59 +++++++++++++++++-------------------
 1 file changed, 28 insertions(+), 31 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 973892606144..7bc1eecff7fe 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -366,6 +366,31 @@ static int vring_mapping_error(const struct vring_virtqueue *vq,
 	return dma_mapping_error(vring_dma_dev(vq), addr);
 }
 
+static void virtqueue_init(struct vring_virtqueue *vq, u32 num)
+{
+	struct virtio_device *vdev;
+
+	vdev = vq->vq.vdev;
+
+	vq->vq.num_free = num;
+	vq->last_used_idx = 0;
+	vq->event_triggered = false;
+	vq->num_added = 0;
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
+	/* Put everything in free lists. */
+	vq->free_head = 0;
+}
+
 
 /*
  * Split ring specific functions - *_split().
@@ -1686,28 +1711,15 @@ static struct virtqueue *vring_create_virtqueue_packed(
 	vq->vq.callback = callback;
 	vq->vq.vdev = vdev;
 	vq->vq.name = name;
-	vq->vq.num_free = num;
 	vq->vq.index = index;
 	vq->we_own_ring = true;
 	vq->notify = notify;
 	vq->weak_barriers = weak_barriers;
 	vq->broken = true;
-	vq->last_used_idx = 0;
-	vq->event_triggered = false;
-	vq->num_added = 0;
 	vq->packed_ring = true;
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
 
 	vq->packed.ring_dma_addr = ring_dma_addr;
 	vq->packed.driver_event_dma_addr = driver_event_dma_addr;
@@ -1736,8 +1748,7 @@ static struct virtqueue *vring_create_virtqueue_packed(
 	memset(vq->packed.desc_state, 0,
 		num * sizeof(struct vring_desc_state_packed));
 
-	/* Put everything in free lists. */
-	vq->free_head = 0;
+	virtqueue_init(vq, num);
 
 	vq->packed.desc_extra = vring_alloc_desc_extra(num);
 	if (!vq->packed.desc_extra)
@@ -2178,27 +2189,13 @@ struct virtqueue *__vring_new_virtqueue(unsigned int index,
 	vq->vq.callback = callback;
 	vq->vq.vdev = vdev;
 	vq->vq.name = name;
-	vq->vq.num_free = vring.num;
 	vq->vq.index = index;
 	vq->we_own_ring = false;
 	vq->notify = notify;
 	vq->weak_barriers = weak_barriers;
 	vq->broken = true;
-	vq->last_used_idx = 0;
-	vq->event_triggered = false;
-	vq->num_added = 0;
-	vq->use_dma_api = vring_use_dma_api(vdev);
-#ifdef DEBUG
-	vq->in_use = false;
-	vq->last_add_time_valid = false;
-#endif
-
 	vq->indirect = virtio_has_feature(vdev, VIRTIO_RING_F_INDIRECT_DESC) &&
 		!context;
-	vq->event = virtio_has_feature(vdev, VIRTIO_RING_F_EVENT_IDX);
-
-	if (virtio_has_feature(vdev, VIRTIO_F_ORDER_PLATFORM))
-		vq->weak_barriers = false;
 
 	vq->split.queue_dma_addr = 0;
 	vq->split.queue_size_in_bytes = 0;
@@ -2224,11 +2221,11 @@ struct virtqueue *__vring_new_virtqueue(unsigned int index,
 	if (!vq->split.desc_extra)
 		goto err_extra;
 
-	/* Put everything in free lists. */
-	vq->free_head = 0;
 	memset(vq->split.desc_state, 0, vring.num *
 			sizeof(struct vring_desc_state_split));
 
+	virtqueue_init(vq, vq->split.vring.num);
+
 	spin_lock(&vdev->vqs_list_lock);
 	list_add_tail(&vq->vq.list, &vdev->vqs);
 	spin_unlock(&vdev->vqs_list_lock);
-- 
2.31.0


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

