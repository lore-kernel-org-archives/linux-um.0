Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1j2EWI-0001vC-3L
 for linux-um@lists.infradead.org; Thu, 13 Feb 2020 13:27:10 +0000
From: Johannes Berg <johannes@sipsolutions.net>
Subject: [PATCH 3/6] um: virtio: implement
 VHOST_USER_PROTOCOL_F_INBAND_NOTIFICATIONS
Date: Thu, 13 Feb 2020 14:26:46 +0100
Message-Id: <20200213132651.20506-4-johannes@sipsolutions.net>
In-Reply-To: <20200213132651.20506-1-johannes@sipsolutions.net>
References: <20200213132651.20506-1-johannes@sipsolutions.net>
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

Implement in-band notifications that are necessary for running
vhost-user devices under externally synchronized time-travel
mode (which is in a follow-up patch). This feature makes what
usually should be eventfd notifications in-band messages.

We'll prefer this feature, under the assumption that only a
few (simulation) devices will ever support it, since it's not
very efficient.

Change-Id: I895f9019593bd579566f14e5af9346e3c9b56f28
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Reviewed-on: https://git-ger-8.devtools.intel.com/gerrit/96454
---
 arch/um/drivers/vhost_user.h | 12 +++--
 arch/um/drivers/virtio_uml.c | 85 ++++++++++++++++++++++++++++--------
 2 files changed, 75 insertions(+), 22 deletions(-)

diff --git a/arch/um/drivers/vhost_user.h b/arch/um/drivers/vhost_user.h
index 45ff5ea22fea..6c71b6005177 100644
--- a/arch/um/drivers/vhost_user.h
+++ b/arch/um/drivers/vhost_user.h
@@ -10,9 +10,10 @@
 /* Feature bits */
 #define VHOST_USER_F_PROTOCOL_FEATURES	30
 /* Protocol feature bits */
-#define VHOST_USER_PROTOCOL_F_REPLY_ACK		3
-#define VHOST_USER_PROTOCOL_F_SLAVE_REQ		5
-#define VHOST_USER_PROTOCOL_F_CONFIG		9
+#define VHOST_USER_PROTOCOL_F_REPLY_ACK			3
+#define VHOST_USER_PROTOCOL_F_SLAVE_REQ			5
+#define VHOST_USER_PROTOCOL_F_CONFIG			9
+#define VHOST_USER_PROTOCOL_F_INBAND_NOTIFICATIONS	14
 /* Vring state index masks */
 #define VHOST_USER_VRING_INDEX_MASK	0xff
 #define VHOST_USER_VRING_POLL_MASK	BIT(8)
@@ -24,7 +25,8 @@
 /* Supported protocol features */
 #define VHOST_USER_SUPPORTED_PROTOCOL_F	(BIT_ULL(VHOST_USER_PROTOCOL_F_REPLY_ACK) | \
 					 BIT_ULL(VHOST_USER_PROTOCOL_F_SLAVE_REQ) | \
