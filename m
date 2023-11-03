Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BCCCC4332F
	for <linux-um@archiver.kernel.org>; Fri,  3 Nov 2023 16:42:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:CC:To:In-Reply-To:References:Message-ID
	:MIME-Version:Subject:Date:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=+jvtFvr0gSrmwoP8+7sqSAaCVUA4OXSNAsQbLkULeY4=; b=01CVBcDK0gvkIu
	TnyYQ6adqxewWmEKU/qojULZxLqsFIOh0MwSTb0mbjeRJvbBV2xKDyUl02OOMU1hC2WwmKPsT2drg
	apt6W7bnSmc/0OnfnW33bh2yCeOn2k6XbobYoOLp+MEyYLZgPweeklBZ1vPIE1+p0/dIioNk/NP4q
	kJVrYaxx2/3YDFn+wDRkmf5Mk3mq3l16Fkn2Z5D/wPR/O+7llxMlYWU1vXXnlNExHNQK6TJXu/6eO
	0JHFwJdjBNjJZrQjw4CYnW7N3GZjF5DW56l5FQ9tP8PcAUSJF1i3XKN5Va/D+IaDA7NAWGwwOqQVb
	JtRkDN5lP71TKVJI5DqA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qyxFP-00BnlG-2u;
	Fri, 03 Nov 2023 16:42:15 +0000
Received: from mx1.uni-rostock.de ([139.30.22.71])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qyxFJ-00BnjX-0e
	for linux-um@lists.infradead.org;
	Fri, 03 Nov 2023 16:42:13 +0000
Received: from 139.30.22.84 by mx1.uni-rostock.de (Tls12, Aes256, Sha384,
 DiffieHellmanEllipticKey384); Fri, 03 Nov 2023 16:42:01 GMT
DKIM-Signature: v=1; c=relaxed/relaxed; d=uni-rostock.de; s=itmze; 
 t=1699029721; bh=kWrrIs3UtL45ZMJGNIGiwZAwEr1yJtlRhqWcnVdyS3M=; h=
 Subject:Subject:From:From:Date:Date:ReplyTo:ReplyTo:Cc:Cc:Message-Id:Message-Id; 
 a=ed25519-sha256; b=
 nQy1UTJtmzTMXs7dnfMkPljyDyDKeco7iQq+AZmZ+WUrXR+2mW1P5phKshdtYG78VcMPiJnzcxpzsQpUEIABDg==
DKIM-Signature: v=1; c=relaxed/relaxed; d=uni-rostock.de; s=itmz; 
 t=1699029721; bh=kWrrIs3UtL45ZMJGNIGiwZAwEr1yJtlRhqWcnVdyS3M=; h=
 Subject:Subject:From:From:Date:Date:ReplyTo:ReplyTo:Cc:Cc:Message-Id:Message-Id; 
 a=rsa-sha256; b=
 ZZgULq9qoyKlDIC+5CuNb++uKi+85nc9MXxlss3zdaZYK9CioT/JHVO6zO7a7j+9xETSDwRsVrjwPae2qM9WccShw27w4ml4Owk2Y8gJhsnGZ8wJ9y8Hi/m2/ofOb7LiMZnkGbgc95yj03ewtApOexMEIXH91mMIOtlhd3gkrhk=
Received: from mininet-experimente.amd.e-technik.uni-rostock.de (139.30.201.3)
 by mail1.uni-rostock.de (139.30.22.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Fri, 3 Nov 2023 17:41:57 +0100
From: Benjamin Beichler <benjamin.beichler@uni-rostock.de>
Date: Fri, 3 Nov 2023 16:41:41 +0000
Subject: [PATCH RFC 03/11] um: Use a simple time travel handler for line
 interrupts
MIME-Version: 1.0
Message-ID: <20231103-bb-timetravel-patches-v1-3-e2c68efcf664@uni-rostock.de>
References: <20231103-bb-timetravel-patches-v1-0-e2c68efcf664@uni-rostock.de>
In-Reply-To: <20231103-bb-timetravel-patches-v1-0-e2c68efcf664@uni-rostock.de>
To: Richard Weinberger <richard@nod.at>, Anton Ivanov
	<anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>
CC: <linux-um@lists.infradead.org>, Benjamin Beichler
	<benjamin.beichler@uni-rostock.de>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1699029716; l=1390;
 i=benjamin.beichler@uni-rostock.de; s=20231103; h=from:subject:message-id;
 bh=oUWecdXr0IF2cOLtLivJrlkjjt6eZJH7/VVzHS9ciVE=;
 b=zaAuDZsKJxWnDBsc4lAjUI18JRDA5m5ST4ri+sTj7B9S2XCFJWJcE0oITsanJKYzTGGCciGrj
 9JR5lgRmRnOCzz5YObV7jWv8LCcB9sagqxfehLTY0IZZFOPVUHUqr7g
X-Developer-Key: i=benjamin.beichler@uni-rostock.de; a=ed25519;
 pk=fla2/IRwqFWH5W+fACqQyDu/mTc6mEcSPQtqb/SoX8o=
X-Originating-IP: [139.30.201.3]
X-ClientProxiedBy: email3.uni-rostock.de (139.30.22.83) To
 mail1.uni-rostock.de (139.30.22.84)
X-TM-SNTS-SMTP: A08383C23EFA02E0CC8E04C6DF65119EBAE7CC12EABFED830CCA4D2528192B8B2000:8
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231103_094210_125330_74D47C79 
X-CRM114-Status: UNSURE (   9.41  )
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

This change permits interrupts on serial lines in time travel mode,
especially in external mode. However, these interrupts are processed
with the simple handler that does not provide any acknowledgment.

Signed-off-by: Benjamin Beichler <benjamin.beichler@uni-rostock.de>
---
 arch/um/drivers/line.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/um/drivers/line.c b/arch/um/drivers/line.c
index b98545f3edb5..3cda0ae41824 100644
--- a/arch/um/drivers/line.c
+++ b/arch/um/drivers/line.c
@@ -260,9 +260,9 @@ int line_setup_irq(int fd, int input, int output, struct line *line, void *data)
 	int err;
 
 	if (input) {
-		err = um_request_irq(UM_IRQ_ALLOC, fd, IRQ_READ,
+		err = um_request_irq_tt(UM_IRQ_ALLOC, fd, IRQ_READ,
 				     line_interrupt, 0,
-				     driver->read_irq_name, data);
+				     driver->read_irq_name, data, simple_timetravel_handler);
 		if (err < 0)
 			return err;
 
@@ -270,9 +270,9 @@ int line_setup_irq(int fd, int input, int output, struct line *line, void *data)
 	}
 
 	if (output) {
-		err = um_request_irq(UM_IRQ_ALLOC, fd, IRQ_WRITE,
+		err = um_request_irq_tt(UM_IRQ_ALLOC, fd, IRQ_WRITE,
 				     line_write_interrupt, 0,
-				     driver->write_irq_name, data);
+				     driver->write_irq_name, data, simple_timetravel_handler);
 		if (err < 0)
 			return err;
 

-- 
2.34.1



_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
