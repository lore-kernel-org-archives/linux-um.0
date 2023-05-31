Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCE56C7EE37
	for <linux-um@archiver.kernel.org>; Wed, 31 May 2023 21:32:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=oFnaNFHdpKgOUjNCH2f8Kz/fw0QKwOBeW4kbSvGMzOU=; b=fML9CkyVqNzJ8C
	aQJAliRNfBEcdksfBdziKcILgMxH2tQ9CT8KmSoyjSa+D8oIFz9yt3b/EsdEuwvb8MO/+zEKQXDEn
	PwYQx4b+231rk4S14l8SugwL9+ELObUwgSulxgP6VhghaG9vly3EXfrpTvU7183GsP+HYf/oM31zU
	FoIIor2+TJ5nffFsecmVzF5fd480lTfYl6IwKq/w5Al+9Oeeoaw7TMAXrSRgLoG1t5Q0g+i8rZghq
	PnZG2r5Rh22Y/SMqBa5tyND9xgCNUxlsowWk+NKdHNS9B55sr86JdBfC969pDTtDk7m0SHjBZbeV9
	2WsmSXLER35IVZsb9mMg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q4TQx-001Ale-12;
	Wed, 31 May 2023 21:32:43 +0000
Received: from mail-yw1-x1130.google.com ([2607:f8b0:4864:20::1130])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q4TQ7-001AMd-2e;
	Wed, 31 May 2023 21:31:53 +0000
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-565c7399afaso817737b3.1;
        Wed, 31 May 2023 14:31:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685568711; x=1688160711;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zsW7mi3+X2fEN/3x0Bi+dafPb2wVjOjUR4AWbTKXMQ0=;
        b=Tua91nOZKux2LUG/1azHCwE0BQP0Ldt/fQcFBTr5Gs9SOVOAK3kiOZTEPbQOZmmRiy
         L/C7DDzaEAD4TJ/PsqDB9bGQgfNVr/qmpDxDu1T3P6Y99drNSm3ToAIDJ8f5x/21uNZG
         pUUOD8Jgv7j2nU4xiGagK626SEPu0aHoPwTImFxvzDIuYjYtXajoHjgtFk6Zd3V/pyaG
         gLJRnJdAK4YFiObBQEli6ODKvc3njLqcTrHFtBx9NqeTVuEeD5M63vdNUsRurBLkb0LY
         QIMgkM/02UNDYBO6osQY211nPQYZamIZAFPQkpE3fQYXReywR2/8RCOtWf6rdMhBO40D
         9r3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685568711; x=1688160711;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zsW7mi3+X2fEN/3x0Bi+dafPb2wVjOjUR4AWbTKXMQ0=;
        b=B8O+akblYkjdaidOUmz6muXdBdZb/Z1wEpN2iLz+B8Bc2vq3LFLpReDH4UutGBd3lx
         gshJgGtNeJQVOjwifvjpwXaPEGqn9O2BWNqtLNAjn7ql3KQ3nemPBxKTDZwNF14Soo0d
         +NTyovpzjjpsrk8P4dPO6mpVvxZ82yBBjpiJ5cVlJEc+5reeVQt2oNLGWlCC6Qizkz17
         pNFKwKNE9KuKrSQNeKpkz/RGSinxix5o3aGhphg2wO1lTDnEaxMZ943aS42/ZllO4cAl
         L4a0M1wd0qdLOXKv0iIdA8g0aMFZP+7xzWejDiePfuChLAGuXXYMaYs/cV/axMx5roXv
         FVqA==
X-Gm-Message-State: AC+VfDyzbsgXBv9PACruCJ4YKnuHH8qQG0L5DHwpaSYFvQMHYhEoZQfY
	4hGHk5AbQqhX0zt4kNeo/ZI=
X-Google-Smtp-Source: ACHHUZ4VOBb0iwQHMeqwI/gDAzuoarhqz29K6pjaMDJD1aWt+PGt8CSoTG+XJl4l0eUyTigEUM/N5g==
X-Received: by 2002:a0d:dc83:0:b0:567:c388:3552 with SMTP id f125-20020a0ddc83000000b00567c3883552mr7998210ywe.6.1685568710976;
        Wed, 31 May 2023 14:31:50 -0700 (PDT)
Received: from unknowna0e70b2ca394.attlocal.net ([2600:1700:2f7d:1800::46])
        by smtp.googlemail.com with ESMTPSA id t63-20020a0dd142000000b0055aafcef659sm658905ywd.5.2023.05.31.14.31.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 May 2023 14:31:50 -0700 (PDT)
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
	Catalin Marinas <catalin.marinas@arm.com>
Subject: [PATCH v3 21/34] arm64: Convert various functions to use ptdescs
Date: Wed, 31 May 2023 14:30:19 -0700
Message-Id: <20230531213032.25338-22-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230531213032.25338-1-vishal.moola@gmail.com>
References: <20230531213032.25338-1-vishal.moola@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230531_143151_858494_CB768C6D 
X-CRM114-Status: GOOD (  12.96  )
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
index af6bc8403ee4..5867a0e917b9 100644
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
