Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00BCBC77B73
	for <linux-um@archiver.kernel.org>; Mon,  1 May 2023 19:48:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=bsGYy3zWTDu6jkaGu1PwqiHFos61N+8xSvFuEA9ERsE=; b=Fhl60jCUnJuse4
	0AVlc5jPqxJO0bGjj2ndsMWhywHc1wyqRYiWp1ZIOFviQp6EVZO7aupAb8bfVbuyXUcEQuFR6b2sk
	tBku6PO57eFQS/tOERV9oK6ZPSpuLz4AWoEEK3QNLh9OCAz4ABLo01FRLNAYp5QILsRwVw/iEUB5w
	2Dd1xwleuSuEpNe1ThtLKzbFte+EuynJ5swOYLGroaIbAQLmw7vK2Mjyn6lD39OEZnnYQu23Hi3l7
	0XRqYNWGxddz51VOn912pcPJ6EE2Xtl3hcleqk9Ag80GCwNCqMaviwlq8zPBrUENIOsj7+DfofJsI
	BFYc+X3El5Lf9ar1y7Ig==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1ptZVJ-00GlwM-0l;
	Mon, 01 May 2023 19:48:09 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1ptZUg-00GlDP-09;
	Mon, 01 May 2023 19:47:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=/Q5rpHIbLtPdsxzDzaO3buqXOd2yqrT0Z007lfiZkpI=; b=Xc6XE/svVn9Tnlxse8iHQQcuu3
	B9O9DCwt0ehwxxxZxmnGumv4M5mQQKzSWGwls3Zj3rsa7tiQ9agEOCCdX6bBELyBIbsjdzzSP43+7
	Pkfklax2HjrBvcC4M56iBOhmBt2amxFW9NwcxaGvliBoq4OzvpXIubUz/rEgXWwtLC2AZdt+VVne+
	p4rcU4ZvHsZHQMPju0YydwBopZA0R30TMU47r1N4drKw+pwTS9dVdr0J+KJBSMvzVIKw9aiFjOpPn
	9EHORXu5OxVHGevL1MzebAF98i8l+2YozsiQDHQZbe7ludcTCMT9GNz0Ej4t9DUJC3Ek9dugs9oOt
	UdcXw8TQ==;
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
	by casper.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ptZCj-007cnN-2r; Mon, 01 May 2023 19:29:01 +0000
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1aaf21bb427so10620695ad.1;
        Mon, 01 May 2023 12:28:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682969335; x=1685561335;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/Q5rpHIbLtPdsxzDzaO3buqXOd2yqrT0Z007lfiZkpI=;
        b=AxAga4aoXPNlXE7+DeUiTXETzfeeCHbm4zGppPqr1MDTZFxhWAViYrGbWyE6GLWt+9
         IB0rpQEMaD7N9ypKiOPbsaINcslUNsYjGQTG5q5vWeCnFZgA7dcIKUsRPd84RGXai5h1
         l16CjSDmsfosD9KMmdT6xq8VRCXKZ9G6YKbNHAZjIZoU/NfYHkwEKIBnMm9mpAHGxSXg
         2woYY+DxDFTOnXL4g3fftw/6LCcjY+gzdniMaWURcfFDuyLcW5IhoWI0SL4yBh+tQBiv
         tdoOcx5iHNlwMY/jUOXeVBpbt3BPtJyBIMif2r3nZba5xvX4tcuGQGviD0d/uLbj9ohj
         JJbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682969335; x=1685561335;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/Q5rpHIbLtPdsxzDzaO3buqXOd2yqrT0Z007lfiZkpI=;
        b=KzFEN7gfZxThe19gPNi+7G4WI/q696cYx8kIy/UfT7ouAinsjxajY2gpWjN6QB774N
         oR65o6sdr/DwWw9XXI0LDgfcVktgQZgQIeeu4YIkFiqLCV0dSEE/FhNlf0pY6FcHCe0b
         e11ryhVL832qB07TTPqkEyrtDP7MvyVRUPxCci0/LZzMbovm8tiNl75BQcPUzM8SuB1i
         TCIWdFRhZ53vgBML27/sKbkrxCxqtluzy+pQSnWNcUF6GD+yBqNgErpkciRAWEvnm+00
         lDZMGQTs8B8XYwtAKaBKRTS6yo+VdFwfTg+nLZc2DuSwxJdgmAylAfEXsARMY9iaorcy
         O+ZQ==
