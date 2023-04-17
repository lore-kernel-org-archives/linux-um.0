Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA3F9C77B72
	for <linux-um@archiver.kernel.org>; Mon, 17 Apr 2023 21:17:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=bsGYy3zWTDu6jkaGu1PwqiHFos61N+8xSvFuEA9ERsE=; b=mtMVveq3QodShn
	Muridulz05oCUgtrFi5Y5kyX1FLPKwSt4Z9b7DkuyEPUH9bKBeMygTaoB+Lq6YhEHOHz2U8iXQNVG
	3yFB5XRC1f1+2lQ70laH6ITLLcKiJLXryD5TR4tpueAglD1zbc2RCMkJA2RtNBctQYnenmgkT8rpx
	u331w7uJ9kaIlEybLZpYvMIdYln+O8IW+Ekz/Hl/QzcQlEklo+x07EHvbPYsAuZGRYWgRVJ5Peh+I
	0sjMM21qXxzv/fXDojExJSBF3saxEO3DPHlB1yEOF/l1Whshd4BLVTigkRAhDITvyYnx+5nixo2gW
	27FPRci7de7SAAuFE7RA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1poWEJ-0002Ts-1Y;
	Mon, 17 Apr 2023 21:17:43 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1poWE4-0002G2-1y;
	Mon, 17 Apr 2023 21:17:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=/Q5rpHIbLtPdsxzDzaO3buqXOd2yqrT0Z007lfiZkpI=; b=n/LA/cQokHWmMzzwsVGpzCemOE
	q4z7Pq1ZYX6s63Yk1qOGuMWnlzzWgNBnX7lqL7GarUF7wL03LQaH5gtXEQ6RyStjq4dYsdZ5SvnXz
	6jkTiI1DA36g2h1SdmSceppH7G5xxnf88GVI5Nw+LFvVJ4plykNz1lCnJf6TPZVaNAbYfo5mHeHi2
	4eeOCZwq7R6OntQYm7r4wzrVy0XuEpoblSSy9gUJWHJpd55a8uoCWQuLIrLwKo+CdMfknRjaqdQbj
	znvg98EtKouxI3nYXT/xZaJJTjIjIOttGbheB8tQjTyIXL8O44ROgNGnHc+jFYfaR58QRctLgT4Tf
	lkBE9Aiw==;
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
	by casper.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1poVqV-00Bfqv-Us; Mon, 17 Apr 2023 20:53:11 +0000
Received: by mail-pl1-x62e.google.com with SMTP id p8so27387733plk.9;
        Mon, 17 Apr 2023 13:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681764785; x=1684356785;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/Q5rpHIbLtPdsxzDzaO3buqXOd2yqrT0Z007lfiZkpI=;
        b=oN3WN3FaawXE5CF6Cg/W/uIlOgFpp+g16jZXog0VNnI/qtOkBdWsDVehFGMED7dn5+
         e56tIJJLtydkdncbDj6EgMfHci5dsJ/ubCUoN7HG1abvk1Sxq0PSQWiGjWfSNWnYoCUZ
         iexosl+123qGqL0uhQqkt6/lQEj+ZZbGmt11o31Lgc0lv69E3YkAOFWPJgHBPxqW6Hcs
         AY1JBassDB9z9gn7HCEtsHeuw7WKOVmcQJj/XwZLajgpzdXqkSttOF9JB8ZOKpdhpqCp
         KcapkWtUG6onUSGsHkpFKHhWq2wTFC19ykRFpbUoVueZkn9rzc97nSY2du8bEMz2qr3M
         LcZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681764785; x=1684356785;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/Q5rpHIbLtPdsxzDzaO3buqXOd2yqrT0Z007lfiZkpI=;
        b=ARGdjHnYSo1QknWMnquMPf2oNioHWmKX2sOt3cCcUW9l690O01Fi6xScFKA7WUIB57
         Gu4zJ43SjAEB/C4opSgj8A28bpvMERyikdjtJh5TggU3BXJNUb2C7JNaXyj/91Kj4xme
         X49V08X1QZexhUU80630s43RZ6U2isjuANGlvsJdOkRPo00fTv12zQR6zZvhHI7oc1Pg
         t5YekP7YWUphb6xr6oPH8JU732jSYe/mottj2VEFkWAG6mexMHtg8+05NIV8HWCHZgNd
         BcatSFTBIFrpMukvbX7JYJzwN+4VBd3656Yrk1lz6RosvKVaugs4LyJGycCJHJKafAGk
         vMCg==
X-Gm-Message-State: AAQBX9cwnftLTrNxK4rRyR5ze5OPL3lwf//foAsXws+t/YNP3qmn7HJy
	TcbNVhRhiUFKwRDrSkVzu/E=
X-Google-Smtp-Source: AKy350bQu6z/qcpmnOWvPCYz19t9kGfi+ogJbAChD8E648rYRlxNxJTxaR2oZuddVpCSFFn5irXClA==
X-Received: by 2002:a17:90b:4d81:b0:240:7f0d:9232 with SMTP id oj1-20020a17090b4d8100b002407f0d9232mr16482647pjb.3.1681764785136;
        Mon, 17 Apr 2023 13:53:05 -0700 (PDT)
Received: from fedora.hsd1.ca.comcast.net ([2601:644:937f:7f20::c139])
        by smtp.googlemail.com with ESMTPSA id h7-20020a17090ac38700b0022335f1dae2sm7609707pjt.22.2023.04.17.13.53.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Apr 2023 13:53:04 -0700 (PDT)
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
Subject: [PATCH 14/33] x86: Convert various functions to use ptdescs
Date: Mon, 17 Apr 2023 13:50:29 -0700
Message-Id: <20230417205048.15870-15-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230417205048.15870-1-vishal.moola@gmail.com>
References: <20230417205048.15870-1-vishal.moola@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230417_215308_008320_AD94A22B 
X-CRM114-Status: GOOD (  13.08  )
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
