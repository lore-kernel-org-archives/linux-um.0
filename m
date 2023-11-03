Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 739A7C001DB
	for <linux-um@archiver.kernel.org>; Fri,  3 Nov 2023 16:42:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:CC:To:In-Reply-To:References:Message-ID
	:MIME-Version:Subject:Date:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=2P70hoY/IebAR3mUR9Sg7kJp98dnvet9E5TgilXC8a8=; b=dJ281C9qrGvaoZ
	wouuNLRCZvAG8IILa+PMDnBBvOPeu1ibrhMroLl6M/RPFhP/goX/lxtGgjHm143vqHXjRxBvVUXcG
	P50aT6KL0ZRSQZ4m7rWdXa2Xnu9NpKaB1pFfOB7dXUREKBC536BnY2ZATALg7Qxag7xanGaVIJ+7/
	wGZ+KTL17sk50rvRHTsxUY3LfnVjo+h/3pab4GHJ2PzFIGsj26G2WPtTtVGC08BRNDnWqZKAoIFRP
	/XVcUKBmvK5+0xuLlj1frbxPQ2H5pcIDt8YkCRqw2JgL2ncpFu7vqE+9kVPVJ1Yvduvqb9rXVHF81
	DVGXn8zh0MZSBDwVEhow==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qyxFW-00Bnp1-0W;
	Fri, 03 Nov 2023 16:42:22 +0000
Received: from mx1.uni-rostock.de ([139.30.22.71])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qyxFT-00BnjU-0Y
	for linux-um@lists.infradead.org;
	Fri, 03 Nov 2023 16:42:20 +0000
Received: from 139.30.22.84 by mx1.uni-rostock.de (Tls12, Aes256, Sha384,
 DiffieHellmanEllipticKey384); Fri, 03 Nov 2023 16:42:06 GMT
DKIM-Signature: v=1; c=relaxed/relaxed; d=uni-rostock.de; s=itmze; 
 t=1699029726; bh=fUEg05OpiHl405oisu7qrYfj0DwJua0tpNnW7igBs50=; h=
 Subject:Subject:From:From:Date:Date:ReplyTo:ReplyTo:Cc:Cc:Message-Id:Message-Id; 
 a=ed25519-sha256; b=
 bCv2E3fkpMDo4G1Jm+kep4/wbUsVQ9HWR08sBZB6BQzb4RJnMQVXeww9AcnXLPP4VbdalVuazJSoWNsc9A4yDA==
DKIM-Signature: v=1; c=relaxed/relaxed; d=uni-rostock.de; s=itmz; 
 t=1699029726; bh=fUEg05OpiHl405oisu7qrYfj0DwJua0tpNnW7igBs50=; h=
 Subject:Subject:From:From:Date:Date:ReplyTo:ReplyTo:Cc:Cc:Message-Id:Message-Id; 
 a=rsa-sha256; b=
 TPj7JiP5wUfln5FPFJ1OcjAzd/d6dgvIuqU/rdEacSrymZSVWOpLTF7awAehf17tXFGtuIcvtGcFAWMzK74NxDjyIUGagg3w/ETpX4G9xXGj6jxecF/tRpTEA2aAatNcYwmGdmZ+5BQCTTiUUAcmoRXEYwBtCSLIs9F7iRWys94=
Received: from mininet-experimente.amd.e-technik.uni-rostock.de (139.30.201.3)
 by mail1.uni-rostock.de (139.30.22.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Fri, 3 Nov 2023 17:41:57 +0100
From: Benjamin Beichler <benjamin.beichler@uni-rostock.de>
Date: Fri, 3 Nov 2023 16:41:45 +0000
Subject: [PATCH RFC 07/11] um: add TIMETRAVEL_REQUEST handler to request
 latest event
MIME-Version: 1.0
Message-ID: <20231103-bb-timetravel-patches-v1-7-e2c68efcf664@uni-rostock.de>
References: <20231103-bb-timetravel-patches-v1-0-e2c68efcf664@uni-rostock.de>
In-Reply-To: <20231103-bb-timetravel-patches-v1-0-e2c68efcf664@uni-rostock.de>
To: Richard Weinberger <richard@nod.at>, Anton Ivanov
	<anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>
CC: <linux-um@lists.infradead.org>, Benjamin Beichler
	<benjamin.beichler@uni-rostock.de>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1699029716; l=1465;
 i=benjamin.beichler@uni-rostock.de; s=20231103; h=from:subject:message-id;
 bh=KH4ddAp2EGaPigbmgh2m0lGLX53d6Wn+CycqcrZ439M=;
 b=UDdrMOAiibfsaWrMYNcKv1ExW9ME7CiFhUcfuxQ3RtV+LHFXBWWTXi4vZ+ozT6skkLuoAm8kn
 uJD3r8u/YmVDLuBUBE3IVTXq3eE7YU0+IgZzLgpJQqQX7GmX2NHMPVJ
X-Developer-Key: i=benjamin.beichler@uni-rostock.de; a=ed25519;
 pk=fla2/IRwqFWH5W+fACqQyDu/mTc6mEcSPQtqb/SoX8o=
X-Originating-IP: [139.30.201.3]
X-ClientProxiedBy: email3.uni-rostock.de (139.30.22.83) To
 mail1.uni-rostock.de (139.30.22.84)
X-TM-SNTS-SMTP: 0FECC66DA8C54EA4FA4EAF56094332371BB6D70CE4A7DE73E7F2FA07F84D7F302000:8
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231103_094219_504307_8AB6422F 
X-CRM114-Status: UNSURE (   9.76  )
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

Allow the so called Calendar (or simulation master) to request the
latest timetravel event. This can be used in situations, where the
former request message from UML to Calendar was missed.

Signed-off-by: Benjamin Beichler <benjamin.beichler@uni-rostock.de>
---
 arch/um/kernel/time.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/um/kernel/time.c b/arch/um/kernel/time.c
index 54fc4a69cb59..e513256eadfe 100644
--- a/arch/um/kernel/time.c
+++ b/arch/um/kernel/time.c
@@ -41,6 +41,7 @@ static bool time_travel_ext_prev_request_valid;
 static unsigned long long time_travel_ext_prev_request;
 static bool time_travel_ext_free_until_valid;
 static unsigned long long time_travel_ext_free_until;
+static struct time_travel_event *time_travel_first_event(void);
 
 static void time_travel_set_time(unsigned long long ns)
 {
@@ -66,6 +67,7 @@ static void time_travel_handle_message(struct um_timetravel_msg *msg,
 		.op = UM_TIMETRAVEL_ACK,
 	};
 	int ret;
+	struct time_travel_event *event;
 
 	/*
 	 * We can't unlock here, but interrupt signals with a timetravel_handler
@@ -103,6 +105,10 @@ static void time_travel_handle_message(struct um_timetravel_msg *msg,
 		time_travel_ext_free_until_valid = true;
 		time_travel_ext_free_until = msg->time;
 		break;
+	case UM_TIMETRAVEL_REQUEST:
+		event = time_travel_first_event();
+		resp.time = event->time;
+		break;
 	}
 
 	resp.seq = msg->seq;

-- 
2.34.1



_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
