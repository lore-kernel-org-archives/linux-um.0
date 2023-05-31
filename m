Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4951CC7EE23
	for <linux-um@archiver.kernel.org>; Wed, 31 May 2023 22:43:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=oy1ctSTh5XTJzullC+SW7zPJlbnrPTZoRBRxfCeKK2A=; b=rD8ZPnnjgW2zA9
	Ujes7Jw/OgtIhbclXAjkl4xoYEk/9wvcviWsLZEW/Pj0uDNEx7FT6A3SrCq1ffZn/FmnEOdh5J52J
	+3c71Q7NXqo+Byo/MWjYeF7mkKFbUZZiBSFtbOJaoiH4yk1FRHP4Syv7or2iYM4hOcl9PfkTNhCcS
	TJruyRZvIyi4TzuJknKMlmBa4qyiymBFcebJChMqze+dysC4pZfDep9cxCxXmt0HAVZj4E/703VrK
	wtSNZAGGvuxSkov3bVSPJTfaNzRVxStFLNaOTBYO1hdmibkqXWBocNwHoQgw7512tViXCEyw4tSPd
	OIS2tSAZGd3OGIexU62Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q4UWx-001MD8-2p;
	Wed, 31 May 2023 22:42:59 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q4UWb-001Lxg-2t;
	Wed, 31 May 2023 22:42:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=ODlFnqFbwCYj1Eu7Q59WYAsHTUoZZ7gjL38Gt/grehE=; b=DVQRiS7g1UxLhR/iHInV8biork
	0ZJZyOVGwmzXdyPlzGlQJE2jBUaJuz2W6Ezg8aj2a9cyGR14LDQLo1XKc4zy1jAdDGaYGia0OTxx4
	ptkhKKT/5HRlL2kDEXymUMAIyCax2WtfphdJ6rdSNknhQckXb9RgXl74kiS8U0LvTxYZ0KB8QCSye
	JhhRsuaVYEyyyZmTOnQTrV+Dod5kl14oHmDxMm1J37QxmVyDb2oIzHHZjJlGoNpO6wUxMkjdfoYsX
	qB+gAeTpXnbw1axAeyB99odSi2/5MdfWKuMYMPeH+3VbCyTa4Ji+KrGqWf8uKwdfJT2Lx8BWUzCAb
	0rjBZZoQ==;
Received: from mail-yw1-x112f.google.com ([2607:f8b0:4864:20::112f])
	by desiato.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q4TPm-00FdKD-1Q;
	Wed, 31 May 2023 21:31:43 +0000
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-568a1011488so969507b3.0;
        Wed, 31 May 2023 14:31:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685568679; x=1688160679;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ODlFnqFbwCYj1Eu7Q59WYAsHTUoZZ7gjL38Gt/grehE=;
        b=NGZceTIR2lqEzgrDeWjSiexk6w9g3s1TlD144+ZFhyEk2n6+p9UC+6qVvvVLXzp2su
         K9oJ0eJw0ezplOB9R0ifZq19iQ285sb1OM4mJ1UElkWFp36T3wq89+HQwlMRGwOKmFO7
         z1tP0exNbwqfKUldCdliSyHLB7+WYxs5iLiptM0KEACbqVBdid/Ntr98KvLnXyv2Phff
         Kkrj2cY5I52akM7rhkuqjxOeMf+L5Rld4rmHhMpoy2yk5X8KAowKfrZQsw0r7hKhSbaY
         cfZsGjnDLb5nI+L/8w5H9J8F2OZUMVJi9RmJunsGnB8M2co0leG7lQkvBoLTt5HxAMxc
         OBEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685568679; x=1688160679;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ODlFnqFbwCYj1Eu7Q59WYAsHTUoZZ7gjL38Gt/grehE=;
        b=Uz9gQhg12jxm8ee9kCByNKxzDk/QCDyRpQe/LrZy1LYx4U876BEv1ncFyXaYFp91Vp
         n9IQlCIS9RYpR6nFvXhQuBhudK/62nLUORABd5b1MCizxpBKCtn37hANxFgWIXHelUWz
         CY5tZR6NnXcJPaWDBwDvFvecuBuJ0OKRsd2080wfsBsdAl2UyjNTnBKV/a7TiWiVSaaO
         HvzGMYED6w3APXTps3PDhOQ4xE3M8HE1iW4UZF8rmf8P54oV1hTdox3t6aR7yhvzduh1
         bow0Qy7jwDOZSurbsPZCBr2js8pY8zGt1mxYNsLBsOXBswQTjxeP+QnRvrlFI82gUu1K
         c8qA==
X-Gm-Message-State: AC+VfDzqfcM5SELLLlIe+9agEk0F0MjBeY5qeQ1/ogAagv3s7obitHtA
	acbQWYCc6eRZfRjhiqm0Sn3KijdU3C1jlA==
X-Google-Smtp-Source: ACHHUZ65n2/E4xpD/Goiwc5ceCegWo1qrr/SWnaz3wgfEMIe1tJLwwNDUTgx+izUNHv+/w4oBsm9SQ==
X-Received: by 2002:a81:a0c1:0:b0:568:b10a:e430 with SMTP id x184-20020a81a0c1000000b00568b10ae430mr7264559ywg.25.1685568679304;
        Wed, 31 May 2023 14:31:19 -0700 (PDT)
Received: from unknowna0e70b2ca394.attlocal.net ([2600:1700:2f7d:1800::46])
        by smtp.googlemail.com with ESMTPSA id t63-20020a0dd142000000b0055aafcef659sm658905ywd.5.2023.05.31.14.31.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 May 2023 14:31:18 -0700 (PDT)
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
Subject: [PATCH v3 05/34] mm: add utility functions for ptdesc
Date: Wed, 31 May 2023 14:30:03 -0700
Message-Id: <20230531213032.25338-6-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230531213032.25338-1-vishal.moola@gmail.com>
References: <20230531213032.25338-1-vishal.moola@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230531_223133_259562_0DA6805A 
X-CRM114-Status: GOOD (  15.35  )
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
index 42ff3e04c006..620537e2f94f 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2747,6 +2747,62 @@ static inline pmd_t *pmd_alloc(struct mm_struct *mm, pud_t *pud, unsigned long a
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
+ * pagetable_alloc allocates a page table descriptor as well as all pages
+ * described by it.
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
+ * pagetable_free frees a page table descriptor as well as all page
+ * tables described by said ptdesc.
+ */
+static inline void pagetable_free(struct ptdesc *pt)
+{
+	struct page *page = ptdesc_page(pt);
+
+	__free_pages(page, compound_order(page));
+}
+
+static inline void pagetable_clear(void *x)
+{
+	clear_page(x);
+}
+
 #if USE_SPLIT_PTE_PTLOCKS
 #if ALLOC_SPLIT_PTLOCKS
 void __init ptlock_cache_init(void);
@@ -2973,6 +3029,11 @@ static inline void mark_page_reserved(struct page *page)
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
index c997e9878969..5f12622d1521 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -1027,6 +1027,18 @@ TABLE_MATCH(ptl, ptl);
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
