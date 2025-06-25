Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D80DC7115C
	for <linux-um@archiver.kernel.org>; Wed, 25 Jun 2025 11:05:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=spnPWYrTCugBtv3C0I1/Y7oTbF6XlJIePRXoFmRkZ78=; b=x4NZUEtivCLW4O+07I/gsAYKfX
	gy4UUnkitTvGclimZ6rnRzcwuJDDfuMFzG7LIYY+wqEx1pO/x/kzOE23BLFteI9+TnoJke9SkZX5R
	FzIQ18JvgXT2fAH9JWmv07H110VaJAkbpfcEo3lD9njayIlI2fUjj+rHWbm/KozfA3krbuMYcKkPo
	CnsyjVJSQBBm0Kw9I4wsuGp27DhK2oWU/evNol8qoLSnd/DpnGFLF1bDwdY9fAs2GCAO3uIctFO/M
	X5BstxcdHCYQ4/6R7VuW2Vf74WCr/tgrMa4gkddZFRB7z38ANxKTBAR8p0TBNV34Kq6yRn4GwW4k2
	piAXkohw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uUNwM-00000008Pem-0WKR;
	Wed, 25 Jun 2025 11:05:18 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uUMoQ-00000008CpK-0zqC;
	Wed, 25 Jun 2025 09:53:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=spnPWYrTCugBtv3C0I1/Y7oTbF6XlJIePRXoFmRkZ78=; b=M7QSXF92coxDAYjoHgnhjIgfSA
	+fJEdKy77GqTpYqGWhHSJOCO0IP268MwBzIv5grOH/m9SLLQWRlSG9npwJaSsmksZWuFZJAQ7Pr73
	X4kgslKrPkIkAysxMevA2xaais+oHo62anI0wai1Ts9zlakEmtDQb54lEZB95uJpTi7whrbvvEAbh
	+/9e7oyk+QLofPw/CO7YnmVirU8An9vGyKMvXWRO/awwEKPGQVLRWUdRSPgGOwSHlfWvEH4jecpnn
	C6e24nbQaEMYJIEKCLgRTTzSnWybQfLuLx507t5OuaQl+3pLxJaMEXl7fXuXHeFSAaVEGUixPPsln
	LskR23eg==;
Received: from mail-lj1-x231.google.com ([2a00:1450:4864:20::231])
	by desiato.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uUMoN-00000005lCU-2NAB;
	Wed, 25 Jun 2025 09:53:01 +0000
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-3105ef2a071so76650941fa.1;
        Wed, 25 Jun 2025 02:52:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750845177; x=1751449977; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=spnPWYrTCugBtv3C0I1/Y7oTbF6XlJIePRXoFmRkZ78=;
        b=X+Fvoost4wUmAW6h4dj/2iELpxrCy/g/7UtBxoGq1cBtBx7E3RbaXrR24V89Sa+ru1
         hQffWJvy+Zb8Z80iczOKWXwR2m3JmGvfdnNv0DJ+T/s5XvlCnUzLUKdNgjnITwiYC3kk
         y6wlnj2lCfnNUqF46P0WsBpHy4NwLcsmniRy9c0kXyqE6/WyFH9oJ/IzTcLxeBhvdCLg
         5GUYHj4WOJkJKil19axcIaxeAXXMh7Kuo+Z3SnJKwYd3BspusRdTV9H6gK8s381I2SC7
         UpeIAcS0/pgTv3cALztXRIJ7vX6M4ecRyS6qzAmcHrwaNYUHix0ZNus3m+vxbMoDOk0I
         U+BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750845177; x=1751449977;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=spnPWYrTCugBtv3C0I1/Y7oTbF6XlJIePRXoFmRkZ78=;
        b=K5FP69ymJr0y6RPuNZiNVxh0pilSf/DHamLF3/r/h/MCMx8w4erFZxdGo8GmAniPo0
         tzVJeUFxIabtmSgvVSEvq0arRdLiH4XLJ1WOgiFKFBwe0okVrESbrAZEI2GHfrCnfyKE
         7I+t5UftS4wgFHjeajY1EMKCeJ5NS/AYw0Zy9IqQ87cr1M7Dn8sS3NUxfRWM127NGxwC
         mV1NRdUnIufFo6dW+j7eTeFFlSeRd38WZoLLxrQu9I5zPVknCy8GHwemMwEWJgvJPhoy
         ASbK0RKCT3j5K3koO+CQVkH8ewRvbdsH8hk/6S4iPuSeEV/Di5zBl3Gy5U8hv6SQz+BZ
         i8Bg==
