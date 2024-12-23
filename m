Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCC7FE7718B
	for <linux-um@archiver.kernel.org>; Mon, 23 Dec 2024 09:54:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Rs6Lkouarv58ZoKb+WtHLVo9G63kikGgJGrD7ursbxc=; b=eMvTQB5iVQQh1SObSIDvwyfiXd
	+CRECTak/AHMDAv62Wl18gkbJ4KwKPMPanW+pb3TIJocUKlWzgnWUWgBkaUr0HbHEXkN2muqsW0mD
	SV22A13fnZprosbFgQs6Wr7lQlG0abrddZkZNwwlwDJi59HHGzkWPYzRZNAdz4ppCNZZcS9hnf/j2
	sPtDJyMxxfvPmk+MZwMqlo0cvwWryGHu55h4qfppqJs4lFDwNky/r3FmanXvE114oU6ZMan2jkqHQ
	WaljGwt8DBhS3uc1V+t0AhLqe0AU/kq6lZgOooNkE/mjH0V4NQK2w5gfQaKvQGzf52QennZSdjIqs
	N8+r9wJg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tPf8u-00000009jL5-2Kxo;
	Mon, 23 Dec 2024 09:54:28 +0000
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tPf08-00000009h98-24wr
	for linux-um@lists.infradead.org;
	Mon, 23 Dec 2024 09:45:26 +0000
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-728ea1573c0so3238073b3a.0
        for <linux-um@lists.infradead.org>; Mon, 23 Dec 2024 01:45:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1734947124; x=1735551924; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rs6Lkouarv58ZoKb+WtHLVo9G63kikGgJGrD7ursbxc=;
        b=DD42x19JvQOPD930qrXn43L81Q0zFimemVRQP44YlFBqhPZfD31PxjHf7h7s3RTLBm
         3PSk4U7GbIwpl/bTcvRKqtqYVl/3T5ywX5vJDK9xTGtOqsi7EM7PF+OdM7wKPPmssFKD
         OD7vPiWbqk5zcNqhNuDLJZrasuudAI326gLAf16tdKYBs78g1VOX/oG2KGQhFfxk0E8Z
         wtiDJYwukOB9UH0grkpF1RArKCNYpONlk3OSUMQfo46Gz9NttZw5nEsdJzuyC5vWrRpv
         kx1qrhqxLfJjUuJIW7IhLvyMDjhdA7EQanvgy9ljGUHh+U4mzSLWB8fe0+vuS8DeSk6U
         sRtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734947124; x=1735551924;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rs6Lkouarv58ZoKb+WtHLVo9G63kikGgJGrD7ursbxc=;
        b=Scolt8kJDbLg7v9L+7LBuS+r0HheIC7HI3vSy2+Jc6X8u2s2UakiXOOsnbt8NxSU8L
         MwSxgu+xHWji+miuTP6qe+4DOF6NCd9z+MdnSanhlQIG5S6Tcag2WmK7d3PBDYqfm0bx
         VYcusKWb2y9LT3bLDOs6K0/Mo66/NZ12BhU9eRmsLiFxiBVt78KIn+NG0q/IXDuAswJL
         jU6XNnQV2jKNwuFQsSqEEXPKpZ6kno+TeRIbtu8ahMGXiMBNpelOcQkDHApoqJ0mzEwe
         HdYZiUgEXnkknBqJ6daQFAFQ7oxu8d7EuhIqL+RWEoIITGHaXf0pvNq2dmdv47RfJ5cJ
         V3Fg==
X-Forwarded-Encrypted: i=1; AJvYcCV7nd01xbxSSJHMizcj/Rve3dT7I+k3n4XmE1b/VWloLJYzNufLLdbQAv+qzCjVlXsasZaZN1qiiA==@lists.infradead.org
X-Gm-Message-State: AOJu0Yy9K/Y3Ic502XlR1bipYDNX4ZqUy+iPeTDb1LLFfRlVTr/HvndO
	2xXtH/UIo8lEDcij6jFmCbQY0SA4QqKg2QjWQZjtqkft/I4Yw3+Zd6kf7siueus=
