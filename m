Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE698C88CB5
	for <linux-um@archiver.kernel.org>; Mon, 12 Jun 2023 21:05:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=4Stegk15viMNrX5tI+ULhgEkkthKePwbY0F17jOu+W4=; b=1ET1v4smtu1orB
	6msKCKwngmH582oMlbYalwLtLTs30xGFhGXg5bHq4BR0IS5/jUio7VKB0u5c1OlVewGBnMlXVM2dv
	pl7XtMPRhx8zaj/b4xXyxlTqEP3hn/WSz9kc0gPrUc9qNo0RVVuoN9YWp7ydFMZCHw3DxOnY2SHBO
	ic8rSPq2AGbWCyKTPM8aamNstiwXy0PD+mSOMfmRTG+F224Rpizdiz4A7sn0R70JDns6MVR/echUE
	5tfiTVnORYP9hAug1uBkeGL2ZwKo/yozdRYn7QAHwMQB85bKKHbhohPBM//c/46sS+2KQgRJt578S
	lhmWH5Z1nFUlKmAKp8WQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q8ojM-005NlW-2w;
	Mon, 12 Jun 2023 21:05:40 +0000
Received: from mail-yw1-x1130.google.com ([2607:f8b0:4864:20::1130])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q8oil-005N6I-2a;
	Mon, 12 Jun 2023 21:05:07 +0000
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-56cf916aaa2so27688047b3.3;
        Mon, 12 Jun 2023 14:05:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686603902; x=1689195902;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7hP9xC8dm7FmaxDqq4kyW1FngYvGoyLv+4GJfd5pZsk=;
        b=CJYIsJwgfTu/y/lqnJP/t9il82a33oAqvZUzCAqj1B6hDybKBkJzlI1M4tHng7gsKh
         wjldrdty5LsQxwcte5A4qzxTSyPWsC3prP09MuDZHhuDdW+KkIuzhNtB1OGIf0fmEYwq
         PbjgzzODbpwoqx2q55Rq1VMyrgJdF+EsVRaRlosxhaI2WYgY5mJZUdNXguDU4uoU3hsT
         HNsA8NDHAaVm+vxqugHLiha5If8egzZBwoJM3N2OKUEJMszToVmHBrGqCteUXmcF8+W9
         CJfXWgYf4SrrnrL4x4+oaqBHqtUA2nnqH+olViH9ENIys3R1pjxamFF3W5tG5eZyHhYN
         +FGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686603902; x=1689195902;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7hP9xC8dm7FmaxDqq4kyW1FngYvGoyLv+4GJfd5pZsk=;
        b=P6W5bihBUgbUUYkU8mDje/1logNYz9TGapBl1B3JdAAVWiEnKEoyY4Qx40v7OVy9RM
         RlW6Hzob/cWkVfuAxMepu5hFeWd/5FayQ6iIJX9e5IFav4FfAkmg1YsE6nG2b0DchBU0
         MKc328Ds0iDYZDvQ34DRuS/G9mRr60LTMRuoIppD13T3GYp5bhNMLjNcFUEqJXfmCvCl
         iixaf+hVS3CEIyPkfLW0z3uaMlV0RB5s8/3TnFEAdP/8GEP4pz2ERcgYn15/+yJJ3kgz
         Me/baXufqCQVWqtva3DnTMChvdsKD1c6HEHDCTbp4O55pLyhjc2leYB5ui1NDmkKEJ5I
         e+Uw==
X-Gm-Message-State: AC+VfDxVh6YXqs/hjaMHS6x1LrKogENh4BUx1AqONEBQl5+mGVdEDSZM
	cZan3N2fPwiViPNjBpw/5KA=
X-Google-Smtp-Source: ACHHUZ5ktkx/ASoBV55sneLmyoKAwlH0/qlI6IE3eWY9yaMnSemMH48l10CKm48pG/hNrIF3qCc62g==
X-Received: by 2002:a0d:d713:0:b0:56d:5286:51f5 with SMTP id z19-20020a0dd713000000b0056d528651f5mr1015907ywd.28.1686603902249;
        Mon, 12 Jun 2023 14:05:02 -0700 (PDT)
