Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iN8QJ-0001nk-Pu
 for linux-um@lists.infradead.org; Wed, 23 Oct 2019 04:39:08 +0000
Received: by mail-pl1-x641.google.com with SMTP id w8so9451717plq.5
 for <linux-um@lists.infradead.org>; Tue, 22 Oct 2019 21:39:03 -0700 (PDT)
From: Hajime Tazaki <thehajime@gmail.com>
Subject: [RFC PATCH 18/47] lkl tools: host lib: virtio block device
Date: Wed, 23 Oct 2019 13:37:52 +0900
Message-Id: <5064a00a901f01008dd216e7a6cf86a179d3ce77.1571798507.git.thehajime@gmail.com>
In-Reply-To: <cover.1571798507.git.thehajime@gmail.com>
References: <cover.1571798507.git.thehajime@gmail.com>
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
To: linux-um@lists.infradead.org
Cc: Octavian Purdila <tavi.purdila@gmail.com>, Petros Angelatos <petrosagg@gmail.com>, Michael Zimmermann <sigmaepsilon92@gmail.com>, Akira Moroo <retrage01@gmail.com>

From: Octavian Purdila <tavi.purdila@gmail.com>

Host independent implementation for virtio block devices. The host
dependent part of the host library must provide an implementation for
lkl_dev_block_ops.

Disks can be added to the LKL configuration via lkl_disk_add(), a new
LKL application API.

Signed-off-by: Michael Zimmermann <sigmaepsilon92@gmail.com>
Signed-off-by: Petros Angelatos <petrosagg@gmail.com>
Signed-off-by: Octavian Purdila <tavi.purdila@gmail.com>
---
 tools/lkl/lib/virtio_blk.c | 132 +++++++++++++++++++++++++++++++++++++
 1 file changed, 132 insertions(+)
 create mode 100644 tools/lkl/lib/virtio_blk.c

diff --git a/tools/lkl/lib/virtio_blk.c b/tools/lkl/lib/virtio_blk.c
new file mode 100644
index 000000000000..9e23316c5d99
--- /dev/null
+++ b/tools/lkl/lib/virtio_blk.c
@@ -0,0 +1,132 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <lkl_host.h>
+#include "virtio.h"
+#include "endian.h"
+
+struct virtio_blk_dev {
+	struct virtio_dev dev;
+	struct lkl_virtio_blk_config config;
+	struct lkl_dev_blk_ops *ops;
+	struct lkl_disk disk;
+};
+
+struct virtio_blk_req_trailer {
+	uint8_t status;
+};
+
+static int blk_check_features(struct virtio_dev *dev)
+{
+	if (dev->driver_features == dev->device_features)
+		return 0;
+
+	return -LKL_EINVAL;
+}
+
+static int blk_enqueue(struct virtio_dev *dev, int q, struct virtio_req *req)
+{
+	struct virtio_blk_dev *blk_dev;
+	struct lkl_virtio_blk_outhdr *h;
+	struct virtio_blk_req_trailer *t;
+	struct lkl_blk_req lkl_req;
+
+	if (req->buf_count < 3) {
+		lkl_printf("virtio_blk: no status buf\n");
+		goto out;
+	}
+
+	h = req->buf[0].iov_base;
+	t = req->buf[req->buf_count - 1].iov_base;
+	blk_dev = container_of(dev, struct virtio_blk_dev, dev);
+
+	t->status = LKL_DEV_BLK_STATUS_IOERR;
+
+	if (req->buf[0].iov_len != sizeof(*h)) {
+		lkl_printf("virtio_blk: bad header buf\n");
+		goto out;
+	}
+
+	if (req->buf[req->buf_count - 1].iov_len != sizeof(*t)) {
+		lkl_printf("virtio_blk: bad status buf\n");
+		goto out;
+	}
+
+	lkl_req.type = le32toh(h->type);
+	lkl_req.prio = le32toh(h->ioprio);
+	lkl_req.sector = le32toh(h->sector);
+	lkl_req.buf = &req->buf[1];
+	lkl_req.count = req->buf_count - 2;
+
+	t->status = blk_dev->ops->request(blk_dev->disk, &lkl_req);
+
+out:
+	virtio_req_complete(req, 0);
+	return 0;
+}
+
+static struct virtio_dev_ops blk_ops = {
+	.check_features = blk_check_features,
+	.enqueue = blk_enqueue,
+};
+
+
+int lkl_disk_add(struct lkl_disk *disk)
+{
+	struct virtio_blk_dev *dev;
+	unsigned long long capacity;
+	int ret;
+
+	dev = lkl_host_ops.mem_alloc(sizeof(*dev));
+	if (!dev)
+		return -LKL_ENOMEM;
+
+	disk->dev = dev;
+
+	dev->dev.device_id = LKL_VIRTIO_ID_BLOCK;
+	dev->dev.vendor_id = 0;
+	dev->dev.device_features = 0;
+	dev->dev.config_gen = 0;
+	dev->dev.config_data = &dev->config;
+	dev->dev.config_len = sizeof(dev->config);
+	dev->dev.ops = &blk_ops;
+	if (disk->ops)
+		dev->ops = disk->ops;
+	else
+		dev->ops = &lkl_dev_blk_ops;
+	dev->disk = *disk;
+
+	ret = dev->ops->get_capacity(*disk, &capacity);
+	if (ret) {
+		ret = -LKL_ENOMEM;
+		goto out_free;
+	}
+	dev->config.capacity = capacity / 512;
+
+	ret = virtio_dev_setup(&dev->dev, 1, 32);
+	if (ret)
+		goto out_free;
+
+	return dev->dev.virtio_mmio_id;
+
+out_free:
+	lkl_host_ops.mem_free(dev);
+
+	return ret;
+}
+
+int lkl_disk_remove(struct lkl_disk disk)
+{
+	struct virtio_blk_dev *dev;
+	int ret;
+
+	dev = (struct virtio_blk_dev *)disk.dev;
+	if (!dev)
+		return -LKL_EINVAL;
+
+	ret = virtio_dev_cleanup(&dev->dev);
+	if (ret < 0)
+		return ret;
+
+	lkl_host_ops.mem_free(dev);
+
+	return 0;
+}
-- 
2.20.1 (Apple Git-117)


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

