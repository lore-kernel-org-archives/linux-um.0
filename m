Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CD03C369B5
	for <linux-um@archiver.kernel.org>; Tue, 15 Apr 2025 11:30:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=qiKWjxg5hQYXh6VJ5Ta8nDxBJKqJG2XK/zQe6QSPUTA=; b=rNudkAOASpVmgh2Lj3kc1amTzB
	EOgY7ZhS95blcVw/0NOdpplovaM01oZpl96IRAQO7lQNp3GEtZBHI0g5HqjDF62NHGV7Zs2vRdzW5
	94/X1m2ZZQ4GbZ4vpWWnYo1tn7UPMWURe3SvsYuSQuzk2UK6zBDSop84Cb9A9rD/0OSFxAqi8EMlR
	bYDRnxdOkDvxpDjeeEHNbaRzfKGahm18f1W05i02/ENmb55FjNtNZwqUeBbalE5x458Z51tFxACi8
	aMI7QoLUhrCZsKnItwkNgcZEJkZrdseeQXkYdw91ZY+1DZY4SPHaThumIOdqfVZ5T19AUlTA1WI3K
	4iqQJdOQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u4eUN-00000005Y1W-20WJ;
	Tue, 15 Apr 2025 11:30:03 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u4dp0-00000005OeL-13kg
	for linux-um@lists.infradead.org;
	Tue, 15 Apr 2025 10:47:19 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 6A73049F2C;
	Tue, 15 Apr 2025 10:47:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70C8BC4CEDD;
	Tue, 15 Apr 2025 10:47:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744714037;
	bh=Qr5jAtX5LdltRj0+jBrQD2OFGLWc+8yqyC9x+FYYSN4=;
	h=From:To:Cc:Subject:Date:From;
	b=ChHfftTja9fjpy6EIp5fzmOJuuqZtwU53iYcFKmVecsT5TiEKetxAjCSZDj4RoxRH
	 YAsKBjQhoqwi/zdKr4z4ub0P+/sVGXTj5BjbmdC12CtFiJRH9jw6WAxZr8yNS8s1cQ
	 sWxbD5NeTHcg/NnD/Yk9ktLdivlRvJl11NLyi+X/jjk1Xl0SU8+c3kxFYvjlVxdg+Q
	 GW0qp7L0+vadG3Lv5bMV49w6pr4McDuwScdfRTS9YmflDM6N9cjhTq3c+1TD4Wu5Sj
	 xEciLvAHnXqol6pKt1N8CXsUU5ndjuSjcstYqq37VFJ/RjQzZztRivlc1KKM/pXAXu
	 E5lSXNwveKa2A==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: richard@nod.at
Cc: tglx@linutronix.de,
	maz@kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	linux-um@lists.infradead.org
Subject: [PATCH] irqdomain: um: use irq_domain_create_linear() helper
Date: Tue, 15 Apr 2025 12:47:13 +0200
Message-ID: <20250415104713.106819-1-jirislaby@kernel.org>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250415_034718_321469_DFBEF434 
X-CRM114-Status: GOOD (  10.61  )
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

---
This is an indepent patch, please apply directly.

The patch was previously a part of a large series [1], but I would like
maintainers to feed the independent parts through their trees.

[1] https://lore.kernel.org/all/20250319092951.37667-1-jirislaby@kernel.org/

[v2]
This is new in v2.
---
 arch/um/drivers/virt-pci.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/arch/um/drivers/virt-pci.c b/arch/um/drivers/virt-pci.c
index b83b5a765d4e..0fe207ca4b72 100644
--- a/arch/um/drivers/virt-pci.c
+++ b/arch/um/drivers/virt-pci.c
@@ -538,11 +538,6 @@ void um_pci_platform_device_unregister(struct um_pci_device *dev)
 
 static int __init um_pci_init(void)
 {
-	struct irq_domain_info inner_domain_info = {
-		.size		= MAX_MSI_VECTORS,
-		.hwirq_max	= MAX_MSI_VECTORS,
-		.ops		= &um_pci_inner_domain_ops,
-	};
 	int err, i;
 
 	WARN_ON(logic_iomem_add_region(&virt_cfgspace_resource,
@@ -564,10 +559,10 @@ static int __init um_pci_init(void)
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
 
@@ -602,7 +597,7 @@ static int __init um_pci_init(void)
 	return 0;
 
 free:
-	if (!IS_ERR_OR_NULL(um_pci_inner_domain))
+	if (um_pci_inner_domain)
 		irq_domain_remove(um_pci_inner_domain);
 	if (um_pci_fwnode)
 		irq_domain_free_fwnode(um_pci_fwnode);
-- 
2.49.0


