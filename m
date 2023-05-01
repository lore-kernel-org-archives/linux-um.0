Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56979C7EE24
	for <linux-um@archiver.kernel.org>; Mon,  1 May 2023 20:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=uFrWPjh79q1hwWJly7YJStmLqXCKk392s+cvwQDJ11g=; b=oWmBExktrlRu+d
	ccOcXAEext6N00sIcQZwga75bMztpIKj9eavWZPE4n/LhYTfubVu2rSFQV3N3nRrcnm0drgtB2KKR
	oBQetNABryweiEQmr60hVyW44aU7eBPE8JgiQopkmIa/sAVe0OarumO+uhDZ60le64bocIg4MUkIX
	md8vJMkYgnea7T1nsgCzYMBJDY8GLzEi09J6l8jcrmZp9sUz3g2gMUXOc7HCROu3qcKjY+tS/KKxj
	NqYGF2l/mTgD+HUTknP/1+QsCV/k0lIdnD9KdeAMWU1OHzE0IIzUp5bdFYvwj+Z1PQ+WzXoqdarFh
	SuGxoYP55m4aiz+Ds7kQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1ptaAB-00Gs6v-0E;
	Mon, 01 May 2023 20:30:23 +0000
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1ptZCV-00Gh5G-1Q;
	Mon, 01 May 2023 19:28:45 +0000
Received: by mail-pg1-x52f.google.com with SMTP id 41be03b00d2f7-517bdc9e81dso1430070a12.1;
        Mon, 01 May 2023 12:28:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682969321; x=1685561321;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AVVNU1/Z0e3e15xLpxnmg1YI8sj9yavBZMAv1HCyq4s=;
        b=LLYF3e7E/amT0QC9X83jr8STEh2LEyhiKwXOflj4vOGUUQ80STkux/B3tsBPRR+iZs
         Z8PEklKtnrf1ANY0yS+7B3mEyOHWcYHngOK95uUUv6xkoIQMHojULkOYhoKI4Ni0FrP2
         S5NHFGXLQHvwvsG30gws5NVKvTRiKsyEh3YkA8qvjSZ3/KlMdDYEuevU5tP8u4iNYhu8
         1xlMd7KFd1vYjOGrW/3tOSP+nbu4BvTDU3KzWxrFnBRpLAae4H3q3HG2nt2iYhftpMs0
         U6/yXrewj3zrB5xufQ+HtnH4MYxc4pcXaT4tSeTPWcq6jVXUA+PWNym9caGo+Q16VqPL
         FcqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682969321; x=1685561321;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AVVNU1/Z0e3e15xLpxnmg1YI8sj9yavBZMAv1HCyq4s=;
        b=UUeDCJUbXG6TMoCKlRipMJZTUSz6zjOTdw9/KwgNXvtjI6UvVCl83cZHgs+n5m+1E2
         w2rLKC23j7jflvRdcWoAmSuLdsV1GtfkyEhDiSwHEtGkbN0LnehvtjocMG6mBOmNXh9+
         NbVJDaZQMnKm8IGeceaV6XaAlCEwZtCvKdpNnO5VdXLLWFQVG9lZIMa/+YlGJFR3EdOG
         XD/TpMyfsaav4+bokDez1qWWg+3/IbmdpQXF4nVRqAvz1vVlH85syn1zSDd2L2xJlgSH
         9I2ehnE0CUV8CmrwNxB6tcb4M/inZS/iidBdqILxxMcvLfhdOt3QdEX+m0m0QihNIoNh
         iMYA==
X-Gm-Message-State: AC+VfDyL/hbD6IYt6BNKDwimjmnz2LCX9I96YV/sGnZY7t0Muy3O5HN/
	4DfsMgVlz14wcqei9ocpky8=
X-Google-Smtp-Source: ACHHUZ5YKwOgPLgh0+tsSaYrcdi28QhyEeU0Z2KklUkfZ7L+H63PFxAPQAkXwR8Vmhp1bd6sZvpxeg==
X-Received: by 2002:a17:902:f814:b0:1a0:50bd:31a8 with SMTP id ix20-20020a170902f81400b001a050bd31a8mr14734719plb.26.1682969321461;
        Mon, 01 May 2023 12:28:41 -0700 (PDT)
Received: from fedora.hsd1.ca.comcast.net ([2601:644:937f:7f20::9a2c])
        by smtp.googlemail.com with ESMTPSA id u8-20020a170902bf4800b0019c13d032d8sm18175622pls.253.2023.05.01.12.28.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 May 2023 12:28:41 -0700 (PDT)
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
Subject: [PATCH v2 05/34] mm: add utility functions for ptdesc
Date: Mon,  1 May 2023 12:28:00 -0700
Message-Id: <20230501192829.17086-6-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230501192829.17086-1-vishal.moola@gmail.com>
References: <20230501192829.17086-1-vishal.moola@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230501_122843_533132_99313CEA 
X-CRM114-Status: GOOD (  13.49  )
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

