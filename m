Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 558DBC77B76
	for <linux-um@archiver.kernel.org>; Mon, 17 Apr 2023 21:53:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ADv3IGSoanaIARcwy2ZoS4fwDbDosrTwU5X8vVrtaxQ=; b=sd1vqLKEBi/QUo
	HcIxhL5V1QDM8rEb5c1/Obs0YurNR20IvYe2QD2ODVFio7KfDrJI03B3yIaAdzfQxZLw0vIFJae2G
	YsLvtDeziwDOH8+E/iAMBWKMANGm3jEINGxVt8aTQ1Bln42L3F6WxMFdZMQaWcvSFbaTbJPGzJYZs
	YxZeZqeQRDFkXA0DhsOAlYnhDXMz22aESEK1QwGsqCv9gLzVIwsSLP1maIvNNo0yqRE1od0aFqeBC
	a5j/SGENBkcjEm8uxXEp07UmGidUm7NRi/d5AfiwNxSHucFRC89ftce8tHTv99KLiLkVdV4cmbz4w
	scT7o8gd9jI2YNeXhDhg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1poWmU-0009OZ-2d;
	Mon, 17 Apr 2023 21:53:02 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1poWmR-0009NG-29;
	Mon, 17 Apr 2023 21:52:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=73w88W+Bv7iZwJaXp6X3OPD7H4X7IV5/5eDbDnIxbNE=; b=NafHMJb2CrTNNpw4awMSwKQOz4
	4xIJidWhnDmjN8Z6IECsQd3DJC00e88L1hSG2bMcvil1ITP3czw+tJVlia+WH+tVELq5JuF1Pjbeu
	0eDo9i8XZMM0GXfVgi3rqQfLMoRGdRkldgOaSrjNtFBlAh+//am9U36kuzXKToTNC3AqKV5njQ8YY
	Gd4fJnzBRy6I/kxpPFaDDABdBjIOX5iB0BRv97/dlMdp3nuw/Mm6Wh9ZFlBxQFZxrDfbIjBcqFvmz
	61UKtDBzjBw4fzspVF/xbMjpwfViPd20oincls9zdoxzQLWEcuFUHUry2lsdSWUl2l5Ym1BeadUrd
	GIShjV9A==;
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
	by desiato.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1poVqN-00HS3o-09;
	Mon, 17 Apr 2023 20:53:10 +0000
Received: by mail-pj1-x102d.google.com with SMTP id v21-20020a17090a459500b0024776162815so6439070pjg.2;
        Mon, 17 Apr 2023 13:52:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681764771; x=1684356771;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=73w88W+Bv7iZwJaXp6X3OPD7H4X7IV5/5eDbDnIxbNE=;
        b=W9nPVyoXWKBUEnGfTyhkHARBTsZqdpJrkrNTKo667lyZEzjN6PxmFbbY0YylZMq9yl
         YfrdFmghyeO5HwXhYCrYBTje7eKqSW91jSFSDlT0dbMWvyCEN9ttpAXe7AFMT1oxAH0K
         BCnetbVzBpycS1Tax/m+o/Gfxhef/Kkj1D6sF8rcDiRlOa7VvGL8i+xK5Gl2/zoIf4yK
         M/9RMi7Hd+G3wH7cuJrpgQnusczVewZS29/AobewpqmBg09r8g/9YIIka/gTIbj6DHBc
         MFg7CjS5kCFyT6XG4/q3MJQ78bnC2QIXJhA82Tu9j9zbgdzbLpx3IE+L7G092ISLAdCE
         r0mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681764771; x=1684356771;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=73w88W+Bv7iZwJaXp6X3OPD7H4X7IV5/5eDbDnIxbNE=;
        b=IeVbgAoBa+TjkCc7frzvxiypfZJOt0R1MQmvdm8YJvfV3fKhMqcH/As4vfFuSZOVhL
         V9F4+80EsCh7wq6hOZyt+WC4/8mRJSPYTO5iGOFREL8cDNRTdps8b46O+ktlPy+72gzQ
         DO5UEkkcc/3x+4PND0mP97kW79ittnWKGNVD5Hhtmdoqc8ANW08o9pjSEXKaMlWJT5Rp
         QdVSTdMm4cz8evLHiAX5ACHZZHPkQHCi1TiiJzaJmSw3BFuFq7/7zIsGbGIqvPuMKhWc
         VBnXePAM5lR6QBGK4rhAynIKdS2hSN9QTtXk8iFNZ/5Y6cg5YW+SY5+0/IjQFXikgEpj
         F8/w==
X-Gm-Message-State: AAQBX9cGAPjZI3Cqn6GNGsnkmuydDdZMo2XJzNskIwD0KOknoSuGIo0P
	s3I9bCAk0PUpbyftmboUaJngMGBfLPJviQ==
X-Google-Smtp-Source: AKy350ZgO/j6WOIysdkqHxj8eua8dcgo+KDK2FD0csNlrjJfCGtmgVmsUk4Xos3l7Ag2y16revzrHg==
X-Received: by 2002:a17:902:8bc6:b0:1a2:8924:224a with SMTP id r6-20020a1709028bc600b001a28924224amr205356plo.25.1681764770838;
        Mon, 17 Apr 2023 13:52:50 -0700 (PDT)
Received: from fedora.hsd1.ca.comcast.net ([2601:644:937f:7f20::c139])
        by smtp.googlemail.com with ESMTPSA id h7-20020a17090ac38700b0022335f1dae2sm7609707pjt.22.2023.04.17.13.52.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Apr 2023 13:52:50 -0700 (PDT)
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
Subject: [PATCH 04/33] mm: add utility functions for ptdesc
Date: Mon, 17 Apr 2023 13:50:19 -0700
Message-Id: <20230417205048.15870-5-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230417205048.15870-1-vishal.moola@gmail.com>
References: <20230417205048.15870-1-vishal.moola@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230417_215300_870846_4D608A08 
X-CRM114-Status: GOOD (  12.44  )
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
 include/linux/pgtable.h   | 13 ++++++++++++
 3 files changed, 68 insertions(+)

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
index b18848ae7e22..ec3cbe2fa665 100644
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
+static inline void *ptdesc_to_virt(struct ptdesc *pt)
+{
+	return page_to_virt(ptdesc_page(pt));
+}
+
+static inline void *ptdesc_address(struct ptdesc *pt)
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
index 7cc6ea057ee9..7cd803aa38eb 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -97,6 +97,19 @@ TABLE_MATCH(ptl, ptl);
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
+static inline struct ptdesc *page_ptdesc(struct page *page)
+{
+	return (struct ptdesc *)page;
+}
+
 /*
  * A page table page can be thought of an array like this: pXd_t[PTRS_PER_PxD]
  *
-- 
2.39.2


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
