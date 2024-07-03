Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5239C2BD09
	for <linux-um@archiver.kernel.org>; Wed,  3 Jul 2024 15:22:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=Fm+mnwksDDCCsdcXbqhf2xJxAZIbrp/U1V4v3z3eTdI=; b=sE+iVYxY3wl5O2kiNxs3psQG3c
	Re+K+nmV3EN6jSVz2EEhB0ByS9/l1dpZmKzmdvUCnKgi632Ps49DzZ/xohaXo6du6CsC5EMSVU769
	d+AUOdWC+7GIFhHF3dmBUdTWcp7My3Mfy1/XW+fGztcchx19iYC5Gr/uIjK/x4co2HEA66p3kPvSL
	pYNhU3ZOZQS91+yV130RFlu71yO+VAAlguvnju6J+uWFlxpo++Xrtz0RK8CLpzGUFoArYu95j0pXJ
	rvysEjYTVlO9jr9v3ALEWZ9+BLW6pElJ950qiLjipzJAiS8gOGOgpGGT5Dqg2igo7q2ygQpD5sXdV
	0tEMp0Gg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sP1oj-0000000AfQU-03Kr;
	Wed, 03 Jul 2024 15:22:45 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sP1of-0000000AfPv-0QJp
	for linux-um@lists.infradead.org;
	Wed, 03 Jul 2024 15:22:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=Fm+mnwksDDCCsdcXbqhf2xJxAZIbrp/U1V4v3z3eTdI=; t=1720020160; x=1721229760; 
	b=tmNMGGm9xU2JrNBOGfG6TItrESHzJJOu/gwfG7sBQrUkfKHnKgbG8/d5pUt+5iVdIAm7aS5iP06
	LBlBjUQYAUGCEZINabzT/pEtRf9jKadbEfVfsZi+zUWIxork4/SzuR4dwYz6rlG3EnUWy5HRlBMle
	aeZHiCiXYFWlT1j67yPeDMZVy8Qj3VTjD9JLXhnKFdtFyjW3tDZL1r7w3u0Odu7SX2/gOP0Whzg/H
	ynvLJiLepNLZQ47iJLHToaap6c4M3Pe9BzdSrC7NsRXz9q7VAiBeyfaQosHxo/xUdy1gSqb9YOzso
	CUEF700+eeMI/ttaxn9wyMeegW6JUMkfEz2A==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sP1oc-00000009OGS-1fLd;
	Wed, 03 Jul 2024 17:22:38 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-um@lists.infradead.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH] um: line: always fill *error_out in setup_one_line()
Date: Wed,  3 Jul 2024 17:22:36 +0200
Message-ID: <20240703172235.ad863568b55f.Iaa1eba4db8265d7715ba71d5f6bb8c7ff63d27e9@changeid>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240703_082241_179976_4AE54959 
X-CRM114-Status: UNSURE (   9.09  )
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

The pointer isn't initialized by callers, but I have
encountered cases where it's still printed; initialize
it in all possible cases in setup_one_line().

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 arch/um/drivers/line.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/um/drivers/line.c b/arch/um/drivers/line.c
index d82bc3fdb86e..43d8959cc746 100644
--- a/arch/um/drivers/line.c
+++ b/arch/um/drivers/line.c
@@ -383,6 +383,7 @@ int setup_one_line(struct line *lines, int n, char *init,
 			parse_chan_pair(NULL, line, n, opts, error_out);
 			err = 0;
 		}
+		*error_out = "configured as 'none'";
 	} else {
 		char *new = kstrdup(init, GFP_KERNEL);
 		if (!new) {
@@ -406,6 +407,7 @@ int setup_one_line(struct line *lines, int n, char *init,
 			}
 		}
 		if (err) {
+			*error_out = "failed to parse channel pair";
 			line->init_str = NULL;
 			line->valid = 0;
 			kfree(new);
-- 
2.45.2


