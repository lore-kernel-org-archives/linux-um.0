Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52F0DC83F3B
	for <linux-um@archiver.kernel.org>; Thu, 17 Jul 2025 15:03:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CtzrgmhXOlDN0Ac+5J9qvgdYRUcauOXxnB1y58JGUsg=; b=G9J1p1tWSC3IMC9xiJir0Rg46b
	s6dS81hr43v52OxAOrg+h15Url+ytRJfj9MtFSTDHykiLzchq5FeWqGyUfWqzp7sYKWU+zNyMPr0I
	/iipye2OMVkskcGwXTffsUbQ0MAtR75CW3eU0GP3Qxktavj5vhL0tmcycwjbRWXdza3vpgTZ9vnSZ
	dm7xRCotPDmXn9VRVmZnrlqHJx4z/ed5tOyDDmEB8mHuDvYOOd8eq0r//l0OCgHFhhEASd/3q2fTL
	nTLCKtx8WvFel30Xzjd4monqTWLnb9yEMoyZn+07j7BZZhUB+WFoMQ5MQLbsTho5mMFvzkALieWxc
	KtS1UFlg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ucQ8z-0000000AS8g-0Gbp;
	Thu, 17 Jul 2025 15:03:33 +0000
Received: from mail-lf1-x12c.google.com ([2a00:1450:4864:20::12c])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ucPaP-0000000AMwe-2kGf;
	Thu, 17 Jul 2025 14:27:51 +0000
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-553d52cb80dso1223049e87.1;
        Thu, 17 Jul 2025 07:27:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752762468; x=1753367268; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CtzrgmhXOlDN0Ac+5J9qvgdYRUcauOXxnB1y58JGUsg=;
        b=EM3C3OCUZW+O/y4AVpe3mHNHtGrWNrTt1NtKl3HoNHqD288swzEiXx2A86oAThcMkv
         b43RDCOFmiW86YnRJiWxGnrXCI2oVsevBRHsUsbnqIjnvWubBnQ6ynDezRkRlhumWIJO
         sOyJ7DaBeVlvBxQ+T/Kgh6wviQqVWAlskD2wvBOlBB/IBX9KrjmGlKgFf2+3HbELHhtZ
         Iaa7C1bXuzZHEsqiGhHLh/eYOnbHeEjJJImwxzrNjuiBCkWOsr9FaTsBa5pnpnS1+H5k
         39HPaj001Rh6VOs9vXO4zkjV8RuQFgfPF7iEs+Btkt1IUNr4KOMrfDVGLSKMmJ564cJ2
         28qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752762468; x=1753367268;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CtzrgmhXOlDN0Ac+5J9qvgdYRUcauOXxnB1y58JGUsg=;
        b=qJUp0cAt4/mLBanwQgbF63MKqFcWp0XhrylTlSvCCl6DSjuk0Trf+0Jxt9xqrZg2CR
         wSJa5zztq3YsCpNTbH2KHxsg5W3ImUP2HbW8/g6GCqUdMabzA5bQNonJqZ6Ik4ADmnSS
         X0hZkR7Fs8I+7xaa7ODSyaCWzwLP59yrvpk0WW1e6lIzKlQD/OUGrI1yrQ07gAnGC20+
         q1VZ0el0XjjlbKckxZvaitNx442cNb8yqb7tV4701CuR22OpoqIN6g09PRnTyiOlmH7i
         6Riq7yJ3BXXcFLvHqko62m7EpXopnSwZDmGSgr8DRcHi6KdeBktKkMB/llLZ28ZeUO/F
         7rkA==
X-Forwarded-Encrypted: i=1; AJvYcCUlmU3wbM/qNp9wsNB0Hh91zJlYgPk2OUCaab8sRe2FR0LBleow9n6MhIS0VN5IQQQtWimgRhs7gm8=@lists.infradead.org, AJvYcCXl2rGZ+LIiQDkGAzoiP4b0ZfQPAhDbdEKahcHUrR60GBBBfXe5EJtY4TirYc+IBTAMSfg566OnIUnalg==@lists.infradead.org
X-Gm-Message-State: AOJu0YxvIS30XB/BlX4fCaWqEhwJzgBgjmACbk1W6uF/P+zkZ1rAh5D5
	ZQH/2eE+/xl8NSgF1AiH7OAqp9P6/mLXuuHGj7pylA/3ZWaP6sCzloIs
X-Gm-Gg: ASbGnctG4V06WE0SUAynqf/7TtD6JemZfpvrvI19WkUnQaLtyd8fmQL34T5HMTc8Tt4
	CdS41CGZCoF5yKusTWtEeyjo2OMo/nrTuImpGv/hQ9NC7jQeW6NYGVsJgaVJUEi77zjF1CIfbFW
	NAJQ3KU8fdtLR/bp7GK1s1swTe4KU41B5nYwWrZEx8KClRdOD4ureVh7h5ChScwDyjP8dutcSTb
	lTVdaoViGsfqCyNiJyiJ407ngehee2cpXsODpjaej8GkmnOtE0kTbgJKLxC4mILdnTa5L40Rf5p
	EFas2EFqih1E8WiocKtjRvOheghBmJUJHlb6NWfxdQb8JTZEIXY6v023nvMhq8hq9B2bTF57813
	b3k4Q2HUYq9HFp5edtohSUm2NhBtOy1eJ0YYZFpX+Grc7Fam+FVcAXqyrYnXOmzagelqz
