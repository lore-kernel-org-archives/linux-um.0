Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8315CC83F34
	for <linux-um@archiver.kernel.org>; Thu, 17 Jul 2025 15:03:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9U6pXPOm17QNJUh3dL0X5SvDfkuBM+kFPXcpz1Z7hWM=; b=WpEA16RiJYgIfG4SLfgB4so1VK
	kckmp60tAA7qFkdxbX/yRxRwbkuYFIYlxP22ZokVcmLpC1V5E5fHaQ/969oyB14zm2ZqOTzTo0b+a
	vvNklq7Q62oWWK2QHH8tWMBoTdsx8ZMbtR9AuvcDxGXMj4eaMuBKzZupc7Tx/iF1tq4p7L+B+h/IR
	7XSxbfRGa0K9QKKrUYULnI8PaYKGkoZPHXwQUDmm/FPESgBv2Ya9kzHbVW2m8UrT2p/xkyj+4QAGt
	jVwKlkSCteJ58Mlu+wQPuR7whtdR1mJF7s4itYSbDS4U8xvDEB7f77cyZ7OTYPMICWdgdmCj4NjOJ
	6KqfZpQw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ucQ90-0000000ASA4-0zbA;
	Thu, 17 Jul 2025 15:03:34 +0000
Received: from mail-lf1-x12e.google.com ([2a00:1450:4864:20::12e])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ucPaS-0000000AMxu-2Hc2;
	Thu, 17 Jul 2025 14:27:53 +0000
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-553d771435fso1179094e87.3;
        Thu, 17 Jul 2025 07:27:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752762471; x=1753367271; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9U6pXPOm17QNJUh3dL0X5SvDfkuBM+kFPXcpz1Z7hWM=;
        b=Xgy0gKFQ6sEzfFsHWpwQ4HG2PNDnsKbo9T3CAEw5gF97ptUF7ra+1CAccuYUbAPUQM
         UEiwk5iBgNLj4i8hTfQdPfADYf9BLOhCjx6EalsbOZ/2Fxl6/xwVjBx2Aiv9G2Fi049i
         0vfoz0bpS2hmGT8MFAA31PX0N1+92grLnWXSG5ZlyiZiuBBrN5La83morEV3RaH4LnBV
         0ZJp2n21NqODTWdqWliyyBHIygaVi1U//phIyab5QXKdWLP1bshbPNuxkn0MHZ3TEoj6
         EefFLoXhl8FNIwYxtK9n3Qxv/A9hqeWAsuLPieYi/xa1C9gLK/+CDu9mZyejAh9eK0Jz
         ga4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752762471; x=1753367271;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9U6pXPOm17QNJUh3dL0X5SvDfkuBM+kFPXcpz1Z7hWM=;
        b=oml5g9YImPEQZI6t4ZprgrESM6UsRVG4/0KDfHZIeNeK7vM+Wc7UQ/8FtcLV6zcr/c
         Vdw7cZAwXPPR4r5A/GiatonrpqAb1Sj8ucUEquDHAd0Cz8sAFF7WlhiFt0trNXhMAKcl
         DYR3RjR70A0/DmvL1FW2SSh6u4vZdc5ZhbyA7q0uxdrWF28lnHSUQeVMcEm7DtWDjO86
         XW1cvyvaNilD0P9VT9aRxOdc0NxA6R4AnSIyCcz1Tjhhh0Q+dv4zfD2aVZEZV6/ie1es
         ozzqldTlP5JwK9EdduZnrzrdIWL1OKIYMib6GtCFc4qlfnpAsWiXm8AhFidfCA2cpYdh
         h2Rw==
X-Forwarded-Encrypted: i=1; AJvYcCV58Zu7P73rXTmJwsnkLAoxBFmjkFPdsGeHZnPta0AMRjd7QJzrXvqEwdD8nGn1RIZIXCEdQUh6RHqwMA==@lists.infradead.org, AJvYcCWAF3qg3z9bjpaIz386aSyDF6MM4XRVFkNGSNfEnjqd64ULC1pURrqqnXIpfd4VqKgKXJ3VnV/wd5g=@lists.infradead.org
X-Gm-Message-State: AOJu0YxjvY3gWTMOHN9nkLAN10oSQSHZ+cZfumKFHCwEOaPCghb+ETTg
	LomOoZhDQD9+z/O6MecqweWPfkLyq/qSfc06Fx4wwAGqOYC36OX/Rs4F
