Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1B90C04A94
	for <linux-um@archiver.kernel.org>; Mon, 31 Jul 2023 17:04:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=7SjK7YVGLf8iem5aZwiMfhbDYqcDyQT7z/lbd4/4kSs=; b=zm55xoEDLbNYX0
	HodbtvD3uOI/cNoA8GL2t6ONMTvSxAM05fZlh233U9RvKgIDFOqgdDV656dE7NGR+/+VZ9E7sQffK
	t+1YFe9o5CuczeUJUB1EHoItUwK5h9FX1AaPRyBCmtP5Kw1HqV+GUWrLvrHq1T/EEtQemZ/K3MCTh
	Rqcffu809tkwLH6+pzs1NJPTeELgAHjyoSUncj36VC3bDAtXpaOUEKpgJvSTwBJO2zZkzHo4FCwrS
	idHCzG7m3TV/T/nU8IUxkpjJQy4uHSWptSKu6ZoGPBxNexQ/kqEIigG7AB2Mt3zZx9MzTPrG5e9B1
	KR/RenLmTh1VHxjgwq6g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qQWJg-00GkVN-1D;
	Mon, 31 Jul 2023 17:04:20 +0000
Received: from mail-oi1-x233.google.com ([2607:f8b0:4864:20::233])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qQWJ9-00Gjxg-2f;
	Mon, 31 Jul 2023 17:03:49 +0000
Received: by mail-oi1-x233.google.com with SMTP id 5614622812f47-3a412653352so3268560b6e.0;
        Mon, 31 Jul 2023 10:03:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690823024; x=1691427824;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VFdcrIV5fIYEpRddOkWey4lp7uyipkLol3FVSysO4BI=;
        b=qbkWgPPid91ZIqftmFBBmjJpzv1I3nAFAPBn0iBZaDKWe1uvfhJ+1U6gJ1dsLe9k8G
         l7DrOCf7gRM2soqiMO44q+s7bgylkU1tiwFZ3vQhRvXR3+IrbpHWwADlXg073Kn29aGv
         6jR4zaER3rVUUYb82D2jgMMbIjrJfkA8xcbPoOTkfTIUXCyNCW6341Yv7mTjWmt8YXjX
         DVSekNPLiQ7ZuAQU0alRNEN5s2nYABPtXl7psWq2PhJX4A2iw0iBhsPbgh2IFaJwQPd6
         Ps6PTryX22bfzx7R3yw/niv4PjS3JpDK+9o8KFnsL0mYZ8+z5MK8XDbxFsJbw1tC6wxV
         bU+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690823024; x=1691427824;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VFdcrIV5fIYEpRddOkWey4lp7uyipkLol3FVSysO4BI=;
        b=UWljE+wJG03Rvd4no7oxJrivqsPOjsWHzTlqrCp1IUZVVnqMceFYhSyBtMy3CG47dI
         Fl1GmrbdVwXUFskKhra9G1rOx8RRbImZBS6SGNhn1r7YZkOElMOyi4SlZSd4ZKSe95AW
         21MxRgZCRcvYS7XxDBTEIeEYSPss5KHqoWGMPmyxa3IcL0QdRvIBlLQquL0lFYbFwn34
         sR41/5cAI6NVS52AWtglEB7JGvbaRtDV4p9q2cvAvn2l+2Ig4MXG9gZZLyNNAbbuR9QD
         GoGP9ckSblWtTUb/8DmOEzSFB5srXZdyaiCI1ttwGsMNGNGf8HkEmQRRa1NEemiAmLwj
         tL7Q==
X-Gm-Message-State: ABy/qLafE8YsU0GRJ2afNiz6t1XiM2Qe3w/qc0nQ6VF4ZOjgr8GBynLS
	uNsRGjughRgb7mVKxWxgE4w=
X-Google-Smtp-Source: APBJJlEPdsci4ZilX3NjM/t6a027bxaAHpHiS1b7Xz7FAoJRqjVPugqaYGEb4Qj9r/gbUH4WVN8xpQ==
X-Received: by 2002:a54:4d8b:0:b0:3a6:f876:148d with SMTP id y11-20020a544d8b000000b003a6f876148dmr9790509oix.8.1690823023801;
        Mon, 31 Jul 2023 10:03:43 -0700 (PDT)
Received: from unknowna0e70b2ca394.attlocal.net ([2600:1700:2f7d:1800::16])
        by smtp.googlemail.com with ESMTPSA id x31-20020a25ac9f000000b00c832ad2e2eesm2511833ybi.60.2023.07.31.10.03.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jul 2023 10:03:43 -0700 (PDT)
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
Subject: [PATCH mm-unstable v8 03/31] mm: add utility functions for ptdesc
Date: Mon, 31 Jul 2023 10:03:04 -0700
Message-Id: <20230731170332.69404-4-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230731170332.69404-1-vishal.moola@gmail.com>
References: <20230731170332.69404-1-vishal.moola@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230731_100347_867632_FC5D3052 
X-CRM114-Status: GOOD (  16.72  )
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
 include/asm-generic/tlb.h | 11 +++++++
 include/linux/mm.h        | 61 +++++++++++++++++++++++++++++++++++++++
 include/linux/pgtable.h   | 12 ++++++++
 3 files changed, 84 insertions(+)

diff --git a/include/asm-generic/tlb.h b/include/asm-generic/tlb.h
index bc32a2284c56..129a3a759976 100644
--- a/include/asm-generic/tlb.h
+++ b/include/asm-generic/tlb.h
@@ -480,6 +480,17 @@ static inline void tlb_remove_page(struct mmu_gather *tlb, struct page *page)
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
index 2ba73f09ae4a..3fda0ad41cf2 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2787,6 +2787,57 @@ static inline pmd_t *pmd_alloc(struct mm_struct *mm, pud_t *pud, unsigned long a
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
@@ -2913,6 +2964,11 @@ static inline struct page *pmd_pgtable_page(pmd_t *pmd)
 	return virt_to_page((void *)((unsigned long) pmd & mask));
 }
 
+static inline struct ptdesc *pmd_ptdesc(pmd_t *pmd)
+{
+	return page_ptdesc(pmd_pgtable_page(pmd));
+}
+
 static inline spinlock_t *pmd_lockptr(struct mm_struct *mm, pmd_t *pmd)
 {
 	return ptlock_ptr(pmd_pgtable_page(pmd));
@@ -3025,6 +3081,11 @@ static inline void mark_page_reserved(struct page *page)
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
index 1f92514d54b0..250fdeba68f3 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -1064,6 +1064,18 @@ TABLE_MATCH(memcg_data, pt_memcg_data);
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
