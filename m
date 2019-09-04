Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1i5PRr-00067t-Eb
 for linux-um@lists.infradead.org; Wed, 04 Sep 2019 07:11:25 +0000
From: Johannes Berg <johannes@sipsolutions.net>
Subject: [PATCH 1/2] um: virtio: implement VHOST_USER_PROTOCOL_F_SLAVE_REQ
Date: Wed,  4 Sep 2019 09:11:15 +0200
Message-Id: <20190904071116.8204-1-johannes@sipsolutions.net>
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

Implement the communication channel for the device to notify
us of some events, and notably implement the handling of the
config updates needed for the combination of this feature
and VHOST_USER_PROTOCOL_F_CONFIG.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 arch/um/drivers/vhost_user.h |  18 ++++-
 arch/um/drivers/virtio_uml.c | 153 ++++++++++++++++++++++++++++++-----
 2 files changed, 147 insertions(+), 24 deletions(-)

diff --git a/arch/um/drivers/vhost_user.h b/arch/um/drivers/vhost_user.h
index 2a9829b0782b..8aee9919581e 100644
--- a/arch/um/drivers/vhost_user.h
+++ b/arch/um/drivers/vhost_user.h
@@ -9,7 +9,8 @@
 /* Feature bits */
 #define VHOST_USER_F_PROTOCOL_FEATURES	30
 /* Protocol feature bits */
-#define VHOST_USER_PROTOCOL_F_CONFIG	9
+#define VHOST_USER_PROTOCOL_F_SLAVE_REQ		5
+#define VHOST_USER_PROTOCOL_F_CONFIG		9
 /* Vring state index masks */
 #define VHOST_USER_VRING_INDEX_MASK	0xff
 #define VHOST_USER_VRING_POLL_MASK	BIT(8)
@@ -19,7 +20,8 @@
 /* Supported transport features */
 #define VHOST_USER_SUPPORTED_F		BIT_ULL(VHOST_USER_F_PROTOCOL_FEATURES)
 /* Supported protocol features */
