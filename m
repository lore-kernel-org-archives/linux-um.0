Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC830C83F1A
	for <linux-um@archiver.kernel.org>; Thu, 17 Jul 2025 15:03:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=f7ZdWtvjGwx1QVMejTFRuKlxOMwOJa4SlH8rLzpLr/Q=; b=fzWGFsTJtCR04UFB1ZxarosA/A
	L2/1g8pIiitJvjdfARPuRT+z0yOf2YNIeRnXQ84dA4X+XqZYPPMHIy7xC9HZlcnBZhenaQoXL2/nf
	8EbB354VsXnKoBj4jRq0TKR5i1xRfSxHwMMOgBoMMDw628cMo5KRB84qFtR6NRcYHPaYVnTRPl31m
	cxqwcrqujsdrFupHYlG808bZ74EyfOzCb7TsEn5yhOIvPrl02w2lUKiK9SURZf1kbMu9fCm2eIiSf
	rolm6H41DbRtUWobrM5YWLrFA/OVI5kGWhcoEIY5edtZrtOFbofBi3jM7EKPe3dNAH/UyA8k/Gg98
	WMWQTqIQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ucQ9J-0000000ASXt-0jbs;
	Thu, 17 Jul 2025 15:03:53 +0000
Received: from mail-lf1-x134.google.com ([2a00:1450:4864:20::134])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ucPav-0000000ANEK-269J;
	Thu, 17 Jul 2025 14:28:23 +0000
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-558f7fda97eso784819e87.2;
        Thu, 17 Jul 2025 07:28:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752762500; x=1753367300; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f7ZdWtvjGwx1QVMejTFRuKlxOMwOJa4SlH8rLzpLr/Q=;
        b=jnZtf8WwwCFE+fSV7bM24YuI/rydRjDMb5jsH090fx8FyoYxMySx/18jwip9XIDmnZ
         bcvAWpxQWvbSQwM7UIbMpaStLw2EsR1KjE7SXzHXbtdPCtbVmpaTq/SSRHS4O+d0sqVU
         h++62laXxiCN0jm+NFOUjgt/XSPHtns82m+bLASmSITLUMAIW5ODgebnd4xh7ud9uJMD
         1XAcWNNTG484yg1HT8ecASRRgYIa3uS6Aix82sMqje08VRNOt8K2cJqqqzqECV/vPjM+
         477+vLeohRkTilAO5MMn/L/b3QUhwU+0pDEFt6DqisfHtDv6uZPDiozlnbGwHh6b0EL2
         i6Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752762500; x=1753367300;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f7ZdWtvjGwx1QVMejTFRuKlxOMwOJa4SlH8rLzpLr/Q=;
        b=OE3Xoxw4uRyhhHBG0HNjDtAltlrlQitH2+pcatpu0a/BtqYTFLEaQXUDOZQ8fjRjYe
         /xapvFkSlHfFq2MDnTFmuHugxPgQ9fcSBr3GOe59mLhdBYb62AvrT1wc+RPO1+CQBS8T
         B0Kt66T8pxmWIz99UBp+fk2WDHLyiEJae9udLmLlSA16ZVe2LtXEwReKJfNb4MiFkqrW
         StamtLY4rwTHY9z6mJnw+fFfbChLOzNB+QiysfWkU8/hGAe+mAqkTRTsNOZ58LWMiVAD
         RrF/y4YnCQRE/Z/w+w7sBvHJXl6MBEY6jW6WW+sJJhCOy32Up4ch4SsD97dXxKjSaud0
         wVtw==
X-Forwarded-Encrypted: i=1; AJvYcCWIJWGrCZ8GOYYJ+Uo/kaxEWmDx+urpACKCGaWa+5dZZrd15g9W22YhzPr2CoIuEa3Hxef2+tlywDk=@lists.infradead.org, AJvYcCX8wqZoXaqAtVJI9dTnNEfgqwkBkHiNdGBoK9IKFQzcoODngshWQv48QU3pLuxoL9uln62+UO2/vS+9Uw==@lists.infradead.org
X-Gm-Message-State: AOJu0YzIDRqrxWYfg4HIdtimVnRqNxdiKms9iMmDVecPApFkkhhjkomg
	hhiz8D9JY/avMLNzOfBfwzpaLCIoEKdgt+XKv+OeK9TOqmjG9OhVDV9b
