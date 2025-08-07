Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6668BC87FCF
	for <linux-um@archiver.kernel.org>; Thu,  7 Aug 2025 19:48:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sNdBwl8v2OqAa3v0ByxYoV2FZHtZfSuaaApNKvSqvMU=; b=BxXbDFmqn8TjvFZ/9YsIXce2z0
	CMsVGDIwoJjGm4f2UunDSnRGGSEbYk6WopH/tAS6E6TRuTKfqO/ifGEXa/o76qISx3ke4OJwXtwPF
	Y/qADJVZGPN/K8YAj7eN1GKueCsuloeL6ZlL7BOUOZNzLwBKMNdvVWFVCCm1O0n1EAcTqVooULoYf
	Hrozzs4p8Gh25wpf03c572XnlhKIEWlnz6IBCGP+/zOi1QcKjqgo1rKUwcZ28ZhL37A6gnRUu42Cw
	feGVUi6BSM6JfhzD9l9+arig6gNRxmG11e9MO9aOMFwB+BqBps7Up9IAFQphxcMWOkQYCPdBHooMN
	V2LL+T0Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uk6b1-00000001QkP-0Ycy;
	Thu, 07 Aug 2025 19:48:15 +0000
Received: from mail-lf1-x135.google.com ([2a00:1450:4864:20::135])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uk6TV-00000001Phn-00gS;
	Thu, 07 Aug 2025 19:40:30 +0000
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-55cb8ab1010so1104014e87.1;
        Thu, 07 Aug 2025 12:40:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754595627; x=1755200427; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sNdBwl8v2OqAa3v0ByxYoV2FZHtZfSuaaApNKvSqvMU=;
        b=d1sHta+0Z48nIavV5+ZueCX6dYh7RgKmn0VV2Xftz9HOR0KHW+HaGiEPCv7slJEDQH
         nTwQBe6FJwilOhcKM8j0ZrzZ9mi1ucbrciW6YJu3KKWjTFCVUVtUrcZ4WgZzrU0GfjFP
         F2VJvU8fR8AIxHWgh+SqKJaYdfDMvOuQQAV1p6DT3gz8eNkzfiZhTxjD8HpIkDKaw5WE
         sLwSeD+UGMSCfDewC8crv1chfqvPZfxxFo5dUDYR3isCMIaFbv7inPHxxEGLT9aL08um
         gWl9y70dnb/s5tI1h9s+9ddfOS/eetdL5q2NdiBOv5OGTc0G7dw1xlPwFt7oB7UW0B1H
         L/TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754595627; x=1755200427;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sNdBwl8v2OqAa3v0ByxYoV2FZHtZfSuaaApNKvSqvMU=;
        b=rxK8I7nBt7rtyoH7DILvdVcCPW0yspC6O0V1YRi8oon8fzrhv/rsEpohHm9HBbug7v
         PHJsCh4uhcRWsx5eu6lI5Oqq7Zxh0pihh43UmNjiNMffnPXdvAFgOeXjtEPJ3f5QOQB1
         ohhurmicCi/06MJXXwoxvSa5XKFtcy/hgM/D5Mpw5iFMirf0GgBeVkEnfLKs97cJUd/B
         wbv176IAa23LVhtZNl0Hc0Xeodrhjk8OaGbp/Urn3/+EbDvzuOFI/ZQLsq9FjmFEYJpb
         2voJLwVOapyQ2k/BWPaezmOP7PmRWtl18sLfx2GJM+FJX+/MBtrmPX5z8u+/+TTJs7/p
         KWHQ==
X-Forwarded-Encrypted: i=1; AJvYcCXAWCkJlHoWqiSw/+TBaYYR6IcxV5HxHD6BPU8UhWh4Q4Vrq6rr4hYyjZSoNiAZAmWXKoQbaONy4gQ=@lists.infradead.org, AJvYcCXDw7L/B/X+ozEIUdlcQN5oXXG91wGrGBZqqRzMMuSEgmwvplAbge9b85Fg3PIZFne/hXMCv4VDZgn/24c=@lists.infradead.org, AJvYcCXrdpiKfGXMsTmOmTxgsKxeGfDtKLY75uYbrTy0JF+/IbkEE9335pUVAX8hTjueCu4sltaIU4EWEi9CMaaoxdBV@lists.infradead.org
X-Gm-Message-State: AOJu0YwXfvtP+hiCAqwazCJaRMyNS8QSaNrlWJepIDSKjJEZWnTj6kwy
	pMLxmjb7VcS2KreFCRJyHeW4FmbWgqRvKw+m97Dtkn4GkViZtoreWpUf
X-Gm-Gg: ASbGncvBoPEi1rYIC4Gj3WgBnJqzMqB3noPqAMlTgMjmRbHk0kJ45nDaz76Pu5sYzKJ
	tTOUgrhaAOAyvYFrPpn8vs3kLETo3BH8JYvyRx4tBGVR3rzwSLITYwyRjDjM421UeUTtg3xJ6UP
	+ARZgdVUEPpfY0UK9I6uPO25nhy7lNrxD9I6I4/jyWi2+8dmSS+ZufhCnGtcwkxs1aGZxLozu6U
	5N7CdojOKwY4aUs27LJOtcK93wCxO3q+bqJjMiBfAFMbtjE9HlUs5V+FNq3tCkLHzMHftEOOjnq
	O3N/fKybWl9r+uNfbuMoR6sE67OHocMtjMwUk7S703C0/+0weCSfTuyvFbZAWifpdxR0+0phOhr
	G0phbd+VVHKTDGcEq+fTZmsJnkNq6V+ZGBxQvGo6yKs6lwssTM7ko0sR5Kxz+Uin5CuzsAg==
