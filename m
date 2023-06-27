Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE202C0015E
	for <linux-um@archiver.kernel.org>; Tue, 27 Jun 2023 03:16:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=9Q5Ubuk+5uSeC1nH8MS2xqrub1m9lgU6poooc8dD/pI=; b=tHl1NOtGU1+/PS
	ASvKmUCV4KHynfrGoYrCSFXSjlUC33obXtO6oLORTrdCwgxj0TrNUoQMW5hWDVrLYWr2OOga6Y/LP
	giCXF61s0b/MoGixwH41NGgKXhWuinDsO7J3mzvXdj9lAZJXGMpltBG4qiwAyuLyowCt/Yfb7PJbF
	iEap+Zwa4yWwbSE/cSvttFk16AgWa1hvp3dxeM15NHLcn3DM0f7SEAulT4clicHA6gUU35+TkWUkw
	q5GfdIbSPSk+Rf+FQXHz+AytgJQ7VhIrh3n8r0jqFwUwwpW0PlodfQ24RTSxO3Vm4STJXJL0I2Zly
	MbRnkO/RQeVh89PTM2Vg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qDzCN-00BX2u-0P;
	Tue, 27 Jun 2023 03:16:59 +0000
Received: from mail-yw1-x1130.google.com ([2607:f8b0:4864:20::1130])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qDzAx-00BVcK-2X;
	Tue, 27 Jun 2023 03:15:34 +0000
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-570284c7e61so43269707b3.1;
        Mon, 26 Jun 2023 20:15:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687835731; x=1690427731;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bhgUYiKwQSwYMGFv9d1r56wjiuPfdLCT9N5JwdJpvSY=;
        b=NN6JuQbcJSEhuQl119fqyrzmvfTJLSgZNGPIizHO44moV6zy7vRkkkGbpzNnm+T/zk
         LfpssTQxYHLCLcRT6ur03GhfUH0PR3hr1gEAZWn4KlOVQ/bRaXKu0XwyzIXh7FK2T78w
         GV5aBHngJRtwmpryMrqg1wnpyNcK63Z6rXozTP8pqdze8wtkdCn+4d6Nxd1VmHHTwiSp
         Hj2gVskjJaa7d3mxLgebdTWNoaiyWHEkTnVETMwzQNfFNqae/PKVEKJL0sEqbBCs/7Gc
         Lg3rR1WUfvzFXQfsjuyOG1PSX82wJS5wL2NRG2ks6qk/cPnX1GTuY36dOOOiPPB0JsGq
         3KdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687835731; x=1690427731;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bhgUYiKwQSwYMGFv9d1r56wjiuPfdLCT9N5JwdJpvSY=;
        b=GGtQf/e0djMB1ubPHIDsbDZL52pgt3wVNO2JMCdSLh6ib5p0EtOsY4p0d74RLmCULG
         +RoyqGs4jZtq3Z8KcYT68LKlBhWQABjvE8DgRkRd5sXWMw22HpmSr3Nf+t9ZkcYriamX
         +1DaRDmR/f5n/vyACYB8vwBAvxC+yZ9sZGVNyKTxCL/FFHkrXZEWGaclO5xalppQRx1/
         ohajj4e4zm7dYq2ki0lGM0Tk8jayn4U2pDY2J0DO4oeYskmz6QisFA4j7Nd741TBOgod
         Li39RUnwIGuS8UhpmKKPUT7URMf+DJbHIzoPlDh0JM7o7gL3ew6teymMbfKioynVjXp0
         5qrQ==
X-Gm-Message-State: AC+VfDyMTH7+unazU7jAn/5VyUuYsAoM/t1Xvs8z6nXQy1AJ8ud13oE9
	FsnzEb6zq6VJblrRWDJ0DBs=
X-Google-Smtp-Source: ACHHUZ77IlfDYtyaiNtbQBvQ+hst+uMDswEhJokbRedTnkaskK+XBmCINjFgoTdvnk/TaS9G8YnT8Q==
X-Received: by 2002:a81:6cc3:0:b0:56f:fcb0:26f6 with SMTP id h186-20020a816cc3000000b0056ffcb026f6mr25623334ywc.52.1687835730840;
        Mon, 26 Jun 2023 20:15:30 -0700 (PDT)
Received: from unknowna0e70b2ca394.attlocal.net ([2600:1700:2f7d:1800::16])
        by smtp.googlemail.com with ESMTPSA id s4-20020a0dd004000000b0057399b3bd26sm1614798ywd.33.2023.06.26.20.15.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jun 2023 20:15:30 -0700 (PDT)
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
Subject: [PATCH v6 11/33] mm: Convert ptlock_free() to use ptdescs
Date: Mon, 26 Jun 2023 20:14:09 -0700
Message-Id: <20230627031431.29653-12-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230627031431.29653-1-vishal.moola@gmail.com>
References: <20230627031431.29653-1-vishal.moola@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230626_201531_869189_C53A6D18 
X-CRM114-Status: GOOD (  10.40  )
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
index 0221675e4dc5..69e6d6696c44 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2799,7 +2799,7 @@ static inline void pagetable_free(struct ptdesc *pt)
 #if ALLOC_SPLIT_PTLOCKS
 void __init ptlock_cache_init(void);
 bool ptlock_alloc(struct ptdesc *ptdesc);
-extern void ptlock_free(struct page *page);
+void ptlock_free(struct ptdesc *ptdesc);
 
 static inline spinlock_t *ptlock_ptr(struct ptdesc *ptdesc)
 {
@@ -2815,7 +2815,7 @@ static inline bool ptlock_alloc(struct ptdesc *ptdesc)
 	return true;
 }
 
-static inline void ptlock_free(struct page *page)
+static inline void ptlock_free(struct ptdesc *ptdesc)
 {
 }
 
@@ -2856,7 +2856,7 @@ static inline spinlock_t *pte_lockptr(struct mm_struct *mm, pmd_t *pmd)
 }
 static inline void ptlock_cache_init(void) {}
 static inline bool ptlock_init(struct ptdesc *ptdesc) { return true; }
-static inline void ptlock_free(struct page *page) {}
+static inline void ptlock_free(struct ptdesc *ptdesc) {}
 #endif /* USE_SPLIT_PTE_PTLOCKS */
 
 static inline bool pgtable_pte_page_ctor(struct page *page)
@@ -2870,7 +2870,7 @@ static inline bool pgtable_pte_page_ctor(struct page *page)
 
 static inline void pgtable_pte_page_dtor(struct page *page)
 {
-	ptlock_free(page);
+	ptlock_free(page_ptdesc(page));
 	__ClearPageTable(page);
 	dec_lruvec_page_state(page, NR_PAGETABLE);
 }
@@ -2939,7 +2939,7 @@ static inline void pmd_ptlock_free(struct ptdesc *ptdesc)
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 	VM_BUG_ON_PAGE(ptdesc->pmd_huge_pte, ptdesc_page(ptdesc));
 #endif
-	ptlock_free(ptdesc_page(ptdesc));
+	ptlock_free(ptdesc);
 }
 
 #define pmd_huge_pte(mm, pmd) (pmd_ptdesc(pmd)->pmd_huge_pte)
diff --git a/mm/memory.c b/mm/memory.c
index 2ff14f50c7b3..8743aef6095b 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -5931,8 +5931,8 @@ bool ptlock_alloc(struct ptdesc *ptdesc)
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
