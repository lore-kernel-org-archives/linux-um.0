Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C17FEC7EE43
	for <linux-um@archiver.kernel.org>; Mon, 12 Jun 2023 22:02:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=oj81xGkHgxe59yn0pMbWLk3OuCC5N9xaXTGvaC5XajM=; b=F8Vo7Q7L1RcRLY
	lyEirW15FORNGb4UPzCTyrc8LW+se7cOutv8LM+bN/Cl2ht+qH3jR4BYngz50BTd2JlKDXO6xwVwZ
	PIB1zSdZOt3pAYx7M4llkI2oipxtC7EJd/5JuwOgB61SYaCWBzzpf7gM4fKL+wy52n84XOSiR/IaY
	cnb0o4L6310dU3k6Seo5ciiKFEDqDlD5z6tyDmhxD3Q0Sr0qCwMf3yweYLGzghSsXRzP1dk+4msco
	dhaRsBvFjYIXBKrxv/HfTwFI3wCDZgWM/T9wZknGMSDCJuv2ZsWzwUi079t9woYI6O6/K1zhGOeIg
	vgdugcdlGxP/rhec2ihQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q8pcA-005dCC-1G;
	Mon, 12 Jun 2023 22:02:18 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q8pc7-005dAc-2i;
	Mon, 12 Jun 2023 22:02:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=zgKyM3Bqye8XIR4cGys6T5IvKp0/wF3iTsg1PUDsTwk=; b=Y16rR33dIo17eKUglGkte8mne/
	brORBd2dJKwxeW3t8hewQ6ydFSl0NJS0Y9Am+QrX6KqsLvhhWK6G9bhehF6jVIvnsiNsW+ysb3gxO
	+GE5r8PXiCzg3D40jk2CCNuXMRWMsz0p3ye8s4o8d5EBFBLhMPwMJ5qOsSq1q/6Kcp8JCCCnOY5Di
	PFxKEjuepbyoLNc2vihgh43Mi1WmT8IwJDN9H4HG8u9GqxWWxHLSGuaCipczmxJ9pcBPQT47Dbmop
	UFAGZxVZoUJD7zeUIxEEiCsAwwseC/jsCRkxb63e6mbHXk9OfmC116NwFXhNYifCoySfmySY4bSr9
	Zs++LuIA==;
Received: from mail-oo1-xc30.google.com ([2607:f8b0:4864:20::c30])
	by desiato.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q8oj1-0090dD-2H;
	Mon, 12 Jun 2023 21:05:22 +0000
Received: by mail-oo1-xc30.google.com with SMTP id 006d021491bc7-558cb7f201cso2777369eaf.2;
        Mon, 12 Jun 2023 14:05:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686603916; x=1689195916;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zgKyM3Bqye8XIR4cGys6T5IvKp0/wF3iTsg1PUDsTwk=;
        b=qq8ATz7qnjhMI4JQRRPl8nQkZZESoSMSYaIpvAm1fkmTP/hhJtK09QthkQIszdY2en
         Np28aEy4Ap8kQZZkxOILcAkOWFCvtD0mksimPr07l40BlBsZAEhYxeqfdjyxkQeqAOW5
         ZTc2r2EYyhW+/Rjr+ix4rQnVYpkl/uEhOS/VFy3JybVwLZGjn5WR2cf2gk8obwo2CXkB
         sGSrhNlSnOkEM+3mRCKt35MlveZfVuGQGd2P1arrL9+IybQt5wlSdODKjPEGV1dnmgeN
         o5s8QyWZIU5taEap5wETL65HSHBQ11HVjiPK1AO1Q4tVycf+rnHrB5djM+QoDLh7ynuT
         05uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686603916; x=1689195916;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zgKyM3Bqye8XIR4cGys6T5IvKp0/wF3iTsg1PUDsTwk=;
        b=de64lxRbq71KGpMRR3waM25nn4qCuKhAiZrHgnGpDCqNSuJNzLkx0h4X88yeEYNW5f
         7vGbm/ZeQRELR8jlqsp7W0uxgeCjBoH1z6G5l4Xi2w0rOo24OJPqDnDlgh3IVnZXtfJ1
         riXRxPal3lTF5IYqvVs42WW8xqWo70KLAfOr6koHMr9umC9zN0jLw8/armeCB6016Bbv
         t3rl7V24Sw+SRpycptGzESZCvTT4YRpSB4RQkbztFLKnOLTILGree5eE8IMMbtod5pGv
         E+r6zEfmUZ2RXF7VQYkyF5nuu3az9slNGOTY9A3g9r0gFmaR29cvEiS7q0sm3ppLmSWM
         hRnw==
