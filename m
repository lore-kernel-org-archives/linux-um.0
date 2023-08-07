Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44097C001DE
	for <linux-um@archiver.kernel.org>; Mon,  7 Aug 2023 23:08:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=wXvpRXYWRJlhXviC+fpE1sGhSq2+oXaPzq21jbOJJEc=; b=CO3i82IkXx9ZES
	3YLKvQzUJe4xu7Lpz9mGyXp5oCDoe6Q2n/fR12jo8/3PZg1Q0TkwCpvuB7MCqsC0abE81zYEnjfGP
	+rRKTIpoMrKUtAnyvr+fAdnkiFKEJvUyhcQkvE3QhMhVgcIUS/+E4nZkh32G8+TiNAnGkglqqBBi1
	z/VzpBGW7REvn54R87bAd05lHBW3D6NQwrgF6LG1BLbqQH75iQULxz0d1+5tKAxFTCBl5rewmQWZ4
	CUjvBoNeIZEoY8Ellw+ggtOonFYCypn7RCLPYN7bDjeUs88uL1KqzE0V2+W7Xcmsm9w4EZejfjOE2
	z4A4+pZQR3+L8WBKOm8A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qT9KV-0017CE-2I;
	Mon, 07 Aug 2023 23:08:03 +0000
Received: from mail-yb1-xb2f.google.com ([2607:f8b0:4864:20::b2f])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qT9IR-0014xl-1q;
	Mon, 07 Aug 2023 23:05:59 +0000
Received: by mail-yb1-xb2f.google.com with SMTP id 3f1490d57ef6-c5ffb6cda23so5463592276.0;
        Mon, 07 Aug 2023 16:05:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691449554; x=1692054354;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d6BZos7Ybf69Lr9ubs2a6Azcthgsxnr+LK2TqOKvMHI=;
        b=p8G6Pt9QZsVgDIw5B0YZsM1HO9y9fkrb/cw0HZOe9s94xOMFlEATGdftneo/KGkdaX
         TwSO+l67/znn0WvrOrRHHntMUuj9nNFXoTE85WKOjzGwb94eB3i84/XFPlTd02w2CLrJ
         DwESQ9jUYWS2DSwjhw7JNYWMJXOT94ZS609EVQWWoXQdRFNt0hhd7LN+kuo1QQmNKeS0
         XHBIPjPF8dy/T4snUiw6ibSJ1ZirvD/sPtDvke5ir6zweBiFnq3ooQs72HZNE6w+OGww
         eTDTJaym+WVQphZfxFF+BeQU7jP4VlgJoz6RKQntFEtdMFIN0fhGKatr4Jikr9avLVk6
         gEYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691449554; x=1692054354;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d6BZos7Ybf69Lr9ubs2a6Azcthgsxnr+LK2TqOKvMHI=;
        b=JF5DWZMFPaE9rtw5u2fjy9iVSe2fXLCuw1jVgfaqwiucsKpciIBeiSKR38aHdhqKea
         TbVbjwxwt05Tz52z8YDFQTM3fuBJX6U+MD8pDZ6i/uLcKweZq3XUDdbeTawKyniUgujx
         H4QQQk3AEaLV65R9tBZpXKrhCRkxJqtmrHMOlSjc4J+aUO14R5aJJ87P/X2nxynVF6HF
         rl59maaTODPFYtYGvQU4NqgU/rvD+hlu9peoaJAQv5/qbIyOJK6MoKhelF6nllJBJPFk
         bqwR8mOrCUupY5mf+4jkO63dGraRwafHeTsu757PtPtdCKWAcU3LBc+OI36lDZxpSXCV
         7y3Q==
X-Gm-Message-State: AOJu0Yx6BUpcaYVRj65RU0r225qPMpWKMNNUxZQkukZOZP0bLxMgNJcT
	PDigx0bcyvEmX2tgoNNIcpk=
X-Google-Smtp-Source: AGHT+IHnEVFzuxaIlZevFxX1u5N6TSfYAnl0Ngd19zcPS1yyZn6+F2gzJTtnG1yf2qQFJp4HGPdIaw==
X-Received: by 2002:a25:aea5:0:b0:d0b:fe82:8b99 with SMTP id b37-20020a25aea5000000b00d0bfe828b99mr10007354ybj.44.1691449554679;
        Mon, 07 Aug 2023 16:05:54 -0700 (PDT)
Received: from unknowna0e70b2ca394.attlocal.net ([2600:1700:2f7d:1800::16])
        by smtp.googlemail.com with ESMTPSA id d190-20020a25cdc7000000b00d3596aca5bcsm2545203ybf.34.2023.08.07.16.05.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 16:05:54 -0700 (PDT)
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
	Mike Rapoport <rppt@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>
Subject: [PATCH mm-unstable v9 18/31] arm64: Convert various functions to use ptdescs
Date: Mon,  7 Aug 2023 16:05:00 -0700
Message-Id: <20230807230513.102486-19-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230807230513.102486-1-vishal.moola@gmail.com>
References: <20230807230513.102486-1-vishal.moola@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230807_160556_415726_5B9F8C5E 
X-CRM114-Status: GOOD (  12.21  )
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

Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
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