X-Gm-Message-State: AC+VfDzgCFFfCX08KU947937iNeVlyOYCzUJEDhQlxyWBqSt4yPLH4cR
	Abm8E4C7D5wDLA4UTDFSLhY=
X-Google-Smtp-Source: ACHHUZ70tPtnwybaj+jIE0QGoYPcdHCYjv99qqOX/zc6uUXZ1o0XGtKwgumEUC29ZoX/UBhdbXOt+g==
X-Received: by 2002:a17:903:41d0:b0:1ab:12a:bd2e with SMTP id u16-20020a17090341d000b001ab012abd2emr2887995ple.37.1682969334945;
        Mon, 01 May 2023 12:28:54 -0700 (PDT)
Received: from fedora.hsd1.ca.comcast.net ([2601:644:937f:7f20::9a2c])
        by smtp.googlemail.com with ESMTPSA id u8-20020a170902bf4800b0019c13d032d8sm18175622pls.253.2023.05.01.12.28.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 May 2023 12:28:54 -0700 (PDT)
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
	"Vishal Moola (Oracle)" <vishal.moola@gmail.com>,
	Dave Hansen <dave.hansen@linux.intel.com>
Subject: [PATCH v2 15/34] x86: Convert various functions to use ptdescs
Date: Mon,  1 May 2023 12:28:10 -0700
Message-Id: <20230501192829.17086-16-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230501192829.17086-1-vishal.moola@gmail.com>
References: <20230501192829.17086-1-vishal.moola@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230501_202857_225478_4F4CB49B 
X-CRM114-Status: GOOD (  13.49  )
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

In order to split struct ptdesc from struct page, convert various
functions to use ptdescs.

Some of the functions use the *get*page*() helper functions. Convert
these to use ptdesc_alloc() and ptdesc_address() instead to help
standardize page tables further.

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
---
 arch/x86/mm/pgtable.c | 46 +++++++++++++++++++++++++------------------
 1 file changed, 27 insertions(+), 19 deletions(-)

diff --git a/arch/x86/mm/pgtable.c b/arch/x86/mm/pgtable.c
index afab0bc7862b..9b6f81c8eb32 100644
--- a/arch/x86/mm/pgtable.c
+++ b/arch/x86/mm/pgtable.c
@@ -52,7 +52,7 @@ early_param("userpte", setup_userpte);
 
 void ___pte_free_tlb(struct mmu_gather *tlb, struct page *pte)
 {
-	pgtable_pte_page_dtor(pte);
+	ptdesc_pte_dtor(page_ptdesc(pte));
 	paravirt_release_pte(page_to_pfn(pte));
 	paravirt_tlb_remove_table(tlb, pte);
 }
