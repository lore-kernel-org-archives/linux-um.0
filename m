Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 564ACC54E67
	for <linux-um@archiver.kernel.org>; Sun, 10 Mar 2024 07:52:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4k49+P1S6zwwYy3WJ7xJ12NYAbqbCv28kw561k6JO0I=; b=MPj9v+zX+ecT8f8leakIoiQzC0
	lDTwl2eFm4G2Mx2cjrmYf42DK1eZr3FU22iZINOLqXv6MXlqNm6gmEC281V0xqLdrbWbKQStf44V3
	beByVwc3MG/qotrwe6ZDhSJ0ukU90/ufKU5oJZapgRMhowI719M53SOH4/iEty83vzLPvk1xN9hMR
	apMIDpFOnKmhKuk3T9p88xwpGIH7tzjvou+5Lbog9yPcHz2RpaorVI2XKx8QO3MQ7+crv8MxrIMEq
	SN7lhUvF1aHWvSO8cBRlEh8R5VAHe+NnwaHHGIaoAJofK+X7RaQsss/FVT4mz0umlaNhN990OQ7Bg
	/aFm+PmQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rjDzJ-0000000FFSf-3eP4;
	Sun, 10 Mar 2024 07:52:53 +0000
Received: from metis.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::104])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rjDzD-0000000FFQJ-0ASb
	for linux-um@lists.infradead.org;
	Sun, 10 Mar 2024 07:52:50 +0000
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rjDz1-0006W9-Aq; Sun, 10 Mar 2024 08:52:35 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rjDz0-005TbI-DI; Sun, 10 Mar 2024 08:52:34 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rjDz0-003JwU-14;
	Sun, 10 Mar 2024 08:52:34 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>
Cc: linux-um@lists.infradead.org,
	kernel@pengutronix.de
Subject: [PATCH 2/2] um: virtio_uml: Convert to platform remove callback returning void
Date: Sun, 10 Mar 2024 08:52:28 +0100
Message-ID: <d5222e85a8557c660d26df00138001e4907605fa.1710056894.git.u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1710056894.git.u.kleine-koenig@pengutronix.de>
References: <cover.1710056894.git.u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1759; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=OR8+ImfP61aNzsF+IzBYccD9b/UeWjEg7toJZ8Fed8w=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBl7Wa9U6ufXzhI62mnp+qyWQzbu9RyRdPI2yt7U 0axgT/sJNWJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZe1mvQAKCRCPgPtYfRL+ Ti/JB/wJlMYLQNRoU4pJl6pJ52UfggUVEIz6D7WRAOqCdiv0wUaSOshc9zAbAs67L4cS3xOV79b wg5GuFb/glxpNvvFLGJ+hnm7/RbJKER7j24M/YPrIJ0fGzZgPtyROhv5sqKMLn73iLud2l4s0l/ dMrTv4tZFbRdRtshleBh5iLz35am97X/DxzNWhYqimSc2Fjp8RJcadSe7r9arDbobBfhzZFej15 T71awn1aBK4mnSUJsPwio1AVzZmw0Eib4BdDMDjWqdvVIi5k0MOOonZnuB4GYPlDVFz+/H2o0Q6 FfG7kjO4AUCG+dxqa58wxDRwpmhOHOpmGufaOP5oLzjmCvoR
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-um@lists.infradead.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240309_235247_552951_0AD646EE 
X-CRM114-Status: GOOD (  15.06  )
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
 arch/um/drivers/virtio_uml.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/um/drivers/virtio_uml.c b/arch/um/drivers/virtio_uml.c
index 8adca2000e51..77faa2cf3a13 100644
--- a/arch/um/drivers/virtio_uml.c
+++ b/arch/um/drivers/virtio_uml.c
@@ -1241,12 +1241,11 @@ static int virtio_uml_probe(struct platform_device *pdev)
 	return rc;
 }
 
-static int virtio_uml_remove(struct platform_device *pdev)
+static void virtio_uml_remove(struct platform_device *pdev)
 {
 	struct virtio_uml_device *vu_dev = platform_get_drvdata(pdev);
 
 	unregister_virtio_device(&vu_dev->vdev);
-	return 0;
 }
 
 /* Command line device list */
@@ -1445,7 +1444,7 @@ static int virtio_uml_resume(struct platform_device *pdev)
 
 static struct platform_driver virtio_uml_driver = {
 	.probe = virtio_uml_probe,
-	.remove = virtio_uml_remove,
+	.remove_new = virtio_uml_remove,
 	.driver = {
 		.name = "virtio-uml",
 		.of_match_table = virtio_uml_match,
-- 
2.43.0


