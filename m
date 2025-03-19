Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0302AC36000
	for <linux-um@archiver.kernel.org>; Wed, 19 Mar 2025 09:30:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mXk+rbdkCySZh9NaOpuGTIHouTFUF1MyKJDDbU28nxU=; b=tg5asacEwD/NXqEg4jKWS42AEw
	f6ErzLqrUoXmlzUsFZGC0Te93nJqoPxrFZvXoAQA0VLqqFNbXroTzpuvudgoGPljyGyEKQKECVPik
	vyvQ3bTR2n2oLQh7iFLTPbUKsqeG8szOJnScy72/oZS3aqSR3lPDn5JmCvDNz2+Wi4Mf2pIEcic55
	taOLZZBeX2eTs1VWaXgiGxcho0QZNvofR0mLP7K/BHas1Qcig3A06mnEtFtLVI4q+3LreRrfhfxG8
	tNBOOeIw/ldJdnIsFTJAKkPPYwnDZ4+6ZLmis7jOpZKmfdTXrbQRoMeiebUijulMtxV/yjQq2SFUg
	s//d01kQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tupl7-00000008UIZ-1xJJ;
	Wed, 19 Mar 2025 09:30:45 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tupl3-00000008UFt-48PF
	for linux-um@lists.infradead.org;
	Wed, 19 Mar 2025 09:30:42 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 437EB61631;
	Wed, 19 Mar 2025 09:30:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 775FFC116C6;
	Wed, 19 Mar 2025 09:30:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742376640;
	bh=NNs8SEwDfc9wDIxk1Dn/+q1ci77lX4vcEi1aTxU5XiQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MSOdQhrgk5hmkbWksclyMaCrFyjiMd812BBwfN6ygHz7ED8jGGeyMaZTbtLXe5n8O
	 KEvcYqkwKDn39WFsQTWmkyuFLVtijGqcDK+K/6TlZECVAyq5V+YhZbMpXvrpY6iiJF
	 pG3WX0U8wTJjrq2yEiPbM788lCU2S+X8n08DhxZIeMHaChZ5gIW8ZMt5qiujKnP0y4
	 xa/bhcUCI4F4gFJ6U/m7OPpqDLAJ+xEzAzyjhOKcfhxYuUvbZNNXsqEbUy61tgQv1B
	 NP5KiW2AMmsIu7itr9LOqIvX9Dw66V8asl5OKb3KPJjzJ9WlmzkIhV0ZUP14s96rMo
	 eHpBMcf4K7FkA==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: tglx@linutronix.de
Cc: maz@kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	linux-um@lists.infradead.org
Subject: [PATCH v2 01/57] irqdomain: um: use irq_domain_create_linear() helper
Date: Wed, 19 Mar 2025 10:28:54 +0100
Message-ID: <20250319092951.37667-2-jirislaby@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250319092951.37667-1-jirislaby@kernel.org>
References: <20250319092951.37667-1-jirislaby@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

um_pci_init() open-codes what the irq_domain_create_linear() helper
does already. Use the helper instead of open-coding it.

This needs retval checking modification.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Cc: Richard Weinberger <richard@nod.at>
Cc: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Cc: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-um@lists.infradead.org

[v2]
This is new in v2.
---
 arch/um/drivers/virt-pci.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/arch/um/drivers/virt-pci.c b/arch/um/drivers/virt-pci.c
index dd5580f975cc..efe8b474c07b 100644
--- a/arch/um/drivers/virt-pci.c
+++ b/arch/um/drivers/virt-pci.c
@@ -1000,11 +1000,6 @@ static struct resource virt_platform_resource = {
 
 static int __init um_pci_init(void)
 {
-	struct irq_domain_info inner_domain_info = {
-		.size		= MAX_MSI_VECTORS,
-		.hwirq_max	= MAX_MSI_VECTORS,
-		.ops		= &um_pci_inner_domain_ops,
-	};
 	int err, i;
 
 	WARN_ON(logic_iomem_add_region(&virt_cfgspace_resource,
@@ -1030,10 +1025,10 @@ static int __init um_pci_init(void)
 		goto free;
 	}
 
-	inner_domain_info.fwnode = um_pci_fwnode;
-	um_pci_inner_domain = irq_domain_instantiate(&inner_domain_info);
-	if (IS_ERR(um_pci_inner_domain)) {
-		err = PTR_ERR(um_pci_inner_domain);
+	um_pci_inner_domain = irq_domain_create_linear(um_pci_fwnode, MAX_MSI_VECTORS,
+						       &um_pci_inner_domain_ops, NULL);
+	if (!um_pci_inner_domain) {
+		err = -ENOMEM;
 		goto free;
 	}
 
@@ -1070,7 +1065,7 @@ static int __init um_pci_init(void)
 		goto free;
 	return 0;
 free:
-	if (!IS_ERR_OR_NULL(um_pci_inner_domain))
+	if (um_pci_inner_domain)
 		irq_domain_remove(um_pci_inner_domain);
 	if (um_pci_fwnode)
 		irq_domain_free_fwnode(um_pci_fwnode);
-- 
2.49.0


