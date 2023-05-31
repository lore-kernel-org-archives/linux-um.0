Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E18D5C87FDE
	for <linux-um@archiver.kernel.org>; Wed, 31 May 2023 21:33:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=dfjzSoeU1dq+8st8J9zKV8xsT+hWRTkNGB+vGnwyuQQ=; b=RCLzr9jov6mX3x
	sz90LAH4DLMhVX/aFgkiMEb4qWam1GgBxLyzKR3axd+mshJNO37isP0S3sWGbCkiJnHmwgMZ/pM7F
	sP/pvZTSJymVAiovKb1wb1oPupGf0IBcfZsCiBRaJKJ8Lx0vgxYiMFv19jDtlFAZtBC/N720sq0a9
	8skjFW4RtDRJ7qf/vJt71UOUgrqiiBvu5XVZBBv9U4ujRwHlaOyth30kvwcNkxlXk+8ZYkLE1qImB
	+VAoNUh3wVH7VT8GpBEPgu2D82Smb3LAyvZ3DFH8GPn7TBcuJMidhRm06wg2TQIxDHJnZK8GF528n
	6RrydYGSmHlyPe7PWIkA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q4TRG-001Ax2-1Z;
	Wed, 31 May 2023 21:33:02 +0000
Received: from mail-yw1-f169.google.com ([209.85.128.169])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q4TQG-001APo-1y;
	Wed, 31 May 2023 21:32:06 +0000
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-55db055b412so22309827b3.0;
        Wed, 31 May 2023 14:31:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685568718; x=1688160718;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iEZT4iY8EEl9pa7al7MLo6hk70lgBLqPfTLtEBGVb+s=;
        b=PGO1theuZfi6ZrSPVpMFRQAeOHsn5pMjC8xgKa8aRHHFy/i2vTnGPbNlxfLx+6Euaq
         Hf4qVvFQ61uRrkfUN+YNchpjFmVCPYUXGh7NblhXFTi/GX4kJQBqzqLIMTqMj4VWjiVr
         t8NWR43kuHnjQ8iMMng7kHUvIdpNqX/tRzg++sr2gZfQOVzgSjuKT3bzIA3uSG7kWgDQ
         17UYBKLxvl6bX7QLV22k75B/kUNvf5SVMTA3n26j13v0+L9xXBnD6yck43hrFvtcREzQ
         KMCTc+ZOGPqah06KW6AsjVfXFVLRcSZafJ7+MXnceNvSPC9LkpMpq/Z7sCtXDDCHjgXH
         Kgmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685568718; x=1688160718;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iEZT4iY8EEl9pa7al7MLo6hk70lgBLqPfTLtEBGVb+s=;
        b=AMZJHNXXq+Nnc/aVgLndRT0LD1p4I0HEfj9rRBhCbblkbHvgretdGFzW2Our8jlodo
         y8LycMZynQ+/z9BdGJQ6nESdvtR3POVTkEFM0+6ODtP5COYdJUcc0UP6K0uHAEe13Bpz
         ESn6yj62gFoNZppTg+aVgucSC/qFaK8cmZYAYator8Su6i1h7cvCNrxmYpYdnaDaoEvN
         KmMh6jiGCc8IqpactI02IsUEBkF76xmCqqcnRuHAxzKFee6qEVL5z0PGC+S6jPtczmsc
         tFEWnrIKKzmQi8SlqP3O6mpdqYf2Wfke+cs25ff6qhKFMjQa3KmfswtieSqrejsC3wzv
         kQzA==
X-Gm-Message-State: AC+VfDx3W0abHUIsYtxqUDX8gWqyMbEo8N9ZiW+2D2U7lrSMwRUvD625
	KHLMBFPEO7j+QI1uJJq0GWA=
X-Google-Smtp-Source: ACHHUZ4Otln+kVOEgUySV1ArKpIYvBeruzYUd+lmycqZnK7GGCWSTwkmzaWpGSc76/XUk7nK9Exgbg==
X-Received: by 2002:a81:4f05:0:b0:561:987e:27a with SMTP id d5-20020a814f05000000b00561987e027amr7848466ywb.10.1685568718603;
        Wed, 31 May 2023 14:31:58 -0700 (PDT)
