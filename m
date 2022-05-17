Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nr4Bo-00Fq3z-MK
 for linux-um@lists.infradead.org; Tue, 17 May 2022 20:53:10 +0000
From: Johannes Berg <johannes@sipsolutions.net>
Subject: [PATCH] um: virtio_uml: fix broken device handling in time-travel
Date: Tue, 17 May 2022 22:52:50 +0200
Message-Id: <20220517225250.d454a961a57a.I4d2d8515d26a87639e1db4e48cc225f16121ee65@changeid>
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

If a device implementation crashes, virtio_uml will mark it
as dead by calling virtio_break_device() and scheduling the
work that will remove it.

This still seems like the right thing to do, but it's done
directly while reading the message, and if time-travel is
used, this is in the time-travel handler, outside of the
normal Linux machinery. Therefore, we cannot acquire locks
or do normal "linux-y" things because e.g. lockdep will be
confused about the context.

Move handling this situation out of the read function and
into the actual IRQ handler and response handling instead,
so that in the case of time-travel we don't call it in the
wrong context.

Chances are the system will still crash immediately, since
the device implementation crashing may also cause the time-
travel controller to go down, but at least all of that now
happens without strange warnings from lockdep.

Fixes: c8177aba37ca ("um: time-travel: rework interrupt handling in ext mode")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 arch/um/drivers/virtio_uml.c | 33 +++++++++++++++++++++++----------
 1 file changed, 23 insertions(+), 10 deletions(-)

diff --git a/arch/um/drivers/virtio_uml.c b/arch/um/drivers/virtio_uml.c
index ba562d68dc04..82ff3785bf69 100644
--- a/arch/um/drivers/virtio_uml.c
+++ b/arch/um/drivers/virtio_uml.c
@@ -63,6 +63,7 @@ struct virtio_uml_device {
 
 	u8 config_changed_irq:1;
 	uint64_t vq_irq_vq_map;
+	int recv_rc;
 };
 
 struct virtio_uml_vq_info {
@@ -148,14 +149,6 @@ static int vhost_user_recv(struct virtio_uml_device *vu_dev,
 
 	rc = vhost_user_recv_header(fd, msg);
 
-	if (rc == -ECONNRESET && vu_dev->registered) {
-		struct virtio_uml_platform_data *pdata;
-
-		pdata = vu_dev->pdata;
-
-		virtio_break_device(&vu_dev->vdev);
-		schedule_work(&pdata->conn_broken_wk);
-	}
 	if (rc)
 		return rc;
 	size = msg->header.size;
@@ -164,6 +157,21 @@ static int vhost_user_recv(struct virtio_uml_device *vu_dev,
 	return full_read(fd, &msg->payload, size, false);
 }
 
+static void vhost_user_check_reset(struct virtio_uml_device *vu_dev,
+				   int rc)
+{
+	struct virtio_uml_platform_data *pdata = vu_dev->pdata;
+
+	if (rc != -ECONNRESET)
+		return;
+
+	if (!vu_dev->registered)
+		return;
+
+	virtio_break_device(&vu_dev->vdev);
+	schedule_work(&pdata->conn_broken_wk);
+}
+
 static int vhost_user_recv_resp(struct virtio_uml_device *vu_dev,
 				struct vhost_user_msg *msg,
 				size_t max_payload_size)
@@ -171,8 +179,10 @@ static int vhost_user_recv_resp(struct virtio_uml_device *vu_dev,
 	int rc = vhost_user_recv(vu_dev, vu_dev->sock, msg,
 				 max_payload_size, true);
 
-	if (rc)
+	if (rc) {
+		vhost_user_check_reset(vu_dev, rc);
 		return rc;
+	}
 
 	if (msg->header.flags != (VHOST_USER_FLAG_REPLY | VHOST_USER_VERSION))
 		return -EPROTO;
@@ -369,6 +379,7 @@ static irqreturn_t vu_req_read_message(struct virtio_uml_device *vu_dev,
 				 sizeof(msg.msg.payload) +
 				 sizeof(msg.extra_payload));
 
+	vu_dev->recv_rc = rc;
 	if (rc)
 		return IRQ_NONE;
 
@@ -412,7 +423,9 @@ static irqreturn_t vu_req_interrupt(int irq, void *data)
 	if (!um_irq_timetravel_handler_used())
 		ret = vu_req_read_message(vu_dev, NULL);
 
-	if (vu_dev->vq_irq_vq_map) {
+	if (vu_dev->recv_rc) {
+		vhost_user_check_reset(vu_dev, vu_dev->recv_rc);
+	} else if (vu_dev->vq_irq_vq_map) {
 		struct virtqueue *vq;
 
 		virtio_device_for_each_vq((&vu_dev->vdev), vq) {
-- 
2.36.1


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

