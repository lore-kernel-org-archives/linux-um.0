Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kxcd4-0002ZM-9P
 for linux-um@lists.infradead.org; Thu, 07 Jan 2021 21:15:35 +0000
From: Johannes Berg <johannes@sipsolutions.net>
Subject: [PATCH] um: virtio: free vu_dev only with the contained struct device
Date: Thu,  7 Jan 2021 22:15:21 +0100
Message-Id: <20210107221521.11bdf4917387.I2851b5ff7f03e79264fe6cca65465247df9d9d98@changeid>
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

Since struct device is refcounted, we shouldn't free the vu_dev
immediately when it's removed from the platform device, but only
when the references actually all go away. Move the freeing to
the release to accomplish that.

Fixes: 5d38f324993f ("um: drivers: Add virtio vhost-user driver")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 arch/um/drivers/virtio_uml.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/um/drivers/virtio_uml.c b/arch/um/drivers/virtio_uml.c
index c870d42d7268..91ddf74ca888 100644
--- a/arch/um/drivers/virtio_uml.c
+++ b/arch/um/drivers/virtio_uml.c
@@ -1095,6 +1095,7 @@ static void virtio_uml_release_dev(struct device *d)
 	}
 
 	os_close_file(vu_dev->sock);
+	kfree(vu_dev);
 }
 
 /* Platform device */
@@ -1108,7 +1109,7 @@ static int virtio_uml_probe(struct platform_device *pdev)
 	if (!pdata)
 		return -EINVAL;
 
-	vu_dev = devm_kzalloc(&pdev->dev, sizeof(*vu_dev), GFP_KERNEL);
+	vu_dev = kzalloc(sizeof(*vu_dev), GFP_KERNEL);
 	if (!vu_dev)
 		return -ENOMEM;
 
-- 
2.26.2


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