X-Gm-Gg: ASbGncuRKqX8pyx6T2y6JHzmPwz/zB3W3QnsW2/x4lNKkK74jz5b7F0dCrEANuEzyVu
	OpWa6MVYoVskafEYt1PiaxyC1dKMg4hxYC3nmPDxe8g8EMj9gFzh9fXvlEeR8L+5uy1XYhhjcKN
	rrfG3E3f2fq3EXG7eQ7QoPaogyI9r0Bd2qogvQakWovS05qds8Qf7ztAztBiCeUbBPwWE90hB8Y
	yicJGgkEkOiEdpEZj6CyUDdMKzCbKZW/rDmV2/ky763hCfQ9tAuYCvlq3uYViZ5UvA8V8sObRae
	ZMafp5hVqG7vs25yxN00gQBhVy1asYwE24OJ4Q2wXVtfp57TDPnHx5CwOtHXfaPUEDmnfefbfVl
	AI4HQxaDXKvObbWtdAQ+bDledpMog8j0nwEBrk+ESIdeCQBd5kshp+p2DYWHRHVs6E7qY
X-Google-Smtp-Source: AGHT+IGCxJLgxZY02tc8foSIT/rHsNNpSknOWUP3l3DGsuRGAuDE+1eyiieQPzZhElaS9ma13LLajg==
X-Received: by 2002:a05:6512:2345:b0:558:f7fc:87c4 with SMTP id 2adb3069b0e04-55a23f7fc98mr2461079e87.32.1752762499563;
        Thu, 17 Jul 2025 07:28:19 -0700 (PDT)
Received: from localhost.localdomain (178.90.89.143.dynamic.telecom.kz. [178.90.89.143])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55989825fe3sm3022975e87.223.2025.07.17.07.28.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 07:28:18 -0700 (PDT)
From: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
To: hca@linux.ibm.com,
	christophe.leroy@csgroup.eu,
	andreyknvl@gmail.com,
	agordeev@linux.ibm.com,
	akpm@linux-foundation.org
Cc: ryabinin.a.a@gmail.com,
	glider@google.com,
	dvyukov@google.com,
	kasan-dev@googlegroups.com,
	linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev,
	linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	linux-um@lists.infradead.org,
	linux-mm@kvack.org,
	snovitoll@gmail.com
Subject: [PATCH v3 12/12] kasan: add shadow checks to wrappers and rename kasan_arch_is_ready
Date: Thu, 17 Jul 2025 19:27:32 +0500
Message-Id: <20250717142732.292822-13-snovitoll@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250717142732.292822-1-snovitoll@gmail.com>
References: <20250717142732.292822-1-snovitoll@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250717_072821_676911_3216FA0C 
X-CRM114-Status: GOOD (  15.50  )
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

This patch completes:
1. Adding kasan_shadow_initialized() checks to existing wrapper functions
2. Replacing kasan_arch_is_ready() calls with kasan_shadow_initialized()
3. Creating wrapper functions for internal functions that need shadow
   readiness checks
4. Removing the kasan_arch_is_ready() fallback definition

The two-level approach is now fully implemented:
- kasan_enabled() - controls whether KASAN is enabled at all.
  (compile-time for most archs)
- kasan_shadow_initialized() - tracks shadow memory initialization
  (static key for ARCH_DEFER_KASAN archs, compile-time for others)

This provides complete elimination of kasan_arch_is_ready() calls from
KASAN implementation while moving all shadow readiness logic to
wrapper functions.

Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217049
Signed-off-by: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
---
Changes in v3:
- Addresses Andrey's feedback to move shadow checks to wrappers
- Rename kasan_arch_is_ready with kasan_shadow_initialized
- Added kasan_shadow_initialized() checks to all necessary wrapper functions
- Eliminated all remaining kasan_arch_is_ready() usage per reviewer guidance
---
 include/linux/kasan.h | 36 +++++++++++++++++++++++++++---------
 mm/kasan/common.c     |  9 +++------
 mm/kasan/generic.c    | 12 +++---------
 mm/kasan/kasan.h      | 36 ++++++++++++++++++++++++++----------
 mm/kasan/shadow.c     | 32 +++++++-------------------------
 5 files changed, 66 insertions(+), 59 deletions(-)

