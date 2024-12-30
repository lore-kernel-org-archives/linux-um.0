Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF1E8E77188
	for <linux-um@archiver.kernel.org>; Mon, 30 Dec 2024 09:23:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=76YtbImY0jPwdXnQQVs9oYKl35yZZ81uc4A2YpilpOk=; b=3+Xtzu9WWCB/o6jhjgebRcIwIU
	S17cjLvyz0UnJ3T5/UNtPMhRDBkqXlLCoyI87OYVHjRdkn7WhXgFTVWeQa10Fjle7EP41rqYGbfAz
	7w3iW9USGSkOrJJXR7PjHvdCmc9Z07oxg73WHoHMvsaw9JuGrciqBUyBY5Gqvk1J3yaL4dydYT3F0
	/0Q//7ZhlkMlHBbB/hR2nCsF7xlG5bEG34f+JYrxB1Epc4HgPdHLwuki9xOZUL4o3wwexBHdBkAUI
	cmKOHF/yvqur/BVax5ix4QJ18T+gHMyAGd/r7DoUFAgqMW0YLtWHYgbVw2Au51tDUd6eep52UTqQK
	Ja+1+hoA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tSBzf-00000004vM2-0XR1;
	Mon, 30 Dec 2024 09:23:23 +0000
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tSBnR-00000004so2-29TI
	for linux-um@lists.infradead.org;
	Mon, 30 Dec 2024 09:10:47 +0000
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-21636268e43so17195305ad.2
        for <linux-um@lists.infradead.org>; Mon, 30 Dec 2024 01:10:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1735549845; x=1736154645; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=76YtbImY0jPwdXnQQVs9oYKl35yZZ81uc4A2YpilpOk=;
        b=Hz6nYF2RDSYUYGEdcBDwICtr7nYxKgxvRxAxy+JRVaPOm0gmHVUWwFhxrciL6TsezH
         knQMJV0Rc8M3r9X39JihXXeOlqLLD92IQXsV35O5Av7Idn6hUrldLpKxYbWmTSuC83//
         ppKqu/tL5Kn/WuB7rht0A/cWz5gD5p1LoWxdr8APOcTJJwIcVnn4zLIK0qRHQVaiCtwf
         +CKH/S00RXMd2EvS92N3N+HsSy3z0ysvd/mAaaxrN4vcLaEEBM5gpMjb1DQQxTX8s3OL
         TVgzMAG3v2XsL62Fx9K4VfMQtyG+b5hGV/qVv+Y5UYxA/t02ezi1Jozkn7le9/Q0lnwn
         TRIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735549845; x=1736154645;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=76YtbImY0jPwdXnQQVs9oYKl35yZZ81uc4A2YpilpOk=;
        b=KCG53EDQMukL5GFTRilaRIq02kWQbG/6UGk6300fkHYaZxarVyAKOlgkvp+aUzCqOF
         zKRPwmWSzv4XlkwvVuVncMk9xvJvfQSyMKEqqCW2fqkEB2pfxQ5rEZrdOwCdMu0QOzIF
         DhtY2LUY57c286W5IeaH8iHaykfGFQbSAmLc7HlfIoUIn+S6v3EAjkzGMoOwRIcv4e1U
         /ViHgK0Zj5SzCmfwVBqwkZKtUm79r2K8USz8TXZ8+JtojMdQX1WDFrJcMX06KzdbpUTw
         4ha0nlL4RhJac5+QHEDdQhWzdYG/m1QDA41JuNyTMKgbeLBmwe+xaz/mXZIVY7H/WY6c
         +l1Q==
X-Forwarded-Encrypted: i=1; AJvYcCXqpgHgD2wnpxqe9EyPrtTetoSnu6dZp1W0vE/ZfzhNV2EBND984mpCyvVWL7Dc2P8Lq4Uqgsg5sA==@lists.infradead.org
X-Gm-Message-State: AOJu0YyQ1y8PdN9EsECwuON9x/BuO8Fs/18wb7xDTEnL7Mu0vJpf3B49
	zycHd9YDJ1bq2xhu+I1ykQBtUH/DdIijFWHYtT8UZxGkKXz8SR7SVWyonSmCwvQ=
