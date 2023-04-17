Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D203CC77B76
	for <linux-um@archiver.kernel.org>; Mon, 17 Apr 2023 21:17:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Xc7FHGDg2/Lw7BbT4vKkggOP8/dx7m7hYCZikJaeIxg=; b=2MVvnAzNoCgHCH
	XlCE5l75t7rvdjIXuX4xYqeTo4XtD7k8/Kiazzle2kpz3qQSroejS2otCOCo5GhMCf7Bv47Fe9rIk
	X0+GezokN3GWVlh1lNhx3kGsWcNqZdVGD8R8zLbCBa7sVGE3Lna/ea3RTmClEJic+WHpbejZvJ/QN
	Xx2q0EMs27tx9reQSleD9BWnRMKWTNau+Xcx2jns/IBYUPVhGwVDm1dGp8RWwDNz5h8fIRzriHQa9
	mFHDIDCbSf1aFjRfb32TGkUVW6d8X6qf7FraVwPG6KLWflSw9K++6LJslbO8OYFkLCEW84R8uCDxy
	nFMG79GF2SKM8ycQhWbQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1poWEM-0002Wc-10;
	Mon, 17 Apr 2023 21:17:46 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1poWE5-0002G2-2p;
	Mon, 17 Apr 2023 21:17:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=WrZX7kBoYSlYOsS+wVtDQN8RsK5AFCnoOOzdjwi5Mms=; b=JC4g4QPcaJe+eleBRU4o5GMBZp
	tgMBYVvegppaECrb4xenSNfGuvaTxDbDf+LnSSaAcws8nDOZpr1q64cK7hSP3DyxJ1JO05g38lmMA
	VX3XOKrxjLTk1MHldccsQ3YGuNmfkLuLawQD6JEzihx70B1pj+ZxTp7kXJq8TaWWZKRgN0H9eUnjy
	ce0KHf2R+6A/FZWP4mr8bt8cymUQrvNO0Gr7fQuz5OwxAz6bkwyfjZ5vW0bwwlxg5GjZ0/QZ6wnmF
	e7B1qmDRYOPMYlftsKxxImM0W8YaIaG/8kcXTr6cbVrVg2JUm2BNMXR5zu+/NhLtwWnCRCcq+5+Gf
	BiusdSHw==;
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
	by casper.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1poVqS-00Bfog-Pe; Mon, 17 Apr 2023 20:53:07 +0000
Received: by mail-pj1-x1031.google.com with SMTP id s6-20020a17090a698600b00247a7794e78so3557461pjj.0;
        Mon, 17 Apr 2023 13:53:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681764782; x=1684356782;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WrZX7kBoYSlYOsS+wVtDQN8RsK5AFCnoOOzdjwi5Mms=;
        b=Fq/GP8pcdLi4I5bPiFEsvLaXpxmzLee60TMK8PZJIeuQRzzOkEw4LNRxem1TjMHkl4
         hpoJjh3mkwkBNIc+7ZgY54HKylkrI6wgo3KFZgMqWIFkgvOs6SvSJyDnyNXKU57Vfgni
         F3o9PaXHz7p6eZRgp/mKtHM6HxVxSp+JnGgjpmMtA2nsWbkEb7dNgfcs3WzKBla+e/KK
         mEc/vn9ckYnWIktc03O3OhGV7y0sYxPsn1QEH3DBGZVQjs25sE8N0p2VjcijmIU6liuv
         XPjI1oYrX0OJGyw0BE4l6r4tCUbdIF44UY/L4uGFZKlEP+7PRKuryCCDJJcwRQi8c96H
         TYTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681764782; x=1684356782;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WrZX7kBoYSlYOsS+wVtDQN8RsK5AFCnoOOzdjwi5Mms=;
        b=SJxt6L2a4EmMcEzs4W9kTpixZgqKX1/qOUkGBwokw3fgpzD+VK4pTpXxMcZeZWmFwz
         zJYBQRrIlFnB6n7zheX9VXFv9bqjXHxFqQHhf4Xh9+bBCSe+9EuzsE6eXHVs//6lyoqo
         OEWyVR+9fzNhPhlpuLAPmlcoZvz/teALuJa9oFShemu62J+qt63Xf2nBLYxLfMv0JENJ
         Be5wZKsuUzu5GPXWfJdS00v45TVm7YArx/R08D6kBvc1dFzVrgGCxubQP7JoZvzBz6Dj
         IgfTvYy9m7x7jaNPQRvaUDIs9aF97tqK7ccDAN3A8S5F/mwV9QVnAcDXbRfkXXmdepj1
         /udg==
X-Gm-Message-State: AAQBX9frNCscR6hpA90uBeyP5JPyCxRNkt1KPurDK9FIqJqLYb4gE9Fu
	1eAYXm154qrCPmNDmyFs5mo=
