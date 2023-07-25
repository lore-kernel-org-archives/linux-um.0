Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6AE7EB64DD
	for <linux-um@archiver.kernel.org>; Tue, 25 Jul 2023 04:22:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=CoYPRiFx2i0DgU0jUaVPHH/i1uulJJG5Xait+WHAYmM=; b=ExjKRyjiDOgEu3
	58c5KnKoXgeWtLx2v4Pwccl/tkDl7QDBoveAMcg8k4YiNuOu9o2EHytEvNuhf9M2RY8XyDJdvSs6d
	k6t75W5/F6VPwgWjO/4DPjn6ZbA0Mw6G4GWFSRRZQBeG2Co+bC6xbVjI9IOz88Qp66SskQP0W2l0i
	nXjHkIC0nk8ova/aOHx1M+fKKdz0ZQ+nrxYiabS2qwDvu9Jt1mtSEML4kVAJaIzSQGWVsrDXh4uDA
	oufLPCxIdVO/zoPshu6tjAoOf3vKod8zM43/GM/v7H5wByOaerMMeykhBTno/J0Hfmxz17QGrI+un
	magbtGe9UJchjma2bqjA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qO9ZO-0068TN-2t;
	Tue, 25 Jul 2023 04:22:46 +0000
Received: from mail-yb1-xb36.google.com ([2607:f8b0:4864:20::b36])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qO9Y8-0067EX-08;
	Tue, 25 Jul 2023 04:21:29 +0000
Received: by mail-yb1-xb36.google.com with SMTP id 3f1490d57ef6-d0fc1d97716so2005843276.1;
        Mon, 24 Jul 2023 21:21:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690258887; x=1690863687;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7EZnRhm4Fj3KaK4sFjI+P1mIVDNOtVXSgVauozi7/LE=;
        b=RYLJ+HHhZ3SW3XdvMN1AzT9gPBErVqrhuCtcU9fNt2oY7ALxgSJoFkBn6Vm9nhRIfL
         WiTjjdSQLpNPnjH/5n9WBm6wJTnH8dJRd1NltGEZ286BUnLn7Q2MMvQIs7uIZqTwGdGS
         eL9nBqdaNLlYe8KWVzFFhBRvhsKclpu6/YA+4Q97+gqJ/tvmMP0hkmlN965zL32r5aWq
         lGDtyvV+tLl+Z/pogbSTjxnJu1qRtO3WfiwXTUnVp3YPllt2BfK2Izz7z0ivGxPYpzFU
         UjwvvFWDj18TjEMiWj89EXU3QbdGQMvzZCK7ByPk/vtnFluG2/Q0k/42+A+1E3bms/jl
         vfTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690258887; x=1690863687;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7EZnRhm4Fj3KaK4sFjI+P1mIVDNOtVXSgVauozi7/LE=;
        b=lRjQjo1J4mmJhQ5xWNGo1cizZO9V23Jm9+G3TUjf7oC7Py8gOnX/SzU7GMhtbtjR6H
         iAAPsByrwy59AB23FnmT2cXEBrTVBME+750Przecolz2Jq6O6xtqeAUyFvjtJLntxOoG
         f34ON/I9tWR3JZAPEY28i0ys7e0PGnt7cuULEKb6Zw4bId+mU4igPthHesIxV/ZZCDhQ
         HJVa/R6PSUgFHyu6sFuq7blr0cFGe07Ww5raKFnsOHQvG9xVtdQrdKVBhZG+mXGAjrri
         vM2/pXrNGfEpJ++ttLhC90DHR90FtcvtXet1WiSDUIwNKrYM6fj+Fr4QKSJH9TA5tWwD
         Sd0g==
X-Gm-Message-State: ABy/qLYTeMdoRkWRmZb5gIG2SqHcD97lKw0/ctdTK/Y5+UR/iYNRHjrS
	vvXGC5AUn8/dg8SHyojsH6M=
