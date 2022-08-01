Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oIP5f-002zZV-9o
	for linux-um@lists.infradead.org; Mon, 01 Aug 2022 06:39:49 +0000
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: [PATCH v14 20/42] virtio_ring: packed: extract the logic of vring init
Date: Mon,  1 Aug 2022 14:38:40 +0800
Message-Id: <20220801063902.129329-21-xuanzhuo@linux.alibaba.com>
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

Separate the logic of initializing vring, and subsequent patches will
call it separately.

This function completes the variable initialization of packed vring. It
together with the logic of atatch constitutes the initialization of
vring.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Acked-by: Jason Wang <jasowang@redhat.com>
---
 drivers/virtio/virtio_ring.c | 28 +++++++++++++++++-----------
 1 file changed, 17 insertions(+), 11 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 533af061d009..a6f90e6e621b 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -1932,6 +1932,22 @@ static int vring_alloc_state_extra_packed(struct vring_virtqueue_packed *vring_p
 	return -ENOMEM;
 }
 
+static void virtqueue_vring_init_packed(struct vring_virtqueue_packed *vring_packed,
+					bool callback)
+{
+	vring_packed->next_avail_idx = 0;
+	vring_packed->avail_wrap_counter = 1;
+	vring_packed->event_flags_shadow = 0;
+	vring_packed->avail_used_flags = 1 << VRING_PACKED_DESC_F_AVAIL;
+
+	/* No callback?  Tell other side not to bother us. */
+	if (!callback) {
+		vring_packed->event_flags_shadow = VRING_PACKED_EVENT_FLAG_DISABLE;
+		vring_packed->vring.driver->flags =
+			cpu_to_le16(vring_packed->event_flags_shadow);
+	}
+}
+
 static struct virtqueue *vring_create_virtqueue_packed(
 	unsigned int index,
 	unsigned int num,
@@ -1986,11 +2002,6 @@ static struct virtqueue *vring_create_virtqueue_packed(
 
 	vq->packed.vring = vring_packed.vring;
 
-	vq->packed.next_avail_idx = 0;
-	vq->packed.avail_wrap_counter = 1;
-	vq->packed.event_flags_shadow = 0;
-	vq->packed.avail_used_flags = 1 << VRING_PACKED_DESC_F_AVAIL;
-
 	err = vring_alloc_state_extra_packed(&vring_packed);
 	if (err)
 		goto err_state_extra;
@@ -2001,12 +2012,7 @@ static struct virtqueue *vring_create_virtqueue_packed(
 	vq->packed.desc_state = vring_packed.desc_state;
 	vq->packed.desc_extra = vring_packed.desc_extra;
 
-	/* No callback?  Tell other side not to bother us. */
-	if (!callback) {
-		vq->packed.event_flags_shadow = VRING_PACKED_EVENT_FLAG_DISABLE;
-		vq->packed.vring.driver->flags =
-			cpu_to_le16(vq->packed.event_flags_shadow);
-	}
+	virtqueue_vring_init_packed(&vring_packed, !!callback);
 
 	virtqueue_init(vq, num);
 
-- 
2.31.0


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

