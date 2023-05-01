Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B864AC77B7C
	for <linux-um@archiver.kernel.org>; Mon,  1 May 2023 19:47:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=64MmdFbEUKUM0ZpiqvPoaThvzBtl36mdks0hkDFts1U=; b=aJzKeKeD2XOC2m
	sfh57cZhbjJBaKBvjmBJDpWdcE8bNiJ1BsTEHH9XHZnA5fRyiGVfg4WbNGPbaxKaU17NR3AMN4zie
	dhzwql/Vb9xDnChZpVUSM5QmulXnSMsrBedVousADIsZ67xieEJQ7ZQ/D8DsZM9Kp936/Y9iHHI1u
	U+QR936hZtL+seRRxKXVSZNCkJrnOVLF80z207uDEj/impCwYZIMeFCQShb1TC+B/v57f1NvbDzME
	MheYkG7kH++yrzJH8/OmsnN24LGm6gQPsxvamijPcxsxZIJiPhels1wka/EJiPzamdOO9zec/BKk+
	FdsJW101+xBpiG1yqUoA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1ptZUp-00GlQ0-0l;
	Mon, 01 May 2023 19:47:39 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1ptZUc-00GlDP-1Z;
	Mon, 01 May 2023 19:47:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=4OtNgWOkZ3LfZLHJ8GzTdJkHLxMJcmtHKM1yrsNlf/Q=; b=p/L4k8JmLLbV/QgmCzjS6lQXSX
	dr5eugv4J0U2SR/S31COhtGBHDon4y2D2sw8GpBSjoDb7MmL628azT3gW+nQt0Ex9LDDrAKz91c8a
	6asnRsNNYLyINPcl67mMqND6uP59r8oDrmr3jKHprP3dXlZmmnwgWcvmR+gjNBqYSSS5jzlXtvx+O
	vk+ekG8dEnFZ2Zy+/fDFZFlMhxW74twOBYOKF/JK1HSTM16UxxKHznmsBNM5gGHLwuY5CJeEbxJ9n
	IU1hXdJr3gIU9QVYfrcyeZApyLBOel+T7rtJC9+TxitvRAuDiDPG90prThD/ZbxHRBj38j84wCK0x
	oKXyB72Q==;
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
	by casper.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ptZCz-007cu6-DK; Mon, 01 May 2023 19:29:15 +0000
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1aaf70676b6so9592355ad.3;
        Mon, 01 May 2023 12:29:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682969350; x=1685561350;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4OtNgWOkZ3LfZLHJ8GzTdJkHLxMJcmtHKM1yrsNlf/Q=;
        b=Z7q9x2Xo+R2VkP+SAoL4No5SPSbkqDSqv1O/IrhmxSJUfCVapYFLSqvpVv77DdaaNp
         7xLFfeVlS+/Z0T5loFjBwxXBtJMOL0SomvnLpxrMgUE0H3Z2NwMVPWqjWZZaWw/Xtz9H
         bXhAt7jaDl6TAQEvatyLSYOokashb8FOV+mCaWLsgTEKm8FhtMTj/edGzjuLKaTQnJVx
         0eZhRzcKCCgmZxOyeAj8qE7Nk7KdCTP6wyrMnmtMZ4gp104XnMq6z3YcmLmYurGQiyUb
         qQCTGhNGKLl+87vhFPVut1PJmPE/0ePjlrtCLEgAAJx+RTgFbaFyPCMZ3prXkkSGna7E
         KEcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682969350; x=1685561350;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4OtNgWOkZ3LfZLHJ8GzTdJkHLxMJcmtHKM1yrsNlf/Q=;
        b=WntBPa0+Kyf13+iMnkoOY8BrOacDaFAVt2QZKHVtm2RVpgnV9HemsONPrUc0f+8dNl
         1KbEjW6S8il1LQnbwgGm70BmG7T0vd1ayKqYCQEPJr0a6nNxp80k+AzTcwllOmg2LHwm
         eydg8XTLbzhto18GjPPqvVHC+r7pciN5QWPXM2MXcHgLy15bdqRAs4MCP8jnSGloFacw
         zqKydrTVNpsIe1cBw3LOrMTbjZl2N2OcQdDcfwPqf4aHBmEdt/8cKGMqwxVZ362YWxq9
         sUnlV5jguI/5XeXNPtFBlz2gCnUnIsM+FPIAClNwDvYysgz6PidI87C1XX46GHJnywYk
         Rw9w==
