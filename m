Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3603DC5DF65
	for <linux-um@archiver.kernel.org>; Thu, 13 Aug 2026 02:20:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VKmmGWRx3Pfbo+nD8y5eQpPaN0sWZSIp/Ijjeyx4vLE=; b=KBETz+kzjlV+hf4a28abWBt0GZ
	wPhsBBVaJrUPwcBxNRFfUat5TGcYlK2bhzl5rSJYh2/GDw/kdTrdBuAn9wRtNvnpup0a68H1tR9rt
	PdE0+Kjp4M4G8dC2bFWpZg2gJrXhbuIu3xnSD+C3ZEd1lCIyO9bUbWP0DvSuY137JzEmrRRdiUIuO
	gKYPbGzI1Jt8ej2WsANIHpHUtjHopmwTtx7j0ehe12IKPsZ2UAb4llJiURYdS98AgPCm/YEp3RDIz
	2gqBxdHupRTY9hdugthKLS9fHPYinDGTw35qz9rcA27zf7QxQQlTqK2Us0ryizY9NAMyabPdNdVf9
	m18/lwkA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wuL3O-0000000HGw7-3lhT;
	Thu, 13 Aug 2026 02:20:22 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wuL3N-0000000HGul-2zmp
	for linux-um@lists.infradead.org;
	Thu, 13 Aug 2026 02:20:21 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 33C62600C3;
	Thu, 13 Aug 2026 02:20:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9B481F00AC4;
	Thu, 13 Aug 2026 02:20:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786587619;
	bh=VKmmGWRx3Pfbo+nD8y5eQpPaN0sWZSIp/Ijjeyx4vLE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jbfF0Cr2ucRoUEyaURyJ+GLQEY4g65br8Xp7+8ORRcCV5v8kUOOM5cxSVV7q/eTiF
	 IchirtVC2pYhgKjYzav90m35Pct7JvygB5aS0OH/tqjRuj7QXsHbKqPZCWyIJo1Ruv
	 yd73eybjb9QIv5Kw5lddbk1zvauhRfeKEVe8RW8ex+R5l1UQA1r8Sc1zJDsYQVvrK9
	 cS4NuD78GQ3XpQiuIT3Sr7kvFcdb9Le4SqID1A9Zd9uAxKcAPoGPmFxSIjD8+7Irtv
	 1KihH0Glp5ND+U/YSL8iE1kRoErrvQu01fo15qqUbzByYVaciQ5cSHE8a+AALD7uKF
	 5MSyR3mPaDrtg==
From: Eric Biggers <ebiggers@kernel.org>
To: x86@kernel.org
Cc: linux-um@lists.infradead.org,
	linux-raid@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Eric Biggers <ebiggers@kernel.org>
Subject: [PATCH v3 3/8] crypto: x86 - Stop using cpu_has_xfeatures()
Date: Wed, 12 Aug 2026 19:15:01 -0700
Message-ID: <20260813021506.55129-4-ebiggers@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260813021506.55129-1-ebiggers@kernel.org>
References: <20260813021506.55129-1-ebiggers@kernel.org>
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

Checking both boot_cpu_has(X86_FEATURE_AVX*) and cpu_has_xfeatures() has
never really been needed in practice, and it's never been universally
done (e.g., lib/raid/ omits cpu_has_xfeatures()).  Nevertheless, both
x86 and UML now explicitly clear the AVX and AVX-512 flags if their
xfeatures are missing, which should remove any remaining doubts.

Thus, remove all the calls to cpu_has_xfeatures(), as well as the
related checks of boot_cpu_has(X86_FEATURE_OSXSAVE).

In a few cases there was no corresponding boot_cpu_has(X86_FEATURE_AVX*)
check, so add the missing ones.

Acked-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Eric Biggers <ebiggers@kernel.org>
---
 arch/x86/crypto/aegis128-aesni-glue.c      |  3 +--
 arch/x86/crypto/aesni-intel_glue.c         |  7 ++-----
 arch/x86/crypto/aria_aesni_avx2_glue.c     | 11 +----------
 arch/x86/crypto/aria_aesni_avx_glue.c      | 11 +----------
 arch/x86/crypto/aria_gfni_avx512_glue.c    | 11 +----------
 arch/x86/crypto/camellia_aesni_avx2_glue.c | 11 +----------
 arch/x86/crypto/camellia_aesni_avx_glue.c  | 11 +----------
 arch/x86/crypto/cast5_avx_glue.c           |  7 ++-----
 arch/x86/crypto/cast6_avx_glue.c           |  7 ++-----
 arch/x86/crypto/serpent_avx2_glue.c        |  9 +--------
 arch/x86/crypto/serpent_avx_glue.c         |  7 ++-----
 arch/x86/crypto/sm4_aesni_avx2_glue.c      | 11 +----------
 arch/x86/crypto/sm4_aesni_avx_glue.c       | 11 +----------
 arch/x86/crypto/twofish_avx_glue.c         |  6 ++----
 14 files changed, 19 insertions(+), 104 deletions(-)

