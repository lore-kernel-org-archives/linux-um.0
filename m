Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nbwar-003e7p-NV
 for linux-um@lists.infradead.org; Wed, 06 Apr 2022 03:44:31 +0000
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: [PATCH v9 17/32] virtio_ring: packed: introduce
 virtqueue_resize_packed()
Date: Wed,  6 Apr 2022 11:43:31 +0800
Message-Id: <20220406034346.74409-18-xuanzhuo@linux.alibaba.com>
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

virtio ring packed supports resize.

Only after the new vring is successfully allocated based on the new num,
we will release the old vring. In any case, an error is returned,
indicating that the vring still points to the old vring.

In the case of an error, the caller must re-initialize(by
virtqueue_reinit_packed()) the virtqueue to ensure that the vring can be
used.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/virtio/virtio_ring.c | 40 ++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 9a4f2db718bd..06f66b15c86c 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -2059,6 +2059,46 @@ static struct virtqueue *vring_create_virtqueue_packed(
 	return NULL;
 }
 
+static int virtqueue_resize_packed(struct virtqueue *_vq, u32 num)
+{
+	dma_addr_t ring_dma_addr, driver_event_dma_addr, device_event_dma_addr;
+	struct vring_packed_desc_event *driver, *device;
+	size_t ring_size_in_bytes, event_size_in_bytes;
+	struct vring_virtqueue *vq = to_vvq(_vq);
+	struct virtio_device *vdev = _vq->vdev;
+	struct vring_desc_state_packed *state;
+	struct vring_desc_extra *extra;
+	struct vring_packed_desc *ring;
+	int err;
+
+	if (vring_alloc_queue_packed(vdev, num, &ring, &driver, &device,
+				     &ring_dma_addr, &driver_event_dma_addr,
+				     &device_event_dma_addr,
+				     &ring_size_in_bytes, &event_size_in_bytes))
+		goto err_ring;
+
+
+	err = vring_alloc_state_extra_packed(num, &state, &extra);
+	if (err)
+		goto err_state_extra;
+
+	vring_free(&vq->vq);
+
+	vring_virtqueue_attach_packed(vq, num, ring, driver, device,
+				      ring_dma_addr, driver_event_dma_addr,
+				      device_event_dma_addr, ring_size_in_bytes,
+				      event_size_in_bytes, state, extra);
+	vring_virtqueue_init_packed(vq, vdev);
+	return 0;
+
+err_state_extra:
+	vring_free_queue(vdev, event_size_in_bytes, device, device_event_dma_addr);
+	vring_free_queue(vdev, event_size_in_bytes, driver, driver_event_dma_addr);
+	vring_free_queue(vdev, ring_size_in_bytes, ring, ring_dma_addr);
+err_ring:
+	return -ENOMEM;
+}
+
 
 /*
  * Generic functions and exported symbols.
-- 
2.31.0


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

