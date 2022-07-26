Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oGEu7-009Kuj-Vp
	for linux-um@lists.infradead.org; Tue, 26 Jul 2022 07:22:57 +0000
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: [PATCH v13 12/42] virtio_ring: split: extract the logic of vring init
Date: Tue, 26 Jul 2022 15:21:55 +0800
Message-Id: <20220726072225.19884-13-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20220726072225.19884-1-xuanzhuo@linux.alibaba.com>
References: <20220726072225.19884-1-xuanzhuo@linux.alibaba.com>
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

Separate the logic of initializing vring, and subsequent patches will
call it separately.

This function completes the variable initialization of split vring. It
together with the logic of atatch constitutes the initialization of
vring.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Acked-by: Jason Wang <jasowang@redhat.com>
---
 drivers/virtio/virtio_ring.c | 31 +++++++++++++++++++++----------
 1 file changed, 21 insertions(+), 10 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 6c24b33ea186..ac973887484f 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -948,6 +948,25 @@ static void *virtqueue_detach_unused_buf_split(struct virtqueue *_vq)
 	return NULL;
 }
 
+static void virtqueue_vring_init_split(struct vring_virtqueue_split *vring_split,
+				       struct vring_virtqueue *vq)
+{
+	struct virtio_device *vdev;
+
+	vdev = vq->vq.vdev;
+
+	vring_split->avail_flags_shadow = 0;
+	vring_split->avail_idx_shadow = 0;
+
+	/* No callback?  Tell other side not to bother us. */
+	if (!vq->vq.callback) {
+		vring_split->avail_flags_shadow |= VRING_AVAIL_F_NO_INTERRUPT;
+		if (!vq->event)
+			vring_split->vring.avail->flags = cpu_to_virtio16(vdev,
+					vring_split->avail_flags_shadow);
+	}
+}
+
 static int vring_alloc_state_extra_split(struct vring_virtqueue_split *vring_split)
 {
 	struct vring_desc_state_split *state;
@@ -2299,16 +2318,6 @@ static struct virtqueue *__vring_new_virtqueue(unsigned int index,
 	vq->split.queue_size_in_bytes = 0;
 
 	vq->split.vring = vring_split->vring;
-	vq->split.avail_flags_shadow = 0;
-	vq->split.avail_idx_shadow = 0;
-
-	/* No callback?  Tell other side not to bother us. */
-	if (!callback) {
-		vq->split.avail_flags_shadow |= VRING_AVAIL_F_NO_INTERRUPT;
-		if (!vq->event)
-			vq->split.vring.avail->flags = cpu_to_virtio16(vdev,
-					vq->split.avail_flags_shadow);
-	}
 
 	err = vring_alloc_state_extra_split(vring_split);
 	if (err) {
@@ -2319,6 +2328,8 @@ static struct virtqueue *__vring_new_virtqueue(unsigned int index,
 	vq->split.desc_state = vring_split->desc_state;
 	vq->split.desc_extra = vring_split->desc_extra;
 
+	virtqueue_vring_init_split(vring_split, vq);
+
 	virtqueue_init(vq, vring_split->vring.num);
 
 	spin_lock(&vdev->vqs_list_lock);
-- 
2.31.0


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

