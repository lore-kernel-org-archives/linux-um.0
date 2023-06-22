Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 943D8EB64DA
	for <linux-um@archiver.kernel.org>; Thu, 22 Jun 2023 21:00:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=txnKlpMD2B6lDQlLZQAq5efL2lrfUHfqLcrW2QMKtSY=; b=i6f9EcN/yyTVE7
	El+KS3vJXyEhoV628Z+vdabv2FFcs+hdEdLQmxO/rIdbgcQm7mr4nsLGJh+R2RghP0xbpSmmj9/CD
	/gdVRjeO5u9T+adL1JCe8kyDcMqTw/VJqki0kbRnhF3djnEXhQNS3OIcp5LpoGWl2Sy5BTER6BPQ2
	a7CGoiIVyyPLw8jbZAVJCpVMGKArKsi9ngF/bJXTN5nXOr2w5wL7U1+mbpUUPS39nuuAltchyLTCh
	i10GrjonNRj25xlbfhdbnuDOEjDPzlrwvs9AzaUxj1jk4FGV9a4/NmE5xsVCdIOxP214GqXv3CCl+
	5uYtqtit2MMzDdNFH4NA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qCRPQ-001jUp-02;
	Thu, 22 Jun 2023 21:00:04 +0000
Received: from mail-ot1-x32f.google.com ([2607:f8b0:4864:20::32f])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qCRNm-001hpZ-1z;
	Thu, 22 Jun 2023 20:58:23 +0000
Received: by mail-ot1-x32f.google.com with SMTP id 46e09a7af769-6b720fe3431so82444a34.3;
        Thu, 22 Jun 2023 13:58:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687467501; x=1690059501;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RnNdr5PDFTKJu1h5zX1p1xVUKJvhUfKvVUh/w7ZbrdI=;
        b=RozEvIvVOP2VqVYYMWGzDNL6CpsXTnGXlp/+8t0w3BlD0JmgE5T0sEFoPJ6ld3NgrT
         bo4deZV9iKOusMQ4leLcL/PwL7QvpCQol+1I1GDFuH17XhvWiV9F9j1adtGOARy9Hha6
         3RGKMSONQqhzWt/kDmWTnPMrNJ63EExn/gif2mwqScqJ0/yA9eOZVrNV6N0d1si+/PRm
         WBpjPrumaScaXS+oAuKW5qjU1zlQ2w0x0jfPY5Gm7PSjCaEQ+p7K8a/NRyFlUYxCrD6N
         J99EeDDjbETqur6Uq9P5kOnzRuhiB5K690PgOVUOJzS9Q8J6CLKu6wMbAbv6pVzbEVQk
         Y9LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687467501; x=1690059501;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RnNdr5PDFTKJu1h5zX1p1xVUKJvhUfKvVUh/w7ZbrdI=;
        b=VeRQ12Bzup4FT0LE6LzFh3hHq5i+VbOKQLuWLkb/LkG2Qrc/dKhMiZZ9kb/S8pIJ8j
         JcLhMBQiYzl360hJohaP2gTGgfNoIk4HCZJag9/y4arTpn7hcbkJPxYyCwGE/R8VltWh
         PpdP/xUQ9wZWqK0znAX0Xayzp1ggAn7NPvThLLqI3VGNagg7ykdBb6fmTmYSml3F/KcC
         kaLcPtDzKxxKnGTcFNL8BPZrwneU5z3kKPXkyR0vQqRCmnk7h4aDIOXzElTYXzTRvssi
         nQiuIkRLQdJD3wQ9kZCuVCtyFnaR074/twgKo06gxfhHZxJJVcDSXD4AVcBxNfg/gvjt
         SKkw==
X-Gm-Message-State: AC+VfDxr71xAUkgNlv90WGboik4KOJqfGoAtQv69+43eAg2330a+s/h5
	xbn77Ja2AXSsE8c7J8eAn0k=
X-Google-Smtp-Source: ACHHUZ69lonjyuyFM3x/i0CqMLsv9C2vXMWoj4oQ2M7sud29qozQJHPP5PISfmTicbDCzcNZpP0hng==
X-Received: by 2002:a05:6358:c114:b0:12b:cdd6:9661 with SMTP id fh20-20020a056358c11400b0012bcdd69661mr14337984rwb.13.1687467500803;
        Thu, 22 Jun 2023 13:58:20 -0700 (PDT)
Received: from unknowna0e70b2ca394.attlocal.net ([2600:1700:2f7d:1800::36])
        by smtp.googlemail.com with ESMTPSA id d18-20020a5b0c52000000b00bc501a1b062sm1684937ybr.42.2023.06.22.13.58.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jun 2023 13:58:20 -0700 (PDT)
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
Subject: [PATCH v5 12/33] mm: Create ptdesc equivalents for pgtable_{pte,pmd}_page_{ctor,dtor}
Date: Thu, 22 Jun 2023 13:57:24 -0700
Message-Id: <20230622205745.79707-13-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230622205745.79707-1-vishal.moola@gmail.com>
References: <20230622205745.79707-1-vishal.moola@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230622_135822_661871_684D368F 
X-CRM114-Status: UNSURE (   9.48  )
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
index 69e6d6696c44..356e79984cf9 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2859,20 +2859,34 @@ static inline bool ptlock_init(struct ptdesc *ptdesc) { return true; }
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
@@ -2965,20 +2979,34 @@ static inline spinlock_t *pmd_lock(struct mm_struct *mm, pmd_t *pmd)
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
