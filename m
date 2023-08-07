Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F97BC05052
	for <linux-um@archiver.kernel.org>; Mon,  7 Aug 2023 23:06:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=IBtKgADaoxEOLIO/goolqT4KcEy/ZFLPiu/fkBZjbSA=; b=Ft1KhqppABvxh0
	dp2nf6qA2fJXovYuyeUPMOGc6KtCvx4EGC0AiYOwsFGKKVPm7RSuq2wfKkfg/rBeUvvok6TD/7frW
	1QpCZVH5gJoJWPByb/hW2agmlbPhpV4T+8/6Ebg5Kmtkiz2HC3W4rBmVmmKQTI/QuSHC9TuqA/CaI
	0hGoLToGYg6R6aEPr5xqHTR37boQeobXc26Onzd2l4U8DZ0CMrHNpVsodPrhLxv3Ga4ULKNyONc88
	uD4dn79x1k+SIYtXEz5ksYzxz6U7jjP074gkCIh9lpFYM0waUR6TUcLrZZQ3zsMmbyd5sVGPMOzjw
	aHIR/pJPQHtpQzG2x6kQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qT9J4-0015jm-2k;
	Mon, 07 Aug 2023 23:06:34 +0000
Received: from mail-yb1-xb34.google.com ([2607:f8b0:4864:20::b34])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qT9I9-0014Zu-2f;
	Mon, 07 Aug 2023 23:05:40 +0000
Received: by mail-yb1-xb34.google.com with SMTP id 3f1490d57ef6-d5869d9651aso722811276.2;
        Mon, 07 Aug 2023 16:05:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691449534; x=1692054334;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qSt61pcnVgNBhKAHMe8eO3a6G9ChrNL9Px0NKJkznSI=;
        b=doFuHRFvbyMJN61tPnMQYXox+6stb50QdP4/3C93sFPuLhCWwxu1z+tfNZJ4b6Wpl+
         E3E2D7c/fVsu9NK1PuuCIKOAph+/dD0UwiupTdpLzihtqamhwaXNn1+eSFxg36XE1nAW
         9YCYbT+6Netay+dE7igP1FbsCv8QYjddLC3kVasHRyFjUe3vhlHJ5pPzAaFOmunT+EhT
         TypcY3libiW+1xTSZsvLq3CfCOXA2FWQUiU+MigDUHm3gt0TV6nV3mcKzhVGZgr0Qhni
         PeipZMs+ho2QZuOrtBA9RQFaTSU/S0o5wnK6eQ2hY8zhXlVshk/VfS/NqhE6JdbcRNTR
         jImw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691449534; x=1692054334;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qSt61pcnVgNBhKAHMe8eO3a6G9ChrNL9Px0NKJkznSI=;
        b=Qw/dKD5GP513TG4NJ0JTWOpRko9By5z5g0nQbJsVG1U247qZdN/oKAtOXrsWaEF9WO
         am2pJC7opQ9UocNoX2FOT7pGp4qntO4TXr/tWxWhCNlrhyHRduAGff/3xkB/62lPu10J
         4LR5mpxTfbGcLfe6rtyOi8gCD2Z17aZFUljnXwhXLXvClL/ghMMkIsk1UIlNFxppfVXL
         RBXebdUjT8HG+5GT19MfiZVCnFPtrIfJO4OAWMGEZBwKI4vFH9xpWdhs25x1cpYWYFzr
         oBg/Rv+RmbntgRqdALsziQ/dtjHqRo5Hwsy2xs38oMwyzj+xtHv9ooa9KuRUJVN316wr
         ly/w==
X-Gm-Message-State: AOJu0YwBiN9+UPusdm7Znr1WR+CNfgSZE5tFMHAAGp4FW3E/S0FRm4XV
	sfwMWP9uhU2xeBzKJgoEMWQ=
X-Google-Smtp-Source: AGHT+IH78clSYv8jjRwrTCz7hdEyV6ONxxFaBIBEI75jS+XpTOJin8WaSgmj5CyKgW8Moog6FuLvdA==
X-Received: by 2002:a25:4c86:0:b0:d0a:d15b:3b0f with SMTP id z128-20020a254c86000000b00d0ad15b3b0fmr10002278yba.33.1691449534448;
        Mon, 07 Aug 2023 16:05:34 -0700 (PDT)
Received: from unknowna0e70b2ca394.attlocal.net ([2600:1700:2f7d:1800::16])
        by smtp.googlemail.com with ESMTPSA id d190-20020a25cdc7000000b00d3596aca5bcsm2545203ybf.34.2023.08.07.16.05.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 16:05:34 -0700 (PDT)
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
Subject: [PATCH mm-unstable v9 08/31] mm: Convert ptlock_init() to use ptdescs
Date: Mon,  7 Aug 2023 16:04:50 -0700
Message-Id: <20230807230513.102486-9-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230807230513.102486-1-vishal.moola@gmail.com>
References: <20230807230513.102486-1-vishal.moola@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230807_160537_921384_14E98E0F 
X-CRM114-Status: GOOD (  10.13  )
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

Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>
Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
---
 include/linux/mm.h | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 040982fe9063..13947b17f25e 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2892,7 +2892,7 @@ static inline spinlock_t *pte_lockptr(struct mm_struct *mm, pmd_t *pmd)
 	return ptlock_ptr(page_ptdesc(pmd_page(*pmd)));
 }
 
-static inline bool ptlock_init(struct page *page)
+static inline bool ptlock_init(struct ptdesc *ptdesc)
 {
 	/*
 	 * prep_new_page() initialize page->private (and therefore page->ptl)
@@ -2901,10 +2901,10 @@ static inline bool ptlock_init(struct page *page)
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
 
@@ -2917,13 +2917,13 @@ static inline spinlock_t *pte_lockptr(struct mm_struct *mm, pmd_t *pmd)
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
@@ -2998,7 +2998,7 @@ static inline bool pmd_ptlock_init(struct ptdesc *ptdesc)
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