X-Forwarded-Encrypted: i=1; AJvYcCVR5KUneXud13AlWYuFehT4kj+/Lgpi5O3ZeEOv1xdSI0rQsf/4aW0x6zPw8WyVd3Tm3PLw4j3uqRCpDejJ5qvM@lists.infradead.org, AJvYcCVX1rl1R9D43VR8hMek7xcGRSVJMcxjE643065Pz0Du1zir6AqaqGXOitVJ81N1ZrFiNnlF/b1Q7D4=@lists.infradead.org
X-Gm-Message-State: AOJu0YzLne86dVDpMa4O4QJ+rmHiNLLVBnH94Ev9lJymoH1uavkX6dlf
	nNl+eq8U0fie6fYVH4mrj7lLl6BrCL5t9r2p5HMM6zSrGjan4iir5QPr
X-Gm-Gg: ASbGncv55pOd7Qpw76KFE7LUEN1k/NXkB5boXAmM2c9Rh/ld81bkOqhrKFF1Jm/1lD0
	6I7S2An00m1SJ2SDThjYFnp6nUpscfnJAEYb+P/H3+Kvlpweb/ki/3V7YBkKkskJaWZPtK4MUk1
	6CS7VsHyvPQnaOIZzwOJ/RehVmeyHZi2K/mV70JcoZd3fskYDWuMHqWOq4Nwucv6PUrJrR+jevt
	iBEGNXtGTCYKgVJRERzoApt6/lVmkHmdadXyUa/8Xl33cq0GhRRZetbHmNomvorkUGaUleZwYau
	7fO+9RehWdEqEkBOoegg+EcXJEFLx1LZmHmN4KAHH92TrsP6KvuJCDUqrqnLvY1AL/xh4l1Iz+g
	y86AS4kSbqlQcEEWq0lGv8Vy+mVYsbg==
X-Google-Smtp-Source: AGHT+IF6eiwi1xoALYtMAE1ncL4ibtGAQqo+HifrEVfcQXGb5lhuCkRcCK0fus3Knli+XAnux0nRaA==
X-Received: by 2002:a2e:7806:0:b0:32c:a709:80ee with SMTP id 38308e7fff4ca-32cc6582a2emr4097091fa.39.1750845177105;
        Wed, 25 Jun 2025 02:52:57 -0700 (PDT)
Received: from localhost.localdomain (2.135.54.165.dynamic.telecom.kz. [2.135.54.165])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-32b980a36c0sm19311851fa.62.2025.06.25.02.52.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 02:52:56 -0700 (PDT)
From: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
To: ryabinin.a.a@gmail.com,
	glider@google.com,
	andreyknvl@gmail.com,
	dvyukov@google.com,
	vincenzo.frascino@arm.com,
	catalin.marinas@arm.com,
	will@kernel.org,
	chenhuacai@kernel.org,
	kernel@xen0n.name,
	maddy@linux.ibm.com,
	mpe@ellerman.id.au,
	npiggin@gmail.com,
	christophe.leroy@csgroup.eu,
	hca@linux.ibm.com,
	gor@linux.ibm.com,
	agordeev@linux.ibm.com,
	borntraeger@linux.ibm.com,
	svens@linux.ibm.com,
	richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net,
	dave.hansen@linux.intel.com,
	luto@kernel.org,
	peterz@infradead.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	x86@kernel.org,
	hpa@zytor.com,
	chris@zankel.net,
	jcmvbkbc@gmail.com,
	akpm@linux-foundation.org
