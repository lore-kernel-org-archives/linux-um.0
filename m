Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B62EAC87FDA
	for <linux-um@archiver.kernel.org>; Tue,  5 Aug 2025 15:38:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Pl3xBvbmXoSLjMyBTIqb051cyNY5upcj2qfXScxGTG8=; b=Kp2hjq1KNXI2jqaj/j/krPvqyh
	hm4FXHzyt1habmux7OaJXT8FcfXFPkczz1nuM45jOCpLq+r1RrTQ3jyia/a0wGXT54GClb99VrMvi
	o5FLRsBtrzUNPAI1qjkLqHbctqbLOKC61eWGNDlD6GXX7EIf7TVCpfBKSojVg7CUChwqL0Ghy5Wjq
	HVd1DZQSh/u9rDP+XopumHsf14hh9HxXbhtubQ4xQAaZPDuKWlkqodm5mvF/OwgDGjjeaEL0NEuib
	jsiqB+F+kIP2+LldnVXXU6Hmk8fefsxmovHrp51N9CPo0Un5f49cX7/aCfBWwDoX+zZWejgH9THJC
	/3MtuL1w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ujJkf-0000000DAi8-1oiV;
	Tue, 05 Aug 2025 15:38:57 +0000
Received: from mail-lf1-x12c.google.com ([2a00:1450:4864:20::12c])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ujIcm-0000000D0XY-2hn6;
	Tue, 05 Aug 2025 14:26:46 +0000
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-55b85413019so6016398e87.0;
        Tue, 05 Aug 2025 07:26:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754404003; x=1755008803; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pl3xBvbmXoSLjMyBTIqb051cyNY5upcj2qfXScxGTG8=;
        b=R4A6gAmy8loy9s+70nt/oYray0coA+RSFo//uoHWuYRq1K/O8qQ98oBWc5hM5f2qFT
         hK4PZoTco+eE1KLKx5LE195idyGqoOmqdCAlFoQeT/AldhSuXVPoxlmKFHYJiYV4CfJV
         yL9zYVjTi0GL7Ls3Hh+j5Fqe6ofAgYrndkXW+zzOT14giJwtlXpwfIZxdSUjzLPQTv+J
         y4t84IeU1ZR1jr7a6WGynwaArOeuUIqDxTzNa6o7/hyip168eYrcBmVKztwPz22sqji8
         etUS93ZHThSAKKHY95ufjrdmRgynd55qeXgZx5Vr3R1+2r5MiUSd7H20Gr8GjBKorYca
         wm9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754404003; x=1755008803;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pl3xBvbmXoSLjMyBTIqb051cyNY5upcj2qfXScxGTG8=;
        b=lO8rAbPhO7gsAIWEAkPF45xo5wfUXdEekaqBQddkX9WT218v9NDo087HL+O3lfrzQy
         ab8mb50paEC89N5LFh6fmPrcXKQ/aSlB97HXbH3XFE8VbC1+o2bnNE/y9CAMaNWjzgPj
         b5CoTDc9JpQh/UPVO6JiwAsc7a87pZ8nsyFtVXM6fPqkwLYsGSG1HHhYeqC3MZV5W94j
         nt8XcgDShByCQBh5jOxC4VpF+eWfWb6k6YQDHnbKZiKoMl/52bbKx5dvdUV1Q4V+skD+
         wNvPa/ZTU9JZ+Btvz5pVOqTkOpkdSceIhh6eD6s96rzoLAqHa/yFH6V5OtAkp+R/Ln7y
         8iKQ==
X-Forwarded-Encrypted: i=1; AJvYcCVBvtRda8gsf/sMt702GRTvpKrJQPYYgxgl+aNWXQf2T+bHqoqe0x+n0ib3luSxHhAEivIKe0LR3I2Pww==@lists.infradead.org, AJvYcCVRPBiHW6yO9qVu3b98buTFGxB+fA3mQXCxC0eGUJCaUvfwHwfLQxVkDWyZ/H3lt3Nqy3CW/po/A5o=@lists.infradead.org
X-Gm-Message-State: AOJu0Yxe9cbH/6IIqxw1T34ZMvH6hnRBJTyZsRBcSQhR8f+HsLk/udsA
	QJEY5OLsxQv38nFxHhDVzJBDXZDLUe9F7GP5/4a33vtjsC9IvxAfddQzLTz1WhrLHUs=
X-Gm-Gg: ASbGnctJw62X84kjvzVGH75kGPHefgw3VWGe9rsMFl/bq6hD+BGkg6t1Pz6enXRbE2Y
	olchUy4k5dxx6MwfI3fzwip2wMOt7FBp8i24/M+mKBxMmI57I7wZ3DlPgtRMhMgLs80yTSjSjyp
	iwymMhZ0lYE/HuvMgW7NIYUVS3wdnvczCgqf+Cu9Y92z3cftH/R/lOv3iEIWZjDUPjf2+e2CvDy
	CFqCz/LPbbV3ECJtF73u7Bk/RlOihnSZIWP50gze89dlC+Q/taV+zRX4dvB0nRnGaj44PETyXXi
	ibTAVu3WsRilk+KFn3E31tEsA5IxAhbS4QGtAdoB1zYp6Bskyqw3uqmR12u0RMQ1y4jBhXRszm9
	My6h1+rfF2seyCI3slnK26TPFnH/uKsqLANlEChOwN42N0uRJpnAe4REPi1WrDYPU58649A==
