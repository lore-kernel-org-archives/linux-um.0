Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from out30-43.freemail.mail.aliyun.com ([115.124.30.43])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o4ZV9-00HV18-St
	for linux-um@lists.infradead.org; Fri, 24 Jun 2022 02:56:57 +0000
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: [PATCH v10 12/41] virtio_ring: split: extract the logic of attach vring
Date: Fri, 24 Jun 2022 10:55:52 +0800
Message-Id: <20220624025621.128843-13-xuanzhuo@linux.alibaba.com>
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

Separate the logic of attach vring, subsequent patches will call it
separately.

Since the "struct vring_virtqueue_split split" is created on the
stack and has been initialized to 0. So using
split->queue_dma_addr/split->queue_size_in_bytes assignment for
queue_dma_addr/queue_size_in_bytes can keep the same as the original
code.

On the other hand, subsequent patches can use the "struct
vring_virtqueue_split split" obtained by vring_alloc_queue_split() to
directly complete the attach operation.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/virtio/virtio_ring.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index ef775154536e..7ee8dd4328ca 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -935,6 +935,18 @@ static void *virtqueue_detach_unused_buf_split(struct virtqueue *_vq)
 	return NULL;
 }
 
+static void virtqueue_vring_attach_split(struct vring_virtqueue *vq,
+					 struct vring_virtqueue_split *vring)
+{
+	vq->split.queue_dma_addr = vring->queue_dma_addr;
+	vq->split.queue_size_in_bytes = vring->queue_size_in_bytes;
+
+	vq->split.vring = vring->vring;
+
+	vq->split.desc_state = vring->desc_state;
+	vq->split.desc_extra = vring->desc_extra;
+}
+
 static int vring_alloc_state_extra_split(struct vring_virtqueue_split *vring)
 {
 	struct vring_desc_state_split *state;
@@ -2252,10 +2264,6 @@ struct virtqueue *__vring_new_virtqueue(unsigned int index,
 	vq->indirect = virtio_has_feature(vdev, VIRTIO_RING_F_INDIRECT_DESC) &&
 		!context;
 
-	vq->split.queue_dma_addr = 0;
-	vq->split.queue_size_in_bytes = 0;
-
-	vq->split.vring = _vring;
 	vq->split.avail_flags_shadow = 0;
 	vq->split.avail_idx_shadow = 0;
 
@@ -2275,10 +2283,8 @@ struct virtqueue *__vring_new_virtqueue(unsigned int index,
 		return NULL;
 	}
 
-	vq->split.desc_state = vring.desc_state;
-	vq->split.desc_extra = vring.desc_extra;
-
 	virtqueue_init(vq, vring.vring.num);
+	virtqueue_vring_attach_split(vq, &vring);
 
 	spin_lock(&vdev->vqs_list_lock);
 	list_add_tail(&vq->vq.list, &vdev->vqs);
-- 
2.31.0


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

