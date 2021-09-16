Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mQpGi-00Awwh-1V
 for linux-um@lists.infradead.org; Thu, 16 Sep 2021 11:09:29 +0000
From: Johannes Berg <johannes@sipsolutions.net>
Subject: [PATCH v2] um: virtio_uml: fix time-travel external time propagation
Date: Thu, 16 Sep 2021 13:09:22 +0200
Message-Id: <20210916130922.56cd8b4ab7a7.I6268ef8a313d80008f422b7ac8b52cb52554d636@changeid>
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

When creating an external event, the current time needs to
be propagated to other participants of a simulation. This
is done in the places here where we kick a virtq etc.

However, it must be done for _all_ external events, and
that includes making the initial socket connection and
later closing it. Call time_travel_propagate_time() to do
this before making or closing the socket connection.

Apparently, at least for the initial connection creation,
due to the remote side in my use cases using microseconds
(rather than nanoseconds), this wasn't a problem yet; only
started failing between 5.14-rc1 and 5.15-rc1 (didn't test
others much), or possibly depending on the configuration,
where more delays happen before the virtio devices are
initialized.

Fixes: 88ce64249233 ("um: Implement time-travel=ext")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
v2: also necessary before closing the connection
---
 arch/um/drivers/virtio_uml.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/um/drivers/virtio_uml.c b/arch/um/drivers/virtio_uml.c
index d51e445df797..7755cb4ff9fc 100644
--- a/arch/um/drivers/virtio_uml.c
+++ b/arch/um/drivers/virtio_uml.c
@@ -1090,6 +1090,8 @@ static void virtio_uml_release_dev(struct device *d)
 			container_of(d, struct virtio_device, dev);
 	struct virtio_uml_device *vu_dev = to_virtio_uml_device(vdev);
 
+	time_travel_propagate_time();
+
 	/* might not have been opened due to not negotiating the feature */
 	if (vu_dev->req_fd >= 0) {
 		um_free_irq(vu_dev->irq, vu_dev);
@@ -1136,6 +1138,8 @@ static int virtio_uml_probe(struct platform_device *pdev)
 	vu_dev->pdev = pdev;
 	vu_dev->req_fd = -1;
 
+	time_travel_propagate_time();
+
 	do {
 		rc = os_connect_socket(pdata->socket_path);
 	} while (rc == -EINTR);
-- 
2.31.1


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

