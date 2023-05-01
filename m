Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25857C77B73
	for <linux-um@archiver.kernel.org>; Mon,  1 May 2023 19:48:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=a8vKZfO9kUwaxAqe6YUl++/1+AfqHVHikzcVTtbWJaI=; b=ZggjGkYITML4J2
	KuXvuxCZaeQhUZIBwUlF4uvtis4OhHf5MWSa81MUDfOW9WkeLygl1hlz+0Ut8sgHHOphvdN3H8XBj
	/DSxzH0trZDAnhhafX65lLRN8axh9poBot9ohW75v1gsFdWEFWJImaSi1Bg+T8JuQB+rqxvrU14j6
	LeCeYMY9FDiRYT6IlEQ25ydHfqGUG2QKirVfsjZseXuOayn2IfZ7daEee3r63IO8AVOIvCF568TS0
	+z9cTCfDIBhS3N8VQHc28hJcjnk+aJ/L87c9I7wOyeiCmUHk9dcWZmzhedUsE2lsRZGerL4rS6WHC
	EKr5F5b7+Lecvi3IeFwg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1ptZV8-00GllZ-1G;
	Mon, 01 May 2023 19:47:58 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1ptZUf-00GlDP-1h;
	Mon, 01 May 2023 19:47:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=ZNft63XW9H/x5zK6HuCJK1zZ20bn1woHqcJTdinQF34=; b=CJda3SOmbQl1euiXMjVp5K9F1g
	3lytwlATlJrDz6G7DCFe7gqVVPDb6iXA+W6LKiEmVnY/QglaSmQGKMzc2L9E9jcSRfg81ChyhRoBj
	PHCl2+Qeg4TvHMHYP97+m+UNMNzebCPRcVMotjS0k1qRd1L8qL3+pFRMvvhNmIg5GVQ85Z+tQn9mF
	iigQGJCQv0qRu/D3GpG9L2kiRRoyBTCI47iHXhWmRIQi7TCGjw/XTyCw6sF4jMrxcqHVisT5/THzq
	zcA1pWVuHZde0ik5QraxPj9FMSPndKV2aB2V/sqzlvfsxs2sq7ZUweZArCihdMB6AHUKvFOdHoiFQ
	XGb+VjCQ==;
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
	by casper.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ptZCj-007cnJ-67; Mon, 01 May 2023 19:29:01 +0000
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1ab01bf474aso6105835ad.1;
        Mon, 01 May 2023 12:28:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682969333; x=1685561333;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZNft63XW9H/x5zK6HuCJK1zZ20bn1woHqcJTdinQF34=;
        b=B5BQ0PUPuJOe03g2Zj4SmcYFdZoHhvQEhjHjXIrDV/cPLgWmHOnGLph27PMtDy+gUk
         vrb8aMyrjxs7+rH+bt4rcFQy1jeum2KTcgeZne4eID9YQx0p8xFIvsQDPlXa9T02F5bm
         XDuuEHyhAFLF/N4HXmu9lHkWjBlAxtCK794Vd1UTAVcPxs1s/UJDMyYjBVgG5TX0KFIE
         Ex1W8v+MyjG1XFcX2NmMKnrKsIeNEQB+OMbajwZPymWFDvUYoyj1bmkkKVL9eBJZnPmo
         n2i7pNy6eK/amTh+JnM4F05ImhBvIH/eExR134Xtgm68Uv7no3ItCNvBtZlMVAsp6dYE
         5mrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682969333; x=1685561333;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZNft63XW9H/x5zK6HuCJK1zZ20bn1woHqcJTdinQF34=;
        b=AaukEFVF6pXMYohNMI8WQELH+uO/eKFllWS+wmnytElhqy++eQ7Upx9wV4CwyRqssb
         1CftUJ4QAiPff9QutcAx3Gxvvbk0gMg1Dg3p9fnh0QEsSJ+Bsya2YZFQlZDZh68//MV7
         UNl1jjbAmcb1vy18dcO8VoAHCyMGxKPPDcJpOy6N5SK7HuL0adXvYEzbG5Mjcm/hXN9J
         eCfILnEY7cevZophJnv+HirIjVpdvWIhVXWZpwTg4pWpEVuOhP/Kxx230h/dotlHaCK9
         qtfmjTkRlyN9MA9HLu2T6V6SkIBfBnGJgcnTc4NPl3wRNb87QCvuAfaWmcKQAEoeGGfS
         8zdg==
