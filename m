Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8FE0CDE013
	for <linux-um@archiver.kernel.org>; Fri, 26 Jun 2026 04:39:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Hga+FKK/kjxq6tHdknIqBYzS+Q9LWEYMoNmY2+CpADM=; b=PZBPdb+xnIYzuq66ivptu2z8lg
	HGC+A7klwAVL7vCKwgXWNpdKaVfIgOL38hEPuwWNkCmAWpeIWdbuLu/hSaofT70h/dE6jmEYHKySP
	l9Rh8GWaR7wta7wuc3N9Gi6FfDMlQ5M0UyA3TEmIWGsHjja/TzW8DxsESo5WdcJMskRdc9WYZka41
	P1a1Lkhw4IFHsRgBlS0nHQ40Cq7eTt+lobfnWumlJmlYI036kkH6GQeGurFT5fXoEN+yNSkl3tDOq
	e+THYUx8eHbajHNlNbngT8APgMuCQRDH+QI2YzV/dZrCn/7iGr4DNnLG4/hurvJoE3Iulw8gszrWt
	zeayhu8g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wcyLh-0000000ATaF-25V1;
	Fri, 26 Jun 2026 04:39:29 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wcyLf-0000000ATYA-39du
	for linux-um@lists.infradead.org;
	Fri, 26 Jun 2026 04:39:28 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id AEE0460122;
	Fri, 26 Jun 2026 04:39:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 315A41F00A3D;
	Fri, 26 Jun 2026 04:39:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782448765;
	bh=Hga+FKK/kjxq6tHdknIqBYzS+Q9LWEYMoNmY2+CpADM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bZY+Pxrm9CqQWhZSGE988ZMbqNiRmpeymU0oGqFQoRmZ8qNEU4kufBWemVpsBFwH4
	 kBUe+W3Z1TYUr/VZr2FK1SiBdYHBrEaTlcJZnp5iMJ2vFOsJYc15VaQ76CpqMUDDJ1
	 y1HfD7aYrvmyqZ4EFq05aINmN1LW5rJsF8iLrQckhegmBdu2maTzmNmpMuiLijTZ4Z
	 m4MJauZq55nyBT0UAMbNhxqhGaVSgMkhnRsKy+OnFERe38/uqZP/8+EkV813ekNVuQ
	 UGl3z8vLTJYp0CW3wMiVnsu3IJCxeu1ZVCjPzyhvv6H8Q4xpCypxu67D8BrHW2OXLS
	 AxR7y+pPFF9PQ==
From: Eric Biggers <ebiggers@kernel.org>
To: x86@kernel.org
Cc: linux-um@lists.infradead.org,
	linux-raid@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Eric Biggers <ebiggers@kernel.org>
Subject: [PATCH 4/8] lib/crypto: x86: Stop using cpu_has_xfeatures()
Date: Thu, 25 Jun 2026 21:37:27 -0700
Message-ID: <20260626043731.319287-5-ebiggers@kernel.org>
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
 lib/crypto/x86/blake2s.h  | 4 +---
 lib/crypto/x86/chacha.h   | 3 +--
 lib/crypto/x86/nh.h       | 4 +---
 lib/crypto/x86/poly1305.h | 7 ++-----
 lib/crypto/x86/sha1.h     | 4 +---
 lib/crypto/x86/sha256.h   | 4 +---
 lib/crypto/x86/sha512.h   | 3 +--
 lib/crypto/x86/sm3.h      | 3 +--
 8 files changed, 9 insertions(+), 23 deletions(-)

diff --git a/lib/crypto/x86/blake2s.h b/lib/crypto/x86/blake2s.h
index f8eed6cb042e..0f7c51f055c8 100644
--- a/lib/crypto/x86/blake2s.h
+++ b/lib/crypto/x86/blake2s.h
@@ -53,10 +53,8 @@ static void blake2s_mod_init_arch(void)
 		static_branch_enable(&blake2s_use_ssse3);
 
 	if (boot_cpu_has(X86_FEATURE_AVX) &&
 	    boot_cpu_has(X86_FEATURE_AVX2) &&
 	    boot_cpu_has(X86_FEATURE_AVX512F) &&
-	    boot_cpu_has(X86_FEATURE_AVX512VL) &&
-	    cpu_has_xfeatures(XFEATURE_MASK_SSE | XFEATURE_MASK_YMM |
-			      XFEATURE_MASK_AVX512, NULL))
+	    boot_cpu_has(X86_FEATURE_AVX512VL))
 		static_branch_enable(&blake2s_use_avx512);
 }
