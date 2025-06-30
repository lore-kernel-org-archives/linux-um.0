Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9351BC83029
	for <linux-um@archiver.kernel.org>; Mon, 30 Jun 2025 06:51:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sm6jHzdEvHenVHHRLowXCnjdqr4oxLjS3mo+byur4bc=; b=qlvnA9uD2fdnyUY7OkoaRDNvI1
	ziVUMdJsv4BAi+1UTP/A6bjateMuMM9NgxMwqV2RMRraXPZY3K4tkj6vl1+IZDoQDOgZ4QFEloN6X
	uPTrTBEFpsmdGUDgERGvO6n2D4ntsF1VyHEYxV9wVXDyc8rzeib9u3Z4qbvFGiFRgBkq8ohdHl1My
	psqo74e/7v+eBjfExNjbCu2KsxTjX8ZjJRO9yMdoVP4klZ5mY0pOnBxmbsiKk1piQED6gKu71LB1p
	GynRvkRyU9z3JVR/45lWFjeKqBaU5p+KDBZ0ej+mALQ9GvoRrnH38YavNTdYWJaJvGrrYrEtzDeAC
	An8eII1g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uW8MX-00000001NeZ-2Ggl;
	Mon, 30 Jun 2025 06:51:33 +0000
Received: from galois.linutronix.de ([2a0a:51c0:0:12e:550::1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uW8MV-00000001Ndv-0ENt
	for linux-um@lists.infradead.org;
	Mon, 30 Jun 2025 06:51:32 +0000
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1751266288;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sm6jHzdEvHenVHHRLowXCnjdqr4oxLjS3mo+byur4bc=;
	b=RRUMa0C24tQ/MofMeF/YCqAlIosDHVHlRjq559dBe77Fnzf72Ovu5Zg4dnLf+0izU0RJqM
	H6/QRfzHizkCK21RUbgeLTcsXhtxGwfg38iCTCRZgmT4/FUiVZwMj/Fnfqb0WpGA3pYfxk
	lG9GoavtJD8WfJI6gtcaqu6inrWofOV3o/kDNeamtngxd74l8kzsZoAdfVuUXogJOowHc0
	8EsvEBGvGytMNFprSpt9Sjntmzil8Mu2w3iacblHWuzcZh4lkjy9TPdS56mYaojIGPSJ5S
	WlgbtZwNBk0Af/7nb5DDsC/mje0kXRKO6jUSf0p/egw9gdIqPhVowCgpLICuGA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1751266288;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sm6jHzdEvHenVHHRLowXCnjdqr4oxLjS3mo+byur4bc=;
	b=cgf9UWkIiIH8RHBZ6faWqtG9Pp/LGBN8BuE2ZQEYAXh/TzzNF/zcxXHWHuztEDPqkvdCrn
	oZAB3G2YQkWJ/UCA==
To: Marc Zyngier <maz@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	linux-um@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Nam Cao <namcao@linutronix.de>
Subject: [PATCH v2 1/1] um: virt-pci: Switch to msi_create_parent_irq_domain()
Date: Mon, 30 Jun 2025 08:51:16 +0200
Message-Id: <5f0bd8e877e7bfdfb1a7e99d6b126caf6a7eea48.1751266049.git.namcao@linutronix.de>
In-Reply-To: <cover.1751266049.git.namcao@linutronix.de>
References: <cover.1751266049.git.namcao@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250629_235131_234347_83BAA78E 
X-CRM114-Status: GOOD (  13.00  )
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

Move away from the legacy MSI domain setup, switch to use
msi_create_parent_irq_domain().

Signed-off-by: Nam Cao <namcao@linutronix.de>
---
v2: Remove MSI_FLAG_PCI_MSI_MASK_PARENT to fix a NULL pointer deref
---
 arch/um/drivers/Kconfig    |  1 +
 arch/um/drivers/virt-pci.c | 45 +++++++++++++++++++-------------------
 2 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/arch/um/drivers/Kconfig b/arch/um/drivers/Kconfig
index 34085bfc6d416..6a0354ca032fb 100644
--- a/arch/um/drivers/Kconfig
+++ b/arch/um/drivers/Kconfig
@@ -160,6 +160,7 @@ config UML_RTC
 config UML_PCI
 	bool
 	select FORCE_PCI
+	select IRQ_MSI_LIB
 	select UML_IOMEM_EMULATION
 	select UML_DMA_EMULATION
 	select PCI_MSI
diff --git a/arch/um/drivers/virt-pci.c b/arch/um/drivers/virt-pci.c
index 0fe207ca4b72e..557d93aea00a1 100644
--- a/arch/um/drivers/virt-pci.c
+++ b/arch/um/drivers/virt-pci.c
@@ -7,6 +7,7 @@
 #include <linux/pci.h>
 #include <linux/logic_iomem.h>
 #include <linux/of_platform.h>
+#include <linux/irqchip/irq-msi-lib.h>
 #include <linux/irqdomain.h>
 #include <linux/msi.h>
 #include <linux/unaligned.h>
@@ -29,7 +30,6 @@ static struct um_pci_device *um_pci_platform_device;
 static struct um_pci_device_reg um_pci_devices[MAX_DEVICES];
 static struct fwnode_handle *um_pci_fwnode;
 static struct irq_domain *um_pci_inner_domain;
-static struct irq_domain *um_pci_msi_domain;
 static unsigned long um_pci_msi_used[BITS_TO_LONGS(MAX_MSI_VECTORS)];
=20
 static unsigned long um_pci_cfgspace_read(void *priv, unsigned int offset,
@@ -400,21 +400,24 @@ static void um_pci_inner_domain_free(struct irq_domai=
n *domain,
 }
=20
 static const struct irq_domain_ops um_pci_inner_domain_ops =3D {
+	.select =3D msi_lib_irq_domain_select,
 	.alloc =3D um_pci_inner_domain_alloc,
 	.free =3D um_pci_inner_domain_free,
 };
=20
-static struct irq_chip um_pci_msi_irq_chip =3D {
-	.name =3D "UM virtual PCIe MSI",
-	.irq_mask =3D pci_msi_mask_irq,
-	.irq_unmask =3D pci_msi_unmask_irq,
-};
-
-static struct msi_domain_info um_pci_msi_domain_info =3D {
-	.flags	=3D MSI_FLAG_USE_DEF_DOM_OPS |
-		  MSI_FLAG_USE_DEF_CHIP_OPS |
-		  MSI_FLAG_PCI_MSIX,
-	.chip	=3D &um_pci_msi_irq_chip,
+#define UM_PCI_MSI_FLAGS_REQUIRED (MSI_FLAG_USE_DEF_DOM_OPS		| \
+				   MSI_FLAG_USE_DEF_CHIP_OPS		| \
+				   MSI_FLAG_NO_AFFINITY)
+#define UM_PCI_MSI_FLAGS_SUPPORTED (MSI_GENERIC_FLAGS_MASK		| \
+				    MSI_FLAG_PCI_MSIX)
+
+static const struct msi_parent_ops um_pci_msi_parent_ops =3D {
+	.required_flags		=3D UM_PCI_MSI_FLAGS_REQUIRED,
+	.supported_flags	=3D UM_PCI_MSI_FLAGS_SUPPORTED,
+	.bus_select_token	=3D DOMAIN_BUS_NEXUS,
+	.bus_select_mask	=3D MATCH_PCI_MSI,
+	.prefix			=3D "UM-virtual-",
+	.init_dev_msi_info	=3D msi_lib_init_dev_msi_info,
 };
=20
 static struct resource busn_resource =3D {
@@ -559,17 +562,14 @@ static int __init um_pci_init(void)
 		goto free;
 	}
=20
-	um_pci_inner_domain =3D irq_domain_create_linear(um_pci_fwnode, MAX_MSI_V=
ECTORS,
-						       &um_pci_inner_domain_ops, NULL);
-	if (!um_pci_inner_domain) {
-		err =3D -ENOMEM;
-		goto free;
-	}
+	struct irq_domain_info info =3D {
+		.fwnode		=3D um_pci_fwnode,
+		.ops		=3D &um_pci_inner_domain_ops,
+		.size		=3D MAX_MSI_VECTORS,
+	};
=20
-	um_pci_msi_domain =3D pci_msi_create_irq_domain(um_pci_fwnode,
-						      &um_pci_msi_domain_info,
-						      um_pci_inner_domain);
-	if (!um_pci_msi_domain) {
+	um_pci_inner_domain =3D msi_create_parent_irq_domain(&info, &um_pci_msi_p=
arent_ops);
+	if (!um_pci_inner_domain) {
 		err =3D -ENOMEM;
 		goto free;
 	}
@@ -611,7 +611,6 @@ device_initcall(um_pci_init);
=20
 static void __exit um_pci_exit(void)
 {
-	irq_domain_remove(um_pci_msi_domain);
 	irq_domain_remove(um_pci_inner_domain);
 	pci_free_resource_list(&bridge->windows);
 	pci_free_host_bridge(bridge);
--=20
2.39.5


