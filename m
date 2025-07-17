Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38E65C83F34
	for <linux-um@archiver.kernel.org>; Thu, 17 Jul 2025 15:03:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xwSPw6gFzDTyOsOkroA5OTCCxXe2CzpjscG8NASBaU4=; b=LDRDE2+2juiC5Ylowq3YoSIdFX
	pZkVAm0Jr1kFHBjHUg9OZ5I2Ex2zIvBjCaCtxjih1Dd8ZXDNbKV+hDYLso/rHB4rZ8Y+/C++QtgwK
	koHnpS1f4/h/dDRwxJ02ArrdhZJQQv8K1P+J4hiIAr4oJwDNaVHeJiP73kSsq3l7dt6+crk9dZVTX
	Efz2lV3d4ySVBosIfPMnjlfhQ/b+g8NufpMKoiKvHfu51Xb8Bt7y93JJDuDVnCZ5j0sIBbSYK0PLL
	evXaQCRmybnZcpyMvMG/bfptvkn2cNC3DBVWreiz8YxJwopfyTM0OukrBRzmxtLMfb7MtHlrDED7d
	feAugcZw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ucQ9F-0000000AST1-3vWv;
	Thu, 17 Jul 2025 15:03:49 +0000
Received: from mail-lf1-x131.google.com ([2a00:1450:4864:20::131])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ucPap-0000000ANAP-2IeB;
	Thu, 17 Jul 2025 14:28:16 +0000
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-5551a770828so1169227e87.1;
        Thu, 17 Jul 2025 07:28:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752762494; x=1753367294; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xwSPw6gFzDTyOsOkroA5OTCCxXe2CzpjscG8NASBaU4=;
        b=UQrPPr9KrAXMgRRo6phubYlGZVgGrfMDA/P6S0OQAp8JcCHkn9OZh/VpJWuckSd5JV
         Gd2Qo9Oq0M/Lp/heaf70FYbh/wIqBNm/15nUI9xkR8vpOWNQOaovm9D9KX8PjEF63E1G
         Gc3gQX73J9dHoAadN6EHz5gf8EEB4O82HZmBmIwNBiI9/awWd9T0kDd877/Dsi24UM/B
         0YtilMp9r4jli8rvslEzYOSWodbcUD70mfHJ6kB02i2MVoBVEM+vGjbN32IPw+qc+RlM
         8iPB6EU/CyqT2EAYCvAjD/g0R/e3hdGEt3ntOYPOBlc98xCCGMsAQFlr64wypFVpE/5M
         4JGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752762494; x=1753367294;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xwSPw6gFzDTyOsOkroA5OTCCxXe2CzpjscG8NASBaU4=;
        b=a/jzthdFytDdMQoUYBpmn/80mkXu2qe0bnNO64eoYykAC+PYeolMFKX9MVIZSHc8Bf
         x3LEiv4weVwEid6E/cWnguXIiKc1V+fX3r7gMCnH19XNKM/5RE4ERihLnKQP6MsI8E9X
         xYIAQ9S2Oo0555R4S3s0dwFd0F02Tre9oAuJxNHWSZkfNisgblW7JP8lBxnqPtgxNGR9
         bxmwr1zO4imSR6SelYZEdQEfk5X3Cq/j1HCFm2ArZR/yWLM/HnGe6YPKnC8i9OsSNqeP
         3/Um1b4xugReQT1a8O8cAb1llev5e7Sxc+BOMGtXJ7HWkuHW9+hh49QhVO3p8Vyo23K/
         n3lA==
X-Forwarded-Encrypted: i=1; AJvYcCV0a2GU8faXYiyYBSQee67wDczjNl6bBkET/0q26n4GqgU09QNqOSbDeS3Qyo5Dum/xA22HnBk8lU05Og==@lists.infradead.org, AJvYcCW0uohRWw3+26eUoVYROvyyQZDh2+y7KyUac2p6XY3aQ1hGBN8pXNm00lEWyxI+25ceoJzAABr2FJ4=@lists.infradead.org
X-Gm-Message-State: AOJu0Yw+O8Q1xLnizQyFb/AAiN3AB+tcJmwUAk5PLrSGa5Vh4tNEUL5V
	e56PYtuMdkIdEx+AErSom797Ad2WfCUQWpiyQzVcJ0PWg1HeiFoqbEhy
