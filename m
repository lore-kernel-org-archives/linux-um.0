Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA523C05027
	for <linux-um@archiver.kernel.org>; Fri, 20 Jan 2023 08:02:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:CC:To:Message-ID:MIME-Version:Subject:
	Date:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=NfIJCK2lPgFHe2HFt1HcDvWp1OACNpAA/20jE9hAp54=; b=0y9mFCf5T9mJE8
	527rIMDUHByBqFxwHYkUQSwt3h4A1oHwzeaQYk2BjtFWhfR2F4oXOG710UwU6S0JcayDcwceuAaUW
	2RkgoKEpG5KMZ9YSL//TVq65PM9QEVpm07V05aGY3i9AlVnFpIbZryGkaRsdvCaU1A8FjAYUWs565
	Ss1Yb1dk/0/TuH/aU1Nnh7SSDnWyMlisGX1B9NnH1V/DWfe8a8A3wLYs/LjasM/K15FtJUCmdoQSt
	HG3plb/YoVjA3F7zNqbm/EalXush9UqGyuUyyvHB31+U7BbaZnvE6OmEgmiLjcmpWneJb81zy/8yF
	qSRyw8Hxi/3nbv6o6Krg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pImMS-008vNT-7w; Fri, 20 Jan 2023 08:02:56 +0000
Received: from smtp1.axis.com ([195.60.68.17])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pImMM-008vJt-G3
	for linux-um@lists.infradead.org; Fri, 20 Jan 2023 08:02:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1674201770;
  x=1705737770;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:to:cc;
  bh=ZasFDb7nYvB8EN2NFjes7tHLvuWokK8uCN1JO+3qhDQ=;
  b=c5u+DX2HA26v/zWNKw5ElhN1R5fZeXn+8qx2pp5RrM83iG9HcUFoIKUc
   wxmTAqsuJ1uGbjXzYZ5vuYXN/rOwNe91CXjDeYgWJyc4S8JkVEsRcnaQ4
   r1ZrNTmNak1wJULH0i0ApqcZBs6jRR8tCp6bHICooMg2oq8JmWPyDoA7L
   +O+4oRN679Ekzm2CXbIZe5ilgpXV8RFm4ewC/6/d8V2IyYuqMHqkxgFPv
   ECExUp9yHCtxsCBEUZbvGeDIPQoz8tNUTgOp1n0DahhnnJEcITzAcHpOh
   Xwkxlhw2do48sXga/fAlVRQ/wWNnOXstHsOBkphP9OQjfrtvLf9lcxc1O
   w==;
From: Vincent Whitchurch <vincent.whitchurch@axis.com>
Date: Fri, 20 Jan 2023 09:02:32 +0100
Subject: [PATCH] um: virt-pci: implement pcibios_get_phb_of_node()
MIME-Version: 1.0
Message-ID: <20230120-uml-pci-of-v1-1-134fb66643d8@axis.com>
X-B4-Tracking: v=1; b=H4sIAJhKymMC/x2NQQqEMAwAvyI5G2izetmvLB7ammpAa2lVFqR/t
 3qcgWEuyJyEM3ybCxKfkmULFXTbgJtNmBhlrAyk6KM0KTzWBaMT3Dx60mNvTWep66EG1mRGm0xw
 85Psa3xsTOzl/y5+Qyk35d7giHIAAAA=
To: Richard Weinberger <richard@nod.at>, Anton Ivanov
	<anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>
CC: <linux-um@lists.infradead.org>, <linux-pci@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Vincent
 Whitchurch <vincent.whitchurch@axis.com>, <kernel@axis.com>
X-Mailer: b4 0.11.2
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230120_000251_079973_5E855518 
X-CRM114-Status: UNSURE (   7.17  )
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

Implement pcibios_get_phb_of_node() as x86 does in order to allow PCI
busses to be associated with devicetree nodes.

Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
---
 arch/um/drivers/virt-pci.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/um/drivers/virt-pci.c b/arch/um/drivers/virt-pci.c
index 3ac220dafec4..6884e1be38e4 100644
--- a/arch/um/drivers/virt-pci.c
+++ b/arch/um/drivers/virt-pci.c
@@ -533,6 +533,25 @@ static void um_pci_irq_vq_cb(struct virtqueue *vq)
 	}
 }
 
+/* Copied from arch/x86/kernel/devicetree.c */
+struct device_node *pcibios_get_phb_of_node(struct pci_bus *bus)
+{
+	struct device_node *np;
+
+	for_each_node_by_type(np, "pci") {
+		const void *prop;
+		unsigned int bus_min;
+
+		prop = of_get_property(np, "bus-range", NULL);
+		if (!prop)
+			continue;
+		bus_min = be32_to_cpup(prop);
+		if (bus->number == bus_min)
+			return np;
+	}
+	return NULL;
+}
+
 static int um_pci_init_vqs(struct um_pci_device *dev)
 {
 	struct virtqueue *vqs[2];

---
base-commit: 1b929c02afd37871d5afb9d498426f83432e71c2
change-id: 20230120-uml-pci-of-f21d5ba4b245

Best regards,
-- 
Vincent Whitchurch <vincent.whitchurch@axis.com>

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
