Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2379EE7718E
	for <linux-um@archiver.kernel.org>; Mon, 23 Dec 2024 09:59:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FItpERzyh1wDMphf2PSqriZlspFkmpQlPhA2jGTCtDU=; b=i8w1klgR2eyGb46J9cJ1NKr2Mt
	UnaVzeE7F8z/38tQOwX6glj+8S2oMf/KIF7nEyg7oP0/RF+wL5SdI3oVTz9CfIgXTB2VoHcffvQ92
	SqWLeOKaG/49FBGAB/Blw5PYtd3VuQ0/zS73u/yy4ppKZwHzTt3ufiAhfyR6MzXHp2uG8hT+oldrj
	R0SzPHu/ln/PO38FQKWUDw4TXLtg9c+GSnJ2wdXFwstCm0i8pQN/1JGE22rkc19W3/UqGeq7rqlR6
	XjM4hxy4bu54ooqDEXXQ4smoHSo3q8bM3B40GjRInUlz6gQjz8wTeNxU/zTwQd5Q7z+JU5yBmK/8+
	b1vmDYXA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tPfDb-00000009k4M-3diB;
	Mon, 23 Dec 2024 09:59:19 +0000
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tPf0x-00000009hdN-2r2r
	for linux-um@lists.infradead.org;
	Mon, 23 Dec 2024 09:46:17 +0000
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-725ef0397aeso3098072b3a.2
        for <linux-um@lists.infradead.org>; Mon, 23 Dec 2024 01:46:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1734947175; x=1735551975; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FItpERzyh1wDMphf2PSqriZlspFkmpQlPhA2jGTCtDU=;
        b=cvhQTvk+P6/NrNoWUSbOzNZIhKg5lC3LAk3e1SlQwYqW27tVT93QSBbWONXTjl/S3l
         Pmdty/KHleD+fykgGnpBuScEX9bg6bCqw0PSbHVO5dakxmDnNnSznHxdVY9dh5o7z9gJ
         JfFWV58m5v2FQfSbWndt3HjieB3Rf0Upwk6aXq9Ra78HeZNSUZ3lDNdHsyzYGZZOOoOy
         Yu+brNQzgc09Kp6RrskAtuQWOnWHXyyDprlPHx+AV6OmTtL7s95IOCznyOfdc5wix9gv
         3q0eEGgVNiYeemTNDbSrMiID0X07zy6axYEesuJkdzGXQjs+livqD3OnBZWQkNM9Fgy4
         2xUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734947175; x=1735551975;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FItpERzyh1wDMphf2PSqriZlspFkmpQlPhA2jGTCtDU=;
        b=N31ZdG1b9d52X7hERYABIO++FpfJH2zFcOpcVv5z//VHZCcTkkCGPLLVsae2ECYGI8
         8dM2f4J566P24Qt6g/okCDLiPGqKrZxt+ruuBgxvFXm04kcK7Aoi89K4r/e+2/wHIHVY
         5iN8RKsk4Fef73Gj/Jc/uchFzsuQW8b77QsON6p3cz140lrTmBxWJc7J4VAALtPHDlyt
         q3WLdHGc5rYAkHvKBhVa4jzdi2qIyCj7EzkUm8FSGUnhoIaaopFn7PYJjq4CrPQ4vvUB
         8JJJUsuy1hJC8jjy79ynyrK2U172Ysf68SsDjfvL4MAWuLLwtRQP7zp3taRhCbPaZrt+
         CDHA==
X-Forwarded-Encrypted: i=1; AJvYcCVECYL6ojmsG+Fo2hm0VPVfxa82kgf5IeK74B/dTmMNNNf9ShrtLkJNtW2+JQe5S56H1wrT+J0+Wg==@lists.infradead.org
X-Gm-Message-State: AOJu0YyQciJrDcG+mrMEnZkmnG2XICM/1LxNQW7SpGGsJpWzdSdgaYc9
	vl75zNFoR64eCaWbVqCFLWqwg6Ioh3kiOj7DRYA4RG+/+DkCzdFchNnKk7ZZ/JY=