X-Gm-Message-State: AC+VfDx7sSztHGLRm39TK1wzKEoj7VAWgw9UqAP+d7lVtaINbJLmXHpR
	xu3ljyetOr7Prw76zsSAOOc=
X-Google-Smtp-Source: ACHHUZ6ZQG7EefBUYeumgjpKENexw5lTdMP6ZEhxCncdw/ecXlC+vhc9H9rF3r/Lw9bkiQ71uazgBQ==
X-Received: by 2002:a17:902:a516:b0:1a6:6b9d:5e0f with SMTP id s22-20020a170902a51600b001a66b9d5e0fmr14561274plq.17.1682969350547;
        Mon, 01 May 2023 12:29:10 -0700 (PDT)
Received: from fedora.hsd1.ca.comcast.net ([2601:644:937f:7f20::9a2c])
        by smtp.googlemail.com with ESMTPSA id u8-20020a170902bf4800b0019c13d032d8sm18175622pls.253.2023.05.01.12.29.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 May 2023 12:29:10 -0700 (PDT)
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
	Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH v2 25/34] m68k: Convert various functions to use ptdescs
Date: Mon,  1 May 2023 12:28:20 -0700
Message-Id: <20230501192829.17086-26-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230501192829.17086-1-vishal.moola@gmail.com>
References: <20230501192829.17086-1-vishal.moola@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230501_202913_495417_756BC260 
X-CRM114-Status: GOOD (  14.81  )
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
these to use ptdesc_alloc() and ptdesc_address() instead to help
standardize page tables further.

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
---
 arch/m68k/include/asm/mcf_pgalloc.h  | 41 ++++++++++++++--------------
 arch/m68k/include/asm/sun3_pgalloc.h |  8 +++---
 arch/m68k/mm/motorola.c              |  4 +--
 3 files changed, 27 insertions(+), 26 deletions(-)

diff --git a/arch/m68k/include/asm/mcf_pgalloc.h b/arch/m68k/include/asm/mcf_pgalloc.h
index 5c2c0a864524..b0e909e23e14 100644
--- a/arch/m68k/include/asm/mcf_pgalloc.h
+++ b/arch/m68k/include/asm/mcf_pgalloc.h
@@ -7,20 +7,19 @@
 
 extern inline void pte_free_kernel(struct mm_struct *mm, pte_t *pte)
 {
-	free_page((unsigned long) pte);
+	ptdesc_free(virt_to_ptdesc(pte));
 }
 
 extern const char bad_pmd_string[];
 
 extern inline pte_t *pte_alloc_one_kernel(struct mm_struct *mm)
 {
-	unsigned long page = __get_free_page(GFP_DMA);
+	struct ptdesc *ptdesc = ptdesc_alloc(GFP_DMA | __GFP_ZERO, 0);
 
-	if (!page)
+	if (!ptdesc)
 		return NULL;
 
-	memset((void *)page, 0, PAGE_SIZE);
-	return (pte_t *) (page);
+	return (pte_t *) (ptdesc_address(ptdesc));
 }
 
 extern inline pmd_t *pmd_alloc_kernel(pgd_t *pgd, unsigned long address)
