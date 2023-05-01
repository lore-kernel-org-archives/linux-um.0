Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B3ABC77B7C
	for <linux-um@archiver.kernel.org>; Mon,  1 May 2023 20:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=S+nAxmy8qoQZGWPS/krdXMT+jD0mvqlRI+16lWqr3ww=; b=biKjzg9tvVHOjl
	BZO6QpPAGawn2bWnT/E5uhtvd8i91PrJw6xnlTcLDJa4oJ8HEvh7rcU1PEvBaYdpZOaMGvr0QKD+w
	PrMBj+LFXfdrsRxL8kf12ucuu3hIgvqPDlFepRPQZGye4pd0XR3IFy/YJp53/oUnnNx7B6AiJz/hj
	71iwB0rNgeIfQWjbn2bdbIc6HmGiKph4OXY7Sr2nAH/zc5ZQ+SaM9PxTrw2mYKQzkNNVUaj5OruQ2
	nY1kxX/FzzciZ0l3+dcmkofrBO+HJPOYtjsMyOxInhfCZkyxeNzc914B9hqIxNYvwCn6zRFQYS/kq
	BSaxQWwCip7sRE0aASKA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1ptaAJ-00GsBs-0n;
	Mon, 01 May 2023 20:30:31 +0000
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1ptZCn-00GhD8-2p;
	Mon, 01 May 2023 19:29:03 +0000
Received: by mail-pg1-x536.google.com with SMTP id 41be03b00d2f7-517c840f181so1426454a12.3;
        Mon, 01 May 2023 12:29:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682969341; x=1685561341;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dfen1Ya6fa7BCRlN1BPOcmTNp3Sy/DALCm51X/wHZX4=;
        b=NGlfJzK3SLIyrzVeCW+cy/LENuF7AIYcpLjneyCln8/dN8tsSa+TUgx6Zs0xZt09V/
         AUoO/9vVboMIkkiAJKzWw3zNTkXyZHbg5i+Uv3Zqtu+rX4tuOiaEx2sdsDxoZuaBDGgr
         vod9dLgUvGamVrCZ2EGOCdE8ToYnRSXk/vhm78x+dP7MR2nyb1QcOC5STzovq8Qe7Hqo
         h0w/rTHUO6l4DW/cRdBZ54cZqeORpVG+YoPGSUP9GNzfvkM/15zFtG0hwm7rzS97mp6T
         8K3nb/fOTHh3fKdVDbkoQtqh9GEw5zSK4hVf63htcA2MUZQPuMJk5JXlIyYiKdaNTnZr
         +1fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682969341; x=1685561341;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dfen1Ya6fa7BCRlN1BPOcmTNp3Sy/DALCm51X/wHZX4=;
        b=VYMwo1dKHkLCtYJeeJ4nyxOOKHZwApKA6BCMG2SE81AbwlMuB18EWAtB4I63PkIpiJ
         gWqQm+xNDWGrO8DZNMnRkTW5QdXGKSaAx2cvDGAdcbsMhYssZU28L5lhSRJ5czW0XRtj
         1K5J+SCnENi0QYwe2TxnqM7UN6lqQQV7dWqtSMxBSB+JbMrit/CEDO/8xpOkSbWR4wpP
         XCj8VIzFr7vPM2cTv0LMwxvXdii7iaUu/hTvqKZFVdui/ousD/sX/8ABnM+Nm8llwHzG
         Ou1z/SfgpdNI2WlYkNCnU6L3vJEJYXBMteppp6YDK8kFBqJrAxpluL9zVk1rjGW79g0g
         wvEQ==
X-Gm-Message-State: AC+VfDyrIdX8+q49Uw2CUV9QA0JzEScOTGLBaYBsXxvTs/tmYN2iOqHe
	yzGONKvIaJWMP6F/ARwKHnk=
X-Google-Smtp-Source: ACHHUZ4bym3aGkcEwh3pzEy9AQ1AIJMbPocjKSt/BA7y0pQIbB80eZOWxLwavvxYdF9801tFQUA10w==
X-Received: by 2002:a17:903:124b:b0:1a2:8c7e:f315 with SMTP id u11-20020a170903124b00b001a28c7ef315mr17565749plh.21.1682969341343;
        Mon, 01 May 2023 12:29:01 -0700 (PDT)
