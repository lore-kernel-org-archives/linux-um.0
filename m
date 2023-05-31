Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F5E8C77B73
	for <linux-um@archiver.kernel.org>; Wed, 31 May 2023 21:54:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=FR4Zi9tGvBFecUAGpmzthwcOK+N74K3ssfRcbAiWYRc=; b=MH72k9FHdujo+T
	JSbdtgc1YuxsctwJ9BmlzAUF+qpJhaAG8X1XBpXwFijHMM6phh38MXu4UPePc+jwmtZUHqfrQjD6q
	G6rAq9b0kTlZcq4uy7BnmBC0sqa8qW6l9oOCGypxpF7jdHfg9fIMRx0wiWtNfD47QOR6vJy8CUwa0
	9g7RM6iEgyzn1czc+8LyxHGBcQlr7dBsaiRcT8QoPJgjv6se4noXlFbStOJTon87p3dHqs7gsWK5U
	u1JWkmRtU0qQofuGhoTBhxt5IBdP93Zm9pHO2HQbuyd8RRp23n82lD12j4CPepMrqB6hVs4nLygM2
	AF7/ZFZ3JxfaoAU6sk7A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q4TmG-001Eg2-0P;
	Wed, 31 May 2023 21:54:44 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q4TmA-001EaC-09;
	Wed, 31 May 2023 21:54:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=BVDfvhMIj7WJxaEIn3M83QWohhaKgCSnIk9ScAfRPU4=; b=WZFfRH1ROprrQZBCp4s/v9+EBG
	3gh/tzK8qxJwJJ/uGYutlemmEiNTovURbgKOyGdb5YGjaxrylV0jOYxtTQrfKuo2CPNa0pVRKlVBN
	KSepUemooG9gxIPNwoWlqlw8XyN6z8Mj1A6fg3CRXxFx0iZe9H+lupquTYhyt6NskhfMTkHv3lvFF
	Le085fATXirP/WofhZHb/rFlEe7E4hhUCLlbbt1cvikfOxsueW/3Xm8m2U7vSwBu5zSqCBiOPwnr/
	R3sZIsBFTQehZBpzNiBJ0b/UJVISWOBBuYaIDmbXJkUyWj0zsIld067PfAUvo0wvL4mLs0N2odBAd
	ZVjUx0BA==;
Received: from mail-yw1-x1131.google.com ([2607:f8b0:4864:20::1131])
	by casper.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1q4TQI-007foV-I5; Wed, 31 May 2023 21:32:04 +0000
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-565a022ef06so766697b3.3;
        Wed, 31 May 2023 14:32:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685568721; x=1688160721;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BVDfvhMIj7WJxaEIn3M83QWohhaKgCSnIk9ScAfRPU4=;
        b=sZVMueiD/ZRZMwtJ1uBmpVp21br88K7Ts0BJnaG9K42MiUpWTkvlqtGrjbXbMcnnig
         ltism/PzSzsT+R/to8b3yQRLDRn38PbBDdqNHRciyJGDmOy9mh7D1lXAJvcHy0PMN5jp
         su04PaNazxgOqRipoXzoczHkJmES+frsRN0f23ykUUyQqSuCIK+AAi0RHbkHHQVi5qyL
         3FwLmSeStb28bpTQ1/hpnTMSIeCoZ802rEkgE91uQZODe47s5OoFtBuE2chhEZiF5V8U
         obYLBCRSZ+tlt5wA8er/wOg+Jr+QyZpX7NHf8eGMHCX/qwho850Ox9fTY+JInMAzI852
         Fi7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685568721; x=1688160721;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BVDfvhMIj7WJxaEIn3M83QWohhaKgCSnIk9ScAfRPU4=;
        b=gnEiwRrkaYzpeLZ+xChoFlZHIaQ3R+ZdRp3OG4OQN9DduMzknTGn2Sfz9yzOVBp0RI
         HAmQ15gElJ1XRD4O9ZCTxIeGor4QqdFnii7zaYPIjyZZ+B4B9c+NeQz2uW0J7aDhUluV
         ICLOVOKizThrOhkevRHqKFA0D2v+RDg2cZl7Zkaby1hdc7KFNCj5BnU7gpaeF4xJMx7R
         qsZbBLGctimnVJE6kky2OsBjt3+7g2kdpc3gCusMQQm9Yk5pnEh8JnPvD1x0FlPW+5k/
         1kMrvIIXciL0q1m+SXG4L49fwJQ9OQ2lGaY4v0kPahJZu/RZ0zwtRtqedqfi3iMSYTgU
         GNAw==
X-Gm-Message-State: AC+VfDwnGnRrlpSDk9VumNNQheFKtIqHtgAdyK46YvhGxcAdtf9xI3T8
	Vln7HkQEWNfIY6PJkPLSHIY=
X-Google-Smtp-Source: ACHHUZ5JiP1u+Csf8JFW+4lOHEoJa4kJJO4bSkCJf3taGF1GbHqDT+hHsEbp8gGuVkWnLydQNajjtA==
X-Received: by 2002:a0d:cc47:0:b0:568:e7e6:4199 with SMTP id o68-20020a0dcc47000000b00568e7e64199mr4171591ywd.6.1685568720746;
        Wed, 31 May 2023 14:32:00 -0700 (PDT)
