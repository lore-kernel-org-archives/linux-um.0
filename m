Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24146D11192
	for <linux-um@archiver.kernel.org>; Sun,  3 Nov 2024 21:30:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UPjFOfTfaI0QE3B0B3y7Cd4EhMnDfdAjQD07PQbNIWY=; b=JRkvB/dihffILxmMHV6/2VBWiT
	rVwe97u4BdKvIhauNovNGZ+FcDYO8pWN7rwKDWCLZjCaKUyX/Qj92iTn9399CDIQYxTNjGXgFYFcd
	apF8HsWih4Ypr4whTrknaxynLvf4x2aT62kVz9QckZHeIA2RtzTh3OsxxcIhmLBPaUhK+lOfG8JJv
	EnQkEEx3U5d+nNTMK6kWHa9xcyOkkGu+zP5pqhezyxpktpvf0CbZezO3cNdtZvh4hFxwaOdJXfcLF
	WiUhHQzi947OjuTGkuA+nKSqW/fzw2U4ypB59eTa+UvyxGcMjL4p1+mk9qar4FhuvquiSnunqWlqI
	1dzfePLw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t7iBL-0000000C4S1-3bBw;
	Sun, 03 Nov 2024 21:30:47 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t7iBJ-0000000C4Qg-0PJQ
	for linux-um@lists.infradead.org;
	Sun, 03 Nov 2024 21:30:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=UPjFOfTfaI0QE3B0B3y7Cd4EhMnDfdAjQD07PQbNIWY=;
	t=1730669444; x=1731879044; b=M9HULHoZPO9yY16VOpbSuMRE9coQ/7HW5snvOot2yk7Ri/3
	pdUdhmsiPz70IyM3os6EdaSGKTQRl1YZYP5XxCVkmp4ySZfe8zk5japca0z8Wbi7jot6b/7bK2WbV
	sI98Bv3/3Y8r7Xqbe9dKwjySY2wc2XwMqkUSqz5w2uk0BoHv/pujw4GClhAlMPVm2DZSYv805HV4h
	tNJtUDvfPL/hAPdAx6xm6MbCkFj6TxbYBxAms7oUyTNoQsN1bcUKBUJ3mX9yKP9OwhNF8XDqx4M4p
	DacazF7GuCZpfmq5uRE8i8aGkx6wdFvxee/dNaHWShTeuaU5SLGd/ZoI8Jyi015Q==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1t7iBF-0000000DCdx-3d74;
	Sun, 03 Nov 2024 22:30:42 +0100
From: Benjamin Berg <benjamin@sipsolutions.net>
To: linux-um@lists.infradead.org
Cc: Benjamin Berg <benjamin.berg@intel.com>
Subject: [PATCH 2/4] um: virtio_uml: use smaller virtqueue sizes for VIRTIO_ID_SOUND
Date: Sun,  3 Nov 2024 22:28:52 +0100
Message-ID: <20241103212854.1436046-3-benjamin@sipsolutions.net>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241103212854.1436046-1-benjamin@sipsolutions.net>
References: <20241103212854.1436046-1-benjamin@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241103_133045_175059_0B2DDF53 
X-CRM114-Status: GOOD (  12.01  )
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

It appears that the different vhost device implementations use different
sizes of the virtual queues. Add device specific limitations (for now,
only for sound), to ensure that we do not get disconnected unexpectedly.

Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
---
 arch/um/drivers/virtio_uml.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/arch/um/drivers/virtio_uml.c b/arch/um/drivers/virtio_uml.c
index c602892f329f..2e4b4eadd553 100644
--- a/arch/um/drivers/virtio_uml.c
+++ b/arch/um/drivers/virtio_uml.c
@@ -25,6 +25,7 @@
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 #include <linux/virtio.h>
+#include <linux/virtio_ids.h>
 #include <linux/virtio_config.h>
 #include <linux/virtio_ring.h>
 #include <linux/time-internal.h>
@@ -935,9 +936,19 @@ static struct virtqueue *vu_setup_vq(struct virtio_device *vdev,
 	struct platform_device *pdev = vu_dev->pdev;
 	struct virtio_uml_vq_info *info;
 	struct virtqueue *vq;
-	int num = MAX_SUPPORTED_QUEUE_SIZE;
+	int num;
 	int rc;
 
+	/* Seems like we need to hard-code the queue size */
+	switch (vu_dev->vdev.id.device) {
+	case VIRTIO_ID_SOUND:
+		num = 64;
+		break;
+	default:
+		num = MAX_SUPPORTED_QUEUE_SIZE;
+		break;
+	}
+
 	info = kzalloc(sizeof(*info), GFP_KERNEL);
 	if (!info) {
 		rc = -ENOMEM;
-- 
2.47.0


