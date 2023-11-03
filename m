Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB49FC0018A
	for <linux-um@archiver.kernel.org>; Fri,  3 Nov 2023 16:42:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:CC:To:In-Reply-To:References:Message-ID
	:MIME-Version:Subject:Date:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=9Gp7GpCdjhT7yJ32totTLE8q/enhiUqRyPoolax2FmA=; b=noaKt+icL1akus
	SdAbn+n+XV4GfeJvi3PnCSVXQH/FDYndynlWxLd7iSghBovhcgfXOQWnVKVKgfdLlKULxSCzsz3ao
	CIVLIABcSGu3B0MouXe6bdMe0SpQymfxFzGCPTjMhBN7nVAGBcqQH+TsNV/B68ATqLsMCca14pUwX
	7plVDRd/Mq+vtCmaOa6TxmFhxYio8TjseSuyHj03aZ6TzYVOS2L/AoeevDL5hzorLmP8LVHhWyjlS
	7wmrTEbVe9EfUkMq3c/UwK281QbE8oZlpm3Xe++nPIxHwgpSTTtEsgpHQn4OsluA6TPqcclWzAPl2
	RswRlbVeKmjoc8WVrD9w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qyxFV-00Bno5-1H;
	Fri, 03 Nov 2023 16:42:21 +0000
Received: from mx1.uni-rostock.de ([139.30.22.71])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qyxFS-00BnjS-0l
	for linux-um@lists.infradead.org;
	Fri, 03 Nov 2023 16:42:20 +0000
Received: from 139.30.22.84 by mx1.uni-rostock.de (Tls12, Aes256, Sha384,
 DiffieHellmanEllipticKey384); Fri, 03 Nov 2023 16:42:02 GMT
DKIM-Signature: v=1; c=relaxed/relaxed; d=uni-rostock.de; s=itmze; 
 t=1699029722; bh=5oUNntIsz42ye+cbkNuzUBfKHPkK2L8T7r9lTsxpiH4=; h=
 Subject:Subject:From:From:Date:Date:ReplyTo:ReplyTo:Cc:Cc:Message-Id:Message-Id; 
 a=ed25519-sha256; b=
 J4805Dx/OmDjq8S8yaRkS8K4CfzUmeugydWNmdSvxcRxXyEzoozMfvwVg5jIMEzDAiuqsE8ANEn+QiEhTCp4DQ==
DKIM-Signature: v=1; c=relaxed/relaxed; d=uni-rostock.de; s=itmz; 
 t=1699029722; bh=5oUNntIsz42ye+cbkNuzUBfKHPkK2L8T7r9lTsxpiH4=; h=
 Subject:Subject:From:From:Date:Date:ReplyTo:ReplyTo:Cc:Cc:Message-Id:Message-Id; 
 a=rsa-sha256; b=
 psCf5uOoNRj5o6KDnf1hJG9teYGBD8MoGgxXDgorteiY8qK/fvx8l/Y0YPY2GKY/g4z30Zup40W+kqGalRxAUuiLuFgrO05ahpUW5zb2k8TBDRWOX3/74eTrToSA26yga0TLP1ZurdnOOszeBN2JYcO7axcbD5YgcxGNlJOXlvs=
