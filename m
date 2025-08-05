Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EFEAC87FDA
	for <linux-um@archiver.kernel.org>; Tue,  5 Aug 2025 15:38:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DndoJEoEU+djai/jF18bii/cwZvYONRQ0C6xs3DhJyU=; b=ZJfSkf2Pt8T6HhSV2EIuAXx3PF
	R0r3AZe8MGXFMJFdSRKBvB9ClFjf22fpzll9acDiVV/HX9fLtOTL3cwmaGCr1GMlhDu3l6LyZaPS5
	38GLtLZ+ngiTJNUxhKHHYTz986wB1keYJdesFtokYlk4O4Waab3kWcZIm3PHDSnZwKJG6ZPwgBwPE
	dcVihPp6it4RfdIiwI9NrftnKVmbKhQ48fFFyalvTbj1vp5y+1jq7aUi7bNwROJm6zcsPNPLh73Dj
	eMVkoJV9oKkzEO8LpH1BpeMZmaoYTElbNy8QeoJ5OF69y0gYfwJJOsClaE2H1EUSDj04FW+kftoZg
	OQ/8A3BA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ujJkc-0000000DAeD-2ZBK;
	Tue, 05 Aug 2025 15:38:54 +0000
Received: from mail-lf1-x132.google.com ([2a00:1450:4864:20::132])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ujIck-0000000D0WP-0OfY;
	Tue, 05 Aug 2025 14:26:43 +0000
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-55b827aba01so3852347e87.0;
        Tue, 05 Aug 2025 07:26:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754404000; x=1755008800; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DndoJEoEU+djai/jF18bii/cwZvYONRQ0C6xs3DhJyU=;
        b=NxEfac9Izok3hZmoRCzNbED9ZgAABX5kEPHDu9HNaxpXNCB+l/qVgF6Wf4pq5TZix9
         LaMtVA1nKs2cSRYX3SJcVs1kaNhJfrrYASQrhvRr+hrVAp1qc7fI/ESRX+2gN34pFbS8
         xQjHsl5h63z7j4SvSZh2iSIuOPFqZdfRTPhPdYtA47L3BsMKzAJTq7+cqUmInJ9csKhf
         La0/KJAS1C6Ncs6LczOGiV4OD7uoWXZ9ZGrsGRMyy7eMFfDIX89at9C5GTB/eMsOB8Jf
         FokKK6kkJIlqUfPBFUr01pevSIHYkq+3oyqher4UJHrrC5KvVof1Xg4dzNaNigsQc5CN
         K0QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754404000; x=1755008800;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DndoJEoEU+djai/jF18bii/cwZvYONRQ0C6xs3DhJyU=;
        b=SLR/Jcga7xPUi/R00CNEB06lbOG7Tnll/Pbj5m7qqcCbv+gUzFJL6RxoSNhFbiSVmL
         PqsEDz8PGhFN9/TgkVRokuY/u+RLpTtxzmR+ouf6UWw7ko6v0cAy2+JF6j0HbKJxQ/QN
         HmD4bPCjYhCVbbJ+GuFjHOEDhW4MMMtsi/TWgC9daxE1cgAvbi8tIJ+LZZpfsdlXE2zV
         dfWliWXbXz2xpVh9SXAg4VGI5I3OUuKB908z+QzxeIO9XQLMDX5I5kK/KvSerWETTND7
         NaeB5krq2BC2SsvYKL0JBcdJBQfqHWHpRYIZnrKa4wjUnT0bYqBxtlmmnL6XCW0HqJLk
         4GdA==
X-Forwarded-Encrypted: i=1; AJvYcCV6FPOT0diuihBxShSRt+yPnueCFl7vHmjjY9CH9ahLpz3ND/bJjqvBxxZqJ4syhNbteF87HfQ4ykI54g==@lists.infradead.org, AJvYcCXHSzAf0VOsBSr9nq99ephJn9IdIdS/57RREuroY3/47LC7ub0JKb/HfLm7YEHDTSSR7OzcNppKZyc=@lists.infradead.org
X-Gm-Message-State: AOJu0Yx0s6L/bs4QV+x4qaK+HhI0fI+AWnecqbsznaI8+rESIt4iSZUq
	I83zm2gRr+pX8F5VtXxwsF1AVt3F6wHTS6obRK/SAw7L9md7REGBQNJO