X-Gm-Gg: ASbGncuXSnyAUJxzbE/DWapBPbz8+qH/mrLQ0O9fyUhqQhKOQLo+dWlrEdwxcpyonzs
	4JTt0yFNkLZKFv/u0PhkA7zXVFLGEHNgy7Y6mVNNZ4WWC8GufChLHmOTgTocrQRRNhoQUmM5+W0
	NMZhb+prUwRxTfFlLeKGyhtJOBltTImcLNkgyLi9qMNrcho/8jNuulR50Oz8/oyXzEILXuc/3S0
	uZelea+s/XbEvY4mFOSUerwfjjlyWchu31aucVM+Sn4bmtH+xvD+SifLD/Jz2QPIZRGdsV8Hhto
	5J65x1EFJNVekj1s1kREQaQLkE+0X5hcxeKAH5U03MPvd4Yf7lqp3IMNLUJKf4XOtSKoFLw80nF
	+KYtvFDvRlXnHMYtwtkLEaIoMfxcsaEId8n2PpLi+dUONOHRS3mVqNkFGUj4QJsWc4sI3
X-Google-Smtp-Source: AGHT+IFxg66CFuCFZcq7YEHf2jsYRpZfJ3opYk2GjZt6qN26RYtZXaN505yqdxOnxSgHLvlINQObtg==
X-Received: by 2002:a05:6512:78a:b0:553:2868:635c with SMTP id 2adb3069b0e04-55a233db5f5mr1804298e87.48.1752762470559;
        Thu, 17 Jul 2025 07:27:50 -0700 (PDT)
Received: from localhost.localdomain (178.90.89.143.dynamic.telecom.kz. [178.90.89.143])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55989825fe3sm3022975e87.223.2025.07.17.07.27.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 07:27:49 -0700 (PDT)
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
Subject: [PATCH v3 03/12] kasan/powerpc: select ARCH_DEFER_KASAN and call kasan_init_generic
Date: Thu, 17 Jul 2025 19:27:23 +0500
Message-Id: <20250717142732.292822-4-snovitoll@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250717142732.292822-1-snovitoll@gmail.com>
References: <20250717142732.292822-1-snovitoll@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250717_072752_581387_886A58E8 
X-CRM114-Status: GOOD (  12.73  )
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

PowerPC with radix MMU is the primary architecture that needs deferred
KASAN initialization, as it requires complex shadow memory setup before
KASAN can be safely enabled.

Select ARCH_DEFER_KASAN for PPC_RADIX_MMU to enable the static key
mechanism for runtime KASAN control. Other PowerPC configurations
(like book3e and 32-bit) can enable KASAN early and will use
compile-time constants instead.

Also call kasan_init_generic() which handles Generic KASAN initialization.
For PowerPC radix MMU (which selects ARCH_DEFER_KASAN), this enables
the static key. For other PowerPC variants, kasan_enable() is a no-op
and kasan_enabled() returns IS_ENABLED(CONFIG_KASAN).

Remove the PowerPC-specific static key and kasan_arch_is_ready()
implementation in favor of the unified interface.

This ensures that:
- PowerPC radix gets the runtime control it needs
- Other PowerPC variants get optimal compile-time behavior
- No unnecessary overhead is added where not needed

Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217049
Fixes: 55d77bae7342 ("kasan: fix Oops due to missing calls to kasan_arch_is_ready()")
Signed-off-by: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
---
Changes in v3:
- Added CONFIG_ARCH_DEFER_KASAN selection for PPC_RADIX_MMU only
- Kept ARCH_DISABLE_KASAN_INLINE selection since it's needed independently
---
 arch/powerpc/Kconfig                   |  1 +
 arch/powerpc/include/asm/kasan.h       | 12 ------------
 arch/powerpc/mm/kasan/init_32.c        |  2 +-
 arch/powerpc/mm/kasan/init_book3e_64.c |  2 +-
 arch/powerpc/mm/kasan/init_book3s_64.c |  6 +-----
 5 files changed, 4 insertions(+), 19 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index c3e0cc83f12..e5a6aae6a77 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -123,6 +123,7 @@ config PPC
 	#
 	select ARCH_32BIT_OFF_T if PPC32
 	select ARCH_DISABLE_KASAN_INLINE	if PPC_RADIX_MMU
