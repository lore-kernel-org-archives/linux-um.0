Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57153C3ABBC
	for <linux-um@archiver.kernel.org>; Tue,  6 May 2025 06:13:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/c0IkIHpl63z6TVpEmRXxzmcqlidNTsTsQWWdba3DHc=; b=g9iTwRlSsToIlDByiHXHlb/siK
	HUirwMOMOgwfFxUZHPXhZOpnV1d/wy+OJAZS0ieyo1NLKgZnikHl3GuooQNu/sgQLq622L03N3Lgr
	kwB71rh3wgF+fVGt7gehwkSt6gjAgvXhvoPjRKyH1Au6QofLYdvU0R4IgkmGC9LrmihNIJBr6JbNj
	TPtV2wptQ/uM5piOoxzMCcB0dWByxatPxFG0lVdQGeXg+iwcKIvQo63soASdMkpJroWV2P77pwa2J
	fq+u5hF0zKAIaWUdeawPIVSAu+7u7ZVFFapRPZRCatikX0xDPv2OcIp4vxbtYOYtHrtwkixPqclkK
	i9643YXQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCBYy-0000000AcbL-2XHf;
	Tue, 06 May 2025 06:13:56 +0000
Received: from out0-212.mail.aliyun.com ([140.205.0.212])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCAHJ-0000000AIjV-2Vw2
	for linux-um@lists.infradead.org;
	Tue, 06 May 2025 04:51:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1746507093; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=/c0IkIHpl63z6TVpEmRXxzmcqlidNTsTsQWWdba3DHc=;
	b=vknLW3vQeo9GhhVwHrjDtjK1rVR/avWm5PM0Xaoqua45mqAfFgM2i5CY8v7LWpS6k0/7B6Z135WHvRCcijCWq8C3kLUg9r61E8v+cxWyKFHpH1Zo8UCo6l62yQ/n3Ot6M3PSr9r4EBlmzANc6Zy3nMELIiI1PBVo2XJj6LmpI+M=
Received: from ubuntu..(mailfrom:tiwei.btw@antgroup.com fp:SMTPD_---.cfhx6wL_1746507091 cluster:ay29)
          by smtp.aliyun-inc.com;
          Tue, 06 May 2025 12:51:31 +0800
From: "Tiwei Bie" <tiwei.btw@antgroup.com>
To: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net
Cc: <linux-um@lists.infradead.org>,
   <geert@linux-m68k.org>,
  "Tiwei Bie" <tiwei.btw@antgroup.com>
Subject: [PATCH 2/2] um: vector: Use mac_pton() for MAC address parsing
Date: Tue, 06 May 2025 12:51:17 +0800
Message-Id: <20250506045117.1896661-3-tiwei.btw@antgroup.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250506045117.1896661-1-tiwei.btw@antgroup.com>
References: <20250506045117.1896661-1-tiwei.btw@antgroup.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250505_215138_138197_D4B18B46 
X-CRM114-Status: UNSURE (   9.13  )
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
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

Use mac_pton() instead of custom approach.

Suggested-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Tiwei Bie <tiwei.btw@antgroup.com>
---
 arch/um/drivers/vector_kern.c | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/arch/um/drivers/vector_kern.c b/arch/um/drivers/vector_kern.c
index 7822421057ea..5226d2c52e6a 100644
--- a/arch/um/drivers/vector_kern.c
+++ b/arch/um/drivers/vector_kern.c
@@ -1543,21 +1543,14 @@ static void vector_timer_expire(struct timer_list *t)
 static void vector_setup_etheraddr(struct net_device *dev, char *str)
 {
 	u8 addr[ETH_ALEN];
-	char *end;
-	int i;
 
 	if (str == NULL)
 		goto random;
 
-	for (i = 0; i < 6; i++) {
-		addr[i] = simple_strtoul(str, &end, 16);
-		if ((end == str) ||
-		   ((*end != ':') && (*end != ',') && (*end != '\0'))) {
-			netdev_err(dev,
-				"Failed to parse '%s' as an ethernet address\n", str);
-			goto random;
-		}
-		str = end + 1;
+	if (!mac_pton(str, addr)) {
+		netdev_err(dev,
+			"Failed to parse '%s' as an ethernet address\n", str);
+		goto random;
 	}
 	if (is_multicast_ether_addr(addr)) {
 		netdev_err(dev,
-- 
2.34.1


