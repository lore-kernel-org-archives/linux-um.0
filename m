Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from out30-44.freemail.mail.aliyun.com ([115.124.30.44])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nN9EC-00HF41-VL
 for linux-um@lists.infradead.org; Thu, 24 Feb 2022 08:11:58 +0000
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: [PATCH v6 23/26] virtio_net: split free_unused_bufs()
Date: Thu, 24 Feb 2022 16:10:59 +0800
Message-Id: <20220224081102.80224-24-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20220224081102.80224-1-xuanzhuo@linux.alibaba.com>
References: <20220224081102.80224-1-xuanzhuo@linux.alibaba.com>
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

This patch separates two functions for freeing sq buf and rq buf from
free_unused_bufs().

When supporting the enable/disable tx/rq queue in the future, it is
necessary to support separate recovery of a sq buf or a rq buf.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/net/virtio_net.c | 53 +++++++++++++++++++++++-----------------
 1 file changed, 31 insertions(+), 22 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 59b1ea82f5f0..409a8e180918 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -2804,36 +2804,45 @@ static void free_receive_page_frags(struct virtnet_info *vi)
 			put_page(vi->rq[i].alloc_frag.page);
 }
 
-static void free_unused_bufs(struct virtnet_info *vi)
+static void virtnet_sq_free_unused_bufs(struct virtnet_info *vi,
+					struct send_queue *sq)
 {
 	void *buf;
-	int i;
 
-	for (i = 0; i < vi->max_queue_pairs; i++) {
-		struct virtqueue *vq = vi->sq[i].vq;
-		while ((buf = virtqueue_detach_unused_buf(vq)) != NULL) {
-			if (!is_xdp_frame(buf))
-				dev_kfree_skb(buf);
-			else
-				xdp_return_frame(ptr_to_xdp(buf));
-		}
+	while ((buf = virtqueue_detach_unused_buf(sq->vq)) != NULL) {
+		if (!is_xdp_frame(buf))
+			dev_kfree_skb(buf);
+		else
+			xdp_return_frame(ptr_to_xdp(buf));
 	}
+}
 
-	for (i = 0; i < vi->max_queue_pairs; i++) {
-		struct virtqueue *vq = vi->rq[i].vq;
-
-		while ((buf = virtqueue_detach_unused_buf(vq)) != NULL) {
-			if (vi->mergeable_rx_bufs) {
-				put_page(virt_to_head_page(buf));
-			} else if (vi->big_packets) {
-				give_pages(&vi->rq[i], buf);
-			} else {
-				put_page(virt_to_head_page(buf));
-			}
-		}
+static void virtnet_rq_free_unused_bufs(struct virtnet_info *vi,
+					struct receive_queue *rq)
+{
+	void *buf;
+
+	while ((buf = virtqueue_detach_unused_buf(rq->vq)) != NULL) {
+		if (vi->mergeable_rx_bufs)
+			put_page(virt_to_head_page(buf));
+		else if (vi->big_packets)
+			give_pages(rq, buf);
+		else
+			put_page(virt_to_head_page(buf));
 	}
 }
 
+static void free_unused_bufs(struct virtnet_info *vi)
+{
+	int i;
+
+	for (i = 0; i < vi->max_queue_pairs; i++)
+		virtnet_sq_free_unused_bufs(vi, vi->sq + i);
+
+	for (i = 0; i < vi->max_queue_pairs; i++)
+		virtnet_rq_free_unused_bufs(vi, vi->rq + i);
+}
+
 static void virtnet_del_vqs(struct virtnet_info *vi)
 {
 	struct virtio_device *vdev = vi->vdev;
-- 
2.31.0


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

