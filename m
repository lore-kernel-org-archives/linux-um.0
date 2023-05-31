Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68FE4C77B7A
	for <linux-um@archiver.kernel.org>; Wed, 31 May 2023 21:55:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=SMjRVShsQDYXIEd+Z9CAAS11001ja0iCtrIonj7Pk8U=; b=g9ZGLXcULThRA7
	D1/vUXS1ATm0NLwc/r4rw8anquaRBy75GpdN0a1yfklr4HVX5TZrgfKdIKar+Un+ExuTyCJFJLQzZ
	DKSpWqgU/ZcNZGGBL/Aj0evV+XNYSsWP8VCOUzYwoHTNLz1Z2/Ocv+VOoWRBDDK31D6pGzD1LenMS
	DKjXlr/8M8SkPReF7Zc424bpt/iFDRVEqsEzzclIEI+jwbqp03gpQEUkAldJSwDm7FtjAg1Ehj5dy
	YJFtMyTweRv2eKzctTmpSZLAlWPNbqu8lYLk0g4cBMthizqxFW+d7FLT+YfxitHK7Gi9nEx8WE9kv
	IBNB/JMECucBXVkFrDDw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q4TmW-001EtW-2z;
	Wed, 31 May 2023 21:55:00 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q4TmB-001EaC-2R;
	Wed, 31 May 2023 21:54:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=P4oKpN44FwSHo9/T7M2wxV2695OWbA5/gOtyDCnuhZU=; b=p1M59DYfuKlfMoc8MpMtkOxud0
	0XuwDClxrImfxt0PYlCvOPWDUyJsELkShVXAhE63LGyxwpi29GRxCj/Z4kkL6qTI29Opba/aH9qsR
	wxJ+1Nn+vtChmo/Mnoa2YoTrXzxwK9bhPo398fakNHv9T2uLQudQF8LaJI6HMU0J5ejSM+XjtjTfb
	FaXKfTREPdNZV+sYGbOiuqx9KovwSGLbQeNdfZJ7IANyCDnWUV/d9JGs9+Gke0dYHakADwxXK9xuf
	ryT28oH7hDm7PCedh1CupLwpnJMf4XMgWTodRsGqjVWwWOfA23dc0Bk9DTqQ6YN4P3C4/qHYM1tcQ
	4nj/Me+g==;
Received: from mail-yw1-x1129.google.com ([2607:f8b0:4864:20::1129])
	by casper.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1q4TQ4-007fk0-Uq; Wed, 31 May 2023 21:31:50 +0000
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-565bd368e19so797757b3.1;
        Wed, 31 May 2023 14:31:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685568707; x=1688160707;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P4oKpN44FwSHo9/T7M2wxV2695OWbA5/gOtyDCnuhZU=;
        b=sqsXs3WYNhTysc3aTx28iPtHSvphFkiMR2eHXkB7o2KtkKwUS1n7i2swDh0KUO31WT
         vavq1N/QnPwK/noQMjdRqJgHjHH9y1SbXtcnoH8vWPU6cfMxQg3fey32EPBGxlhGICtg
         d8p/rta/A6M/whTQ0SC5TRg4TVCyj1UgJEz0AD/6Adc/3sAai7pLjPybThunWDVH0699
         DJojWygC0Hk+BqL+vYwU7r82IBRSNnvoC+HA8BiJR1lfy1uKogoYj7KNe4JDvOtpNfpw
         fDp/K8vIfXRi0kNe3liDJnJyivYwfRujVeTE2teBbN8ilRdSN+O8021GFlawVUTXhajU
         nKiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685568707; x=1688160707;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P4oKpN44FwSHo9/T7M2wxV2695OWbA5/gOtyDCnuhZU=;
        b=I7asDDXlPK74LTp+5ZA8n8Ww+rxanTR/cN12zR4J65bv7Q9FnPwPqS0RYnn+OxQcay
         q00mv7Ye+XAwaUnt9kpLZDz/+nlMMbxGH6h+sQFX7B7sI9lCL5NbEbfXnfWPTB3pfQqZ
         Lo5AxBQGq5g1FJRIx05lwbnHHKXAttRtytmXYXIjbnQ5UHSVfBHLFfvblGD1OgN7rFtZ
         ZQzdniyINKW1yMOEK9M+xkyfCrHXiilDJCbz3jXkv0yWsg+M/0o5Wi7mqzCf+YfKGPOA
         QSeLkze/b/8ctuNzJVAOTPjssx7PINAq2turIG4wXcgn60Fo5PU+XxrjwDJruSOO38z/
         guBQ==
