Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6FB1C7EE30
	for <linux-um@archiver.kernel.org>; Thu, 26 Jun 2025 17:24:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+pDrLO6USAZl/TGsifgnkWPVKgGBnMCumXxL7y5KwTQ=; b=HVLG51tLVYZytjRVWJTjuhZ1Lz
	puJFD49sRcEm+A0w8/2dSPn7nFGr+DbCCZGiW129dQELdcTeNGbTCT+yIqG4AsiOBUlm/YqmMrJVx
	7AX2fbHyt91gP7V0Pz/EIIeHmQ0qTGcD+jrEVY/WojS/X3s8d3w9dnMzZQYSYtqieYdq5FdJrmkAS
	dcmOZ/vzgNvWAzNqvS7GI0rrh0p0T8qPeBPkWbqoWeLAFFvvcd9egsvNvf2Bn6yow8Z/Vjfgrw7xA
	o9QkcfWG3/DODCUJZa6MZQeHb0FlRd/i5tSKkCclizH8Q9wAUdlAA7hws1GudxihuyiCStW3YkMAw
	pudXW3tg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uUqKO-0000000CMf7-1cAu;
	Thu, 26 Jun 2025 17:24:00 +0000
Received: from mail-lf1-x12c.google.com ([2a00:1450:4864:20::12c])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uUobJ-0000000C8VZ-2GX5;
	Thu, 26 Jun 2025 15:33:22 +0000
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-553dceb345eso1130552e87.1;
        Thu, 26 Jun 2025 08:33:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750952000; x=1751556800; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+pDrLO6USAZl/TGsifgnkWPVKgGBnMCumXxL7y5KwTQ=;
        b=YcEgX2nzi1IPZcH72Uo8wHSOVzXb672yfL6QMvQvI4TkXvLVpP5ej+2ghqic50F38c
         arJq3iYwwXGe4XGo57iQmy0zxtMSlDMfl45H6FWm9xZ+Kg5PCba6bndu4ibASAqJV09h
         ysu24tmrAIcNyVmoUK0/P1AOKJGXMr79LNveMU6WyYhL09GxouCIJMRQA+p7oGof63Pd
         gNX/f7JS0ogHYKRwWl9QOtwUXsHS5q4G790hAYQQi1UBbjthC3Onl4nv/NA4uj73njAk
         j+hJ13PIgF4bb2VcSe+Lci7yRs4Mr0TgKfkVOi1EI5lUFyc73z3layqDUG3+CRH7tjTQ
         p/vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750952000; x=1751556800;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+pDrLO6USAZl/TGsifgnkWPVKgGBnMCumXxL7y5KwTQ=;
        b=EuTuVYaEPJ2TyIahvLkvlQp9tnry0OCWsETTseaMcT5OtHlK39CRO9Q4HsgnHrqNkG
         ugqrjmzGb9KRRLce1k3HtWz1jyysQ49CJRLRzYdQ3f0XxM0/vVaWrlyP2kDaGeOYL8lh
         u7ke5LfOSRhhU5eHHyAhgu+b0eNiI8inJijAHqfPEp++sKg4UsnQ16k8SFv4kBIpQmZt
         /j1N6HoZm2k5em/o52uVoSWWLz2AHJSY4K3CDeXOTsEt7xdn5xDcxECEUk0K+cXKCWWE
         EP4r35baz3yY2AgCByA/hfOwxG62ZuT0Qh8BcxZN+9Tm43F9TeVMALCxkIrfNoYDXkqt
         JO9A==
X-Forwarded-Encrypted: i=1; AJvYcCV52Rv0JjYcXtccf7VFf95i9DaUJcxr1DxLzL32lWgRPHOYK09ZsqAJxzqb4nBS/gXS91uKeMiEB0A=@lists.infradead.org, AJvYcCVGKaKzQN72C2Tb+BEgM6NG5VoQI06fC3rf4FGWxXGi6wI4OMzwt7O7cq26kb/AsnkcL48AUJd8urBkgvgbEyVD@lists.infradead.org, AJvYcCWL8UGr2L7hBZ+FILto7ajrZ+XtOPCqBqjfV/ESydzo1iUXMCXUuc+Kj15PTy9dIGMPlmCIa5jP/6i/GHI=@lists.infradead.org
X-Gm-Message-State: AOJu0YwHrAnKY00RM1Qj8/1UG7/ro5EV2kQkOkpBXebO3xZ96QtlWF07
	JkB4K/Lbq4brBE4niAWsEGG/CWWw3r4hSOR5aLMvLQ06BqmPL617tiIs
