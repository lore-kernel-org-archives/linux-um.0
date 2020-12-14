Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1komed-0005J3-3O
 for linux-um@lists.infradead.org; Mon, 14 Dec 2020 12:08:41 +0000
From: Johannes Berg <johannes@sipsolutions.net>
Subject: [PATCH 2/4] um: virtio: disable VQs during suspend
Date: Mon, 14 Dec 2020 13:08:24 +0100
Message-Id: <20201214130826.a9726e6f6304.If62b5749ee500e51ad4b86910fb466c039f0ba8f@changeid>
In-Reply-To: <20201214130826.5c1b7720a11b.Ibacb1cbbdd1fa7ae866f0c3c94488dcbae01b39b@changeid>
References: <20201214130826.5c1b7720a11b.Ibacb1cbbdd1fa7ae866f0c3c94488dcbae01b39b@changeid>
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

If the system is suspended, the device shouldn't be able to send
anything to it. Disable virtqueues in suspend to simulate this,
and as we might be only using s2idle (kernel services are still
on), prevent sending anything on them as well.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 arch/um/drivers/virtio_uml.c | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/arch/um/drivers/virtio_uml.c b/arch/um/drivers/virtio_uml.c
index ead9a1aea192..c400a8e64f7c 100644
--- a/arch/um/drivers/virtio_uml.c
+++ b/arch/um/drivers/virtio_uml.c
@@ -65,6 +65,7 @@ struct virtio_uml_vq_info {
 	vq_callback_t *callback;
 	struct time_travel_event defer;
 #endif
+	bool suspended;
 };
 
 extern unsigned long long physmem_size, highmem;
@@ -722,6 +723,9 @@ static bool vu_notify(struct virtqueue *vq)
 	const uint64_t n = 1;
 	int rc;
 
+	if (info->suspended)
+		return true;
+
 	time_travel_propagate_time();
 
 	if (info->kick_fd < 0) {
@@ -1284,6 +1288,36 @@ static const struct of_device_id virtio_uml_match[] = {
 };
 MODULE_DEVICE_TABLE(of, virtio_uml_match);
 
+static int virtio_uml_suspend(struct platform_device *pdev, pm_message_t state)
+{
+	struct virtio_uml_device *vu_dev = platform_get_drvdata(pdev);
+	struct virtqueue *vq;
+
+	virtio_device_for_each_vq((&vu_dev->vdev), vq) {
+		struct virtio_uml_vq_info *info = vq->priv;
+
+		info->suspended = true;
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
+	virtio_device_for_each_vq((&vu_dev->vdev), vq) {
+		struct virtio_uml_vq_info *info = vq->priv;
+
+		info->suspended = false;
+		vhost_user_set_vring_enable(vu_dev, vq->index, true);
+	}
+
+	return 0;
+}
+
 static struct platform_driver virtio_uml_driver = {
 	.probe = virtio_uml_probe,
 	.remove = virtio_uml_remove,
@@ -1291,6 +1325,8 @@ static struct platform_driver virtio_uml_driver = {
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