X-Google-Smtp-Source: AKy350ZKSmY2j825YUr7PKp4UY4ecmOCun/8MK3oszIbqT0tc1tYYx3cO7v8JESnTYGwYaXHIhiESg==
X-Received: by 2002:a17:902:ecd2:b0:1a6:9671:253e with SMTP id a18-20020a170902ecd200b001a69671253emr219179plh.47.1681764781984;
        Mon, 17 Apr 2023 13:53:01 -0700 (PDT)
Received: from fedora.hsd1.ca.comcast.net ([2601:644:937f:7f20::c139])
        by smtp.googlemail.com with ESMTPSA id h7-20020a17090ac38700b0022335f1dae2sm7609707pjt.22.2023.04.17.13.53.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Apr 2023 13:53:01 -0700 (PDT)
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
Subject: [PATCH 12/33] mm: Create ptdesc equivalents for pgtable_{pte,pmd}_page_{ctor,dtor}
Date: Mon, 17 Apr 2023 13:50:27 -0700
Message-Id: <20230417205048.15870-13-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230417205048.15870-1-vishal.moola@gmail.com>
References: <20230417205048.15870-1-vishal.moola@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230417_215305_068493_561F28F3 
X-CRM114-Status: UNSURE (   9.24  )
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

Creates ptdesc_pte_ctor(), ptdesc_pmd_ctor(), ptdesc_pte_dtor(), and
ptdesc_pmd_dtor() and make the original pgtable constructor/destructors
wrappers.

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
---
 include/linux/mm.h | 56 ++++++++++++++++++++++++++++++++++------------
 1 file changed, 42 insertions(+), 14 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 17a64cfd1430..cb136d2fdf74 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2847,20 +2847,34 @@ static inline bool ptlock_init(struct ptdesc *ptdesc) { return true; }
 static inline void ptlock_free(struct ptdesc *ptdesc) {}
 #endif /* USE_SPLIT_PTE_PTLOCKS */
 
-static inline bool pgtable_pte_page_ctor(struct page *page)
+static inline bool ptdesc_pte_ctor(struct ptdesc *ptdesc)
 {
-	if (!ptlock_init(page_ptdesc(page)))
+	struct folio *folio = ptdesc_folio(ptdesc);
+
+	if (!ptlock_init(ptdesc))
 		return false;
-	__SetPageTable(page);
-	inc_lruvec_page_state(page, NR_PAGETABLE);
+	__SetPageTable(&folio->page);
+	lruvec_stat_add_folio(folio, NR_PAGETABLE);
 	return true;
 }
 
+static inline bool pgtable_pte_page_ctor(struct page *page)
+{
+	return ptdesc_pte_ctor(page_ptdesc(page));
+}
+
+static inline void ptdesc_pte_dtor(struct ptdesc *ptdesc)
+{
+	struct folio *folio = ptdesc_folio(ptdesc);
+
+	ptlock_free(ptdesc);
+	__ClearPageTable(&folio->page);
+	lruvec_stat_sub_folio(folio, NR_PAGETABLE);
+}
+
 static inline void pgtable_pte_page_dtor(struct page *page)
 {
-	ptlock_free(page_ptdesc(page));
-	__ClearPageTable(page);
-	dec_lruvec_page_state(page, NR_PAGETABLE);
+	ptdesc_pte_dtor(page_ptdesc(page));
 }
 
 #define pte_offset_map_lock(mm, pmd, address, ptlp)	\
@@ -2942,20 +2956,34 @@ static inline spinlock_t *pmd_lock(struct mm_struct *mm, pmd_t *pmd)
 	return ptl;
 }
 
-static inline bool pgtable_pmd_page_ctor(struct page *page)
+static inline bool ptdesc_pmd_ctor(struct ptdesc *ptdesc)
 {
-	if (!pmd_ptlock_init(page_ptdesc(page)))
+	struct folio *folio = ptdesc_folio(ptdesc);
+
+	if (!pmd_ptlock_init(ptdesc))
 		return false;
-	__SetPageTable(page);
-	inc_lruvec_page_state(page, NR_PAGETABLE);
+	__SetPageTable(&folio->page);
+	lruvec_stat_add_folio(folio, NR_PAGETABLE);
 	return true;
 }
 
+static inline bool pgtable_pmd_page_ctor(struct page *page)
+{
+	return ptdesc_pmd_ctor(page_ptdesc(page));
+}
+
+static inline void ptdesc_pmd_dtor(struct ptdesc *ptdesc)
+{
+	struct folio *folio = ptdesc_folio(ptdesc);
+
+	pmd_ptlock_free(ptdesc);
+	__ClearPageTable(&folio->page);
+	lruvec_stat_sub_folio(folio, NR_PAGETABLE);
+}
+
 static inline void pgtable_pmd_page_dtor(struct page *page)
 {
-	pmd_ptlock_free(page_ptdesc(page));
-	__ClearPageTable(page);
-	dec_lruvec_page_state(page, NR_PAGETABLE);
+	ptdesc_pmd_dtor(page_ptdesc(page));
 }
 
 /*
-- 
2.39.2


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