Received: from fedora.hsd1.ca.comcast.net ([2601:644:937f:7f20::9a2c])
        by smtp.googlemail.com with ESMTPSA id u8-20020a170902bf4800b0019c13d032d8sm18175622pls.253.2023.05.01.12.28.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 May 2023 12:29:00 -0700 (PDT)
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
Subject: [PATCH v2 19/34] pgalloc: Convert various functions to use ptdescs
Date: Mon,  1 May 2023 12:28:14 -0700
Message-Id: <20230501192829.17086-20-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230501192829.17086-1-vishal.moola@gmail.com>
References: <20230501192829.17086-1-vishal.moola@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230501_122901_912905_51AD2E0D 
X-CRM114-Status: GOOD (  16.50  )
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
these to use ptdesc_alloc() and ptdesc_address() instead to help
standardize page tables further.

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
---
 include/asm-generic/pgalloc.h | 62 +++++++++++++++++++++--------------
 1 file changed, 37 insertions(+), 25 deletions(-)

diff --git a/include/asm-generic/pgalloc.h b/include/asm-generic/pgalloc.h
index a7cf825befae..7d4a1f5d3c17 100644
--- a/include/asm-generic/pgalloc.h
+++ b/include/asm-generic/pgalloc.h
@@ -18,7 +18,11 @@
  */
 static inline pte_t *__pte_alloc_one_kernel(struct mm_struct *mm)
 {
-	return (pte_t *)__get_free_page(GFP_PGTABLE_KERNEL);
+	struct ptdesc *ptdesc = ptdesc_alloc(GFP_PGTABLE_KERNEL, 0);
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
+	ptdesc_free(virt_to_ptdesc(pte));
 }
 
 /**
@@ -49,7 +53,7 @@ static inline void pte_free_kernel(struct mm_struct *mm, pte_t *pte)
  * @mm: the mm_struct of the current context
  * @gfp: GFP flags to use for the allocation
  *
- * Allocates a page and runs the pgtable_pte_page_ctor().
+ * Allocates a ptdesc and runs the ptdesc_pte_ctor().
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
+	ptdesc = ptdesc_alloc(gfp, 0);
+	if (!ptdesc)
 		return NULL;
-	if (!pgtable_pte_page_ctor(pte)) {
-		__free_page(pte);
+	if (!ptdesc_pte_ctor(ptdesc)) {
+		ptdesc_free(ptdesc);
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
+ * Allocates a ptdesc and runs the ptdesc_pte_ctor().
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
+	ptdesc_pte_dtor(ptdesc);
+	ptdesc_free(ptdesc);
 }
 
 
@@ -110,7 +116,7 @@ static inline void pte_free(struct mm_struct *mm, struct page *pte_page)
  * pmd_alloc_one - allocate a page for PMD-level page table
  * @mm: the mm_struct of the current context
  *
- * Allocates a page and runs the pgtable_pmd_page_ctor().
+ * Allocates a ptdesc and runs the ptdesc_pmd_ctor().
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
+	ptdesc = ptdesc_alloc(gfp, 0);
+	if (!ptdesc)
 		return NULL;
-	if (!pgtable_pmd_page_ctor(page)) {
-		__free_page(page);
+	if (!ptdesc_pmd_ctor(ptdesc)) {
+		ptdesc_free(ptdesc);
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
+	ptdesc_pmd_dtor(ptdesc);
+	ptdesc_free(ptdesc);
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
+	ptdesc = ptdesc_alloc(gfp, 0);
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
+	ptdesc_free(virt_to_ptdesc(pud));
 }
 
 #ifndef __HAVE_ARCH_PUD_FREE
@@ -190,7 +202,7 @@ static inline void pud_free(struct mm_struct *mm, pud_t *pud)
 #ifndef __HAVE_ARCH_PGD_FREE
 static inline void pgd_free(struct mm_struct *mm, pgd_t *pgd)
 {
-	free_page((unsigned long)pgd);
+	ptdesc_free(virt_to_ptdesc(pgd));
 }
 #endif
 
-- 
2.39.2


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