X-Gm-Gg: ASbGnct0g0SV1keOIjoSlXZ107MqGJZk0z7ebDrqKtcqO5ldnGtV4rMt4e8ieVaASpG
	M9g9PScLKT4uwYI5z8N21woHhayQ23WDifoo0/QBx/7Ib5dKq3bHE2ml9Z6JP3ntfsUPvVVxqpL
	sy7El/AQuKm79OarrymSkuKcddnypymSVZ+v5F4sgXFreNe9kex/s592z9nnrFihkltLm9lFtrH
	gV/ZzGQZQdvIZENWOJPu8K+1wgwvFVS0LSSAYRiQf0jCOJFCMFvCpFF48VQHMcGS/BX9wMKCLhP
	tt9TPzwYTXGGlyYqAo2+QA==
X-Google-Smtp-Source: AGHT+IF9RJvbCaq38Te31r1RKGqLS5POHI3EPqaSbNpVA67C9keEJqX0jQ2rnqy+EikMhfv/vLwTVQ==
X-Received: by 2002:a05:6a20:12d2:b0:1e0:c0fa:e088 with SMTP id adf61e73a8af0-1e5e059b19cmr20289317637.18.1734947175103;
        Mon, 23 Dec 2024 01:46:15 -0800 (PST)
Received: from C02DW0BEMD6R.bytedance.net ([203.208.167.150])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72aad8486c6sm7468309b3a.85.2024.12.23.01.46.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Dec 2024 01:46:14 -0800 (PST)
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
Subject: [PATCH v3 15/17] mm: pgtable: remove tlb_remove_page_ptdesc()
Date: Mon, 23 Dec 2024 17:41:01 +0800
Message-Id: <b37435768345e0fcf7ea358f69b4a71767f0f530.1734945104.git.zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <cover.1734945104.git.zhengqi.arch@bytedance.com>
References: <cover.1734945104.git.zhengqi.arch@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241223_014615_772316_DBEF6B89 
X-CRM114-Status: UNSURE (   9.88  )
X-CRM114-Notice: Please train this message.
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

Here we are explicitly dealing with struct page, and the following logic
semms strange:

tlb_remove_page_ptdesc((tlb), (page_ptdesc(pte)));

tlb_remove_page_ptdesc
--> tlb_remove_page(tlb, ptdesc_page(pt));

So remove tlb_remove_page_ptdesc() and make callers call tlb_remove_page()
directly.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
Originally-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/csky/include/asm/pgalloc.h      | 2 +-
 arch/hexagon/include/asm/pgalloc.h   | 2 +-
 arch/loongarch/include/asm/pgalloc.h | 2 +-
 arch/m68k/include/asm/sun3_pgalloc.h | 2 +-
 arch/mips/include/asm/pgalloc.h      | 2 +-
 arch/nios2/include/asm/pgalloc.h     | 2 +-
 arch/openrisc/include/asm/pgalloc.h  | 2 +-
 arch/riscv/include/asm/pgalloc.h     | 2 +-
 arch/sh/include/asm/pgalloc.h        | 2 +-
 arch/um/include/asm/pgalloc.h        | 8 ++++----
 include/asm-generic/tlb.h            | 6 ------
 11 files changed, 13 insertions(+), 19 deletions(-)

diff --git a/arch/csky/include/asm/pgalloc.h b/arch/csky/include/asm/pgalloc.h
index f1ce5b7b28f22..936a43a49e704 100644
--- a/arch/csky/include/asm/pgalloc.h
+++ b/arch/csky/include/asm/pgalloc.h
@@ -64,7 +64,7 @@ static inline pgd_t *pgd_alloc(struct mm_struct *mm)
 #define __pte_free_tlb(tlb, pte, address)		\
 do {							\
 	pagetable_dtor(page_ptdesc(pte));		\
-	tlb_remove_page_ptdesc(tlb, page_ptdesc(pte));	\
+	tlb_remove_page(tlb, (pte));			\
 } while (0)
 
 extern void pagetable_init(void);
