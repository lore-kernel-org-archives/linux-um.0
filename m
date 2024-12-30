Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7856E77194
	for <linux-um@archiver.kernel.org>; Mon, 30 Dec 2024 10:26:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jyEzElX2/Cl2Hb0vACePBo9dDp7jwROhL3d0Mq9f7ig=; b=n2k98u2t26ONv456LcKETiaUnw
	SB6GjokFLodJ0nfLvnSUJHdl518QNsNIVtIMKQEYBuZft5PG13A4areC9oYod/Jov9sQnQ8eZ9ivw
	WY9E0UP5lX67nr1crs2UfgOskQDahD7Naj3vVE81gO7jq+9nUob97Cth2s1SHkpNFAfpEDpmAeY8J
	CUlMAOgCQAoZxJVBubsT0KhNqqXyv7fAJUFWFyBQ6Uvk3ZAeHDLLpn3COFOUdPaIN+AmqrR33BzBY
	Egy8y9fqNIli3nRDj8YLTc8D4P6LjVWeWQPSfWNxG/gGqsoCwraGUA3a4ko4FbIZNRazdXtfbyYl9
	+e4ar55Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tSCyM-0000000525h-2uCj;
	Mon, 30 Dec 2024 10:26:06 +0000
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tSBnq-00000004t0z-2BNC
	for linux-um@lists.infradead.org;
	Mon, 30 Dec 2024 09:11:12 +0000
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-2166651f752so132030075ad.3
        for <linux-um@lists.infradead.org>; Mon, 30 Dec 2024 01:11:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1735549870; x=1736154670; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jyEzElX2/Cl2Hb0vACePBo9dDp7jwROhL3d0Mq9f7ig=;
        b=BsCfVEFjtD3iR9n0+qfkNJ2WgcZmMDjeKBin05cEaJtKPdo8K30th8hkFALxdu6Uf3
         lu1FPg/3aaVvw3Hz/c6N5PCGacy6rEIsEX/MegloXzGvPMaRg0bCvvU115uYLOrVnEBi
         aB97tn734B9e1c5Xb51qOcOVcZlrvqDBaU2Pd6nKw5KD9+XW8JLgp8DW/q1OIY6H6z0w
         6vUKMrRUc4bifaDMJOrqtO4E3m/GtlRHh+2ACiXnqEb2wGuuTA/dg0aQDQlRQCbwhYNk
         E5btr4eMdqTjUBouClOtX/h//TYFXXGePyFcGKAEmKxNcVwsMxDQ7kJP22lkyVpbCgg/
         HCNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735549870; x=1736154670;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jyEzElX2/Cl2Hb0vACePBo9dDp7jwROhL3d0Mq9f7ig=;
        b=O7tQKnfJIf4anh4zMB33HptDYS8LsxYiuXTuxtVQ0hO7ymmwakMjp/nqSLCsdb59oa
         3qR8nMUD2GReVq8lcN2/Ppk/4m/Y5ebWI5HB9FDbLL92v1Afw3MAJ4dkxCgCqSmZvpPQ
         YPcmfcio54P2LTJtn0dMzkGKb1+vrh+2wXVBTSUUJnUJ9CxFuoXXQfH2aiF/z9SF/X+t
         RRQHcTOgRXBsWStrG2W+C6iZZLqZsgQcqo7ulmQ8Q8ExzZHQi5XqloShQZaVM1Cpnf5o
         fILHmfLSsnN+R6a+M9vt8iFGxIeCMGM9004ySe9fQ7e1FOliIlAv5dSrST5e4PJLL7+x
         5S6A==
X-Forwarded-Encrypted: i=1; AJvYcCWibGLyUUeDRBdYbN4qtIE3gFu+bbc02CeX3pvAqPeVB6OqdMNxaCB9iogUqDzRCwvlGYE9AHaB6Q==@lists.infradead.org
X-Gm-Message-State: AOJu0Ywm/1/PoSKZzuqd0Mg7Zf7flrsx1QtxbkqJawfAz/xVffmbnwz7
	uYYrODVjO0ZZdwtaO8ZmeeOIbhM2xd6XqCN3MVRGBoZY2HqJm8TzfsV0zmebUjM=
X-Gm-Gg: ASbGncuVDLWyUoPZm+XTdgaGyzle1OplAZIThepapmd4eBYcOBDvDqZuyny9mNhksSE
	PFCKmxZ1TzLyVdhtshP2oE7GAZzSSjO5WufWZE48UvARUMZWYWKHdxEb1wwbnQuGkUgX1H2i8JQ
	sPjjsinGUjfWnJ92h/1oSHRD96r9GKr7EoriqD4aORhioizcZQXoF8JWom190p0tBCdOZGw1gwT
	QGKWl4Yd++tqITYpRz0Nm6iI6flKPjGoUf3PJ4Q6aJ7AgUL4p4EqucfJCX+XVbZVoeJf9rcY/FC
	8uwZpSvP3FmA+T6z2w1CJA==