+	select ARCH_DEFER_KASAN			if PPC_RADIX_MMU
 	select ARCH_DMA_DEFAULT_COHERENT	if !NOT_COHERENT_CACHE
 	select ARCH_ENABLE_MEMORY_HOTPLUG
 	select ARCH_ENABLE_MEMORY_HOTREMOVE
diff --git a/arch/powerpc/include/asm/kasan.h b/arch/powerpc/include/asm/kasan.h
index b5bbb94c51f..957a57c1db5 100644
--- a/arch/powerpc/include/asm/kasan.h
+++ b/arch/powerpc/include/asm/kasan.h
@@ -53,18 +53,6 @@
 #endif
 
 #ifdef CONFIG_KASAN
-#ifdef CONFIG_PPC_BOOK3S_64
-DECLARE_STATIC_KEY_FALSE(powerpc_kasan_enabled_key);
-
-static __always_inline bool kasan_arch_is_ready(void)
-{
-	if (static_branch_likely(&powerpc_kasan_enabled_key))
-		return true;
-	return false;
-}
-
-#define kasan_arch_is_ready kasan_arch_is_ready
-#endif
 
 void kasan_early_init(void);
 void kasan_mmu_init(void);
diff --git a/arch/powerpc/mm/kasan/init_32.c b/arch/powerpc/mm/kasan/init_32.c
index 03666d790a5..1d083597464 100644
--- a/arch/powerpc/mm/kasan/init_32.c
+++ b/arch/powerpc/mm/kasan/init_32.c
@@ -165,7 +165,7 @@ void __init kasan_init(void)
 
 	/* At this point kasan is fully initialized. Enable error messages */
 	init_task.kasan_depth = 0;
-	pr_info("KASAN init done\n");
+	kasan_init_generic();
 }
 
 void __init kasan_late_init(void)
diff --git a/arch/powerpc/mm/kasan/init_book3e_64.c b/arch/powerpc/mm/kasan/init_book3e_64.c
index 60c78aac0f6..0d3a73d6d4b 100644
--- a/arch/powerpc/mm/kasan/init_book3e_64.c
+++ b/arch/powerpc/mm/kasan/init_book3e_64.c
@@ -127,7 +127,7 @@ void __init kasan_init(void)
 
 	/* Enable error messages */
 	init_task.kasan_depth = 0;
-	pr_info("KASAN init done\n");
+	kasan_init_generic();
 }
 
 void __init kasan_late_init(void) { }
diff --git a/arch/powerpc/mm/kasan/init_book3s_64.c b/arch/powerpc/mm/kasan/init_book3s_64.c
index 7d959544c07..dcafa641804 100644
--- a/arch/powerpc/mm/kasan/init_book3s_64.c
+++ b/arch/powerpc/mm/kasan/init_book3s_64.c
@@ -19,8 +19,6 @@
 #include <linux/memblock.h>
 #include <asm/pgalloc.h>
 
-DEFINE_STATIC_KEY_FALSE(powerpc_kasan_enabled_key);
-
 static void __init kasan_init_phys_region(void *start, void *end)
 {
 	unsigned long k_start, k_end, k_cur;
@@ -92,11 +90,9 @@ void __init kasan_init(void)
 	 */
 	memset(kasan_early_shadow_page, 0, PAGE_SIZE);
 
-	static_branch_inc(&powerpc_kasan_enabled_key);
-
 	/* Enable error messages */
 	init_task.kasan_depth = 0;
-	pr_info("KASAN init done\n");
+	kasan_init_generic();
 }
 
 void __init kasan_early_init(void) { }
-- 
2.34.1