X-Gm-Message-State: AC+VfDxu08q6EIgSgaa0LrpUpSZYrxAhARYAbsu8Mo6GNn2byI/0Lzp8
	+f7PM/IgLqSsDDzJ1nFpUEc=
X-Google-Smtp-Source: ACHHUZ5/VRaG2onpIf15XR/3p6i4VphUhlpU8l14iUMmxT/o+LeZ6COrGbtS8DM/yhDOMNorlLAd2g==
X-Received: by 2002:a17:902:d48b:b0:1a6:ef75:3c53 with SMTP id c11-20020a170902d48b00b001a6ef753c53mr18457119plg.11.1682969333517;
        Mon, 01 May 2023 12:28:53 -0700 (PDT)
Received: from fedora.hsd1.ca.comcast.net ([2601:644:937f:7f20::9a2c])
        by smtp.googlemail.com with ESMTPSA id u8-20020a170902bf4800b0019c13d032d8sm18175622pls.253.2023.05.01.12.28.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 May 2023 12:28:53 -0700 (PDT)
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
	"Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [PATCH v2 14/34] powerpc: Convert various functions to use ptdescs
Date: Mon,  1 May 2023 12:28:09 -0700
Message-Id: <20230501192829.17086-15-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230501192829.17086-1-vishal.moola@gmail.com>
References: <20230501192829.17086-1-vishal.moola@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230501_202857_387845_60884D3A 
X-CRM114-Status: GOOD (  15.20  )
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

In order to split struct ptdesc from struct page, convert various
functions to use ptdescs.

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
---
 arch/powerpc/mm/book3s64/mmu_context.c | 10 +++---
 arch/powerpc/mm/book3s64/pgtable.c     | 32 +++++++++---------
 arch/powerpc/mm/pgtable-frag.c         | 46 +++++++++++++-------------
 3 files changed, 44 insertions(+), 44 deletions(-)

