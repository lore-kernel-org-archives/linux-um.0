Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from out30-44.freemail.mail.aliyun.com ([115.124.30.44])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o4ZVH-00HVCG-Pq
	for linux-um@lists.infradead.org; Fri, 24 Jun 2022 02:57:05 +0000
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: [PATCH v10 16/41] virtio_ring: split: introduce virtqueue_resize_split()
Date: Fri, 24 Jun 2022 10:55:56 +0800
Message-Id: <20220624025621.128843-17-xuanzhuo@linux.alibaba.com>
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

virtio ring split supports resize.

Only after the new vring is successfully allocated based on the new num,
we will release the old vring. In any case, an error is returned,
indicating that the vring still points to the old vring.

In the case of an error, re-initialize(virtqueue_reinit_split()) the
virtqueue to ensure that the vring can be used.

In addition, vring_align, may_reduce_num are necessary for reallocating
vring, so they are retained for creating vq.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/virtio/virtio_ring.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 8738ec690621..1ba00e73d601 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -210,6 +210,7 @@ struct vring_virtqueue {
 };
 
 static struct vring_desc_extra *vring_alloc_desc_extra(unsigned int num);
+static void vring_free(struct virtqueue *_vq);
 
 /*
  * Helpers.
@@ -1109,6 +1110,37 @@ static struct virtqueue *vring_create_virtqueue_split(
 	return vq;
 }
 
+static int virtqueue_resize_split(struct virtqueue *_vq, u32 num)
+{
+	struct vring_virtqueue *vq = to_vvq(_vq);
+	struct vring_virtqueue_split vring = {};
+	struct virtio_device *vdev = _vq->vdev;
+	int err;
+
+	err = vring_alloc_queue_split(&vring, vdev, num, vq->split.vring_align,
+				      vq->split.may_reduce_num);
+	if (err)
+		goto err;
+
+	err = vring_alloc_state_extra_split(&vring);
+	if (err) {
+		vring_free_split(&vring, vdev);
+		goto err;
+	}
+
+	vring_free(&vq->vq);
+
+	virtqueue_init(vq, vring.vring.num);
+	virtqueue_vring_attach_split(vq, &vring);
+	virtqueue_vring_init_split(vq);
+
+	return 0;
+
+err:
+	virtqueue_reinit_split(vq);
+	return -ENOMEM;
+}
+
 
 /*
  * Packed ring specific functions - *_packed().
-- 
2.31.0


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