X-Google-Smtp-Source: AGHT+IGVveeqR4Cp++JX2gYkKHclckYO0JnGR061NIJDmvQ7jhspWng2d4EVRtNzF0MnSLGE8X42Dw==
X-Received: by 2002:a05:6512:ba8:b0:55b:8e3e:2be6 with SMTP id 2adb3069b0e04-55b97b2971dmr4253074e87.24.1754404002655;
        Tue, 05 Aug 2025 07:26:42 -0700 (PDT)
Received: from localhost.localdomain (178.90.89.143.dynamic.telecom.kz. [178.90.89.143])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55b889a290fsm1976379e87.54.2025.08.05.07.26.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Aug 2025 07:26:42 -0700 (PDT)
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
Subject: [PATCH v4 6/9] kasan/um: select ARCH_DEFER_KASAN and call kasan_init_generic
Date: Tue,  5 Aug 2025 19:26:19 +0500
Message-Id: <20250805142622.560992-7-snovitoll@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250805142622.560992-1-snovitoll@gmail.com>
References: <20250805142622.560992-1-snovitoll@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250805_072644_688322_F21BEACF 
X-CRM114-Status: GOOD (  17.49  )
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

UserMode Linux needs deferred KASAN initialization as it has a custom
kasan_arch_is_ready() implementation that tracks shadow memory readiness
via the kasan_um_is_ready flag.

As it's explained in commit 5b301409e8bc("UML: add support for KASAN
under x86_64"), if CONFIG_STATIC_LINK=y, then it works only with
CONFIG_KASAN_OUTLINE instrumentation.

Calling kasan_init_generic() in the end of kasan_init() like in other
arch does not work for UML as kasan_init() is called way before
main()->linux_main(). It produces the SEGFAULT in:
kasan_init()
	kasan_init_generic
		kasan_enable
		static_key_enable
			STATIC_KEY_CHECK_USE
...
<kasan_init+173>    movabs r9, kasan_flag_enabled
<kasan_init+183>    movabs r8, __func__.2
<kasan_init+193>    movabs rcx, 0x60a04540
<kasan_init+203>    movabs rdi, 0x60a045a0
<kasan_init+213>    movabs r10, warn_slowpath_fmt
	 WARN_ON_ONCE("static key '%pS' used before call to jump_label_init()")
<kasan_init+226>    movabs r12, kasan_flag_enabled

That's why we need to call kasan_init_generic() which enables the
static flag after jump_label_init(). The earliest available place
is arch_mm_preinit().

kasan_init()
main()
	start_kernel
		setup_arch
		jump_label_init
		...
		mm_core_init
			arch_mm_preinit
				kasan_init_generic()

PowerPC, for example, has kasan_late_init() in arch_mm_preinit().
Though there is no static key enabling there, but it should be the best
place to enable KASAN "fully".

Verified with defconfig, enabling KASAN.

Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217049
Signed-off-by: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
---
Changes in v4:
- Addressed the issue in UML arch, where kasan_init_generic() is
  called before jump_label_init() (Andrey Ryabinin)
---
 arch/um/Kconfig             |  1 +
 arch/um/include/asm/kasan.h |  5 -----
 arch/um/kernel/mem.c        | 12 +++++++++---
 3 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/arch/um/Kconfig b/arch/um/Kconfig
index 9083bfdb773..8d14c8fc2cd 100644
--- a/arch/um/Kconfig
+++ b/arch/um/Kconfig
@@ -5,6 +5,7 @@ menu "UML-specific options"
 config UML
 	bool
 	default y
+	select ARCH_DEFER_KASAN
 	select ARCH_WANTS_DYNAMIC_TASK_STRUCT
 	select ARCH_HAS_CACHE_LINE_SIZE
 	select ARCH_HAS_CPU_FINALIZE_INIT
diff --git a/arch/um/include/asm/kasan.h b/arch/um/include/asm/kasan.h
index f97bb1f7b85..81bcdc0f962 100644
--- a/arch/um/include/asm/kasan.h
+++ b/arch/um/include/asm/kasan.h
@@ -24,11 +24,6 @@
 
 #ifdef CONFIG_KASAN
 void kasan_init(void);
-extern int kasan_um_is_ready;
-
-#ifdef CONFIG_STATIC_LINK
-#define kasan_arch_is_ready() (kasan_um_is_ready)
-#endif
 #else
 static inline void kasan_init(void) { }
 #endif /* CONFIG_KASAN */
diff --git a/arch/um/kernel/mem.c b/arch/um/kernel/mem.c
index 76bec7de81b..704a26211ed 100644
--- a/arch/um/kernel/mem.c
+++ b/arch/um/kernel/mem.c
@@ -21,10 +21,10 @@
 #include <os.h>
 #include <um_malloc.h>
 #include <linux/sched/task.h>
+#include <linux/kasan.h>
 
 #ifdef CONFIG_KASAN
-int kasan_um_is_ready;
-void kasan_init(void)
+void __init kasan_init(void)
 {
 	/*
 	 * kasan_map_memory will map all of the required address space and
@@ -32,7 +32,10 @@ void kasan_init(void)
 	 */
 	kasan_map_memory((void *)KASAN_SHADOW_START, KASAN_SHADOW_SIZE);
 	init_task.kasan_depth = 0;
-	kasan_um_is_ready = true;
+	/* Since kasan_init() is called before main(),
+	 * KASAN is initialized but the enablement is deferred after
+	 * jump_label_init(). See arch_mm_preinit().
+	 */
 }
 
 static void (*kasan_init_ptr)(void)
@@ -58,6 +61,9 @@ static unsigned long brk_end;
 
 void __init arch_mm_preinit(void)
 {
+	/* Safe to call after jump_label_init(). Enables KASAN. */
+	kasan_init_generic();
+
 	/* clear the zero-page */
 	memset(empty_zero_page, 0, PAGE_SIZE);
 
-- 
2.34.1


