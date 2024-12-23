Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B29DE7718D
	for <linux-um@archiver.kernel.org>; Mon, 23 Dec 2024 11:06:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qA0mhWnXo6upWemI3POPEc6VJyAkyxFJggkOB6WNq2k=; b=GlVHPTffbwvzgpHM7nkMPAO3ld
	MvYvMtO1yBqJKu4IyHDp6b7JbvnaKZrgQkI2JeYutPPS0D/iGgT0+KOqTScZMPHhjJ8M6BuProuno
	/bMN7aMcPqxNByAmu1FAQL1ulLz2NEiOTVbFv/XnQvAFzldnL5dgFUgzL/RYwu3V5B8P9npCCupSn
	id2N99gzTfSA3YSzAMYp9wdbCWorlhqrDxnGh9GeIRCG3T9QaPKuInAK/eRj1XjwRTRvanFj/MrfR
	FemzVTB9YWNlk9yXJRYvcRQcJ0Cb7Maf/Mp0W+V3kTWFENkw9qmGUDAoLS5/IKTSFEUcah2YtrP44
	ldlFYmnw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tPgGH-00000009qIi-3njb;
	Mon, 23 Dec 2024 11:06:09 +0000
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tPezW-00000009gq8-09Fm
	for linux-um@lists.infradead.org;
	Mon, 23 Dec 2024 09:44:47 +0000
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-72764c995e5so2420721b3a.2
        for <linux-um@lists.infradead.org>; Mon, 23 Dec 2024 01:44:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1734947085; x=1735551885; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qA0mhWnXo6upWemI3POPEc6VJyAkyxFJggkOB6WNq2k=;
        b=FE452Oqusb0rgBr6YngBczaIZtEjQK09AFdFZIxckz6Xr+PLf+KBXxu4GjmlQdbcD5
         MnwMxLVk8A2O13eLCuT1rD6LzHnfa3icb5t2bHmQ7jaU6XeqImTR+arkQ6Gma9oZBIpZ
         PyBLtSj0xITvtIpAszE8FkLmnqBtcaLkygNZ6f3KU9X3tXXbdKxMfCmUvVAsBZ7JrcX9
         jSRBaoz8CWnotjj2fOpzzV9r+RTVSguntC/dC44O+E2ceeTEoex2Ds9n8bruAdbfo9hX
         ItgWksMMWSENZmlPmTGXxggqUFfLoOF895Sj+FSe1cHC8wR9Mv/6RhCTVy686hB/8mqg
         NV0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734947085; x=1735551885;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qA0mhWnXo6upWemI3POPEc6VJyAkyxFJggkOB6WNq2k=;
        b=OKv+N8mfdluHcLq3zu9VVLzJ8188koii3J35+rCTo5CMKGWXErPKZDlycusSdjdIwD
         lEfHqVmFH4boi46Ijkq28arUuD8uB3YW2bDuslBYSGdl2A2pjc3A5RQFxrpVlgwmfFoT
         7LSOJQUR+Xw4SjYBYVV1Bx24xVyxhN3hxshEGJVieZ6yrbtW9Edi5fm5KwLrXtunGe5A
         I6LmGu58La2b0XETARRwnABndy5t04QccZ0MADcWKo4I+4iQJWSpu54EQbrdnTvDFsUZ
         BqclfSLhe/EAYD4HuqSlUMwBri+oKPlrhoVSRTByHaHwO8Fvgwro6g0JV3E+QrlyuZmP
         U1eg==
X-Forwarded-Encrypted: i=1; AJvYcCWm5u9aT0I8OUiRyObhvEG8s130auN/qmisnrab8ZdlG+gjhrQe4Uc5sHe/MVjiY8ueukNZ2o5UOw==@lists.infradead.org
X-Gm-Message-State: AOJu0YycioHSFrN6/XZgoiLWOgW8O7ctgi8DAMdlVMUgbOePHRuqHH3r
	8lDrsNUilAXlAgOtKrb6NqZY4W9NoNk5sDq6RmVuAMyCygsdWrnUQCGyUGl9K1U=
X-Gm-Gg: ASbGncvw3/WOhC5HHpbemJX7Zmkp3c+XgymuABXT/MbKoyAiWNeGkXbJfXMHR9JWxhB
	eW/jjwoF0u0nhY8L2Ntfow0fuvBeQUwqQDXFOE7r30jTsKuG3a5KyxixFCL8ehcVt69Jyn9VRrF
	hr4G2oi/467JClDejdJhtcZWYH5yzcxhj/a803Z55GD8OkxrX2dbpaSkIt6PgCll4uw0ja375Bx
	KI6OmgsYcIbfVrFHzIS0FN+VWr+LjijnTAUxkk+3HKOkIzPD/AZWaOzwtL3cN/yWoWFDhFZYQp8
	Dj9JYuSIX7JZ3JlbhJcRAw==
