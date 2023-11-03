Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13CB0C001B2
	for <linux-um@archiver.kernel.org>; Fri,  3 Nov 2023 16:42:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:CC:To:In-Reply-To:References:Message-ID
	:MIME-Version:Subject:Date:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=t+q3fzIyXlNuGEXf/6eFQp0cBwMzreUZV39G8b+dJ+0=; b=BXO51newTD16KN
	H2w4JM+djy0wsJ+4AvFDxngbrDSxazmrAGt6gZLC6dEPRLg3MbSDlqcg0gaXujSROEkfxn3SrhFCH
	1fg6ICmJtgUYhBK0benONzVwwvaOsspyURIxsyJG4aF6rCWM2N+TSXbLhj6wG03wsy5gZ6ehlombD
	G55kgicMgUOeLwYCQfyeI1IyuaKOh92ksSLW/o39cTAzyBA30hS97iCH+s1T6lubi1fUIXL7b8T0R
	kEhcHMnCOc9sewOSXelZKFbV3Vga3HX3e2ByfYeQ/znTs3FgtuLBwJudoLpW7/3MWtlcgFUw27QH+
	Q0yXcbfA9654vRhg//jQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qyxFV-00BnoM-2P;
	Fri, 03 Nov 2023 16:42:21 +0000
Received: from mx1.uni-rostock.de ([139.30.22.71])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qyxFS-00BnjT-0l
	for linux-um@lists.infradead.org;
	Fri, 03 Nov 2023 16:42:20 +0000
Received: from 139.30.22.84 by mx1.uni-rostock.de (Tls12, Aes256, Sha384,
 DiffieHellmanEllipticKey384); Fri, 03 Nov 2023 16:42:05 GMT
DKIM-Signature: v=1; c=relaxed/relaxed; d=uni-rostock.de; s=itmze; 
 t=1699029725; bh=+I6LfghT6UhHMk52j4tHBEBojG5M3F9dzwIC7tXxeOg=; h=
 Subject:Subject:From:From:Date:Date:ReplyTo:ReplyTo:Cc:Cc:Message-Id:Message-Id; 
 a=ed25519-sha256; b=
 sUPspnMB0YDD4YCdxCidZXlXZ1iZ10pyV1fi/Q8zmy5EMdSMY5p6wWt0SW5Or+Yyh78/DK9GECDVNfd0fiSBBw==
DKIM-Signature: v=1; c=relaxed/relaxed; d=uni-rostock.de; s=itmz; 
 t=1699029725; bh=+I6LfghT6UhHMk52j4tHBEBojG5M3F9dzwIC7tXxeOg=; h=
 Subject:Subject:From:From:Date:Date:ReplyTo:ReplyTo:Cc:Cc:Message-Id:Message-Id; 
 a=rsa-sha256; b=
 l3bvMEhn7bCyi6MCOzYwkIZcrNwfVo0avNCcs8uF7VVGbdRad5zqTzZtO+rkUJkxTjeNFdRBGylsSsoIDXDBWP+5CxX0Vo0z/EnHuzIclazTCXuA5YO0lz7t5R93ecBrKv38qvZSjhx/rfmEds57EbtLMkRj6znpUy6lABSpJ50=
Received: from mininet-experimente.amd.e-technik.uni-rostock.de (139.30.201.3)
 by mail1.uni-rostock.de (139.30.22.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Fri, 3 Nov 2023 17:41:57 +0100
From: Benjamin Beichler <benjamin.beichler@uni-rostock.de>
Date: Fri, 3 Nov 2023 16:41:44 +0000
Subject: [PATCH RFC 06/11] um: always send UM_TIMETRAVEL_REQUEST from ISRs
MIME-Version: 1.0
Message-ID: <20231103-bb-timetravel-patches-v1-6-e2c68efcf664@uni-rostock.de>
References: <20231103-bb-timetravel-patches-v1-0-e2c68efcf664@uni-rostock.de>
In-Reply-To: <20231103-bb-timetravel-patches-v1-0-e2c68efcf664@uni-rostock.de>
To: Richard Weinberger <richard@nod.at>, Anton Ivanov
	<anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>
CC: <linux-um@lists.infradead.org>, Benjamin Beichler
	<benjamin.beichler@uni-rostock.de>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1699029716; l=1196;
 i=benjamin.beichler@uni-rostock.de; s=20231103; h=from:subject:message-id;
 bh=whauhw64hJbXS+FrcF3n/N+PPrSKvl+WxTmvMFoPidY=;
 b=bsFuqjsp6MeQtZnZEaW1L3412l43LuXj38wf1P+97Q8441yKn/Zh42TlI1MuRyPcK5OFd5btF
 XE+tH6FXOf6A+qAmrjAGjNIe5sRAjytihp4sxILyzaieRsQdkhBQbXa
X-Developer-Key: i=benjamin.beichler@uni-rostock.de; a=ed25519;
 pk=fla2/IRwqFWH5W+fACqQyDu/mTc6mEcSPQtqb/SoX8o=
X-Originating-IP: [139.30.201.3]
X-ClientProxiedBy: email3.uni-rostock.de (139.30.22.83) To
 mail1.uni-rostock.de (139.30.22.84)
X-TM-SNTS-SMTP: 5049AD6F7FC391B63B6EABB41DBA2FF2640FDFB035AC0548DE839B438844BDEF2000:8
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231103_094218_571054_481F6FD1 
X-CRM114-Status: GOOD (  10.02  )
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

The number of UM_TIMETRAVEL_REQUEST msgs is tried to reduced, if they
are redundant via the time_travel_ext_prev_request_valid flag. This can
create a race condition, when an interrupt happens and the idle loop
wants to wait.

This means, sometimes the UM_TIMETRAVEL_REQUEST are sent(when the idle
loop already started waiting) and sometimes not, which makes it harder
to implement the other end of the scheduler. Therefore, this fix make
the time travel protocol a bit more deterministic by always sending the
UM_TIMETRAVEL_REQUEST msg.

Signed-off-by: Benjamin Beichler <benjamin.beichler@uni-rostock.de>
---
 arch/um/kernel/time.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/um/kernel/time.c b/arch/um/kernel/time.c
index abd5fd0f62ee..54fc4a69cb59 100644
--- a/arch/um/kernel/time.c
+++ b/arch/um/kernel/time.c
@@ -446,6 +446,7 @@ void time_travel_add_irq_event(struct time_travel_event *e)
 	BUG_ON(time_travel_mode != TT_MODE_EXTERNAL);
 
 	time_travel_ext_get_time();
+	time_travel_ext_prev_request_valid = false;
 	/*
 	 * We could model interrupt latency here, for now just
 	 * don't have any latency at all and request the exact

-- 
2.34.1



_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
