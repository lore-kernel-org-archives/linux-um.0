Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from out30-57.freemail.mail.aliyun.com ([115.124.30.57])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nRZ45-004NEP-1M
 for linux-um@lists.infradead.org; Tue, 08 Mar 2022 12:35:47 +0000
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: [PATCH v7 08/26] virtio_ring: extract the logic of freeing vring
Date: Tue,  8 Mar 2022 20:35:00 +0800
Message-Id: <20220308123518.33800-9-xuanzhuo@linux.alibaba.com>
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

Introduce vring_free() to free the vring of vq.

Prevent double free by setting vq->reset.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/virtio/virtio_ring.c | 25 ++++++++++++++++++++-----
 include/linux/virtio.h       |  8 ++++++++
 2 files changed, 28 insertions(+), 5 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index b5a9bf4f45b3..e0422c04c903 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -2442,14 +2442,10 @@ struct virtqueue *vring_new_virtqueue(unsigned int index,
 }
 EXPORT_SYMBOL_GPL(vring_new_virtqueue);
 
-void vring_del_virtqueue(struct virtqueue *_vq)
+static void __vring_free(struct virtqueue *_vq)
 {
 	struct vring_virtqueue *vq = to_vvq(_vq);
 
-	spin_lock(&vq->vq.vdev->vqs_list_lock);
-	list_del(&_vq->list);
-	spin_unlock(&vq->vq.vdev->vqs_list_lock);
-
 	if (vq->we_own_ring) {
 		if (vq->packed_ring) {
 			vring_free_queue(vq->vq.vdev,
@@ -2480,6 +2476,25 @@ void vring_del_virtqueue(struct virtqueue *_vq)
 		kfree(vq->split.desc_state);
 		kfree(vq->split.desc_extra);
 	}
+}
+
+static void vring_free(struct virtqueue *vq)
+{
+	__vring_free(vq);
+	vq->reset = VIRTIO_VQ_RESET_STEP_VRING_RELEASE;
+}
+
+void vring_del_virtqueue(struct virtqueue *_vq)
+{
+	struct vring_virtqueue *vq = to_vvq(_vq);
+
+	spin_lock(&vq->vq.vdev->vqs_list_lock);
+	list_del(&_vq->list);
+	spin_unlock(&vq->vq.vdev->vqs_list_lock);
+
+	if (_vq->reset != VIRTIO_VQ_RESET_STEP_VRING_RELEASE)
+		__vring_free(_vq);
+
 	kfree(vq);
 }
 EXPORT_SYMBOL_GPL(vring_del_virtqueue);
diff --git a/include/linux/virtio.h b/include/linux/virtio.h
index d59adc4be068..e3714e6db330 100644
--- a/include/linux/virtio.h
+++ b/include/linux/virtio.h
@@ -10,6 +10,13 @@
 #include <linux/mod_devicetable.h>
 #include <linux/gfp.h>
 
+enum virtio_vq_reset_step {
+	VIRTIO_VQ_RESET_STEP_NONE,
+	VIRTIO_VQ_RESET_STEP_DEVICE,
+	VIRTIO_VQ_RESET_STEP_VRING_RELEASE,
+	VIRTIO_VQ_RESET_STEP_VRING_ATTACH,
+};
+
 /**
  * virtqueue - a queue to register buffers for sending or receiving.
  * @list: the chain of virtqueues for this device
@@ -33,6 +40,7 @@ struct virtqueue {
 	unsigned int num_free;
 	unsigned int num_max;
 	void *priv;
+	enum virtio_vq_reset_step reset;
 };
 
 int virtqueue_add_outbuf(struct virtqueue *vq,
-- 
2.31.0


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

