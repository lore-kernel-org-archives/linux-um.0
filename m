Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 877E1C001B3
	for <linux-um@archiver.kernel.org>; Tue, 27 Jun 2023 03:18:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=FPHoUWQFhUT2NCh2zDxGN+7zS3kaABHZcaicgqb/Euk=; b=0eU16jnzboL1Pk
	UeRJJ9SnILQMf1DL/b+AL8qXuz4y5yVFwD31DWGQck6LNgGpucuIFZL5paBXUlP6tzJ5z6ca7ImHY
	V5XRPeGHodRVi7YXxdNt0XTRddYCWl6d0aBm2PF/EHffx3gaIfebgjzTpDF0ph/oIoTtITGXyjw0n
	GAPTeq2jYIr1kNMNNC+weUbzW5jtuRKO8OwGKVR8zAai9BBErz5JnnTP8mMTR2zB8RWeCn2ZnFw0T
	8PxDKLJbTZxBR2hjTO/1EvpdPaSTa0/2SBdWA89N3zOyH3sZDeS9SRlHJE5o1ih+1pxN+yPk2SvGz
	Nb97wTbsyzkX4RYsQRtQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qDzEA-00BYdb-0X;
	Tue, 27 Jun 2023 03:18:50 +0000
Received: from mail-yw1-x1131.google.com ([2607:f8b0:4864:20::1131])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qDzBN-00BW5N-1o;
	Tue, 27 Jun 2023 03:16:06 +0000
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-5700b15c12fso42626737b3.1;
        Mon, 26 Jun 2023 20:15:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687835756; x=1690427756;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pBiyp2dfMpzV+NvCt1JbKOh6Ic1GEYp83948mVxRzoc=;
        b=lEtqmrwI3pH1F9NhuLSu+lhrJuJBeaNoc0B/a+jtRpylRNiz6lnVYqwXFylSaxIlSS
         fal5MuqlLO46M8tgspmd3hSeZZQkHzVCiF/enKflZ1M3hEbA15QMn0yHyWiDxK+YUgaZ
         GWFcNw4Uez0C21+p6DRUZFT6brtk9p0VoxgHF26jewVOVnyhkSQ3DRQfrpXYXTkzJvdt
         UKT9r8byFkYtRNMun/mKCKgBDEtBv/scAQyWpgjFy69JlQUU0QN5ljLcHnq80rGO/875
         /+CaEkKEPeM1zZ6Ui2wCINBbaXnsdbhwpMR3GV5pLj1s7PximB5Gycu9naEXtrlwl71V
         d+Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687835756; x=1690427756;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pBiyp2dfMpzV+NvCt1JbKOh6Ic1GEYp83948mVxRzoc=;
        b=BJl2tcMeU7MogKY6Env99O4rPqPHbgnjTyoTmbuxJ6u0rn5rVwyiAgzBG3TAQqKe9i
         eigO/XrmAYP0spHCC5wF0z9KM/vyHhg6FLg9Gq4wnddxQjp6nXuwCroES2uZWLWa8n+h
         GRZ/jsxiUELzuo31ByPFmEeF1ONsUiu3qFHHy+5tw6a3Ue0BkOrwqPztef+BjGywZOP7
         52NcrzMU9ClTSOPK5Y+vXCQh3gBRU8LGQr4PRp4g8DsjbzFKUfmSRUEiug1Fy0PLk4F/
         XiL04GZvPQLcw2Y+VrAA78QmTV+J9eahiR9J0d3ujOPLKKVBQrFFnJroXnSNiKes/6S6
         x+rQ==
X-Gm-Message-State: AC+VfDzFUcnzRW2orPiv1tHp97wzmrbs+SlqOzVFtVPrD+vu1l242+rY
	qifHQe6W4mDmNIKpEpr2IGU=
X-Google-Smtp-Source: ACHHUZ6AsPEMPaYNwMvJ9C/uUytKifTWfNOxJlUh8Y26CFwkBAjPl8zEubY5Kzi6Ted2kFoKwje9oQ==
X-Received: by 2002:a0d:e24c:0:b0:56c:fc62:a5a2 with SMTP id l73-20020a0de24c000000b0056cfc62a5a2mr32690358ywe.7.1687835756402;
        Mon, 26 Jun 2023 20:15:56 -0700 (PDT)