X-Gm-Gg: ASbGncu84LZx8GPVppFRo4AnfqAduw/vehugfzRjyEP7Ti2PUcjVldvIMeB+z+Dxhfe
	drn2hUo4VhmEr4D/M12s334JhyXpk+IuohR82yhXJz5dyWrNnV3+rCEn0Ch/qg8QXcpC21bz5Qf
	hXP+FKQzsbDjjBLib2yZhwqmE3MnXv9Ed2v7Q4ra9oAJKkyfAZyvj8vrjP7gpFE4O2+9kjaGOlG
	KUTHi8/3kpQCVjMblMH0aF8MHAMJ8hAS9/Sk2vuzYILGWWuzcCsFHYNTz3ACLW0Ta2yczMKhoOt
	tGYE7F5xJqw1+iHXM6KrvKWLaW8tfMvYZmK+L04RokimUiTl9reiqEFtWgiJ6OtgtYk0GAW7u2M
	yRy/ynVpOmh7ULc6QpZ8PwILCnmWTwFzHIllAPMsAtVwoOsqmCo3kOWQaciEvKvggUDKu
X-Google-Smtp-Source: AGHT+IFV4/fgUWSLQ9HeTYD1ZNc8U4khjXBXPUvRtZGAA8fcpyT35FlSXgJszoiLVDo7d7offe3D+A==
X-Received: by 2002:a05:6512:3710:b0:554:f74b:78c1 with SMTP id 2adb3069b0e04-55a233db3famr2128904e87.43.1752762493542;
        Thu, 17 Jul 2025 07:28:13 -0700 (PDT)
Received: from localhost.localdomain (178.90.89.143.dynamic.telecom.kz. [178.90.89.143])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55989825fe3sm3022975e87.223.2025.07.17.07.28.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 07:28:12 -0700 (PDT)
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
Subject: [PATCH v3 10/12] kasan/s390: call kasan_init_generic in kasan_init
Date: Thu, 17 Jul 2025 19:27:30 +0500
Message-Id: <20250717142732.292822-11-snovitoll@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250717142732.292822-1-snovitoll@gmail.com>
References: <20250717142732.292822-1-snovitoll@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250717_072815_585989_651C2CD5 
X-CRM114-Status: GOOD (  10.24  )
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

Call kasan_init_generic() which handles Generic KASAN initialization
and prints the banner. Since s390 doesn't select ARCH_DEFER_KASAN,
kasan_enable() will be a no-op, and kasan_enabled() will return
IS_ENABLED(CONFIG_KASAN) for optimal compile-time behavior.

s390 sets up KASAN mappings in the decompressor and can run with KASAN
enabled from very early, so it doesn't need runtime control.

Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217049
Signed-off-by: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
---
 arch/s390/kernel/early.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/s390/kernel/early.c b/arch/s390/kernel/early.c
index 54cf0923050..7ada1324f6a 100644
--- a/arch/s390/kernel/early.c
+++ b/arch/s390/kernel/early.c
@@ -21,6 +21,7 @@
 #include <linux/kernel.h>
 #include <asm/asm-extable.h>
 #include <linux/memblock.h>
+#include <linux/kasan.h>
 #include <asm/access-regs.h>
 #include <asm/asm-offsets.h>
 #include <asm/machine.h>
@@ -65,7 +66,7 @@ static void __init kasan_early_init(void)
 {
 #ifdef CONFIG_KASAN
 	init_task.kasan_depth = 0;
-	pr_info("KernelAddressSanitizer initialized\n");
+	kasan_init_generic();
 #endif
 }
 
-- 
2.34.1


