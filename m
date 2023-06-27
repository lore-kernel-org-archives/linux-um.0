Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97FCAEB64DD
	for <linux-um@archiver.kernel.org>; Tue, 27 Jun 2023 03:16:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=NLoFmgQvrTo+qP5nn4vwV6/wmM9qqFeRuvyFWNxln8I=; b=ruK6flwipUZbUU
	14g2d/zjHPx0VQp9C9mMDbykm4wErWtJEqklj8N3ikJ/UwAdoxYokuXEgi7mdg4JXNIdxehlGZFvP
	EhPmsPIjVXtBZCybcAjL2nzjf8H6vZH9H+1DIpSF1+6kYHPxw7gaLsVQdTGCBTqJngxrdcgTLts6P
	2Z8A7bdDjKVvMKVYJGcPoCltBP/ct1JmZ32xRxIGro0QbIDm3Ie0nWeMpK2R3yHC7HVybr9qzS9mM
	6SHH4/Oo8UC+bdC+U3z1jZq2uKyiP3ybESc3OhR40Y+VZY8cxBw00JQXirtvVph0m+Ak/Lj2FukKZ
	YrAPFyIiQoZgp/QoO3sg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qDzC8-00BWrS-1m;
	Tue, 27 Jun 2023 03:16:44 +0000
Received: from mail-yw1-x1136.google.com ([2607:f8b0:4864:20::1136])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qDzAt-00BVXc-20;
	Tue, 27 Jun 2023 03:15:29 +0000
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-570002c9b38so42369397b3.1;
        Mon, 26 Jun 2023 20:15:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687835727; x=1690427727;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uRcW1jW+95PozpJhE7MOWGztyyXp9a8KAqI8T3AvQGQ=;
        b=pvA/vO4MDeq4kIIhsE3yrV9+ALefWilKkLuNIgHhecd9VDeKpQ3CrB44RRLXN/wH9a
         v+3v6EJOL2IcXShzxOvXaOjl2qaDyEgyn03s8SsAgafbqCa5mGXGEFvhH716JQIAT0SC
         QEIWs35jWLlJpDE0C433qu5q7ESJ8UkDS3w921ZCRctPmdDsHkPUrtmlpYzw5VwqW3do
         SQRdIAIjkZikdiXvEEkKtp7sFgpQSLF0GRJH1HdPtksJU7st37GWKQiDw1MyawGMKHo0
         s5ztl+d6CGvn0kzD8aZyh2iX1osumXcuHPhisUrTXBEX0Rdvq7Iup64Z2b22TeYu/gRr
         mzYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687835727; x=1690427727;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uRcW1jW+95PozpJhE7MOWGztyyXp9a8KAqI8T3AvQGQ=;
        b=AV7mx3STNZ7UZfHz0u4CtZalH21170oYeLqkCWW7uVsBap2h9v/a/e3gmkZcNJzoqq
         e91ZSTT0xItwi9ka+zz97JapI9SC+oYgsvUqj4ZRhzknNwzUcObyejkH7FVbFit6EGdA
         d9ZZz5wzHqTwfdpa4vHGX2NWbpveDIoZxvKZ4bJjFUVA4eQJd38CnxvlPAB8cNsWCFvu
         zWVjOSrf+0Rg8SfmyuToV+Fhwjz0NLoeULS30uOCcgfgB0sPydx5gScFctrJV8S/kLYN
         icoPv4XnGmGx+OjxAyajkcDgmFzSFlCvKHHT/PorZCgwad/7H96t5+jYzHc4aogJR2mb
         npBg==
X-Gm-Message-State: AC+VfDyYtaKBKPZSippl3+bFJawjt56Cib93tk0ZHobZkYzPQnBHLxVX
	LE9L4YIIDgK6frCCZr+F1Tw=