Introduce utility functions setting the foundation for ptdescs. These
will also assist in the splitting out of ptdesc from struct page.

ptdesc_alloc() is defined to allocate new ptdesc pages as compound
pages. This is to standardize ptdescs by allowing for one allocation
and one free function, in contrast to 2 allocation and 2 free functions.

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
---
 include/asm-generic/tlb.h | 11 ++++++++++
 include/linux/mm.h        | 44 +++++++++++++++++++++++++++++++++++++++
 include/linux/pgtable.h   | 12 +++++++++++
 3 files changed, 67 insertions(+)

diff --git a/include/asm-generic/tlb.h b/include/asm-generic/tlb.h
index b46617207c93..6bade9e0e799 100644
--- a/include/asm-generic/tlb.h
+++ b/include/asm-generic/tlb.h
@@ -481,6 +481,17 @@ static inline void tlb_remove_page(struct mmu_gather *tlb, struct page *page)
 	return tlb_remove_page_size(tlb, page, PAGE_SIZE);
 }
 
+static inline void tlb_remove_ptdesc(struct mmu_gather *tlb, void *pt)
+{
+	tlb_remove_table(tlb, pt);
+}
+
+/* Like tlb_remove_ptdesc, but for page-like page directories. */
+static inline void tlb_remove_page_ptdesc(struct mmu_gather *tlb, struct ptdesc *pt)
+{
+	tlb_remove_page(tlb, ptdesc_page(pt));
+}
+
 static inline void tlb_change_page_size(struct mmu_gather *tlb,
 						     unsigned int page_size)
 {
diff --git a/include/linux/mm.h b/include/linux/mm.h
index b18848ae7e22..258f3b730359 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2744,6 +2744,45 @@ static inline pmd_t *pmd_alloc(struct mm_struct *mm, pud_t *pud, unsigned long a
 }
 #endif /* CONFIG_MMU */
 
+static inline struct ptdesc *virt_to_ptdesc(const void *x)
+{
+	return page_ptdesc(virt_to_head_page(x));
+}
+
+static inline void *ptdesc_to_virt(const struct ptdesc *pt)
+{
+	return page_to_virt(ptdesc_page(pt));
+}
+
+static inline void *ptdesc_address(const struct ptdesc *pt)
+{
+	return folio_address(ptdesc_folio(pt));
+}
+
+static inline bool ptdesc_is_reserved(struct ptdesc *pt)
+{
+	return folio_test_reserved(ptdesc_folio(pt));
+}
+
+static inline struct ptdesc *ptdesc_alloc(gfp_t gfp, unsigned int order)
+{
+	struct page *page = alloc_pages(gfp | __GFP_COMP, order);
+
+	return page_ptdesc(page);
+}
+
+static inline void ptdesc_free(struct ptdesc *pt)
+{
+	struct page *page = ptdesc_page(pt);
+
+	__free_pages(page, compound_order(page));
+}
+
+static inline void ptdesc_clear(void *x)
+{
+	clear_page(x);
+}
+
 #if USE_SPLIT_PTE_PTLOCKS
 #if ALLOC_SPLIT_PTLOCKS
 void __init ptlock_cache_init(void);
@@ -2970,6 +3009,11 @@ static inline void mark_page_reserved(struct page *page)
 	adjust_managed_page_count(page, -1);
 }
 
+static inline void free_reserved_ptdesc(struct ptdesc *pt)
+{
+	free_reserved_page(ptdesc_page(pt));
+}
+
 /*
  * Default method to free all the __init memory into the buddy system.
  * The freed pages will be poisoned with pattern "poison" if it's within
diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index 5e0f51308724..b067ac10f3dd 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -1041,6 +1041,18 @@ TABLE_MATCH(ptl, ptl);
 #undef TABLE_MATCH
 static_assert(sizeof(struct ptdesc) <= sizeof(struct page));
 
+#define ptdesc_page(pt)			(_Generic((pt),			\
+	const struct ptdesc *:		(const struct page *)(pt),	\
+	struct ptdesc *:		(struct page *)(pt)))
+
+#define ptdesc_folio(pt)		(_Generic((pt),			\
+	const struct ptdesc *:		(const struct folio *)(pt),	\
+	struct ptdesc *:		(struct folio *)(pt)))
+
+#define page_ptdesc(p)			(_Generic((p),			\
+	const struct page *:		(const struct ptdesc *)(p),	\
+	struct page *:			(struct ptdesc *)(p)))
+
 /*
  * No-op macros that just return the current protection value. Defined here
  * because these macros can be used even if CONFIG_MMU is not defined.
-- 
2.39.2


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
