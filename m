Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D416C4332F
	for <linux-um@archiver.kernel.org>; Fri,  3 Nov 2023 16:42:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:CC:To:In-Reply-To:References:Message-ID
	:MIME-Version:Subject:Date:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=vYElSr3WfrgySKgDYQ4q2XEi5pKgMlDcPB6yhyBfjuE=; b=i81PZ7HYGfDZOj
	cEZksXzXP75iN/aL3QslCzif+EkXgTS/WmJtuEMDWsteoz91ffjlW+KNJ4OiPsUxT49O6Rx4IBMwr
	fKNF5mWjxEqnJQfmuAB7bxb1hz15TWRGELjJkMPVTn2pFpkQIysTqcDcZ8N6TY8v7cD8J4kJz1lok
	RQ4cWKgf2KDhD4Maob0eimcVUOMo5yrPaQn6m8Wt7Z5ZxJEKVDDYWAW8SyIV/wuzyeYIjMGTUT9Qr
	HwxJKQHaGej+pPwADX5QHgmSua5MPS1g8KFmhsNiGMy/Of3TdwbT+TxIeFatY6RmkzmfCcNNiiRPn
	1yqdtXl+mmv0dFYKYiCw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qyxFa-00BnrP-0h;
	Fri, 03 Nov 2023 16:42:26 +0000
Received: from mx1.uni-rostock.de ([139.30.22.71])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qyxFU-00BnjS-2d
	for linux-um@lists.infradead.org;
	Fri, 03 Nov 2023 16:42:24 +0000
Received: from 139.30.22.84 by mx1.uni-rostock.de (Tls12, Aes256, Sha384,
 DiffieHellmanEllipticKey384); Fri, 03 Nov 2023 16:42:07 GMT
DKIM-Signature: v=1; c=relaxed/relaxed; d=uni-rostock.de; s=itmze; 
 t=1699029727; bh=/gQjcBz/Vi/HkJdzNEFOX47B7D0y/1xPFVbKVqFTHT8=; h=
 Subject:Subject:From:From:Date:Date:ReplyTo:ReplyTo:Cc:Cc:Message-Id:Message-Id; 
 a=ed25519-sha256; b=
 lCNTnk8MlRlmM+OOZH3yyy4eYGkqFCnYMq1w5AGIjaaETgxY12kgMy/RSiV/yJY6/tHaPUAAPr8cEJpEVf30DA==
DKIM-Signature: v=1; c=relaxed/relaxed; d=uni-rostock.de; s=itmz; 
 t=1699029727; bh=/gQjcBz/Vi/HkJdzNEFOX47B7D0y/1xPFVbKVqFTHT8=; h=
 Subject:Subject:From:From:Date:Date:ReplyTo:ReplyTo:Cc:Cc:Message-Id:Message-Id; 
 a=rsa-sha256; b=
 fnUa6aGVZgcSrr6u7V8fBk18aeDK1qOet3Fth6AznyCokUEX04bLiI8+zlWtj0qw2DfgHcNodb+DhVZr1nKT3UlQAjx+MbB1wxt/FjyhqQ4kh99Eb28ikwwuhB1ygEJPaLLUVgJM+3awOSL6Yfci0dDrCcOtl8D21tZLQw1EME8=
Received: from mininet-experimente.amd.e-technik.uni-rostock.de (139.30.201.3)
 by mail1.uni-rostock.de (139.30.22.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Fri, 3 Nov 2023 17:41:57 +0100
From: Benjamin Beichler <benjamin.beichler@uni-rostock.de>
Date: Fri, 3 Nov 2023 16:41:47 +0000
Subject: [PATCH RFC 09/11] um: Delay timer_read in time travel mode only
 after consecutive reads
MIME-Version: 1.0
Message-ID: <20231103-bb-timetravel-patches-v1-9-e2c68efcf664@uni-rostock.de>
References: <20231103-bb-timetravel-patches-v1-0-e2c68efcf664@uni-rostock.de>
In-Reply-To: <20231103-bb-timetravel-patches-v1-0-e2c68efcf664@uni-rostock.de>
To: Richard Weinberger <richard@nod.at>, Anton Ivanov
	<anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>
CC: <linux-um@lists.infradead.org>, Benjamin Beichler
	<benjamin.beichler@uni-rostock.de>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1699029716; l=1732;
 i=benjamin.beichler@uni-rostock.de; s=20231103; h=from:subject:message-id;
 bh=gYYkPHoC/BeZdF3NsLFtZdipUoD67sIIs3zzuRe4EAc=;
 b=qNjT+9ZlfCCLI3bIOoqFaMJvEJky+Cv40dcx128vYi79Fi3YNm6HNvk/qqQU+2REB4TEFBGVO
 BIkY9AfsJDxCRmD3BMLup8xFcQUYLcZ0uxbHnPMlQgqFMn3gsm3vxkg
X-Developer-Key: i=benjamin.beichler@uni-rostock.de; a=ed25519;
 pk=fla2/IRwqFWH5W+fACqQyDu/mTc6mEcSPQtqb/SoX8o=
X-Originating-IP: [139.30.201.3]
X-ClientProxiedBy: email3.uni-rostock.de (139.30.22.83) To
 mail1.uni-rostock.de (139.30.22.84)
X-TM-SNTS-SMTP: 96CA85543203E8B74B9384DCEFB97B9F7ED42428D68DD10E594024F0F1764FD42000:8
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231103_094221_154636_CAE78C17 
X-CRM114-Status: GOOD (  11.64  )
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

Given the presence of numerous timer_read calls in well-behaved code
within the kernel and userspace, particularly those that do not employ
busy loops, we introduce a delay in reading the timer only after several
consecutive attempts (currently set at 10).

Unfortunately, it is challenging to differentiate between various
callers and pinpoint specific misbehaving code, so this is only a
mediocre heuristic.

Signed-off-by: Benjamin Beichler <benjamin.beichler@uni-rostock.de>
---
 arch/um/kernel/time.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/um/kernel/time.c b/arch/um/kernel/time.c
index f1b2ca45994d..f76237cfc1ea 100644
--- a/arch/um/kernel/time.c
+++ b/arch/um/kernel/time.c
@@ -723,6 +723,9 @@ static irqreturn_t um_timer(int irq, void *dev)
 
 static u64 timer_read(struct clocksource *cs)
 {
+	static unsigned long long last_timer_read;
+	static int consecutive_calls_at_same_time;
+
 	if (time_travel_mode != TT_MODE_OFF) {
 		/*
 		 * We make reading the timer cost a bit so that we don't get
@@ -736,8 +739,14 @@ static u64 timer_read(struct clocksource *cs)
 		 * "what do I do next" and onstack event we use to know when
 		 * to return from time_travel_update_time().
 		 */
+		if (last_timer_read != time_travel_time) {
+			last_timer_read = time_travel_time;
+			consecutive_calls_at_same_time = 0;
+		} else {
+			consecutive_calls_at_same_time++;
+		}
 		if (!irqs_disabled() && !in_interrupt() && !in_softirq() &&
-		    !time_travel_ext_waiting)
+		    !time_travel_ext_waiting && consecutive_calls_at_same_time > 10)
 			time_travel_update_time(time_travel_time +
 						TIMER_MULTIPLIER,
 						false);

-- 
2.34.1



_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
