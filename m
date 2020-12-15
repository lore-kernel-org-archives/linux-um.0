Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kp70T-0005VV-Oi
 for linux-um@lists.infradead.org; Tue, 15 Dec 2020 09:52:34 +0000
From: Johannes Berg <johannes@sipsolutions.net>
Subject: [PATCH v2 1/5] um: virtio: clean up a comment
Date: Tue, 15 Dec 2020 10:52:21 +0100
Message-Id: <20201215105225.5c1b7720a11b.Ibacb1cbbdd1fa7ae866f0c3c94488dcbae01b39b@changeid>
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

There's no 'simtime' device, because implementing that through
virtio was just too much complexity. Clean up the comment that
still refers to it.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 arch/um/drivers/virtio_uml.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/um/drivers/virtio_uml.c b/arch/um/drivers/virtio_uml.c
index 27e92d3881ff..ead9a1aea192 100644
--- a/arch/um/drivers/virtio_uml.c
+++ b/arch/um/drivers/virtio_uml.c
@@ -914,8 +914,7 @@ static struct virtqueue *vu_setup_vq(struct virtio_device *vdev,
 #ifdef CONFIG_UML_TIME_TRAVEL_SUPPORT
 	/*
 	 * When we get an interrupt, we must bounce it through the simulation
-	 * calendar (the simtime device), except for the simtime device itself
-	 * since that's part of the simulation control.
+	 * calendar (the time-travel=ext:... socket).
 	 */
 	if (time_travel_mode == TT_MODE_EXTERNAL && callback) {
 		info->callback = callback;
-- 
2.26.2


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