diff --git a/arch/x86/crypto/aegis128-aesni-glue.c b/arch/x86/crypto/aegis128-aesni-glue.c
index f1adfba1a76e..09fc0b15b0e9 100644
--- a/arch/x86/crypto/aegis128-aesni-glue.c
+++ b/arch/x86/crypto/aegis128-aesni-glue.c
@@ -265,8 +265,7 @@ static struct aead_alg crypto_aegis128_aesni_alg = {
 static int __init crypto_aegis128_aesni_module_init(void)
 {
 	if (!boot_cpu_has(X86_FEATURE_XMM4_1) ||
-	    !boot_cpu_has(X86_FEATURE_AES) ||
-	    !cpu_has_xfeatures(XFEATURE_MASK_SSE, NULL))
+	    !boot_cpu_has(X86_FEATURE_AES))
 		return -ENODEV;
 
 	return crypto_register_aead(&crypto_aegis128_aesni_alg);
diff --git a/arch/x86/crypto/aesni-intel_glue.c b/arch/x86/crypto/aesni-intel_glue.c
index f522fff9231e..f6f899db7482 100644
--- a/arch/x86/crypto/aesni-intel_glue.c
+++ b/arch/x86/crypto/aesni-intel_glue.c
@@ -1548,8 +1548,7 @@ static int __init register_avx_algs(void)
 	if (!boot_cpu_has(X86_FEATURE_AVX2) ||
 	    !boot_cpu_has(X86_FEATURE_VAES) ||
 	    !boot_cpu_has(X86_FEATURE_VPCLMULQDQ) ||
-	    !boot_cpu_has(X86_FEATURE_PCLMULQDQ) ||
-	    !cpu_has_xfeatures(XFEATURE_MASK_SSE | XFEATURE_MASK_YMM, NULL))
+	    !boot_cpu_has(X86_FEATURE_PCLMULQDQ))
 		return 0;
 	err = crypto_register_skciphers(skcipher_algs_vaes_avx2,
 					ARRAY_SIZE(skcipher_algs_vaes_avx2));
