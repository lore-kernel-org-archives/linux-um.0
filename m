Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2A9EC87FCA
	for <linux-um@archiver.kernel.org>; Sun, 10 Aug 2025 13:05:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qPUEdIdCRmt+MYJsQtBbxjY1GnPuX9CU1RwbVybqcDU=; b=X+vITWqlVV03EMOw8zHQUQydK8
	ou7Tm7DIE6ydAq3+u4+PhrCYiR+tgAu6QwwVRT4/GnRqmIhmYv0H9IwcyZoGPjfk1SBzBwdKqj2Ci
	HQEqVIfE4iT79Ze+OiSIuBGh6V9EOqsomuH4eULUYOiwBlizppBgqU7OjkmcMku3bs44F1Uz74GFF
	8JfGaZaBhLqXPZaKdXwUK5PYKJBArQ2j8D8s5Xdcfg4qlGGnWTljJw/0+drzGQoWzb1wHiRyoYebk
	gPR96JsbYMmezCeqVIb7gE11mGSL66WuCutEMH04SGM+nfvzZodpahXaytV8A4FyDT8iByu6qt5Wk
	COdoQNBg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ul5kF-00000005chU-0TDu;
	Sun, 10 Aug 2025 13:05:51 +0000
Received: from mail-lf1-x12a.google.com ([2a00:1450:4864:20::12a])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ul5cr-00000005bri-1Ypk;
	Sun, 10 Aug 2025 12:58:14 +0000
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-55b8bf653dfso3857773e87.0;
        Sun, 10 Aug 2025 05:58:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754830692; x=1755435492; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qPUEdIdCRmt+MYJsQtBbxjY1GnPuX9CU1RwbVybqcDU=;
        b=CJAnCrVCN3n3IpJQ/UsgEKqgVGg2ELfKXblFCCkdxQPseVFGOhF/bkZNrp0OHPSet9
         8RLPvb7shWfUwnXizgojyzfk0bvTJXFZNEyGJjovbsUtH9jht1v6aohcXILEbVKd4nT6
         73LwQkdv42J/VI+YRi9xwYJjIwKTUWNEHYIqVwtmg0x5Byvoo9AeQp4nYGOxV6/275y5
         CYTYiDWoxYiWdC3yyszuAOrdSYCwrA625qij9UupSTxLjQEckXE1ISh0u5aojlKCxaUr
         iZNy91rYZFDbHTaZVTZJzCXNcRu8l1QDf5CPao1qDXAQQY1quOOFrRYqMAj52A5btHAw
         0Nsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754830692; x=1755435492;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qPUEdIdCRmt+MYJsQtBbxjY1GnPuX9CU1RwbVybqcDU=;
        b=B+65oK5qRtsFFT/dCCezZ6yKyzblTAk1PlVI5ryRJBK/NTiIPfwyo1M/hlalNrytPa
         2V2Y3vP5zKBo3WKiuajeghYsuGiN93EqlRGGu4KRk0riCko6XpwIRPdyaL+MOs2ikC06
         pTZJAFzSLSkdtEmQ5JZkdGLVyhQU0UsoBwzHqGZqJhUrEUQbvloSjuH2/gobWuL86JTq
         +M7YJx2r2xVL4IjSj3Xd13E6Q6a6XITFffzJY1WRcDtMvAO13dU8DPXNySCFJ02nwZN3
         SZ5aiFicQAWnogq+dfh5IksqX1XcCNhZKoM1JyI7tybOLsHPo/MLA50z6RMMWK8/63Og
         yTJQ==
X-Forwarded-Encrypted: i=1; AJvYcCWeHvAbNuRA5X/nBfMKEjK/hK6dmQPTja5rbRBhdi5MfIvLvRxqBUiwoWG3FG2ZRXYCYhDjAWoRiv8=@lists.infradead.org, AJvYcCWhyT48sDx5bsLdTlbES23sdVKcE0xHfld+vFWo0ifPEKVuJGFdhgNCAD6WgSxKXFoF3EMZBsWu4xxSJVrgwWjX@lists.infradead.org, AJvYcCXcOpqLNeunKBdyQFbwY6/+4X7tjJOC0jOg90ugSBoTmd1HRi2VSt8Zbkao7rx17oR/Jg7SJiK9QTcZhNQ=@lists.infradead.org
X-Gm-Message-State: AOJu0YzpfW6ckHNlF51OqF2KcvpdmjTZcbu0QifPmzR65gaPO9tV1Jx5
	h5sy4TSWQBdbE7TfWb7/88SOoC1aLmxzk7lQLzrQQ0OC6/NGnmvo0oy/
