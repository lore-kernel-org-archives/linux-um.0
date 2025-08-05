Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53FC6C87FDA
	for <linux-um@archiver.kernel.org>; Tue,  5 Aug 2025 15:38:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=44Cef9kvp87sJdDYN0I0T3XW3v08YaC6etU0qwyWC00=; b=Eln+qSjWEWaH+8J4CzD2YBfQ0l
	jo0o6WIJXc1qbkevgbDAs8V7s4IgS5pzfhgSazevhrhR8WsG2Kd0JSrVSS0S99jFXBUcvDltKCXQf
	sbSCYYFZ33pjqhiSOInZUEthIKUkFjuaveaByArux+yuVNlq4xU/M6NtJYRUkRhSfvSwlhuT5LUrD
	5JOtHD5Vrujh4aSAzYbgBtXrT/WMNkleIj4Qsjaoh0voxdi+vjJrVm4ZGuS5KTNLhAp0/h0JmqC3P
	isd9PVaAO7YelxvUP63k5EG5mCamfYvwVYlQ+Q5mgMXCk2j4gMil7xDkwTmQjiezDEgiJVf8FugN3
	6DRFA7gw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ujJkY-0000000DAYD-0Bu0;
	Tue, 05 Aug 2025 15:38:50 +0000
Received: from mail-lf1-x134.google.com ([2a00:1450:4864:20::134])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ujIcd-0000000D0R1-1rZP;
	Tue, 05 Aug 2025 14:26:36 +0000
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-55b847a061dso6301786e87.1;
        Tue, 05 Aug 2025 07:26:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754403994; x=1755008794; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=44Cef9kvp87sJdDYN0I0T3XW3v08YaC6etU0qwyWC00=;
        b=eFVjNCm2wEf82IdoFnBaMTacWqE2jYUzyrh4I3EZqb7n5aL321dIb7j4EIMS4pCmvg
         bmy8CbMr9ZzUPODvTZ/G1I2d2zXKPQXLthnBPYT2aOr9+0I9xMz2/e5sPlsjjMgKlDTz
         ZHFs21VEFP7ChfMJKlFJ3hxpCh8mN5sz0cvuOeJ8vfYb7xOVyysAKp/ThqH1VC7yCza+
         wFmyvf/adfhr2LGVJmANXPgxc/k6XMD92e9+qGXbziXKfyzv8CMvJmbFpHkqGW1vsvvq
         19AfVl3aHlqiX6WlfKeqqsZfLJMGJ1zVBp42Bh1WJXgnK4xNJTzTyyDZy8VDHKJA7r/c
         PE7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754403994; x=1755008794;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=44Cef9kvp87sJdDYN0I0T3XW3v08YaC6etU0qwyWC00=;
        b=G3Yy4HBX0U30xyUnk4FnUCicbXUgbiap967mlAlueDrHb6IjXVKRSVHJBDVCxfwHTt
         3zzV5BUSnB/bdnViD2hN2zocUcRsnWPmOgl0yZeOY8gjjct47gmfZn1u3Q8AzKUpz/Vc
         j/LQFSTgKzg6HGln1+f7C7hcMzmBClR26U1pDnhILTou5HFH8SIdz1uujowv+RvKCcSW
         4BMOs+HhMGeGsNzXaZyQ2x/XlvjZTOAl9JzNVKPL3syyBZvE9/nOxz5gsN0X9+F/6uL3
         c75vPh1h6uK3yzvWYM2DA7sJtTAWfavloVGuTuXUBDpfEdEBctM0XgCAIfXe+GDRBsPq
         YcSA==