X-Google-Smtp-Source: AGHT+IGFU/9g3XHsICupAR2OwO3I+VhsbowqxnMbfcNePQa3z69BAqmHMKuwXCkJ+RRLdmWNcXslSQ==
X-Received: by 2002:a05:6512:1254:b0:553:2c01:ff4a with SMTP id 2adb3069b0e04-55a2fdd97dbmr24308e87.3.1752762467575;
        Thu, 17 Jul 2025 07:27:47 -0700 (PDT)
Received: from localhost.localdomain (178.90.89.143.dynamic.telecom.kz. [178.90.89.143])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55989825fe3sm3022975e87.223.2025.07.17.07.27.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 07:27:46 -0700 (PDT)
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
Subject: [PATCH v3 02/12] kasan: unify static kasan_flag_enabled across modes
Date: Thu, 17 Jul 2025 19:27:22 +0500
Message-Id: <20250717142732.292822-3-snovitoll@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250717142732.292822-1-snovitoll@gmail.com>
References: <20250717142732.292822-1-snovitoll@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250717_072749_692769_800F8A93 
X-CRM114-Status: GOOD (  16.24  )
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

Historically, the runtime static key kasan_flag_enabled existed only for
CONFIG_KASAN_HW_TAGS mode. Generic and SW_TAGS modes either relied on
architecture-specific kasan_arch_is_ready() implementations or evaluated
KASAN checks unconditionally, leading to code duplication.

This patch implements two-level approach:

1. kasan_enabled() - controls if KASAN is enabled at all (compile-time)
2. kasan_shadow_initialized() - tracks shadow memory
   initialization (runtime)

For architectures that select ARCH_DEFER_KASAN: kasan_shadow_initialized()
uses a static key that gets enabled when shadow memory is ready.

For architectures that don't: kasan_shadow_initialized() returns
IS_ENABLED(CONFIG_KASAN) since shadow is ready from the start.

This provides:
- Consistent interface across all KASAN modes
- Runtime control only where actually needed
- Compile-time constants for optimal performance where possible
- Clear separation between "KASAN configured" vs "shadow ready"

Also adds kasan_init_generic() function that enables the shadow flag and
handles initialization for Generic mode, and updates SW_TAGS and HW_TAGS
to use the unified kasan_shadow_enable() function.

Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217049
Signed-off-by: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
---
Changes in v3:
- Only architectures that need deferred KASAN get runtime overhead
- Added kasan_shadow_initialized() for shadow memory readiness tracking
- kasan_enabled() now provides compile-time check for KASAN configuration
---
 include/linux/kasan-enabled.h | 34 ++++++++++++++++++++++++++--------
 include/linux/kasan.h         |  6 ++++++
 mm/kasan/common.c             |  9 +++++++++
 mm/kasan/generic.c            | 11 +++++++++++
 mm/kasan/hw_tags.c            |  9 +--------
 mm/kasan/sw_tags.c            |  2 ++
 6 files changed, 55 insertions(+), 16 deletions(-)

diff --git a/include/linux/kasan-enabled.h b/include/linux/kasan-enabled.h
index 6f612d69ea0..fa99dc58f95 100644
--- a/include/linux/kasan-enabled.h
+++ b/include/linux/kasan-enabled.h
@@ -4,32 +4,50 @@
 
 #include <linux/static_key.h>
 
-#ifdef CONFIG_KASAN_HW_TAGS
+/* Controls whether KASAN is enabled at all (compile-time check). */
+static __always_inline bool kasan_enabled(void)
+{
+	return IS_ENABLED(CONFIG_KASAN);
+}
 
+#ifdef CONFIG_ARCH_DEFER_KASAN
+/*
+ * Global runtime flag for architectures that need deferred KASAN.
+ * Switched to 'true' by the appropriate kasan_init_*()
+ * once KASAN is fully initialized.
+ */
 DECLARE_STATIC_KEY_FALSE(kasan_flag_enabled);
 
-static __always_inline bool kasan_enabled(void)
+static __always_inline bool kasan_shadow_initialized(void)
 {
 	return static_branch_likely(&kasan_flag_enabled);
 }
 
-static inline bool kasan_hw_tags_enabled(void)
+static inline void kasan_enable(void)
+{
+	static_branch_enable(&kasan_flag_enabled);
+}
+#else
+/* For architectures that can enable KASAN early, use compile-time check. */
+static __always_inline bool kasan_shadow_initialized(void)
 {
 	return kasan_enabled();
 }
 