X-Gm-Gg: ASbGncuAecZn1b+hP4jHqW7F/TltXtIcoZZL5CQ6ARYtKv98X4XdmvfYCbo1s/7HrHQ
	zANwgnSprOuB7tdIEzCq4UX7I6nRO7DBOkDxFyfxnzQSi7CiYcRa/vkrQ6x3g/bM9ocMKDSXFhs
	tawyQ+7Dotxwo3qmLe/TKy5++9Af6RlLBmD1Cr4i/eu2zPLI2wliFG4nKI3XLSfsEy2nu3Gql+R
	6btebNihpWIM8cqfA5QQFE6IC/SlE9lvy96YLgqEPlUiieeJYBsDNGGF3ll16vcHrQLOEtxQf0d
	8nskT67mqEAPx8y+BFgoaSLMMyUr4umrolAuh52WXaKxG87KRG/58OpQIAHvck1qJ108gnPJs3/
	re5fk1zWs3gTcElNhIM6Sp7UNKJaU8HyfwqbvFQ==
X-Google-Smtp-Source: AGHT+IFrIl3eJCoqqHt0ANltzYIq2yL9Jka0mZA2tOEeoGsTnUPJed1OxDGIgQlZCm+SP4loyYZbRA==
X-Received: by 2002:a05:6512:3502:b0:55b:732d:931 with SMTP id 2adb3069b0e04-55cc00b14c8mr2560689e87.12.1754830691289;
        Sun, 10 Aug 2025 05:58:11 -0700 (PDT)
Received: from localhost.localdomain ([2a03:32c0:2e:37dd:bfc4:9fdc:ddc6:5962])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55b88c9908esm3804561e87.76.2025.08.10.05.58.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Aug 2025 05:58:10 -0700 (PDT)
From: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
To: ryabinin.a.a@gmail.com,
	christophe.leroy@csgroup.eu,
	bhe@redhat.com,
	hca@linux.ibm.com,
	andreyknvl@gmail.com,
	akpm@linux-foundation.org,
	zhangqing@loongson.cn,
	chenhuacai@loongson.cn,
	davidgow@google.com,
	glider@google.com,
	dvyukov@google.com,
	alexghiti@rivosinc.com
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
	snovitoll@gmail.com
Subject: [PATCH v6 2/2] kasan: call kasan_init_generic in kasan_init
Date: Sun, 10 Aug 2025 17:57:46 +0500
Message-Id: <20250810125746.1105476-3-snovitoll@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250810125746.1105476-1-snovitoll@gmail.com>
References: <20250810125746.1105476-1-snovitoll@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250810_055813_408732_0FD4DDFF 
X-CRM114-Status: GOOD (  13.06  )
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
Changes in v6:
- Call kasan_init_generic() in arch/riscv _after_ local_flush_tlb_all()
---
 arch/arm/mm/kasan_init.c    | 2 +-
 arch/arm64/mm/kasan_init.c  | 4 +---
 arch/riscv/mm/kasan_init.c  | 1 +
 arch/s390/kernel/early.c    | 3 ++-
 arch/x86/mm/kasan_init_64.c | 2 +-
 arch/xtensa/mm/kasan_init.c | 2 +-
 6 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mm/kasan_init.c b/arch/arm/mm/kasan_init.c
index 111d4f703136..c6625e808bf8 100644
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
index d541ce45daeb..abeb81bf6ebd 100644
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
index 41c635d6aca4..c4a2a9e5586e 100644
--- a/arch/riscv/mm/kasan_init.c
+++ b/arch/riscv/mm/kasan_init.c
@@ -533,4 +533,5 @@ void __init kasan_init(void)
 
 	csr_write(CSR_SATP, PFN_DOWN(__pa(swapper_pg_dir)) | satp_mode);
 	local_flush_tlb_all();
+	kasan_init_generic();
 }
diff --git a/arch/s390/kernel/early.c b/arch/s390/kernel/early.c
index 9adfbdd377dc..544e5403dd91 100644
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
index 0539efd0d216..998b6010d6d3 100644
--- a/arch/x86/mm/kasan_init_64.c
+++ b/arch/x86/mm/kasan_init_64.c
@@ -451,5 +451,5 @@ void __init kasan_init(void)
 	__flush_tlb_all();
 
 	init_task.kasan_depth = 0;
-	pr_info("KernelAddressSanitizer initialized\n");
+	kasan_init_generic();
 }
diff --git a/arch/xtensa/mm/kasan_init.c b/arch/xtensa/mm/kasan_init.c
index f39c4d83173a..0524b9ed5e63 100644
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