Received: from unknowna0e70b2ca394.attlocal.net ([2600:1700:2f7d:1800::16])
        by smtp.googlemail.com with ESMTPSA id s4-20020a0dd004000000b0057399b3bd26sm1614798ywd.33.2023.06.26.20.15.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jun 2023 20:15:56 -0700 (PDT)
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
	Huacai Chen <chenhuacai@kernel.org>,
	Mike Rapoport <rppt@kernel.org>
Subject: [PATCH v6 23/33] loongarch: Convert various functions to use ptdescs
Date: Mon, 26 Jun 2023 20:14:21 -0700
Message-Id: <20230627031431.29653-24-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230627031431.29653-1-vishal.moola@gmail.com>
References: <20230627031431.29653-1-vishal.moola@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230626_201557_636280_E369F0B3 
X-CRM114-Status: GOOD (  13.80  )
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
Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>
---
 arch/loongarch/include/asm/pgalloc.h | 27 +++++++++++++++------------
 arch/loongarch/mm/pgtable.c          |  7 ++++---
 2 files changed, 19 insertions(+), 15 deletions(-)

diff --git a/arch/loongarch/include/asm/pgalloc.h b/arch/loongarch/include/asm/pgalloc.h
index af1d1e4a6965..23f5b1107246 100644
--- a/arch/loongarch/include/asm/pgalloc.h
+++ b/arch/loongarch/include/asm/pgalloc.h
@@ -45,9 +45,9 @@ extern void pagetable_init(void);
 extern pgd_t *pgd_alloc(struct mm_struct *mm);
 
 #define __pte_free_tlb(tlb, pte, address)			\
-do {							\
-	pgtable_pte_page_dtor(pte);			\
-	tlb_remove_page((tlb), pte);			\
+do {								\
+	pagetable_pte_dtor(page_ptdesc(pte));			\
+	tlb_remove_page_ptdesc((tlb), page_ptdesc(pte));	\
 } while (0)
 
 #ifndef __PAGETABLE_PMD_FOLDED
@@ -55,18 +55,18 @@ do {							\
 static inline pmd_t *pmd_alloc_one(struct mm_struct *mm, unsigned long address)
 {
 	pmd_t *pmd;
-	struct page *pg;
+	struct ptdesc *ptdesc;
 
-	pg = alloc_page(GFP_KERNEL_ACCOUNT);
-	if (!pg)
+	ptdesc = pagetable_alloc(GFP_KERNEL_ACCOUNT, 0);
+	if (!ptdesc)
 		return NULL;
 
-	if (!pgtable_pmd_page_ctor(pg)) {
-		__free_page(pg);
+	if (!pagetable_pmd_ctor(ptdesc)) {
+		pagetable_free(ptdesc);
 		return NULL;
 	}
 
-	pmd = (pmd_t *)page_address(pg);
+	pmd = ptdesc_address(ptdesc);
 	pmd_init(pmd);
 	return pmd;
 }
@@ -80,10 +80,13 @@ static inline pmd_t *pmd_alloc_one(struct mm_struct *mm, unsigned long address)
 static inline pud_t *pud_alloc_one(struct mm_struct *mm, unsigned long address)
 {
 	pud_t *pud;
+	struct ptdesc *ptdesc = pagetable_alloc(GFP_KERNEL & ~__GFP_HIGHMEM, 0);
 
-	pud = (pud_t *) __get_free_page(GFP_KERNEL);
-	if (pud)
-		pud_init(pud);
+	if (!ptdesc)
+		return NULL;
+	pud = ptdesc_address(ptdesc);
+
+	pud_init(pud);
 	return pud;
 }
 
diff --git a/arch/loongarch/mm/pgtable.c b/arch/loongarch/mm/pgtable.c
index 36a6dc0148ae..5bd102b51f7c 100644
--- a/arch/loongarch/mm/pgtable.c
+++ b/arch/loongarch/mm/pgtable.c
@@ -11,10 +11,11 @@
 
 pgd_t *pgd_alloc(struct mm_struct *mm)
 {
-	pgd_t *ret, *init;
+	pgd_t *init, *ret = NULL;
+	struct ptdesc *ptdesc = pagetable_alloc(GFP_KERNEL & ~__GFP_HIGHMEM, 0);
 
-	ret = (pgd_t *) __get_free_page(GFP_KERNEL);
-	if (ret) {
+	if (ptdesc) {
+		ret = (pgd_t *)ptdesc_address(ptdesc);
 		init = pgd_offset(&init_mm, 0UL);
 		pgd_init(ret);
 		memcpy(ret + USER_PTRS_PER_PGD, init + USER_PTRS_PER_PGD,
-- 
2.40.1


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
