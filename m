Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1A63C2BD09
	for <linux-um@archiver.kernel.org>; Wed,  3 Jul 2024 15:20:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=AgYl9Zzq8Ev3a0CeHiU/TNQ6tM2EK4RpP2iLdcXAV2I=; b=lQWhW7AfbdVGGrxK40OQ+IuSJO
	G+rDD3rklGUHZKri1b09Jr0QQBTJcgk+Fen/ogiZw7RWPMtsci0Li2k2Wl3AJfWEoRe3sEGBXEFc7
	z+X/749CAaWL7TlKeMnjavBSS2TfEb492kcUVRJsLORhbihYYZHa+riE1WRgZR1SRkDzxhiWSJYu1
	VS/tLeN2nUHH087NX2uylizOwmfCnjRIZZHSnHwT/loMBnWUA71XaxAuTz+yXHVVRf+nZpzt5I2E+
	WoQBtHLHAq5LtZARdcsk2hjwIz9cStBpvxL5KD7DqJsXvoDrI+UkzMDFVuePPfepQvOz4icWTP09i
	jIsJ8Z8Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sP1mP-0000000AfEF-3Hty;
	Wed, 03 Jul 2024 15:20:21 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sP1mN-0000000AfDp-1Wn9
	for linux-um@lists.infradead.org;
	Wed, 03 Jul 2024 15:20:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=AgYl9Zzq8Ev3a0CeHiU/TNQ6tM2EK4RpP2iLdcXAV2I=; t=1720020018; x=1721229618; 
	b=KRu1JkOz9lXBLDGknnb60Anu1FAht0j8w2N+7s82bcIVIF9m4N6Ki0Em0LbtrdMtq243ibTQr2Q
	TE6yn2611OeXRg5kpHj2+B2UL4G2eKtXdwDaAb3Hfn7VeIU5vgMuiNo4qi5hi3kHJwz7zj5NyZjEs
	o3ccWU/XDSuP0+wES0OQF0U5gk2Oqvz3d6qLVQssw54OMVmmQ4O/XifFoNl8eW+7bWY2ez9rZt3vW
	a37guFaahHvAPH/tgNtpXrTnCa593qZ5cvHqV2Vc2OytdMqzbT9wImeWmfKQUnrNcZw/OBn2dVixT
	GMXnnkCrBzpKbI4YGNxSmZVH2pzWU4kpxKnw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sP1mJ-00000009OA3-2PJo;
	Wed, 03 Jul 2024 17:20:16 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-um@lists.infradead.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH] um: remove pcap driver from documentation
Date: Wed,  3 Jul 2024 17:20:14 +0200
Message-ID: <20240703172013.c3232dc5cbe9.I7f9941095d45a39d0f1e83680a408b3c6d445242@changeid>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240703_082019_455109_E8243E8F 
X-CRM114-Status: UNSURE (   7.51  )
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

We just removed the driver, but forgot the row in the
documentation table mentioning it. Remove that.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 Documentation/virt/uml/user_mode_linux_howto_v2.rst | 2 --
 1 file changed, 2 deletions(-)

diff --git a/Documentation/virt/uml/user_mode_linux_howto_v2.rst b/Documentation/virt/uml/user_mode_linux_howto_v2.rst
index d1cfe415e4c4..27942446f406 100644
--- a/Documentation/virt/uml/user_mode_linux_howto_v2.rst
+++ b/Documentation/virt/uml/user_mode_linux_howto_v2.rst
@@ -223,8 +223,6 @@ remote UML and other VM instances.
 +-----------+--------+------------------------------------+------------+
 | socket    | legacy | none                               | ~ 450Mbit  |
 +-----------+--------+------------------------------------+------------+
-| pcap      | legacy | rx only                            | ~ 450Mbit  |
-+-----------+--------+------------------------------------+------------+
 | ethertap  | legacy | obsolete                           | ~ 500Mbit  |
 +-----------+--------+------------------------------------+------------+
 | vde       | legacy | obsolete                           | ~ 500Mbit  |
-- 
2.45.2


