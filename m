Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D253AC54F4C
	for <linux-um@archiver.kernel.org>; Tue, 28 Jul 2026 02:19:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=31UGHYq+d0u8f48qP0Suqrqb8/GOanM5DkaA24l4HNQ=; b=Oq0qrmomC4VyasTWFRYndSE0fX
	QnBhX7Z3Ci8NEZHs/+XQ5DcgdJE0Q6qEEGPj9b3/3mTTqj1NCajp71w0ecJU5UmkAAV1hHe/xwrnq
	uEXBY8bQshxOjzTQPHYYHHXdxyBw6GNZBNKAtjn0sW6LcXcK/132X2s9WdKavmF0S5SZ8cFY1Z3ee
	DRN8IS99svo1Y4CEyuIhIGTs0E+8IyJHzw547L0L6RmVCqSYK585m4OdII4dH1tfDc4JrSZ1Yew/b
	OLqQ7CZq1I+zMs+R67t2An6GCKAF03WgLFg2NllBKIeym3AHdlDE2BdIjo7BSeneL8PfhaNTc8OPo
	ULNzOJyg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1woXPb-00000004Fed-273x;
	Tue, 28 Jul 2026 02:19:19 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1woXPa-00000004Fdn-1ccP
	for linux-um@lists.infradead.org;
	Tue, 28 Jul 2026 02:19:18 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 2A23943BBC;
	Tue, 28 Jul 2026 02:19:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD08E1F00A3D;
	Tue, 28 Jul 2026 02:19:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785205158;
	bh=31UGHYq+d0u8f48qP0Suqrqb8/GOanM5DkaA24l4HNQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XGoKSrSkBt4xo+VMKbCv/SKWBD02GtnxLebQXbZ1u60X+bcKIcmYX1az6/OcOXkx4
	 VLWyHN+FwvtpTODodlTLvWsGMn2EVlUSis+bBxh65Hye+gfgCg7zbxz/AjUy6Wiupi
	 HyoKEHxktBuen6+jOCEeG42RkgHwZd4WhrTeDuZnrewMlUIvbpKmo15V8q8ZAypxQ4
	 HZT29v7wcRogoLERFaUp7qVdU5lkbVXvnxXecOcMBRufibknrYm9zZOsuuE9n6BHEz
	 +ma6t2EVewuheWEakDzmFEapcddg34UckJjPq3oNzwFF5h3SwMElHKDfbvncaJT++j
	 rEWtQukVZBIKA==
From: Eric Biggers <ebiggers@kernel.org>
To: x86@kernel.org
Cc: linux-um@lists.infradead.org,
	linux-raid@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Eric Biggers <ebiggers@kernel.org>
Subject: [PATCH v2 4/8] lib/crypto: x86: Stop using cpu_has_xfeatures()
Date: Mon, 27 Jul 2026 19:15:59 -0700
Message-ID: <20260728021603.79870-5-ebiggers@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260728021603.79870-1-ebiggers@kernel.org>
References: <20260728021603.79870-1-ebiggers@kernel.org>
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
index f8eed6cb042e4..0f7c51f055c8f 100644
--- a/lib/crypto/x86/blake2s.h
+++ b/lib/crypto/x86/blake2s.h
@@ -55,8 +55,6 @@ static void blake2s_mod_init_arch(void)
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
index 10cf8f1c569dc..c79562aac56b6 100644
--- a/lib/crypto/x86/chacha.h
+++ b/lib/crypto/x86/chacha.h
@@ -165,8 +165,7 @@ static void chacha_mod_init_arch(void)
 	static_branch_enable(&chacha_use_simd);
 
 	if (boot_cpu_has(X86_FEATURE_AVX) &&
-	    boot_cpu_has(X86_FEATURE_AVX2) &&
-	    cpu_has_xfeatures(XFEATURE_MASK_SSE | XFEATURE_MASK_YMM, NULL)) {
+	    boot_cpu_has(X86_FEATURE_AVX2)) {
 		static_branch_enable(&chacha_use_avx2);
 
 		if (boot_cpu_has(X86_FEATURE_AVX512VL) &&
diff --git a/lib/crypto/x86/nh.h b/lib/crypto/x86/nh.h
index 83361c2e97838..342636dcb750f 100644
--- a/lib/crypto/x86/nh.h
+++ b/lib/crypto/x86/nh.h
@@ -37,9 +37,7 @@ static void nh_mod_init_arch(void)
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
index ee92e3740a787..b061b9926fa5d 100644
--- a/lib/crypto/x86/poly1305.h
+++ b/lib/crypto/x86/poly1305.h
@@ -143,15 +143,12 @@ static void poly1305_emit(const struct poly1305_state *ctx,
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
diff --git a/lib/crypto/x86/sha1.h b/lib/crypto/x86/sha1.h
index c48a0131fd12c..6aff433466e7e 100644
--- a/lib/crypto/x86/sha1.h
+++ b/lib/crypto/x86/sha1.h
@@ -59,9 +59,7 @@ static void sha1_mod_init_arch(void)
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
diff --git a/lib/crypto/x86/sha256.h b/lib/crypto/x86/sha256.h
index 0ee69d8e39fe8..e98ffdaf4b14f 100644
--- a/lib/crypto/x86/sha256.h
+++ b/lib/crypto/x86/sha256.h
@@ -104,9 +104,7 @@ static void sha256_mod_init_arch(void)
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
diff --git a/lib/crypto/x86/sha512.h b/lib/crypto/x86/sha512.h
index 0213c70cedd01..4e177b4606bd2 100644
--- a/lib/crypto/x86/sha512.h
+++ b/lib/crypto/x86/sha512.h
@@ -37,8 +37,7 @@ static void sha512_blocks(struct sha512_block_state *state,
 #define sha512_mod_init_arch sha512_mod_init_arch
 static void sha512_mod_init_arch(void)
 {
-	if (cpu_has_xfeatures(XFEATURE_MASK_SSE | XFEATURE_MASK_YMM, NULL) &&
-	    boot_cpu_has(X86_FEATURE_AVX)) {
+	if (boot_cpu_has(X86_FEATURE_AVX)) {
 		if (boot_cpu_has(X86_FEATURE_AVX2) &&
 		    boot_cpu_has(X86_FEATURE_BMI2))
 			static_call_update(sha512_blocks_x86,
diff --git a/lib/crypto/x86/sm3.h b/lib/crypto/x86/sm3.h
index 3834780f2f6a3..e06d4a22e4fa7 100644
--- a/lib/crypto/x86/sm3.h
+++ b/lib/crypto/x86/sm3.h
@@ -33,7 +33,6 @@ static void sm3_blocks(struct sm3_block_state *state,
 #define sm3_mod_init_arch sm3_mod_init_arch
 static void sm3_mod_init_arch(void)
 {
-	if (boot_cpu_has(X86_FEATURE_AVX) && boot_cpu_has(X86_FEATURE_BMI2) &&
-	    cpu_has_xfeatures(XFEATURE_MASK_SSE | XFEATURE_MASK_YMM, NULL))
+	if (boot_cpu_has(X86_FEATURE_AVX) && boot_cpu_has(X86_FEATURE_BMI2))
 		static_call_update(sm3_blocks_x86, sm3_blocks_avx);
 }
-- 
2.55.0