X-Gm-Message-State: AC+VfDyX6vQTF5zXdiwQMGRPjAGCfqI7YekLlRcxSv4EY72CHbccQIOk
	hehtQgGJ1WEf9c3zbVYZ/oI=
X-Google-Smtp-Source: ACHHUZ6OvrV5xnmsTMrRhILOepKGCGWLH/CFbB0N6d+Jj1gXGdTSLJ6+yTuiQ99sICG0ABshC/lJaQ==
X-Received: by 2002:a05:6870:955c:b0:1a6:a89b:d8fa with SMTP id v28-20020a056870955c00b001a6a89bd8famr1204093oal.22.1686603916460;
        Mon, 12 Jun 2023 14:05:16 -0700 (PDT)
Received: from unknowna0e70b2ca394.attlocal.net ([2600:1700:2f7d:1800::16])
        by smtp.googlemail.com with ESMTPSA id s125-20020a817783000000b00569eb609458sm2757115ywc.81.2023.06.12.14.05.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 14:05:16 -0700 (PDT)
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
	Dave Hansen <dave.hansen@linux.intel.com>
Subject: [PATCH v4 15/34] x86: Convert various functions to use ptdescs
Date: Mon, 12 Jun 2023 14:04:04 -0700
Message-Id: <20230612210423.18611-16-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230612210423.18611-1-vishal.moola@gmail.com>
References: <20230612210423.18611-1-vishal.moola@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230612_220520_173394_1EF3F6F0 
X-CRM114-Status: GOOD (  14.26  )
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
these to use pagetable_alloc() and ptdesc_address() instead to help
standardize page tables further.

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
---
 arch/x86/mm/pgtable.c | 46 +++++++++++++++++++++++++------------------
 1 file changed, 27 insertions(+), 19 deletions(-)

diff --git a/arch/x86/mm/pgtable.c b/arch/x86/mm/pgtable.c
index 15a8009a4480..6da7fd5d4782 100644
--- a/arch/x86/mm/pgtable.c
+++ b/arch/x86/mm/pgtable.c
@@ -52,7 +52,7 @@ early_param("userpte", setup_userpte);
 
 void ___pte_free_tlb(struct mmu_gather *tlb, struct page *pte)
 {
-	pgtable_pte_page_dtor(pte);
+	pagetable_pte_dtor(page_ptdesc(pte));
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
+	pagetable_pmd_dtor(ptdesc);
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
+			pagetable_pmd_dtor(ptdesc);
+			pagetable_free(ptdesc);
 			mm_dec_nr_pmds(mm);
 		}
 }
@@ -232,16 +235,21 @@ static int preallocate_pmds(struct mm_struct *mm, pmd_t *pmds[], int count)
 		gfp &= ~__GFP_ACCOUNT;
 
 	for (i = 0; i < count; i++) {
-		pmd_t *pmd = (pmd_t *)__get_free_page(gfp);
-		if (!pmd)
+		pmd_t *pmd = NULL;
+		struct ptdesc *ptdesc = pagetable_alloc(gfp, 0);
+
+		if (!ptdesc)
 			failed = true;
-		if (pmd && !pgtable_pmd_page_ctor(virt_to_page(pmd))) {
-			free_page((unsigned long)pmd);
-			pmd = NULL;
+		if (ptdesc && !pagetable_pmd_ctor(ptdesc)) {
+			pagetable_free(ptdesc);
+			ptdesc = NULL;
 			failed = true;
 		}
-		if (pmd)
+		if (ptdesc) {
 			mm_inc_nr_pmds(mm);
+			pmd = ptdesc_address(ptdesc);
+		}
+
 		pmds[i] = pmd;
 	}
 
@@ -830,7 +838,7 @@ int pud_free_pmd_page(pud_t *pud, unsigned long addr)
 
 	free_page((unsigned long)pmd_sv);
 
-	pgtable_pmd_page_dtor(virt_to_page(pmd));
+	pagetable_pmd_dtor(virt_to_ptdesc(pmd));
 	free_page((unsigned long)pmd);
 
 	return 1;
-- 
2.40.1


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
