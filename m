Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B31EAC7115C
	for <linux-um@archiver.kernel.org>; Wed, 25 Jun 2025 11:05:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=U6SFM5Ezspiku172UK6Utmx+P9PfAPP964pKgViV7lo=; b=SB35InCqJYvC/+Lue6dNUBbsTV
	BnDGqYfrFQiyYyfGJ5b/h9H67joKSvCj80YO5BEwKwBrKEVRtvkVCQmpnXRim6G6/GxR2uBZCizKE
	vTAj+q/I+hIBo2iAaF/x3d1W+eLUmKhmdzZC+eq2SWjXCa4qJmzvzQMGrR9eRPh1gnYBkVl9YKTRE
	btnnW9RjO2QrORnKMm25r+Mm9DTPnCPDYoj5cWsi5EKMrSAJyHW17ycGG3UmHv4gT+FXQpWclquha
	oumIJvZcZ6PI0eQ+CfCRmr7IsmxQDNFQ9FhOzAavj/DFdDdgLoTuZpUzJUm8giFG6QJUJGplcV5mv
	oLIbnRVQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uUNwB-00000008Pbi-1xlP;
	Wed, 25 Jun 2025 11:05:07 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uUMoL-00000008Co5-1avt;
	Wed, 25 Jun 2025 09:52:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=U6SFM5Ezspiku172UK6Utmx+P9PfAPP964pKgViV7lo=; b=q31p2V7R3Nu0hVd1oqg21GEIMG
	ymZBIUPTBNKMOznNtYXUkQRipJ1jfPs+4OnpGnsHBfaTxLqftuTZwufyb6krJTrH80h+Ds/h6and+
	UKiuioMqIc4btJ6j1G8ZeHOByo+xYaQ5QscyJAMIDvKfCM5g8zaNzYwQOIHlKO2O/RGBB4ZYvYKKa
	kI/I+PZg+x8fdSLp42CZh5hRugoJApyVfzTXlZ9og1r7qFxId3Z+RQrkYB9bBjNFG5NK3HbXPWceC
	4EUK1jhuHMtGyGyuAgenI0W59UmoKBzMyDRjrx37B1PORyj9R9HoAzobVkt2CRSLhhlrgLP0bqEWc
	xwnNFLLA==;
Received: from mail-lj1-x22c.google.com ([2a00:1450:4864:20::22c])
	by desiato.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uUMoH-00000005lAz-2nk2;
	Wed, 25 Jun 2025 09:52:56 +0000
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-32a9e5b6395so12340451fa.0;
        Wed, 25 Jun 2025 02:52:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750845171; x=1751449971; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U6SFM5Ezspiku172UK6Utmx+P9PfAPP964pKgViV7lo=;
        b=Eo+em+qjJT/GArnJxOC+z5apvghPXHqI6ouGnrry0IkzeOpARMfj4cpQE0np+OKa50
         +6/yajDyqri4Prm6bu5Hv8iUAyA6FDO4LPNg09hN8QX0teJDITuqz9cHdnt4KiJreyFR
         zzUyITLLaAMq+VfYJ8u87x5Up3GjykTAVtheODa16lqlx2mWk2hmbGO9zR4opqdVGr7P
         7WB9jCSF+NcdyQAqJlzilTAGU7roEjIBxdJEthTL9Dj9ZtDMwy0IEBG/QKD8fgRoNk0G
         jeADqYQNAY7aet3WUNnQ8H4olxVDlj8iv82ecncRSHlR+0uHffBLYmyaM6QDrZuG82v6
         mmFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750845171; x=1751449971;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U6SFM5Ezspiku172UK6Utmx+P9PfAPP964pKgViV7lo=;
        b=j5LrhC5qhBYUCo8hLjBHiYp+lfOrQo9GFl95asylofTikYmGkoOoG4UdZX5ShtVa/Z
         +Q2emG5/V7fJIT17sz2cVh43Nz1aJigsGJOpxp2S8FimM0RzUE3fMmEyFOaj4QYcs/yE
         uVlk2qy18rNONb5eryISVguWCNf+I9ZLBjGH3afkVfyIfbwf5t8Lma8IGHQVXeCNTuwP
         LqVA8fMMq/sXf10oZARwo4mrngIQfcxTd+jg8TakDMlcVZekffwalsa1xhVjo//LWhLe
         8LoMv3m3FrH9b3N2AQg956m48w/T2aHcJh32qlxfaobrX51dxkBfDz3rkQstYbNhQb85
         EdQg==
X-Forwarded-Encrypted: i=1; AJvYcCVXvxa24rUem6TxQraqSoL3jgTclFXtsyy1QJhdxdlHqSZ5F0rhsoFRW906kIm1FIeUuukxKWI29rIWLnvtJ3/f@lists.infradead.org, AJvYcCVdSbyIeFLmo/MGlsicgCzTKAbuZC2XxEJdteOZOyJEH/pWa+yoabY7ihMfIPhPsBN/T2IgnCZ0QMo=@lists.infradead.org
X-Gm-Message-State: AOJu0YzAijBHrCp7h4U7EEwDiyiuw0+qav8Lln89MAgYl9VYhptj961s
	2384ydrbGnbx1G20I0AqpeerQkW1PyJ+jg09sIQ8xr3O+IZPrQW+8ZC7