@@ -60,7 +60,7 @@ void ___pte_free_tlb(struct mmu_gather *tlb, struct page *pte)
 #if CONFIG_PGTABLE_LEVELS > 2
 void ___pmd_free_tlb(struct mmu_gather *tlb, pmd_t *pmd)
 {
-	struct page *page = virt_to_page(pmd);
+	struct ptdesc *ptdesc = virt_to_ptdesc(pmd);
 	paravirt_release_pmd(__pa(pmd) >> PAGE_SHIFT);
 	/*
 	 * NOTE! For PAE, any changes to the top page-directory-pointer-table
@@ -69,8 +69,8 @@ void ___pmd_free_tlb(struct mmu_gather *tlb, pmd_t *pmd)
 #ifdef CONFIG_X86_PAE
 	tlb->need_flush_all = 1;
 #endif
-	pgtable_pmd_page_dtor(page);
-	paravirt_tlb_remove_table(tlb, page);
+	ptdesc_pmd_dtor(ptdesc);
+	paravirt_tlb_remove_table(tlb, ptdesc_page(ptdesc));
 }
 
 #if CONFIG_PGTABLE_LEVELS > 3
@@ -92,16 +92,16 @@ void ___p4d_free_tlb(struct mmu_gather *tlb, p4d_t *p4d)
 
 static inline void pgd_list_add(pgd_t *pgd)
 {
-	struct page *page = virt_to_page(pgd);
+	struct ptdesc *ptdesc = virt_to_ptdesc(pgd);
 
-	list_add(&page->lru, &pgd_list);
+	list_add(&ptdesc->pt_list, &pgd_list);
 }
 
 static inline void pgd_list_del(pgd_t *pgd)
 {
-	struct page *page = virt_to_page(pgd);
+	struct ptdesc *ptdesc = virt_to_ptdesc(pgd);
 
-	list_del(&page->lru);
+	list_del(&ptdesc->pt_list);
 }
 
 #define UNSHARED_PTRS_PER_PGD				\
@@ -112,12 +112,12 @@ static inline void pgd_list_del(pgd_t *pgd)
 
 static void pgd_set_mm(pgd_t *pgd, struct mm_struct *mm)
 {
-	virt_to_page(pgd)->pt_mm = mm;
+	virt_to_ptdesc(pgd)->pt_mm = mm;
 }
 
 struct mm_struct *pgd_page_get_mm(struct page *page)
 {
-	return page->pt_mm;
+	return page_ptdesc(page)->pt_mm;
 }
 
 static void pgd_ctor(struct mm_struct *mm, pgd_t *pgd)
@@ -213,11 +213,14 @@ void pud_populate(struct mm_struct *mm, pud_t *pudp, pmd_t *pmd)
 static void free_pmds(struct mm_struct *mm, pmd_t *pmds[], int count)
 {
 	int i;
+	struct ptdesc *ptdesc;
 
 	for (i = 0; i < count; i++)
 		if (pmds[i]) {
-			pgtable_pmd_page_dtor(virt_to_page(pmds[i]));
-			free_page((unsigned long)pmds[i]);
+			ptdesc = virt_to_ptdesc(pmds[i]);
+
+			ptdesc_pmd_dtor(ptdesc);
+			ptdesc_free(ptdesc);
 			mm_dec_nr_pmds(mm);
 		}
 }
@@ -232,16 +235,21 @@ static int preallocate_pmds(struct mm_struct *mm, pmd_t *pmds[], int count)
 		gfp &= ~__GFP_ACCOUNT;
 
 	for (i = 0; i < count; i++) {
-		pmd_t *pmd = (pmd_t *)__get_free_page(gfp);
-		if (!pmd)
+		pmd_t *pmd = NULL;
+		struct ptdesc *ptdesc = ptdesc_alloc(gfp, 0);
+
+		if (!ptdesc)
 			failed = true;
-		if (pmd && !pgtable_pmd_page_ctor(virt_to_page(pmd))) {
-			free_page((unsigned long)pmd);
-			pmd = NULL;
+		if (ptdesc && !ptdesc_pmd_ctor(ptdesc)) {
+			ptdesc_free(ptdesc);
+			ptdesc = NULL;
 			failed = true;
 		}
-		if (pmd)
+		if (ptdesc) {
 			mm_inc_nr_pmds(mm);
+			pmd = (pmd_t *)ptdesc_address(ptdesc);
+		}
+
 		pmds[i] = pmd;
 	}
 
@@ -838,7 +846,7 @@ int pud_free_pmd_page(pud_t *pud, unsigned long addr)
 
 	free_page((unsigned long)pmd_sv);
 
-	pgtable_pmd_page_dtor(virt_to_page(pmd));
+	ptdesc_pmd_dtor(virt_to_ptdesc(pmd));
 	free_page((unsigned long)pmd);
 
 	return 1;
-- 
2.39.2


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