X-Gm-Gg: ASbGncuLu3YEdzwmxOJaOwpMhrEnYmweXrrEYCpcVOHBWykpuPf+lBrjifcIdq90M+A
	lDKgVQvz7ghXbfcvvmTh8dr/lteM90IbScbTuIKLhFqjHYy3ja5gf1YjalrueMFzuRbmv+zWJg3
	2hXlILlSBB9QGrFF+uXHILrsQ0vOqzEFykdQIwCZ9N1tW+dW7QE+sNLemWxOixI13C3pvaiRN5z
	kWo0h7SrdbtmTmcSq2zzpGxn3NzF6DV69pGYodXWDpcnz8zuqTPHzPYN5FZOj0HGXtNmrumUJpl
	OVGZ3iW++Xe7BWKISFiOdg==
X-Google-Smtp-Source: AGHT+IE9evGbD+yEfyO2G41S4amTNhC2vfWaq9UYV9WQJrC+a4l06PyKmdWx4KtX6MVeEx+cVngAAA==
X-Received: by 2002:a05:6a20:c91b:b0:1e1:d22d:cf38 with SMTP id adf61e73a8af0-1e5e05b06bbmr51533885637.21.1735549844993;
        Mon, 30 Dec 2024 01:10:44 -0800 (PST)
Received: from C02DW0BEMD6R.bytedance.net ([203.208.167.150])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-842aba72f7csm17057841a12.4.2024.12.30.01.10.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Dec 2024 01:10:44 -0800 (PST)
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
Subject: [PATCH v4 10/15] riscv: pgtable: move pagetable_dtor() to __tlb_remove_table()
Date: Mon, 30 Dec 2024 17:07:45 +0800
Message-Id: <0e8f0b3835c15e99145e0006ac1020ae45a2b166.1735549103.git.zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <cover.1735549103.git.zhengqi.arch@bytedance.com>
References: <cover.1735549103.git.zhengqi.arch@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241230_011045_575283_8278DF3A 
X-CRM114-Status: GOOD (  13.21  )
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

By the way, move the comment above __tlb_remove_table() to
riscv_tlb_remove_ptdesc(), it will be more appropriate.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
Suggested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: linux-riscv@lists.infradead.org
---
 arch/riscv/include/asm/pgalloc.h | 38 ++++++++++++++------------------
 arch/riscv/include/asm/tlb.h     | 14 ++++--------
 2 files changed, 21 insertions(+), 31 deletions(-)

diff --git a/arch/riscv/include/asm/pgalloc.h b/arch/riscv/include/asm/pgalloc.h
index b6793c5c99296..c8907b8317115 100644
--- a/arch/riscv/include/asm/pgalloc.h
+++ b/arch/riscv/include/asm/pgalloc.h
@@ -15,12 +15,22 @@
 #define __HAVE_ARCH_PUD_FREE
 #include <asm-generic/pgalloc.h>
 