X-Gm-Message-State: AC+VfDwNheEzC6tsrGcHvShsuKBtg2LM9mEZPSYvGnqZdPG+HXudp5je
	re/GIQ4OIYTJ1ilQCbsD6BM=
X-Google-Smtp-Source: ACHHUZ4cUrGzzAXtFYmG5Rt72zlr1Ku9VNItY9WpWFz1hTE12ha2fk+XvRIynyT8hJNvgfTr9E++sw==
X-Received: by 2002:a25:aa03:0:b0:ba8:5fd6:e657 with SMTP id s3-20020a25aa03000000b00ba85fd6e657mr7836976ybi.49.1685568706939;
        Wed, 31 May 2023 14:31:46 -0700 (PDT)
Received: from unknowna0e70b2ca394.attlocal.net ([2600:1700:2f7d:1800::46])
        by smtp.googlemail.com with ESMTPSA id t63-20020a0dd142000000b0055aafcef659sm658905ywd.5.2023.05.31.14.31.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 May 2023 14:31:46 -0700 (PDT)
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
	Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v3 19/34] pgalloc: Convert various functions to use ptdescs
Date: Wed, 31 May 2023 14:30:17 -0700
Message-Id: <20230531213032.25338-20-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230531213032.25338-1-vishal.moola@gmail.com>
References: <20230531213032.25338-1-vishal.moola@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230531_223149_003306_605986A8 
X-CRM114-Status: GOOD (  16.29  )
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
 include/asm-generic/pgalloc.h | 62 +++++++++++++++++++++--------------
 1 file changed, 37 insertions(+), 25 deletions(-)

diff --git a/include/asm-generic/pgalloc.h b/include/asm-generic/pgalloc.h
index a7cf825befae..1e5799ba2e56 100644
--- a/include/asm-generic/pgalloc.h
+++ b/include/asm-generic/pgalloc.h
@@ -18,7 +18,11 @@
  */
 static inline pte_t *__pte_alloc_one_kernel(struct mm_struct *mm)
 {
-	return (pte_t *)__get_free_page(GFP_PGTABLE_KERNEL);
+	struct ptdesc *ptdesc = pagetable_alloc(GFP_PGTABLE_KERNEL, 0);
+
+	if (!ptdesc)
+		return NULL;
+	return (pte_t *)ptdesc_address(ptdesc);
 }
 
 #ifndef __HAVE_ARCH_PTE_ALLOC_ONE_KERNEL
