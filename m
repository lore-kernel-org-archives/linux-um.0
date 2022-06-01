Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mx1.uni-rostock.de ([139.30.22.71])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nwQQ6-00Gw7t-Q8
	for linux-um@lists.infradead.org; Wed, 01 Jun 2022 15:38:05 +0000
From: Benjamin Beichler <benjamin.beichler@uni-rostock.de>
Subject: [PATCH] um: read multiple msg from virtio slave request fd
Date: Wed, 1 Jun 2022 15:37:22 +0000
Message-ID: <20220601153722.181427-1-benjamin.beichler@uni-rostock.de>
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
To: jdike@addtoit.com, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>
Cc: Benjamin Beichler <benjamin.beichler@uni-rostock.de>, Johannes Berg <johannes.berg@intel.com>, linux-um@lists.infradead.org, linux-kernel@vger.kernel.org

If VHOST_USER_PROTOCOL_F_INBAND_NOTIFICATIONS is activated, the user mode
linux virtio irq handler only read one msg from the corresponding socket.
This creates issues, when the device emulation creates multiple call
requests (e.g. for multiple virtqueues), as the socket buffer tend to fill
up and the call requests are delayed.

This creates a deadlock situation, when the device simulation blocks,
because of sending a msg and the kernel side blocks because of
synchronously waiting for an acknowledge of kick request.

Actually inband notifications are meant to be used in combination with the
time travel protocol, but it is not required, therefore this corner case
needs to be handled.

Anyways, in general it seems to be more natural to consume always all
messages from a socket, instead of only a single one.

Fixes: 2cd097ba8c05 ("um: virtio: Implement VHOST_USER_PROTOCOL_F_SLAVE_REQ")
Signed-off-by: Benjamin Beichler <benjamin.beichler@uni-rostock.de>
---
 arch/um/drivers/virtio_uml.c | 72 ++++++++++++++++++------------------
 1 file changed, 37 insertions(+), 35 deletions(-)

diff --git a/arch/um/drivers/virtio_uml.c b/arch/um/drivers/virtio_uml.c
index ba562d68dc04..0c171dd11414 100644
--- a/arch/um/drivers/virtio_uml.c
+++ b/arch/um/drivers/virtio_uml.c
@@ -363,45 +363,47 @@ static irqreturn_t vu_req_read_message(struct virtio_uml_device *vu_dev,
 		struct vhost_user_msg msg;
 		u8 extra_payload[512];
 	} msg;
-	int rc;
-
-	rc = vhost_user_recv_req(vu_dev, &msg.msg,
-				 sizeof(msg.msg.payload) +
-				 sizeof(msg.extra_payload));
-
-	if (rc)
-		return IRQ_NONE;
-
-	switch (msg.msg.header.request) {
-	case VHOST_USER_SLAVE_CONFIG_CHANGE_MSG:
-		vu_dev->config_changed_irq = true;
-		response = 0;
-		break;
-	case VHOST_USER_SLAVE_VRING_CALL:
-		virtio_device_for_each_vq((&vu_dev->vdev), vq) {
-			if (vq->index == msg.msg.payload.vring_state.index) {
-				response = 0;
-				vu_dev->vq_irq_vq_map |= BIT_ULL(vq->index);
-				break;
+	irqreturn_t rc = IRQ_NONE;
+
+	while (1) {
+		if (vhost_user_recv_req(vu_dev, &msg.msg,
+					sizeof(msg.msg.payload)
+					+ sizeof(msg.extra_payload)))
+			break;
+
+		switch (msg.msg.header.request) {
+		case VHOST_USER_SLAVE_CONFIG_CHANGE_MSG:
+			vu_dev->config_changed_irq = true;
+			response = 0;
+			break;
+		case VHOST_USER_SLAVE_VRING_CALL:
+			virtio_device_for_each_vq((&vu_dev->vdev), vq) {
+				if (vq->index ==
+				    msg.msg.payload.vring_state.index) {
+					response = 0;
+					vu_dev->vq_irq_vq_map |=
+						BIT_ULL(vq->index);
+					break;
+				}
 			}
+			break;
+		case VHOST_USER_SLAVE_IOTLB_MSG:
+			/* not supported - VIRTIO_F_ACCESS_PLATFORM */
+		case VHOST_USER_SLAVE_VRING_HOST_NOTIFIER_MSG:
+			/* not supported - VHOST_USER_PROTOCOL_F_HOST_NOTIFIER */
+		default:
+			vu_err(vu_dev, "unexpected slave request %d\n",
+			       msg.msg.header.request);
 		}
-		break;
-	case VHOST_USER_SLAVE_IOTLB_MSG:
-		/* not supported - VIRTIO_F_ACCESS_PLATFORM */
-	case VHOST_USER_SLAVE_VRING_HOST_NOTIFIER_MSG:
-		/* not supported - VHOST_USER_PROTOCOL_F_HOST_NOTIFIER */
-	default:
-		vu_err(vu_dev, "unexpected slave request %d\n",
-		       msg.msg.header.request);
-	}
-
-	if (ev && !vu_dev->suspended)
-		time_travel_add_irq_event(ev);
 
-	if (msg.msg.header.flags & VHOST_USER_FLAG_NEED_REPLY)
-		vhost_user_reply(vu_dev, &msg.msg, response);
+		if (ev && !vu_dev->suspended)
+			time_travel_add_irq_event(ev);
 
-	return IRQ_HANDLED;
+		if (msg.msg.header.flags & VHOST_USER_FLAG_NEED_REPLY)
+			vhost_user_reply(vu_dev, &msg.msg, response);
+		rc = IRQ_HANDLED;
+	}
+	return rc;
 }
 
 static irqreturn_t vu_req_interrupt(int irq, void *data)
-- 
2.25.1

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