-#else /* CONFIG_KASAN_HW_TAGS */
+/* No-op for architectures that don't need deferred KASAN. */
+static inline void kasan_enable(void) {}
+#endif /* CONFIG_ARCH_DEFER_KASAN */
 
-static inline bool kasan_enabled(void)
+#ifdef CONFIG_KASAN_HW_TAGS
+static inline bool kasan_hw_tags_enabled(void)
 {
-	return IS_ENABLED(CONFIG_KASAN);
+	return kasan_enabled();
 }
-
+#else
 static inline bool kasan_hw_tags_enabled(void)
 {
 	return false;
 }
-
 #endif /* CONFIG_KASAN_HW_TAGS */
 
 #endif /* LINUX_KASAN_ENABLED_H */
diff --git a/include/linux/kasan.h b/include/linux/kasan.h
index 890011071f2..51a8293d1af 100644
--- a/include/linux/kasan.h
+++ b/include/linux/kasan.h
@@ -543,6 +543,12 @@ void kasan_report_async(void);
 
 #endif /* CONFIG_KASAN_HW_TAGS */
 
+#ifdef CONFIG_KASAN_GENERIC
+void __init kasan_init_generic(void);
+#else
+static inline void kasan_init_generic(void) { }
+#endif
+
 #ifdef CONFIG_KASAN_SW_TAGS
 void __init kasan_init_sw_tags(void);
 #else
diff --git a/mm/kasan/common.c b/mm/kasan/common.c
index ed4873e18c7..c3a6446404d 100644
--- a/mm/kasan/common.c
+++ b/mm/kasan/common.c
@@ -32,6 +32,15 @@
 #include "kasan.h"
 #include "../slab.h"
 
+#ifdef CONFIG_ARCH_DEFER_KASAN
+/*
+ * Definition of the unified static key declared in kasan-enabled.h.
+ * This provides consistent runtime enable/disable across KASAN modes.
+ */
+DEFINE_STATIC_KEY_FALSE(kasan_flag_enabled);
+EXPORT_SYMBOL(kasan_flag_enabled);
+#endif
+
 struct slab *kasan_addr_to_slab(const void *addr)
 {
 	if (virt_addr_valid(addr))
diff --git a/mm/kasan/generic.c b/mm/kasan/generic.c
index d54e89f8c3e..03b6d322ff6 100644
--- a/mm/kasan/generic.c
+++ b/mm/kasan/generic.c
@@ -36,6 +36,17 @@
 #include "kasan.h"
 #include "../slab.h"
 
+/*
+ * Initialize Generic KASAN and enable runtime checks.
+ * This should be called from arch kasan_init() once shadow memory is ready.
+ */
+void __init kasan_init_generic(void)
+{
+	kasan_enable();
+
+	pr_info("KernelAddressSanitizer initialized (generic)\n");
+}
+
 /*
  * All functions below always inlined so compiler could
  * perform better optimizations in each of __asan_loadX/__assn_storeX
diff --git a/mm/kasan/hw_tags.c b/mm/kasan/hw_tags.c
index 9a6927394b5..c8289a3feab 100644
--- a/mm/kasan/hw_tags.c
+++ b/mm/kasan/hw_tags.c
@@ -45,13 +45,6 @@ static enum kasan_arg kasan_arg __ro_after_init;
 static enum kasan_arg_mode kasan_arg_mode __ro_after_init;
 static enum kasan_arg_vmalloc kasan_arg_vmalloc __initdata;
 
-/*
- * Whether KASAN is enabled at all.
- * The value remains false until KASAN is initialized by kasan_init_hw_tags().
- */
-DEFINE_STATIC_KEY_FALSE(kasan_flag_enabled);
-EXPORT_SYMBOL(kasan_flag_enabled);
-
 /*
  * Whether the selected mode is synchronous, asynchronous, or asymmetric.
  * Defaults to KASAN_MODE_SYNC.
@@ -260,7 +253,7 @@ void __init kasan_init_hw_tags(void)
 	kasan_init_tags();
 
 	/* KASAN is now initialized, enable it. */
-	static_branch_enable(&kasan_flag_enabled);
+	kasan_enable();
 
 	pr_info("KernelAddressSanitizer initialized (hw-tags, mode=%s, vmalloc=%s, stacktrace=%s)\n",
 		kasan_mode_info(),
diff --git a/mm/kasan/sw_tags.c b/mm/kasan/sw_tags.c
index b9382b5b6a3..275bcbbf612 100644
--- a/mm/kasan/sw_tags.c
+++ b/mm/kasan/sw_tags.c
@@ -45,6 +45,8 @@ void __init kasan_init_sw_tags(void)
 
 	kasan_init_tags();
 
+	kasan_enable();
+
 	pr_info("KernelAddressSanitizer initialized (sw-tags, stacktrace=%s)\n",
 		str_on_off(kasan_stack_collection_enabled()));
 }
-- 
2.34.1