@@ -35,36 +34,36 @@ extern inline pmd_t *pmd_alloc_kernel(pgd_t *pgd, unsigned long address)
 static inline void __pte_free_tlb(struct mmu_gather *tlb, pgtable_t pgtable,
 				  unsigned long address)
 {
-	struct page *page = virt_to_page(pgtable);
+	struct ptdesc *ptdesc = virt_to_ptdesc(pgtable);
 
-	pgtable_pte_page_dtor(page);
-	__free_page(page);
+	ptdesc_pte_dtor(ptdesc);
+	ptdesc_free(ptdesc);
 }
 
 static inline pgtable_t pte_alloc_one(struct mm_struct *mm)
 {
-	struct page *page = alloc_pages(GFP_DMA, 0);
+	struct ptdesc *ptdesc = ptdesc_alloc(GFP_DMA, 0);
 	pte_t *pte;
 
-	if (!page)
+	if (!ptdesc)
 		return NULL;
-	if (!pgtable_pte_page_ctor(page)) {
-		__free_page(page);
+	if (!ptdesc_pte_ctor(ptdesc)) {
+		ptdesc_free(ptdesc);
 		return NULL;
 	}
 
-	pte = page_address(page);
-	clear_page(pte);
+	pte = ptdesc_address(ptdesc);
+	ptdesc_clear(pte);
 
 	return pte;
 }
 
 static inline void pte_free(struct mm_struct *mm, pgtable_t pgtable)
 {
-	struct page *page = virt_to_page(pgtable);
+	struct ptdesc *ptdesc = virt_to_ptdesc(ptdesc);
 
-	pgtable_pte_page_dtor(page);
-	__free_page(page);
+	ptdesc_pte_dtor(ptdesc);
+	ptdesc_free(ptdesc);
 }
 
 /*
@@ -75,16 +74,18 @@ static inline void pte_free(struct mm_struct *mm, pgtable_t pgtable)
 
 static inline void pgd_free(struct mm_struct *mm, pgd_t *pgd)
 {
-	free_page((unsigned long) pgd);
+	ptdesc_free(virt_to_ptdesc(pgd));
 }
 
 static inline pgd_t *pgd_alloc(struct mm_struct *mm)
 {
 	pgd_t *new_pgd;
+	struct ptdesc *ptdesc = ptdesc_alloc(GFP_DMA | GFP_NOWARN, 0);
 
-	new_pgd = (pgd_t *)__get_free_page(GFP_DMA | __GFP_NOWARN);
-	if (!new_pgd)
+	if (!ptdesc)
 		return NULL;
+	new_pgd = (pgd_t *) ptdesc_address(ptdesc);
+
 	memcpy(new_pgd, swapper_pg_dir, PTRS_PER_PGD * sizeof(pgd_t));
 	memset(new_pgd, 0, PAGE_OFFSET >> PGDIR_SHIFT);
 	return new_pgd;
diff --git a/arch/m68k/include/asm/sun3_pgalloc.h b/arch/m68k/include/asm/sun3_pgalloc.h
index 198036aff519..013d375fc239 100644
--- a/arch/m68k/include/asm/sun3_pgalloc.h
+++ b/arch/m68k/include/asm/sun3_pgalloc.h
@@ -17,10 +17,10 @@
 
 extern const char bad_pmd_string[];
 
-#define __pte_free_tlb(tlb,pte,addr)			\
-do {							\
-	pgtable_pte_page_dtor(pte);			\
-	tlb_remove_page((tlb), pte);			\
+#define __pte_free_tlb(tlb, pte, addr)				\
+do {								\
+	ptdesc_pte_dtor(page_ptdesc(pte));			\
+	tlb_remove_page_ptdesc((tlb), page_ptdesc(pte));	\
 } while (0)
 
 static inline void pmd_populate_kernel(struct mm_struct *mm, pmd_t *pmd, pte_t *pte)
diff --git a/arch/m68k/mm/motorola.c b/arch/m68k/mm/motorola.c
index 911301224078..f7adb86b37fb 100644
--- a/arch/m68k/mm/motorola.c
+++ b/arch/m68k/mm/motorola.c
@@ -161,7 +161,7 @@ void *get_pointer_table(int type)
 			 * m68k doesn't have SPLIT_PTE_PTLOCKS for not having
 			 * SMP.
 			 */
-			pgtable_pte_page_ctor(virt_to_page(page));
+			ptdesc_pte_ctor(virt_to_ptdesc(page));
 		}
 
 		mmu_page_ctor(page);
@@ -201,7 +201,7 @@ int free_pointer_table(void *table, int type)
 		list_del(dp);
 		mmu_page_dtor((void *)page);
 		if (type == TABLE_PTE)
-			pgtable_pte_page_dtor(virt_to_page(page));
+			ptdesc_pte_dtor(virt_to_ptdesc((void *)page));
 		free_page (page);
 		return 1;
 	} else if (ptable_list[type].next != dp) {
-- 
2.39.2


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