X-Forwarded-Encrypted: i=1; AJvYcCWrLS+D83LdlSCWWNx1H/ZRNF5H7YZfy/YQ0T+x/IW7yB36ACEXHRxzNAlE95ZZ+FcijHnohHw+Dfc=@lists.infradead.org, AJvYcCX1Qbnxlz6C5+I5BsBy0biNou8dVEUVxJvhLk5QMoCrAchs2JboaLjw+MtBbpeUVEQfeqW2HmQfFjFLZQ==@lists.infradead.org
X-Gm-Message-State: AOJu0Yw6pVMqLb2aub2GCXPhvJqRPeWmRv/MlzGq2y7u3UY+L7NvcV6i
	mLkHWar8cvt0Bi4/FrknZeW85CZ7l9l34VXpWTbxTX9s0G3voKWbA6ua
X-Gm-Gg: ASbGncvVeocliBFVh5xg2MLWnX4zW71m/R14nAZM5GDcf0vQpatFy/ntVdlplykmWqq
	MQyT88VWJ1A1I9hIavSwNEoEmLBxB0IrwnmVDTsqt7azVjv1gErg8QMVWRUzZW2YTL4a9U+8itV
	uzJoZhgCTANkk5wEYB8NSfBhvSQJdDQs5N/yRlfUCQzyVKxuhiQcYd89nPxbx57+ZCHcquAxI48
	OvvYutGrojf6UNQI6ZNZEukwes31/oyBNp9Wl6Yi2jw01fsbmoi+YfKhtrrzttGqc6miFUMQMRr
	f1qns1IqlBa70Ya/ZOlAdQgymXYdiFda0genufc8888uSeXG2pHIU/01G3xZsJGz0cjDB6Z2OHf
	qbWKpi8uhH39Ifvw1vlJKokgDVE8RLjnUd2qf2FhU07fNc/kyuVmMKwfqaHM4IJtoQ7fgIA==
X-Google-Smtp-Source: AGHT+IG3IvKFDzWW1UJXkvwSM56EKK5Kb8nNkpLL/WnL+raFeiYW6aZ7Xti28XnaNJYqXW0SrOWKyA==
X-Received: by 2002:a05:6512:4023:b0:55b:81de:3576 with SMTP id 2adb3069b0e04-55bab40c2d5mr1298432e87.24.1754403993514;
        Tue, 05 Aug 2025 07:26:33 -0700 (PDT)
Received: from localhost.localdomain (178.90.89.143.dynamic.telecom.kz. [178.90.89.143])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55b889a290fsm1976379e87.54.2025.08.05.07.26.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Aug 2025 07:26:33 -0700 (PDT)
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
Subject: [PATCH v4 2/9] kasan/powerpc: select ARCH_DEFER_KASAN and call kasan_init_generic
Date: Tue,  5 Aug 2025 19:26:15 +0500
Message-Id: <20250805142622.560992-3-snovitoll@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250805142622.560992-1-snovitoll@gmail.com>
References: <20250805142622.560992-1-snovitoll@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250805_072635_483818_62B508FA 
X-CRM114-Status: GOOD (  12.58  )
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

Remove the PowerPC-specific static key and kasan_arch_is_ready()
implementation in favor of the unified interface.

Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217049
Fixes: 55d77bae7342 ("kasan: fix Oops due to missing calls to kasan_arch_is_ready()")
Signed-off-by: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
---
 arch/powerpc/Kconfig                   |  1 +
 arch/powerpc/include/asm/kasan.h       | 12 ------------
 arch/powerpc/mm/kasan/init_32.c        |  2 +-
 arch/powerpc/mm/kasan/init_book3e_64.c |  2 +-
 arch/powerpc/mm/kasan/init_book3s_64.c |  6 +-----
 5 files changed, 4 insertions(+), 19 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 93402a1d9c9..11c8ef2d88e 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -122,6 +122,7 @@ config PPC
 	# Please keep this list sorted alphabetically.
 	#
 	select ARCH_32BIT_OFF_T if PPC32
+	select ARCH_DEFER_KASAN			if PPC_RADIX_MMU
 	select ARCH_DISABLE_KASAN_INLINE	if PPC_RADIX_MMU
 	select ARCH_DMA_DEFAULT_COHERENT	if !NOT_COHERENT_CACHE
 	select ARCH_ENABLE_MEMORY_HOTPLUG
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


