Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o4ZUo-00HUjd-QY
	for linux-um@lists.infradead.org; Fri, 24 Jun 2022 02:56:37 +0000
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: [PATCH v10 01/41] remoteproc: rename len of rpoc_vring to num
Date: Fri, 24 Jun 2022 10:55:41 +0800
Message-Id: <20220624025621.128843-2-xuanzhuo@linux.alibaba.com>
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

Rename the member len in the structure rpoc_vring to num. And remove 'in
bytes' from the comment of it. This is misleading. Because this actually
refers to the size of the virtio vring to be created. The unit is not
bytes.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/remoteproc/remoteproc_core.c   |  4 ++--
 drivers/remoteproc/remoteproc_virtio.c | 10 +++++-----
 include/linux/remoteproc.h             |  4 ++--
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
index 02a04ab34a23..2d2f3bab5888 100644
--- a/drivers/remoteproc/remoteproc_core.c
+++ b/drivers/remoteproc/remoteproc_core.c
@@ -334,7 +334,7 @@ int rproc_alloc_vring(struct rproc_vdev *rvdev, int i)
 	size_t size;
 
 	/* actual size of vring (in bytes) */
-	size = PAGE_ALIGN(vring_size(rvring->len, rvring->align));
+	size = PAGE_ALIGN(vring_size(rvring->num, rvring->align));
 
 	rsc = (void *)rproc->table_ptr + rvdev->rsc_offset;
 
@@ -401,7 +401,7 @@ rproc_parse_vring(struct rproc_vdev *rvdev, struct fw_rsc_vdev *rsc, int i)
 		return -EINVAL;
 	}
 
-	rvring->len = vring->num;
+	rvring->num = vring->num;
 	rvring->align = vring->align;
 	rvring->rvdev = rvdev;
 
diff --git a/drivers/remoteproc/remoteproc_virtio.c b/drivers/remoteproc/remoteproc_virtio.c
index 70ab496d0431..d43d74733f0a 100644
--- a/drivers/remoteproc/remoteproc_virtio.c
+++ b/drivers/remoteproc/remoteproc_virtio.c
@@ -87,7 +87,7 @@ static struct virtqueue *rp_find_vq(struct virtio_device *vdev,
 	struct fw_rsc_vdev *rsc;
 	struct virtqueue *vq;
 	void *addr;
-	int len, size;
+	int num, size;
 
 	/* we're temporarily limited to two virtqueues per rvdev */
 	if (id >= ARRAY_SIZE(rvdev->vring))
@@ -104,20 +104,20 @@ static struct virtqueue *rp_find_vq(struct virtio_device *vdev,
 
 	rvring = &rvdev->vring[id];
 	addr = mem->va;
-	len = rvring->len;
+	num = rvring->num;
 
 	/* zero vring */
-	size = vring_size(len, rvring->align);
+	size = vring_size(num, rvring->align);
 	memset(addr, 0, size);
 
 	dev_dbg(dev, "vring%d: va %pK qsz %d notifyid %d\n",
-		id, addr, len, rvring->notifyid);
+		id, addr, num, rvring->notifyid);
 
 	/*
 	 * Create the new vq, and tell virtio we're not interested in
 	 * the 'weak' smp barriers, since we're talking with a real device.
 	 */
-	vq = vring_new_virtqueue(id, len, rvring->align, vdev, false, ctx,
+	vq = vring_new_virtqueue(id, num, rvring->align, vdev, false, ctx,
 				 addr, rproc_virtio_notify, callback, name);
 	if (!vq) {
 		dev_err(dev, "vring_new_virtqueue %s failed\n", name);
diff --git a/include/linux/remoteproc.h b/include/linux/remoteproc.h
index 7c943f0a2fc4..aea79c77db0f 100644
--- a/include/linux/remoteproc.h
+++ b/include/linux/remoteproc.h
@@ -597,7 +597,7 @@ struct rproc_subdev {
 /**
  * struct rproc_vring - remoteproc vring state
  * @va:	virtual address
- * @len: length, in bytes
+ * @num: vring size
  * @da: device address
  * @align: vring alignment
  * @notifyid: rproc-specific unique vring index
@@ -606,7 +606,7 @@ struct rproc_subdev {
  */
 struct rproc_vring {
 	void *va;
-	int len;
+	int num;
 	u32 da;
 	u32 align;
 	int notifyid;
-- 
2.31.0


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

