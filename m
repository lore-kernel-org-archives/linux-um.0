Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kgDyH-0008EC-D2
 for linux-um@lists.infradead.org; Fri, 20 Nov 2020 21:29:34 +0000
From: Johannes Berg <johannes@sipsolutions.net>
Subject: [PATCH 3/4] um: virtio: disable VQs during suspend if in-band kick is
 used
Date: Fri, 20 Nov 2020 22:29:20 +0100
Message-Id: <20201120222625.bd91fe57e2b3.If62b5749ee500e51ad4b86910fb466c039f0ba8f@changeid>
In-Reply-To: <20201120212921.880781-1-johannes@sipsolutions.net>
References: <20201120212921.880781-1-johannes@sipsolutions.net>
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

If we're suspended, we'll not be handling interrupts. This is
fine if the interrupts are not in-band, since then they just
pile up on the eventfd, which just counts.

However, if we're using in-band messages, then the messages
will pile up and eventually block, or worse, if we negotiated
ACKs then we'll never ACK them and things get stuck.

To avoid this, disable virtqueues in suspend, and as we may
only suspend to idle (kernel services are still on), prevent
sending anything on them as well.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 arch/um/drivers/virtio_uml.c | 44 ++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/arch/um/drivers/virtio_uml.c b/arch/um/drivers/virtio_uml.c
index a6c4bb6c2c01..9404314aa6a9 100644
--- a/arch/um/drivers/virtio_uml.c
+++ b/arch/um/drivers/virtio_uml.c
@@ -70,6 +70,7 @@ struct virtio_uml_vq_info {
 	vq_callback_t *callback;
 	struct time_travel_event defer;
 #endif
+	bool disabled;
 };
 
 extern unsigned long long physmem_size, highmem;
@@ -725,6 +726,9 @@ static bool vu_notify(struct virtqueue *vq)
 	const uint64_t n = 1;
 	int rc;
 
+	if (info->disabled)
+		return true;
+
 	time_travel_propagate_time();
 
 	if (info->kick_fd < 0) {
@@ -1284,6 +1288,44 @@ static const struct of_device_id virtio_uml_match[] = {
 };
 MODULE_DEVICE_TABLE(of, virtio_uml_match);
 
+static int virtio_uml_suspend(struct platform_device *pdev, pm_message_t state)
+{
+	struct virtio_uml_device *vu_dev = platform_get_drvdata(pdev);
+	struct virtqueue *vq;
+
+	if (!(vu_dev->protocol_features &
+			BIT_ULL(VHOST_USER_PROTOCOL_F_INBAND_NOTIFICATIONS)))
+		return 0;
+
+	virtio_device_for_each_vq((&vu_dev->vdev), vq) {
+		struct virtio_uml_vq_info *info = vq->priv;
+
+		info->disabled = true;
+		vhost_user_set_vring_enable(vu_dev, vq->index, false);
+	}
+
+	return 0;
+}
+
+static int virtio_uml_resume(struct platform_device *pdev)
+{
+	struct virtio_uml_device *vu_dev = platform_get_drvdata(pdev);
+	struct virtqueue *vq;
+
+	if (!(vu_dev->protocol_features &
+			BIT_ULL(VHOST_USER_PROTOCOL_F_INBAND_NOTIFICATIONS)))
+		return 0;
+
+	virtio_device_for_each_vq((&vu_dev->vdev), vq) {
+		struct virtio_uml_vq_info *info = vq->priv;
+
+		info->disabled = false;
+		vhost_user_set_vring_enable(vu_dev, vq->index, true);
+	}
+
+	return 0;
+}
+
 static struct platform_driver virtio_uml_driver = {
 	.probe = virtio_uml_probe,
 	.remove = virtio_uml_remove,
@@ -1291,6 +1333,8 @@ static struct platform_driver virtio_uml_driver = {
 		.name = "virtio-uml",
 		.of_match_table = virtio_uml_match,
 	},
+	.suspend = virtio_uml_suspend,
+	.resume = virtio_uml_resume,
 };
 
 static int __init virtio_uml_init(void)
-- 
2.26.2


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

