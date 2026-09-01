Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FD86C624D8
	for <linux-um@archiver.kernel.org>; Tue,  1 Sep 2026 14:58:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CGFmBktDb18Ou8jdzee9BRhN2jpwroPuYWGDnSphFl0=; b=iLIH4OvGPv2IicZWQ5eM25tDNd
	jWV70NOM/xZZjJfDIqkl6qFcfl8u/8hhV55RQXgTH0KwmApFiUjWeqVV4P+EvPB4X0++R/k5eBxBq
	12CVhLQj9wZMSb4oOTmFuXWOVU0TBEMkuPF3ULF01a3CR5uiiRt7JxUpnS7oatYWAJ9HhiFUDcsOe
	ojWTtAVK80dHAVoGG+9LTMMSoYusNa4/RGogQ6a1/6qrICEMx2Xs6O3tslhAcC7HZBJCf0gwI8yqh
	mDutUaku4GKBFVXNU1tR1TwgYv3eMQdsTnHbIiFGAoNGsEPjEFBc+RcYLA15Mxf1THnSkRlQfRq7c
	OYpV2Xbw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x1PwH-0000000COXj-2kAv;
	Tue, 01 Sep 2026 14:58:17 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x1PwF-0000000COVS-29fJ
	for linux-um@lists.infradead.org;
	Tue, 01 Sep 2026 14:58:15 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 450D04330D;
	Tue,  1 Sep 2026 14:58:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E31C61F000E9;
	Tue,  1 Sep 2026 14:58:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788274695;
	bh=CGFmBktDb18Ou8jdzee9BRhN2jpwroPuYWGDnSphFl0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VhSj3+BkQtVSyy/0a/UXLwqRnLqlZyrvWJvJ4DMKYKWfTyH44WJT6jDdHbynwgnaD
	 itgUcs3lXcrGXsGbeu20U2B2c8yr5dwKlpIrTcTIUg65IWx+T7wNL6jJ9fxhYw72t9
	 N0V+CEFK7uD5kXrBPhTbQ2AowtyQdCNIZabPOBnzEIgZL1k0LiwshRwTTVGmPOvlqf
	 dkrgnah1pNjTN2z75fEFLOXowZHGWm/M9uf+2BQy3fPxIrRgBvmie5g/8AzFbWCpXr
	 xIg0isQ71KxHd9h8LmQZ9X6qwtH2UaMIlFXJWJKIfVOPWviFWrQ4xP+iYFQPiJqyyV
	 zyPDQqoaEEG2A==
From: Eric Biggers <ebiggers@kernel.org>
To: x86@kernel.org
Cc: linux-um@lists.infradead.org,
	linux-raid@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Eric Biggers <ebiggers@kernel.org>
Subject: [PATCH v5 7/8] xor: Remove redundant X86_FEATURE_OSXSAVE check
Date: Tue,  1 Sep 2026 07:57:39 -0700
Message-ID: <20260901145740.42337-8-ebiggers@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260901145740.42337-1-ebiggers@kernel.org>
References: <20260901145740.42337-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

X86_FEATURE_AVX implies X86_FEATURE_OSXSAVE already.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Acked-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Eric Biggers <ebiggers@kernel.org>
---
 lib/raid/xor/x86/xor_arch.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/lib/raid/xor/x86/xor_arch.h b/lib/raid/xor/x86/xor_arch.h
index 99fe85a213c6..991abe3f4bbd 100644
--- a/lib/raid/xor/x86/xor_arch.h
+++ b/lib/raid/xor/x86/xor_arch.h
@@ -18,8 +18,7 @@ extern struct xor_block_template xor_block_avx;
  */
 static __always_inline void __init arch_xor_init(void)
 {
-	if (boot_cpu_has(X86_FEATURE_AVX) &&
-	    boot_cpu_has(X86_FEATURE_OSXSAVE)) {
+	if (boot_cpu_has(X86_FEATURE_AVX)) {
 		xor_force(&xor_block_avx);
 	} else if (IS_ENABLED(CONFIG_X86_64) || boot_cpu_has(X86_FEATURE_XMM)) {
 		xor_register(&xor_block_sse);
-- 
2.55.0


