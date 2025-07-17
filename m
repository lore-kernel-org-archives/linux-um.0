Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E9DBC83F38
	for <linux-um@archiver.kernel.org>; Thu, 17 Jul 2025 15:03:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FVh/EioNiM2ei5SEPjKOjjcyR398WOKR4A8RtqUhr5I=; b=lK9U5VxK8kJOBiLYz4nhpVNwqQ
	nr3nqYThX1TE6hPjNoaYdbBzIQulpkMXPmKSUoPF7v/xVB3oG4VjG1jbnXNP9GdpnXPx45GPujsTp
	9wPqTbusClYgZpolz7vPqU+WKV2nKsAzQZie4qNO/YIqtQ8bHdsJPeSBVpOAn7gnJZQP8mEG7TXfY
	FI0CSUjqyDpFHFFdvtpw2txMZSazwKyMqz7Z2Ke2WnR3tS1egl5FPVm6aSWW9uzvRieQdPB+8goeq
	m+NDMdf1wn9R86ZwN9wOwNhR7mFD8aOW2KExBE7s4HV8O/Y7FN3octcwX7MWz7xPd7NuO4XheRqnH
	CZo8OLjA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ucQ9C-0000000ASPK-40gB;
	Thu, 17 Jul 2025 15:03:46 +0000
Received: from mail-lf1-x134.google.com ([2a00:1450:4864:20::134])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ucPaj-0000000AN7H-1Ox9;
	Thu, 17 Jul 2025 14:28:10 +0000
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-553b16a0e38so931897e87.1;
        Thu, 17 Jul 2025 07:28:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752762488; x=1753367288; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FVh/EioNiM2ei5SEPjKOjjcyR398WOKR4A8RtqUhr5I=;
        b=OhcGxR+TyuDRvktoYUL4OLGd3OWNCT2fY3P9D++6DtsBmrQsjW+JKICRk8ML1m2aMA
         PRCEnOJ7qrEfV6sZgyhlUslTLCpPRSE2a15jlkV0oYOkOX9DxS7trZmREg7ILpWb+EUz
         BmOpMdeGuuX4LgmCu24FXe8v50Umt4qX4wXSwKVyaaEhnbYE1epwPQ/t54LkjhEaUhC2
         Opwlg5ZfxEck+cOH2bsKaDMFflXMMLTCB0TQjZxKGODBPAZ0kHqn/bMIhpDCDkSCt2TL
         RehAoZAz+I9lQAkMVGmF6sUuGvuwdiOvqePlI2CaSlrQNo6l9vawNAcErSqAg1u3wdJ1
         Kl8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752762488; x=1753367288;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FVh/EioNiM2ei5SEPjKOjjcyR398WOKR4A8RtqUhr5I=;
        b=gVdyKXtBwunuWJi7dT6NjqGvHhKh+ktjl5WUk/ojjtQuxFOSzLqtD19tlILfYu//K6
         SRMRTFhfHrtgRhDqvnDn6l6AwSD3MNd7VgBS0p/lYg+AWwj4z5fmJO44QNBUK+KIYRHW
         twmHR4qi0h9knCozML/WS7l0BgmStqLcja6/y2UaVerC6NcS0w1ORHI5YKFcd66I6PgG
         O9shCnsi4dVsG6O+pfexNE01QG9YP5oGwX8yb9uHeLTeZ3hpcPvdNnyNpn5M8/0yOSZ5
         p4+XlJOn1GJMkCZQTSJSHw+xkuTIsS9TuGo6bHLDFe3E4OEmVyIEFiIw0LFfPpCSuSE/
         LcAg==
X-Forwarded-Encrypted: i=1; AJvYcCUfBtgxuzghWjvdPfk/cxq5bh8oJW4N2vCxDV2zjsmo8SfVsaiahv2ccNW8gJEjaBbK5D/8yQGIiBw=@lists.infradead.org, AJvYcCVkmO2shpkSxtH5Rhbfo85+1Azk3o+tBRSc+C0R1R4/i/iZhSI1dS7DM9oJYRt90duw8QAjez2cXTNkJg==@lists.infradead.org
X-Gm-Message-State: AOJu0YysR04V5/Q44VNAAcGhr0G3nePcmGGA05t0a++3pqq7ZJEpy3YW
	Uq13ybkoRDoULJGRU6/0oV3WUlUMoUtC3v8DdaG0wBsQdafFLIj2Jk+d