X-Google-Smtp-Source: ACHHUZ44nBppmQGdd8zdkRU4D5yhqKKKAoy0EjGlUrIReqb1/1yiuyQcU5hRXay6VI94GfMmMF8RKg==
X-Received: by 2002:a81:c203:0:b0:561:da0d:6488 with SMTP id z3-20020a81c203000000b00561da0d6488mr27417977ywc.50.1687835726781;
        Mon, 26 Jun 2023 20:15:26 -0700 (PDT)
Received: from unknowna0e70b2ca394.attlocal.net ([2600:1700:2f7d:1800::16])
        by smtp.googlemail.com with ESMTPSA id s4-20020a0dd004000000b0057399b3bd26sm1614798ywd.33.2023.06.26.20.15.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jun 2023 20:15:26 -0700 (PDT)
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
	"Vishal Moola (Oracle)" <vishal.moola@gmail.com>,
	Mike Rapoport <rppt@kernel.org>
Subject: [PATCH v6 09/33] mm: Convert ptlock_init() to use ptdescs
Date: Mon, 26 Jun 2023 20:14:07 -0700
Message-Id: <20230627031431.29653-10-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230627031431.29653-1-vishal.moola@gmail.com>
References: <20230627031431.29653-1-vishal.moola@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230626_201527_692219_CD9977E2 
X-CRM114-Status: GOOD (  10.34  )
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

This removes some direct accesses to struct page, working towards
splitting out struct ptdesc from struct page.

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>
---
 include/linux/mm.h | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 1c4c6a7b69b3..4af424e4015a 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2830,7 +2830,7 @@ static inline spinlock_t *pte_lockptr(struct mm_struct *mm, pmd_t *pmd)
 	return ptlock_ptr(page_ptdesc(pmd_page(*pmd)));
 }
 
-static inline bool ptlock_init(struct page *page)
+static inline bool ptlock_init(struct ptdesc *ptdesc)
 {
 	/*
 	 * prep_new_page() initialize page->private (and therefore page->ptl)
@@ -2839,10 +2839,10 @@ static inline bool ptlock_init(struct page *page)
 	 * It can happen if arch try to use slab for page table allocation:
 	 * slab code uses page->slab_cache, which share storage with page->ptl.
 	 */
-	VM_BUG_ON_PAGE(*(unsigned long *)&page->ptl, page);
-	if (!ptlock_alloc(page_ptdesc(page)))
+	VM_BUG_ON_PAGE(*(unsigned long *)&ptdesc->ptl, ptdesc_page(ptdesc));
+	if (!ptlock_alloc(ptdesc))
 		return false;
-	spin_lock_init(ptlock_ptr(page_ptdesc(page)));
+	spin_lock_init(ptlock_ptr(ptdesc));
 	return true;
 }
 
@@ -2855,13 +2855,13 @@ static inline spinlock_t *pte_lockptr(struct mm_struct *mm, pmd_t *pmd)
 	return &mm->page_table_lock;
 }
 static inline void ptlock_cache_init(void) {}
-static inline bool ptlock_init(struct page *page) { return true; }
+static inline bool ptlock_init(struct ptdesc *ptdesc) { return true; }
 static inline void ptlock_free(struct page *page) {}
 #endif /* USE_SPLIT_PTE_PTLOCKS */
 
 static inline bool pgtable_pte_page_ctor(struct page *page)
 {
-	if (!ptlock_init(page))
+	if (!ptlock_init(page_ptdesc(page)))
 		return false;
 	__SetPageTable(page);
 	inc_lruvec_page_state(page, NR_PAGETABLE);
@@ -2931,7 +2931,7 @@ static inline bool pmd_ptlock_init(struct ptdesc *ptdesc)
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 	ptdesc->pmd_huge_pte = NULL;
 #endif
-	return ptlock_init(ptdesc_page(ptdesc));
+	return ptlock_init(ptdesc);
 }
 
 static inline void pmd_ptlock_free(struct page *page)
-- 
2.40.1


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
