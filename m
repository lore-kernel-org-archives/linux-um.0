Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F1DCC4167B
	for <linux-um@archiver.kernel.org>; Fri,  3 Nov 2023 16:42:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:CC:To:In-Reply-To:References:Message-ID
	:MIME-Version:Subject:Date:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=5BrqhpkOHV+t+z8TcSbA6vM37g200HCSfb+LULFOjAs=; b=QnkQB+7WbQa7Dy
	+e7rqVR13zLlLm78FnjJV1PAzNpf8G3qZLoSzOaUCqa8VKr7tzQuJi0gsF9GUihCQ54wg+8odekuN
	cwUZyChw8vS1l1y3AtXMwbaqxWqimsL3AVupP8RkvVto4h8Z4u9Aa+vrjnxfHDVf4vNYivzKlPHJ/
	qqQ70CSNM7gHNEPxOcrgEldY95bO+qKc2W//RpaJlR0fP/EqJCuLo5rP/X6gi1yADxtWkfVOWx15N
	SQxKB5mKwAipZ0B7ycBp7DNOrDrvqSgDl383zTB/3QzD3g3mIgO86M+ilJhH3L/j4xegyUBk0/A/1
	eJ3dOIa27+mB/fZ1JyFg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qyxFP-00BnlB-1t;
	Fri, 03 Nov 2023 16:42:15 +0000
Received: from mx1.uni-rostock.de ([139.30.22.71])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qyxFJ-00BnjU-0a
	for linux-um@lists.infradead.org;
	Fri, 03 Nov 2023 16:42:13 +0000
Received: from 139.30.22.84 by mx1.uni-rostock.de (Tls12, Aes256, Sha384,
 DiffieHellmanEllipticKey384); Fri, 03 Nov 2023 16:42:00 GMT
DKIM-Signature: v=1; c=relaxed/relaxed; d=uni-rostock.de; s=itmze; 
 t=1699029720; bh=1ZY7X92pnMnsIY19LFNUSrdcE8xl1BEfH2ls6ywy8nc=; h=
 Subject:Subject:From:From:Date:Date:ReplyTo:ReplyTo:Cc:Cc:Message-Id:Message-Id; 
 a=ed25519-sha256; b=
 9gi42H4yXqwIjbJp3gYPawgL5dLuIjQ/T8WTAoAY1ni3F4qmbKovYlinKKJPopCjd3KTnV2scWkSvE8UB5DEDA==
DKIM-Signature: v=1; c=relaxed/relaxed; d=uni-rostock.de; s=itmz; 
 t=1699029720; bh=1ZY7X92pnMnsIY19LFNUSrdcE8xl1BEfH2ls6ywy8nc=; h=
 Subject:Subject:From:From:Date:Date:ReplyTo:ReplyTo:Cc:Cc:Message-Id:Message-Id; 
 a=rsa-sha256; b=
 UiHXq7MbqwvSi5/3CwngT2LJUbw6Dex/4fszw9XOjpjb6IHuwSrCqhOn0fXTNAFHOF2FneBz8OGBg+Vo9vNBSA5LVsg41oyUWcZUZq1EqCr7AUYHN02U678NofUcnrZKk+8xwtO5fkQFYQQUlwQrGvL/05B/TldmnGuMu97JNHQ=
Received: from mininet-experimente.amd.e-technik.uni-rostock.de (139.30.201.3)
 by mail1.uni-rostock.de (139.30.22.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Fri, 3 Nov 2023 17:41:56 +0100
From: Benjamin Beichler <benjamin.beichler@uni-rostock.de>
Date: Fri, 3 Nov 2023 16:41:40 +0000
Subject: [PATCH RFC 02/11] um: add a simple time_travel_handler
 implementation
MIME-Version: 1.0
Message-ID: <20231103-bb-timetravel-patches-v1-2-e2c68efcf664@uni-rostock.de>
References: <20231103-bb-timetravel-patches-v1-0-e2c68efcf664@uni-rostock.de>
In-Reply-To: <20231103-bb-timetravel-patches-v1-0-e2c68efcf664@uni-rostock.de>
To: Richard Weinberger <richard@nod.at>, Anton Ivanov
	<anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>
CC: <linux-um@lists.infradead.org>, Benjamin Beichler
	<benjamin.beichler@uni-rostock.de>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1699029716; l=1083;
 i=benjamin.beichler@uni-rostock.de; s=20231103; h=from:subject:message-id;
 bh=AUx+GmuFvsd569qGGE08iczX/VPuDGvsieK9N3BcPA4=;
 b=kB4o1zawvSPZKbRiyyY/fmBuw6q00voRqvdrfm9fJA0FFPk9ga5kY3C3aBMhybcgJUwnFCA4U
 QE+SbDF5cPWCGEycbJOQz93lM2Uqbgxva2PHs0ptUSgpecnHfvop7Kd
X-Developer-Key: i=benjamin.beichler@uni-rostock.de; a=ed25519;
 pk=fla2/IRwqFWH5W+fACqQyDu/mTc6mEcSPQtqb/SoX8o=
X-Originating-IP: [139.30.201.3]
X-ClientProxiedBy: email3.uni-rostock.de (139.30.22.83) To
 mail1.uni-rostock.de (139.30.22.84)
X-TM-SNTS-SMTP: 4D8F6D2F97742BA6ABAA78C5B40DC353BFA3EEDE93D6A1B3AFBE2707EA010EDB2000:8
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231103_094210_125142_EA552153 
X-CRM114-Status: UNSURE (   7.54  )
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

Use in uml drivers, which do not need more than scheduling the interrupt
at the time of a follow up timetravel GET-Message.

Signed-off-by: Benjamin Beichler <benjamin.beichler@uni-rostock.de>
---
 arch/um/include/shared/irq_user.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/um/include/shared/irq_user.h b/arch/um/include/shared/irq_user.h
index da0f6eea30d0..8c336c79ffb9 100644
--- a/arch/um/include/shared/irq_user.h
+++ b/arch/um/include/shared/irq_user.h
@@ -17,6 +17,13 @@ enum um_irq_type {
 struct siginfo;
 extern void sigio_handler(int sig, struct siginfo *unused_si, struct uml_pt_regs *regs);
 void sigio_run_timetravel_handlers(void);
+
+struct time_travel_event;
+extern void time_travel_add_irq_event(struct time_travel_event *ev);
+static inline void simple_timetravel_handler(int irq, int fd, void *data,
+					  struct time_travel_event *ev) {
+	time_travel_add_irq_event(ev);
+}
 extern void free_irq_by_fd(int fd);
 extern void deactivate_fd(int fd, int irqnum);
 extern int deactivate_all_fds(void);

-- 
2.34.1



_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
