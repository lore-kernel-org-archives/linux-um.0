Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 605DDC54E94
	for <linux-um@archiver.kernel.org>; Thu, 26 Jan 2023 10:49:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:CC:To:Message-ID:MIME-Version:Subject:
	Date:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=d+Noj2cPrBcD5FRibguWwhzhh7RH8Yd5T7V7GNWfoHM=; b=GPPJtQO4Glpo4f
	usuvvmAKdyJmwnal9Opx+vy65+wl2lTWZbwNB+29EQ3e/iAEsUjAxgTwWf9DSvZPC7Xr+I/O1zwiZ
	FuvvGULGxBh2jp7x/u98jTbxm8Ju9w3uBYnXonVbvTgUCMeV6xSR/2mk2yZylGWU3wQkADl8rNza3
	ZTa8r6jSAFX3G6hV+E8igAxjRQHELtXWmUyctBYTJ+xa9ASCQnmnD8VuFMW3MlHLFbtwPF4cwssyW
	/c0nQSV6UhUtJqGmiYvLzssWdXvlKGdih03nb1j3e12dNX/jFdnLJ+IueQzrYxqrzwH3pHJv5ixA2
	QWgFqGjN10k66w2H40rA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pKzpF-00AZMF-6U; Thu, 26 Jan 2023 10:49:49 +0000
Received: from smtp1.axis.com ([195.60.68.17])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pKzmx-00AYNo-4m
	for linux-um@lists.infradead.org; Thu, 26 Jan 2023 10:47:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1674730047;
  x=1706266047;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:to:cc;
  bh=DTva1Ssx8kQR67UOp6qZggMijTqQjiAsgHXYRC030jE=;
  b=Z1/1itknB+x2EiLSsxd3jhk4MDvzELNtbw6YT4GkMSQ8PI5ZC7M9L1wg
   TUwnp9EPgWrRuBCmGfMuE5jXFbSOX0oPbnYbXKHZtmpAFDxZ0cCPyRNuV
   nqttmeQNIYtdtWLKebJainqwOpCKhBM4cOGO3JjF5uwGR9UFg8mXzlRWt
   DA2h7Iv+2Wm0nGNZEnnMm2Xp2xD6MqbCcL61hkpYlxPoXTnFdZIrH0olZ
   T6sbBK7K0iEYVYxF8YlQdizjVE8fJ7zAtcY+RRkefGGnvx8kEgfJ0Ao3w
   OW2+i/FK4amijWtxoxiSAY8LCKGCmglySP0AVeZuil/IElPt8RgepxZ3+
   A==;
From: Vincent Whitchurch <vincent.whitchurch@axis.com>
Date: Thu, 26 Jan 2023 11:47:10 +0100
Subject: [PATCH] um-virt-pci: Make max delay configurable
MIME-Version: 1.0
Message-ID: <20230126-uml-pci-delay-v1-1-015ed7e93ef2@axis.com>
X-B4-Tracking: v=1; b=H4sIAC1a0mMC/x2NwQqDMBAFf0X27EKMVLC/UnrYxKcuaBoSLS3iv
 zf2OAPDHJSRFJnu1UEJb836CgWauiI/S5jAOhQma2xrGtvxvi4cvfKARb5spff9rTWA66g0TjL
 YJQl+vqptjZeNCaN+/pfH8zx/c6Z7+nUAAAA=
To: Richard Weinberger <richard@nod.at>, Anton Ivanov
	<anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>
CC: <linux-um@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<kernel@axis.com>, Vincent Whitchurch <vincent.whitchurch@axis.com>
X-Mailer: b4 0.12.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230126_024727_807630_56244A64 
X-CRM114-Status: GOOD (  10.34  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

There is a hard coded maximum time for which the driver busy-loops
waiting for a response from the virtio device.  This default time may be
too short for some systems, so make it a module parameter so that it can
be set via the kernel command line.

Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
---
 arch/um/drivers/virt-pci.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/um/drivers/virt-pci.c b/arch/um/drivers/virt-pci.c
index 3ac220dafec4..33183f6f9f2a 100644
--- a/arch/um/drivers/virt-pci.c
+++ b/arch/um/drivers/virt-pci.c
@@ -54,7 +54,8 @@ static struct irq_domain *um_pci_inner_domain;
 static struct irq_domain *um_pci_msi_domain;
 static unsigned long um_pci_msi_used[BITS_TO_LONGS(MAX_MSI_VECTORS)];
 
-#define UM_VIRT_PCI_MAXDELAY 40000
+static unsigned int um_pci_max_delay_us = 40000;
+module_param_named(max_delay_us, um_pci_max_delay_us, uint, 0644);
 
 struct um_pci_message_buffer {
 	struct virtio_pcidev_msg hdr;
@@ -155,7 +156,7 @@ static int um_pci_send_cmd(struct um_pci_device *dev,
 			kfree(completed);
 
 		if (WARN_ONCE(virtqueue_is_broken(dev->cmd_vq) ||
-			      ++delay_count > UM_VIRT_PCI_MAXDELAY,
+			      ++delay_count > um_pci_max_delay_us,
 			      "um virt-pci delay: %d", delay_count)) {
 			ret = -EIO;
 			break;

---
base-commit: 1b929c02afd37871d5afb9d498426f83432e71c2
change-id: 20230126-uml-pci-delay-2a9c9530eeb6

Best regards,
-- 
Vincent Whitchurch <vincent.whitchurch@axis.com>


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
