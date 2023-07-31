Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A50EC001DC
	for <linux-um@archiver.kernel.org>; Mon, 31 Jul 2023 17:05:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=IE/unCKaczgFWDthXqoGoIUi8+JYIh8uVki2M0NwA8A=; b=me32Kk+vtTCyd6
	vM985PFOaBX9Sw7HaHLDTUJLcxJtEuBaSREZVHaODO8PmrZO0WdiwKc6ZIhlDE+9KDVCicO370TFD
	UIJ08/sfC/hJgXRzP20nGt3oTo6zotuASIQe2sl9nUswxCkwWS5ayLA1SW+mB5udy1v0He0+qzoqT
	lexaxmh4iJHBXmn+0T86vzd3GIcNuH3c8MuOlq01n5Ool3teWjiRgIiat0HBrrMOtwtHXlm+PeQ+5
	auiHjGTGQBED+j5Rst64qbCkIAwF+XSs6Mm9E8T+6BTxpnwBBXiashgsjuSlTcZByRRDRsyqA7I0K
	YCIeBXpzF2yTRHScDTpg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qQWLE-00GlnK-1e;
	Mon, 31 Jul 2023 17:05:56 +0000
Received: from mail-yw1-x112a.google.com ([2607:f8b0:4864:20::112a])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qQWJO-00GkC0-0h;
	Mon, 31 Jul 2023 17:04:03 +0000
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-5862a6ae535so12593187b3.0;
        Mon, 31 Jul 2023 10:04:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690823040; x=1691427840;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GM8s3dDlKIn9bcZ3Rv1fAyQJ11tvy15JiujAITQGQIU=;
        b=WsnCjEuFun6IuHpPh6Ck/rBg4AZLbVHEs2jk+7TEc5kPbUlyDbLU82vMQ8hYNiUbEV
         KmukkQXHlnalx2MRwxX9OA1ED5qQ+cRzMsv/rlYCU41nnUNJeib6/uXFu8sMt236/2Ud
         yhZAMNcebKfkSv6mc59ZybiKh0RsfAPQpPnm2pft2DHqmzXA9/C0fNB/u3wlBocoiSJC
         LtpkvTvVemtPOevOsyRiBPGxBKIgXaumZpQx0YFqajcNPkaTnpsizZKv1A3XIPWZnK5y
         p/CzUaAjAQ1JZb9e9DygJrxewNU/aZAjuX8qYUs6cV2yG2QRoeh00nb4O3A983HwtiRJ
         fbTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690823040; x=1691427840;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GM8s3dDlKIn9bcZ3Rv1fAyQJ11tvy15JiujAITQGQIU=;
        b=keXv6LfoivwydRQONxwfm6wXs8VnKyyBGaGKmGRFS5xijV01RtOKY6rU/516QEg7DN
         3NQdI8dadU1CNSvadwxHo0VMUntJAOYFgEi0pH7533MKFIhp0aNimFIqU6FhM82tXtSp
         yk+2nw+EEYqRODTBrqHuJnFsKZn88P6KXlhT2B8dPeNO1NksweqFfehrChKNXyjz7ioX
         9MiubhgVEa/bPBz+I4v6UqdsPQCz+fLuzB3zglZBtd3BTcb1DQf18A859fh92oyVc37t
         LswhSxuLY05/mP/tUIGfU+qofPe34rwgAL7fLLFLuDG8TZgf9++8KHb8an0osUxYeNqw
         xfrg==
X-Gm-Message-State: ABy/qLauhk+t6p+9fWANz3cxTMIWBw0bH2PGWMbD8lA0k3dZiGEbA2wZ
	pXTybPQqrMW6HXJYt3N7fuY=
X-Google-Smtp-Source: APBJJlHch/jSJCdVVtDWb1WClZ5gGKwbX6GY1zRRfwmE6xAtgRg67mCRvfprsxzmmxwehzomhr3VNg==
X-Received: by 2002:a25:c7d1:0:b0:d08:20f1:f7cd with SMTP id w200-20020a25c7d1000000b00d0820f1f7cdmr8274869ybe.16.1690823039767;
        Mon, 31 Jul 2023 10:03:59 -0700 (PDT)
Received: from unknowna0e70b2ca394.attlocal.net ([2600:1700:2f7d:1800::16])
        by smtp.googlemail.com with ESMTPSA id x31-20020a25ac9f000000b00c832ad2e2eesm2511833ybi.60.2023.07.31.10.03.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jul 2023 10:03:59 -0700 (PDT)
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
Subject: [PATCH mm-unstable v8 11/31] mm: Create ptdesc equivalents for pgtable_{pte,pmd}_page_{ctor,dtor}
Date: Mon, 31 Jul 2023 10:03:12 -0700
Message-Id: <20230731170332.69404-12-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230731170332.69404-1-vishal.moola@gmail.com>
References: <20230731170332.69404-1-vishal.moola@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230731_100402_261755_F0B30D46 
X-CRM114-Status: GOOD (  10.12  )
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