Received: from unknowna0e70b2ca394.attlocal.net ([2600:1700:2f7d:1800::16])
        by smtp.googlemail.com with ESMTPSA id s125-20020a817783000000b00569eb609458sm2757115ywc.81.2023.06.12.14.05.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 14:05:01 -0700 (PDT)
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
Subject: [PATCH v4 08/34] mm: Convert ptlock_ptr() to use ptdescs
Date: Mon, 12 Jun 2023 14:03:57 -0700
Message-Id: <20230612210423.18611-9-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230612210423.18611-1-vishal.moola@gmail.com>
References: <20230612210423.18611-1-vishal.moola@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230612_140503_879906_E3526516 
X-CRM114-Status: GOOD (  11.58  )
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
---
 arch/x86/xen/mmu_pv.c |  2 +-
 include/linux/mm.h    | 14 +++++++-------
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/x86/xen/mmu_pv.c b/arch/x86/xen/mmu_pv.c
index b3b8d289b9ab..f469862e3ef4 100644
--- a/arch/x86/xen/mmu_pv.c
+++ b/arch/x86/xen/mmu_pv.c
@@ -651,7 +651,7 @@ static spinlock_t *xen_pte_lock(struct page *page, struct mm_struct *mm)
 	spinlock_t *ptl = NULL;
 
 #if USE_SPLIT_PTE_PTLOCKS
-	ptl = ptlock_ptr(page);
+	ptl = ptlock_ptr(page_ptdesc(page));
 	spin_lock_nest_lock(ptl, &mm->page_table_lock);
 #endif
 
diff --git a/include/linux/mm.h b/include/linux/mm.h
index e6f1be2a405e..bb934d51390f 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2828,9 +2828,9 @@ void __init ptlock_cache_init(void);
 bool ptlock_alloc(struct ptdesc *ptdesc);
 extern void ptlock_free(struct page *page);
 
-static inline spinlock_t *ptlock_ptr(struct page *page)
+static inline spinlock_t *ptlock_ptr(struct ptdesc *ptdesc)
 {
-	return page->ptl;
+	return ptdesc->ptl;
 }
 #else /* ALLOC_SPLIT_PTLOCKS */
 static inline void ptlock_cache_init(void)
@@ -2846,15 +2846,15 @@ static inline void ptlock_free(struct page *page)
 {
 }
 
-static inline spinlock_t *ptlock_ptr(struct page *page)
+static inline spinlock_t *ptlock_ptr(struct ptdesc *ptdesc)
 {
-	return &page->ptl;
+	return &ptdesc->ptl;
 }
 #endif /* ALLOC_SPLIT_PTLOCKS */
 
 static inline spinlock_t *pte_lockptr(struct mm_struct *mm, pmd_t *pmd)
 {
-	return ptlock_ptr(pmd_page(*pmd));
+	return ptlock_ptr(page_ptdesc(pmd_page(*pmd)));
 }
 
 static inline bool ptlock_init(struct page *page)
@@ -2869,7 +2869,7 @@ static inline bool ptlock_init(struct page *page)
 	VM_BUG_ON_PAGE(*(unsigned long *)&page->ptl, page);
 	if (!ptlock_alloc(page_ptdesc(page)))
 		return false;
-	spin_lock_init(ptlock_ptr(page));
+	spin_lock_init(ptlock_ptr(page_ptdesc(page)));
 	return true;
 }
 
@@ -2939,7 +2939,7 @@ static inline struct ptdesc *pmd_ptdesc(pmd_t *pmd)
 
 static inline spinlock_t *pmd_lockptr(struct mm_struct *mm, pmd_t *pmd)
 {
-	return ptlock_ptr(ptdesc_page(pmd_ptdesc(pmd)));
+	return ptlock_ptr(pmd_ptdesc(pmd));
 }
 
 static inline bool pmd_ptlock_init(struct page *page)
-- 
2.40.1


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
