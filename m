Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1CCBC54E66
	for <linux-um@archiver.kernel.org>; Sun, 10 Mar 2024 07:52:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=emZOtsXHsr6ALHPpOsDR6adOQ5IR/GN+8/jtYwaRvHI=; b=uhabJEyq9adoQNlAWWqn9EIiL5
	ztarj1t2nv0n5YG5cTtQxd0/f8hUlEZrgPfqHubUGc2dHoxo/oHZXFs/HFe8sXxL0qv4LZfRILpwS
	7No/O9X0JNDZ3/DbewPDMQTa8DoAnJ/J/GCL7lOUF3QtdGSbKsylYyv0aO9w8pBW00QC65bAKRg1C
	5WrUMfnMA1QyFRL0SOrS+46oLzhrSWyg/51Ei8JiUD0wEVQUXLrV4tdvukJkqsLvaYM2dki2B4qP4
	s8Hk9xPsFXhdv+T61J3ebMUL1In2f9arG4PrHXbVye+CgZXmyznh17bJcBguzMSd1qSAns7I3Z7aU
	B19UXjPg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rjDzG-0000000FFS1-3zZi;
	Sun, 10 Mar 2024 07:52:50 +0000
Received: from metis.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::104])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rjDzC-0000000FFQE-1XL9
	for linux-um@lists.infradead.org;
	Sun, 10 Mar 2024 07:52:49 +0000
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rjDz1-0006W7-Aq; Sun, 10 Mar 2024 08:52:35 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rjDyz-005TbC-TU; Sun, 10 Mar 2024 08:52:33 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rjDyz-003JwM-2f;
	Sun, 10 Mar 2024 08:52:33 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>
Cc: linux-um@lists.infradead.org,
	kernel@pengutronix.de
Subject: [PATCH 0/2] um: Convert to platform remove callback returning void
Date: Sun, 10 Mar 2024 08:52:26 +0100
Message-ID: <cover.1710056894.git.u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=833; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=LkWs8VUM1W1qPvRGxy2q5x4qXYQeVit85G5Mt6EK24o=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBl7Wa7Ff+o/fA+IXcnZPtVfbgrUsBRgsrU9rlfO Lkvqv62LBSJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZe1muwAKCRCPgPtYfRL+ TqTKB/9ibLUWSVl4uvQbYJUtTWIZFtnSyPxA0BaDz9lxUdfq+HLGWuNEtOVDmpl63vY/1k9eI10 7FYF0ZBDnbNGyYaI4NLtSpNsifsarJnOgQ7hnqKTPSSIlBoAyujsCVyXaA8EpCCgqaNow87c8kL 0sUCfhGE5ZhkQU09PV3SEqFK7LuO2NXc1gJRfD5G3LQY4NgfibLZoMDYzHYCd34LCltPT/jtyIP SFZ/XVwxHQuVuBxG1j/LSk467MMT7sZHse/LNVfB1N8o5zaM2vT2+o5jUDprjxbalU0Nw0HW+j7 gsagyspHrW+JE6+0CfYKXarfUtyNxoSWarY+t9v97ccxFlKB
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-um@lists.infradead.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240309_235247_144119_7208288E 
X-CRM114-Status: UNSURE (   6.95  )
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

Hello,

this series converts all platform drivers below arch/um to stop using
struct platform_driver::remove(). See commit 5c5a7680e67b ("platform:
Provide a remove callback that returns no value") for an extended
explanation and the eventual goal.

Both conversations are trivial, because the driver's .remove() callbacks
returned zero unconditionally.

There are no interdependencies between these patches, still I'd expect
them to be picked up together.

Uwe Kleine-König (2):
  um: rtc: Convert to platform remove callback returning void
  um: virtio_uml: Convert to platform remove callback returning void

 arch/um/drivers/rtc_kern.c   | 5 ++---
 arch/um/drivers/virtio_uml.c | 5 ++---
 2 files changed, 4 insertions(+), 6 deletions(-)

base-commit: 8ffc8b1bbd505e27e2c8439d326b6059c906c9dd
-- 
2.43.0


