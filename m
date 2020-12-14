Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1komed-0005J4-3N
 for linux-um@lists.infradead.org; Mon, 14 Dec 2020 12:08:40 +0000
From: Johannes Berg <johannes@sipsolutions.net>
Subject: [PATCH 4/4] um: virtio: allow devices to be configured for wakeup
Date: Mon, 14 Dec 2020 13:08:26 +0100
Message-Id: <20201214130826.9a53945c951a.I2279a1ab566499554b882c07ed27e5199f991b56@changeid>
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

With all the IRQ machinery being in place, we can allow virtio
devices to additionally be configured as wakeup sources, in
which case basically any interrupt from them wakes us up. Note
that this requires a call FD because the VQs are all disabled.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 arch/um/drivers/virtio_uml.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/um/drivers/virtio_uml.c b/arch/um/drivers/virtio_uml.c
index 781c3943a5bd..0673795fb966 100644
--- a/arch/um/drivers/virtio_uml.c
+++ b/arch/um/drivers/virtio_uml.c
@@ -1131,6 +1131,8 @@ static int virtio_uml_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, vu_dev);
 
+	device_set_wakeup_capable(&vu_dev->vdev.dev, true);
+
 	rc = register_virtio_device(&vu_dev->vdev);
 	if (rc)
 		put_device(&vu_dev->vdev.dev);
@@ -1304,7 +1306,10 @@ static int virtio_uml_suspend(struct platform_device *pdev, pm_message_t state)
 		vhost_user_set_vring_enable(vu_dev, vq->index, false);
 	}
 
-	return 0;
+	if (!device_may_wakeup(&vu_dev->vdev.dev))
+		return 0;
+
+	return irq_set_irq_wake(vu_dev->irq, 1);
 }
 
 static int virtio_uml_resume(struct platform_device *pdev)
@@ -1319,7 +1324,10 @@ static int virtio_uml_resume(struct platform_device *pdev)
 		vhost_user_set_vring_enable(vu_dev, vq->index, true);
 	}
 
-	return 0;
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

