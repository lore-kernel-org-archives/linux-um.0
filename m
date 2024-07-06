Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A78CCC2BD09
	for <linux-um@archiver.kernel.org>; Sat,  6 Jul 2024 09:12:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=V0fVSBQHSvsMyzS9r0BU/nF4Ul6CKqfsRGvzFqEHzfk=; b=K4KG2I+oqjo0Wn5gNQhcbquxVt
	sqzVx2CqfNMOdzDnT9/0NkoAeAhRkYZBnnqWuMMAgmoYmXgVSy80mKGi4fRRWLYU/9IBMmYUR6/Ud
	FWBhmv7YyR2ATZ4hA7ALspcyK1aayTFkv0imxXQEkNA/JCG5gzNFrWhDJ3P9IwrgioYR/QVRDKfm9
	w7C4Hem1YaWcs8lri64kQkK33MiZsyNzgrEYDx7ZX0PqqvPOxSd5888fr1PwsDf3fNeytU0wFjnSE
	/AwFbou4x1o5rgNb6z5Q1nCgwyyqyt/KQTInhIho3fNginsXYBJAldxbICnAVlQ690X10a5xr2iik
	TmQNpOTg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sQ1So-0000000Hagy-15tB;
	Sat, 06 Jul 2024 09:12:14 +0000
Received: from ns1.kot-begemot.co.uk ([217.160.28.25] helo=www.kot-begemot.co.uk)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sQ1Sl-0000000HagW-0qrO
	for linux-um@lists.infradead.org;
	Sat, 06 Jul 2024 09:12:13 +0000
Received: from [192.168.17.6] (helo=jain.kot-begemot.co.uk)
	by www.kot-begemot.co.uk with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <anton.ivanov@cambridgegreys.com>)
	id 1sQ1Sg-005oLo-SZ; Sat, 06 Jul 2024 09:12:06 +0000
Received: from jain.kot-begemot.co.uk ([192.168.3.3])
	by jain.kot-begemot.co.uk with esmtp (Exim 4.96)
	(envelope-from <anton.ivanov@cambridgegreys.com>)
	id 1sQ1Sc-00D4ab-2I;
	Sat, 06 Jul 2024 10:12:05 +0100
From: anton.ivanov@cambridgegreys.com
To: linux-um@lists.infradead.org
Cc: johannes@sipsolutions.net,
	richard@nod.at,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>
Subject: [PATCH v2] um: vector: Fix NAPI budget handling
Date: Sat,  6 Jul 2024 10:12:00 +0100
Message-Id: <20240706091200.3115885-1-anton.ivanov@cambridgegreys.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Clacks-Overhead: GNU Terry Pratchett
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240706_021211_266304_BA23141D 
X-CRM114-Status: UNSURE (   8.35  )
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
 arch/um/drivers/vector_kern.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/um/drivers/vector_kern.c b/arch/um/drivers/vector_kern.c
index 53e825bcc6fa..5e96efef65cf 100644
--- a/arch/um/drivers/vector_kern.c
+++ b/arch/um/drivers/vector_kern.c
@@ -968,7 +968,7 @@ static int vector_mmsg_rx(struct vector_private *vp, int budget)
 		budget = qi->max_depth;
 
 	packet_count = uml_vector_recvmmsg(
-		vp->fds->rx_fd, qi->mmsg_vector, qi->max_depth, 0);
+		vp->fds->rx_fd, qi->mmsg_vector, budget, 0);
 
 	if (packet_count < 0)
 		vp->in_error = true;
@@ -1184,7 +1184,7 @@ static int vector_poll(struct napi_struct *napi, int budget)
 
 	if (tx_enqueued || err > 0)
 		napi_schedule(napi);
-	if (work_done < budget)
+	if (work_done <= budget)
 		napi_complete_done(napi, work_done);
 	return work_done;
 }
-- 
2.39.2


