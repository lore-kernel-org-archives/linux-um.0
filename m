Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FA86C7EE43
	for <linux-um@archiver.kernel.org>; Mon, 12 Jun 2023 21:07:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=IN6Jzti0HwbPQhsJtQZIc8wNE/Kkot4ZMFBdw0p9Q/Q=; b=BfW/kWna1Yj9+P
	T99c4i8zAJVzEIgfKX36K4ikp8YqNb/bmEv60lE5NUuPiYagfUrH4gaM/pNkEdYrWmy+2Nua+NQPQ
	NO+UuGhCZPc2jwDMTYhslmZenMx0CDAtee9a45SgCCPgsIajQFxt12xJjvITy/6AFnyqwhOljXFDh
	8EcATeDfAkfXf3XU2fjjuC7P8zhUb08PLiayO0pTBBhl9qQrTOLwdRk7MLE0Gs65H1iRtzfqGuucP
	IKvdJCqSokRzmyDSBsjBdNOPmoyWB4jMuojD9FQukVibG7uSC+A539mIFvAlRJL56/jWyIBWHKoFa
	MS6saOXBodQK9Hjiy5xA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q8oke-005PDX-2K;
	Mon, 12 Jun 2023 21:07:00 +0000
Received: from mail-yw1-x1135.google.com ([2607:f8b0:4864:20::1135])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q8ojI-005NfN-1U;
	Mon, 12 Jun 2023 21:05:39 +0000
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-56d2b950447so15930757b3.2;
        Mon, 12 Jun 2023 14:05:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686603935; x=1689195935;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KVp6CEv5MRUGdp+2H8Cti9WenGhaFTTbvrfHRtAH9kc=;
        b=SoTIqHuLCAWfEiaWrP9H5RMeBUfw/4blxWiNTbN+EgENMXgximV8iyAXgGOp4XDuw0
         D58PnjKgFper5JHCNJspm8td1YpFLE0wlV4KRGzp+/fPbBvQvEKYiEzI6FQgDegSQMJA
         W98fOojhxmIMYwSI3q765OUKGKExSDNbpRlItg5xCIvhjN0428xf4HNUJQQ5P+6zPMLU
         Ma3chacqOtGRi3R200/qVHAxMt5ARo9Z4Ra2qg/4Z+GPUMiMBJG7HmJrnWozDqrgtVLb
         PcdJ9jNUuMMACxveQJzaFtzM2eOsEwEww1xM2Q56gVCjb83OZCynZYnfeNSiDloj+NNW
         ogTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686603935; x=1689195935;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KVp6CEv5MRUGdp+2H8Cti9WenGhaFTTbvrfHRtAH9kc=;
        b=LtBVBH/Si7RhsUnef+Wm/2SclMvOU3WJ9/nnN/SLGe9QBQpDEQMbiqRFgNTZOtLpcY
         7/FijytBlR/KNGwLGi/fnX9EaMo3x6h5Mqjw36h5AJX+qzJX6ik+K+g/sjGK4qosBaDP
         Q6qvHK7MLrDM7vgFBjG2lwGtd8Umcp3x5FuxERgHutCAw/s9t5arW1HCprTx35Og48Sz
         8J+ppvotxIzeBoq4MSmGcaG00pg6eDOyQ9hn2qmxRL2JKPujschEEjV62417XmL7Jtke
         YV7qx/pTISiUdhT2/a2gkyf2re+acssW4mllsbewpZU3YYnaX694Ww7UcNuku/hciAgP
         5MEw==
X-Gm-Message-State: AC+VfDzPB8mPEJmhDGQIvUpXn/jkTyuRmcwIr737svx/SEu0OvJs70cI
	jeCL0Ggei1X2byr1dFUv384=
X-Google-Smtp-Source: ACHHUZ67Z3iEzfMJBv1FKsvF9wmF9wb7PLhtVh2H16srVVINddDnAoJ1jY9AaH4fP20t9BaRYfthGg==
X-Received: by 2002:a0d:c7c7:0:b0:568:b10a:e430 with SMTP id j190-20020a0dc7c7000000b00568b10ae430mr10170669ywd.25.1686603934783;
        Mon, 12 Jun 2023 14:05:34 -0700 (PDT)
Received: from unknowna0e70b2ca394.attlocal.net ([2600:1700:2f7d:1800::16])
        by smtp.googlemail.com with ESMTPSA id s125-20020a817783000000b00569eb609458sm2757115ywc.81.2023.06.12.14.05.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 14:05:34 -0700 (PDT)
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
	Huacai Chen <chenhuacai@kernel.org>
Subject: [PATCH v4 24/34] loongarch: Convert various functions to use ptdescs
Date: Mon, 12 Jun 2023 14:04:13 -0700
Message-Id: <20230612210423.18611-25-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230612210423.18611-1-vishal.moola@gmail.com>
References: <20230612210423.18611-1-vishal.moola@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230612_140536_522762_A4E4D0DE 
X-CRM114-Status: GOOD (  13.52  )
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
 arch/loongarch/include/asm/pgalloc.h | 27 +++++++++++++++------------
 arch/loongarch/mm/pgtable.c          |  7 ++++---
 2 files changed, 19 insertions(+), 15 deletions(-)

diff --git a/arch/loongarch/include/asm/pgalloc.h b/arch/loongarch/include/asm/pgalloc.h
index af1d1e4a6965..70bb3bdd201e 100644
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
+	struct ptdesc *ptdesc = pagetable_alloc(GFP_KERNEL, 0);
 
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
index 36a6dc0148ae..cdba10ffc0df 100644
--- a/arch/loongarch/mm/pgtable.c
+++ b/arch/loongarch/mm/pgtable.c
@@ -11,10 +11,11 @@
 
 pgd_t *pgd_alloc(struct mm_struct *mm)
 {
-	pgd_t *ret, *init;
+	pgd_t *init, *ret = NULL;
+	struct ptdesc *ptdesc = pagetable_alloc(GFP_KERNEL, 0);
 
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
