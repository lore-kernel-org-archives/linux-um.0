Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A2A8C88CB5
	for <linux-um@archiver.kernel.org>; Mon, 12 Jun 2023 21:07:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Vc42YTpgH7P1mzJ3awKF+O38afzCXJntguj1lq3RlDo=; b=Hywt43vDf6tUyi
	iBo0yjD+gHYOfka6Ceqr8fJh413WY/WNzstWpETrxx4TGi9Wb4T4ztnD0TrsHnTWK32IHuZkwXB3p
	CIus03N2U9T1/veWlhqnN59Sw/wBKreHyn+MoPPE4aTcRId3UrZi3yktOZ7YdUmx336+i3QCDmMj6
	CPnr4Ck+PG21Nd6VHjRe4+FmQDw4q9cYfKGPOV0f3kw0XYgy4pPgSU/iHvOo5wbbMkELj118PeO9j
	96vyZtX2V1mHP6MKZsX+DsgbVSKQQAO74adZYIQAdS46IIvFBUXw/ffH6puscucVAjt3TECMVLE25
	SGYK66jfJmFCrLafG+RA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q8ol4-005PgT-2K;
	Mon, 12 Jun 2023 21:07:26 +0000
Received: from mail-ot1-x32d.google.com ([2607:f8b0:4864:20::32d])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q8ojT-005Ns0-1X;
	Mon, 12 Jun 2023 21:05:48 +0000
Received: by mail-ot1-x32d.google.com with SMTP id 46e09a7af769-6b2041315a5so2307999a34.0;
        Mon, 12 Jun 2023 14:05:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686603945; x=1689195945;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RAmT8w/AncpH6QVoSIrvIComylZ1SrhYEKCy+DX5WSQ=;
        b=TKVGiilQ78a/OhIPJrQkIG23uSCTs20i/bAbbkbs/oLPcc63baV2HRxlfziGdsvmbT
         NGwmW85cSCp6KespeqLEesubwuI3LepWWanH5S5npuzVlt9k5eU+arhtadffMS44bFKz
         tZe3hNLEkkGFlp7EldonlERGCsKXmABWlm5tuivlOHa4YP48jZLg/NXNUT6fL0OAV+la
         FfMXzF6x14kaKnLc9TNsZyJBWsa9Csrn4MI3KMBJ6+29vVkgPdAEbVwqoitINTtP8h57
         PClm1IA8Ha5Fd3vbc4M29HaqMx1DRRQlZyGElsQzM+NPYmwv6tn2zngJCKwAeXiQVKW2
         CRrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686603945; x=1689195945;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RAmT8w/AncpH6QVoSIrvIComylZ1SrhYEKCy+DX5WSQ=;
        b=ho5euVpqhe120Uzn3JgVPkWn6EZhtQ6KNE7z96WK8dnoyh3yZ2vVXclRaWeFywcmpS
         ls3sRMaSLtKE7rIJlUMj6aMNtuP7GbKe1/nwMB1E+bxz+2bd95UpECMmhabaU9c4pIrM
         ZmMdJUVoOYAlIQsO82RbyUPK8PmZM7Z0BHeQ0r8SeBaNz7rdjnW/OQ61ObFaKw4kLC6p
         PHHPEs5R7ly3SJ3T/jrWl7204iCruKT0WDw72yOlxJxLarb5pp30RN/R9t+6w1Rt+tao
         JX9oZA2jCdyEJkTz15HyQamZLzxC5K+YSmCtjwEUNoVAXZw8vzMpkFdAyRVQWTK6yzog
         sThw==
X-Gm-Message-State: AC+VfDymfiyiafrzr6WQCbdfFRsWAsAptwra3Jmkq5bWTn8E4RAizXi5
	Sl0UqlNA5gNRW0hL1JbHz/c=
