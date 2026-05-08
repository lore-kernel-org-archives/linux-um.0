Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F7DFCD342F
	for <linux-um@archiver.kernel.org>; Fri,  8 May 2026 20:52:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=cGg05p0EPBuZ0MN6OfsJUWxzC1RxBJWTKJHqRka/clA=; b=d0LL6VgTUK4BwF/cFN8SQQUIR2
	PuNO3+hfUcV0IvoKoq6fTFK/8w/ghaPF8X9rJw08qDcps8hwRwvGh7muc0kng2yz7pw8AlWFX91BD
	8Y6Qv5g+6sYlJwd/uKRJGcQg8RQNaFGnM0aJzcWlC1Z7h88wChgsEIMNDhTM0CMHUmT58STJvVss7
	uXM/1eoaVK2Yc7/j1018VXTjZuMkGPdMxmCISziM9vy+Q7EM4iehFnMLlVdO4NWdr5+3gdl1FsXcH
	KZhvHHmbdFeFKgasljK7iFmF+p0f/k2gFHhfCmt/UwudZFX5kTF0iVWtP1e9eDCbCV+grup9mdN+l
	D+YC/zVQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wLSBq-00000007Uwo-0wa3;
	Fri, 08 May 2026 20:52:54 +0000
Received: from relay.smtp-ext.broadcom.com ([192.19.166.231])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wLSBl-00000007Uw0-1GVN
	for linux-um@lists.infradead.org;
	Fri, 08 May 2026 20:52:50 +0000
Received: from mail-lvn-it-01.broadcom.com (mail-lvn-it-01.lvn.broadcom.net [10.36.132.253])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id 79FC7C000320;
	Fri,  8 May 2026 13:52:46 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 79FC7C000320
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1778273566;
	bh=H1EvY1PsxDZA4+rF1Z4pbyqEwCYNC0lzM+PFx/IcTmw=;
	h=From:To:Cc:Subject:Date:From;
	b=BA1JgvazB+N8dB8CaF6pWp/FmsWczlsVWdEWPLp3qsOoVguofm+8GOAIe7j2nAyTH
	 qfqrVUzkOBKWVbZWnvR5kVT17mT8wZyWzpQaJ9TKudDY1vHiH/38kgdeUIQe3jcmar
	 MyVYuYSlghZle2wFBLPyURAjBD6sD07AH2Ksi4jk=
Received: from fainelli-desktop.igp.broadcom.net (fainelli-desktop.dhcp.broadcom.net [10.67.48.245])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail-lvn-it-01.broadcom.com (Postfix) with ESMTPSA id 5942EB70;
	Fri,  8 May 2026 13:52:46 -0700 (PDT)
From: Florian Fainelli <florian.fainelli@broadcom.com>
To: stable@vger.kernel.org
Cc: bcm-kernel-feedback-list@broadcom.com,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Jeff Dike <jdike@addtoit.com>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Benjamin Berg <benjamin.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	linux-um@lists.infradead.org (open list:USER-MODE LINUX (UML)),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH stable 5.15] um: virt-pci: Fix build failure
Date: Fri,  8 May 2026 13:52:41 -0700
Message-ID: <20260508205241.962178-1-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260508_135249_383596_067CB0F2 
X-CRM114-Status: GOOD (  11.51  )
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

Commit a27e95a6ff3f ("um: virt-pci: properly remove PCI device from
bus") assumed that virtio_reset_device() is present in the 5.15.y kernel
but it is not and so backport would now cause a build failure.

Fixes: a27e95a6ff3f ("um: virt-pci: properly remove PCI device from bus")
Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
 arch/um/drivers/virt-pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/um/drivers/virt-pci.c b/arch/um/drivers/virt-pci.c
index d762d726b66c..0666c9e0998d 100644
--- a/arch/um/drivers/virt-pci.c
+++ b/arch/um/drivers/virt-pci.c
@@ -641,7 +641,7 @@ static void um_pci_virtio_remove(struct virtio_device *vdev)
 	}
 
 	/* Stop all virtqueues */
-	virtio_reset_device(vdev);
+	vdev->config->reset(vdev);
 	dev->cmd_vq = NULL;
 	dev->irq_vq = NULL;
 	vdev->config->del_vqs(vdev);
-- 
2.43.0


