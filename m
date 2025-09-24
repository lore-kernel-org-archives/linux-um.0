Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BCB9CAC5A5
	for <linux-um@archiver.kernel.org>; Wed, 24 Sep 2025 14:21:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=w0zvkyHycNf62ji7JboPNe59KMTBMZPeiYVTw++Mcio=; b=tmsCJVj9ZYibexugIa5GgEXBRP
	u2iSnDGCf71AfSzqND8m5JGcw6yaIY+cCtCWGI3nmTzfrmf70uEe80WZTU447+1sQQDSY7uJ45II8
	Imp0fg6LlSrW9XpVuN4ThTHG6WIij+LYmnEq8nZhxRmY7x7uSDw/Tsu3T6F3A/Yb3KQ0HT6rcco/i
	c94lHQQt2HFmHOvqTOLyhLQFNztV8EKtbRkaYN9+VVRTLZNRN08Gwr0ZwJmur5hw2XGAiIzoIWOau
	mqYH6SKcKt7ysbIkUM5Q63wm7SJWG95OiKCXIlX8FeixcKUt1ohJ2IoaTAWfc8eS4LXouFwtAcWD8
	ut7v1S3g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v1QNX-00000000ake-02Yq;
	Wed, 24 Sep 2025 14:21:55 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v1QNU-00000000agH-1pVw
	for linux-um@lists.infradead.org;
	Wed, 24 Sep 2025 14:21:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=w0zvkyHycNf62ji7JboPNe59KMTBMZPeiYVTw++Mcio=;
	t=1758723712; x=1759933312; b=G0QX4r95Iy0zX01prAmiJgG7JVIrJ+kMb2F5jbU622o8KB7
	4Eu9gNhqCfofMt4olVXCCD01JRXK1k4oK+3a/gFrexoA0r7VxIJbmXNQQhNXvVlc9NXUr7dgKHBsq
	mZykyUyyh9QZqlV7DCgK1zN+7TVBfhpItv7UdtJqfNrsbbOhQVqncO9fj9yzh7MtlKA8EilSotLL9
	/jhbxobGt1gqpQj/HKH3nSzB4y4gFVAisVR9seJlEhSEEJactR6JBoh8XsxydJaMXCQdhAisnK90f
	9bHzz02WdHYv1XyNiIolVljrHcS98WNvm+rmwHiFqlClKw1pC4XXHlN4+8ziegRQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1v1QNQ-000000090Bz-3BPc;
	Wed, 24 Sep 2025 16:21:49 +0200
From: Benjamin Berg <benjamin@sipsolutions.net>
To: linux-um@lists.infradead.org,
	Willy Tarreau <w@1wt.eu>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	linux-kselftest@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: linux-kernel@vger.kernel.org,
	Benjamin Berg <benjamin.berg@intel.com>
Subject: [PATCH v3 01/12] tools compiler.h: fix __used definition
Date: Wed, 24 Sep 2025 16:20:48 +0200
Message-ID: <20250924142059.527768-2-benjamin@sipsolutions.net>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250924142059.527768-1-benjamin@sipsolutions.net>
References: <20250924142059.527768-1-benjamin@sipsolutions.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250924_072152_491487_13F777E9 
X-CRM114-Status: UNSURE (   9.87  )
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

From: Benjamin Berg <benjamin.berg@intel.com>

The define mapped to __attribute__((__unused__)) instead of using
__used__. Having the wrong definition here may result in the linker
incorrectly removing the symbol. Also, this now matches the definition
in include/linux/compiler_attributes.h.

Fixes: e58e871becec ("tools/lib/lockdep: Remove private kernel headers")
Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
Reviewed-by: Thomas Weißschuh <linux@weissschuh.net>
---
 tools/include/linux/compiler.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/include/linux/compiler.h b/tools/include/linux/compiler.h
index 33411ca0cc90..b2c40621d441 100644
--- a/tools/include/linux/compiler.h
+++ b/tools/include/linux/compiler.h
@@ -127,7 +127,7 @@
 #endif
 
 #ifndef __used
-# define __used		__attribute__((__unused__))
+# define __used		__attribute__((__used__))
 #endif
 
 #ifndef __packed
-- 
2.51.0


