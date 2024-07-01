Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3913C2BD09
	for <linux-um@archiver.kernel.org>; Mon,  1 Jul 2024 20:00:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=4p8E/VSnsrnsKV07TQq8qRlGlHLe7if08R8l+RqApBs=; b=Z5NV3QNiQoJU6nhJs2DuSAB8Xn
	1pFHK24HZ/pdA5GUV82+4O4DACd0HWV7bLexISKWKoSNoFS/6+MXcxWDp5HjKICwH3dLCpUW9qtNQ
	CYFfZKvyWpR10BsjScgo4k2llNgOnt10tnGGh5r3k1Sv9eVW5sNaCPnK/+uBJJxsKq7/OLWlPsviq
	nMz9j+k6pjp7nSG7nubrbBaaDXYH/rsk5z877ejfk0WXAyu/9alAV3PxANySvua4zWYUuYMvSWsDE
	+cXrTouwxv/b+awncpwJ8r8t/lyBJ2A9U1uxy5upkmGW0lVqmNJpIq1XOc2fFJEcfk76TLdK+xdOg
	XWpojQOQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sONCh-00000004ilS-3p7X;
	Mon, 01 Jul 2024 20:00:47 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sONCf-00000004ikh-1ALv
	for linux-um@lists.infradead.org;
	Mon, 01 Jul 2024 20:00:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=4p8E/VSnsrnsKV07TQq8qRlGlHLe7if08R8l+RqApBs=; t=1719864044; x=1721073644; 
	b=PzPCb8E6USLg6gG6yfixAGSFC0/F0Zadi5aVHkQIaj3nyVVMgXTKVPFgFmpiC1ti9oltJJ5Sfvp
	t9cL9kHWmN6qyDpXVTrG8I6cNT5nHpqmBsCf3NKlA8p3aFm11PIxhU1wtHKI7F+rK0k4xZ91KQIqI
	EAmHT0V8pWC2eksL48sS3kGTNQRaD+xx+L4XiMqmR7AqDfQ/6STgdotJvs6emdAb3ufT6njJsLhF4
	jj7uy77e3bE5IQ1cxKF+jzATehg60WerEK904hHY8KB88PO5WfM6hDQtZstrto5I6RIySTHrYZn7U
	5sKQAw0k69VHk+ULu8J78WqXpQkJRHj84HdA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sONCc-00000003C6A-22hd;
	Mon, 01 Jul 2024 22:00:42 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-um@lists.infradead.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH] um: enable UBSAN
Date: Mon,  1 Jul 2024 22:00:35 +0200
Message-ID: <20240701220034.995eb04d656d.Ia29fe091b207fe66b5e26298c1e427ebcf131642@changeid>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240701_130045_338223_B58395CF 
X-CRM114-Status: UNSURE (   7.24  )
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

We can select ARCH_HAS_UBSAN, it works just fine. It had been
enabled and we even used it, but then commit 890a64810d59
("ubsan: Restore dependency on ARCH_HAS_UBSAN") (correctly)
disabled it again, enable ARCH_HAS_UBSAN to get it.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 arch/um/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/um/Kconfig b/arch/um/Kconfig
index 93a5a8999b07..bc930cca92e2 100644
--- a/arch/um/Kconfig
+++ b/arch/um/Kconfig
@@ -32,6 +32,7 @@ config UML
 	select TTY # Needed for line.c
 	select HAVE_ARCH_VMAP_STACK
 	select HAVE_RUST			if X86_64
+	select ARCH_HAS_UBSAN
 
 config MMU
 	bool
-- 
2.45.2


