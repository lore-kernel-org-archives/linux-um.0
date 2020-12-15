Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kp70U-0005VY-9x
 for linux-um@lists.infradead.org; Tue, 15 Dec 2020 09:52:35 +0000
From: Johannes Berg <johannes@sipsolutions.net>
Subject: [PATCH v2 5/5] um: virtio: allow devices to be configured for wakeup
Date: Tue, 15 Dec 2020 10:52:25 +0100
Message-Id: <20201215105225.a6aab14dfbe9.I2279a1ab566499554b882c07ed27e5199f991b56@changeid>
In-Reply-To: <20201215105225.5c1b7720a11b.Ibacb1cbbdd1fa7ae866f0c3c94488dcbae01b39b@changeid>
References: <20201215105225.5c1b7720a11b.Ibacb1cbbdd1fa7ae866f0c3c94488dcbae01b39b@changeid>
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

With all the IRQ machinery being in place, we can allow virtio
devices to additionally be configured as wakeup sources, in
which case basically any interrupt from them wakes us up. Note
that this requires a call FD because the VQs are all disabled.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
v2: let only devices configured for wakeup add an irq event
---
 arch/um/drivers/virtio_uml.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/arch/um/drivers/virtio_uml.c b/arch/um/drivers/virtio_uml.c
index 492cf5115752..c870d42d7268 100644
--- a/arch/um/drivers/virtio_uml.c
+++ b/arch/um/drivers/virtio_uml.c
@@ -55,6 +55,7 @@ struct virtio_uml_device {
 	u64 protocol_features;
 	u8 status;
 	u8 registered:1;
+	u8 suspended:1;
 
 	u8 config_changed_irq:1;
 	uint64_t vq_irq_vq_map;
@@ -390,7 +391,7 @@ static irqreturn_t vu_req_read_message(struct virtio_uml_device *vu_dev,
 		       msg.msg.header.request);
 	}
 
-	if (ev)
+	if (ev && !vu_dev->suspended)
 		time_travel_add_irq_event(ev);
 
 	if (msg.msg.header.flags & VHOST_USER_FLAG_NEED_REPLY)
@@ -1134,6 +1135,8 @@ static int virtio_uml_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, vu_dev);
 
+	device_set_wakeup_capable(&vu_dev->vdev.dev, true);
+
 	rc = register_virtio_device(&vu_dev->vdev);
 	if (rc)
 		put_device(&vu_dev->vdev.dev);
@@ -1307,7 +1310,12 @@ static int virtio_uml_suspend(struct platform_device *pdev, pm_message_t state)
 		vhost_user_set_vring_enable(vu_dev, vq->index, false);
 	}
 
-	return 0;
+	if (!device_may_wakeup(&vu_dev->vdev.dev)) {
+		vu_dev->suspended = true;
+		return 0;
+	}
+
+	return irq_set_irq_wake(vu_dev->irq, 1);
 }
 
 static int virtio_uml_resume(struct platform_device *pdev)
@@ -1322,7 +1330,12 @@ static int virtio_uml_resume(struct platform_device *pdev)
 		vhost_user_set_vring_enable(vu_dev, vq->index, true);
 	}
 
-	return 0;
+	vu_dev->suspended = false;
+
+	if (!device_may_wakeup(&vu_dev->vdev.dev))
+		return 0;
+
+	return irq_set_irq_wake(vu_dev->irq, 0);
 }
 
 static struct platform_driver virtio_uml_driver = {
-- 
2.26.2


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

