Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34AA3D1118C
	for <linux-um@archiver.kernel.org>; Sun,  3 Nov 2024 21:30:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HK0ArEprsl2rE4uIM1vCnaQIsp9uWixkRNDuBbJArcM=; b=lLOu1yP2k0HTLuM86WNdV3FY3g
	OKfYd3Lc7+4leThiU7gXFPfnyOh5jZQj1CUumoXa1gqZ078B5zWkQJ5s1ySf7SU7RNVmFMRih0fN/
	8TLggkuHNGRxOSnYyTMkvOzhHg4W/y6aSkHZrDJtaN7trCq2nYoYiZvsKW6CvqDAHbqCat9fvO6kw
	lK5W3Yx6skyGCW6tRpMWZ4wd1OGrSNa0o9EJD3OOPMCNp7eHab/gpxrmnd8pSVLvC2eWEw5aXZ1Pv
	cqaJEXk/cWZ3JCmocf8W6bCtTaZLtWhgf5p2pcX9CuIZuckR8woj9eGopKrXARw02Y1dEyqURTf1i
	kWp6CV0A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t7iBO-0000000C4Ta-3uRj;
	Sun, 03 Nov 2024 21:30:50 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t7iBL-0000000C4Rb-46cH
	for linux-um@lists.infradead.org;
	Sun, 03 Nov 2024 21:30:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=HK0ArEprsl2rE4uIM1vCnaQIsp9uWixkRNDuBbJArcM=;
	t=1730669447; x=1731879047; b=h3plXr6ghZ2TYgZU5KKf5ahU0ni5EFDAtG0iTk9HGcoqpjg
	IhOtbTmfrkG0mpF0DlJ9r+TUN6U0AeMMKEkjUYdjviUImhO0BoJK/eAGDVUW9GZVTbpqNRUwVd7TC
	ZeozPWwBU6r+E67k/jqstjlIcppMtI5EuWDnW91OIp6I+X1nrcXgf1kPDvJV9ZbikX9WBWF5TK+k+
	+cx9ebnXCg5sRxnITAlm1gvfMsPZyGExX/KzGbpHB4HcCZSeL2eHQyNvjwbx1Ijw+XD9zA8HGRG5I
	yo4yPKeF+XcfdgQYFNWfl2dNpeDCQoGcMLEWmfE/olKDF4durc4k5Y/LEJY0nV5A==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1t7iBJ-0000000DCdx-2GkO;
	Sun, 03 Nov 2024 22:30:45 +0100
From: Benjamin Berg <benjamin@sipsolutions.net>
To: linux-um@lists.infradead.org
Cc: Benjamin Berg <benjamin.berg@intel.com>
Subject: [PATCH 4/4] um: virtio_uml: query the number of vqs if supported
Date: Sun,  3 Nov 2024 22:28:54 +0100
Message-ID: <20241103212854.1436046-5-benjamin@sipsolutions.net>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241103212854.1436046-1-benjamin@sipsolutions.net>
References: <20241103212854.1436046-1-benjamin@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241103_133048_042801_80CEED4B 
X-CRM114-Status: GOOD (  14.12  )
X-BeenThere: linux-um@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

From: Benjamin Berg <benjamin.berg@intel.com>

When the VHOST_USER_PROTOCOL_F_MQ protocol feature flag is set, we can
query the maximum number of virtual queues. Do so when supported and
extend the check to verify that we are not trying to allocate more
queues.

Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
---
 arch/um/drivers/vhost_user.h |  4 +++-
 arch/um/drivers/virtio_uml.c | 23 ++++++++++++++++++++++-
 2 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/arch/um/drivers/vhost_user.h b/arch/um/drivers/vhost_user.h
index 6f147cd3c9f7..fcfa3b7e021b 100644
--- a/arch/um/drivers/vhost_user.h
+++ b/arch/um/drivers/vhost_user.h
@@ -10,6 +10,7 @@
 /* Feature bits */
 #define VHOST_USER_F_PROTOCOL_FEATURES	30
 /* Protocol feature bits */
+#define VHOST_USER_PROTOCOL_F_MQ			0
 #define VHOST_USER_PROTOCOL_F_REPLY_ACK			3
 #define VHOST_USER_PROTOCOL_F_SLAVE_REQ			5
 #define VHOST_USER_PROTOCOL_F_CONFIG			9
@@ -23,7 +24,8 @@
 /* Supported transport features */
 #define VHOST_USER_SUPPORTED_F		BIT_ULL(VHOST_USER_F_PROTOCOL_FEATURES)
 /* Supported protocol features */
-#define VHOST_USER_SUPPORTED_PROTOCOL_F	(BIT_ULL(VHOST_USER_PROTOCOL_F_REPLY_ACK) | \
+#define VHOST_USER_SUPPORTED_PROTOCOL_F	(BIT_ULL(VHOST_USER_PROTOCOL_F_MQ) | \
+					 BIT_ULL(VHOST_USER_PROTOCOL_F_REPLY_ACK) | \
 					 BIT_ULL(VHOST_USER_PROTOCOL_F_SLAVE_REQ) | \
 					 BIT_ULL(VHOST_USER_PROTOCOL_F_CONFIG) | \
 					 BIT_ULL(VHOST_USER_PROTOCOL_F_INBAND_NOTIFICATIONS))
diff --git a/arch/um/drivers/virtio_uml.c b/arch/um/drivers/virtio_uml.c
index 5b19e9a3447a..2b130d57d36e 100644
--- a/arch/um/drivers/virtio_uml.c
+++ b/arch/um/drivers/virtio_uml.c
@@ -57,6 +57,7 @@ struct virtio_uml_device {
 	int sock, req_fd, irq;
 	u64 features;
 	u64 protocol_features;
+	u64 max_vqs;
 	u8 status;
 	u8 registered:1;
 	u8 suspended:1;
@@ -342,6 +343,17 @@ static int vhost_user_set_protocol_features(struct virtio_uml_device *vu_dev,
 				   protocol_features);
 }
 
+static int vhost_user_get_queue_num(struct virtio_uml_device *vu_dev,
+				    u64 *queue_num)
+{
+	int rc = vhost_user_send_no_payload(vu_dev, true,
+			VHOST_USER_GET_QUEUE_NUM);
+
+	if (rc)
+		return rc;
+	return vhost_user_recv_u64(vu_dev, queue_num);
+}
+
 static void vhost_user_reply(struct virtio_uml_device *vu_dev,
 			     struct vhost_user_msg *msg, int response)
 {
@@ -515,6 +527,15 @@ static int vhost_user_init(struct virtio_uml_device *vu_dev)
 			return rc;
 	}
 
+	if (vu_dev->protocol_features &
+			BIT_ULL(VHOST_USER_PROTOCOL_F_MQ)) {
+		rc = vhost_user_get_queue_num(vu_dev, &vu_dev->max_vqs);
+		if (rc)
+			return rc;
+	} else {
+		vu_dev->max_vqs = U64_MAX;
+	}
+
 	return 0;
 }
 
@@ -1029,7 +1050,7 @@ static int vu_find_vqs(struct virtio_device *vdev, unsigned nvqs,
 	struct virtqueue *vq;
 
 	/* not supported for now */
-	if (WARN_ON(nvqs > 64))
+	if (WARN_ON(nvqs > 64) || WARN_ON(nvqs > vu_dev->max_vqs))
 		return -EINVAL;
 
 	rc = vhost_user_set_mem_table(vu_dev);
-- 
2.47.0


