Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FBF6C77B7A
	for <linux-um@archiver.kernel.org>; Wed, 31 May 2023 22:43:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=9QKlHc0FImgyyTcY5r6VRArCAzcxE8nehS67QQ+rp4I=; b=49BzYtrt019M+6
	Nyikd9WEWUOQpjkHIOt6YnwtQ3PMP5m2QWfKP2QZp+mdR/gLq3l3wV+nOXh/9RBcX9EWs1w25ep7Z
	LGgezbWo7nyFP9c4UpuSSBXbi8MsXO+X+52HgqNHC9N835CUn39XdY4yMEIBvx8d9orCIN2O4tR6N
	bUcxLeOdngLZ9YvCsIYCCLYVM6JcnNXsaGbKAUkGYRKev9vxHyeNffpVfPWsMYog1HZDvLbqEsDpI
	5ZgGlWRvr9aFC+Pv/p21gGn4DwjBRORYefMInTxLpdZ3Kbe/wbRzOV2qNs7HZDwqoE8JaPtUexrve
	AthQIIEBIPYAut2qvxrg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q4UXn-001MoH-2f;
	Wed, 31 May 2023 22:43:51 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q4UXA-001MLb-0q;
	Wed, 31 May 2023 22:43:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=CiuD1fnPRO8jyev+m9HAl1NKcgSXjs7PYAEQ9fPxEwI=; b=P2ObPmERcXcxSdcmwX5jHX5432
	9/vkBIwCzoiYeGdI3i0gimu931gEirzD9UItbTpGdLACstSn0nbK/Uv//UWUZEO+4i2vb2yUuwfTA
	Yi16WHWlRwA09vPQUYCbkFMBIZtIjyK6RurP/EsQQyZ9Cb2MJXVhjt6C5kXhYDhY6qYKeSr9qTJu9
	VJE64UIWlQwASHm1VYSw7nK0WjCAhM7PGTGmoMe/MeuH7hNunM+Wh/JiZFhDNa9DvdPdF4e6JPJiK
	kLpuHvPnY0NlGb2VVyCC0gNM0etOaRPkUyxOsPB1AraZ+MT15YMCT+EgL1MV/H2ZTFnvjPWVLrZbs
	c+YVODOQ==;
Received: from mail-yw1-x1135.google.com ([2607:f8b0:4864:20::1135])
	by desiato.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q4TPw-00FdO1-0Z;
	Wed, 31 May 2023 21:31:55 +0000
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-565c7399afaso815247b3.1;
        Wed, 31 May 2023 14:31:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685568699; x=1688160699;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CiuD1fnPRO8jyev+m9HAl1NKcgSXjs7PYAEQ9fPxEwI=;
        b=dwKPCZ9sOqelwYr8F/cSipEa3jHhRdlxXOeKLR/uKctFcyWbknhl7PTpjdfvG2wdAw
         pMFXdWvJKkAwifmK+eF/WF2c+CTwD32ESs3xYPpfMCjwyoVuEtX6esdP6hVyOjImmyUk
         Oh+dQbUYFzz+RNVUajzvmNf19c5I4sagTuDGjtO3TygkKRoR+ykzPoVUyEPrbcpAn52e
         rU0Chmm96Re5mM9CLdg1318OX9ZTyh5zkMgv9dD9FfM+Aps24GBiAtG6k7NQXS+y1kVH
         W5R3JCSdW+dNmMUo9S420mdoMO5JugaoZBL/4nDQ/iinPbgBaddQ0udYo8DlZN/IM0qe
         FbCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685568699; x=1688160699;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CiuD1fnPRO8jyev+m9HAl1NKcgSXjs7PYAEQ9fPxEwI=;
        b=SMRn3QUbmPjDp1850JESZOgyXy6/mKB8E3F7XUtU06CCih9LTZe2RN4bHi5gLApxqY
         BfDBIOA/bXjNE+3ol+gLOBXpmPfE8R8RdxPcbXihuFFAf9vTyyMd38tPpdr2fB83jIVn
         oLKLL1HeQF5vd5ELJFJOuB300MOodxlShAfKr+HTZOhs4/RdU6SYHL3cM25kQ4ZK2WS2
         0J1QgGZYKQLCPZQMUoQiZtbO/Pq6G0VdmE9bDY8SBVYnV6a4HP+9h+jQth2JB4wH8/3Z
         NhEgU+HitecV39cki5tADkKNBcZyG75owYUuQe16+i8xlfOMCpkg2V7FfH8sYS/+uXPg
         f4hg==
X-Gm-Message-State: AC+VfDyyo7JL+4IqiV3d1kShzE+BjjyoyGuUFvWse4sKDabWFDKt4vG5
	cvOBT7uRETu1tKNXlvczcBE=
X-Google-Smtp-Source: ACHHUZ68ZyyZPWIoZr6cEDE/Fc/GjANr19wlevcJlVACZTiXrZelT9pLwANtLCgEsMseNvfv3aa+eg==
X-Received: by 2002:a81:4e8b:0:b0:561:d6dd:bc84 with SMTP id c133-20020a814e8b000000b00561d6ddbc84mr7760695ywb.48.1685568698919;
        Wed, 31 May 2023 14:31:38 -0700 (PDT)
Received: from unknowna0e70b2ca394.attlocal.net ([2600:1700:2f7d:1800::46])
        by smtp.googlemail.com with ESMTPSA id t63-20020a0dd142000000b0055aafcef659sm658905ywd.5.2023.05.31.14.31.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 May 2023 14:31:38 -0700 (PDT)
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
Subject: [PATCH v3 15/34] x86: Convert various functions to use ptdescs
Date: Wed, 31 May 2023 14:30:13 -0700
Message-Id: <20230531213032.25338-16-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230531213032.25338-1-vishal.moola@gmail.com>
References: <20230531213032.25338-1-vishal.moola@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230531_223142_994687_5C1C18E8 
X-CRM114-Status: GOOD (  14.97  )
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
index e4f499eb0f29..79681557fce6 100644
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
+			pmd = (pmd_t *)ptdesc_address(ptdesc);
+		}
+
 		pmds[i] = pmd;
 	}
 
@@ -838,7 +846,7 @@ int pud_free_pmd_page(pud_t *pud, unsigned long addr)
 
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
