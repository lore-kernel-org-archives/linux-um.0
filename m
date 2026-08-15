Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78AD0C5AD5A
	for <linux-um@archiver.kernel.org>; Sat, 15 Aug 2026 18:12:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CGFmBktDb18Ou8jdzee9BRhN2jpwroPuYWGDnSphFl0=; b=VEBgG5aWdSHd4OI1qjdkJMs0Fb
	JRlpiBYFrcECi77UrJj2MCRDHUn8tEpAKpmQAOF1LxcpUhhTXknkSVgn3OWdry9WmaTUUlapxfLAY
	PlcSxSfJwsod15XntiuLAlilzhoqRc0yTzHlg5DGZS59A7N/Q8wn9pUlC6XQ8Kf8nme8VOGeEFDZx
	sXjrJAtjPlMLVllHW8bJsT/eQ3yaLR6+kkgk/fhrA9sqYjWlqQ9foG7yjAbpyvIrvdxlVDkCAjBWa
	qynJEOnlBYdABdtSbSkrnARLt3EYl2numSMR2Pbi2qORUZbOTmAbVJ+S13buJUuXMxMszem0/fdGE
	U/WnGuAg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wvIs4-000000041Fg-0LkE;
	Sat, 15 Aug 2026 18:12:40 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wvIs1-000000041Bm-0i5U
	for linux-um@lists.infradead.org;
	Sat, 15 Aug 2026 18:12:37 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id E895D436E8;
	Sat, 15 Aug 2026 18:12:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81EFA1F00ACA;
	Sat, 15 Aug 2026 18:12:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786817556;
	bh=CGFmBktDb18Ou8jdzee9BRhN2jpwroPuYWGDnSphFl0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ldjMJ+impcxexn1BTzwXKM0ieYKC+W9D1FQGgpAGZUCFZjnldAnVMlyHPjyd6kNrm
	 ceUwaoE+eHz3jmAd+5aWvSLW3jYxwFVNyhz4QlmLOe2jpgpE5UOhNI1UFJYLY2uDTv
	 1CvCina8Qp/l4r1TlhDDl9CsjMNgxUDvTR8ifzaIwj3qs1/6ky561iQcv8QTbCfHRL
	 jHIYGO/67OninbV3QcYvCqjkgngQsw2u2QzfB82dHTArMxdSkbQOQ6UxLALx2HruZV
	 JV80HbZQ0+Pt6j7jR/ahsiWXylADEMLCz5UMMWTlwWkuh3UfIm6YRRXTl5juK85zrJ
	 v1da6pUA1ddxA==
From: Eric Biggers <ebiggers@kernel.org>
To: x86@kernel.org
Cc: linux-um@lists.infradead.org,
	linux-raid@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Eric Biggers <ebiggers@kernel.org>
Subject: [PATCH v4 7/8] xor: Remove redundant X86_FEATURE_OSXSAVE check
Date: Sat, 15 Aug 2026 11:10:23 -0700
Message-ID: <20260815181024.28924-8-ebiggers@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260815181024.28924-1-ebiggers@kernel.org>
References: <20260815181024.28924-1-ebiggers@kernel.org>
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