diff --git a/arch/hexagon/include/asm/pgalloc.h b/arch/hexagon/include/asm/pgalloc.h
index 40e42a0e71673..8b1550498f1bf 100644
--- a/arch/hexagon/include/asm/pgalloc.h
+++ b/arch/hexagon/include/asm/pgalloc.h
@@ -90,7 +90,7 @@ static inline void pmd_populate_kernel(struct mm_struct *mm, pmd_t *pmd,
 #define __pte_free_tlb(tlb, pte, addr)				\
 do {								\
 	pagetable_dtor((page_ptdesc(pte)));			\
-	tlb_remove_page_ptdesc((tlb), (page_ptdesc(pte)));	\
+	tlb_remove_page((tlb), (pte));				\
 } while (0)
 
 #endif
diff --git a/arch/loongarch/include/asm/pgalloc.h b/arch/loongarch/include/asm/pgalloc.h
index 7211dff8c969e..5a4f22aeb6189 100644
--- a/arch/loongarch/include/asm/pgalloc.h
+++ b/arch/loongarch/include/asm/pgalloc.h
@@ -58,7 +58,7 @@ static inline pte_t *pte_alloc_one_kernel(struct mm_struct *mm)
 #define __pte_free_tlb(tlb, pte, address)			\
 do {								\
 	pagetable_dtor(page_ptdesc(pte));			\
-	tlb_remove_page_ptdesc((tlb), page_ptdesc(pte));	\
+	tlb_remove_page((tlb), (pte));				\
 } while (0)
 
 #ifndef __PAGETABLE_PMD_FOLDED
diff --git a/arch/m68k/include/asm/sun3_pgalloc.h b/arch/m68k/include/asm/sun3_pgalloc.h
index 2b626cb3ad0ae..63d9f95f5e3dd 100644
--- a/arch/m68k/include/asm/sun3_pgalloc.h
+++ b/arch/m68k/include/asm/sun3_pgalloc.h
@@ -20,7 +20,7 @@ extern const char bad_pmd_string[];
 #define __pte_free_tlb(tlb, pte, addr)				\
 do {								\
 	pagetable_dtor(page_ptdesc(pte));			\
-	tlb_remove_page_ptdesc((tlb), page_ptdesc(pte));	\
+	tlb_remove_page((tlb), (pte));				\
 } while (0)
 
 static inline void pmd_populate_kernel(struct mm_struct *mm, pmd_t *pmd, pte_t *pte)
diff --git a/arch/mips/include/asm/pgalloc.h b/arch/mips/include/asm/pgalloc.h
index 36d9805033c4b..bbee21345154b 100644
--- a/arch/mips/include/asm/pgalloc.h
+++ b/arch/mips/include/asm/pgalloc.h
@@ -57,7 +57,7 @@ static inline void pgd_free(struct mm_struct *mm, pgd_t *pgd)
 #define __pte_free_tlb(tlb, pte, address)			\
 do {								\
 	pagetable_dtor(page_ptdesc(pte));			\
-	tlb_remove_page_ptdesc((tlb), page_ptdesc(pte));	\
+	tlb_remove_page((tlb), (pte));				\
 } while (0)
 
 #ifndef __PAGETABLE_PMD_FOLDED
diff --git a/arch/nios2/include/asm/pgalloc.h b/arch/nios2/include/asm/pgalloc.h
index 12a536b7bfbd4..641cec8fb2a22 100644
--- a/arch/nios2/include/asm/pgalloc.h
+++ b/arch/nios2/include/asm/pgalloc.h
@@ -31,7 +31,7 @@ extern pgd_t *pgd_alloc(struct mm_struct *mm);
 #define __pte_free_tlb(tlb, pte, addr)					\
 	do {								\
 		pagetable_dtor(page_ptdesc(pte));			\
-		tlb_remove_page_ptdesc((tlb), (page_ptdesc(pte)));	\
+		tlb_remove_page((tlb), (pte));				\
 	} while (0)
 
 #endif /* _ASM_NIOS2_PGALLOC_H */
diff --git a/arch/openrisc/include/asm/pgalloc.h b/arch/openrisc/include/asm/pgalloc.h
index 596e2355824e3..e9b9bc53ece0b 100644
--- a/arch/openrisc/include/asm/pgalloc.h
+++ b/arch/openrisc/include/asm/pgalloc.h
@@ -69,7 +69,7 @@ extern pte_t *pte_alloc_one_kernel(struct mm_struct *mm);
 #define __pte_free_tlb(tlb, pte, addr)				\
 do {								\
 	pagetable_dtor(page_ptdesc(pte));			\
-	tlb_remove_page_ptdesc((tlb), (page_ptdesc(pte)));	\
+	tlb_remove_page((tlb), (pte));				\
 } while (0)
 
 #endif
diff --git a/arch/riscv/include/asm/pgalloc.h b/arch/riscv/include/asm/pgalloc.h
index c8907b8317115..ab4f9b2cf9e11 100644
--- a/arch/riscv/include/asm/pgalloc.h
+++ b/arch/riscv/include/asm/pgalloc.h
@@ -29,7 +29,7 @@ static inline void riscv_tlb_remove_ptdesc(struct mmu_gather *tlb, void *pt)
 		tlb_remove_ptdesc(tlb, pt);
 	} else {
 		pagetable_dtor(pt);
-		tlb_remove_page_ptdesc(tlb, pt);
+		tlb_remove_page(tlb, ptdesc_page((struct ptdesc *)pt));
 	}
 }
 