@@ -1562,9 +1561,7 @@ static int __init register_avx_algs(void)
 
 	if (!boot_cpu_has(X86_FEATURE_AVX512BW) ||
 	    !boot_cpu_has(X86_FEATURE_AVX512VL) ||
-	    !boot_cpu_has(X86_FEATURE_BMI2) ||
-	    !cpu_has_xfeatures(XFEATURE_MASK_SSE | XFEATURE_MASK_YMM |
-			       XFEATURE_MASK_AVX512, NULL))
+	    !boot_cpu_has(X86_FEATURE_BMI2))
 		return 0;
 
 	if (boot_cpu_has(X86_FEATURE_PREFER_YMM)) {
diff --git a/arch/x86/crypto/aria_aesni_avx2_glue.c b/arch/x86/crypto/aria_aesni_avx2_glue.c
index 1487a49bfbac..371be2fb6469 100644
--- a/arch/x86/crypto/aria_aesni_avx2_glue.c
+++ b/arch/x86/crypto/aria_aesni_avx2_glue.c
@@ -195,22 +195,13 @@ static struct skcipher_alg aria_algs[] = {
 
 static int __init aria_avx2_init(void)
 {
-	const char *feature_name;
-
 	if (!boot_cpu_has(X86_FEATURE_AVX) ||
 	    !boot_cpu_has(X86_FEATURE_AVX2) ||
-	    !boot_cpu_has(X86_FEATURE_AES) ||
-	    !boot_cpu_has(X86_FEATURE_OSXSAVE)) {
+	    !boot_cpu_has(X86_FEATURE_AES)) {
 		pr_info("AVX2 or AES-NI instructions are not detected.\n");
 		return -ENODEV;
 	}
 
-	if (!cpu_has_xfeatures(XFEATURE_MASK_SSE | XFEATURE_MASK_YMM,
-				&feature_name)) {
-		pr_info("CPU feature '%s' is not supported.\n", feature_name);
-		return -ENODEV;
-	}
-
 	if (boot_cpu_has(X86_FEATURE_GFNI)) {
 		aria_ops.aria_encrypt_16way = aria_aesni_avx_gfni_encrypt_16way;
 		aria_ops.aria_decrypt_16way = aria_aesni_avx_gfni_decrypt_16way;
diff --git a/arch/x86/crypto/aria_aesni_avx_glue.c b/arch/x86/crypto/aria_aesni_avx_glue.c
index e4e3d78915a5..d23fc91c0ebd 100644
--- a/arch/x86/crypto/aria_aesni_avx_glue.c
+++ b/arch/x86/crypto/aria_aesni_avx_glue.c
@@ -182,21 +182,12 @@ static struct skcipher_alg aria_algs[] = {
 
 static int __init aria_avx_init(void)
 {
-	const char *feature_name;
-
 	if (!boot_cpu_has(X86_FEATURE_AVX) ||
-	    !boot_cpu_has(X86_FEATURE_AES) ||
-	    !boot_cpu_has(X86_FEATURE_OSXSAVE)) {
+	    !boot_cpu_has(X86_FEATURE_AES)) {
 		pr_info("AVX or AES-NI instructions are not detected.\n");
 		return -ENODEV;
 	}
 
-	if (!cpu_has_xfeatures(XFEATURE_MASK_SSE | XFEATURE_MASK_YMM,
-				&feature_name)) {
-		pr_info("CPU feature '%s' is not supported.\n", feature_name);
-		return -ENODEV;
-	}
-
 	if (boot_cpu_has(X86_FEATURE_GFNI)) {
 		aria_ops.aria_encrypt_16way = aria_aesni_avx_gfni_encrypt_16way;
 		aria_ops.aria_decrypt_16way = aria_aesni_avx_gfni_decrypt_16way;
diff --git a/arch/x86/crypto/aria_gfni_avx512_glue.c b/arch/x86/crypto/aria_gfni_avx512_glue.c
index 363cbf4399cc..e05bbeb22d4a 100644
--- a/arch/x86/crypto/aria_gfni_avx512_glue.c
+++ b/arch/x86/crypto/aria_gfni_avx512_glue.c
@@ -196,24 +196,15 @@ static struct skcipher_alg aria_algs[] = {
 
 static int __init aria_avx512_init(void)
 {
-	const char *feature_name;
-
 	if (!boot_cpu_has(X86_FEATURE_AVX) ||
 	    !boot_cpu_has(X86_FEATURE_AVX2) ||
 	    !boot_cpu_has(X86_FEATURE_AVX512F) ||
 	    !boot_cpu_has(X86_FEATURE_AVX512VL) ||
-	    !boot_cpu_has(X86_FEATURE_GFNI) ||
-	    !boot_cpu_has(X86_FEATURE_OSXSAVE)) {
+	    !boot_cpu_has(X86_FEATURE_GFNI)) {
 		pr_info("AVX512/GFNI instructions are not detected.\n");
 		return -ENODEV;
 	}
 
-	if (!cpu_has_xfeatures(XFEATURE_MASK_SSE | XFEATURE_MASK_YMM |
-			       XFEATURE_MASK_AVX512, &feature_name)) {
-		pr_info("CPU feature '%s' is not supported.\n", feature_name);
-		return -ENODEV;
-	}
-
 	aria_ops.aria_encrypt_16way = aria_aesni_avx_gfni_encrypt_16way;
 	aria_ops.aria_decrypt_16way = aria_aesni_avx_gfni_decrypt_16way;
 	aria_ops.aria_ctr_crypt_16way = aria_aesni_avx_gfni_ctr_crypt_16way;
diff --git a/arch/x86/crypto/camellia_aesni_avx2_glue.c b/arch/x86/crypto/camellia_aesni_avx2_glue.c
index 2d2f4e16537c..073fa3bb8388 100644
--- a/arch/x86/crypto/camellia_aesni_avx2_glue.c
+++ b/arch/x86/crypto/camellia_aesni_avx2_glue.c
@@ -97,22 +97,13 @@ static struct skcipher_alg camellia_algs[] = {
 
 static int __init camellia_aesni_init(void)
 {
-	const char *feature_name;
-
 	if (!boot_cpu_has(X86_FEATURE_AVX) ||
 	    !boot_cpu_has(X86_FEATURE_AVX2) ||
-	    !boot_cpu_has(X86_FEATURE_AES) ||
-	    !boot_cpu_has(X86_FEATURE_OSXSAVE)) {
+	    !boot_cpu_has(X86_FEATURE_AES)) {
 		pr_info("AVX2 or AES-NI instructions are not detected.\n");
 		return -ENODEV;
 	}
 
-	if (!cpu_has_xfeatures(XFEATURE_MASK_SSE | XFEATURE_MASK_YMM,
-				&feature_name)) {
-		pr_info("CPU feature '%s' is not supported.\n", feature_name);
-		return -ENODEV;
-	}
-
 	return crypto_register_skciphers(camellia_algs,
 					 ARRAY_SIZE(camellia_algs));
 }
diff --git a/arch/x86/crypto/camellia_aesni_avx_glue.c b/arch/x86/crypto/camellia_aesni_avx_glue.c
index 5c321f255eb7..872e5e07220f 100644
--- a/arch/x86/crypto/camellia_aesni_avx_glue.c
+++ b/arch/x86/crypto/camellia_aesni_avx_glue.c
@@ -98,21 +98,12 @@ static struct skcipher_alg camellia_algs[] = {
 
 static int __init camellia_aesni_init(void)
 {
-	const char *feature_name;
-
 	if (!boot_cpu_has(X86_FEATURE_AVX) ||
-	    !boot_cpu_has(X86_FEATURE_AES) ||
-	    !boot_cpu_has(X86_FEATURE_OSXSAVE)) {
+	    !boot_cpu_has(X86_FEATURE_AES)) {
 		pr_info("AVX or AES-NI instructions are not detected.\n");
 		return -ENODEV;
 	}
 
-	if (!cpu_has_xfeatures(XFEATURE_MASK_SSE | XFEATURE_MASK_YMM,
-				&feature_name)) {
-		pr_info("CPU feature '%s' is not supported.\n", feature_name);
-		return -ENODEV;
-	}
-
 	return crypto_register_skciphers(camellia_algs,
 					 ARRAY_SIZE(camellia_algs));
 }
diff --git a/arch/x86/crypto/cast5_avx_glue.c b/arch/x86/crypto/cast5_avx_glue.c
index 3aca04d43b34..5de35e863370 100644
--- a/arch/x86/crypto/cast5_avx_glue.c
+++ b/arch/x86/crypto/cast5_avx_glue.c
@@ -92,11 +92,8 @@ static struct skcipher_alg cast5_algs[] = {
 
 static int __init cast5_init(void)
 {
-	const char *feature_name;
-
-	if (!cpu_has_xfeatures(XFEATURE_MASK_SSE | XFEATURE_MASK_YMM,
-				&feature_name)) {
-		pr_info("CPU feature '%s' is not supported.\n", feature_name);
+	if (!boot_cpu_has(X86_FEATURE_AVX)) {
+		pr_info("AVX instructions are not detected.\n");
 		return -ENODEV;
 	}
 
diff --git a/arch/x86/crypto/cast6_avx_glue.c b/arch/x86/crypto/cast6_avx_glue.c
index c4dd28c30303..3d7ea48007bc 100644
--- a/arch/x86/crypto/cast6_avx_glue.c
+++ b/arch/x86/crypto/cast6_avx_glue.c
@@ -92,11 +92,8 @@ static struct skcipher_alg cast6_algs[] = {
 
 static int __init cast6_init(void)
 {
-	const char *feature_name;
-
-	if (!cpu_has_xfeatures(XFEATURE_MASK_SSE | XFEATURE_MASK_YMM,
-				&feature_name)) {
-		pr_info("CPU feature '%s' is not supported.\n", feature_name);
+	if (!boot_cpu_has(X86_FEATURE_AVX)) {
+		pr_info("AVX instructions are not detected.\n");
 		return -ENODEV;
 	}
 
diff --git a/arch/x86/crypto/serpent_avx2_glue.c b/arch/x86/crypto/serpent_avx2_glue.c
index f5f2121b7956..72a9e2b306d6 100644
--- a/arch/x86/crypto/serpent_avx2_glue.c
+++ b/arch/x86/crypto/serpent_avx2_glue.c
@@ -93,17 +93,10 @@ static struct skcipher_alg serpent_algs[] = {
 
 static int __init serpent_avx2_init(void)
 {
-	const char *feature_name;
-
-	if (!boot_cpu_has(X86_FEATURE_AVX2) || !boot_cpu_has(X86_FEATURE_OSXSAVE)) {
+	if (!boot_cpu_has(X86_FEATURE_AVX2)) {
 		pr_info("AVX2 instructions are not detected.\n");
 		return -ENODEV;
 	}
-	if (!cpu_has_xfeatures(XFEATURE_MASK_SSE | XFEATURE_MASK_YMM,
-				&feature_name)) {
-		pr_info("CPU feature '%s' is not supported.\n", feature_name);
-		return -ENODEV;
-	}
 
 	return crypto_register_skciphers(serpent_algs,
 					 ARRAY_SIZE(serpent_algs));
diff --git a/arch/x86/crypto/serpent_avx_glue.c b/arch/x86/crypto/serpent_avx_glue.c
index 9c8b3a335d5c..42c4e1569674 100644
--- a/arch/x86/crypto/serpent_avx_glue.c
+++ b/arch/x86/crypto/serpent_avx_glue.c
@@ -100,11 +100,8 @@ static struct skcipher_alg serpent_algs[] = {
 
 static int __init serpent_init(void)
 {
-	const char *feature_name;
-
-	if (!cpu_has_xfeatures(XFEATURE_MASK_SSE | XFEATURE_MASK_YMM,
-				&feature_name)) {
-		pr_info("CPU feature '%s' is not supported.\n", feature_name);
+	if (!boot_cpu_has(X86_FEATURE_AVX)) {
+		pr_info("AVX instructions are not detected.\n");
 		return -ENODEV;
 	}
 
diff --git a/arch/x86/crypto/sm4_aesni_avx2_glue.c b/arch/x86/crypto/sm4_aesni_avx2_glue.c
index fec0ab7a63dd..eef73894e777 100644
--- a/arch/x86/crypto/sm4_aesni_avx2_glue.c
+++ b/arch/x86/crypto/sm4_aesni_avx2_glue.c
@@ -98,22 +98,13 @@ static struct skcipher_alg sm4_aesni_avx2_skciphers[] = {
 
 static int __init sm4_init(void)
 {
-	const char *feature_name;
-
 	if (!boot_cpu_has(X86_FEATURE_AVX) ||
 	    !boot_cpu_has(X86_FEATURE_AVX2) ||
-	    !boot_cpu_has(X86_FEATURE_AES) ||
-	    !boot_cpu_has(X86_FEATURE_OSXSAVE)) {
+	    !boot_cpu_has(X86_FEATURE_AES)) {
 		pr_info("AVX2 or AES-NI instructions are not detected.\n");
 		return -ENODEV;
 	}
 
-	if (!cpu_has_xfeatures(XFEATURE_MASK_SSE | XFEATURE_MASK_YMM,
-				&feature_name)) {
-		pr_info("CPU feature '%s' is not supported.\n", feature_name);
-		return -ENODEV;
-	}
-
 	return crypto_register_skciphers(sm4_aesni_avx2_skciphers,
 					 ARRAY_SIZE(sm4_aesni_avx2_skciphers));
 }
diff --git a/arch/x86/crypto/sm4_aesni_avx_glue.c b/arch/x86/crypto/sm4_aesni_avx_glue.c
index 88caf418a06f..ed383da5ff46 100644
--- a/arch/x86/crypto/sm4_aesni_avx_glue.c
+++ b/arch/x86/crypto/sm4_aesni_avx_glue.c
@@ -314,21 +314,12 @@ static struct skcipher_alg sm4_aesni_avx_skciphers[] = {
 
 static int __init sm4_init(void)
 {
-	const char *feature_name;
-
 	if (!boot_cpu_has(X86_FEATURE_AVX) ||
-	    !boot_cpu_has(X86_FEATURE_AES) ||
-	    !boot_cpu_has(X86_FEATURE_OSXSAVE)) {
+	    !boot_cpu_has(X86_FEATURE_AES)) {
 		pr_info("AVX or AES-NI instructions are not detected.\n");
 		return -ENODEV;
 	}
 
-	if (!cpu_has_xfeatures(XFEATURE_MASK_SSE | XFEATURE_MASK_YMM,
-				&feature_name)) {
-		pr_info("CPU feature '%s' is not supported.\n", feature_name);
-		return -ENODEV;
-	}
-
 	return crypto_register_skciphers(sm4_aesni_avx_skciphers,
 					 ARRAY_SIZE(sm4_aesni_avx_skciphers));
 }
diff --git a/arch/x86/crypto/twofish_avx_glue.c b/arch/x86/crypto/twofish_avx_glue.c
index 9e20db013750..985bc54a2340 100644
--- a/arch/x86/crypto/twofish_avx_glue.c
+++ b/arch/x86/crypto/twofish_avx_glue.c
@@ -102,10 +102,8 @@ static struct skcipher_alg twofish_algs[] = {
 
 static int __init twofish_init(void)
 {
-	const char *feature_name;
-
-	if (!cpu_has_xfeatures(XFEATURE_MASK_SSE | XFEATURE_MASK_YMM, &feature_name)) {
-		pr_info("CPU feature '%s' is not supported.\n", feature_name);
+	if (!boot_cpu_has(X86_FEATURE_AVX)) {
+		pr_info("AVX instructions are not detected.\n");
 		return -ENODEV;
 	}
 
-- 
2.55.0


