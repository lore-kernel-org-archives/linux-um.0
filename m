Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAD5ED11193
	for <linux-um@archiver.kernel.org>; Sun,  3 Nov 2024 21:30:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5I5CPJsC33trkTrKpn6Ifbw+0nrwn/6PINruf9PYHfQ=; b=yPawEkMOYuHgTuz+RM3hqDS++c
	rpnXoCvO7VFNrVKkJvI9Ictb8Ed/TuLAEpbeMPHP0hTYuMb9AkxAkhP3mWib7QPMS4mBVTPRPt2DD
	O7CfQcqjNh6NaKG68DtKcLDYrpephE+tfsOzoqUnhN6jBMfnodsNJT9hN+FpXb1R6xR/gGsbcEF5V
	0db5OZGp8rpZwadYJdrX93hJH185AyFB89TeCQLIyj+y1cDFdJl5+S4G4Vo1KSZwe8exde4T5VYNn
	N8MDHsfuI3JBzA4DlNniqUkURacas45gFT2srDCuRAq/OMIqm7QgWd04LtBGiyGNctYFrxaqe3YxP
	tFeD5nBg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t7iBL-0000000C4Rm-22sS;
	Sun, 03 Nov 2024 21:30:47 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t7iBG-0000000C4QE-2mX6
	for linux-um@lists.infradead.org;
	Sun, 03 Nov 2024 21:30:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=5I5CPJsC33trkTrKpn6Ifbw+0nrwn/6PINruf9PYHfQ=;
	t=1730669442; x=1731879042; b=MYDnLsRmBu6nAT0ZEZb1cPDJNwrX40DiEs7KuRcexpjNdgg
	icyrrNLMxp/J5+vHbgYwmxFhsjBMVEKjje+C1bzjoQASaDs4dvOo2t8HfIT4CUbcO7iKtKH3OjDTU
	PgeVXyQ2rDlVMycYh77x06OxqNlpMBgJ7lPdldEfazp3tw/LJtQtaPfpkWKUgn/VEf9zulD5G+4k6
	wkJvk32VJz2vGCWtNXzpdB3RxskNIT15+RGKKBNn+HJ8Qv0wfYW26f63JXMfVxPBL5IyKc61EKNoN
	7ZTAFl9Fpo3YnZNcN4f7Fk7++nR4GM8ILSATHaJiXLbOIGdIEFuzgyLMuktxqHAw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1t7iBD-0000000DCdx-46E8;
	Sun, 03 Nov 2024 22:30:40 +0100
From: Benjamin Berg <benjamin@sipsolutions.net>
To: linux-um@lists.infradead.org
Cc: Benjamin Berg <benjamin.berg@intel.com>
Subject: [PATCH 1/4] um: virtio_uml: send SET_MEM_TABLE message with the exact size
Date: Sun,  3 Nov 2024 22:28:51 +0100
Message-ID: <20241103212854.1436046-2-benjamin@sipsolutions.net>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241103212854.1436046-1-benjamin@sipsolutions.net>
References: <20241103212854.1436046-1-benjamin@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241103_133043_626940_94027A6C 
X-CRM114-Status: GOOD (  11.05  )
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

The rust based userspace vhost devices are very strict and will not
accept the message if it is longer than required. So, only include the
data for the first memory region.

Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
---
 arch/um/drivers/virtio_uml.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/um/drivers/virtio_uml.c b/arch/um/drivers/virtio_uml.c
index 4d3e9b9f5b61..c602892f329f 100644
--- a/arch/um/drivers/virtio_uml.c
+++ b/arch/um/drivers/virtio_uml.c
@@ -623,7 +623,7 @@ static int vhost_user_set_mem_table(struct virtio_uml_device *vu_dev)
 {
 	struct vhost_user_msg msg = {
 		.header.request = VHOST_USER_SET_MEM_TABLE,
-		.header.size = sizeof(msg.payload.mem_regions),
+		.header.size = offsetof(typeof(msg.payload.mem_regions), regions[1]),
 		.payload.mem_regions.num = 1,
 	};
 	unsigned long reserved = uml_reserved - uml_physmem;
-- 
2.47.0