Received: from mininet-experimente.amd.e-technik.uni-rostock.de (139.30.201.3)
 by mail1.uni-rostock.de (139.30.22.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Fri, 3 Nov 2023 17:41:57 +0100
From: Benjamin Beichler <benjamin.beichler@uni-rostock.de>
Date: Fri, 3 Nov 2023 16:41:43 +0000
Subject: [PATCH RFC 05/11] um: Add final request time to TT wait message
MIME-Version: 1.0
Message-ID: <20231103-bb-timetravel-patches-v1-5-e2c68efcf664@uni-rostock.de>
References: <20231103-bb-timetravel-patches-v1-0-e2c68efcf664@uni-rostock.de>
In-Reply-To: <20231103-bb-timetravel-patches-v1-0-e2c68efcf664@uni-rostock.de>
To: Richard Weinberger <richard@nod.at>, Anton Ivanov
	<anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>
CC: <linux-um@lists.infradead.org>, Benjamin Beichler
	<benjamin.beichler@uni-rostock.de>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1699029716; l=2438;
 i=benjamin.beichler@uni-rostock.de; s=20231103; h=from:subject:message-id;
 bh=cUx3FbldG98/2P5aQhm9/XrZgucPSi9rnu0lQ6fNFvM=;
 b=oD8qOm9vbsrzTMgmOLcFfxroUtYq8mUOYMPzJ+c4UMhlb3p0FBsHX9sTzfMnUd0GWfkHP6PWi
 pob4Mhxo+QgBomq2hTia2OlPmT4I52mPl0qRJvXvfJDG4Nx+GtLcw8Q
X-Developer-Key: i=benjamin.beichler@uni-rostock.de; a=ed25519;
 pk=fla2/IRwqFWH5W+fACqQyDu/mTc6mEcSPQtqb/SoX8o=
X-Originating-IP: [139.30.201.3]
X-ClientProxiedBy: email3.uni-rostock.de (139.30.22.83) To
 mail1.uni-rostock.de (139.30.22.84)
X-TM-SNTS-SMTP: 424959179161C38A1EFDF6737992251ABF54ABD2DA2DB807F91E2EFD2AB82AA32000:8
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231103_094218_570957_D6E08582 
X-CRM114-Status: GOOD (  13.65  )
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

Although the information for the next requested time was already sent in
a prior message, this change introduces the otherwise unused time
variable in the TT message. This addition enables an extra consistency
check and can otherwise be ignored.

Signed-off-by: Benjamin Beichler <benjamin.beichler@uni-rostock.de>
---
 arch/um/kernel/time.c              | 6 +++---
 include/uapi/linux/um_timetravel.h | 6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/um/kernel/time.c b/arch/um/kernel/time.c
index ff5ef75bbb94..abd5fd0f62ee 100644
--- a/arch/um/kernel/time.c
+++ b/arch/um/kernel/time.c
@@ -220,7 +220,7 @@ static bool time_travel_ext_request(unsigned long long time)
 	return true;
 }
 
-static void time_travel_ext_wait(bool idle)
+static void time_travel_ext_wait(bool idle, unsigned long long ns)
 {
 	struct um_timetravel_msg msg = {
 		.op = UM_TIMETRAVEL_ACK,
@@ -230,7 +230,7 @@ static void time_travel_ext_wait(bool idle)
 	time_travel_ext_free_until_valid = false;
 	time_travel_ext_waiting++;
 
-	time_travel_ext_req(UM_TIMETRAVEL_WAIT, -1);
+	time_travel_ext_req(UM_TIMETRAVEL_WAIT, ns);
 
 	/*
 	 * Here we are deep in the idle loop, so we have to break out of the
@@ -256,7 +256,7 @@ static void time_travel_ext_get_time(void)
 static void __time_travel_update_time(unsigned long long ns, bool idle)
 {
 	if (time_travel_mode == TT_MODE_EXTERNAL && time_travel_ext_request(ns))
-		time_travel_ext_wait(idle);
+		time_travel_ext_wait(idle, ns);
 	else
 		time_travel_set_time(ns);
 }
diff --git a/include/uapi/linux/um_timetravel.h b/include/uapi/linux/um_timetravel.h
index ca3238222b6d..3127f069d9dc 100644
--- a/include/uapi/linux/um_timetravel.h
+++ b/include/uapi/linux/um_timetravel.h
@@ -77,9 +77,9 @@ enum um_timetravel_ops {
 	/**
 	 * @UM_TIMETRAVEL_WAIT: Indicate waiting for the previously requested
 	 *	runtime, new requests may be made while waiting (e.g. due to
-	 *	interrupts); the time field is ignored. The calendar must process
-	 *	this message and later	send a %UM_TIMETRAVEL_RUN message when
-	 *	the host can run again.
+	 *	interrupts); the time field contains the next requested runtime
+	 *  for consistency checks. The calendar must process this message and
+	 *  later send a %UM_TIMETRAVEL_RUN message when the host can run again.
 	 *	(host -> calendar)
 	 */
 	UM_TIMETRAVEL_WAIT		= 3,

-- 
2.34.1



_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
