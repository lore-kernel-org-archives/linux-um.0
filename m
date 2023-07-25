Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 706EEEB64DD
	for <linux-um@archiver.kernel.org>; Tue, 25 Jul 2023 04:22:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=IE/unCKaczgFWDthXqoGoIUi8+JYIh8uVki2M0NwA8A=; b=ME4u7g6buHnifk
	kMnp9vuiGZkIRSQFuDCkwi7swYX7c5ffXr7xGyDesKpiZPivMczODrmCClsf2isvpfQddF2WOGhrL
	f0r8KHHbwvNRdeflAoV/4mgWALIPVegJ4v0CXqBrZy7PxWJcCG/CCXHeo+IHgmpW6DoF4mRAviqL9
	Hod1UnwtxFtiTMZ8Q5WcX1AMaIajCe2WDRRXQNpPSCJWJBc5/bODDp/lNGPPO4T4csTb8ySkTMjyZ
	i/f2epCYXm++8QkOJ+3ZiAdDwOJM8KU6zoKK1RGs/UHOrmiVkNlWbThBOrbZrNVWAxerxqB/o2NpU
	joHvuVvDgpEmfseezwOQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qO9Za-0068bj-04;
	Tue, 25 Jul 2023 04:22:58 +0000
Received: from mail-yb1-xb33.google.com ([2607:f8b0:4864:20::b33])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qO9YA-0067Gb-0i;
	Tue, 25 Jul 2023 04:21:32 +0000
Received: by mail-yb1-xb33.google.com with SMTP id 3f1490d57ef6-d0b597e7ac1so2717992276.1;
        Mon, 24 Jul 2023 21:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690258889; x=1690863689;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GM8s3dDlKIn9bcZ3Rv1fAyQJ11tvy15JiujAITQGQIU=;
        b=pRtFn4s2PbyDqF0TT2ROPqoi8Nf6cO+mjT/PpAibpqoGu7RVl319pUbQzpwGcemW6v
         ycybLo0TEnNIsKIUBDodgJqfY6SleEYizvK1Vc9btvfMS46S3rfljXuaAJYnljAU7sG7
         7jK+G5eyuE1KaJYyjxnJ03BoenaidsCYPCkwIEGR1Hhy/zJz4Ys+XX9GMOuKC1FJDNY4
         VtftN6v4wiLKMbMCHR3bjB9E/ZrVvmPIO3VQbX7+L4Iqn5VeUa8q9xhONTfTBRh7Kux2
         Tj/BOzEarK1RhsZfJqN5Pnf19w+jQvRB3VZLmWb0D0GCMPtXp8othTQIXw79eSgdX3zV
         QV6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690258889; x=1690863689;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GM8s3dDlKIn9bcZ3Rv1fAyQJ11tvy15JiujAITQGQIU=;
        b=aKkxqXGBAy7YGWal1R85y7ESO79DayUMr8iPng511YzeZK6e8bd2IFCC/uAr6KXi7Q
         1Xuekx/XuKWpXyVA1d0lb0vAbgEZZrMnoUbtV0O1ie4N2IoOYfsnnN/EeuewdqhcBWwB
         vG1+ihaCf8h74PCSuuQceeFli1BAnZ0IeobqdmeIBocetmD5fBD0kDVzj5pPDgyeihZh
         +e+n7+W1ES8wxet49MAFtWStgh9A1yVUjWzuQfzoi3QlvJDqE5J85iGI/Uaqqb2Z93Uy
         EI/VO4K/58IFtTdbWatx3bWRKPAkdLW+LPiSJVdPAr1GalgrP5/xy+qz1w3NoBmRWr4c
         0PpQ==
X-Gm-Message-State: ABy/qLa99sGDgLCzs4mqwg3+2SW1BN6md0gsRZzVVi81HHRH4+HVQtow
	NbW4ECgU4nCN42XQDKh/rJU=
X-Google-Smtp-Source: APBJJlG8/pyNsL5c65VV2FWW2n+kp6iwz/O9EJhcRKijOyOwqeNWpfh6eCenLgaMZnYc3nueG5tQ5Q==
X-Received: by 2002:a25:e7d8:0:b0:d0e:b5c8:6359 with SMTP id e207-20020a25e7d8000000b00d0eb5c86359mr4890639ybh.55.1690258889345;
        Mon, 24 Jul 2023 21:21:29 -0700 (PDT)
