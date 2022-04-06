Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nbwaa-003doB-CY
 for linux-um@lists.infradead.org; Wed, 06 Apr 2022 03:44:13 +0000
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: [PATCH v9 08/32] virtio_ring: split: extract the logic of attach vring
Date: Wed,  6 Apr 2022 11:43:22 +0800
Message-Id: <20220406034346.74409-9-xuanzhuo@linux.alibaba.com>
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

Separate the logic of attach vring, subsequent patches will call it
separately.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/virtio/virtio_ring.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 6de67439cb57..083f2992ba0d 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -916,6 +916,19 @@ static void *virtqueue_detach_unused_buf_split(struct virtqueue *_vq)
 	return NULL;
 }
 
+static void vring_virtqueue_attach_split(struct vring_virtqueue *vq,
+					 struct vring vring,
+					 struct vring_desc_state_split *desc_state,
+					 struct vring_desc_extra *desc_extra)
+{
+	vq->split.vring = vring;
+	vq->split.queue_dma_addr = 0;
+	vq->split.queue_size_in_bytes = 0;
+
+	vq->split.desc_state = desc_state;
+	vq->split.desc_extra = desc_extra;
+}
+
 static int vring_alloc_state_extra_split(u32 num,
 					 struct vring_desc_state_split **desc_state,
 					 struct vring_desc_extra **desc_extra)
@@ -2262,10 +2275,6 @@ struct virtqueue *__vring_new_virtqueue(unsigned int index,
 	if (virtio_has_feature(vdev, VIRTIO_F_ORDER_PLATFORM))
 		vq->weak_barriers = false;
 
-	vq->split.queue_dma_addr = 0;
-	vq->split.queue_size_in_bytes = 0;
-
-	vq->split.vring = vring;
 	vq->split.avail_flags_shadow = 0;
 	vq->split.avail_idx_shadow = 0;
 
@@ -2283,8 +2292,7 @@ struct virtqueue *__vring_new_virtqueue(unsigned int index,
 		return NULL;
 	}
 
-	vq->split.desc_state = state;
-	vq->split.desc_extra = extra;
+	vring_virtqueue_attach_split(vq, vring, state, extra);
 
 	/* Put everything in free lists. */
 	vq->free_head = 0;
-- 
2.31.0


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

