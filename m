Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D822BC4345F
	for <linux-um@archiver.kernel.org>; Wed, 17 Apr 2024 08:27:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=JK2F6zdqjodjDIWLn0t8Kpbd20RixogpV8+ueEbUa0c=; b=AO5IeD8212ZkOGcPMOTGask8yx
	qeLwPpAZ+VZSk3dC6Hdu7z+7x/XUgCh8WjSK2fIbHfpnGiTGqFVayMFuppi+oLwX+hYAk+a4WJw2F
	PKuaF2OWFpkkgLNw708CsWvnsaF5N6wXWjP47K1cw00KvEZ8WimlZYS7vHBXatiCmxBALCL5P6VtK
	C+1UrxSFXIwSfQrwzOhdThtXkSOZO9ZKKH9bnOZPHLQugpa1ar12+3RvvkPfdioIy1VtnXEt4W5r5
	vZCk2+ByT6zWYdiBsr0esco/ZPbU8V7Iz79ZBM52QS/Y7yQAzu9jVJBbbpBxt60UEpngcPfYG+scn
	YIfmTw3g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rx0e1-0000000FCpN-3NYQ;
	Wed, 17 Apr 2024 08:27:53 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rx0dz-0000000FCoI-3d3G
	for linux-um@lists.infradead.org;
	Wed, 17 Apr 2024 08:27:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=JK2F6zdqjodjDIWLn0t8Kpbd20RixogpV8+ueEbUa0c=; t=1713342470; x=1714552070; 
	b=BSiZdngUInYK8TpekfSqIZHRTIb+tKKDl46Yc7lXh+j35wOyKy8FpBO8YztuAVQVSQNfoPdUCws
	bjtkiDTSsJYHr5lOU9ayNFezONAuqpAxMLiCAsBC9SVX4FgRQowEqpYdOdXr87mJBkA3tox7Cxmw7
	KrVIXrsHtI2K4qD/TGWAwf0zwiHvEt8dchS44E6JJbHO7gjJD2/vp6wbPQUxQewca051OfeWh6YUw
	xTibvNbveBx2o1iSiGgdqKDwDHPe74LmVD8QKCMS0x5rLIC9fp0KM4HbiMT0XUJgQaNSsxY7BGh7n
	/aJV8spqcyPg0NLepwozqVFpykj/xCDlTkhg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rx0dv-0000000AmKN-09eS;
	Wed, 17 Apr 2024 10:27:47 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-um@lists.infradead.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH] um: time-travel: fix time-travel-start option
Date: Wed, 17 Apr 2024 10:27:45 +0200
Message-ID: <20240417102744.14b9a9d4eba0.Ib22e9136513126b2099d932650f55f193120cd97@changeid>
X-Mailer: git-send-email 2.44.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240417_012751_931370_7858D532 
X-CRM114-Status: UNSURE (   9.02  )
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

We need to have the = as part of the option so that the
value can be parsed properly. Also document that it must
be given in nanoseconds, not seconds.

Fixes: 065038706f77 ("um: Support time travel mode")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 arch/um/kernel/time.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/um/kernel/time.c b/arch/um/kernel/time.c
index 3e270da6b6f6..c8c4ef94c753 100644
--- a/arch/um/kernel/time.c
+++ b/arch/um/kernel/time.c
@@ -874,9 +874,9 @@ int setup_time_travel_start(char *str)
 	return 1;
 }
 
-__setup("time-travel-start", setup_time_travel_start);
+__setup("time-travel-start=", setup_time_travel_start);
 __uml_help(setup_time_travel_start,
-"time-travel-start=<seconds>\n"
+"time-travel-start=<nanoseconds>\n"
 "Configure the UML instance's wall clock to start at this value rather than\n"
 "the host's wall clock at the time of UML boot.\n");
 #endif
-- 
2.44.0


