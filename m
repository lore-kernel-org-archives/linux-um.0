Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E143AC6FA99
	for <linux-um@archiver.kernel.org>; Sun, 12 Mar 2023 05:26:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=dS+bEXMghresrnT8svXUrNN43WWyAamwcvqcUYL57a0=; b=W8xRG4NtRTJx0H
	M32xli1dKXDGjKNpadnt4DKDtjvdhlSGHzGuiV0QUdYeRB3FWhCrDBuDVwqSpGAuQzkCp5lP+rnl2
	pHzEipZfskga0AAypBI8yxj9qdFYYoPsD8B7LnfZysvJIscDpEL08gAxd13NJRMGDfd2BoQvd7YYG
	Fd9TuFHOWQcJa7SgYuaNchu1HM/GE5u00LdSg8WICvdUVzJzHfbmXaH6Ki0nIbDM5guHJIAAbcHcf
	6lOgnRf+2bHTT9VOq5sk6Zim32T00wlGgS1KXAuOETk30KIfbkUJPwQPxoEvkNdgLxCIttChZUX7D
	OFYDgY8mDZ7ipOmYTl1g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pbEE1-001ooE-CC; Sun, 12 Mar 2023 05:26:29 +0000
Received: from [2601:1c2:980:9ec0::df2f] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pbEDx-001onR-LW; Sun, 12 Mar 2023 05:26:25 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Damien Le Moal <damien.lemoal@opensource.wdc.com>,
	linux-ide@vger.kernel.org,
	linux-um@lists.infradead.org
Subject: [PATCH] ata: pata_cs5536: don't build on UML
Date: Sat, 11 Mar 2023 21:26:24 -0800
Message-Id: <20230312052624.8402-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
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

Similar to 22eebaa631c4 ("ata: pata_cs5535: Don't build on UML"),
prevent pata_cs5536 from building on UML since it references
symbols that are not present when building X86_32/i386 allmodconfig.

ERROR: modpost: "__tracepoint_write_msr" [drivers/ata/pata_cs5536.ko] undefined!
ERROR: modpost: "do_trace_write_msr" [drivers/ata/pata_cs5536.ko] undefined!
ERROR: modpost: "__tracepoint_read_msr" [drivers/ata/pata_cs5536.ko] undefined!
ERROR: modpost: "do_trace_read_msr" [drivers/ata/pata_cs5536.ko] undefined!

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc: linux-ide@vger.kernel.org
Cc: linux-um@lists.infradead.org
---
 drivers/ata/Kconfig |    1 +
 1 file changed, 1 insertion(+)

diff -- a/drivers/ata/Kconfig b/drivers/ata/Kconfig
--- a/drivers/ata/Kconfig
+++ b/drivers/ata/Kconfig
@@ -650,6 +650,7 @@ config PATA_CS5535
 config PATA_CS5536
 	tristate "CS5536 PATA support"
 	depends on PCI && (X86_32 || MIPS || COMPILE_TEST)
+	depends on !UML
 	help
 	  This option enables support for the AMD CS5536
 	  companion chip used with the Geode LX processor family.

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
