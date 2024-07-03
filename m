Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC0C4C30653
	for <linux-um@archiver.kernel.org>; Wed,  3 Jul 2024 11:01:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=MYoSjpMlu35wF1T885LS6BwiqPfcyWaaYieU3k6B1xY=; b=S3IcsnpeBYo/Rl9ucaQ17nm2Ix
	sfikpOPOV3fFauyOmPJ3HlimdbuFYhdpPIa55Y5TSXnCpH7r04r+RGt6eRVOp1N4HHBBykjJoOYCI
	BsXmoSAjO50OJv8TA7ZSgMepfTbMLURjKa1UNiSfQHz7a8dm4hRCKuxzDVxx+2tMAkTlyZM1JmfOw
	1A/lGVvx7xhHPBF/OpFUG5kZgZK/IfR8/pCdXwhjXGTnezGtRVPIRci4i/aV7AI275l+2Q/Ft81sU
	Jv+1nhMMAjykrUCX9UAitrmZ2eLP4ACajhMnPSno4FTrOP6q64jUao25w7LtCct1z0eqXil1zixdf
	oh7rsLdQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sOxjo-00000009wZ2-0UqX;
	Wed, 03 Jul 2024 11:01:24 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sOxjm-00000009wXU-03NX
	for linux-um@lists.infradead.org;
	Wed, 03 Jul 2024 11:01:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=MYoSjpMlu35wF1T885LS6BwiqPfcyWaaYieU3k6B1xY=; t=1720004481; x=1721214081; 
	b=O2Wt2EwXxcW2BWAFJC7j2qXiU19mX/u8e/6zvEHNjbhxEEfcS/0BAg7Cr6SmwDdR9KaYi7rU5Aq
	EdCK7M8UvZMoyHx3ioDxReTehadgccQsAoah2ziZTMLctHPDoLYcGDmk+2ZFS8NUQoCcc70TgzKCX
	GAoW9/Wf9YdCr7IlYeWDbcB+ME/4h/Yn2Frf8POpQGOul0xZTJ5ttQDC0B3Z0wPDYbfPNLUofCQCC
	njohc7usPtC0KMaiVja+uh6TMwZIqiRE/HoNXaehZwKNtSQhe2bBEjgX3/WyMc3J+bJdqtTz2vVon
	4OYXgNJl5gK6Hmv9pdg21SKOKg/KWWIyN7hg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sOxji-00000008hov-3wbk;
	Wed, 03 Jul 2024 13:01:19 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-um@lists.infradead.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH] um: time-travel: remove time_exit()
Date: Wed,  3 Jul 2024 13:01:05 +0200
Message-ID: <20240703130105.02b3a974acb7.I7264821f7cfa17ea713b7a3e4787aa41a3107d01@changeid>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240703_040122_073882_8DDE7362 
X-CRM114-Status: UNSURE (   6.57  )
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

From: Johannes Berg <johannes.berg@intel.com>

This function is unused and unneeded, remove it.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 arch/um/kernel/time.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/um/kernel/time.c b/arch/um/kernel/time.c
index d44eaad53d9d..47b9f5e63566 100644
--- a/arch/um/kernel/time.c
+++ b/arch/um/kernel/time.c
@@ -1038,11 +1038,5 @@ static int __init um_bc_start(void)
 
 	return 0;
 }
-
-void __exit time_exit(void)
-{
-	kobject_put(bc_time_kobject);
-}
-
 late_initcall(um_bc_start);
 #endif
-- 
2.45.2


