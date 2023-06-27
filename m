Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A05A5C25B7B
	for <linux-um@archiver.kernel.org>; Tue, 27 Jun 2023 03:15:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=80Ji/au80jGBDJyYKbTqHCX1eZyJcSXmKt5Y93M3rXI=; b=pccRHJ9yBXMZlp
	0Y7z6v2Gg212oLKBdJHoQgQsgALxjpCKvM3OalWa8Pf+8uCmbJGNzUDIilO0A+t0v+qsOucV4cjq1
	jn/YHyWqqn9TUBYM95PQDmfvUPWojG9bpc++RZxcSXCddYNzpv6vlebnY3O8hx3sIsT9h0vOc25EH
	eJVip38eJWr6cpcgYea049Lru+v+R1IhvFI1rI3ewCplt7peY6B/vRktwLq0fN+cSS4HfdMRySkHF
	MK7ybAK3u382kT2S7nUUB4uUiUdsgZCIJegofptRPy9MkKgNeX7xAntf02cH54JLw+dTMXX0B37ry
	l7nX7kcwa5hbZJ307Wsw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qDzBD-00BVs0-0M;
	Tue, 27 Jun 2023 03:15:47 +0000
Received: from mail-yw1-x112e.google.com ([2607:f8b0:4864:20::112e])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qDzAj-00BVOc-29;
	Tue, 27 Jun 2023 03:15:21 +0000
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-5703d12ab9aso42005597b3.2;
        Mon, 26 Jun 2023 20:15:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687835716; x=1690427716;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HtFJ7gYDDt6nFtJ3t4rf4iEtrxS/aE7Nt5tBsex6r9A=;
        b=ezZY2RRaBsO8vupgw2jirYZqUqmGibvIwA82DEMWpf56igWuBXAqitT4X8HFP0H1em
         qInNajfNuzHXRKyCsOjr1ow6YjtmBJmSGwTpqkLixyNIhU7k9Ph16qz2hibDBlk4ocWn
         RdQq60FSFIq8+C1zjLLZN/Rg7C2lIgGdw5ZwRyR727fqaxVVL271FHYTSlcEWFbnTW+n
         ai4y6LrhJ2fQPdUOuCCIjPAYCrwucE/VRobbMg4Tdi7YBB6HSEEQoC+LDsht9wreS+ur
         2ZI4rM/c7NVhKyeNzOFTFN1TecKoEZQs/ZCcRhwVVJL+smX0rtd7NxGtRSoeSJDmpM8H
         CrQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687835716; x=1690427716;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HtFJ7gYDDt6nFtJ3t4rf4iEtrxS/aE7Nt5tBsex6r9A=;
        b=CmbkBt9du2mF3gY/o23Cmn8VXwETHMZ26X9Dtis495jB0yGKCtaVztbDDhlBEJK+P4
         1gJyeoPzCIZBS5VAtKHp1uNRts46X8CvokicKu/z2/PiDJ2WKYqpCqgcaK8UfNtg4BGZ
         RWUls1akyxYRqFviO5pgvprIfEUsmDH7NG81C6tX/rIQmUpZ6vPJSpQYpz+CkfVgrPTz
         f5DmQ1eek2RqlwiXSxYzgNuVeUBSEdAsRqISuLhpol7PIazuKP1ldILG2apKfYZ1xcLl
         GtPq1aRXcF77CUmuPvfmf6tfYExmBi06fdOqJGhNojKKCXwYNUtyyhvKt2Tj3i7ne75U
         v0pw==
X-Gm-Message-State: AC+VfDz4pcq76VoWmSDaG+O5NYMgMwkW12xzxoZa89FmRpne6ZJufnYW
	RuxktC9kvGAv+A57QaZWLUs=
X-Google-Smtp-Source: ACHHUZ4EM4P6arjbVFZ7FT16PBM+ahxIjoFzjt7cHsivb9z4gadBenbNhcBrFTzqfItdDpBTwEdG4w==
X-Received: by 2002:a0d:c786:0:b0:570:8854:8e9e with SMTP id j128-20020a0dc786000000b0057088548e9emr26427874ywd.33.1687835716265;
        Mon, 26 Jun 2023 20:15:16 -0700 (PDT)
Received: from unknowna0e70b2ca394.attlocal.net ([2600:1700:2f7d:1800::16])
        by smtp.googlemail.com with ESMTPSA id s4-20020a0dd004000000b0057399b3bd26sm1614798ywd.33.2023.06.26.20.15.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jun 2023 20:15:15 -0700 (PDT)
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
	Hugh Dickins <hughd@google.com>,
	"Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [PATCH v6 04/33] mm: add utility functions for ptdesc
Date: Mon, 26 Jun 2023 20:14:02 -0700
Message-Id: <20230627031431.29653-5-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230627031431.29653-1-vishal.moola@gmail.com>
References: <20230627031431.29653-1-vishal.moola@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230626_201517_717347_A4CA714A 
X-CRM114-Status: GOOD (  16.04  )
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

Functions that focus on the descriptor are prefixed with ptdesc_* while
functions that focus on the pagetable are prefixed with pagetable_*.

pagetable_alloc() is defined to allocate new ptdesc pages as compound
pages. This is to standardize ptdescs by allowing for one allocation
and one free function, in contrast to 2 allocation and 2 free functions.

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
---
 include/asm-generic/tlb.h | 11 ++++++++
 include/linux/mm.h        | 56 +++++++++++++++++++++++++++++++++++++++
 include/linux/pgtable.h   | 12 +++++++++
 3 files changed, 79 insertions(+)

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
index 0dad5f40ef96..14d95d494958 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2744,6 +2744,57 @@ static inline pmd_t *pmd_alloc(struct mm_struct *mm, pud_t *pud, unsigned long a
 }
 #endif /* CONFIG_MMU */
 
+static inline struct ptdesc *virt_to_ptdesc(const void *x)
+{
+	return page_ptdesc(virt_to_page(x));
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
+static inline bool pagetable_is_reserved(struct ptdesc *pt)
+{
+	return folio_test_reserved(ptdesc_folio(pt));
+}
+
+/**
+ * pagetable_alloc - Allocate pagetables
+ * @gfp:    GFP flags
+ * @order:  desired pagetable order
+ *
+ * pagetable_alloc allocates memory for page tables as well as a page table
+ * descriptor to describe that memory.
+ *
+ * Return: The ptdesc describing the allocated page tables.
+ */
+static inline struct ptdesc *pagetable_alloc(gfp_t gfp, unsigned int order)
+{
+	struct page *page = alloc_pages(gfp | __GFP_COMP, order);
+
+	return page_ptdesc(page);
+}
+
+/**
+ * pagetable_free - Free pagetables
+ * @pt:	The page table descriptor
+ *
+ * pagetable_free frees the memory of all page tables described by a page
+ * table descriptor and the memory for the descriptor itself.
+ */
+static inline void pagetable_free(struct ptdesc *pt)
+{
+	struct page *page = ptdesc_page(pt);
+
+	__free_pages(page, compound_order(page));
+}
+
 #if USE_SPLIT_PTE_PTLOCKS
 #if ALLOC_SPLIT_PTLOCKS
 void __init ptlock_cache_init(void);
@@ -2981,6 +3032,11 @@ static inline void mark_page_reserved(struct page *page)
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
index d46cb709ce08..e9bb5f18cade 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -1055,6 +1055,18 @@ TABLE_MATCH(memcg_data, pt_memcg_data);
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
2.40.1


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