Received: from unknowna0e70b2ca394.attlocal.net ([2600:1700:2f7d:1800::16])
        by smtp.googlemail.com with ESMTPSA id h9-20020a25b189000000b00d0db687ef48sm1175540ybj.61.2023.07.24.21.21.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jul 2023 21:21:29 -0700 (PDT)
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
Subject: [PATCH mm-unstable v7 11/31] mm: Create ptdesc equivalents for pgtable_{pte,pmd}_page_{ctor,dtor}
Date: Mon, 24 Jul 2023 21:20:31 -0700
Message-Id: <20230725042051.36691-12-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230725042051.36691-1-vishal.moola@gmail.com>
References: <20230725042051.36691-1-vishal.moola@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230724_212130_274571_643EE375 
X-CRM114-Status: UNSURE (   9.68  )
X-CRM114-Notice: Please train this message.
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

Create pagetable_pte_ctor(), pagetable_pmd_ctor(), pagetable_pte_dtor(),
and pagetable_pmd_dtor() and make the original pgtable
constructor/destructors wrappers.

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>
---
 include/linux/mm.h | 56 ++++++++++++++++++++++++++++++++++------------
 1 file changed, 42 insertions(+), 14 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index ffddae95af78..bd3d99d81984 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2902,20 +2902,34 @@ static inline bool ptlock_init(struct ptdesc *ptdesc) { return true; }
 static inline void ptlock_free(struct ptdesc *ptdesc) {}
 #endif /* USE_SPLIT_PTE_PTLOCKS */
 
-static inline bool pgtable_pte_page_ctor(struct page *page)
+static inline bool pagetable_pte_ctor(struct ptdesc *ptdesc)
 {
-	if (!ptlock_init(page_ptdesc(page)))
+	struct folio *folio = ptdesc_folio(ptdesc);
+
+	if (!ptlock_init(ptdesc))
 		return false;
-	__SetPageTable(page);
-	inc_lruvec_page_state(page, NR_PAGETABLE);
+	__folio_set_pgtable(folio);
+	lruvec_stat_add_folio(folio, NR_PAGETABLE);
 	return true;
 }
 
+static inline bool pgtable_pte_page_ctor(struct page *page)
+{
+	return pagetable_pte_ctor(page_ptdesc(page));
+}
+
+static inline void pagetable_pte_dtor(struct ptdesc *ptdesc)
+{
+	struct folio *folio = ptdesc_folio(ptdesc);
+
+	ptlock_free(ptdesc);
+	__folio_clear_pgtable(folio);
+	lruvec_stat_sub_folio(folio, NR_PAGETABLE);
+}
+
 static inline void pgtable_pte_page_dtor(struct page *page)
 {
-	ptlock_free(page_ptdesc(page));
-	__ClearPageTable(page);
-	dec_lruvec_page_state(page, NR_PAGETABLE);
+	pagetable_pte_dtor(page_ptdesc(page));
 }
 
 pte_t *__pte_offset_map(pmd_t *pmd, unsigned long addr, pmd_t *pmdvalp);
@@ -3013,20 +3027,34 @@ static inline spinlock_t *pmd_lock(struct mm_struct *mm, pmd_t *pmd)
 	return ptl;
 }
 
-static inline bool pgtable_pmd_page_ctor(struct page *page)
+static inline bool pagetable_pmd_ctor(struct ptdesc *ptdesc)
 {
-	if (!pmd_ptlock_init(page_ptdesc(page)))
+	struct folio *folio = ptdesc_folio(ptdesc);
+
+	if (!pmd_ptlock_init(ptdesc))
 		return false;
-	__SetPageTable(page);
-	inc_lruvec_page_state(page, NR_PAGETABLE);
+	__folio_set_pgtable(folio);
+	lruvec_stat_add_folio(folio, NR_PAGETABLE);
 	return true;
 }
 
+static inline bool pgtable_pmd_page_ctor(struct page *page)
+{
+	return pagetable_pmd_ctor(page_ptdesc(page));
+}
+
+static inline void pagetable_pmd_dtor(struct ptdesc *ptdesc)
+{
+	struct folio *folio = ptdesc_folio(ptdesc);
+
+	pmd_ptlock_free(ptdesc);
+	__folio_clear_pgtable(folio);
+	lruvec_stat_sub_folio(folio, NR_PAGETABLE);
+}
+
 static inline void pgtable_pmd_page_dtor(struct page *page)
 {
-	pmd_ptlock_free(page_ptdesc(page));
-	__ClearPageTable(page);
-	dec_lruvec_page_state(page, NR_PAGETABLE);
+	pagetable_pmd_dtor(page_ptdesc(page));
 }
 
 /*
-- 
2.40.1


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
