Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from out30-43.freemail.mail.aliyun.com ([115.124.30.43])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nRZ4D-004NQK-Oq
 for linux-um@lists.infradead.org; Tue, 08 Mar 2022 12:35:55 +0000
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: [PATCH v7 13/26] virtio: queue_reset: struct virtio_config_ops add
 callbacks for queue_reset
Date: Tue,  8 Mar 2022 20:35:05 +0800
Message-Id: <20220308123518.33800-14-xuanzhuo@linux.alibaba.com>
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

Performing reset on a queue is divided into four steps:

 1. reset_vq()                     - notify the device to reset the queue
 2. virtqueue_detach_unused_buf()  - recycle the buffer submitted
 3. virtqueue_reset_vring()        - reset the vring (may re-alloc)
 4. enable_reset_vq()              - mmap vring to device, and enable the queue

So add two callbacks reset_vq, enable_reset_vq to struct
virtio_config_ops.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 include/linux/virtio_config.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
index 4d107ad31149..d51906b1389f 100644
--- a/include/linux/virtio_config.h
+++ b/include/linux/virtio_config.h
@@ -74,6 +74,15 @@ struct virtio_shm_region {
  * @set_vq_affinity: set the affinity for a virtqueue (optional).
  * @get_vq_affinity: get the affinity for a virtqueue (optional).
  * @get_shm_region: get a shared memory region based on the index.
+ * @reset_vq: reset a queue individually (optional).
+ *	vq: the virtqueue
+ *	Returns 0 on success or error status
+ *	Caller should guarantee that the vring is not accessed by any functions
+ *	of virtqueue.
+ * @enable_reset_vq: enable a reset queue
+ *	vq: the virtqueue
+ *	Returns 0 on success or error status
+ *	If reset_vq is set, then enable_reset_vq must also be set.
  */
 typedef void vq_callback_t(struct virtqueue *);
 struct virtio_config_ops {
@@ -100,6 +109,8 @@ struct virtio_config_ops {
 			int index);
 	bool (*get_shm_region)(struct virtio_device *vdev,
 			       struct virtio_shm_region *region, u8 id);
+	int (*reset_vq)(struct virtqueue *vq);
+	int (*enable_reset_vq)(struct virtqueue *vq);
 };
 
 /* If driver didn't advertise the feature, it will never appear. */
-- 
2.31.0


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