X-Gm-Gg: ASbGnct9R6o9WIiTVYmJeNaAr8SPXD4uCkpDs4g0N1nPEYmxCs0smdZFfhLkMAygRff
	ncsC76gnowuxIBot9G5By2MK2egcx34Yhbzax1DOSGpND9BIYGjb2Mic5Mz+WCAsT+Wgpg6ySJ9
	4GJ0gCkO+AM4GUL7m/E6SirATHktn3lfa+yQPaZcX0NlPUetpXuFZP6CVgl2smifMrOTeLzv3+t
	eVNnQ2YerWFJyo4Ls+1BcIJBxURwZXebZhUqDtwHx2R/3FQDFWS6Kr2Bcfp0XBID9iW/A8E3cUn
	3mkdEhUETA9Z+9A6RYzwMYJYd5Hk/VPMqoLLGDZZHsHypGqc4XlJ8NtrQmGmwXmvPBJR/dxh8Ti
	oh/PmzrGIE52xBzNlPXsOipHyn5jAUg==
X-Google-Smtp-Source: AGHT+IEfwLa2l5GETasrkBN6s16G3uwHStgfCUXGV9Vb0lViqA4Rs63c7NBMXwsuNAY9/KPq3s8gww==
X-Received: by 2002:a05:651c:f03:b0:32b:93fa:2c0b with SMTP id 38308e7fff4ca-32cc64d280emr4286261fa.11.1750845171079;
        Wed, 25 Jun 2025 02:52:51 -0700 (PDT)
Received: from localhost.localdomain (2.135.54.165.dynamic.telecom.kz. [2.135.54.165])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-32b980a36c0sm19311851fa.62.2025.06.25.02.52.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 02:52:50 -0700 (PDT)
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
Subject: [PATCH 1/9] kasan: unify static kasan_flag_enabled across modes
Date: Wed, 25 Jun 2025 14:52:16 +0500
Message-Id: <20250625095224.118679-2-snovitoll@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250625095224.118679-1-snovitoll@gmail.com>
References: <20250625095224.118679-1-snovitoll@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250625_105253_945351_F6878E36 
X-CRM114-Status: GOOD (  14.73  )
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

Historically the fast-path static key `kasan_flag_enabled` existed
only for `CONFIG_KASAN_HW_TAGS`. Generic and SW_TAGS either relied on
`kasan_arch_is_ready()` or evaluated KASAN checks unconditionally.
As a result every architecture had to toggle a private flag
in its `kasan_init()`.

This patch turns the flag into a single global runtime predicate that
is built for every `CONFIG_KASAN` mode and adds a helper that flips
the key once KASAN is ready.

Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218315
Signed-off-by: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
---
 include/linux/kasan-enabled.h | 22 ++++++++++++++++------
 include/linux/kasan.h         |  6 ++++++
 mm/kasan/common.c             |  7 +++++++
 mm/kasan/generic.c            | 11 +++++++++++
 mm/kasan/hw_tags.c            |  7 -------
 mm/kasan/sw_tags.c            |  2 ++
 6 files changed, 42 insertions(+), 13 deletions(-)

diff --git a/include/linux/kasan-enabled.h b/include/linux/kasan-enabled.h
index 6f612d69ea0c..2436eb45cfee 100644
--- a/include/linux/kasan-enabled.h
+++ b/include/linux/kasan-enabled.h
@@ -4,8 +4,12 @@
 
 #include <linux/static_key.h>
 
-#ifdef CONFIG_KASAN_HW_TAGS
+#ifdef CONFIG_KASAN
 
+/*
+ * Global runtime flag. Starts ‘false’; switched to ‘true’ by
+ * the appropriate kasan_init_*() once KASAN is fully initialized.
+ */
 DECLARE_STATIC_KEY_FALSE(kasan_flag_enabled);
 
 static __always_inline bool kasan_enabled(void)
@@ -13,18 +17,24 @@ static __always_inline bool kasan_enabled(void)
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
 
-static inline bool kasan_enabled(void)
+#ifdef CONFIG_KASAN_HW_TAGS
+
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
diff --git a/include/linux/kasan.h b/include/linux/kasan.h
index 890011071f2b..51a8293d1af6 100644
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
index ed4873e18c75..525194da25fa 100644
--- a/mm/kasan/common.c
+++ b/mm/kasan/common.c
@@ -32,6 +32,13 @@
 #include "kasan.h"
 #include "../slab.h"
 
+/*
+ * Definition of the unified static key declared in kasan-enabled.h.
+ * This provides consistent runtime enable/disable across all KASAN modes.
+ */
+DEFINE_STATIC_KEY_FALSE(kasan_flag_enabled);
+EXPORT_SYMBOL(kasan_flag_enabled);
+
 struct slab *kasan_addr_to_slab(const void *addr)
 {
 	if (virt_addr_valid(addr))
diff --git a/mm/kasan/generic.c b/mm/kasan/generic.c
index d54e89f8c3e7..32c432df24aa 100644
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
+	static_branch_enable(&kasan_flag_enabled);
+
+	pr_info("KernelAddressSanitizer initialized (generic)\n");
+}
+
 /*
  * All functions below always inlined so compiler could
  * perform better optimizations in each of __asan_loadX/__assn_storeX
diff --git a/mm/kasan/hw_tags.c b/mm/kasan/hw_tags.c
index 9a6927394b54..8e819fc4a260 100644
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
diff --git a/mm/kasan/sw_tags.c b/mm/kasan/sw_tags.c
index b9382b5b6a37..525bc91e2fcd 100644
--- a/mm/kasan/sw_tags.c
+++ b/mm/kasan/sw_tags.c
@@ -45,6 +45,8 @@ void __init kasan_init_sw_tags(void)
 
 	kasan_init_tags();
 
+	static_branch_enable(&kasan_flag_enabled);
+
 	pr_info("KernelAddressSanitizer initialized (sw-tags, stacktrace=%s)\n",
 		str_on_off(kasan_stack_collection_enabled()));
 }
-- 
2.34.1


