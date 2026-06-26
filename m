Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B903CCDE017
	for <linux-um@archiver.kernel.org>; Fri, 26 Jun 2026 04:39:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XKHZjuqa6SA7Q+q9Rian771zvDreJMenlySa40ODDo4=; b=BiMTpq46elbBgtyoVrExDSPxVj
	t6q41jR/luhoX3RIhyb1cCim9StNtCUWgxwRUuXqaqET4W/FnEjwzfvA9PfFwMGI+wQUAsZ16TGKa
	Fp8Fyyb3pyX5XQewTIpFYPVQ8WfugaOIIrA6IdjJtTmSvGDNPPG/OR5VfNAb7hAmVqNa26Nac6LtR
	nC8lyBQOHZiGI2gIwMsafpNqQ0chQAcc5MiW4qeBd2JhzFQ7LlVk3cZNsNuOzfYhRVVDh0MKZJpLS
	/aFIpusH4iM8W5C5LO6kerai1I3w5ehTpffHvrE8RZxkQNC2cQ7jI5sG58KDC5O4YUN1SuAubWz1M
	V7Sq2Smg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wcyLh-0000000ATa4-1iol;
	Fri, 26 Jun 2026 04:39:29 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wcyLf-0000000ATY2-1rww
	for linux-um@lists.infradead.org;
	Fri, 26 Jun 2026 04:39:27 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 13A2A60141;
	Fri, 26 Jun 2026 04:39:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A6611F00A3E;
	Fri, 26 Jun 2026 04:39:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782448765;
	bh=XKHZjuqa6SA7Q+q9Rian771zvDreJMenlySa40ODDo4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gZzDs4LY1eQrVc4m3L3prP2YGRmr0ZDlgWf5RvT0ELnNdCSh6UFJ0vNT8Aip3r0Ps
	 KcUEGZDvsjsYjD30dB5rZ10Ml0y30P4Ov5veDg+QkTGaXN0qBXMZgISNPLZD2LqLoH
	 PfuDnsgatoprHVpvqvLHafIQnitGKb6aYbYSDwZUBs0nFA54f4wOlog6aIIbIQ20Xk
	 fZmOd9ltXX0bAu9qbt/5Wdxckb91zl0Sq2GOPapRx38A0GUE3dVe4OCLRTxG3JH/QJ
	 VVveOIT1nU0u218YJca17NApbALRkGWsglZA4JGcvABdb7cSlE5xfjI/LlyRnmAgYV
	 CCRWLP1EKregA==
From: Eric Biggers <ebiggers@kernel.org>
To: x86@kernel.org
Cc: linux-um@lists.infradead.org,
	linux-raid@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Eric Biggers <ebiggers@kernel.org>
Subject: [PATCH 5/8] lib/crc: x86: Stop using cpu_has_xfeatures()
Date: Thu, 25 Jun 2026 21:37:28 -0700
Message-ID: <20260626043731.319287-6-ebiggers@kernel.org>
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

Checking both boot_cpu_has() and cpu_has_xfeatures() has never really
been needed in practice, and it's never been universally done (e.g.,
lib/raid/ omits cpu_has_xfeatures()).  Nevertheless, both x86 and UML
now explicitly clear the AVX and AVX-512 flags if their xfeatures are
missing, which should remove any remaining doubts.

Thus, remove all the calls to cpu_has_xfeatures().

Signed-off-by: Eric Biggers <ebiggers@kernel.org>
---
 lib/crc/x86/crc-pclmul-template.h | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/lib/crc/x86/crc-pclmul-template.h b/lib/crc/x86/crc-pclmul-template.h
index 02744831c6fa..893119bb7c07 100644
--- a/lib/crc/x86/crc-pclmul-template.h
+++ b/lib/crc/x86/crc-pclmul-template.h
@@ -25,20 +25,18 @@ crc_t prefix##_vpclmul_avx512(crc_t crc, const u8 *p, size_t len,	\
 DEFINE_STATIC_CALL(prefix##_pclmul, prefix##_pclmul_sse)
 
 static inline bool have_vpclmul(void)
 {
 	return boot_cpu_has(X86_FEATURE_VPCLMULQDQ) &&
-	       boot_cpu_has(X86_FEATURE_AVX2) &&
-	       cpu_has_xfeatures(XFEATURE_MASK_YMM, NULL);
+	       boot_cpu_has(X86_FEATURE_AVX2);
 }
 
 static inline bool have_avx512(void)
 {
 	return boot_cpu_has(X86_FEATURE_AVX512BW) &&
 	       boot_cpu_has(X86_FEATURE_AVX512VL) &&
-	       !boot_cpu_has(X86_FEATURE_PREFER_YMM) &&
-	       cpu_has_xfeatures(XFEATURE_MASK_AVX512, NULL);
+	       !boot_cpu_has(X86_FEATURE_PREFER_YMM);
 }
 
 /*
  * Call a [V]PCLMULQDQ optimized CRC function if the data length is at least 16
  * bytes, the CPU has PCLMULQDQ support, and the current context may use SIMD.
-- 
2.54.0


