Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oIP6J-0030OU-S8
	for linux-um@lists.infradead.org; Mon, 01 Aug 2022 06:40:30 +0000
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: [PATCH v14 41/42] virtio_net: support tx queue resize
Date: Mon,  1 Aug 2022 14:39:01 +0800
Message-Id: <20220801063902.129329-42-xuanzhuo@linux.alibaba.com>
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

This patch implements the resize function of the tx queues.
Based on this function, it is possible to modify the ring num of the
queue.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Acked-by: Jason Wang <jasowang@redhat.com>
---
 drivers/net/virtio_net.c | 47 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 1115a8b59a08..d1e6940b46d8 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -135,6 +135,9 @@ struct send_queue {
 	struct virtnet_sq_stats stats;
 
 	struct napi_struct napi;
+
+	/* Record whether sq is in reset state. */
+	bool reset;
 };
 
 /* Internal representation of a receive virtqueue */
@@ -279,6 +282,7 @@ struct padded_vnet_hdr {
 };
 
 static void virtnet_rq_free_unused_buf(struct virtqueue *vq, void *buf);
+static void virtnet_sq_free_unused_buf(struct virtqueue *vq, void *buf);
 
 static bool is_xdp_frame(void *ptr)
 {
@@ -1603,6 +1607,11 @@ static void virtnet_poll_cleantx(struct receive_queue *rq)
 		return;
 
 	if (__netif_tx_trylock(txq)) {
+		if (sq->reset) {
+			__netif_tx_unlock(txq);
+			return;
+		}
+
 		do {
 			virtqueue_disable_cb(sq->vq);
 			free_old_xmit_skbs(sq, true);
@@ -1868,6 +1877,44 @@ static int virtnet_rx_resize(struct virtnet_info *vi,
 	return err;
 }
 
+static int virtnet_tx_resize(struct virtnet_info *vi,
+			     struct send_queue *sq, u32 ring_num)
+{
+	struct netdev_queue *txq;
+	int err, qindex;
+
+	qindex = sq - vi->sq;
+
+	virtnet_napi_tx_disable(&sq->napi);
+
+	txq = netdev_get_tx_queue(vi->dev, qindex);
+
+	/* 1. wait all ximt complete
+	 * 2. fix the race of netif_stop_subqueue() vs netif_start_subqueue()
+	 */
+	__netif_tx_lock_bh(txq);
+
+	/* Prevent rx poll from accessing sq. */
+	sq->reset = true;
+
+	/* Prevent the upper layer from trying to send packets. */
+	netif_stop_subqueue(vi->dev, qindex);
+
+	__netif_tx_unlock_bh(txq);
+
+	err = virtqueue_resize(sq->vq, ring_num, virtnet_sq_free_unused_buf);
+	if (err)
+		netdev_err(vi->dev, "resize tx fail: tx queue index: %d err: %d\n", qindex, err);
+
+	__netif_tx_lock_bh(txq);
+	sq->reset = false;
+	netif_tx_wake_queue(txq);
+	__netif_tx_unlock_bh(txq);
+
+	virtnet_napi_tx_enable(vi, sq->vq, &sq->napi);
+	return err;
+}
+
 /*
  * Send command via the control virtqueue and check status.  Commands
  * supported by the hypervisor, as indicated by feature bits, should
-- 
2.31.0


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

