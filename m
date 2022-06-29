Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o6Re4-009wvp-8N
	for linux-um@lists.infradead.org; Wed, 29 Jun 2022 06:57:54 +0000
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: [PATCH v11 23/40] virtio_pci: move struct virtio_pci_common_cfg to virtio_pci_modern.h
Date: Wed, 29 Jun 2022 14:56:39 +0800
Message-Id: <20220629065656.54420-24-xuanzhuo@linux.alibaba.com>
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

In order to facilitate the expansion of virtio_pci_common_cfg in the
future, move it from uapi to virtio_pci_modern.h. In this way, we can
freely expand virtio_pci_common_cfg in the future.

Other projects using virtio_pci_common_cfg in uapi need to maintain a
separate virtio_pci_common_cfg or use the offset macro defined in uapi.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 include/linux/virtio_pci_modern.h | 26 ++++++++++++++++++++++++++
 include/uapi/linux/virtio_pci.h   | 26 --------------------------
 2 files changed, 26 insertions(+), 26 deletions(-)

diff --git a/include/linux/virtio_pci_modern.h b/include/linux/virtio_pci_modern.h
index eb2bd9b4077d..c4f7ffbacb4e 100644
--- a/include/linux/virtio_pci_modern.h
+++ b/include/linux/virtio_pci_modern.h
@@ -5,6 +5,32 @@
 #include <linux/pci.h>
 #include <linux/virtio_pci.h>
 
+/* Fields in VIRTIO_PCI_CAP_COMMON_CFG: */
+struct virtio_pci_common_cfg {
+	/* About the whole device. */
+	__le32 device_feature_select;	/* read-write */
+	__le32 device_feature;		/* read-only */
+	__le32 guest_feature_select;	/* read-write */
+	__le32 guest_feature;		/* read-write */
+	__le16 msix_config;		/* read-write */
+	__le16 num_queues;		/* read-only */
+	__u8 device_status;		/* read-write */
+	__u8 config_generation;		/* read-only */
+
+	/* About a specific virtqueue. */
+	__le16 queue_select;		/* read-write */
+	__le16 queue_size;		/* read-write, power of 2. */
+	__le16 queue_msix_vector;	/* read-write */
+	__le16 queue_enable;		/* read-write */
+	__le16 queue_notify_off;	/* read-only */
+	__le32 queue_desc_lo;		/* read-write */
+	__le32 queue_desc_hi;		/* read-write */
+	__le32 queue_avail_lo;		/* read-write */
+	__le32 queue_avail_hi;		/* read-write */
+	__le32 queue_used_lo;		/* read-write */
+	__le32 queue_used_hi;		/* read-write */
+};
+
 struct virtio_pci_modern_device {
 	struct pci_dev *pci_dev;
 
diff --git a/include/uapi/linux/virtio_pci.h b/include/uapi/linux/virtio_pci.h
index 3a86f36d7e3d..247ec42af2c8 100644
--- a/include/uapi/linux/virtio_pci.h
+++ b/include/uapi/linux/virtio_pci.h
@@ -140,32 +140,6 @@ struct virtio_pci_notify_cap {
 	__le32 notify_off_multiplier;	/* Multiplier for queue_notify_off. */
 };
 
-/* Fields in VIRTIO_PCI_CAP_COMMON_CFG: */
-struct virtio_pci_common_cfg {
-	/* About the whole device. */
-	__le32 device_feature_select;	/* read-write */
-	__le32 device_feature;		/* read-only */
-	__le32 guest_feature_select;	/* read-write */
-	__le32 guest_feature;		/* read-write */
-	__le16 msix_config;		/* read-write */
-	__le16 num_queues;		/* read-only */
-	__u8 device_status;		/* read-write */
-	__u8 config_generation;		/* read-only */
-
-	/* About a specific virtqueue. */
-	__le16 queue_select;		/* read-write */
-	__le16 queue_size;		/* read-write, power of 2. */
-	__le16 queue_msix_vector;	/* read-write */
-	__le16 queue_enable;		/* read-write */
-	__le16 queue_notify_off;	/* read-only */
-	__le32 queue_desc_lo;		/* read-write */
-	__le32 queue_desc_hi;		/* read-write */
-	__le32 queue_avail_lo;		/* read-write */
-	__le32 queue_avail_hi;		/* read-write */
-	__le32 queue_used_lo;		/* read-write */
-	__le32 queue_used_hi;		/* read-write */
-};
-
 /* Fields in VIRTIO_PCI_CAP_PCI_CFG: */
 struct virtio_pci_cfg_cap {
 	struct virtio_pci_cap cap;
-- 
2.31.0


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

