Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABD44C87FD2
	for <linux-um@archiver.kernel.org>; Tue,  5 Aug 2025 15:38:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vUUI2xKZlk5/jtNpSyx53EShjk/LU4/amvgKSzwK4wM=; b=Ni7Dm0umtUGHcvK4tNv1BIrWC+
	7ndf1JRr8WDOEqi7x4HQmANHCNmfal3QArGB7zReNg8C77/tEYv3DPkTdmnTM3RTvDxy1HeZvkAo5
	Kp1ePRaP4lyxUzeTdUzyCOcXSmC4+mn2T5ZyvqCOkvRBvWPEOfBSxjA8Lkq+QAEA9vOCErUe8f9zp
	by+ez6dgzy4ylU5treEY2fmgLe7BYCXiCE3Xir2w/nO5Qsdp9BqiFnbfM6OON7jeyp8G6BsIMGcIs
	rms5pgdWWQlUwMYVUVrcGjwiqFZy4HczfUO2aZEK3cRYcPrJjpeMxeoTml/1qjFpBEsTloggvQV9x
	BpceTkvg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ujJkZ-0000000DAa5-1Ivv;
	Tue, 05 Aug 2025 15:38:51 +0000
Received: from mail-lf1-x12d.google.com ([2a00:1450:4864:20::12d])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ujIcf-0000000D0Sr-2ltU;
	Tue, 05 Aug 2025 14:26:39 +0000
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-55b829c7f1aso6569130e87.2;
        Tue, 05 Aug 2025 07:26:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754403996; x=1755008796; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vUUI2xKZlk5/jtNpSyx53EShjk/LU4/amvgKSzwK4wM=;
        b=Ehgj7IJxWwdfacwJQeW4eu8+QJoVcpF8kC+Zs8bAQKlmU81lps0oFERS7bbxn62n0H
         jcG3kRtPtbtTGtNt9Ix6q+icYknx4M0ESEGP6vUcKF0aIzozZh44xuv5rgN8SjLbRPTJ
         a6GnLOTTcLB2xU24CiGZD8G/CmE8ruBHFtbTcU0mwFCAJuTaha6aVVCt+3AXH+c/5mmt
         tygmUDO/16G/QVuS7avEV2GIIZBqDEtjQyoyQaupxgvt3yXQ9A0KqLYS8Nkkj6EKgGG1
         bOQZ6v5EiS9B1dxLpJCQ7BAB0M8RvsXCFx626P8rU4UAevsIwOpDpAnA1QyfM7EfBDpl
         BSng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754403996; x=1755008796;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vUUI2xKZlk5/jtNpSyx53EShjk/LU4/amvgKSzwK4wM=;
        b=ZiJS8Rc8vOQG/hdrMbwE28DS9KT6y7H1AjNs9NR9SwADWFodVuZlrAZIS3wokX1EFe
         s89ut9+sCnE43KGxjZAVG0oWYxK3k4I8rvucs0Epz3QHWNzoehdJ8aqcr2dFrRySO9OI
         5aV4iWklvP4/kK2SOKqkw5SiEi36EeUi+PS3q2UoRkSqcoKoYTEn5+ImfmZPdSYtbodx
         ctmcXnkp60Za15GdzchlVo3Y5gr3beqY++OnEl0XqIj49CVa7FkFXZ3kvQvzcJTD0Hpx
         4M8B2TNZflpi19dq4bbxeiRxXSnqmePFZSZ5rT4NEOo/5H69uGGjEd3LxqvS3Fv6bvEt
         2C9g==
X-Forwarded-Encrypted: i=1; AJvYcCV6S4Z8QXRIRucLtmn0b3JkY9K48yRCGHteZBuZZeCv+i6yB71J1tSrf6GKIndN8hAjab3g1Oy9NwwtpA==@lists.infradead.org, AJvYcCX6oSjmTDQKblfkeRm6s5v2oAOJorFOCymoFkT8BN9OxDyW8YsJTZnEpqcAKSjmtWDXxxtp18oGFpw=@lists.infradead.org
X-Gm-Message-State: AOJu0Yz9XorwRutZvUvFcoSDsz8QQT9C2DZJG9Gk32fptORNuAtdF4bP
	qqfCsOnkHHFqt7Zm90ZmgitKf6fACbjg/wf8GCSyA1F6fJrG/3+Z2LP5
