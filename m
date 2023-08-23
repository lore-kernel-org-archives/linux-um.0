Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B88E0EE49B2
	for <linux-um@archiver.kernel.org>; Wed, 23 Aug 2023 10:41:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:CC:To:Message-ID:MIME-Version:Subject:
	Date:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=PfuHLs/PSyuXktZaR7SsLQM1Y2VCu+0N8mQprVr1e0I=; b=dlsRW7MB0k+NO/
	k8ykgc3PFErkMDVzR0j2fgmVcCeFP/s0vF2itBuzUyzHuR0LWaMiJqbniAjpbMBCXt9vVWbL6ri5A
	CGqQ7Dug5dwkFKeSEerB+p3j0HtTM/d5zazbGIisyVjVYVAhkke4RabU/O4N1dByPaW0zCoe8we8D
	VViF6fIuYZoIHi/zRaSZsqo44RXYM738tAKDSt364qHXtCZ0Fdvc2xJVE3uXMp/QPcHNWb/NjYYUI
	8yrp29KUfXFz84Rv54rFBF/vNljKzQ31YX8VsmfE2XcnAtQhuFIBLJPkPA2z/g648qkT1hnkQVFDE
	y8XimIb2h5tgZIITlt+A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qYlIP-000LDI-0L;
	Wed, 23 Aug 2023 10:41:05 +0000
Received: from smtp2.axis.com ([195.60.68.18])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qYlIG-000L8K-2r
	for linux-um@lists.infradead.org;
	Wed, 23 Aug 2023 10:40:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1692787257;
  x=1724323257;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:to:cc;
  bh=6LJ6BHzjxEmUNS9AR+aQcWxz25DB+rK6TaYI29lFdFE=;
  b=R+/jTePQNAtVDBhSJHxvKfBdCSmPdiPlDBfayz7s+rlkKJWaBrSGntcc
   /cmPl56ZgIf3T64a+/4y0X6HFZlVs9nERRoJIz7UhiRRRQ7wNqPdnx8PA
   qDZmAwlbTrQbm9Lyf8u4mgQD1ZwnWD705jLp34QpjkLfTSkT2o+3oGXJm
   Ku6XF+EJdFSgkGz3VzsVsRwsqQglcGp1K84st9pG1f9M97BNwr411sTV3
   hrZFuQiOba4vnK1HFHs1iZhoG+oDkzZugovstLg6OBn1NVjGAyq/5uv9E
   c/nR0KAU8dov/VgA7BHQ0AD90sKkEr56q4PzcEEZOAGsKlo+3xdHFEM9c
   w==;
From: Vincent Whitchurch <vincent.whitchurch@axis.com>
Date: Wed, 23 Aug 2023 12:40:44 +0200
Subject: [PATCH] um: virt-pci: fix missing declaration warning
MIME-Version: 1.0
Message-ID: <20230823-uml-virt-pci-warn-v1-1-fd43183a10d6@axis.com>
X-B4-Tracking: v=1; b=H4sIACvi5WQC/x3MSQqAMAxA0atI1ga04oBXERe1phrQKqkTFO9uc
 fkW/wfwJEwe2iSA0MWeNxeRpwmYWbuJkMdoUJkqskYVeK4LXiwH7obx1uKwKgdt6rHR1lQQu13
 I8vM/u/59P4J7sxRjAAAA
To: Richard Weinberger <richard@nod.at>, Anton Ivanov
	<anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>
CC: <linux-um@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<kernel@axis.com>, kernel test robot <lkp@intel.com>, Vincent Whitchurch
	<vincent.whitchurch@axis.com>
X-Mailer: b4 0.12.3
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230823_034057_257267_2DC0B4FC 
X-CRM114-Status: UNSURE (   6.72  )
X-CRM114-Notice: Please train this message.
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

Fix this warning which appears with W=1 and without CONFIG_OF:

 warning: no previous declaration for 'pcibios_get_phb_of_node'

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202308230949.PphIIlhq-lkp@intel.com/
Fixes: 314a1408b79a ("um: virt-pci: implement pcibios_get_phb_of_node()")
Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
---
 arch/um/drivers/virt-pci.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/um/drivers/virt-pci.c b/arch/um/drivers/virt-pci.c
index 7699ca5f35d4..ffe2ee8a0246 100644
--- a/arch/um/drivers/virt-pci.c
+++ b/arch/um/drivers/virt-pci.c
@@ -544,6 +544,7 @@ static void um_pci_irq_vq_cb(struct virtqueue *vq)
 	}
 }
 
+#ifdef CONFIG_OF
 /* Copied from arch/x86/kernel/devicetree.c */
 struct device_node *pcibios_get_phb_of_node(struct pci_bus *bus)
 {
@@ -562,6 +563,7 @@ struct device_node *pcibios_get_phb_of_node(struct pci_bus *bus)
 	}
 	return NULL;
 }
+#endif
 
 static int um_pci_init_vqs(struct um_pci_device *dev)
 {

---
base-commit: 706a741595047797872e669b3101429ab8d378ef
change-id: 20230823-uml-virt-pci-warn-65bac7d8afc6

Best regards,
-- 
Vincent Whitchurch <vincent.whitchurch@axis.com>


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
