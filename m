Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o6RdU-009wBA-Lu
	for linux-um@lists.infradead.org; Wed, 29 Jun 2022 06:57:20 +0000
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: [PATCH v11 05/40] virtio_ring: split vring_virtqueue
Date: Wed, 29 Jun 2022 14:56:21 +0800
Message-Id: <20220629065656.54420-6-xuanzhuo@linux.alibaba.com>
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

Separate the two inline structures(split and packed) from the structure
vring_virtqueue.

In this way, we can use these two structures later to pass parameters
and retain temporary variables.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/virtio/virtio_ring.c | 116 ++++++++++++++++++-----------------
 1 file changed, 60 insertions(+), 56 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index bb4e8ae09c9b..2806e033a651 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -85,6 +85,64 @@ struct vring_desc_extra {
 	u16 next;			/* The next desc state in a list. */
 };
 
+struct vring_virtqueue_split {
+	/* Actual memory layout for this queue. */
+	struct vring vring;
+
+	/* Last written value to avail->flags */
+	u16 avail_flags_shadow;
+
+	/*
+	 * Last written value to avail->idx in
+	 * guest byte order.
+	 */
+	u16 avail_idx_shadow;
+
+	/* Per-descriptor state. */
+	struct vring_desc_state_split *desc_state;
+	struct vring_desc_extra *desc_extra;
+
+	/* DMA address and size information */
+	dma_addr_t queue_dma_addr;
+	size_t queue_size_in_bytes;
+};
+
+struct vring_virtqueue_packed {
+	/* Actual memory layout for this queue. */
+	struct {
+		unsigned int num;
+		struct vring_packed_desc *desc;
+		struct vring_packed_desc_event *driver;
+		struct vring_packed_desc_event *device;
+	} vring;
+
+	/* Driver ring wrap counter. */
+	bool avail_wrap_counter;
+
+	/* Avail used flags. */
+	u16 avail_used_flags;
+
+	/* Index of the next avail descriptor. */
+	u16 next_avail_idx;
+
+	/*
+	 * Last written value to driver->flags in
+	 * guest byte order.
+	 */
+	u16 event_flags_shadow;
+
+	/* Per-descriptor state. */
+	struct vring_desc_state_packed *desc_state;
+	struct vring_desc_extra *desc_extra;
+
+	/* DMA address and size information */
+	dma_addr_t ring_dma_addr;
+	dma_addr_t driver_event_dma_addr;
+	dma_addr_t device_event_dma_addr;
+	size_t ring_size_in_bytes;
+	size_t event_size_in_bytes;
+};
+
 struct vring_virtqueue {
 	struct virtqueue vq;
 
@@ -124,64 +182,10 @@ struct vring_virtqueue {
 
 	union {
 		/* Available for split ring */
-		struct {
-			/* Actual memory layout for this queue. */
-			struct vring vring;
-
-			/* Last written value to avail->flags */
-			u16 avail_flags_shadow;
-
-			/*
-			 * Last written value to avail->idx in
-			 * guest byte order.
-			 */
-			u16 avail_idx_shadow;
-
-			/* Per-descriptor state. */
-			struct vring_desc_state_split *desc_state;
-			struct vring_desc_extra *desc_extra;
-
-			/* DMA address and size information */
-			dma_addr_t queue_dma_addr;
-			size_t queue_size_in_bytes;
-		} split;
+		struct vring_virtqueue_split split;
 
 		/* Available for packed ring */
-		struct {
-			/* Actual memory layout for this queue. */
-			struct {
-				unsigned int num;
-				struct vring_packed_desc *desc;
-				struct vring_packed_desc_event *driver;
-				struct vring_packed_desc_event *device;
-			} vring;
-
-			/* Driver ring wrap counter. */
-			bool avail_wrap_counter;
-
-			/* Avail used flags. */
-			u16 avail_used_flags;
-
-			/* Index of the next avail descriptor. */
-			u16 next_avail_idx;
-
-			/*
-			 * Last written value to driver->flags in
-			 * guest byte order.
-			 */
-			u16 event_flags_shadow;
-
-			/* Per-descriptor state. */
-			struct vring_desc_state_packed *desc_state;
-			struct vring_desc_extra *desc_extra;
-
-			/* DMA address and size information */
-			dma_addr_t ring_dma_addr;
-			dma_addr_t driver_event_dma_addr;
-			dma_addr_t device_event_dma_addr;
-			size_t ring_size_in_bytes;
-			size_t event_size_in_bytes;
-		} packed;
+		struct vring_virtqueue_packed packed;
 	};
 
 	/* How to notify other side. FIXME: commonalize hcalls! */
-- 
2.31.0


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

