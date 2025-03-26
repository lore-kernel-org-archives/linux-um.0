Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11CC4C3600E
	for <linux-um@archiver.kernel.org>; Wed, 26 Mar 2025 07:01:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=J+Hfy2b5Jz/zFauEbik58SX2474fowy9y0neNGWml6k=; b=ASHs5Ebkar92kVY8a2rwnRtRC/
	+RyxgofAK3iXimpiv95R5Jw/zmamn2hbiZxV6Y/aTaIfrBO59cCbncpBAWBSDFHopKumOd8kHgBOo
	8tFYzaUQA3XcaZrccVQXSK75aPJOxhV7/qmZkWYA4FaqKIOvURQam1HoRwCi0KnIV0H3FA9FvQRJr
	ewaRtfjaKZq7nZ8Km4D5h8HKy9UhSJgqLI+jcY7/Atfu4j1yGO8Uj/RoablrbSY59xq5DeV/2xrwb
	5qIRoCj41xPWVfuuou9ugULgfIv0vrjTt6rdwDgbEO4EVZeZMr7t2SKcL07fIWsSjw+NiUg6sqklP
	8AUjPpXw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1txKlV-00000007ix7-3VSX;
	Wed, 26 Mar 2025 07:01:29 +0000
Received: from out0-205.mail.aliyun.com ([140.205.0.205])
	by bombadil.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1txKlS-00000007iva-0DSp
	for linux-um@lists.infradead.org;
	Wed, 26 Mar 2025 07:01:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1742972484; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=J+Hfy2b5Jz/zFauEbik58SX2474fowy9y0neNGWml6k=;
	b=lNBu1BUcnYWVKgEU0pttYZvYoxzoTX7MFCSFKd67DU9d6s/+dB3z3p0DYmbPuGipjp6/XSdS3EX546b4afm7hOhshpZgD1Iir5ZlNodW9bV1u5CQ/37sC6xZD83PWvgT6NiFcwnUc8wzQ7IfSXztzElS6u7M49m/wKFCK5rUwAw=
Received: from ubuntu..(mailfrom:tiwei.btw@antgroup.com fp:SMTPD_---.c3eI03h_1742972481 cluster:ay29)
          by smtp.aliyun-inc.com;
          Wed, 26 Mar 2025 15:01:21 +0800
From: "Tiwei Bie" <tiwei.btw@antgroup.com>
To: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net
Cc: <linux-um@lists.infradead.org>,
  "Tiwei Bie" <tiwei.btw@antgroup.com>
Subject: [PATCH 1/2] um: xterm: Add Wayland support
Date: Wed, 26 Mar 2025 15:01:12 +0800
Message-Id: <20250326070113.401857-2-tiwei.btw@antgroup.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250326070113.401857-1-tiwei.btw@antgroup.com>
References: <20250326070113.401857-1-tiwei.btw@antgroup.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250326_000126_245299_80685A3B 
X-CRM114-Status: UNSURE (   9.25  )
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

Under Wayland, we should check WAYLAND_DISPLAY instead.

Signed-off-by: Tiwei Bie <tiwei.btw@antgroup.com>
---
 arch/um/drivers/xterm.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/arch/um/drivers/xterm.c b/arch/um/drivers/xterm.c
index e4316c7981e8..f607af738eac 100644
--- a/arch/um/drivers/xterm.c
+++ b/arch/um/drivers/xterm.c
@@ -97,12 +97,9 @@ static int xterm_open(int input, int output, int primary, void *d,
 	if (access(argv[4], X_OK) < 0)
 		argv[4] = "port-helper";
 
-	/*
-	 * Check that DISPLAY is set, this doesn't guarantee the xterm
-	 * will work but w/o it we can be pretty sure it won't.
-	 */
-	if (getenv("DISPLAY") == NULL) {
-		printk(UM_KERN_ERR "xterm_open: $DISPLAY not set.\n");
+	/* Ensure we are running on Xorg or Wayland. */
+	if (!getenv("DISPLAY") && !getenv("WAYLAND_DISPLAY")) {
+		printk(UM_KERN_ERR "xterm_open : neither $DISPLAY nor $WAYLAND_DISPLAY is set.\n");
 		return -ENODEV;
 	}
 
-- 
2.34.1