Cc: guoweikang.kernel@gmail.com,
	geert@linux-m68k.org,
	rppt@kernel.org,
	tiwei.btw@antgroup.com,
	richard.weiyang@gmail.com,
	benjamin.berg@intel.com,
	kevin.brodsky@arm.com,
	kasan-dev@googlegroups.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev,
	linuxppc-dev@lists.ozlabs.org,
	linux-s390@vger.kernel.org,
	linux-um@lists.infradead.org,
	linux-mm@kvack.org,
	snovitoll@gmail.com
Subject: [PATCH 2/9] kasan: replace kasan_arch_is_ready with kasan_enabled
Date: Wed, 25 Jun 2025 14:52:17 +0500
Message-Id: <20250625095224.118679-3-snovitoll@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250625095224.118679-1-snovitoll@gmail.com>
References: <20250625095224.118679-1-snovitoll@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250625_105259_704940_3206025B 
X-CRM114-Status: GOOD (  14.25  )
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

Replace the existing kasan_arch_is_ready() calls with kasan_enabled().
Drop checks where the caller is already under kasan_enabled() condition.

Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218315
Signed-off-by: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
---
 mm/kasan/common.c  |  8 ++++----
 mm/kasan/generic.c |  6 +++---
 mm/kasan/kasan.h   |  6 ------
 mm/kasan/shadow.c  | 15 +++------------
 4 files changed, 10 insertions(+), 25 deletions(-)

