Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mPh9Q-000gZJ-CD
 for linux-um@lists.infradead.org; Mon, 13 Sep 2021 08:17:18 +0000
From: Johannes Berg <johannes@sipsolutions.net>
Subject: [PATCH] um: virtio_uml: fix time-travel external time propagation
Date: Mon, 13 Sep 2021 10:16:55 +0200
Message-Id: <20210913101651.cdb4485c257e.I6268ef8a313d80008f422b7ac8b52cb52554d636@changeid>
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
that includes making the initial socket connection. Call
time_travel_propagate_time() to do this before making the
socket connection.

Apparently, due to the remote side in my use cases using
only microseconds (rather than nanoseconds), this wasn't a
problem yet - only started failing between 5.14-rc1 and
5.15-rc1 (didn't test others much), or possibly depending
on the configuration, where more delays happen before the
virtio devices are initialized.

Fixes: 88ce64249233 ("um: Implement time-travel=ext")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 arch/um/drivers/virtio_uml.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/um/drivers/virtio_uml.c b/arch/um/drivers/virtio_uml.c
index d51e445df797..860b7430bcff 100644
--- a/arch/um/drivers/virtio_uml.c
+++ b/arch/um/drivers/virtio_uml.c
@@ -1136,6 +1136,8 @@ static int virtio_uml_probe(struct platform_device *pdev)
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