-#define VHOST_USER_SUPPORTED_PROTOCOL_F	BIT_ULL(VHOST_USER_PROTOCOL_F_CONFIG)
+#define VHOST_USER_SUPPORTED_PROTOCOL_F	(BIT_ULL(VHOST_USER_PROTOCOL_F_SLAVE_REQ) | \
+					 BIT_ULL(VHOST_USER_PROTOCOL_F_CONFIG))
 
 enum vhost_user_request {
 	VHOST_USER_GET_FEATURES = 1,
@@ -49,8 +51,18 @@ enum vhost_user_request {
 	VHOST_USER_SET_CONFIG = 25,
 };
 
+enum vhost_user_slave_request {
+	VHOST_USER_SLAVE_IOTLB_MSG = 1,
+	VHOST_USER_SLAVE_CONFIG_CHANGE_MSG = 2,
+	VHOST_USER_SLAVE_VRING_HOST_NOTIFIER_MSG = 3,
+};
+
 struct vhost_user_header {
-	u32 request; /* Use enum vhost_user_request */
+	/*
+	 * Use enum vhost_user_request for outgoing messages,
+	 * uses enum vhost_user_slave_request for incoming ones.
+	 */
+	u32 request;
 	u32 flags;
 	u32 size;
 } __packed;
diff --git a/arch/um/drivers/virtio_uml.c b/arch/um/drivers/virtio_uml.c
index b4737dfddde8..a261977244b9 100644
--- a/arch/um/drivers/virtio_uml.c
+++ b/arch/um/drivers/virtio_uml.c
@@ -45,7 +45,7 @@ struct virtio_uml_device {
 	struct virtio_device vdev;
 	struct platform_device *pdev;
 
-	int sock;
+	int sock, req_fd;
 	u64 features;
 	u64 protocol_features;
 	u8 status;
@@ -101,40 +101,46 @@ static int full_read(int fd, void *buf, int len)
 	return 0;
 }
 
-static int vhost_user_recv_header(struct virtio_uml_device *vu_dev,
-				  struct vhost_user_msg *msg)
+static int vhost_user_recv_header(int fd, struct vhost_user_msg *msg)
 {
-	size_t size = sizeof(msg->header);
-	int rc;
-
-	rc = full_read(vu_dev->sock, (void *) msg, size);
-	if (rc)
-		return rc;
-	if (msg->header.flags != (VHOST_USER_FLAG_REPLY | VHOST_USER_VERSION))
-		return -EPROTO;
-	return 0;
+	return full_read(fd, msg, sizeof(msg->header));
 }
 
-static int vhost_user_recv(struct virtio_uml_device *vu_dev,
-			   struct vhost_user_msg *msg,
+static int vhost_user_recv(int fd, struct vhost_user_msg *msg,
 			   size_t max_payload_size)
 {
 	size_t size;
-	int rc = vhost_user_recv_header(vu_dev, msg);
+	int rc = vhost_user_recv_header(fd, msg);
 
 	if (rc)
 		return rc;
 	size = msg->header.size;
 	if (size > max_payload_size)
 		return -EPROTO;
-	return full_read(vu_dev->sock, (void *) &msg->payload, size);
+	return full_read(fd, &msg->payload, size);
+}
+
+static int vhost_user_recv_resp(struct virtio_uml_device *vu_dev,
+				struct vhost_user_msg *msg,
+				size_t max_payload_size)
+{
+	int rc = vhost_user_recv(vu_dev->sock, msg, max_payload_size);
+
+	if (rc)
+		return rc;
+
+	if (msg->header.flags != (VHOST_USER_FLAG_REPLY | VHOST_USER_VERSION))
+		return -EPROTO;
+
+	return 0;
 }
 
 static int vhost_user_recv_u64(struct virtio_uml_device *vu_dev,
 			       u64 *value)
 {
 	struct vhost_user_msg msg;
-	int rc = vhost_user_recv(vu_dev, &msg, sizeof(msg.payload.integer));
+	int rc = vhost_user_recv_resp(vu_dev, &msg,
+				      sizeof(msg.payload.integer));
 
 	if (rc)
 		return rc;
@@ -144,6 +150,21 @@ static int vhost_user_recv_u64(struct virtio_uml_device *vu_dev,
 	return 0;
 }
 
+static int vhost_user_recv_req(struct virtio_uml_device *vu_dev,
+			       struct vhost_user_msg *msg,
+			       size_t max_payload_size)
+{
+	int rc = vhost_user_recv(vu_dev->req_fd, msg, max_payload_size);
+
+	if (rc)
+		return rc;
+
+	if (msg->header.flags != VHOST_USER_VERSION)
+		return -EPROTO;
+
+	return 0;
+}
+
 static int vhost_user_send(struct virtio_uml_device *vu_dev,
 			   struct vhost_user_msg *msg,
 			   int *fds, size_t num_fds)
@@ -164,6 +185,16 @@ static int vhost_user_send_no_payload(struct virtio_uml_device *vu_dev,
 	return vhost_user_send(vu_dev, &msg, NULL, 0);
 }
 
+static int vhost_user_send_no_payload_fd(struct virtio_uml_device *vu_dev,
+					 u32 request, int fd)
+{
+	struct vhost_user_msg msg = {
+		.header.request = request,
+	};
+
+	return vhost_user_send(vu_dev, &msg, &fd, 1);
+}
+
 static int vhost_user_send_u64(struct virtio_uml_device *vu_dev,
 			       u32 request, u64 value)
 {
@@ -215,6 +246,68 @@ static int vhost_user_set_protocol_features(struct virtio_uml_device *vu_dev,
 				   protocol_features);
 }
 
+static irqreturn_t vu_req_interrupt(int irq, void *data)
+{
+	struct virtio_uml_device *vu_dev = data;
+	struct {
+		struct vhost_user_msg msg;
+		u8 extra_payload[512];
+	} msg;
+	int rc;
+
+	rc = vhost_user_recv_req(vu_dev, &msg.msg,
+				 sizeof(msg.msg.payload) +
+				 sizeof(msg.extra_payload));
+
+	if (rc == -EAGAIN)
+		return IRQ_NONE;
+
+	switch (msg.msg.header.request) {
+	case VHOST_USER_SLAVE_CONFIG_CHANGE_MSG:
+		virtio_config_changed(&vu_dev->vdev);
+		break;
+	case VHOST_USER_SLAVE_IOTLB_MSG:
+		/* not supported - VIRTIO_F_IOMMU_PLATFORM */
+	case VHOST_USER_SLAVE_VRING_HOST_NOTIFIER_MSG:
+		/* not supported - VHOST_USER_PROTOCOL_F_HOST_NOTIFIER */
+	default:
+		vu_err(vu_dev, "unexpected slave request %d\n",
+		       msg.msg.header.request);
+	}
+
+	return IRQ_HANDLED;
+}
+
+static int vhost_user_init_slave_req(struct virtio_uml_device *vu_dev)
+{
+	int rc, req_fds[2];
+
+	rc = os_pipe(req_fds, true, true);
+	if (rc < 0)
+		return rc;
+	vu_dev->req_fd = req_fds[0];
+
+	rc = um_request_irq(VIRTIO_IRQ, vu_dev->req_fd, IRQ_READ,
+			    vu_req_interrupt, IRQF_SHARED,
+			    vu_dev->pdev->name, vu_dev);
+	if (rc)
+		goto error;
+
+	rc = vhost_user_send_no_payload_fd(vu_dev, VHOST_USER_SET_SLAVE_REQ_FD,
+					   req_fds[1]);
+	if (rc)
+		goto error;
+
+	goto out;
+
+error:
+	os_close_file(req_fds[0]);
+out:
+	/* Close unused write end of request fds */
+	os_close_file(req_fds[1]);
+	return rc;
+}
+
 static int vhost_user_init(struct virtio_uml_device *vu_dev)
 {
 	int rc = vhost_user_set_owner(vu_dev);
@@ -233,8 +326,17 @@ static int vhost_user_init(struct virtio_uml_device *vu_dev)
 		vu_dev->protocol_features &= VHOST_USER_SUPPORTED_PROTOCOL_F;
 		rc = vhost_user_set_protocol_features(vu_dev,
 				vu_dev->protocol_features);
+		if (rc)
+			return rc;
 	}
-	return rc;
+
+	if (vu_dev->protocol_features & VHOST_USER_PROTOCOL_F_SLAVE_REQ) {
+		rc = vhost_user_init_slave_req(vu_dev);
+		if (rc)
+			return rc;
+	}
+
+	return 0;
 }
 
 static void vhost_user_get_config(struct virtio_uml_device *vu_dev,
@@ -265,7 +367,7 @@ static void vhost_user_get_config(struct virtio_uml_device *vu_dev,
 		goto free;
 	}
 
-	rc = vhost_user_recv(vu_dev, msg, msg_size);
+	rc = vhost_user_recv_resp(vu_dev, msg, msg_size);
 	if (rc) {
 		vu_err(vu_dev,
 		       "receiving VHOST_USER_GET_CONFIG response failed: %d\n",
@@ -719,6 +821,14 @@ static const struct virtio_config_ops virtio_uml_config_ops = {
 	.bus_name = vu_bus_name,
 };
 
+static void vhost_user_exit(struct virtio_uml_device *vu_dev)
+{
+	if (vu_dev->req_fd >= 0) {
+		um_free_irq(VIRTIO_IRQ, vu_dev);
+		os_close_file(vu_dev->req_fd);
+	}
+	os_close_file(vu_dev->sock);
+}
 
 static void virtio_uml_release_dev(struct device *d)
 {
@@ -726,7 +836,7 @@ static void virtio_uml_release_dev(struct device *d)
 			container_of(d, struct virtio_device, dev);
 	struct virtio_uml_device *vu_dev = to_virtio_uml_device(vdev);
 
-	os_close_file(vu_dev->sock);
+	vhost_user_exit(vu_dev);
 }
 
 /* Platform device */
@@ -755,6 +865,7 @@ static int virtio_uml_probe(struct platform_device *pdev)
 	vu_dev->vdev.id.device = pdata->virtio_device_id;
 	vu_dev->vdev.id.vendor = VIRTIO_DEV_ANY_ID;
 	vu_dev->pdev = pdev;
+	vu_dev->req_fd = -1;
 
 	do {
 		rc = os_connect_socket(pdata->socket_path);
@@ -775,7 +886,7 @@ static int virtio_uml_probe(struct platform_device *pdev)
 	return rc;
 
 error_init:
-	os_close_file(vu_dev->sock);
+	vhost_user_exit(vu_dev);
 	return rc;
 }
 
-- 
2.20.1


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

