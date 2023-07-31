Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01D39C04E69
	for <linux-um@archiver.kernel.org>; Mon, 31 Jul 2023 17:07:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=pXuy4Vkx5aYEYOq9KEDSHtFOdr+KMGwAk/zEd/nGORk=; b=Fa9d1fs2Qe9U3E
	RYk0CKmY0eM3Vrc7OdQxCPODPYeG7wKNqE2PMpWV/oQcEP8XaHIBaXWOA86ZfI+vudyu3L0RLRfRN
	hG2V7GC1x53+Wr61QhhdXe6e8VdQ2NCHrx44cKA9MvN1JIja1FWBrRy7tJmZLpcm28zNk05wAMz/t
	WvikyosCxqegNaP6cKk1DXibChSW0W38YK/qdyTn3BI7K7U29kAtMtyTUDbJNW7LS6J5Rx+KFTE3d
	6Bg76kYC3REWczsWLg8IgjEmiw6soaD7pPtmX9oCTeZLscxawm5Uusk8KWKTAMDaYUa7OY7gbQnaa
	EYxSw081chIgR2h8u9aQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qQWMh-00GmrE-2t;
	Mon, 31 Jul 2023 17:07:28 +0000
Received: from mail-yb1-xb36.google.com ([2607:f8b0:4864:20::b36])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qQWJb-00GkPz-0E;
	Mon, 31 Jul 2023 17:04:18 +0000
Received: by mail-yb1-xb36.google.com with SMTP id 3f1490d57ef6-d16889b3e93so4993880276.0;
        Mon, 31 Jul 2023 10:04:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690823054; x=1691427854;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1W6z1I6yvWrQZbHmgHYBEGZZDstSbvELOPET/EcKlKw=;
        b=DoLYDaRBa41Zdh1yGELvr4mktDPzCr5wZMtfaOFQzQ5hTcfRkcfNo2gxzOD+0/ykOM
         euBOcnH4+UQlm104MdM8Mcd6Wd+0oXQ7r2d8C7k16OxK93xpXJQ9cxidNEnw+09+Tsgn
         4MiJbaZ4azooZbJym/w2spQi4ZLNoUGyQvzF+yt3P/maH4DT1bEGYtqh5RJ+6A+RSiNZ
         F4VZO0F3scHf9jVdMvyffz9Y4Un+dZzmqLUFBUExZqr5BTOKTZ3vKrNuYiRkZjRgx8qM
         A0v2BAwmzAgXUoHV1OBdUh/BQxSYjg1Y5Vc+ifw6djIqa1GbEqCTgLRTuyk3SSeDHWhN
         ZcIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690823054; x=1691427854;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1W6z1I6yvWrQZbHmgHYBEGZZDstSbvELOPET/EcKlKw=;
        b=bS3GRLOYa/i3u3RudQcv4KQsLfwM++k7eFd6T8IBhbaE5mkE1PSLK9TA/Bzy5fWgo4
         t7lZFEA/7xrx5+lhoN4qCWxdayQPlLQ0VhUjlXvjF5NoedIizrqFQyq4Vomvr+MdvcKV
         IKWf8UJOESM9htM3zhJITIUdrY3DIwJ1orQR7oqFkzthlHHw+0J15I2lU/ZhC6QT1ISw
         GSWueHSNtBUMTTOjvkjL+MG5aDnJNnXllWiUnS4MIrQrK+u4Ed4Nkdq5OksCe97W+sgl
         iu+Xaq9Dq5v5TM4Jcj26ewwinq4NNI+ouQjaQ9d0A+JLd4wQL9MegtaE4dUf5h+7p1A3
         eeOg==
X-Gm-Message-State: ABy/qLb+HGzQlCso1rf7vXAsVGL2UPUASjpmNLfMasBR0UTRrDXOQROW
	+ewX09au5KRK1v3ZPpgb14M=
X-Google-Smtp-Source: APBJJlEdpRjJyqAaQhaJuPKqzpefz2AFbwFC7sVhDBH7lQjGs0g9KoyKRkFSzeflgvIaUwqu4lunqA==
X-Received: by 2002:a25:b08d:0:b0:d11:2a52:3f35 with SMTP id f13-20020a25b08d000000b00d112a523f35mr11488364ybj.20.1690823054136;
        Mon, 31 Jul 2023 10:04:14 -0700 (PDT)
Received: from unknowna0e70b2ca394.attlocal.net ([2600:1700:2f7d:1800::16])
        by smtp.googlemail.com with ESMTPSA id x31-20020a25ac9f000000b00c832ad2e2eesm2511833ybi.60.2023.07.31.10.04.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jul 2023 10:04:13 -0700 (PDT)
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
Subject: [PATCH mm-unstable v8 18/31] arm64: Convert various functions to use ptdescs
Date: Mon, 31 Jul 2023 10:03:19 -0700
Message-Id: <20230731170332.69404-19-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230731170332.69404-1-vishal.moola@gmail.com>
References: <20230731170332.69404-1-vishal.moola@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230731_100415_131794_B032D0BE 
X-CRM114-Status: GOOD (  12.98  )
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
