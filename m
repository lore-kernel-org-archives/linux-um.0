Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 546E1CAC5AE
	for <linux-um@archiver.kernel.org>; Wed, 24 Sep 2025 14:22:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=I1cm2is+Xgw+x+T3m8uuoGo4E722CtwyukEZGpVjsa4=; b=qmpAPXU9yArrYS4XvJAOgzW8Uf
	vlmxsNHYKDODmFg+A0AdoIHRC7lTMEVHmxxg+HSWTgpgKk/bSuPFFNLgYycLwknk+HJCYAGxQuxLU
	SdUGjkPR3faKH2tdgQttrVtjq0A/X6mw9K+MuAShHKQEDdG5JDVtVED9GxupOjGXZuidS13Ihr8MC
	5ahHXCchvF+8Fxi7OiXrqutVjhYgrGGq+L0JWgCuBUk78dtQt3bnne1R6EYd4kAl+7gdkBL39B9ni
	Yhca9FY4SiS8ec6ZXPAKEauoy+t/U2qmuLR4uCncMzdlzPUhoRfCRXLX+HkNbwk89t0JO3xc+s67O
	a2GWPW6w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v1QNe-00000000axt-0HDe;
	Wed, 24 Sep 2025 14:22:02 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v1QNZ-00000000amr-226U
	for linux-um@lists.infradead.org;
	Wed, 24 Sep 2025 14:21:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=I1cm2is+Xgw+x+T3m8uuoGo4E722CtwyukEZGpVjsa4=;
	t=1758723717; x=1759933317; b=DkC7wNhoimCI0gemmn4W8KGDPvEuZmXY15kQ/TltjK4VOX3
	/bQjwv/pocI6qlr5vonVQHNA18kx6sh5NC4mDr8Dy5b31TY8KzFWm6XPDbYJAOKQaqDfKDqay6yax
	tak9JiVJP8L0hLZhiNgsZ47d/qu9sXjn3xDp4riidFK0YJYocw4hxpgh+Jc4Pa1Ao6fAbMDSNJ7tA
	u4oRlOfOtHZqzQdQ4mdBip10/V8ODc/JLZuqU0/rhBTSpBbBe13YoMu+bW1p3zHoii66TmcThKvfT
	ExbnI8gFDXESPLAXztrunKY8GoT8MHGml5OEpigZDR8OVp784Tb4rMMSEI9485CQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1v1QNW-000000090Bz-3KBY;
	Wed, 24 Sep 2025 16:21:55 +0200
From: Benjamin Berg <benjamin@sipsolutions.net>
To: linux-um@lists.infradead.org,
	Willy Tarreau <w@1wt.eu>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	linux-kselftest@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: linux-kernel@vger.kernel.org,
	Benjamin Berg <benjamin.berg@intel.com>
Subject: [PATCH v3 06/12] tools/nolibc: use __fallthrough__ rather than fallthrough
Date: Wed, 24 Sep 2025 16:20:53 +0200
Message-ID: <20250924142059.527768-7-benjamin@sipsolutions.net>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250924142059.527768-1-benjamin@sipsolutions.net>
References: <20250924142059.527768-1-benjamin@sipsolutions.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250924_072157_532706_61CDBC80 
X-CRM114-Status: GOOD (  10.47  )
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

From: Benjamin Berg <benjamin.berg@intel.com>

Use the version of the attribute with underscores to avoid issues if
fallthrough has been defined by another header file already.

Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
Acked-by: Thomas Weißschuh <linux@weissschuh.net>
---
 tools/include/nolibc/compiler.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/include/nolibc/compiler.h b/tools/include/nolibc/compiler.h
index 369cfb5a0e78..87090bbc53e0 100644
--- a/tools/include/nolibc/compiler.h
+++ b/tools/include/nolibc/compiler.h
@@ -41,8 +41,8 @@
 #  define __no_stack_protector __attribute__((__optimize__("-fno-stack-protector")))
 #endif /* __nolibc_has_attribute(no_stack_protector) */
 
-#if __nolibc_has_attribute(fallthrough)
-#  define __nolibc_fallthrough do { } while (0); __attribute__((fallthrough))
+#if __nolibc_has_attribute(__fallthrough__)
+#  define __nolibc_fallthrough do { } while (0); __attribute__((__fallthrough__))
 #else
 #  define __nolibc_fallthrough do { } while (0)
 #endif /* __nolibc_has_attribute(fallthrough) */
-- 
2.51.0