X-Google-Smtp-Source: AGHT+IFy1K+04TTf6HeQynR9tEb65FcTbYVkR/07BpvyTspaDpSD1TTrgV/AzkLRIY/TwnnFAN629A==
X-Received: by 2002:ac2:4e14:0:b0:55b:8f46:80ed with SMTP id 2adb3069b0e04-55cc00e3a66mr10263e87.21.1754595627098;
        Thu, 07 Aug 2025 12:40:27 -0700 (PDT)
Received: from localhost.localdomain (178.90.89.143.dynamic.telecom.kz. [178.90.89.143])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55b88c98c2asm2793570e87.77.2025.08.07.12.40.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Aug 2025 12:40:26 -0700 (PDT)
From: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
To: ryabinin.a.a@gmail.com,
	bhe@redhat.com,
	hca@linux.ibm.com,
	christophe.leroy@csgroup.eu,
	andreyknvl@gmail.com,
	akpm@linux-foundation.org,
	zhangqing@loongson.cn,
	chenhuacai@loongson.cn,
	davidgow@google.co,
	glider@google.com,
	dvyukov@google.com
Cc: alex@ghiti.fr,
	agordeev@linux.ibm.com,
	vincenzo.frascino@arm.com,
	elver@google.com,
	kasan-dev@googlegroups.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev,
	linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	linux-um@lists.infradead.org,
	linux-mm@kvack.org,
	snovitoll@gmail.com,
	Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: [PATCH v5 2/2] kasan: call kasan_init_generic in kasan_init
Date: Fri,  8 Aug 2025 00:40:12 +0500
Message-Id: <20250807194012.631367-3-snovitoll@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250807194012.631367-1-snovitoll@gmail.com>
References: <20250807194012.631367-1-snovitoll@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250807_124029_039454_2EB35C3C 
X-CRM114-Status: GOOD (  14.49  )
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
For architectures that do not select ARCH_DEFER_KASAN,
this will be a no-op for the runtime flag but will
print the initialization banner.

For SW_TAGS and HW_TAGS modes, their respective init functions will
handle the flag enabling, if they are enabled/implemented.

Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217049
Signed-off-by: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
Tested-by: Alexandre Ghiti <alexghiti@rivosinc.com> # riscv
Acked-by: Alexander Gordeev <agordeev@linux.ibm.com> # s390
---
Changes in v5:
- Unified arch patches into a single one, where we just call
	kasan_init_generic()
- Added Tested-by tag for riscv (tested the same change in v4)
- Added Acked-by tag for s390 (tested the same change in v4)
---
 arch/arm/mm/kasan_init.c    | 2 +-
 arch/arm64/mm/kasan_init.c  | 4 +---
 arch/riscv/mm/kasan_init.c  | 1 +
 arch/s390/kernel/early.c    | 3 ++-
 arch/x86/mm/kasan_init_64.c | 2 +-
 arch/xtensa/mm/kasan_init.c | 2 +-
 6 files changed, 7 insertions(+), 7 deletions(-)

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
diff --git a/arch/riscv/mm/kasan_init.c b/arch/riscv/mm/kasan_init.c
index 41c635d6aca..ba2709b1eec 100644
--- a/arch/riscv/mm/kasan_init.c
+++ b/arch/riscv/mm/kasan_init.c
@@ -530,6 +530,7 @@ void __init kasan_init(void)
 
 	memset(kasan_early_shadow_page, KASAN_SHADOW_INIT, PAGE_SIZE);
 	init_task.kasan_depth = 0;
+	kasan_init_generic();
 
 	csr_write(CSR_SATP, PFN_DOWN(__pa(swapper_pg_dir)) | satp_mode);
 	local_flush_tlb_all();
diff --git a/arch/s390/kernel/early.c b/arch/s390/kernel/early.c
index 9adfbdd377d..544e5403dd9 100644
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
 
diff --git a/arch/x86/mm/kasan_init_64.c b/arch/x86/mm/kasan_init_64.c
index 0539efd0d21..998b6010d6d 100644
--- a/arch/x86/mm/kasan_init_64.c
+++ b/arch/x86/mm/kasan_init_64.c
@@ -451,5 +451,5 @@ void __init kasan_init(void)
 	__flush_tlb_all();
 
 	init_task.kasan_depth = 0;
-	pr_info("KernelAddressSanitizer initialized\n");
+	kasan_init_generic();
 }
diff --git a/arch/xtensa/mm/kasan_init.c b/arch/xtensa/mm/kasan_init.c
index f39c4d83173..0524b9ed5e6 100644
--- a/arch/xtensa/mm/kasan_init.c
+++ b/arch/xtensa/mm/kasan_init.c
@@ -94,5 +94,5 @@ void __init kasan_init(void)
 
 	/* At this point kasan is fully initialized. Enable error messages. */
 	current->kasan_depth = 0;
-	pr_info("KernelAddressSanitizer initialized\n");
+	kasan_init_generic();
 }
-- 
2.34.1