X-Gm-Gg: ASbGncvT4k6RYbzHV+11NRAw3Nlq/ZjsjaQx9KO4PkAd40H1XzhivrAf+aCcOPhWeFK
	u1qjEx7HuHRX3XMtIx4eERan0z3d/2guNqxLCqZtgADJAQ85/AulcKokgvdai9xQ2dqdH1liIeY
	iwreUHu65L+gojMJhVyXLKFNHlLLpaLczMJ3w+hdG2Yg1WMt85fRAv5BBwoyUYghjtXbfxX+ogV
	fQ0UNr1BgzG0nt9AwKfKSmcIoVAsUmK896maqqHEuvf65g1ue6gAQLfTGiRO6sn5hHLDQ+7acRS
	Fbdv5IP0f8C4NI7O14bw4hKULhaNWKeXv25hpvXvqlXvXzj6wOjFTyaFLSaYY7FieXmDgJU/Gdg
	mYr5fxu4J//THRIPgJAYg7ga1Op48S12eeMQ9O71m61DZx3i2wjzr69erZ7ee5YkLEgklkw==
X-Google-Smtp-Source: AGHT+IEuyOphkquEE1TcD7oJ1sEAoZRW6geJFjdlevxIlBKJ8sCVOgd5wEIObFEm35WGh0DuMN4+1Q==
X-Received: by 2002:a05:6512:228a:b0:55c:ac98:edb6 with SMTP id 2adb3069b0e04-55cac98f040mr114526e87.12.1754403995715;
        Tue, 05 Aug 2025 07:26:35 -0700 (PDT)
Received: from localhost.localdomain (178.90.89.143.dynamic.telecom.kz. [178.90.89.143])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55b889a290fsm1976379e87.54.2025.08.05.07.26.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Aug 2025 07:26:35 -0700 (PDT)
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
Subject: [PATCH v4 3/9] kasan/arm,arm64: call kasan_init_generic in kasan_init
Date: Tue,  5 Aug 2025 19:26:16 +0500
Message-Id: <20250805142622.560992-4-snovitoll@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250805142622.560992-1-snovitoll@gmail.com>
References: <20250805142622.560992-1-snovitoll@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250805_072637_706590_8888B1D5 
X-CRM114-Status: GOOD (  11.32  )
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

Call kasan_init_generic() which handles Generic KASAN initialization.
Since arm64 doesn't select ARCH_DEFER_KASAN, this will be a no-op for
the runtime flag but will print the initialization banner.

For SW_TAGS and HW_TAGS modes, their respective init functions will
handle the flag enabling.

Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217049
Signed-off-by: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
---
 arch/arm/mm/kasan_init.c   | 2 +-
 arch/arm64/mm/kasan_init.c | 4 +---
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mm/kasan_init.c b/arch/arm/mm/kasan_init.c
index 111d4f70313..c6625e808bf 100644
--- a/arch/arm/mm/kasan_init.c
+++ b/arch/arm/mm/kasan_init.c
@@ -300,6 +300,6 @@ void __init kasan_init(void)
 	local_flush_tlb_all();
 
 	memset(kasan_early_shadow_page, 0, PAGE_SIZE);
-	pr_info("Kernel address sanitizer initialized\n");
 	init_task.kasan_depth = 0;
+	kasan_init_generic();
 }
diff --git a/arch/arm64/mm/kasan_init.c b/arch/arm64/mm/kasan_init.c
index d541ce45dae..abeb81bf6eb 100644
--- a/arch/arm64/mm/kasan_init.c
+++ b/arch/arm64/mm/kasan_init.c
@@ -399,14 +399,12 @@ void __init kasan_init(void)
 {
 	kasan_init_shadow();
 	kasan_init_depth();
-#if defined(CONFIG_KASAN_GENERIC)
+	kasan_init_generic();
 	/*
 	 * Generic KASAN is now fully initialized.
 	 * Software and Hardware Tag-Based modes still require
 	 * kasan_init_sw_tags() and kasan_init_hw_tags() correspondingly.
 	 */
-	pr_info("KernelAddressSanitizer initialized (generic)\n");
-#endif
 }
 
 #endif /* CONFIG_KASAN_GENERIC || CONFIG_KASAN_SW_TAGS */
-- 
2.34.1