+/*
+ * While riscv platforms with riscv_ipi_for_rfence as true require an IPI to
+ * perform TLB shootdown, some platforms with riscv_ipi_for_rfence as false use
+ * SBI to perform TLB shootdown. To keep software pagetable walkers safe in this
+ * case we switch to RCU based table free (MMU_GATHER_RCU_TABLE_FREE). See the
+ * comment below 'ifdef CONFIG_MMU_GATHER_RCU_TABLE_FREE' in include/asm-generic/tlb.h
+ * for more details.
+ */
 static inline void riscv_tlb_remove_ptdesc(struct mmu_gather *tlb, void *pt)
 {
-	if (riscv_use_sbi_for_rfence())
+	if (riscv_use_sbi_for_rfence()) {
 		tlb_remove_ptdesc(tlb, pt);
-	else
+	} else {
+		pagetable_dtor(pt);
 		tlb_remove_page_ptdesc(tlb, pt);
+	}
 }
 
 static inline void pmd_populate_kernel(struct mm_struct *mm,
@@ -97,23 +107,15 @@ static inline void pud_free(struct mm_struct *mm, pud_t *pud)
 static inline void __pud_free_tlb(struct mmu_gather *tlb, pud_t *pud,
 				  unsigned long addr)
 {
-	if (pgtable_l4_enabled) {
-		struct ptdesc *ptdesc = virt_to_ptdesc(pud);
-
-		pagetable_dtor(ptdesc);
-		riscv_tlb_remove_ptdesc(tlb, ptdesc);
-	}
+	if (pgtable_l4_enabled)
+		riscv_tlb_remove_ptdesc(tlb, virt_to_ptdesc(pud));
 }
 
 static inline void __p4d_free_tlb(struct mmu_gather *tlb, p4d_t *p4d,
 				  unsigned long addr)
 {
-	if (pgtable_l5_enabled) {
-		struct ptdesc *ptdesc = virt_to_ptdesc(p4d);
-
-		pagetable_dtor(ptdesc);
+	if (pgtable_l5_enabled)
 		riscv_tlb_remove_ptdesc(tlb, virt_to_ptdesc(p4d));
-	}
 }
 #endif /* __PAGETABLE_PMD_FOLDED */
 
@@ -142,10 +144,7 @@ static inline pgd_t *pgd_alloc(struct mm_struct *mm)
 static inline void __pmd_free_tlb(struct mmu_gather *tlb, pmd_t *pmd,
 				  unsigned long addr)
 {
-	struct ptdesc *ptdesc = virt_to_ptdesc(pmd);
-
-	pagetable_dtor(ptdesc);
-	riscv_tlb_remove_ptdesc(tlb, ptdesc);
+	riscv_tlb_remove_ptdesc(tlb, virt_to_ptdesc(pmd));
 }
 
 #endif /* __PAGETABLE_PMD_FOLDED */
@@ -153,10 +152,7 @@ static inline void __pmd_free_tlb(struct mmu_gather *tlb, pmd_t *pmd,
 static inline void __pte_free_tlb(struct mmu_gather *tlb, pgtable_t pte,
 				  unsigned long addr)
 {
-	struct ptdesc *ptdesc = page_ptdesc(pte);
-
-	pagetable_dtor(ptdesc);
-	riscv_tlb_remove_ptdesc(tlb, ptdesc);
+	riscv_tlb_remove_ptdesc(tlb, page_ptdesc(pte));
 }
 #endif /* CONFIG_MMU */
 
diff --git a/arch/riscv/include/asm/tlb.h b/arch/riscv/include/asm/tlb.h
index 1f6c38420d8e0..ded8724b3c4f7 100644
--- a/arch/riscv/include/asm/tlb.h
+++ b/arch/riscv/include/asm/tlb.h
@@ -11,19 +11,13 @@ struct mmu_gather;
 static void tlb_flush(struct mmu_gather *tlb);
 
 #ifdef CONFIG_MMU
-#include <linux/swap.h>
 
-/*
- * While riscv platforms with riscv_ipi_for_rfence as true require an IPI to
- * perform TLB shootdown, some platforms with riscv_ipi_for_rfence as false use
- * SBI to perform TLB shootdown. To keep software pagetable walkers safe in this
- * case we switch to RCU based table free (MMU_GATHER_RCU_TABLE_FREE). See the
- * comment below 'ifdef CONFIG_MMU_GATHER_RCU_TABLE_FREE' in include/asm-generic/tlb.h
- * for more details.
- */
 static inline void __tlb_remove_table(void *table)
 {
-	free_page_and_swap_cache(table);
+	struct ptdesc *ptdesc = (struct ptdesc *)table;
+
+	pagetable_dtor(ptdesc);
+	pagetable_free(ptdesc);
 }
 
 #endif /* CONFIG_MMU */
-- 
2.20.1