@@ -41,7 +45,7 @@ static inline pte_t *pte_alloc_one_kernel(struct mm_struct *mm)
  */
 static inline void pte_free_kernel(struct mm_struct *mm, pte_t *pte)
 {
-	free_page((unsigned long)pte);
+	pagetable_free(virt_to_ptdesc(pte));
 }
 
 /**
@@ -49,7 +53,7 @@ static inline void pte_free_kernel(struct mm_struct *mm, pte_t *pte)
  * @mm: the mm_struct of the current context
  * @gfp: GFP flags to use for the allocation
  *
- * Allocates a page and runs the pgtable_pte_page_ctor().
+ * Allocates a ptdesc and runs the pagetable_pte_ctor().
  *
  * This function is intended for architectures that need
  * anything beyond simple page allocation or must have custom GFP flags.
@@ -58,17 +62,17 @@ static inline void pte_free_kernel(struct mm_struct *mm, pte_t *pte)
  */
 static inline pgtable_t __pte_alloc_one(struct mm_struct *mm, gfp_t gfp)
 {
-	struct page *pte;
+	struct ptdesc *ptdesc;
 
-	pte = alloc_page(gfp);
-	if (!pte)
+	ptdesc = pagetable_alloc(gfp, 0);
+	if (!ptdesc)
 		return NULL;
-	if (!pgtable_pte_page_ctor(pte)) {
-		__free_page(pte);
+	if (!pagetable_pte_ctor(ptdesc)) {
+		pagetable_free(ptdesc);
 		return NULL;
 	}
 
-	return pte;
+	return ptdesc_page(ptdesc);
 }
 
 #ifndef __HAVE_ARCH_PTE_ALLOC_ONE
@@ -76,7 +80,7 @@ static inline pgtable_t __pte_alloc_one(struct mm_struct *mm, gfp_t gfp)
  * pte_alloc_one - allocate a page for PTE-level user page table
  * @mm: the mm_struct of the current context
  *
- * Allocates a page and runs the pgtable_pte_page_ctor().
+ * Allocates a ptdesc and runs the pagetable_pte_ctor().
  *
  * Return: `struct page` initialized as page table or %NULL on error
  */
@@ -98,8 +102,10 @@ static inline pgtable_t pte_alloc_one(struct mm_struct *mm)
  */
 static inline void pte_free(struct mm_struct *mm, struct page *pte_page)
 {
-	pgtable_pte_page_dtor(pte_page);
-	__free_page(pte_page);
+	struct ptdesc *ptdesc = page_ptdesc(pte_page);
+
+	pagetable_pte_dtor(ptdesc);
+	pagetable_free(ptdesc);
 }
 
 
@@ -110,7 +116,7 @@ static inline void pte_free(struct mm_struct *mm, struct page *pte_page)
  * pmd_alloc_one - allocate a page for PMD-level page table
  * @mm: the mm_struct of the current context
  *
- * Allocates a page and runs the pgtable_pmd_page_ctor().
+ * Allocates a ptdesc and runs the pagetable_pmd_ctor().
  * Allocations use %GFP_PGTABLE_USER in user context and
  * %GFP_PGTABLE_KERNEL in kernel context.
  *
@@ -118,28 +124,30 @@ static inline void pte_free(struct mm_struct *mm, struct page *pte_page)
  */
 static inline pmd_t *pmd_alloc_one(struct mm_struct *mm, unsigned long addr)
 {
-	struct page *page;
+	struct ptdesc *ptdesc;
 	gfp_t gfp = GFP_PGTABLE_USER;
 
 	if (mm == &init_mm)
 		gfp = GFP_PGTABLE_KERNEL;
-	page = alloc_page(gfp);
-	if (!page)
+	ptdesc = pagetable_alloc(gfp, 0);
+	if (!ptdesc)
 		return NULL;
-	if (!pgtable_pmd_page_ctor(page)) {
-		__free_page(page);
+	if (!pagetable_pmd_ctor(ptdesc)) {
+		pagetable_free(ptdesc);
 		return NULL;
 	}
-	return (pmd_t *)page_address(page);
+	return (pmd_t *)ptdesc_address(ptdesc);
 }
 #endif
 
 #ifndef __HAVE_ARCH_PMD_FREE
 static inline void pmd_free(struct mm_struct *mm, pmd_t *pmd)
 {
+	struct ptdesc *ptdesc = virt_to_ptdesc(pmd);
+
 	BUG_ON((unsigned long)pmd & (PAGE_SIZE-1));
-	pgtable_pmd_page_dtor(virt_to_page(pmd));
-	free_page((unsigned long)pmd);
+	pagetable_pmd_dtor(ptdesc);
+	pagetable_free(ptdesc);
 }
 #endif
 
@@ -149,11 +157,15 @@ static inline void pmd_free(struct mm_struct *mm, pmd_t *pmd)
 
 static inline pud_t *__pud_alloc_one(struct mm_struct *mm, unsigned long addr)
 {
-	gfp_t gfp = GFP_PGTABLE_USER;
+	gfp_t gfp = GFP_PGTABLE_USER | __GFP_ZERO;
+	struct ptdesc *ptdesc;
 
 	if (mm == &init_mm)
 		gfp = GFP_PGTABLE_KERNEL;
-	return (pud_t *)get_zeroed_page(gfp);
+	ptdesc = pagetable_alloc(gfp, 0);
+	if (!ptdesc)
+		return NULL;
+	return (pud_t *)ptdesc_address(ptdesc);
 }
 
 #ifndef __HAVE_ARCH_PUD_ALLOC_ONE
@@ -175,7 +187,7 @@ static inline pud_t *pud_alloc_one(struct mm_struct *mm, unsigned long addr)
 static inline void __pud_free(struct mm_struct *mm, pud_t *pud)
 {
 	BUG_ON((unsigned long)pud & (PAGE_SIZE-1));
-	free_page((unsigned long)pud);
+	pagetable_free(virt_to_ptdesc(pud));
 }
 
 #ifndef __HAVE_ARCH_PUD_FREE
@@ -190,7 +202,7 @@ static inline void pud_free(struct mm_struct *mm, pud_t *pud)
 #ifndef __HAVE_ARCH_PGD_FREE
 static inline void pgd_free(struct mm_struct *mm, pgd_t *pgd)
 {
-	free_page((unsigned long)pgd);
+	pagetable_free(virt_to_ptdesc(pgd));
 }
 #endif
 
-- 
2.40.1


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
