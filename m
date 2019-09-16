Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by bombadil.infradead.org with esmtps (Exim 4.92.2 #3 (Red Hat Linux))
 id 1i9qlr-0004Nz-Pb
 for linux-um@lists.infradead.org; Mon, 16 Sep 2019 13:10:25 +0000
From: Johannes Berg <johannes@sipsolutions.net>
Subject: [RFC 2/3] um: virtio: wrap irq request/free functions
Date: Mon, 16 Sep 2019 15:10:17 +0200
Message-Id: <1568639418-Idb5cc482e329c30eff3b4f53e5f86d60cb078738@changeid>
In-Reply-To: <1568639418-I895f9019593bd579566f14e5af9346e3c9b56f28@changeid>
References: <1568639418-I895f9019593bd579566f14e5af9346e3c9b56f28@changeid>
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
Cc: Johannes Berg <johannes.berg@intel.com>

From: Johannes Berg <johannes.berg@intel.com>

For the time-travel=virtio patch, we need some different
logic here - just split out the refactoring to make the
review easier.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 arch/um/drivers/virtio_uml.c | 32 +++++++++++++++++++++++---------
 1 file changed, 23 insertions(+), 9 deletions(-)

diff --git a/arch/um/drivers/virtio_uml.c b/arch/um/drivers/virtio_uml.c
index f25bcd147c6b..c23129b1c220 100644
--- a/arch/um/drivers/virtio_uml.c
+++ b/arch/um/drivers/virtio_uml.c
@@ -373,6 +373,20 @@ static irqreturn_t vu_req_interrupt(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
+static int vu_request_irq(struct virtio_uml_device *vu_dev,
+			  int fd, irq_handler_t handler,
+			  const char *name, void *data)
+{
+	return um_request_irq(VIRTIO_IRQ, fd, IRQ_READ, handler,
+			      IRQF_SHARED, name, data);
+}
+
+static void vu_free_irq(struct virtio_uml_device *vu_dev,
+			int fd, void *data)
+{
+	um_free_irq(VIRTIO_IRQ, data);
+}
+
 static int vhost_user_init_slave_req(struct virtio_uml_device *vu_dev)
 {
 	int rc, req_fds[2];
@@ -383,8 +397,7 @@ static int vhost_user_init_slave_req(struct virtio_uml_device *vu_dev)
 		return rc;
 	vu_dev->req_fd = req_fds[0];
 
-	rc = um_request_irq(VIRTIO_IRQ, vu_dev->req_fd, IRQ_READ,
-			    vu_req_interrupt, IRQF_SHARED,
+	rc = vu_request_irq(vu_dev, vu_dev->req_fd, vu_req_interrupt,
 			    vu_dev->pdev->name, vu_dev);
 	if (rc)
 		goto err_close;
@@ -397,7 +410,7 @@ static int vhost_user_init_slave_req(struct virtio_uml_device *vu_dev)
 	goto out;
 
 err_free_irq:
-	um_free_irq(VIRTIO_IRQ, vu_dev);
+	vu_free_irq(vu_dev, vu_dev->req_fd, vu_dev);
 err_close:
 	os_close_file(req_fds[0]);
 out:
@@ -771,10 +784,11 @@ static void vu_reset(struct virtio_device *vdev)
 
 static void vu_del_vq(struct virtqueue *vq)
 {
+	struct virtio_uml_device *vu_dev = to_virtio_uml_device(vq->vdev);
 	struct virtio_uml_vq_info *info = vq->priv;
 
 	if (info->call_fd >= 0) {
-		um_free_irq(VIRTIO_IRQ, vq);
+		vu_free_irq(vu_dev, info->call_fd, vq);
 		os_close_file(info->call_fd);
 	}
 
@@ -824,8 +838,8 @@ static int vu_setup_vq_call_fd(struct virtio_uml_device *vu_dev,
 		return rc;
 
 	info->call_fd = call_fds[0];
-	rc = um_request_irq(VIRTIO_IRQ, info->call_fd, IRQ_READ,
-			    vu_interrupt, IRQF_SHARED, info->name, vq);
+	rc = vu_request_irq(vu_dev, info->call_fd, vu_interrupt,
+			    info->name, vq);
 	if (rc)
 		goto close_both;
 
@@ -836,7 +850,7 @@ static int vu_setup_vq_call_fd(struct virtio_uml_device *vu_dev,
 	goto out;
 
 release_irq:
-	um_free_irq(VIRTIO_IRQ, vq);
+	vu_free_irq(vu_dev, info->call_fd, vq);
 close_both:
 	os_close_file(call_fds[0]);
 out:
@@ -908,7 +922,7 @@ static struct virtqueue *vu_setup_vq(struct virtio_device *vdev,
 
 error_setup:
 	if (info->call_fd >= 0) {
-		um_free_irq(VIRTIO_IRQ, vq);
+		vu_free_irq(vu_dev, info->call_fd, vq);
 		os_close_file(info->call_fd);
 	}
 error_call:
@@ -1015,7 +1029,7 @@ static void virtio_uml_release_dev(struct device *d)
 
 	/* might not have been opened due to not negotiating the feature */
 	if (vu_dev->req_fd >= 0) {
-		um_free_irq(VIRTIO_IRQ, vu_dev);
+		vu_free_irq(vu_dev, vu_dev->req_fd, vu_dev);
 		os_close_file(vu_dev->req_fd);
 	}
 
-- 
2.20.1


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