diff --git a/mm/kasan/common.c b/mm/kasan/common.c
index 525194da25f..0f3648335a6 100644
--- a/mm/kasan/common.c
+++ b/mm/kasan/common.c
@@ -257,7 +257,7 @@ static inline void poison_slab_object(struct kmem_cache *cache, void *object,
 bool __kasan_slab_pre_free(struct kmem_cache *cache, void *object,
 				unsigned long ip)
 {
-	if (!kasan_arch_is_ready() || is_kfence_address(object))
+	if (!kasan_enabled() || is_kfence_address(object))
 		return false;
 	return check_slab_allocation(cache, object, ip);
 }
@@ -265,7 +265,7 @@ bool __kasan_slab_pre_free(struct kmem_cache *cache, void *object,
 bool __kasan_slab_free(struct kmem_cache *cache, void *object, bool init,
 		       bool still_accessible)
 {
-	if (!kasan_arch_is_ready() || is_kfence_address(object))
+	if (!kasan_enabled() || is_kfence_address(object))
 		return false;
 
 	poison_slab_object(cache, object, init, still_accessible);
@@ -289,7 +289,7 @@ bool __kasan_slab_free(struct kmem_cache *cache, void *object, bool init,
 
 static inline bool check_page_allocation(void *ptr, unsigned long ip)
 {
-	if (!kasan_arch_is_ready())
+	if (!kasan_enabled())
 		return false;
 
 	if (ptr != page_address(virt_to_head_page(ptr))) {
@@ -518,7 +518,7 @@ bool __kasan_mempool_poison_object(void *ptr, unsigned long ip)
 		return true;
 	}
 
-	if (is_kfence_address(ptr) || !kasan_arch_is_ready())
+	if (is_kfence_address(ptr) || !kasan_enabled())
 		return true;
 
 	slab = folio_slab(folio);
diff --git a/mm/kasan/generic.c b/mm/kasan/generic.c
index ab9ab30caf4..af2f2077a45 100644
--- a/mm/kasan/generic.c
+++ b/mm/kasan/generic.c
@@ -176,7 +176,7 @@ static __always_inline bool check_region_inline(const void *addr,
 						size_t size, bool write,
 						unsigned long ret_ip)
 {
-	if (!kasan_arch_is_ready())
+	if (!kasan_enabled())
 		return true;
 
 	if (unlikely(size == 0))
@@ -204,7 +204,7 @@ bool kasan_byte_accessible(const void *addr)
 {
 	s8 shadow_byte;
 
-	if (!kasan_arch_is_ready())
+	if (!kasan_enabled())
 		return true;
 
 	shadow_byte = READ_ONCE(*(s8 *)kasan_mem_to_shadow(addr));
@@ -506,7 +506,7 @@ static void release_alloc_meta(struct kasan_alloc_meta *meta)
 
 static void release_free_meta(const void *object, struct kasan_free_meta *meta)
 {
-	if (!kasan_arch_is_ready())
+	if (!kasan_enabled())
 		return;
 
 	/* Check if free meta is valid. */
diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
index 129178be5e6..e0ffc16495d 100644
--- a/mm/kasan/kasan.h
+++ b/mm/kasan/kasan.h
@@ -544,12 +544,6 @@ static inline void kasan_poison_last_granule(const void *address, size_t size) {
 
 #endif /* CONFIG_KASAN_GENERIC */
 
-#ifndef kasan_arch_is_ready
-static inline bool kasan_arch_is_ready(void)	{ return true; }
-#elif !defined(CONFIG_KASAN_GENERIC) || !defined(CONFIG_KASAN_OUTLINE)
-#error kasan_arch_is_ready only works in KASAN generic outline mode!
-#endif
-
 #if IS_ENABLED(CONFIG_KASAN_KUNIT_TEST)
 
 void kasan_kunit_test_suite_start(void);
diff --git a/mm/kasan/shadow.c b/mm/kasan/shadow.c
index d2c70cd2afb..9db8548ccb4 100644
--- a/mm/kasan/shadow.c
+++ b/mm/kasan/shadow.c
@@ -125,7 +125,7 @@ void kasan_poison(const void *addr, size_t size, u8 value, bool init)
 {
 	void *shadow_start, *shadow_end;
 
-	if (!kasan_arch_is_ready())
+	if (!kasan_enabled())
 		return;
 
 	/*
@@ -150,9 +150,6 @@ EXPORT_SYMBOL_GPL(kasan_poison);
 #ifdef CONFIG_KASAN_GENERIC
 void kasan_poison_last_granule(const void *addr, size_t size)
 {
-	if (!kasan_arch_is_ready())
-		return;
-
 	if (size & KASAN_GRANULE_MASK) {
 		u8 *shadow = (u8 *)kasan_mem_to_shadow(addr + size);
 		*shadow = size & KASAN_GRANULE_MASK;
@@ -390,7 +387,7 @@ int kasan_populate_vmalloc(unsigned long addr, unsigned long size)
 	unsigned long shadow_start, shadow_end;
 	int ret;
 
-	if (!kasan_arch_is_ready())
+	if (!kasan_enabled())
 		return 0;
 
 	if (!is_vmalloc_or_module_addr((void *)addr))
@@ -560,7 +557,7 @@ void kasan_release_vmalloc(unsigned long start, unsigned long end,
 	unsigned long region_start, region_end;
 	unsigned long size;
 
-	if (!kasan_arch_is_ready())
+	if (!kasan_enabled())
 		return;
 
 	region_start = ALIGN(start, KASAN_MEMORY_PER_SHADOW_PAGE);
@@ -611,9 +608,6 @@ void *__kasan_unpoison_vmalloc(const void *start, unsigned long size,
 	 * with setting memory tags, so the KASAN_VMALLOC_INIT flag is ignored.
 	 */
 
-	if (!kasan_arch_is_ready())
-		return (void *)start;
-
 	if (!is_vmalloc_or_module_addr(start))
 		return (void *)start;
 
@@ -636,9 +630,6 @@ void *__kasan_unpoison_vmalloc(const void *start, unsigned long size,
  */
 void __kasan_poison_vmalloc(const void *start, unsigned long size)
 {
-	if (!kasan_arch_is_ready())
-		return;
-
 	if (!is_vmalloc_or_module_addr(start))
 		return;
 
-- 
2.34.1


