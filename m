Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A1B0C54791
	for <linux-um@archiver.kernel.org>; Sun, 10 Mar 2024 07:52:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xk4vJijE42qmS44kJGZFjv5wqwM+/d0AHabR1S6vpSE=; b=fJkGYxEB4BUuqfMexsmvKpSvUy
	2jQOLlUG0+gAAWLdY+7bZkqxHUcBKsqXXWqJIPaJ/CfIncZY0b08nXGMHWJKWwfcWlIZ33FVdqMGZ
	f9KmhaeXuwxWlzOrpmrpIubiZN2zTfp4rFA76NotWFP5NcuRkI0vrs0bajJeInrXeFNy/oPPipFFi
	d5KOfQwfO7H+7FfHLLPuVjLwI9dzXDg/AnQ6m81t96iluv/J2xL6yBpNasQNyx/X37P1APGHiEje/
	azsOgiR4G6BpcdbQI1yOSk0HEUocMll1JeKUPL+4aFeJnUN25qyR4b91CQBJBoXk04gGPY7fxNMfP
	jBizSH3Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rjDzH-0000000FFS7-1uEL;
	Sun, 10 Mar 2024 07:52:51 +0000
Received: from metis.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::104])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rjDzC-0000000FFQK-0oX3
	for linux-um@lists.infradead.org;
	Sun, 10 Mar 2024 07:52:49 +0000
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rjDz1-0006W8-Aq; Sun, 10 Mar 2024 08:52:35 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rjDz0-005TbF-42; Sun, 10 Mar 2024 08:52:34 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rjDz0-003JwQ-08;
	Sun, 10 Mar 2024 08:52:34 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>
Cc: linux-um@lists.infradead.org,
	kernel@pengutronix.de
Subject: [PATCH 1/2] um: rtc: Convert to platform remove callback returning void
Date: Sun, 10 Mar 2024 08:52:27 +0100
Message-ID: <3efc2ebba6837349765c7cbcf14ff6147e696e5b.1710056894.git.u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1710056894.git.u.kleine-koenig@pengutronix.de>
References: <cover.1710056894.git.u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1519; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=MdZHHcg/SDSWtPshmzlU/w4AaxG1ZX9OYZzBtr09f14=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBl7Wa8mJHM9hm0DP069B1UHkw1lUyXhXIgyUMh+ pN6sHWsjVmJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZe1mvAAKCRCPgPtYfRL+ TkyWB/wObVCMkHn5kJL5/Z4VEtsHtPlZJ6rsPdnp8gZZkydPGrGAXnmtF4FrJXfBzf0QSuFZ/3r 41QucNmO4PWbKvdKYwGkBdNFuXZTmDATESEUXQXkAxcP7LeEpZY9JQyCVHDvFQkBF16PCgswwft 13ufW8Nv2WNTiBYYAldchJJ0mN27yqD2Wk5EBJVZb6m/8giE7Q2tnO7VC/mnGUC1M9BOfbiPggi 3LXGjd97L1grAJCIY901RSaLuyime0YgjryP+JBEuPCQbKFOAgerb1lDCG0Forr9Ue+SdtNXN3y jwCEPog1uNVH1G5kV7kho8OUVa2VGMAAHD5w8Li10AbzhZNH
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-um@lists.infradead.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240309_235247_047777_7FF447F5 
X-CRM114-Status: GOOD (  14.82  )
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

The .remove() callback for a platform driver returns an int which makes
many driver authors wrongly assume it's possible to do error handling by
returning an error code. However the value returned is ignored (apart
from emitting a warning) and this typically results in resource leaks.

To improve here there is a quest to make the remove callback return
void. In the first step of this quest all drivers are converted to
.remove_new(), which already returns void. Eventually after all drivers
are converted, .remove_new() will be renamed to .remove().

Trivially convert this driver from always returning zero in the remove
callback to the void returning variant.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 arch/um/drivers/rtc_kern.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/um/drivers/rtc_kern.c b/arch/um/drivers/rtc_kern.c
index 97ceb205cfe6..3a1582219c4b 100644
--- a/arch/um/drivers/rtc_kern.c
+++ b/arch/um/drivers/rtc_kern.c
@@ -168,16 +168,15 @@ static int uml_rtc_probe(struct platform_device *pdev)
 	return err;
 }
 
-static int uml_rtc_remove(struct platform_device *pdev)
+static void uml_rtc_remove(struct platform_device *pdev)
 {
 	device_init_wakeup(&pdev->dev, 0);
 	uml_rtc_cleanup();
-	return 0;
 }
 
 static struct platform_driver uml_rtc_driver = {
 	.probe = uml_rtc_probe,
-	.remove = uml_rtc_remove,
+	.remove_new = uml_rtc_remove,
 	.driver = {
 		.name = "uml-rtc",
 	},
-- 
2.43.0