diff --git a/arch/powerpc/mm/book3s64/mmu_context.c b/arch/powerpc/mm/book3s64/mmu_context.c
index c766e4c26e42..b22ad2839897 100644
--- a/arch/powerpc/mm/book3s64/mmu_context.c
+++ b/arch/powerpc/mm/book3s64/mmu_context.c
@@ -246,15 +246,15 @@ static void destroy_contexts(mm_context_t *ctx)
 static void pmd_frag_destroy(void *pmd_frag)
 {
 	int count;
-	struct page *page;
+	struct ptdesc *ptdesc;
 
-	page = virt_to_page(pmd_frag);
+	ptdesc = virt_to_ptdesc(pmd_frag);
 	/* drop all the pending references */
 	count = ((unsigned long)pmd_frag & ~PAGE_MASK) >> PMD_FRAG_SIZE_SHIFT;
 	/* We allow PTE_FRAG_NR fragments from a PTE page */
-	if (atomic_sub_and_test(PMD_FRAG_NR - count, &page->pt_frag_refcount)) {
-		pgtable_pmd_page_dtor(page);
-		__free_page(page);
+	if (atomic_sub_and_test(PMD_FRAG_NR - count, &ptdesc->pt_frag_refcount)) {
+		ptdesc_pmd_dtor(ptdesc);
+		ptdesc_free(ptdesc);
 	}
 }
 
diff --git a/arch/powerpc/mm/book3s64/pgtable.c b/arch/powerpc/mm/book3s64/pgtable.c
index 85c84e89e3ea..da46e3efc66c 100644
--- a/arch/powerpc/mm/book3s64/pgtable.c
+++ b/arch/powerpc/mm/book3s64/pgtable.c
@@ -306,22 +306,22 @@ static pmd_t *get_pmd_from_cache(struct mm_struct *mm)
 static pmd_t *__alloc_for_pmdcache(struct mm_struct *mm)
 {
 	void *ret = NULL;
-	struct page *page;
+	struct ptdesc *ptdesc;
 	gfp_t gfp = GFP_KERNEL_ACCOUNT | __GFP_ZERO;
 
 	if (mm == &init_mm)
 		gfp &= ~__GFP_ACCOUNT;
-	page = alloc_page(gfp);
-	if (!page)
+	ptdesc = ptdesc_alloc(gfp, 0);
+	if (!ptdesc)
 		return NULL;
-	if (!pgtable_pmd_page_ctor(page)) {
-		__free_pages(page, 0);
+	if (!ptdesc_pmd_ctor(ptdesc)) {
+		ptdesc_free(ptdesc);
 		return NULL;
 	}
 
-	atomic_set(&page->pt_frag_refcount, 1);
+	atomic_set(&ptdesc->pt_frag_refcount, 1);
 
-	ret = page_address(page);
+	ret = ptdesc_address(ptdesc);
 	/*
 	 * if we support only one fragment just return the
 	 * allocated page.
@@ -331,12 +331,12 @@ static pmd_t *__alloc_for_pmdcache(struct mm_struct *mm)
 
 	spin_lock(&mm->page_table_lock);
 	/*
-	 * If we find pgtable_page set, we return
+	 * If we find ptdesc_page set, we return
 	 * the allocated page with single fragment
 	 * count.
 	 */
 	if (likely(!mm->context.pmd_frag)) {
-		atomic_set(&page->pt_frag_refcount, PMD_FRAG_NR);
+		atomic_set(&ptdesc->pt_frag_refcount, PMD_FRAG_NR);
 		mm->context.pmd_frag = ret + PMD_FRAG_SIZE;
 	}
 	spin_unlock(&mm->page_table_lock);
@@ -357,15 +357,15 @@ pmd_t *pmd_fragment_alloc(struct mm_struct *mm, unsigned long vmaddr)
 
 void pmd_fragment_free(unsigned long *pmd)
 {
-	struct page *page = virt_to_page(pmd);
+	struct ptdesc *ptdesc = virt_to_ptdesc(pmd);
 
-	if (PageReserved(page))
-		return free_reserved_page(page);
+	if (ptdesc_is_reserved(ptdesc))
+		return free_reserved_ptdesc(ptdesc);
 
-	BUG_ON(atomic_read(&page->pt_frag_refcount) <= 0);
-	if (atomic_dec_and_test(&page->pt_frag_refcount)) {
-		pgtable_pmd_page_dtor(page);
-		__free_page(page);
+	BUG_ON(atomic_read(&ptdesc->pt_frag_refcount) <= 0);
+	if (atomic_dec_and_test(&ptdesc->pt_frag_refcount)) {
+		ptdesc_pmd_dtor(ptdesc);
+		ptdesc_free(ptdesc);
 	}
 }
 
diff --git a/arch/powerpc/mm/pgtable-frag.c b/arch/powerpc/mm/pgtable-frag.c
index 20652daa1d7e..b53e18fab74a 100644
--- a/arch/powerpc/mm/pgtable-frag.c
+++ b/arch/powerpc/mm/pgtable-frag.c
@@ -18,15 +18,15 @@
 void pte_frag_destroy(void *pte_frag)
 {
 	int count;
-	struct page *page;
+	struct ptdesc *ptdesc;
 
-	page = virt_to_page(pte_frag);
+	ptdesc = virt_to_ptdesc(pte_frag);
 	/* drop all the pending references */
 	count = ((unsigned long)pte_frag & ~PAGE_MASK) >> PTE_FRAG_SIZE_SHIFT;
 	/* We allow PTE_FRAG_NR fragments from a PTE page */
-	if (atomic_sub_and_test(PTE_FRAG_NR - count, &page->pt_frag_refcount)) {
-		pgtable_pte_page_dtor(page);
-		__free_page(page);
+	if (atomic_sub_and_test(PTE_FRAG_NR - count, &ptdesc->pt_frag_refcount)) {
+		ptdesc_pte_dtor(ptdesc);
+		ptdesc_free(ptdesc);
 	}
 }
 
@@ -55,25 +55,25 @@ static pte_t *get_pte_from_cache(struct mm_struct *mm)
 static pte_t *__alloc_for_ptecache(struct mm_struct *mm, int kernel)
 {
 	void *ret = NULL;
-	struct page *page;
+	struct ptdesc *ptdesc;
 
 	if (!kernel) {
-		page = alloc_page(PGALLOC_GFP | __GFP_ACCOUNT);
-		if (!page)
+		ptdesc = ptdesc_alloc(PGALLOC_GFP | __GFP_ACCOUNT, 0);
+		if (!ptdesc)
 			return NULL;
-		if (!pgtable_pte_page_ctor(page)) {
-			__free_page(page);
+		if (!ptdesc_pte_ctor(ptdesc)) {
+			ptdesc_free(ptdesc);
 			return NULL;
 		}
 	} else {
-		page = alloc_page(PGALLOC_GFP);
-		if (!page)
+		ptdesc = ptdesc_alloc(PGALLOC_GFP, 0);
+		if (!ptdesc)
 			return NULL;
 	}
 
-	atomic_set(&page->pt_frag_refcount, 1);
+	atomic_set(&ptdesc->pt_frag_refcount, 1);
 
-	ret = page_address(page);
+	ret = ptdesc_address(ptdesc);
 	/*
 	 * if we support only one fragment just return the
 	 * allocated page.
@@ -82,12 +82,12 @@ static pte_t *__alloc_for_ptecache(struct mm_struct *mm, int kernel)
 		return ret;
 	spin_lock(&mm->page_table_lock);
 	/*
-	 * If we find pgtable_page set, we return
+	 * If we find ptdesc_page set, we return
 	 * the allocated page with single fragment
 	 * count.
 	 */
 	if (likely(!pte_frag_get(&mm->context))) {
-		atomic_set(&page->pt_frag_refcount, PTE_FRAG_NR);
+		atomic_set(&ptdesc->pt_frag_refcount, PTE_FRAG_NR);
 		pte_frag_set(&mm->context, ret + PTE_FRAG_SIZE);
 	}
 	spin_unlock(&mm->page_table_lock);
@@ -108,15 +108,15 @@ pte_t *pte_fragment_alloc(struct mm_struct *mm, int kernel)
 
 void pte_fragment_free(unsigned long *table, int kernel)
 {
-	struct page *page = virt_to_page(table);
+	struct ptdesc *ptdesc = virt_to_ptdesc(table);
 
-	if (PageReserved(page))
-		return free_reserved_page(page);
+	if (ptdesc_is_reserved(ptdesc))
+		return free_reserved_ptdesc(ptdesc);
 
-	BUG_ON(atomic_read(&page->pt_frag_refcount) <= 0);
-	if (atomic_dec_and_test(&page->pt_frag_refcount)) {
+	BUG_ON(atomic_read(&ptdesc->pt_frag_refcount) <= 0);
+	if (atomic_dec_and_test(&ptdesc->pt_frag_refcount)) {
 		if (!kernel)
-			pgtable_pte_page_dtor(page);
-		__free_page(page);
+			ptdesc_pte_dtor(ptdesc);
+		ptdesc_free(ptdesc);
 	}
 }
-- 
2.39.2


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
