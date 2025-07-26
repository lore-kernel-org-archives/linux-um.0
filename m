Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8B56C83F17
	for <linux-um@archiver.kernel.org>; Sat, 26 Jul 2025 12:29:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=6X4cEmTAi6QL34dBdkrEqZlOjfamDlRho5r7P+EXvxo=; b=kdk3489DdyAEtRFf+O7/5bD/0E
	XwpWFPPr0+4dZOcD/qRfx6+nO2CSStVh9TKKfcmoGPbNl5jy7vhIO/vPpD9NB56QS1AknDpvsb74B
	e/0VUY9vhv4jn+b32O5TlniN8oC5UmuOPbJrsJBHnjwaDfrVWg15bp1OaZZG3bl69VKWUpFvvs62V
	dArrVTZIFHnw4PlOMJyaPJCGTxjuMy8blumuPMxj78E1kvLxTSrG6twUDQiBhDeD+2U2w/ezT/Yqm
	3hY445cSyXXqiN2xVqXe0Rr2m1XwlNBJDrxykMVWVtkx1F97H0pRoH35nUrA/0VKX6jMmgXVfBhxe
	rJwdXqEQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ufe25-0000000BRxY-0tmp;
	Sat, 26 Jul 2025 12:29:45 +0000
Received: from mailout.nod.at ([116.203.167.152] helo=lithops.sigma-star.at)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ufe21-0000000BRvp-48xy
	for linux-um@lists.infradead.org;
	Sat, 26 Jul 2025 12:29:43 +0000
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 33D932B4F63;
	Sat, 26 Jul 2025 14:29:37 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id eh_HtHKnTg5M; Sat, 26 Jul 2025 14:29:36 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 4F04E2B4F68;
	Sat, 26 Jul 2025 14:29:36 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id RQSioKZZK5P5; Sat, 26 Jul 2025 14:29:36 +0200 (CEST)
Received: from nailgun.corp.sigma-star.at (85-127-105-52.dsl.dynamic.surfer.at [85.127.105.52])
	by lithops.sigma-star.at (Postfix) with ESMTPSA id EB5522B4F63;
	Sat, 26 Jul 2025 14:29:35 +0200 (CEST)
From: Richard Weinberger <richard@nod.at>
To: linux-um@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net,
	benjamin.berg@intel.com
Subject: [PATCH] um: Don't mark stack executable
Date: Sat, 26 Jul 2025 14:29:30 +0200
Message-ID: <20250726122930.236404-1-richard@nod.at>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250726_052942_164143_E9628970 
X-CRM114-Status: UNSURE (   7.81  )
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

On one of my machines UML failed to start after enabling
SELinux.
UML failed to start because SELinux's execmod rule denies
executable pages on a modified file mapping.

Historically UML marks it's stack rwx.
AFAICT, these days this is no longer needed, so let's remove
PROT_EXEC.

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 arch/um/os-Linux/util.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/um/os-Linux/util.c b/arch/um/os-Linux/util.c
index 4193e04d7e4a7..e3ad71a0d13c4 100644
--- a/arch/um/os-Linux/util.c
+++ b/arch/um/os-Linux/util.c
@@ -20,8 +20,7 @@
=20
 void stack_protections(unsigned long address)
 {
-	if (mprotect((void *) address, UM_THREAD_SIZE,
-		    PROT_READ | PROT_WRITE | PROT_EXEC) < 0)
+	if (mprotect((void *) address, UM_THREAD_SIZE, PROT_READ | PROT_WRITE) =
< 0)
 		panic("protecting stack failed, errno =3D %d", errno);
 }
=20
--=20
2.49.0