X-Gm-Gg: ASbGncv5Iwa0+CuXQueiGJWePEtsj8MytX6dri+CuiRacgF15uls1nbg5MG0TtvhQWS
	XOpfKNzU9cBOql2lj93PEDf17jDUKhRbS5xTdaLXc0UjlW6itu6BwpVcYdXvK5sSqV8fiSccHNA
	1zDuQTMZK4ahipnnt5eQpJBia7v6wE6vWTtKExZXktN3lNEQXcgaiNtPFkoVQvbWDzkV5dzcIkC
	sZOXEgjyoPFiBPiL/hIu89UdUsf1fiSSM/f+kgwOezzb3grp9z4ZCAgEV8+Eh5nnatGN7ubYHS9
	ijmBFGR3p95vITgpjFAIe3I4y3qjlAfbV3T/F+zzbg4TLHhsJAtHegzKRuA1Q6m6grPzPOm8QrH
	r4MCTmY+udSCVKcuDBVWNa91rsPcQiUrtWuvM6lgPnmTRaw5v0EAgzvNbXLQrG8570E7xOg==
X-Google-Smtp-Source: AGHT+IG8YXFpsfEvWLWpJ0j6eFW8/n9npKWJxSkpHVdxT2hyDgxCfNXo+mPOdolEzpL3+MkF6IOdvw==
X-Received: by 2002:a05:6512:1387:b0:553:25f4:695c with SMTP id 2adb3069b0e04-55b97bc54b1mr4200362e87.50.1754404000307;
        Tue, 05 Aug 2025 07:26:40 -0700 (PDT)
Received: from localhost.localdomain (178.90.89.143.dynamic.telecom.kz. [178.90.89.143])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55b889a290fsm1976379e87.54.2025.08.05.07.26.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Aug 2025 07:26:39 -0700 (PDT)
From: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
To: ryabinin.a.a@gmail.com,
	hca@linux.ibm.com,
	christophe.leroy@csgroup.eu,
	andreyknvl@gmail.com,
	agordeev@linux.ibm.com,
	akpm@linux-foundation.org,
	zhangqing@loongson.cn,
	chenhuacai@loongson.cn,
	trishalfonso@google.com,
	davidgow@google.com
Cc: glider@google.com,
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
Subject: [PATCH v4 5/9] kasan/loongarch: select ARCH_DEFER_KASAN and call kasan_init_generic
Date: Tue,  5 Aug 2025 19:26:18 +0500
Message-Id: <20250805142622.560992-6-snovitoll@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250805142622.560992-1-snovitoll@gmail.com>
References: <20250805142622.560992-1-snovitoll@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250805_072642_133699_81086F42 
X-CRM114-Status: GOOD (  13.70  )
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

LoongArch needs deferred KASAN initialization as it has a custom
kasan_arch_is_ready() implementation that tracks shadow memory
readiness via the kasan_early_stage flag.

Select ARCH_DEFER_KASAN to enable the unified static key mechanism
for runtime KASAN control. Call kasan_init_generic() which handles
Generic KASAN initialization and enables the static key.

Replace kasan_arch_is_ready() with kasan_enabled() and delete the
flag kasan_early_stage in favor of the unified kasan_enabled()
interface.

Note that init_task.kasan_depth = 0 is called after kasan_init_generic(),
which is different than in other arch kasan_init(). This is left
unchanged as it cannot be tested.

Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217049
Signed-off-by: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
---
Changes in v4:
- Replaced !kasan_enabled() with !kasan_shadow_initialized() in
  loongarch which selects ARCH_DEFER_KASAN (Andrey Ryabinin)
