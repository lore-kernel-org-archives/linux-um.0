Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF08FE7718F
	for <linux-um@archiver.kernel.org>; Mon, 30 Dec 2024 09:13:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=t6vBY23hDAeU19z0pXyQ9vuAeZavJyfGUN8npoqwlxU=; b=lludXpHtYoae6s2serBsrqKvYK
	9et8cHcHCa9+3EWd7JGlQ4dHXwkivxZ0FaRgXVY1HzjfHVaE1ZKkIfoQhL/N3zOGdYpX8pZVoL1Sp
	5L2oDEr4dfgJEkrWsSGtCHcz/sXKPli8Q/Yww+b9FLkAPFsyItD8YprxEyKNCrhKU7Ioddde90GDI
	bV2SniI2MjrX2ev5083HFn71I1hm2ErDTJ17ENhb/SGA78bcdXPSKTiuBB4l2gdqyuPybzkPKofUh
	RGeIbUnjRzoDw8EUxqT6uPdnT2zngQk5pfFjR4xd3axpQU4PiN6IWpdVPBjKvniXbeJdeNxB9MxBc
	pkoWCfzQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tSBqK-00000004ty1-2bMV;
	Mon, 30 Dec 2024 09:13:44 +0000
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tSBmF-00000004s32-0AJW
	for linux-um@lists.infradead.org;
	Mon, 30 Dec 2024 09:09:32 +0000
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-21644aca3a0so17733155ad.3
        for <linux-um@lists.infradead.org>; Mon, 30 Dec 2024 01:09:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1735549770; x=1736154570; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t6vBY23hDAeU19z0pXyQ9vuAeZavJyfGUN8npoqwlxU=;
        b=PsHzQczHTywBhKIG1SYlzIvd3ZgE09p7FIYyY/cmmUmQwRCq0TBIc51jb2E2tLp7OG
         yQeHb99auymz0Ut+poTbXEXZJE6+jDJwkwgKqoRObyDTwzsJ2DFYPYJyyPJ7bZX72HCT
         sw8uYLW+qN03e78uhkTUXPwGfGnlR12msd//6BgR0DcqC2G+Fe0VY12IJHBSMPBsUAYL
         gEgE37Qz1sEhSkd62FNIASSbpLW97m5zlGHmmphD6mLpgA+/XdkRnkCE56+GOMkkLVEn
         FZ7l64o7IihZ/DBVatP/Ty/8oZqSiTVMCfPRhzGBUbw0EPjCh5JwPcL0u/nmCMRPc77Q
         Xhug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735549770; x=1736154570;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t6vBY23hDAeU19z0pXyQ9vuAeZavJyfGUN8npoqwlxU=;
        b=Fcg9IUBeN4aY3h6ZGRz8RSbFsfyNBLEHxf8l8DgnHUpnE8rsuPAJ+7xZZCSoiQw50+
         A9KIt5vQeZrCNk2PbHTCWMh07tShgp7MliPPqE0yx7Xr1UWU3KfIOeOUA1lWovjjlbhy
         rx6rvSJ3TZ859a/3tPj3hh4LXy9KACSsWvS8n4qeYntDpTesuyNE1pQIxlueRm6BZFB3
         Y7nUIZ0nPL4nRjEDIG7nvuW5sw0hzu29VnDe2B5kAvziFjnTCkq6Sm2WTT5AWIxSc3oY
         NrvPYIowaTtaZjiAQOOt1sQOHM0pwCGrxhk5JrPqJXRghbDesZ2nQk4QbSFhoXL99sx9
         BDMA==
X-Forwarded-Encrypted: i=1; AJvYcCWnCvh/NUeRn2lwk8wUVW83vF8gTh1DQuneITJe09QyMGAmNzlNE65513ocHQva0SGqIDD7zXLnxg==@lists.infradead.org
X-Gm-Message-State: AOJu0Yz5cBhpeFm6mW6p1Hx5LIAEe/FxTVJSNGXwSb1vmxJAjVnUHhYi
	nV90i5D4k4vZ39ewDpq6SR8NxuQJY7k4RgbtJb7KLUQp/AdNzaJvt4uuTPal5iQ=
X-Gm-Gg: ASbGncs/R3J3zEwRx2ztFKNEgQSZzmpFQWvkhoKLnlcayLPBq6c1DLm8+prLPXVQmJW
	Xub3WOaksc9ZOVvLSmY1MnzhwE8adbG8k9dSqcnxB5StcmXT5bwmZezHFOGzfuTERXMc84r0Qqy
	/lOnZH4THtmeFUOe24OBVFSgJIxvEraoxK1Dfn3LONh+69ASwTGHeP3cchYZjm8w4EqbCzFfydU
	dcv6PUcRfBKwMapmpPF/NU9t1WVXJ9mb8DlSr9/Hq2LN7MmqmAQLAiMyK6dm2Fiuqymw3RZZVDu
	yu06LocmWNtajqoaAFqi6g==
X-Google-Smtp-Source: AGHT+IFhgZxpyzdRj713xWVIn5lnq5dMIdipHJPkhLMIEEbSziCo236oEOGt7kn6Wpg3lXZNnJqwCQ==
X-Received: by 2002:a05:6a21:1517:b0:1e1:adb9:d1a6 with SMTP id adf61e73a8af0-1e5e08439e8mr55857078637.41.1735549770532;
        Mon, 30 Dec 2024 01:09:30 -0800 (PST)