X-Google-Smtp-Source: AGHT+IHPMMlkiFtH678yJhisFXpRpeLbEmYMWQPlXwvGfvt1NUv1TR7XGzXk5FcrgJpzIcDaQ0LX6w==
X-Received: by 2002:a05:6a20:7351:b0:1e0:cadd:f670 with SMTP id adf61e73a8af0-1e5e044c8ebmr53183808637.5.1735549869780;
        Mon, 30 Dec 2024 01:11:09 -0800 (PST)
Received: from C02DW0BEMD6R.bytedance.net ([203.208.167.150])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-842aba72f7csm17057841a12.4.2024.12.30.01.10.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Dec 2024 01:11:09 -0800 (PST)
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
Subject: [PATCH v4 12/15] s390: pgtable: also move pagetable_dtor() of PxD to __tlb_remove_table()
Date: Mon, 30 Dec 2024 17:07:47 +0800
Message-Id: <ad21b9392096336cf15aee46f68f9989a9cf877e.1735549103.git.zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <cover.1735549103.git.zhengqi.arch@bytedance.com>
References: <cover.1735549103.git.zhengqi.arch@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241230_011110_590125_204161CE 
X-CRM114-Status: UNSURE (   9.69  )
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

To unify the PxD and PTE TLB free path, also move the pagetable_dtor() of
PMD|PUD|P4D to __tlb_remove_table().

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
Suggested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: linux-s390@vger.kernel.org
---
 arch/s390/include/asm/tlb.h |  3 ---
 arch/s390/mm/pgalloc.c      | 14 ++++----------
 2 files changed, 4 insertions(+), 13 deletions(-)

diff --git a/arch/s390/include/asm/tlb.h b/arch/s390/include/asm/tlb.h
index 74b6fba4c2ee3..79df7c0932c56 100644
--- a/arch/s390/include/asm/tlb.h
+++ b/arch/s390/include/asm/tlb.h
@@ -102,7 +102,6 @@ static inline void pmd_free_tlb(struct mmu_gather *tlb, pmd_t *pmd,
 {
 	if (mm_pmd_folded(tlb->mm))
 		return;
-	pagetable_dtor(virt_to_ptdesc(pmd));
 	__tlb_adjust_range(tlb, address, PAGE_SIZE);
 	tlb->mm->context.flush_mm = 1;
 	tlb->freed_tables = 1;
@@ -122,7 +121,6 @@ static inline void pud_free_tlb(struct mmu_gather *tlb, pud_t *pud,
 {
 	if (mm_pud_folded(tlb->mm))
 		return;
-	pagetable_dtor(virt_to_ptdesc(pud));
 	tlb->mm->context.flush_mm = 1;
 	tlb->freed_tables = 1;
 	tlb->cleared_p4ds = 1;
@@ -141,7 +139,6 @@ static inline void p4d_free_tlb(struct mmu_gather *tlb, p4d_t *p4d,
 {
 	if (mm_p4d_folded(tlb->mm))
 		return;
-	pagetable_dtor(virt_to_ptdesc(p4d));
 	__tlb_adjust_range(tlb, address, PAGE_SIZE);
 	tlb->mm->context.flush_mm = 1;
 	tlb->freed_tables = 1;
diff --git a/arch/s390/mm/pgalloc.c b/arch/s390/mm/pgalloc.c
index 569de24d33761..c73b89811a264 100644
--- a/arch/s390/mm/pgalloc.c
+++ b/arch/s390/mm/pgalloc.c
@@ -180,7 +180,7 @@ unsigned long *page_table_alloc(struct mm_struct *mm)
 	return table;
 }
 
-static void pagetable_pte_dtor_free(struct ptdesc *ptdesc)
+static void pagetable_dtor_free(struct ptdesc *ptdesc)
 {
 	pagetable_dtor(ptdesc);
 	pagetable_free(ptdesc);
@@ -190,20 +190,14 @@ void page_table_free(struct mm_struct *mm, unsigned long *table)
 {
 	struct ptdesc *ptdesc = virt_to_ptdesc(table);
 
-	pagetable_pte_dtor_free(ptdesc);
+	pagetable_dtor_free(ptdesc);
 }
 
 void __tlb_remove_table(void *table)
 {
 	struct ptdesc *ptdesc = virt_to_ptdesc(table);
-	struct page *page = ptdesc_page(ptdesc);
 
-	if (compound_order(page) == CRST_ALLOC_ORDER) {
-		/* pmd, pud, or p4d */
-		pagetable_free(ptdesc);
-		return;
-	}
-	pagetable_pte_dtor_free(ptdesc);
+	pagetable_dtor_free(ptdesc);
 }
 
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
@@ -211,7 +205,7 @@ static void pte_free_now(struct rcu_head *head)
 {
 	struct ptdesc *ptdesc = container_of(head, struct ptdesc, pt_rcu_head);
 
-	pagetable_pte_dtor_free(ptdesc);
+	pagetable_dtor_free(ptdesc);
 }
 
 void pte_free_defer(struct mm_struct *mm, pgtable_t pgtable)
-- 
2.20.1