diff --git a/arch/sh/include/asm/pgalloc.h b/arch/sh/include/asm/pgalloc.h
index 96d938fdf2244..43812b2363efd 100644
--- a/arch/sh/include/asm/pgalloc.h
+++ b/arch/sh/include/asm/pgalloc.h
@@ -35,7 +35,7 @@ static inline void pmd_populate(struct mm_struct *mm, pmd_t *pmd,
 #define __pte_free_tlb(tlb, pte, addr)				\
 do {								\
 	pagetable_dtor(page_ptdesc(pte));			\
-	tlb_remove_page_ptdesc((tlb), (page_ptdesc(pte)));	\
+	tlb_remove_page((tlb), (pte));				\
 } while (0)
 
 #endif /* __ASM_SH_PGALLOC_H */
diff --git a/arch/um/include/asm/pgalloc.h b/arch/um/include/asm/pgalloc.h
index f0af23c3aeb2b..98190c318a8e9 100644
--- a/arch/um/include/asm/pgalloc.h
+++ b/arch/um/include/asm/pgalloc.h
@@ -28,7 +28,7 @@ extern pgd_t *pgd_alloc(struct mm_struct *);
 #define __pte_free_tlb(tlb, pte, address)			\
 do {								\
 	pagetable_dtor(page_ptdesc(pte));			\
-	tlb_remove_page_ptdesc((tlb), (page_ptdesc(pte)));	\
+	tlb_remove_page((tlb), (pte));				\
 } while (0)
 
 #if CONFIG_PGTABLE_LEVELS > 2
@@ -36,15 +36,15 @@ do {								\
 #define __pmd_free_tlb(tlb, pmd, address)			\
 do {								\
 	pagetable_dtor(virt_to_ptdesc(pmd));			\
-	tlb_remove_page_ptdesc((tlb), virt_to_ptdesc(pmd));	\
+	tlb_remove_page((tlb), virt_to_page(pmd));		\
 } while (0)
 
 #if CONFIG_PGTABLE_LEVELS > 3
 
 #define __pud_free_tlb(tlb, pud, address)			\
 do {								\
-	pagetable_dtor(virt_to_ptdesc(pud));		\
-	tlb_remove_page_ptdesc((tlb), virt_to_ptdesc(pud));	\
+	pagetable_dtor(virt_to_ptdesc(pud));			\
+	tlb_remove_page((tlb), virt_to_page(pud));		\
 } while (0)
 
 #endif
diff --git a/include/asm-generic/tlb.h b/include/asm-generic/tlb.h
index 69de47c7ef3c5..8d6cfe5058543 100644
--- a/include/asm-generic/tlb.h
+++ b/include/asm-generic/tlb.h
@@ -504,12 +504,6 @@ static inline void tlb_remove_ptdesc(struct mmu_gather *tlb, void *pt)
 	tlb_remove_table(tlb, pt);
 }
 
-/* Like tlb_remove_ptdesc, but for page-like page directories. */
-static inline void tlb_remove_page_ptdesc(struct mmu_gather *tlb, struct ptdesc *pt)
-{
-	tlb_remove_page(tlb, ptdesc_page(pt));
-}
-
 static inline void tlb_change_page_size(struct mmu_gather *tlb,
 						     unsigned int page_size)
 {
-- 
2.20.1