Received: from C02DW0BEMD6R.bytedance.net ([203.208.167.150])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-842aba72f7csm17057841a12.4.2024.12.30.01.09.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Dec 2024 01:09:30 -0800 (PST)
From: Qi Zheng <zhengqi.arch@bytedance.com>
To: peterz@infradead.org,
	agordeev@linux.ibm.com,
	kevin.brodsky@arm.com,
	palmer@dabbelt.com,
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
Subject: [PATCH v4 04/15] mm: pgtable: add statistics for P4D level page table
Date: Mon, 30 Dec 2024 17:07:39 +0800
Message-Id: <2fa644e37ab917292f5c342e40fa805aa91afbbd.1735549103.git.zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <cover.1735549103.git.zhengqi.arch@bytedance.com>
References: <cover.1735549103.git.zhengqi.arch@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241230_010931_080294_E2817552 
X-CRM114-Status: GOOD (  11.89  )
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

Like other levels of page tables, add statistics for P4D level page table.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
Originally-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/riscv/include/asm/pgalloc.h |  6 +++++-
 arch/x86/mm/pgtable.c            |  3 +++
 include/asm-generic/pgalloc.h    |  2 ++
 include/linux/mm.h               | 16 ++++++++++++++++
 4 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/include/asm/pgalloc.h b/arch/riscv/include/asm/pgalloc.h
index 551d614d3369c..3466fbe2e508d 100644
--- a/arch/riscv/include/asm/pgalloc.h
+++ b/arch/riscv/include/asm/pgalloc.h
@@ -108,8 +108,12 @@ static inline void __pud_free_tlb(struct mmu_gather *tlb, pud_t *pud,
 static inline void __p4d_free_tlb(struct mmu_gather *tlb, p4d_t *p4d,
 				  unsigned long addr)
 {
-	if (pgtable_l5_enabled)
+	if (pgtable_l5_enabled) {
+		struct ptdesc *ptdesc = virt_to_ptdesc(p4d);
+
+		pagetable_p4d_dtor(ptdesc);
 		riscv_tlb_remove_ptdesc(tlb, virt_to_ptdesc(p4d));
+	}
 }
 #endif /* __PAGETABLE_PMD_FOLDED */
 
diff --git a/arch/x86/mm/pgtable.c b/arch/x86/mm/pgtable.c
index 69a357b15974a..3d6e84da45b24 100644
--- a/arch/x86/mm/pgtable.c
+++ b/arch/x86/mm/pgtable.c
@@ -94,6 +94,9 @@ void ___pud_free_tlb(struct mmu_gather *tlb, pud_t *pud)
 #if CONFIG_PGTABLE_LEVELS > 4
 void ___p4d_free_tlb(struct mmu_gather *tlb, p4d_t *p4d)
 {
+	struct ptdesc *ptdesc = virt_to_ptdesc(p4d);
+
+	pagetable_p4d_dtor(ptdesc);
 	paravirt_release_p4d(__pa(p4d) >> PAGE_SHIFT);
 	paravirt_tlb_remove_table(tlb, virt_to_page(p4d));
 }
diff --git a/include/asm-generic/pgalloc.h b/include/asm-generic/pgalloc.h
index 59131629ac9cc..bb482eeca0c3e 100644
--- a/include/asm-generic/pgalloc.h
+++ b/include/asm-generic/pgalloc.h
@@ -230,6 +230,7 @@ static inline p4d_t *__p4d_alloc_one_noprof(struct mm_struct *mm, unsigned long
 	if (!ptdesc)
 		return NULL;
 
+	pagetable_p4d_ctor(ptdesc);
 	return ptdesc_address(ptdesc);
 }
 #define __p4d_alloc_one(...)	alloc_hooks(__p4d_alloc_one_noprof(__VA_ARGS__))
@@ -247,6 +248,7 @@ static inline void __p4d_free(struct mm_struct *mm, p4d_t *p4d)
 	struct ptdesc *ptdesc = virt_to_ptdesc(p4d);
 
 	BUG_ON((unsigned long)p4d & (PAGE_SIZE-1));
+	pagetable_p4d_dtor(ptdesc);
 	pagetable_free(ptdesc);
 }
 
diff --git a/include/linux/mm.h b/include/linux/mm.h
index c49bc7b764535..5d82f42ddd5cc 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3175,6 +3175,22 @@ static inline void pagetable_pud_dtor(struct ptdesc *ptdesc)
 	lruvec_stat_sub_folio(folio, NR_PAGETABLE);
 }
 
+static inline void pagetable_p4d_ctor(struct ptdesc *ptdesc)
+{
+	struct folio *folio = ptdesc_folio(ptdesc);
+
+	__folio_set_pgtable(folio);
+	lruvec_stat_add_folio(folio, NR_PAGETABLE);
+}
+
+static inline void pagetable_p4d_dtor(struct ptdesc *ptdesc)
+{
+	struct folio *folio = ptdesc_folio(ptdesc);
+
+	__folio_clear_pgtable(folio);
+	lruvec_stat_sub_folio(folio, NR_PAGETABLE);
+}
+
 extern void __init pagecache_init(void);
 extern void free_initmem(void);
 
-- 
2.20.1