X-Gm-Gg: ASbGncvAsPQuJ55GWflKT5ROy0V7tilbK7iFrJc60W2Q9FoC91zgtGvHgPYMLYmSp1S
	At8Q/Mg3P+URrX1GPFo2ERMaCd1ONsZgtpZ6Ox9OYvN4VhOZaaGqudEiCPJCjsh3ngKAmvEt98K
	JphIWoyFsqRg06hTBWPX8ItMcv3UvorhsVQNWmovMuXg0gKPK/b+6+83naRUwSfSXmZRG+JvpMR
	8X0Bcwv/p48KvfyPWRr3gBexWI6bNPzz5mFyt8ons7ocMGpP5ye31i8RItUO7KRfEgcxyX4tAZM
	4ImRgsCw41l475Aq0fv0Mg==
X-Google-Smtp-Source: AGHT+IEsUkA9RBo0Vmvp6m94/gMVFQ4PHl6SoN42Z+rLx+q01B5oEKa1sTTPOWHs1mFCNObFPbuRxA==
X-Received: by 2002:a05:6a20:6a25:b0:1d9:18af:d150 with SMTP id adf61e73a8af0-1e5e05a9e39mr19676430637.21.1734947123919;
        Mon, 23 Dec 2024 01:45:23 -0800 (PST)
Received: from C02DW0BEMD6R.bytedance.net ([203.208.167.150])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72aad8486c6sm7468309b3a.85.2024.12.23.01.45.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Dec 2024 01:45:23 -0800 (PST)
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
Subject: [PATCH v3 11/17] x86: pgtable: move pagetable_dtor() to __tlb_remove_table()
Date: Mon, 23 Dec 2024 17:40:57 +0800
Message-Id: <0dc5a3bf5a692e24379c1d3b879a6d4396f0dbbd.1734945104.git.zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <cover.1734945104.git.zhengqi.arch@bytedance.com>
References: <cover.1734945104.git.zhengqi.arch@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241223_014524_542333_E9BBE067 
X-CRM114-Status: GOOD (  11.30  )
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
Cc: x86@kernel.org
---
 arch/x86/include/asm/tlb.h | 17 ++++++++++-------
 arch/x86/kernel/paravirt.c |  1 +
 arch/x86/mm/pgtable.c      | 12 ++----------
 3 files changed, 13 insertions(+), 17 deletions(-)

diff --git a/arch/x86/include/asm/tlb.h b/arch/x86/include/asm/tlb.h
index 73f0786181cc9..f64730be5ad67 100644
--- a/arch/x86/include/asm/tlb.h
+++ b/arch/x86/include/asm/tlb.h
@@ -31,24 +31,27 @@ static inline void tlb_flush(struct mmu_gather *tlb)
  */
 static inline void __tlb_remove_table(void *table)
 {
-	free_page_and_swap_cache(table);
+	struct ptdesc *ptdesc = (struct ptdesc *)table;
+
+	pagetable_dtor(ptdesc);
+	pagetable_free(ptdesc);
 }
 
 #ifdef CONFIG_PT_RECLAIM
 static inline void __tlb_remove_table_one_rcu(struct rcu_head *head)
 {
-	struct page *page;
+	struct ptdesc *ptdesc;
 
-	page = container_of(head, struct page, rcu_head);
-	put_page(page);
+	ptdesc = container_of(head, struct ptdesc, pt_rcu_head);
+	__tlb_remove_table(ptdesc);
 }
 
 static inline void __tlb_remove_table_one(void *table)
 {
-	struct page *page;
+	struct ptdesc *ptdesc;
 
-	page = table;
-	call_rcu(&page->rcu_head, __tlb_remove_table_one_rcu);
+	ptdesc = table;
+	call_rcu(&ptdesc->pt_rcu_head, __tlb_remove_table_one_rcu);
 }
 #define __tlb_remove_table_one __tlb_remove_table_one
 #endif /* CONFIG_PT_RECLAIM */