Received: from unknowna0e70b2ca394.attlocal.net ([2600:1700:2f7d:1800::46])
        by smtp.googlemail.com with ESMTPSA id t63-20020a0dd142000000b0055aafcef659sm658905ywd.5.2023.05.31.14.31.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 May 2023 14:31:58 -0700 (PDT)
From: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Matthew Wilcox <willy@infradead.org>
Cc: linux-mm@kvack.org,
	linux-arch@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-csky@vger.kernel.org,
	linux-hexagon@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-m68k@lists.linux-m68k.org,
	linux-mips@vger.kernel.org,
	linux-openrisc@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	linux-sh@vger.kernel.org,
	sparclinux@vger.kernel.org,
	linux-um@lists.infradead.org,
	xen-devel@lists.xenproject.org,
	kvm@vger.kernel.org,
	"Vishal Moola (Oracle)" <vishal.moola@gmail.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH v3 25/34] m68k: Convert various functions to use ptdescs
Date: Wed, 31 May 2023 14:30:23 -0700
Message-Id: <20230531213032.25338-26-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230531213032.25338-1-vishal.moola@gmail.com>
References: <20230531213032.25338-1-vishal.moola@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230531_143200_648679_06191CF8 
X-CRM114-Status: GOOD (  16.35  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

As part of the conversions to replace pgtable constructor/destructors with
ptdesc equivalents, convert various page table functions to use ptdescs.

Some of the functions use the *get*page*() helper functions. Convert
these to use pagetable_alloc() and ptdesc_address() instead to help
standardize page tables further.

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
---
 arch/m68k/include/asm/mcf_pgalloc.h  | 41 ++++++++++++++--------------
 arch/m68k/include/asm/sun3_pgalloc.h |  8 +++---
 arch/m68k/mm/motorola.c              |  4 +--
 3 files changed, 27 insertions(+), 26 deletions(-)

diff --git a/arch/m68k/include/asm/mcf_pgalloc.h b/arch/m68k/include/asm/mcf_pgalloc.h
index 5c2c0a864524..9eb4ef9e6d77 100644
--- a/arch/m68k/include/asm/mcf_pgalloc.h
+++ b/arch/m68k/include/asm/mcf_pgalloc.h
@@ -7,20 +7,19 @@
 
 extern inline void pte_free_kernel(struct mm_struct *mm, pte_t *pte)
 {
-	free_page((unsigned long) pte);
+	pagetable_free(virt_to_ptdesc(pte));
 }
 
 extern const char bad_pmd_string[];
 
 extern inline pte_t *pte_alloc_one_kernel(struct mm_struct *mm)
 {
-	unsigned long page = __get_free_page(GFP_DMA);
+	struct ptdesc *ptdesc = pagetable_alloc(GFP_DMA | __GFP_ZERO, 0);
 
-	if (!page)
+	if (!ptdesc)
 		return NULL;
 
-	memset((void *)page, 0, PAGE_SIZE);
-	return (pte_t *) (page);
+	return (pte_t *) (ptdesc_address(ptdesc));
 }
 
 extern inline pmd_t *pmd_alloc_kernel(pgd_t *pgd, unsigned long address)
@@ -35,36 +34,36 @@ extern inline pmd_t *pmd_alloc_kernel(pgd_t *pgd, unsigned long address)
 static inline void __pte_free_tlb(struct mmu_gather *tlb, pgtable_t pgtable,
 				  unsigned long address)
 {
-	struct page *page = virt_to_page(pgtable);
+	struct ptdesc *ptdesc = virt_to_ptdesc(pgtable);
 
-	pgtable_pte_page_dtor(page);
-	__free_page(page);
+	pagetable_pte_dtor(ptdesc);
+	pagetable_free(ptdesc);
 }
 
 static inline pgtable_t pte_alloc_one(struct mm_struct *mm)
 {
-	struct page *page = alloc_pages(GFP_DMA, 0);
+	struct ptdesc *ptdesc = pagetable_alloc(GFP_DMA, 0);
 	pte_t *pte;
 
-	if (!page)
+	if (!ptdesc)
 		return NULL;
-	if (!pgtable_pte_page_ctor(page)) {
-		__free_page(page);
+	if (!pagetable_pte_ctor(ptdesc)) {
+		pagetable_free(ptdesc);
 		return NULL;
 	}
 
-	pte = page_address(page);
-	clear_page(pte);
+	pte = ptdesc_address(ptdesc);
+	pagetable_clear(pte);
 
 	return pte;
 }
 
 static inline void pte_free(struct mm_struct *mm, pgtable_t pgtable)
 {
-	struct page *page = virt_to_page(pgtable);
+	struct ptdesc *ptdesc = virt_to_ptdesc(ptdesc);
 
-	pgtable_pte_page_dtor(page);
-	__free_page(page);
+	pagetable_pte_dtor(ptdesc);
+	pagetable_free(ptdesc);
 }
 
 /*
@@ -75,16 +74,18 @@ static inline void pte_free(struct mm_struct *mm, pgtable_t pgtable)
 
 static inline void pgd_free(struct mm_struct *mm, pgd_t *pgd)
 {
-	free_page((unsigned long) pgd);
+	pagetable_free(virt_to_ptdesc(pgd));
 }
 
 static inline pgd_t *pgd_alloc(struct mm_struct *mm)
 {
 	pgd_t *new_pgd;
+	struct ptdesc *ptdesc = pagetable_alloc(GFP_DMA | GFP_NOWARN, 0);
 
-	new_pgd = (pgd_t *)__get_free_page(GFP_DMA | __GFP_NOWARN);
-	if (!new_pgd)
+	if (!ptdesc)
 		return NULL;
+	new_pgd = (pgd_t *) ptdesc_address(ptdesc);
+
 	memcpy(new_pgd, swapper_pg_dir, PTRS_PER_PGD * sizeof(pgd_t));
 	memset(new_pgd, 0, PAGE_OFFSET >> PGDIR_SHIFT);
 	return new_pgd;
diff --git a/arch/m68k/include/asm/sun3_pgalloc.h b/arch/m68k/include/asm/sun3_pgalloc.h
index 198036aff519..ff48573db2c0 100644
--- a/arch/m68k/include/asm/sun3_pgalloc.h
+++ b/arch/m68k/include/asm/sun3_pgalloc.h
@@ -17,10 +17,10 @@
 
 extern const char bad_pmd_string[];
 
-#define __pte_free_tlb(tlb,pte,addr)			\
-do {							\
-	pgtable_pte_page_dtor(pte);			\
-	tlb_remove_page((tlb), pte);			\
+#define __pte_free_tlb(tlb, pte, addr)				\
+do {								\
+	pagetable_pte_dtor(page_ptdesc(pte));			\
+	tlb_remove_page_ptdesc((tlb), page_ptdesc(pte));	\
 } while (0)
 
 static inline void pmd_populate_kernel(struct mm_struct *mm, pmd_t *pmd, pte_t *pte)
diff --git a/arch/m68k/mm/motorola.c b/arch/m68k/mm/motorola.c
index c75984e2d86b..594575a0780c 100644
--- a/arch/m68k/mm/motorola.c
+++ b/arch/m68k/mm/motorola.c
@@ -161,7 +161,7 @@ void *get_pointer_table(int type)
 			 * m68k doesn't have SPLIT_PTE_PTLOCKS for not having
 			 * SMP.
 			 */
-			pgtable_pte_page_ctor(virt_to_page(page));
+			pagetable_pte_ctor(virt_to_ptdesc(page));
 		}
 
 		mmu_page_ctor(page);
@@ -201,7 +201,7 @@ int free_pointer_table(void *table, int type)
 		list_del(dp);
 		mmu_page_dtor((void *)page);
 		if (type == TABLE_PTE)
-			pgtable_pte_page_dtor(virt_to_page((void *)page));
+			pagetable_pte_dtor(virt_to_ptdesc((void *)page));
 		free_page (page);
 		return 1;
 	} else if (ptable_list[type].next != dp) {
-- 
2.40.1


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