X-Gm-Gg: ASbGncvrAuEtQ78oJEonOvYSIA3tTj+xqWHL1kd95oE9YxxayK1H3u3JNerrlBPMrt4
	x5DGZqvWgdjYewT9ZhJr0NASvEiTWltC3INhHOGEvcb5tbe3tYej6PxIXLD2vTe1Dm988kXbin6
	FFrvPHPY/jPT3KD9V19jljeBDwxsX9n1NA9Ygt0aJqzc1HMTjszSYYxHo8ZFHMzncIyBAME88EL
	ksOrHx3eu9EL+Lu9ZnAWKopvsjTNOumMYzS51zqKS2F01btvyb9WMsueB7ev7oKHGWgzsouzXMS
	+DC8iVCNiQhNh6HkaEwAsemWUBwIS+yXccoBjExnflaqfA4Vc1dHn+eKM3JZf5BUYvwz7mk59Sg
	eSyEUapDzVYaf2iaFagSVmUAq4ovojg==
X-Google-Smtp-Source: AGHT+IGY311+Wdu3kb/XvX91pk/iQewvyeMEbYN3t0cf6Gst1F46Nt/0GHv4Ja5q8VZUcn9wuGuFjg==
X-Received: by 2002:a05:6512:12c2:b0:553:28f1:66ec with SMTP id 2adb3069b0e04-554fdd47009mr2940330e87.31.1750951999683;
        Thu, 26 Jun 2025 08:33:19 -0700 (PDT)
Received: from localhost.localdomain (2.135.54.165.dynamic.telecom.kz. [2.135.54.165])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5550b2ce1fasm42792e87.174.2025.06.26.08.33.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jun 2025 08:33:18 -0700 (PDT)
From: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
To: ryabinin.a.a@gmail.com,
	glider@google.com,
	andreyknvl@gmail.com,
	dvyukov@google.com,
	vincenzo.frascino@arm.com,
	linux@armlinux.org.uk,
	catalin.marinas@arm.com,
	will@kernel.org,
	chenhuacai@kernel.org,
	kernel@xen0n.name,
	maddy@linux.ibm.com,
	mpe@ellerman.id.au,
	npiggin@gmail.com,
	christophe.leroy@csgroup.eu,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
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
	akpm@linux-foundation.org,
	nathan@kernel.org,
	nick.desaulniers+lkml@gmail.com,
	morbo@google.com,
	justinstitt@google.com
Cc: arnd@arndb.de,
	rppt@kernel.org,
	geert@linux-m68k.org,
	mcgrof@kernel.org,
	guoweikang.kernel@gmail.com,
	tiwei.btw@antgroup.com,
	kevin.brodsky@arm.com,
	benjamin.berg@intel.com,
	kasan-dev@googlegroups.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev,
	linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	linux-um@lists.infradead.org,
	linux-mm@kvack.org,
	llvm@lists.linux.dev,
	snovitoll@gmail.com
Subject: [PATCH v2 11/11] kasan: replace kasan_arch_is_ready with kasan_enabled
Date: Thu, 26 Jun 2025 20:31:47 +0500
Message-Id: <20250626153147.145312-12-snovitoll@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250626153147.145312-1-snovitoll@gmail.com>
References: <20250626153147.145312-1-snovitoll@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250626_083321_678696_CD913A54 
X-CRM114-Status: GOOD (  15.06  )
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
 include/linux/kasan-enabled.h | 20 ++++++++++++--------
 mm/kasan/common.c             |  8 ++++----
 mm/kasan/generic.c            |  6 +++---
 mm/kasan/kasan.h              |  6 ------
 mm/kasan/shadow.c             | 15 +++------------
 5 files changed, 22 insertions(+), 33 deletions(-)

diff --git a/include/linux/kasan-enabled.h b/include/linux/kasan-enabled.h
index 2b1351c30c6..2436eb45cfe 100644
--- a/include/linux/kasan-enabled.h
+++ b/include/linux/kasan-enabled.h
@@ -5,32 +5,36 @@
 #include <linux/static_key.h>
 
 #ifdef CONFIG_KASAN
+
 /*
  * Global runtime flag. Starts ‘false’; switched to ‘true’ by
  * the appropriate kasan_init_*() once KASAN is fully initialized.
  */
 DECLARE_STATIC_KEY_FALSE(kasan_flag_enabled);
-#endif
-
-#ifdef CONFIG_KASAN_HW_TAGS
 
 static __always_inline bool kasan_enabled(void)
 {
 	return static_branch_likely(&kasan_flag_enabled);
 }
 
-static inline bool kasan_hw_tags_enabled(void)
+#else /* !CONFIG_KASAN */
+
+static __always_inline bool kasan_enabled(void)
 {
-	return kasan_enabled();
+	return false;
 }
 
-#else /* CONFIG_KASAN_HW_TAGS */
+#endif /* CONFIG_KASAN */
+
+#ifdef CONFIG_KASAN_HW_TAGS
 
-static inline bool kasan_enabled(void)
+static inline bool kasan_hw_tags_enabled(void)
 {
-	return IS_ENABLED(CONFIG_KASAN);
+	return kasan_enabled();
 }
 
+#else /* !CONFIG_KASAN_HW_TAGS */
+
 static inline bool kasan_hw_tags_enabled(void)
 {
 	return false;
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