diff --git a/arch/x86/kernel/paravirt.c b/arch/x86/kernel/paravirt.c
index 7bdcf152778c0..46d5d325483b0 100644
--- a/arch/x86/kernel/paravirt.c
+++ b/arch/x86/kernel/paravirt.c
@@ -62,6 +62,7 @@ void __init native_pv_lock_init(void)
 #ifndef CONFIG_PT_RECLAIM
 static void native_tlb_remove_table(struct mmu_gather *tlb, void *table)
 {
+	pagetable_dtor(table);
 	tlb_remove_page(tlb, table);
 }
 #else
diff --git a/arch/x86/mm/pgtable.c b/arch/x86/mm/pgtable.c
index a6cd9660e29ec..a0b0e501ba663 100644
--- a/arch/x86/mm/pgtable.c
+++ b/arch/x86/mm/pgtable.c
@@ -23,6 +23,7 @@ EXPORT_SYMBOL(physical_mask);
 static inline
 void paravirt_tlb_remove_table(struct mmu_gather *tlb, void *table)
 {
+	pagetable_dtor(table);
 	tlb_remove_page(tlb, table);
 }
 #else
@@ -60,7 +61,6 @@ early_param("userpte", setup_userpte);
 
 void ___pte_free_tlb(struct mmu_gather *tlb, struct page *pte)
 {
-	pagetable_dtor(page_ptdesc(pte));
 	paravirt_release_pte(page_to_pfn(pte));
 	paravirt_tlb_remove_table(tlb, pte);
 }
@@ -68,7 +68,6 @@ void ___pte_free_tlb(struct mmu_gather *tlb, struct page *pte)
 #if CONFIG_PGTABLE_LEVELS > 2
 void ___pmd_free_tlb(struct mmu_gather *tlb, pmd_t *pmd)
 {
-	struct ptdesc *ptdesc = virt_to_ptdesc(pmd);
 	paravirt_release_pmd(__pa(pmd) >> PAGE_SHIFT);
 	/*
 	 * NOTE! For PAE, any changes to the top page-directory-pointer-table
@@ -77,16 +76,12 @@ void ___pmd_free_tlb(struct mmu_gather *tlb, pmd_t *pmd)
 #ifdef CONFIG_X86_PAE
 	tlb->need_flush_all = 1;
 #endif
-	pagetable_dtor(ptdesc);
-	paravirt_tlb_remove_table(tlb, ptdesc_page(ptdesc));
+	paravirt_tlb_remove_table(tlb, virt_to_page(pmd));
 }
 
 #if CONFIG_PGTABLE_LEVELS > 3
 void ___pud_free_tlb(struct mmu_gather *tlb, pud_t *pud)
 {
-	struct ptdesc *ptdesc = virt_to_ptdesc(pud);
-
-	pagetable_dtor(ptdesc);
 	paravirt_release_pud(__pa(pud) >> PAGE_SHIFT);
 	paravirt_tlb_remove_table(tlb, virt_to_page(pud));
 }
@@ -94,9 +89,6 @@ void ___pud_free_tlb(struct mmu_gather *tlb, pud_t *pud)
 #if CONFIG_PGTABLE_LEVELS > 4
 void ___p4d_free_tlb(struct mmu_gather *tlb, p4d_t *p4d)
 {
-	struct ptdesc *ptdesc = virt_to_ptdesc(p4d);
-
-	pagetable_dtor(ptdesc);
 	paravirt_release_p4d(__pa(p4d) >> PAGE_SHIFT);
 	paravirt_tlb_remove_table(tlb, virt_to_page(p4d));
 }
-- 
2.20.1


