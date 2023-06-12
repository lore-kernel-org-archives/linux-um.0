Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF6ADC7EE43
	for <linux-um@archiver.kernel.org>; Mon, 12 Jun 2023 21:59:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=oFnaNFHdpKgOUjNCH2f8Kz/fw0QKwOBeW4kbSvGMzOU=; b=CiUSSxhF8Cjjf8
	InQ4V9C3Va8O7SdlPkjITNRrqU2n2r8oYX90zMffThnOX9ToEcpK4ksKeLLnE03huNWOUAPh9qYO8
	MbhAmoIkgHXLv2P/LDCwqVJfYSeNViv9O68MT/lBPOkMugV7sKwZi8NTryV5VC/Pp7wMbn7OrlZJB
	grP3OjbnyoLJMfMAwLW4+7cIJlYx8AOOMMT/9olvpbCaYIIWVArxLaVBe2v1rqRQoMb2psDaeCkh6
	GroJ+TcDeBXLfOEICqLBMhLP2hW5sV6cuq65+y4nc2a5B+BQHqChwy8JM90xZc3gs0lVwqtY0aN7R
	OCEYiRlEIY2pNfbWoVuA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q8pZO-005c7L-0S;
	Mon, 12 Jun 2023 21:59:26 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q8pZL-005c6e-34;
	Mon, 12 Jun 2023 21:59:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=zsW7mi3+X2fEN/3x0Bi+dafPb2wVjOjUR4AWbTKXMQ0=; b=pA/GP2eNyyNnYUSi/ICisZcqRw
	Efb2LVZx+wAgaULQA2ex+aXU9GZn0JvcQV4lGxSGig+BcVCQw9C7+7uHDYkKr/MtJLWtgVJBuAdGd
	N10128/SZJZkpaDngVll5F8LYp8vUXaW7quRFm+Q1CgWGNCyaZwNWxr2wbJbYaRMyqXsugd6WlCfR
	Tk27EjpO1rwTTAOp+bnpN1D1GUh6EQkMi+q/RVMzfDBDHknn69iLA9IA8oSvTxT2LlmAeOdBAJ9E4
	u0jau0hoUlUxFM8aVhuSvUjVQiaAXqTq+O9SQuc9hkdM43jLA7VzLTStrJqQEqBMFNPj4XzrpULKa
	xZFQQWew==;
Received: from mail-yw1-x112f.google.com ([2607:f8b0:4864:20::112f])
	by desiato.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q8ojB-0090by-1L;
	Mon, 12 Jun 2023 21:05:31 +0000
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-56d549284bbso2189547b3.0;
        Mon, 12 Jun 2023 14:05:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686603929; x=1689195929;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zsW7mi3+X2fEN/3x0Bi+dafPb2wVjOjUR4AWbTKXMQ0=;
        b=skq9VJH5dgJqddGwdVt6QPnDFnHLuDHmOdJ+p0cfKrjwcpANWfXjFtOnE+ShUVF4Wp
         +eZ1oAi7jnx0p4XZ2vlWf2HsUPHPywHFWTLkyBo2gHsKrZMxdedqFJMYHcQirASjKLsR
         SHXXWS83xBIee1HeZ900C52L0cf1hZAGJBgTBGRkI/olW2eHqyg1aEFYABUX/cDGInxY
         qBm8udoAWKxdlfWi3VICLCjFw6K8a8OX+rJWjNQ1/2hLUrj/oVGI32qhAulpQwwr+kGa
         Lu8zhuAzxz28DDQDJR/r5ap4yvwSJYAPMD0veq5+nFM3RaL/7sjJCqWPanMB6gD1jpVC
         DRIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686603929; x=1689195929;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zsW7mi3+X2fEN/3x0Bi+dafPb2wVjOjUR4AWbTKXMQ0=;
        b=ZofSVVLBEBs7ZIFXsM3t4RpyfbeY7eNxk7xwqbHEjvR2hVd1/hqpW21TqqgBEVbPnJ
         5moXeUdhiApdqClWFpHVq+LXHrwOyaVcKlqRml76UTDC4QSv2Q7oHQL3qOpHpT75YnAv
         ByvtfImZlgYs7odPt2JMq5ggZIQAkMrYCf+tQYDkM8E2aWy0xDajYaLKz1aTcTFfxRVb
         PtdYWKQj382YQv4dadRMHnEKZmNod+yu4MljyrBZFK045NFcmfAuqdQMfj1An7ugWZh3
         0DFWXA71N568T5DWL0VQ+PEECpMVX+0pjRjd7PLTyG49BtiOTw+Ht10VrcdV+6J3X/7z
         o3Yw==
X-Gm-Message-State: AC+VfDyFYTsKxJ6qtTzJgYIHHRYUmatYudxEr0cOKFWRdruSIhI13/BF
	qZVITjYDDLSxykVn2i925A8=
X-Google-Smtp-Source: ACHHUZ6YXnFai1+oazoURBIRxVN/vSubE3IHa08ab+S6MI7hbnWKgAk8qpadPRjUwPnUDYOPSto+cQ==
X-Received: by 2002:a0d:eb8d:0:b0:56c:e54b:b4b8 with SMTP id u135-20020a0deb8d000000b0056ce54bb4b8mr8864333ywe.28.1686603928796;
        Mon, 12 Jun 2023 14:05:28 -0700 (PDT)
Received: from unknowna0e70b2ca394.attlocal.net ([2600:1700:2f7d:1800::16])
        by smtp.googlemail.com with ESMTPSA id s125-20020a817783000000b00569eb609458sm2757115ywc.81.2023.06.12.14.05.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 14:05:28 -0700 (PDT)
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
	Catalin Marinas <catalin.marinas@arm.com>
Subject: [PATCH v4 21/34] arm64: Convert various functions to use ptdescs
Date: Mon, 12 Jun 2023 14:04:10 -0700
Message-Id: <20230612210423.18611-22-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230612210423.18611-1-vishal.moola@gmail.com>
References: <20230612210423.18611-1-vishal.moola@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230612_220529_748620_3134A0EE 
X-CRM114-Status: GOOD (  12.38  )
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