---
 arch/loongarch/Kconfig             | 1 +
 arch/loongarch/include/asm/kasan.h | 7 -------
 arch/loongarch/mm/kasan_init.c     | 8 ++------
 3 files changed, 3 insertions(+), 13 deletions(-)

diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
index f0abc38c40a..f6304c073ec 100644
--- a/arch/loongarch/Kconfig
+++ b/arch/loongarch/Kconfig
@@ -9,6 +9,7 @@ config LOONGARCH
 	select ACPI_PPTT if ACPI
 	select ACPI_SYSTEM_POWER_STATES_SUPPORT	if ACPI
 	select ARCH_BINFMT_ELF_STATE
+	select ARCH_DEFER_KASAN
 	select ARCH_DISABLE_KASAN_INLINE
 	select ARCH_ENABLE_MEMORY_HOTPLUG
 	select ARCH_ENABLE_MEMORY_HOTREMOVE
diff --git a/arch/loongarch/include/asm/kasan.h b/arch/loongarch/include/asm/kasan.h
index 62f139a9c87..0e50e5b5e05 100644
--- a/arch/loongarch/include/asm/kasan.h
+++ b/arch/loongarch/include/asm/kasan.h
@@ -66,7 +66,6 @@
 #define XKPRANGE_WC_SHADOW_OFFSET	(KASAN_SHADOW_START + XKPRANGE_WC_KASAN_OFFSET)
 #define XKVRANGE_VC_SHADOW_OFFSET	(KASAN_SHADOW_START + XKVRANGE_VC_KASAN_OFFSET)
 
-extern bool kasan_early_stage;
 extern unsigned char kasan_early_shadow_page[PAGE_SIZE];
 
 #define kasan_mem_to_shadow kasan_mem_to_shadow
@@ -75,12 +74,6 @@ void *kasan_mem_to_shadow(const void *addr);
 #define kasan_shadow_to_mem kasan_shadow_to_mem
 const void *kasan_shadow_to_mem(const void *shadow_addr);
 
-#define kasan_arch_is_ready kasan_arch_is_ready
-static __always_inline bool kasan_arch_is_ready(void)
-{
-	return !kasan_early_stage;
-}
-
 #define addr_has_metadata addr_has_metadata
 static __always_inline bool addr_has_metadata(const void *addr)
 {
diff --git a/arch/loongarch/mm/kasan_init.c b/arch/loongarch/mm/kasan_init.c
index d2681272d8f..57fb6e98376 100644
--- a/arch/loongarch/mm/kasan_init.c
+++ b/arch/loongarch/mm/kasan_init.c
@@ -40,11 +40,9 @@ static pgd_t kasan_pg_dir[PTRS_PER_PGD] __initdata __aligned(PAGE_SIZE);
 #define __pte_none(early, pte) (early ? pte_none(pte) : \
 ((pte_val(pte) & _PFN_MASK) == (unsigned long)__pa(kasan_early_shadow_page)))
 
-bool kasan_early_stage = true;
-
 void *kasan_mem_to_shadow(const void *addr)
 {
-	if (!kasan_arch_is_ready()) {
+	if (!kasan_shadow_initialized()) {
 		return (void *)(kasan_early_shadow_page);
 	} else {
 		unsigned long maddr = (unsigned long)addr;
@@ -298,8 +296,6 @@ void __init kasan_init(void)
 	kasan_populate_early_shadow(kasan_mem_to_shadow((void *)VMALLOC_START),
 					kasan_mem_to_shadow((void *)KFENCE_AREA_END));
 
-	kasan_early_stage = false;
-
 	/* Populate the linear mapping */
 	for_each_mem_range(i, &pa_start, &pa_end) {
 		void *start = (void *)phys_to_virt(pa_start);
@@ -329,5 +325,5 @@ void __init kasan_init(void)
 
 	/* At this point kasan is fully initialized. Enable error messages */
 	init_task.kasan_depth = 0;
-	pr_info("KernelAddressSanitizer initialized.\n");
+	kasan_init_generic();
 }
-- 
2.34.1