-					 BIT_ULL(VHOST_USER_PROTOCOL_F_CONFIG))
+					 BIT_ULL(VHOST_USER_PROTOCOL_F_CONFIG) | \
+					 BIT_ULL(VHOST_USER_PROTOCOL_F_INBAND_NOTIFICATIONS))
 
 enum vhost_user_request {
 	VHOST_USER_GET_FEATURES = 1,
@@ -52,12 +54,14 @@ enum vhost_user_request {
 	VHOST_USER_SET_VRING_ENDIAN = 23,
 	VHOST_USER_GET_CONFIG = 24,
 	VHOST_USER_SET_CONFIG = 25,
+	VHOST_USER_VRING_KICK = 35,
 };
 
 enum vhost_user_slave_request {
 	VHOST_USER_SLAVE_IOTLB_MSG = 1,
 	VHOST_USER_SLAVE_CONFIG_CHANGE_MSG = 2,
 	VHOST_USER_SLAVE_VRING_HOST_NOTIFIER_MSG = 3,
+	VHOST_USER_SLAVE_VRING_CALL = 4,
 };
 
 struct vhost_user_header {
diff --git a/arch/um/drivers/virtio_uml.c b/arch/um/drivers/virtio_uml.c
index 023ced2250ea..9b4c5b7c0f0d 100644
--- a/arch/um/drivers/virtio_uml.c
+++ b/arch/um/drivers/virtio_uml.c
@@ -53,6 +53,7 @@ struct virtio_uml_device {
 	struct virtio_device vdev;
 	struct platform_device *pdev;
 
+	spinlock_t sock_lock;
 	int sock, req_fd;
 	u64 features;
 	u64 protocol_features;
@@ -189,6 +190,7 @@ static int vhost_user_send(struct virtio_uml_device *vu_dev,
 			   int *fds, size_t num_fds)
 {
 	size_t size = sizeof(msg->header) + msg->header.size;
+	unsigned long flags;
 	bool request_ack;
 	int rc;
 
@@ -207,24 +209,28 @@ static int vhost_user_send(struct virtio_uml_device *vu_dev,
 	if (request_ack)
 		msg->header.flags |= VHOST_USER_FLAG_NEED_REPLY;
 
+	spin_lock_irqsave(&vu_dev->sock_lock, flags);
 	rc = full_sendmsg_fds(vu_dev->sock, msg, size, fds, num_fds);
 	if (rc < 0)
-		return rc;
+		goto out;
 
 	if (request_ack) {
 		uint64_t status;
 
 		rc = vhost_user_recv_u64(vu_dev, &status);
 		if (rc)
-			return rc;
+			goto out;
 
 		if (status) {
 			vu_err(vu_dev, "slave reports error: %llu\n", status);
-			return -EIO;
+			rc = -EIO;
+			goto out;
 		}
 	}
 
-	return 0;
+out:
+	spin_unlock_irqrestore(&vu_dev->sock_lock, flags);
+	return rc;
 }
 
 static int vhost_user_send_no_payload(struct virtio_uml_device *vu_dev,
@@ -324,6 +330,7 @@ static void vhost_user_reply(struct virtio_uml_device *vu_dev,
 static irqreturn_t vu_req_interrupt(int irq, void *data)
 {
 	struct virtio_uml_device *vu_dev = data;
+	struct virtqueue *vq;
 	int response = 1;
 	struct {
 		struct vhost_user_msg msg;
@@ -343,6 +350,15 @@ static irqreturn_t vu_req_interrupt(int irq, void *data)
 		virtio_config_changed(&vu_dev->vdev);
 		response = 0;
 		break;
+	case VHOST_USER_SLAVE_VRING_CALL:
+		virtio_device_for_each_vq((&vu_dev->vdev), vq) {
+			if (vq->index == msg.msg.payload.vring_state.index) {
+				response = 0;
+				vring_interrupt(0 /* ignored */, vq);
+				break;
+			}
+		}
+		break;
 	case VHOST_USER_SLAVE_IOTLB_MSG:
 		/* not supported - VIRTIO_F_IOMMU_PLATFORM */
 	case VHOST_USER_SLAVE_VRING_HOST_NOTIFIER_MSG:
@@ -684,6 +700,15 @@ static bool vu_notify(struct virtqueue *vq)
 	const uint64_t n = 1;
 	int rc;
 
+	if (info->kick_fd < 0) {
+		struct virtio_uml_device *vu_dev;
+
+		vu_dev = to_virtio_uml_device(vq->vdev);
+
+		return vhost_user_set_vring_state(vu_dev, VHOST_USER_VRING_KICK,
+						  vq->index, 0) == 0;
+	}
+
 	do {
 		rc = os_write_file(info->kick_fd, &n, sizeof(n));
 	} while (rc == -EINTR);
@@ -749,10 +774,13 @@ static void vu_del_vq(struct virtqueue *vq)
 {
 	struct virtio_uml_vq_info *info = vq->priv;
 
-	um_free_irq(VIRTIO_IRQ, vq);
+	if (info->call_fd >= 0) {
+		um_free_irq(VIRTIO_IRQ, vq);
+		os_close_file(info->call_fd);
+	}
 
-	os_close_file(info->call_fd);
-	os_close_file(info->kick_fd);
+	if (info->kick_fd >= 0)
+		os_close_file(info->kick_fd);
 
 	vring_del_virtqueue(vq);
 	kfree(info);
@@ -782,6 +810,15 @@ static int vu_setup_vq_call_fd(struct virtio_uml_device *vu_dev,
 	int call_fds[2];
 	int rc;
 
+	/* no call FD needed/desired in this case */
+	if (vu_dev->protocol_features &
+			BIT_ULL(VHOST_USER_PROTOCOL_F_INBAND_NOTIFICATIONS) &&
+	    vu_dev->protocol_features &
+			BIT_ULL(VHOST_USER_PROTOCOL_F_SLAVE_REQ)) {
+		info->call_fd = -1;
+		return 0;
+	}
+
 	/* Use a pipe for call fd, since SIGIO is not supported for eventfd */
 	rc = os_pipe(call_fds, true, true);
 	if (rc < 0)
@@ -838,10 +875,15 @@ static struct virtqueue *vu_setup_vq(struct virtio_device *vdev,
 	vq->priv = info;
 	num = virtqueue_get_vring_size(vq);
 
-	rc = os_eventfd(0, 0);
-	if (rc < 0)
-		goto error_kick;
-	info->kick_fd = rc;
+	if (vu_dev->protocol_features &
+			BIT_ULL(VHOST_USER_PROTOCOL_F_INBAND_NOTIFICATIONS)) {
+		info->kick_fd = -1;
+	} else {
+		rc = os_eventfd(0, 0);
+		if (rc < 0)
+			goto error_kick;
+		info->kick_fd = rc;
+	}
 
 	rc = vu_setup_vq_call_fd(vu_dev, vq);
 	if (rc)
@@ -866,10 +908,13 @@ static struct virtqueue *vu_setup_vq(struct virtio_device *vdev,
 	return vq;
 
 error_setup:
-	um_free_irq(VIRTIO_IRQ, vq);
-	os_close_file(info->call_fd);
+	if (info->call_fd >= 0) {
+		um_free_irq(VIRTIO_IRQ, vq);
+		os_close_file(info->call_fd);
+	}
 error_call:
-	os_close_file(info->kick_fd);
+	if (info->kick_fd >= 0)
+		os_close_file(info->kick_fd);
 error_kick:
 	vring_del_virtqueue(vq);
 error_create:
@@ -908,10 +953,12 @@ static int vu_find_vqs(struct virtio_device *vdev, unsigned nvqs,
 	list_for_each_entry(vq, &vdev->vqs, list) {
 		struct virtio_uml_vq_info *info = vq->priv;
 
-		rc = vhost_user_set_vring_kick(vu_dev, vq->index,
-					       info->kick_fd);
-		if (rc)
-			goto error_setup;
+		if (info->kick_fd >= 0) {
+			rc = vhost_user_set_vring_kick(vu_dev, vq->index,
+						       info->kick_fd);
+			if (rc)
+				goto error_setup;
+		}
 
 		rc = vhost_user_set_vring_enable(vu_dev, vq->index, true);
 		if (rc)
@@ -1008,6 +1055,8 @@ static int virtio_uml_probe(struct platform_device *pdev)
 		return rc;
 	vu_dev->sock = rc;
 
+	spin_lock_init(&vu_dev->sock_lock);
+
 	rc = vhost_user_init(vu_dev);
 	if (rc)
 		goto error_init;
-- 
2.24.1


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

