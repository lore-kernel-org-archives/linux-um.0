Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B54CBC3271E
	for <linux-um@archiver.kernel.org>; Fri,  5 Jul 2024 14:25:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=mh13Atbfz80m9PfL0qbdEYZY1UXuVO/Z9Tn7WEig8QY=; b=W8XDpKkKoBSXG7fzMzAHdhDDsw
	bE3G0l4udzJz4SNjzQImGxjQ6Wis2x+o3NKihD11TYFR6gdVM61gj47mwX6mTo7HVqPwd1BcmirP9
	yfpulEuj3wcxoIyXknCXizkO4MlvDZ39ZpDovPGG9Of93FvjZVmvOUz4zrt+rI7ddAYy++TsAljZn
	28/UQPcGpeVGwAhqo7qkNCaaPEyH2YcZvFBpjvmBu+ChH2Z+bqERNl4qMdMU2oQ14DyoKq8GN/cMQ
	pBBcMf68Way8PGfc8tk+uWHP+OjAptycY7xaTFNMmvIm1hbAMTP3S5ei5tF0iyGA4Eqp0rzcsRCDl
	cAPYEpYg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sPjsP-0000000GCPE-47oW;
	Fri, 05 Jul 2024 14:25:30 +0000
Received: from ns1.kot-begemot.co.uk ([217.160.28.25] helo=www.kot-begemot.co.uk)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sPjsN-0000000GCNE-0wWc
	for linux-um@lists.infradead.org;
	Fri, 05 Jul 2024 14:25:28 +0000
Received: from [192.168.17.6] (helo=jain.kot-begemot.co.uk)
	by www.kot-begemot.co.uk with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <anton.ivanov@cambridgegreys.com>)
	id 1sPjsJ-005ip2-Gu; Fri, 05 Jul 2024 14:25:23 +0000
Received: from jain.kot-begemot.co.uk ([192.168.3.3])
	by jain.kot-begemot.co.uk with esmtp (Exim 4.96)
	(envelope-from <anton.ivanov@cambridgegreys.com>)
	id 1sPjsG-00Au4h-1M;
	Fri, 05 Jul 2024 15:25:21 +0100
From: anton.ivanov@cambridgegreys.com
To: linux-um@lists.infradead.org
Cc: johannes@sipsolutions.net,
	richard@nod.at,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>
Subject: [PATCH] um: vector: Fix NAPI budget handling
Date: Fri,  5 Jul 2024 15:25:17 +0100
Message-Id: <20240705142517.2598785-1-anton.ivanov@cambridgegreys.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Clacks-Overhead: GNU Terry Pratchett
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240705_072527_288408_C87D0675 
X-CRM114-Status: UNSURE (   7.96  )
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

From: Anton Ivanov <anton.ivanov@cambridgegreys.com>

Fix the handling of NAPI budget.

Signed-off-by: Anton Ivanov <anton.ivanov@cambridgegreys.com>
---
 arch/um/drivers/vector_kern.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/um/drivers/vector_kern.c b/arch/um/drivers/vector_kern.c
index 53e825bcc6fa..18fb167e7bd8 100644
--- a/arch/um/drivers/vector_kern.c
+++ b/arch/um/drivers/vector_kern.c
@@ -968,7 +968,7 @@ static int vector_mmsg_rx(struct vector_private *vp, int budget)
 		budget = qi->max_depth;
 
 	packet_count = uml_vector_recvmmsg(
-		vp->fds->rx_fd, qi->mmsg_vector, qi->max_depth, 0);
+		vp->fds->rx_fd, qi->mmsg_vector, budget, 0);
 
 	if (packet_count < 0)
 		vp->in_error = true;
-- 
2.39.2