diff --git a/lib/crypto/x86/chacha.h b/lib/crypto/x86/chacha.h
index 10cf8f1c569d..c79562aac56b 100644
--- a/lib/crypto/x86/chacha.h
+++ b/lib/crypto/x86/chacha.h
@@ -163,12 +163,11 @@ static void chacha_mod_init_arch(void)
 		return;
 
 	static_branch_enable(&chacha_use_simd);
 
 	if (boot_cpu_has(X86_FEATURE_AVX) &&
-	    boot_cpu_has(X86_FEATURE_AVX2) &&
-	    cpu_has_xfeatures(XFEATURE_MASK_SSE | XFEATURE_MASK_YMM, NULL)) {
+	    boot_cpu_has(X86_FEATURE_AVX2)) {
 		static_branch_enable(&chacha_use_avx2);
 
 		if (boot_cpu_has(X86_FEATURE_AVX512VL) &&
 		    boot_cpu_has(X86_FEATURE_AVX512BW)) /* kmovq */
 			static_branch_enable(&chacha_use_avx512vl);
diff --git a/lib/crypto/x86/nh.h b/lib/crypto/x86/nh.h
index 83361c2e9783..342636dcb750 100644
--- a/lib/crypto/x86/nh.h
+++ b/lib/crypto/x86/nh.h
@@ -35,11 +35,9 @@ static bool nh_arch(const u32 *key, const u8 *message, size_t message_len,
 #define nh_mod_init_arch nh_mod_init_arch
 static void nh_mod_init_arch(void)
 {
 	if (boot_cpu_has(X86_FEATURE_XMM2)) {
 		static_branch_enable(&have_sse2);
-		if (boot_cpu_has(X86_FEATURE_AVX2) &&
-		    cpu_has_xfeatures(XFEATURE_MASK_SSE | XFEATURE_MASK_YMM,
-				      NULL))
+		if (boot_cpu_has(X86_FEATURE_AVX2))
 			static_branch_enable(&have_avx2);
 	}
 }
diff --git a/lib/crypto/x86/poly1305.h b/lib/crypto/x86/poly1305.h
index ee92e3740a78..b061b9926fa5 100644
--- a/lib/crypto/x86/poly1305.h
+++ b/lib/crypto/x86/poly1305.h
@@ -141,18 +141,15 @@ static void poly1305_emit(const struct poly1305_state *ctx,
 }
 
 #define poly1305_mod_init_arch poly1305_mod_init_arch
 static void poly1305_mod_init_arch(void)
 {
-	if (boot_cpu_has(X86_FEATURE_AVX) &&
-	    cpu_has_xfeatures(XFEATURE_MASK_SSE | XFEATURE_MASK_YMM, NULL))
+	if (boot_cpu_has(X86_FEATURE_AVX))
 		static_branch_enable(&poly1305_use_avx);
-	if (boot_cpu_has(X86_FEATURE_AVX) && boot_cpu_has(X86_FEATURE_AVX2) &&
-	    cpu_has_xfeatures(XFEATURE_MASK_SSE | XFEATURE_MASK_YMM, NULL))
+	if (boot_cpu_has(X86_FEATURE_AVX) && boot_cpu_has(X86_FEATURE_AVX2))
 		static_branch_enable(&poly1305_use_avx2);
 	if (boot_cpu_has(X86_FEATURE_AVX) && boot_cpu_has(X86_FEATURE_AVX2) &&
 	    boot_cpu_has(X86_FEATURE_AVX512F) &&
-	    cpu_has_xfeatures(XFEATURE_MASK_SSE | XFEATURE_MASK_YMM | XFEATURE_MASK_AVX512, NULL) &&
 	    /* Skylake downclocks unacceptably much when using zmm, but later generations are fast. */
 	    boot_cpu_data.x86_vfm != INTEL_SKYLAKE_X)
 		static_branch_enable(&poly1305_use_avx512);
 }
diff --git a/lib/crypto/x86/sha1.h b/lib/crypto/x86/sha1.h
index c48a0131fd12..6aff433466e7 100644
--- a/lib/crypto/x86/sha1.h
+++ b/lib/crypto/x86/sha1.h
@@ -57,13 +57,11 @@ static void sha1_blocks(struct sha1_block_state *state,
 #define sha1_mod_init_arch sha1_mod_init_arch
 static void sha1_mod_init_arch(void)
 {
 	if (boot_cpu_has(X86_FEATURE_SHA_NI)) {
 		static_call_update(sha1_blocks_x86, sha1_blocks_ni);
-	} else if (cpu_has_xfeatures(XFEATURE_MASK_SSE | XFEATURE_MASK_YMM,
-				     NULL) &&
-		   boot_cpu_has(X86_FEATURE_AVX)) {
+	} else if (boot_cpu_has(X86_FEATURE_AVX)) {
 		if (boot_cpu_has(X86_FEATURE_AVX2) &&
 		    boot_cpu_has(X86_FEATURE_BMI1) &&
 		    boot_cpu_has(X86_FEATURE_BMI2))
 			static_call_update(sha1_blocks_x86, sha1_blocks_avx2);
 		else
diff --git a/lib/crypto/x86/sha256.h b/lib/crypto/x86/sha256.h
index 0ee69d8e39fe..e98ffdaf4b14 100644
--- a/lib/crypto/x86/sha256.h
+++ b/lib/crypto/x86/sha256.h
@@ -102,13 +102,11 @@ static void sha256_mod_init_arch(void)
 		static_branch_enable(&have_sha_ni);
 	} else if (IS_ENABLED(CONFIG_CPU_SUP_ZHAOXIN) &&
 		   boot_cpu_has(X86_FEATURE_PHE_EN) &&
 		   boot_cpu_data.x86 >= 0x07) {
 		static_call_update(sha256_blocks_x86, sha256_blocks_phe);
-	} else if (cpu_has_xfeatures(XFEATURE_MASK_SSE | XFEATURE_MASK_YMM,
-				     NULL) &&
-		   boot_cpu_has(X86_FEATURE_AVX)) {
+	} else if (boot_cpu_has(X86_FEATURE_AVX)) {
 		if (boot_cpu_has(X86_FEATURE_AVX2) &&
 		    boot_cpu_has(X86_FEATURE_BMI2))
 			static_call_update(sha256_blocks_x86,
 					   sha256_blocks_avx2);
 		else
diff --git a/lib/crypto/x86/sha512.h b/lib/crypto/x86/sha512.h
index 0213c70cedd0..4e177b4606bd 100644
--- a/lib/crypto/x86/sha512.h
+++ b/lib/crypto/x86/sha512.h
@@ -35,12 +35,11 @@ static void sha512_blocks(struct sha512_block_state *state,
 }
 
 #define sha512_mod_init_arch sha512_mod_init_arch
 static void sha512_mod_init_arch(void)
 {
-	if (cpu_has_xfeatures(XFEATURE_MASK_SSE | XFEATURE_MASK_YMM, NULL) &&
-	    boot_cpu_has(X86_FEATURE_AVX)) {
+	if (boot_cpu_has(X86_FEATURE_AVX)) {
 		if (boot_cpu_has(X86_FEATURE_AVX2) &&
 		    boot_cpu_has(X86_FEATURE_BMI2))
 			static_call_update(sha512_blocks_x86,
 					   sha512_blocks_avx2);
 		else
diff --git a/lib/crypto/x86/sm3.h b/lib/crypto/x86/sm3.h
index 3834780f2f6a..e06d4a22e4fa 100644
--- a/lib/crypto/x86/sm3.h
+++ b/lib/crypto/x86/sm3.h
@@ -31,9 +31,8 @@ static void sm3_blocks(struct sm3_block_state *state,
 }
 
 #define sm3_mod_init_arch sm3_mod_init_arch
 static void sm3_mod_init_arch(void)
 {
-	if (boot_cpu_has(X86_FEATURE_AVX) && boot_cpu_has(X86_FEATURE_BMI2) &&
-	    cpu_has_xfeatures(XFEATURE_MASK_SSE | XFEATURE_MASK_YMM, NULL))
+	if (boot_cpu_has(X86_FEATURE_AVX) && boot_cpu_has(X86_FEATURE_BMI2))
 		static_call_update(sm3_blocks_x86, sm3_blocks_avx);
 }
-- 
2.54.0


