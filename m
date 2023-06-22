Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDC55EB64DA
	for <linux-um@archiver.kernel.org>; Thu, 22 Jun 2023 21:01:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=pXuy4Vkx5aYEYOq9KEDSHtFOdr+KMGwAk/zEd/nGORk=; b=jub8legufYN0PW
	jUckbWRBlvi/suSrd68OqCsTCSQWX4LHI/uKHgmMrW1hfVOStLW7ZQ0Eh05wyY+V1kUiMRtUPhrvk
	JlrxrrZBjFA5Cxsh58HOOtMYUyocr4amELLnyP9/jiVyxYsvgIQ4Najwo2wtnRvRkltj0i8uUrjdf
	dtLVzALVhPIrs8oTiVJvrW9bgzz3ttiN41f7jlSbSrdCjdBY3cG6HvtAVtZLKFWTdwcN8Yr0ZHcOf
	E77cki8GHEzrC7zdoK1zBxejwZQg6U1/T7HwLcXm88+HnV3uVsBGzhUoLgGm26nffru9D2e2iFAP8
	aj5AlphknUTqQRLY29ZA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qCRQX-001kck-2q;
	Thu, 22 Jun 2023 21:01:13 +0000
Received: from mail-yb1-xb36.google.com ([2607:f8b0:4864:20::b36])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qCRO2-001i6k-0Y;
	Thu, 22 Jun 2023 20:58:41 +0000
Received: by mail-yb1-xb36.google.com with SMTP id 3f1490d57ef6-bf5f41a87ceso4112085276.1;
        Thu, 22 Jun 2023 13:58:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687467517; x=1690059517;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1W6z1I6yvWrQZbHmgHYBEGZZDstSbvELOPET/EcKlKw=;
        b=WzrZfg7Ix9NVgsDMORZZHtKMCnkCtYTNqN5BxfEl0LqJAF/m52D2DjGs1CtMdjlW/Y
         FCQoo6ICOsgfyZao7TI8v6fZI4UENFpY3jZe81s91B3mvmmCsOIgDTDPzHKe5SMRuqNo
         GqmfsZL/fdh4LhL0Jo2UTpv/Zzerp4OFJp5voue8zSTsRJ0/4bzo0POGwXibz4pL7ew3
         XfWPis6drhy3Tn+kW5uEHt9jkm10f1F49xoaZHUD6V/XhEZK2GBId7pwhiwEW8CobjeX
         ndMopKlNsVQQSaeMMfuVNTCC7fSMRAuphXmsb5MG/ItVGni8JlC+amvlrfvw1GK2MkRJ
         BN3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687467517; x=1690059517;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1W6z1I6yvWrQZbHmgHYBEGZZDstSbvELOPET/EcKlKw=;
        b=M295d4+7JznV315G5vvwkdEzVoqaU2cvDFbQEAJEUSSZd3JYaveYehqbaSO82lggVf
         mJNjVv9wu+OWdbCNzSQW1OkWwA4Mbrfl1lobD0OzpZj5abWFouRbaAOY8ux15fedZj3I
         Bt1SYGJClwRq5uuwP2SCKr0bpdOehJRzmB2lJ2dNBWxPNovnR0mPWsxtg8n5MZNbRWmC
         P/uXILkcnGY4Q5QoIaqm+RXAlyMjLtnjAv49aqHXV+wPE0gmqFCWbrxynWxfyX8pUCuJ
         Me3jh0J8x2cS79N++/r456jEZXM8Oc2AwBxYDgnOxnCGSchKDUaDJJG7lMSJ7WpXdbN+
         9tBA==
X-Gm-Message-State: AC+VfDxnfBxG1ISsAeHL93uQJXEpw+EnTXspc0fwbyA//zcY6acXurtB
	WOOJ7wjCH688NhkDeIzBbEE=
X-Google-Smtp-Source: ACHHUZ43E6q8U9GZrhFDLZLO6dXpt9JpmRg2Kg6CKMns06auYc1hxRdgyW9/NyEhButWG+5gdBeMhw==
X-Received: by 2002:a25:b190:0:b0:bd4:8ea4:39bb with SMTP id h16-20020a25b190000000b00bd48ea439bbmr15159544ybj.4.1687467517233;
        Thu, 22 Jun 2023 13:58:37 -0700 (PDT)