X-Google-Smtp-Source: AGHT+IEwnxNRxjpY566VNLJW6lRIrSoOOApqv/9DKS3yUbVNE+/391+nOnqyFIwO+T3gR5XgQach6A==
X-Received: by 2002:a05:6a00:330b:b0:728:e382:5f14 with SMTP id d2e1a72fcca58-72abdd7bae3mr14443469b3a.9.1734947085429;
        Mon, 23 Dec 2024 01:44:45 -0800 (PST)
Received: from C02DW0BEMD6R.bytedance.net ([203.208.167.150])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72aad8486c6sm7468309b3a.85.2024.12.23.01.44.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Dec 2024 01:44:45 -0800 (PST)
From: Qi Zheng <zhengqi.arch@bytedance.com>
To: peterz@infradead.org,
	agordeev@linux.ibm.com,
	kevin.brodsky@arm.com,
	tglx@linutronix.de,
	david@redhat.com,
	jannh@google.com,
	hughd@google.com,
	yuzhao@google.com,
	willy@infradead.org,
	muchun.song@linux.dev,
	vbabka@kernel.org,
	lorenzo.stoakes@oracle.com,
	akpm@linux-foundation.org,
	rientjes@google.com,
	vishal.moola@gmail.com,
	arnd@arndb.de,
	will@kernel.org,
	aneesh.kumar@kernel.org,
	npiggin@gmail.com,
	dave.hansen@linux.intel.com,
	rppt@kernel.org,
	ryan.roberts@arm.com
Cc: linux-mm@kvack.org,
	linux-arm-kernel@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	x86@kernel.org,
	linux-arch@vger.kernel.org,
	linux-csky@vger.kernel.org,
	linux-hexagon@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-m68k@lists.linux-m68k.org,
	linux-mips@vger.kernel.org,
	linux-openrisc@vger.kernel.org,
	linux-sh@vger.kernel.org,
	linux-um@lists.infradead.org,
	Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH v3 08/17] arm: pgtable: move pagetable_dtor() to __tlb_remove_table()
Date: Mon, 23 Dec 2024 17:40:54 +0800
Message-Id: <955162bfbbcd9fbb3b074e1fe2aef4f64b61d6f9.1734945104.git.zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <cover.1734945104.git.zhengqi.arch@bytedance.com>
References: <cover.1734945104.git.zhengqi.arch@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241223_014446_091180_DD9BEE65 
X-CRM114-Status: GOOD (  10.11  )
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

Move pagetable_dtor() to __tlb_remove_table(), so that ptlock and page
table pages can be freed together (regardless of whether RCU is used).
This prevents the use-after-free problem where the ptlock is freed
immediately but the page table pages is freed later via RCU.

Page tables shouldn't have swap cache, so use pagetable_free() instead of
free_page_and_swap_cache() to free page table pages.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
Suggested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: linux-arm-kernel@lists.infradead.org
---
 arch/arm/include/asm/tlb.h | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/arch/arm/include/asm/tlb.h b/arch/arm/include/asm/tlb.h
index ef79bf1e8563f..264ab635e807a 100644
--- a/arch/arm/include/asm/tlb.h
+++ b/arch/arm/include/asm/tlb.h
@@ -26,12 +26,14 @@
 
 #else /* !CONFIG_MMU */
 
-#include <linux/swap.h>
 #include <asm/tlbflush.h>
 
 static inline void __tlb_remove_table(void *_table)
 {
-	free_page_and_swap_cache((struct page *)_table);
+	struct ptdesc *ptdesc = (struct ptdesc *)_table;
+
+	pagetable_dtor(ptdesc);
+	pagetable_free(ptdesc);
 }
 
 #include <asm-generic/tlb.h>
@@ -41,8 +43,6 @@ __pte_free_tlb(struct mmu_gather *tlb, pgtable_t pte, unsigned long addr)
 {
 	struct ptdesc *ptdesc = page_ptdesc(pte);
 
-	pagetable_dtor(ptdesc);
-
 #ifndef CONFIG_ARM_LPAE
 	/*
 	 * With the classic ARM MMU, a pte page has two corresponding pmd
@@ -61,7 +61,6 @@ __pmd_free_tlb(struct mmu_gather *tlb, pmd_t *pmdp, unsigned long addr)
 #ifdef CONFIG_ARM_LPAE
 	struct ptdesc *ptdesc = virt_to_ptdesc(pmdp);
 
-	pagetable_dtor(ptdesc);
 	tlb_remove_ptdesc(tlb, ptdesc);
 #endif
 }
-- 
2.20.1