Received: from unknowna0e70b2ca394.attlocal.net ([2600:1700:2f7d:1800::46])
        by smtp.googlemail.com with ESMTPSA id t63-20020a0dd142000000b0055aafcef659sm658905ywd.5.2023.05.31.14.31.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 May 2023 14:32:00 -0700 (PDT)
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
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Subject: [PATCH v3 26/34] mips: Convert various functions to use ptdescs
Date: Wed, 31 May 2023 14:30:24 -0700
Message-Id: <20230531213032.25338-27-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230531213032.25338-1-vishal.moola@gmail.com>
References: <20230531213032.25338-1-vishal.moola@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230531_223202_630948_FD92E156 
X-CRM114-Status: GOOD (  13.40  )
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

As part of the conversions to replace pgtable constructor/destructors with
ptdesc equivalents, convert various page table functions to use ptdescs.

Some of the functions use the *get*page*() helper functions. Convert
these to use pagetable_alloc() and ptdesc_address() instead to help
standardize page tables further.

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
---
 arch/mips/include/asm/pgalloc.h | 31 +++++++++++++++++--------------
 arch/mips/mm/pgtable.c          |  7 ++++---
 2 files changed, 21 insertions(+), 17 deletions(-)

diff --git a/arch/mips/include/asm/pgalloc.h b/arch/mips/include/asm/pgalloc.h
index f72e737dda21..3ba1fdb06502 100644
--- a/arch/mips/include/asm/pgalloc.h
+++ b/arch/mips/include/asm/pgalloc.h
@@ -51,13 +51,13 @@ extern pgd_t *pgd_alloc(struct mm_struct *mm);
 
 static inline void pgd_free(struct mm_struct *mm, pgd_t *pgd)
 {
-	free_pages((unsigned long)pgd, PGD_TABLE_ORDER);
+	pagetable_free(virt_to_ptdesc(pgd));
 }
 
-#define __pte_free_tlb(tlb,pte,address)			\
-do {							\
-	pgtable_pte_page_dtor(pte);			\
-	tlb_remove_page((tlb), pte);			\
+#define __pte_free_tlb(tlb, pte, address)			\
+do {								\
+	pagetable_pte_dtor(page_ptdesc(pte));			\
+	tlb_remove_page_ptdesc((tlb), page_ptdesc(pte));	\
 } while (0)
 
 #ifndef __PAGETABLE_PMD_FOLDED
@@ -65,18 +65,18 @@ do {							\
 static inline pmd_t *pmd_alloc_one(struct mm_struct *mm, unsigned long address)
 {
 	pmd_t *pmd;
-	struct page *pg;
+	struct ptdesc *ptdesc;
 
-	pg = alloc_pages(GFP_KERNEL_ACCOUNT, PMD_TABLE_ORDER);
-	if (!pg)
+	ptdesc = pagetable_alloc(GFP_KERNEL_ACCOUNT, PMD_TABLE_ORDER);
+	if (!ptdesc)
 		return NULL;
 
-	if (!pgtable_pmd_page_ctor(pg)) {
-		__free_pages(pg, PMD_TABLE_ORDER);
+	if (!pagetable_pmd_ctor(ptdesc)) {
+		pagetable_free(ptdesc);
 		return NULL;
 	}
 
-	pmd = (pmd_t *)page_address(pg);
+	pmd = (pmd_t *)ptdesc_address(ptdesc);
 	pmd_init(pmd);
 	return pmd;
 }
@@ -90,10 +90,13 @@ static inline pmd_t *pmd_alloc_one(struct mm_struct *mm, unsigned long address)
 static inline pud_t *pud_alloc_one(struct mm_struct *mm, unsigned long address)
 {
 	pud_t *pud;
+	struct ptdesc *ptdesc = pagetable_alloc(GFP_KERNEL, PUD_TABLE_ORDER);
 
-	pud = (pud_t *) __get_free_pages(GFP_KERNEL, PUD_TABLE_ORDER);
-	if (pud)
-		pud_init(pud);
+	if (!ptdesc)
+		return NULL;
+	pud = (pud_t *)ptdesc_address(ptdesc);
+
+	pud_init(pud);
 	return pud;
 }
 
diff --git a/arch/mips/mm/pgtable.c b/arch/mips/mm/pgtable.c
index b13314be5d0e..6be3493d7722 100644
--- a/arch/mips/mm/pgtable.c
+++ b/arch/mips/mm/pgtable.c
@@ -10,10 +10,11 @@
 
 pgd_t *pgd_alloc(struct mm_struct *mm)
 {
-	pgd_t *ret, *init;
+	pgd_t *init, *ret = NULL;
+	struct ptdesc *ptdesc = pagetable_alloc(GFP_KERNEL, PGD_TABLE_ORDER);
 
-	ret = (pgd_t *) __get_free_pages(GFP_KERNEL, PGD_TABLE_ORDER);
-	if (ret) {
+	if (ptdesc) {
+		ret = (pgd_t *) ptdesc_address(ptdesc);
 		init = pgd_offset(&init_mm, 0UL);
 		pgd_init(ret);
 		memcpy(ret + USER_PTRS_PER_PGD, init + USER_PTRS_PER_PGD,
-- 
2.40.1


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