Received: from unknowna0e70b2ca394.attlocal.net ([2600:1700:2f7d:1800::36])
        by smtp.googlemail.com with ESMTPSA id d18-20020a5b0c52000000b00bc501a1b062sm1684937ybr.42.2023.06.22.13.58.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jun 2023 13:58:36 -0700 (PDT)
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
	Catalin Marinas <catalin.marinas@arm.com>,
	Mike Rapoport <rppt@kernel.org>
Subject: [PATCH v5 20/33] arm64: Convert various functions to use ptdescs
Date: Thu, 22 Jun 2023 13:57:32 -0700
Message-Id: <20230622205745.79707-21-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230622205745.79707-1-vishal.moola@gmail.com>
References: <20230622205745.79707-1-vishal.moola@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230622_135838_251974_0EDFB923 
X-CRM114-Status: GOOD (  12.12  )
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

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm64/include/asm/tlb.h | 14 ++++++++------
 arch/arm64/mm/mmu.c          |  7 ++++---
 2 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/include/asm/tlb.h b/arch/arm64/include/asm/tlb.h
index c995d1f4594f..2c29239d05c3 100644
--- a/arch/arm64/include/asm/tlb.h
+++ b/arch/arm64/include/asm/tlb.h
@@ -75,18 +75,20 @@ static inline void tlb_flush(struct mmu_gather *tlb)
 static inline void __pte_free_tlb(struct mmu_gather *tlb, pgtable_t pte,
 				  unsigned long addr)
 {
-	pgtable_pte_page_dtor(pte);
-	tlb_remove_table(tlb, pte);
+	struct ptdesc *ptdesc = page_ptdesc(pte);
+
+	pagetable_pte_dtor(ptdesc);
+	tlb_remove_ptdesc(tlb, ptdesc);
 }
 
 #if CONFIG_PGTABLE_LEVELS > 2
 static inline void __pmd_free_tlb(struct mmu_gather *tlb, pmd_t *pmdp,
 				  unsigned long addr)
 {
-	struct page *page = virt_to_page(pmdp);
+	struct ptdesc *ptdesc = virt_to_ptdesc(pmdp);
 
-	pgtable_pmd_page_dtor(page);
-	tlb_remove_table(tlb, page);
+	pagetable_pmd_dtor(ptdesc);
+	tlb_remove_ptdesc(tlb, ptdesc);
 }
 #endif
 
@@ -94,7 +96,7 @@ static inline void __pmd_free_tlb(struct mmu_gather *tlb, pmd_t *pmdp,
 static inline void __pud_free_tlb(struct mmu_gather *tlb, pud_t *pudp,
 				  unsigned long addr)
 {
-	tlb_remove_table(tlb, virt_to_page(pudp));
+	tlb_remove_ptdesc(tlb, virt_to_ptdesc(pudp));
 }
 #endif
 
diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 95d360805f8a..47781bec6171 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -426,6 +426,7 @@ static phys_addr_t __pgd_pgtable_alloc(int shift)
 static phys_addr_t pgd_pgtable_alloc(int shift)
 {
 	phys_addr_t pa = __pgd_pgtable_alloc(shift);
+	struct ptdesc *ptdesc = page_ptdesc(phys_to_page(pa));
 
 	/*
 	 * Call proper page table ctor in case later we need to
@@ -433,12 +434,12 @@ static phys_addr_t pgd_pgtable_alloc(int shift)
 	 * this pre-allocated page table.
 	 *
 	 * We don't select ARCH_ENABLE_SPLIT_PMD_PTLOCK if pmd is
-	 * folded, and if so pgtable_pmd_page_ctor() becomes nop.
+	 * folded, and if so pagetable_pte_ctor() becomes nop.
 	 */
 	if (shift == PAGE_SHIFT)
-		BUG_ON(!pgtable_pte_page_ctor(phys_to_page(pa)));
+		BUG_ON(!pagetable_pte_ctor(ptdesc));
 	else if (shift == PMD_SHIFT)
-		BUG_ON(!pgtable_pmd_page_ctor(phys_to_page(pa)));
+		BUG_ON(!pagetable_pmd_ctor(ptdesc));
 
 	return pa;
 }
-- 
2.40.1


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