X-Google-Smtp-Source: ACHHUZ47i0W41PgLnIyz22Ca7yXJDqII27mpfISq9Vor76sG0Ii5GTRFPk+r3wb8VVa0pQvvv4TjaQ==
X-Received: by 2002:a05:6358:cc1b:b0:12b:de97:1be4 with SMTP id gx27-20020a056358cc1b00b0012bde971be4mr1697129rwb.30.1686603945076;
        Mon, 12 Jun 2023 14:05:45 -0700 (PDT)
Received: from unknowna0e70b2ca394.attlocal.net ([2600:1700:2f7d:1800::16])
        by smtp.googlemail.com with ESMTPSA id s125-20020a817783000000b00569eb609458sm2757115ywc.81.2023.06.12.14.05.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 14:05:44 -0700 (PDT)
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
	Palmer Dabbelt <palmer@rivosinc.com>
Subject: [PATCH v4 29/34] riscv: Convert alloc_{pmd, pte}_late() to use ptdescs
Date: Mon, 12 Jun 2023 14:04:18 -0700
Message-Id: <20230612210423.18611-30-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230612210423.18611-1-vishal.moola@gmail.com>
References: <20230612210423.18611-1-vishal.moola@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230612_140547_540050_70E79C05 
X-CRM114-Status: GOOD (  11.91  )
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
Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
---
 arch/riscv/include/asm/pgalloc.h |  8 ++++----
 arch/riscv/mm/init.c             | 16 ++++++----------
 2 files changed, 10 insertions(+), 14 deletions(-)

diff --git a/arch/riscv/include/asm/pgalloc.h b/arch/riscv/include/asm/pgalloc.h
index 59dc12b5b7e8..d169a4f41a2e 100644
--- a/arch/riscv/include/asm/pgalloc.h
+++ b/arch/riscv/include/asm/pgalloc.h
@@ -153,10 +153,10 @@ static inline pgd_t *pgd_alloc(struct mm_struct *mm)
 
 #endif /* __PAGETABLE_PMD_FOLDED */
 
-#define __pte_free_tlb(tlb, pte, buf)   \
-do {                                    \
-	pgtable_pte_page_dtor(pte);     \
-	tlb_remove_page((tlb), pte);    \
+#define __pte_free_tlb(tlb, pte, buf)			\
+do {							\
+	pagetable_pte_dtor(page_ptdesc(pte));		\
+	tlb_remove_page_ptdesc((tlb), page_ptdesc(pte));\
 } while (0)
 #endif /* CONFIG_MMU */
 
diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index 3d689ffb2072..6bfeec80bf4e 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -354,12 +354,10 @@ static inline phys_addr_t __init alloc_pte_fixmap(uintptr_t va)
 
 static phys_addr_t __init alloc_pte_late(uintptr_t va)
 {
-	unsigned long vaddr;
-
-	vaddr = __get_free_page(GFP_KERNEL);
-	BUG_ON(!vaddr || !pgtable_pte_page_ctor(virt_to_page((void *)vaddr)));
+	struct ptdesc *ptdesc = pagetable_alloc(GFP_KERNEL, 0);
 
-	return __pa(vaddr);
+	BUG_ON(!ptdesc || !pagetable_pte_ctor(ptdesc));
+	return __pa((pte_t *)ptdesc_address(ptdesc));
 }
 
 static void __init create_pte_mapping(pte_t *ptep,
@@ -437,12 +435,10 @@ static phys_addr_t __init alloc_pmd_fixmap(uintptr_t va)
 
 static phys_addr_t __init alloc_pmd_late(uintptr_t va)
 {
-	unsigned long vaddr;
-
-	vaddr = __get_free_page(GFP_KERNEL);
-	BUG_ON(!vaddr || !pgtable_pmd_page_ctor(virt_to_page((void *)vaddr)));
+	struct ptdesc *ptdesc = pagetable_alloc(GFP_KERNEL, 0);
 
-	return __pa(vaddr);
+	BUG_ON(!ptdesc || !pagetable_pmd_ctor(ptdesc));
+	return __pa((pmd_t *)ptdesc_address(ptdesc));
 }
 
 static void __init create_pmd_mapping(pmd_t *pmdp,
-- 
2.40.1


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