X-Google-Smtp-Source: APBJJlEDrySQ7FY0Or7EcCMVmcmwbMMbiMSaZShCmPSyL8HtQQZFeTHHFjIo1cF+xzs4edAkc8Gy+Q==
X-Received: by 2002:a5b:782:0:b0:c91:cc0e:1aef with SMTP id b2-20020a5b0782000000b00c91cc0e1aefmr9011877ybq.58.1690258887257;
        Mon, 24 Jul 2023 21:21:27 -0700 (PDT)
Received: from unknowna0e70b2ca394.attlocal.net ([2600:1700:2f7d:1800::16])
        by smtp.googlemail.com with ESMTPSA id h9-20020a25b189000000b00d0db687ef48sm1175540ybj.61.2023.07.24.21.21.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jul 2023 21:21:27 -0700 (PDT)
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
Subject: [PATCH mm-unstable v7 10/31] mm: Convert ptlock_free() to use ptdescs
Date: Mon, 24 Jul 2023 21:20:30 -0700
Message-Id: <20230725042051.36691-11-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230725042051.36691-1-vishal.moola@gmail.com>
References: <20230725042051.36691-1-vishal.moola@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230724_212128_087649_D4C3AC33 
X-CRM114-Status: GOOD (  10.32  )
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
 include/linux/mm.h | 10 +++++-----
 mm/memory.c        |  4 ++--
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 774fe83c0c16..ffddae95af78 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2842,7 +2842,7 @@ static inline void pagetable_free(struct ptdesc *pt)
 #if ALLOC_SPLIT_PTLOCKS
 void __init ptlock_cache_init(void);
 bool ptlock_alloc(struct ptdesc *ptdesc);
-extern void ptlock_free(struct page *page);
+void ptlock_free(struct ptdesc *ptdesc);
 
 static inline spinlock_t *ptlock_ptr(struct ptdesc *ptdesc)
 {
@@ -2858,7 +2858,7 @@ static inline bool ptlock_alloc(struct ptdesc *ptdesc)
 	return true;
 }
 
-static inline void ptlock_free(struct page *page)
+static inline void ptlock_free(struct ptdesc *ptdesc)
 {
 }
 
@@ -2899,7 +2899,7 @@ static inline spinlock_t *pte_lockptr(struct mm_struct *mm, pmd_t *pmd)
 }
 static inline void ptlock_cache_init(void) {}
 static inline bool ptlock_init(struct ptdesc *ptdesc) { return true; }
-static inline void ptlock_free(struct page *page) {}
+static inline void ptlock_free(struct ptdesc *ptdesc) {}
 #endif /* USE_SPLIT_PTE_PTLOCKS */
 
 static inline bool pgtable_pte_page_ctor(struct page *page)
@@ -2913,7 +2913,7 @@ static inline bool pgtable_pte_page_ctor(struct page *page)
 
 static inline void pgtable_pte_page_dtor(struct page *page)
 {
-	ptlock_free(page);
+	ptlock_free(page_ptdesc(page));
 	__ClearPageTable(page);
 	dec_lruvec_page_state(page, NR_PAGETABLE);
 }
@@ -2987,7 +2987,7 @@ static inline void pmd_ptlock_free(struct ptdesc *ptdesc)
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 	VM_BUG_ON_PAGE(ptdesc->pmd_huge_pte, ptdesc_page(ptdesc));
 #endif
-	ptlock_free(ptdesc_page(ptdesc));
+	ptlock_free(ptdesc);
 }
 
 #define pmd_huge_pte(mm, pmd) (pmd_ptdesc(pmd)->pmd_huge_pte)
diff --git a/mm/memory.c b/mm/memory.c
index 4fee273595e2..e5e370cdac23 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -6242,8 +6242,8 @@ bool ptlock_alloc(struct ptdesc *ptdesc)
 	return true;
 }
 
-void ptlock_free(struct page *page)
+void ptlock_free(struct ptdesc *ptdesc)
 {
-	kmem_cache_free(page_ptl_cachep, page->ptl);
+	kmem_cache_free(page_ptl_cachep, ptdesc->ptl);
 }
 #endif
-- 
2.40.1


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
