Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C750C001DE
	for <linux-um@archiver.kernel.org>; Mon, 31 Jul 2023 17:05:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=q+vgYgNnFIPv6/m53xkTx75C7BJETMjVq3uruvzFAzw=; b=c99P/xSmly03sz
	CfG/PgFXMhHawBCiR6FYqF3r5Cbh0K274iwVkgXx7mxrhlXjwYJENFHSM5zp2m6FPTh3xFgECjPxa
	lRDltLJg00wN44ahYCS2H4iKYoz5VZzfvmVjW9VDrttEJ7gyWGKOTEzO5XWYsRtKuWOf9HyDNoc+a
	ylxa26mhNefn55BCv/3UnKBDz9XkJXdxHE6NL1fgDZKYonro2Gx703Yq265x6/dWYnuma4atmnTOl
	xXkbLOObtI/I1qB4CvL+bVls+5k6z2LdEU8FuSBI9WUD8YjcV1ifLDSnKgJGO08YBql7uG/S7oFmv
	rVaaDUipb/UEBIJDGRZQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qQWKf-00GlPJ-00;
	Mon, 31 Jul 2023 17:05:21 +0000
Received: from mail-yb1-xb36.google.com ([2607:f8b0:4864:20::b36])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qQWJG-00Gk5i-2X;
	Mon, 31 Jul 2023 17:03:56 +0000
Received: by mail-yb1-xb36.google.com with SMTP id 3f1490d57ef6-d3522283441so604050276.0;
        Mon, 31 Jul 2023 10:03:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690823034; x=1691427834;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iy/rMhqpUcv/05FOZn+4srvOxwPFLEA5us+pK4Rb6lw=;
        b=V/96hykns8XVM5vLmRXG/u4xSypUgGiGwrOyC+rZQj+rcZ/GpgCOArv+BLqwnK6ndI
         s6FLSAxMDlFyUBDNQE2VhRek5g328y+/ccd+AsCeEjwXU0hVeTp7lQbn+jR0/Talq7yP
         X53eA6P253fr2h0Co5LkgUqrydVRI6I/ApD8z89cYAQIEmQbjgDCE+0t6nBNrgVReKu1
         hKceHGETSaBcw+wqVyp5iupRKeJkqfupmvumPfxkbIwnP/D5j0bL4ZMnmoLVvjw3thur
         HGuYrC1zSSdz4NYzQoV0QVVrCZG7E5Ll8cUs/PSqUH3UyhbWaZjmYOzvlOZrxF4wqCJv
         qIEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690823034; x=1691427834;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iy/rMhqpUcv/05FOZn+4srvOxwPFLEA5us+pK4Rb6lw=;
        b=ItHqfArTgEDTrtNSVIM0yD00ZbaYb9k0xC1Nia8QcI7gDZ74MKV6psUhXaR66bySbi
         SQc78cyRvyQk6RC8zOKkJhUOiiRDHUeoGROu3+wShnCvTYkEMzPtZ11L1H0BGWGu9cQY
         tXswcdhUqxt6FjfUxJVFcAx7Azrc9CYFA/8ye1AAABXL5IC8HDNlnxPSt+kJ6otKwr5f
         L3GXSMc3rmYol1hQzrR8YOaKBUw95vOhJ4qmNUeQSdOfGVjwbXjbQVtmsNJMpUlNmUx7
         qUtT0axgEvTXC3BQbEq4mfjr58UmGTlvDLKSYdT6aMgRgUaThjRctfuFICs+yBBtmDcL
         Dfww==
X-Gm-Message-State: ABy/qLYAVlq9xlqu3lRO297oWWPzPbUuRuiY6B52OTk08Gh4i4octo5e
	+McNVUeYEGF0/MVX4h9ik1o=
X-Google-Smtp-Source: APBJJlFl3cMRdcyGTSqylTcgbFymQPUIeV+vjMCwSs3kC0GtKDKYI1e8i0USnYA5QForqJcTrXzM0w==
X-Received: by 2002:a25:908d:0:b0:c67:5aea:97ba with SMTP id t13-20020a25908d000000b00c675aea97bamr7117064ybl.50.1690823033777;
        Mon, 31 Jul 2023 10:03:53 -0700 (PDT)
Received: from unknowna0e70b2ca394.attlocal.net ([2600:1700:2f7d:1800::16])
        by smtp.googlemail.com with ESMTPSA id x31-20020a25ac9f000000b00c832ad2e2eesm2511833ybi.60.2023.07.31.10.03.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jul 2023 10:03:53 -0700 (PDT)
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
Subject: [PATCH mm-unstable v8 08/31] mm: Convert ptlock_init() to use ptdescs
Date: Mon, 31 Jul 2023 10:03:09 -0700
Message-Id: <20230731170332.69404-9-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230731170332.69404-1-vishal.moola@gmail.com>
References: <20230731170332.69404-1-vishal.moola@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230731_100354_868213_C3DAA434 
X-CRM114-Status: GOOD (  10.91  )
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
index 52ef09c100a2..675972d3f7e4 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2873,7 +2873,7 @@ static inline spinlock_t *pte_lockptr(struct mm_struct *mm, pmd_t *pmd)
 	return ptlock_ptr(page_ptdesc(pmd_page(*pmd)));
 }
 
-static inline bool ptlock_init(struct page *page)
+static inline bool ptlock_init(struct ptdesc *ptdesc)
 {
 	/*
 	 * prep_new_page() initialize page->private (and therefore page->ptl)
@@ -2882,10 +2882,10 @@ static inline bool ptlock_init(struct page *page)
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
 
@@ -2898,13 +2898,13 @@ static inline spinlock_t *pte_lockptr(struct mm_struct *mm, pmd_t *pmd)
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
@@ -2979,7 +2979,7 @@ static inline bool pmd_ptlock_init(struct ptdesc *ptdesc)
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
