Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93892CDE015
	for <linux-um@archiver.kernel.org>; Fri, 26 Jun 2026 04:39:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2iQ1W2m2jf8sj+hQjMAm5tIGc8YEMfT2gTSRmmRaOPQ=; b=E15TY3dQ6Aqa+KcYEbmqm1owp4
	JyS8DaXebLzNtW9r5GvQs3yHffSErM88B2r8R5abl/B+fBbFkkhCaUu7TEaZ9Vgip4xxLc/VCrDVM
	k7cFrvOXfFI9oDmrQVIGjTHS7wZzuS9q1PhS5bOJYAGmkymDlDXg6aoiGtxzLI2RDW1erf5MSq5Ly
	IeNyI4Axq/rWWNESoAQaDKkt/1h1ymmaMu6v7FQESrj3L2r7FUyTOpYTCw5fVtTPRcJ7/WsBzfjJc
	xCDfLIKp8K0iFO4SbduSAU9MarZoskPyHwguDRWHO85I2MmjWyrmGDELeyS7QZIzO8AatMVExUuFt
	/RGIjO7w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wcyLh-0000000ATZm-1KjI;
	Fri, 26 Jun 2026 04:39:29 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wcyLf-0000000ATY9-1Sms
	for linux-um@lists.infradead.org;
	Fri, 26 Jun 2026 04:39:27 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id C654B60128;
	Fri, 26 Jun 2026 04:39:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48BC21F00ACF;
	Fri, 26 Jun 2026 04:39:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782448766;
	bh=2iQ1W2m2jf8sj+hQjMAm5tIGc8YEMfT2gTSRmmRaOPQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NVLb1Na6vRW/fQEpxj+xBekGf4TJSfmPUFKPvbVOcRIz4ei9eERfowt4+XRMABSFF
	 D7W2gMeJi0nl6yddDwo15rO/Jrpt92HL5e7cgAyXsi4ts8uGTTE39S8rfZ6MnkIbpK
	 qJIuxvWrn+vNnJUx38PUyXoM327Mqse/HH5pZl+u9BqSRUiSzZShh+xDUjA5csOnHr
	 jlRc1ZGtx5GgJg6sMqMO6dJOhukaAZKHDGZZCO4SdqnRWwm9QScpS7ev7DSClnxHLX
	 XTscV6I054J8b2JI/UyzrSlIx6OtYVq4AmqHalr5TXN7OQre9L5QW7h+86K6E5W3Kv
	 12J3YzI6Cn0ow==
From: Eric Biggers <ebiggers@kernel.org>
To: x86@kernel.org
Cc: linux-um@lists.infradead.org,
	linux-raid@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Eric Biggers <ebiggers@kernel.org>
Subject: [PATCH 7/8] lib/raid/xor: x86: Remove redundant X86_FEATURE_OSXSAVE check
Date: Thu, 25 Jun 2026 21:37:30 -0700
Message-ID: <20260626043731.319287-8-ebiggers@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260626043731.319287-1-ebiggers@kernel.org>
References: <20260626043731.319287-1-ebiggers@kernel.org>
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

Signed-off-by: Eric Biggers <ebiggers@kernel.org>
---
 lib/raid/xor/x86/xor_arch.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/lib/raid/xor/x86/xor_arch.h b/lib/raid/xor/x86/xor_arch.h
index 99fe85a213c6..991abe3f4bbd 100644
--- a/lib/raid/xor/x86/xor_arch.h
+++ b/lib/raid/xor/x86/xor_arch.h
@@ -16,12 +16,11 @@ extern struct xor_block_template xor_block_avx;
  *
  * 32-bit without MMX can fall back to the generic routines.
  */
 static __always_inline void __init arch_xor_init(void)
 {
-	if (boot_cpu_has(X86_FEATURE_AVX) &&
-	    boot_cpu_has(X86_FEATURE_OSXSAVE)) {
+	if (boot_cpu_has(X86_FEATURE_AVX)) {
 		xor_force(&xor_block_avx);
 	} else if (IS_ENABLED(CONFIG_X86_64) || boot_cpu_has(X86_FEATURE_XMM)) {
 		xor_register(&xor_block_sse);
 		xor_register(&xor_block_sse_pf64);
 	} else if (boot_cpu_has(X86_FEATURE_MMX)) {
-- 
2.54.0