X-Gm-Gg: ASbGnctdlF3+93kPbrX1bnFTLGsffSMWpFsgM+1a+oprTOxVfNUtQwVm2CLI9FP8qJS
	6qD/XQaAa5YaECVOtPJiCXdO5/RrABEFFxmvYbVsJr/DyyvbV5gi3EqagAn84DXVBa49o7FRilJ
	k3LEzHGHCysMDK6FPo4eo5cFQmay9LTLOi7B27WRh5fesL63Y+XqmHsObU/Uaw1oMcv8d96GADP
	DKEAE+NOrYK3gZxXyTpkvqoy410AynVL4vyhwWL71ww3POoYW0N0EHs6LRxvW3JURXh5ApTBQUe
	IJkhtCg6xtiY5T8tYNPUz0ncYlVp0OEp3mJV10+iG5WtLxYP0+DlUuNdy4iwor5HeAV4m7Uzkps
	RbR9AqLPfY9e1e2Yb2171+F5AaBUtoW4vMKTZ76lm6yjAhwM57dHt5l7Zl6HaTKAH8pOP
X-Google-Smtp-Source: AGHT+IGxLJhvaMCe+spMW+LE9A946Qy8DaLWnnJJyiUxPC1zU6fBVPq5lHa93m7Tf0WxYYCemaAtrQ==
X-Received: by 2002:a05:6512:611:10b0:553:2e92:2c98 with SMTP id 2adb3069b0e04-55a2339f4b9mr1702111e87.42.1752762487529;
        Thu, 17 Jul 2025 07:28:07 -0700 (PDT)
Received: from localhost.localdomain (178.90.89.143.dynamic.telecom.kz. [178.90.89.143])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55989825fe3sm3022975e87.223.2025.07.17.07.28.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 07:28:06 -0700 (PDT)
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
Subject: [PATCH v3 08/12] kasan/um: select ARCH_DEFER_KASAN and call kasan_init_generic
Date: Thu, 17 Jul 2025 19:27:28 +0500
Message-Id: <20250717142732.292822-9-snovitoll@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250717142732.292822-1-snovitoll@gmail.com>
References: <20250717142732.292822-1-snovitoll@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250717_072809_384088_41E851CE 
X-CRM114-Status: GOOD (  12.09  )
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

Select ARCH_DEFER_KASAN to enable the unified static key mechanism
for runtime KASAN control. Call kasan_init_generic() which handles
Generic KASAN initialization and enables the static key.

Delete the key kasan_um_is_ready in favor of the unified kasan_enabled()
interface.

Note that kasan_init_generic has __init macro, which is called by
kasan_init() which is not marked with __init in arch/um code.

Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217049
Signed-off-by: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
---
Changes in v3:
- Added CONFIG_ARCH_DEFER_KASAN selection for proper runtime control
---
 arch/um/Kconfig             | 1 +
 arch/um/include/asm/kasan.h | 5 -----
 arch/um/kernel/mem.c        | 4 ++--
 3 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/arch/um/Kconfig b/arch/um/Kconfig
index f08e8a7fac9..fd6d78bba52 100644
--- a/arch/um/Kconfig
+++ b/arch/um/Kconfig
@@ -8,6 +8,7 @@ config UML
 	select ARCH_WANTS_DYNAMIC_TASK_STRUCT
 	select ARCH_HAS_CPU_FINALIZE_INIT
 	select ARCH_HAS_FORTIFY_SOURCE
+	select ARCH_DEFER_KASAN
 	select ARCH_HAS_GCOV_PROFILE_ALL
 	select ARCH_HAS_KCOV
 	select ARCH_HAS_STRNCPY_FROM_USER
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
index 76bec7de81b..058cb70e330 100644
--- a/arch/um/kernel/mem.c
+++ b/arch/um/kernel/mem.c
@@ -21,9 +21,9 @@
 #include <os.h>
 #include <um_malloc.h>
 #include <linux/sched/task.h>
+#include <linux/kasan.h>
 
 #ifdef CONFIG_KASAN
-int kasan_um_is_ready;
 void kasan_init(void)
 {
 	/*
@@ -32,7 +32,7 @@ void kasan_init(void)
 	 */
 	kasan_map_memory((void *)KASAN_SHADOW_START, KASAN_SHADOW_SIZE);
 	init_task.kasan_depth = 0;
-	kasan_um_is_ready = true;
+	kasan_init_generic();
 }
 
 static void (*kasan_init_ptr)(void)
-- 
2.34.1


