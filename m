Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oIP5N-002z2c-CZ
	for linux-um@lists.infradead.org; Mon, 01 Aug 2022 06:39:33 +0000
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: [PATCH v14 08/42] virtio_ring: split: __vring_new_virtqueue() accept struct vring_virtqueue_split
Date: Mon,  1 Aug 2022 14:38:28 +0800
Message-Id: <20220801063902.129329-9-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20220801063902.129329-1-xuanzhuo@linux.alibaba.com>
References: <20220801063902.129329-1-xuanzhuo@linux.alibaba.com>
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

__vring_new_virtqueue() instead accepts struct vring_virtqueue_split.

The purpose of this is to pass more information into
__vring_new_virtqueue() to make the code simpler and the structure
cleaner.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Acked-by: Jason Wang <jasowang@redhat.com>
---
 drivers/virtio/virtio_ring.c | 29 +++++++++++++++--------------
 1 file changed, 15 insertions(+), 14 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 8ce6cc73d814..1d51ed46b295 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -205,7 +205,7 @@ struct vring_virtqueue {
 };
 
 static struct virtqueue *__vring_new_virtqueue(unsigned int index,
-					       struct vring vring,
+					       struct vring_virtqueue_split *vring_split,
 					       struct virtio_device *vdev,
 					       bool weak_barriers,
 					       bool context,
@@ -949,6 +949,7 @@ static struct virtqueue *vring_create_virtqueue_split(
 	void (*callback)(struct virtqueue *),
 	const char *name)
 {
+	struct vring_virtqueue_split vring_split = {};
 	struct virtqueue *vq;
 	void *queue = NULL;
 	dma_addr_t dma_addr;
@@ -984,10 +985,10 @@ static struct virtqueue *vring_create_virtqueue_split(
 		return NULL;
 
 	queue_size_in_bytes = vring_size(num, vring_align);
-	vring_init(&vring, num, queue, vring_align);
+	vring_init(&vring_split.vring, num, queue, vring_align);
 
-	vq = __vring_new_virtqueue(index, vring, vdev, weak_barriers, context,
-				   notify, callback, name);
+	vq = __vring_new_virtqueue(index, &vring_split, vdev, weak_barriers,
+				   context, notify, callback, name);
 	if (!vq) {
 		vring_free_queue(vdev, queue_size_in_bytes, queue,
 				 dma_addr);
@@ -2204,7 +2205,7 @@ EXPORT_SYMBOL_GPL(vring_interrupt);
 
 /* Only available for split ring */
 static struct virtqueue *__vring_new_virtqueue(unsigned int index,
-					       struct vring vring,
+					       struct vring_virtqueue_split *vring_split,
 					       struct virtio_device *vdev,
 					       bool weak_barriers,
 					       bool context,
@@ -2246,7 +2247,7 @@ static struct virtqueue *__vring_new_virtqueue(unsigned int index,
 	vq->split.queue_dma_addr = 0;
 	vq->split.queue_size_in_bytes = 0;
 
-	vq->split.vring = vring;
+	vq->split.vring = vring_split->vring;
 	vq->split.avail_flags_shadow = 0;
 	vq->split.avail_idx_shadow = 0;
 
@@ -2258,21 +2259,21 @@ static struct virtqueue *__vring_new_virtqueue(unsigned int index,
 					vq->split.avail_flags_shadow);
 	}
 
-	vq->split.desc_state = kmalloc_array(vring.num,
+	vq->split.desc_state = kmalloc_array(vring_split->vring.num,
 			sizeof(struct vring_desc_state_split), GFP_KERNEL);
 	if (!vq->split.desc_state)
 		goto err_state;
 
-	vq->split.desc_extra = vring_alloc_desc_extra(vring.num);
+	vq->split.desc_extra = vring_alloc_desc_extra(vring_split->vring.num);
 	if (!vq->split.desc_extra)
 		goto err_extra;
 
 	/* Put everything in free lists. */
 	vq->free_head = 0;
-	memset(vq->split.desc_state, 0, vring.num *
+	memset(vq->split.desc_state, 0, vring_split->vring.num *
 			sizeof(struct vring_desc_state_split));
 
-	virtqueue_init(vq, vring.num);
+	virtqueue_init(vq, vring_split->vring.num);
 
 	spin_lock(&vdev->vqs_list_lock);
 	list_add_tail(&vq->vq.list, &vdev->vqs);
@@ -2322,14 +2323,14 @@ struct virtqueue *vring_new_virtqueue(unsigned int index,
 				      void (*callback)(struct virtqueue *vq),
 				      const char *name)
 {
-	struct vring vring;
+	struct vring_virtqueue_split vring_split = {};
 
 	if (virtio_has_feature(vdev, VIRTIO_F_RING_PACKED))
 		return NULL;
 
-	vring_init(&vring, num, pages, vring_align);
-	return __vring_new_virtqueue(index, vring, vdev, weak_barriers, context,
-				     notify, callback, name);
+	vring_init(&vring_split.vring, num, pages, vring_align);
+	return __vring_new_virtqueue(index, &vring_split, vdev, weak_barriers,
+				     context, notify, callback, name);
 }
 EXPORT_SYMBOL_GPL(vring_new_virtqueue);
 
-- 
2.31.0


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