diff --git a/include/linux/kasan.h b/include/linux/kasan.h
index 51a8293d1af..292bd741d8d 100644
--- a/include/linux/kasan.h
+++ b/include/linux/kasan.h
@@ -194,7 +194,7 @@ bool __kasan_slab_pre_free(struct kmem_cache *s, void *object,
 static __always_inline bool kasan_slab_pre_free(struct kmem_cache *s,
 						void *object)
 {
-	if (kasan_enabled())
+	if (kasan_enabled() && kasan_shadow_initialized())
 		return __kasan_slab_pre_free(s, object, _RET_IP_);
 	return false;
 }
@@ -229,7 +229,7 @@ static __always_inline bool kasan_slab_free(struct kmem_cache *s,
 						void *object, bool init,
 						bool still_accessible)
 {
-	if (kasan_enabled())
+	if (kasan_enabled() && kasan_shadow_initialized())
 		return __kasan_slab_free(s, object, init, still_accessible);
 	return false;
 }
@@ -237,7 +237,7 @@ static __always_inline bool kasan_slab_free(struct kmem_cache *s,
 void __kasan_kfree_large(void *ptr, unsigned long ip);
 static __always_inline void kasan_kfree_large(void *ptr)
 {
-	if (kasan_enabled())
+	if (kasan_enabled() && kasan_shadow_initialized())
 		__kasan_kfree_large(ptr, _RET_IP_);
 }
 
@@ -302,7 +302,7 @@ bool __kasan_mempool_poison_pages(struct page *page, unsigned int order,
 static __always_inline bool kasan_mempool_poison_pages(struct page *page,
 						       unsigned int order)
 {
-	if (kasan_enabled())
+	if (kasan_enabled() && kasan_shadow_initialized())
 		return __kasan_mempool_poison_pages(page, order, _RET_IP_);
 	return true;
 }
@@ -356,7 +356,7 @@ bool __kasan_mempool_poison_object(void *ptr, unsigned long ip);
  */
 static __always_inline bool kasan_mempool_poison_object(void *ptr)
 {
-	if (kasan_enabled())
+	if (kasan_enabled() && kasan_shadow_initialized())
 		return __kasan_mempool_poison_object(ptr, _RET_IP_);
 	return true;
 }
@@ -568,11 +568,29 @@ static inline void kasan_init_hw_tags(void) { }
 #if defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS)
 
 void kasan_populate_early_vm_area_shadow(void *start, unsigned long size);
-int kasan_populate_vmalloc(unsigned long addr, unsigned long size);
-void kasan_release_vmalloc(unsigned long start, unsigned long end,
+
+int __kasan_populate_vmalloc(unsigned long addr, unsigned long size);
+static inline int kasan_populate_vmalloc(unsigned long addr, unsigned long size)
+{
+	if (!kasan_shadow_initialized())
+		return 0;
+	return __kasan_populate_vmalloc(addr, size);
+}
+
+void __kasan_release_vmalloc(unsigned long start, unsigned long end,
 			   unsigned long free_region_start,
 			   unsigned long free_region_end,
 			   unsigned long flags);
+static inline void kasan_release_vmalloc(unsigned long start,
+			   unsigned long end,
+			   unsigned long free_region_start,
+			   unsigned long free_region_end,
+			   unsigned long flags)
+{
+	if (kasan_shadow_initialized())
+		__kasan_release_vmalloc(start, end, free_region_start,
+			   free_region_end, flags);
+}
 
 #else /* CONFIG_KASAN_GENERIC || CONFIG_KASAN_SW_TAGS */
 
@@ -598,7 +616,7 @@ static __always_inline void *kasan_unpoison_vmalloc(const void *start,
 						unsigned long size,
 						kasan_vmalloc_flags_t flags)
 {
-	if (kasan_enabled())
+	if (kasan_enabled() && kasan_shadow_initialized())
 		return __kasan_unpoison_vmalloc(start, size, flags);
 	return (void *)start;
 }
@@ -607,7 +625,7 @@ void __kasan_poison_vmalloc(const void *start, unsigned long size);
 static __always_inline void kasan_poison_vmalloc(const void *start,
 						 unsigned long size)
 {
-	if (kasan_enabled())
+	if (kasan_enabled() && kasan_shadow_initialized())
 		__kasan_poison_vmalloc(start, size);
 }
 
diff --git a/mm/kasan/common.c b/mm/kasan/common.c
index c3a6446404d..b561734767d 100644
--- a/mm/kasan/common.c
+++ b/mm/kasan/common.c
@@ -259,7 +259,7 @@ static inline void poison_slab_object(struct kmem_cache *cache, void *object,
 bool __kasan_slab_pre_free(struct kmem_cache *cache, void *object,
 				unsigned long ip)
 {
-	if (!kasan_arch_is_ready() || is_kfence_address(object))
+	if (is_kfence_address(object))
 		return false;
 	return check_slab_allocation(cache, object, ip);
 }
@@ -267,7 +267,7 @@ bool __kasan_slab_pre_free(struct kmem_cache *cache, void *object,
 bool __kasan_slab_free(struct kmem_cache *cache, void *object, bool init,
 		       bool still_accessible)
 {
-	if (!kasan_arch_is_ready() || is_kfence_address(object))
+	if (is_kfence_address(object))
 		return false;
 
 	poison_slab_object(cache, object, init, still_accessible);
@@ -291,9 +291,6 @@ bool __kasan_slab_free(struct kmem_cache *cache, void *object, bool init,
 
 static inline bool check_page_allocation(void *ptr, unsigned long ip)
 {
-	if (!kasan_arch_is_ready())
-		return false;
-
 	if (ptr != page_address(virt_to_head_page(ptr))) {
 		kasan_report_invalid_free(ptr, ip, KASAN_REPORT_INVALID_FREE);
 		return true;
@@ -520,7 +517,7 @@ bool __kasan_mempool_poison_object(void *ptr, unsigned long ip)
 		return true;
 	}
 
-	if (is_kfence_address(ptr) || !kasan_arch_is_ready())
+	if (is_kfence_address(ptr))
 		return true;
 
 	slab = folio_slab(folio);
diff --git a/mm/kasan/generic.c b/mm/kasan/generic.c
index 03b6d322ff6..1d20b925b9d 100644
--- a/mm/kasan/generic.c
+++ b/mm/kasan/generic.c
@@ -176,7 +176,7 @@ static __always_inline bool check_region_inline(const void *addr,
 						size_t size, bool write,
 						unsigned long ret_ip)
 {
-	if (!kasan_arch_is_ready())
+	if (!kasan_shadow_initialized())
 		return true;
 
 	if (unlikely(size == 0))
@@ -200,13 +200,10 @@ bool kasan_check_range(const void *addr, size_t size, bool write,
 	return check_region_inline(addr, size, write, ret_ip);
 }
 
-bool kasan_byte_accessible(const void *addr)
+bool __kasan_byte_accessible(const void *addr)
 {
 	s8 shadow_byte;
 
-	if (!kasan_arch_is_ready())
-		return true;
-
 	shadow_byte = READ_ONCE(*(s8 *)kasan_mem_to_shadow(addr));
 
 	return shadow_byte >= 0 && shadow_byte < KASAN_GRANULE_SIZE;
@@ -506,9 +503,6 @@ static void release_alloc_meta(struct kasan_alloc_meta *meta)
 
 static void release_free_meta(const void *object, struct kasan_free_meta *meta)
 {
-	if (!kasan_arch_is_ready())
-		return;
-
 	/* Check if free meta is valid. */
 	if (*(u8 *)kasan_mem_to_shadow(object) != KASAN_SLAB_FREE_META)
 		return;
@@ -573,7 +567,7 @@ void kasan_save_alloc_info(struct kmem_cache *cache, void *object, gfp_t flags)
 	kasan_save_track(&alloc_meta->alloc_track, flags);
 }
 
-void kasan_save_free_info(struct kmem_cache *cache, void *object)
+void __kasan_save_free_info(struct kmem_cache *cache, void *object)
 {
 	struct kasan_free_meta *free_meta;
 
diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
index 129178be5e6..67a0a1095d2 100644
--- a/mm/kasan/kasan.h
+++ b/mm/kasan/kasan.h
@@ -398,7 +398,13 @@ depot_stack_handle_t kasan_save_stack(gfp_t flags, depot_flags_t depot_flags);
 void kasan_set_track(struct kasan_track *track, depot_stack_handle_t stack);
 void kasan_save_track(struct kasan_track *track, gfp_t flags);
 void kasan_save_alloc_info(struct kmem_cache *cache, void *object, gfp_t flags);
-void kasan_save_free_info(struct kmem_cache *cache, void *object);
+
+void __kasan_save_free_info(struct kmem_cache *cache, void *object);
+static inline void kasan_save_free_info(struct kmem_cache *cache, void *object)
+{
+	if (kasan_enabled() && kasan_shadow_initialized())
+		__kasan_save_free_info(cache, object);
+}
 
 #ifdef CONFIG_KASAN_GENERIC
 bool kasan_quarantine_put(struct kmem_cache *cache, void *object);
@@ -499,6 +505,7 @@ static inline bool kasan_byte_accessible(const void *addr)
 
 #else /* CONFIG_KASAN_HW_TAGS */
 
+void __kasan_poison(const void *addr, size_t size, u8 value, bool init);
 /**
  * kasan_poison - mark the memory range as inaccessible
  * @addr: range start address, must be aligned to KASAN_GRANULE_SIZE
@@ -506,7 +513,11 @@ static inline bool kasan_byte_accessible(const void *addr)
  * @value: value that's written to metadata for the range
  * @init: whether to initialize the memory range (only for hardware tag-based)
  */
-void kasan_poison(const void *addr, size_t size, u8 value, bool init);
+static inline void kasan_poison(const void *addr, size_t size, u8 value, bool init)
+{
+	if (kasan_shadow_initialized())
+		__kasan_poison(addr, size, value, init);
+}
 
 /**
  * kasan_unpoison - mark the memory range as accessible
@@ -521,12 +532,19 @@ void kasan_poison(const void *addr, size_t size, u8 value, bool init);
  */
 void kasan_unpoison(const void *addr, size_t size, bool init);
 
-bool kasan_byte_accessible(const void *addr);
+bool __kasan_byte_accessible(const void *addr);
+static inline bool kasan_byte_accessible(const void *addr)
+{
+	if (!kasan_shadow_initialized())
+		return true;
+	return __kasan_byte_accessible(addr);
+}
 
 #endif /* CONFIG_KASAN_HW_TAGS */
 
 #ifdef CONFIG_KASAN_GENERIC
 
+void __kasan_poison_last_granule(const void *address, size_t size);
 /**
  * kasan_poison_last_granule - mark the last granule of the memory range as
  * inaccessible
@@ -536,7 +554,11 @@ bool kasan_byte_accessible(const void *addr);
  * This function is only available for the generic mode, as it's the only mode
  * that has partially poisoned memory granules.
  */
-void kasan_poison_last_granule(const void *address, size_t size);
+static inline void kasan_poison_last_granule(const void *address, size_t size)
+{
+	if (kasan_shadow_initialized())
+		__kasan_poison_last_granule(address, size);
+}
 
 #else /* CONFIG_KASAN_GENERIC */
 
@@ -544,12 +566,6 @@ static inline void kasan_poison_last_granule(const void *address, size_t size) {
 
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
index d2c70cd2afb..90c508cad63 100644
--- a/mm/kasan/shadow.c
+++ b/mm/kasan/shadow.c
@@ -121,13 +121,10 @@ void *__hwasan_memcpy(void *dest, const void *src, ssize_t len) __alias(__asan_m
 EXPORT_SYMBOL(__hwasan_memcpy);
 #endif
 
-void kasan_poison(const void *addr, size_t size, u8 value, bool init)
+void __kasan_poison(const void *addr, size_t size, u8 value, bool init)
 {
 	void *shadow_start, *shadow_end;
 
-	if (!kasan_arch_is_ready())
-		return;
-
 	/*
 	 * Perform shadow offset calculation based on untagged address, as
 	 * some of the callers (e.g. kasan_poison_new_object) pass tagged
@@ -145,14 +142,11 @@ void kasan_poison(const void *addr, size_t size, u8 value, bool init)
 
 	__memset(shadow_start, value, shadow_end - shadow_start);
 }
-EXPORT_SYMBOL_GPL(kasan_poison);
+EXPORT_SYMBOL_GPL(__kasan_poison);
 
 #ifdef CONFIG_KASAN_GENERIC
-void kasan_poison_last_granule(const void *addr, size_t size)
+void __kasan_poison_last_granule(const void *addr, size_t size)
 {
-	if (!kasan_arch_is_ready())
-		return;
-
 	if (size & KASAN_GRANULE_MASK) {
 		u8 *shadow = (u8 *)kasan_mem_to_shadow(addr + size);
 		*shadow = size & KASAN_GRANULE_MASK;
@@ -353,7 +347,7 @@ static int ___alloc_pages_bulk(struct page **pages, int nr_pages)
 	return 0;
 }
 
-static int __kasan_populate_vmalloc(unsigned long start, unsigned long end)
+static int __kasan_populate_vmalloc_do(unsigned long start, unsigned long end)
 {
 	unsigned long nr_pages, nr_total = PFN_UP(end - start);
 	struct vmalloc_populate_data data;
@@ -385,14 +379,11 @@ static int __kasan_populate_vmalloc(unsigned long start, unsigned long end)
 	return ret;
 }
 
-int kasan_populate_vmalloc(unsigned long addr, unsigned long size)
+int __kasan_populate_vmalloc(unsigned long addr, unsigned long size)
 {
 	unsigned long shadow_start, shadow_end;
 	int ret;
 
-	if (!kasan_arch_is_ready())
-		return 0;
-
 	if (!is_vmalloc_or_module_addr((void *)addr))
 		return 0;
 
@@ -414,7 +405,7 @@ int kasan_populate_vmalloc(unsigned long addr, unsigned long size)
 	shadow_start = PAGE_ALIGN_DOWN(shadow_start);
 	shadow_end = PAGE_ALIGN(shadow_end);
 
-	ret = __kasan_populate_vmalloc(shadow_start, shadow_end);
+	ret = __kasan_populate_vmalloc_do(shadow_start, shadow_end);
 	if (ret)
 		return ret;
 
@@ -551,7 +542,7 @@ static int kasan_depopulate_vmalloc_pte(pte_t *ptep, unsigned long addr,
  * pages entirely covered by the free region, we will not run in to any
  * trouble - any simultaneous allocations will be for disjoint regions.
  */
-void kasan_release_vmalloc(unsigned long start, unsigned long end,
+void __kasan_release_vmalloc(unsigned long start, unsigned long end,
 			   unsigned long free_region_start,
 			   unsigned long free_region_end,
 			   unsigned long flags)
@@ -560,9 +551,6 @@ void kasan_release_vmalloc(unsigned long start, unsigned long end,
 	unsigned long region_start, region_end;
 	unsigned long size;
 
-	if (!kasan_arch_is_ready())
-		return;
-
 	region_start = ALIGN(start, KASAN_MEMORY_PER_SHADOW_PAGE);
 	region_end = ALIGN_DOWN(end, KASAN_MEMORY_PER_SHADOW_PAGE);
 
@@ -611,9 +599,6 @@ void *__kasan_unpoison_vmalloc(const void *start, unsigned long size,
 	 * with setting memory tags, so the KASAN_VMALLOC_INIT flag is ignored.
 	 */
 
-	if (!kasan_arch_is_ready())
-		return (void *)start;
-
 	if (!is_vmalloc_or_module_addr(start))
 		return (void *)start;
 
@@ -636,9 +621,6 @@ void *__kasan_unpoison_vmalloc(const void *start, unsigned long size,
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


