Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFA9DC7EE23
	for <linux-um@archiver.kernel.org>; Wed, 31 May 2023 22:45:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=WMDYwyA1EXNY48G2k3PVGsH7g9Iy/HOH07LgZ0l7UGc=; b=j1YzaMy4KCVOUB
	toIp7Us3DhUL+1zlyjh6DSjYXQvAvh9EKgFZFyEViLPz/Vg9vQYCZBj8O+33QYkwXBOw9dEFOhiVx
	H0N8Dw7HdHBuZPe7HgcPHylbExb3jy7ANb6KbDx4haxKDSSE7w4bWDKlcH3zUitRCxB2DOJJe/ADR
	OYuAlIHweyzlfGUrVPXw2Ps4L+1/IYFxKv6XKOKijROcLIH1pvfN/Q2iTm/EevL0K5wvqEkUguOLU
	WcEHH8gGJd4qitt3uhQ0qVNiaLo/DjxVcu5DsLXymHyLWLZSZDs8hsQL5tkpRfrjZNQPqDRQ49Sjx
	rot/53qnRp4yHtwZtkiw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q4UZh-001Nyc-1J;
	Wed, 31 May 2023 22:45:49 +0000
Received: from mail-yw1-x1135.google.com ([2607:f8b0:4864:20::1135])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q4TQ5-001A45-1K;
	Wed, 31 May 2023 21:31:50 +0000
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-565cdb77b01so925357b3.0;
        Wed, 31 May 2023 14:31:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685568709; x=1688160709;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=llblHDjuRzdwObovgJjTe//ioNSPoyRpZegKgEWGdOs=;
        b=iH3Uuo4ydabF86Ae3Pt9mqJWCo9Mdl0v853LngJ++ms5qQhJIV2nJMOwvvj1jdSolp
         wkug3c5kE5OyC8B7qbo9EtOWW91dAFU5qbdW1jXEhkmIJBuTnUynbfXIOO6t9HnXXwkE
         IN/6ruRl/K/MZEBNhZ/CMDwD4Ey5RSIokBkrylG9gJyzM17uataBRfYABiymq5L1JBem
         AiofKm4cV+Hpu3+dW3nZQBqxHmZ0U8w75MqODX8zjymWwzwAB9aGsVd720nTIfH2C9wd
         s6EKfpFxPPWRO5hvsFIezwgeyXUB9GISVAQy5eO7rADF0ZyAn64v+X5gTI2GfoMJv3eF
         AD6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685568709; x=1688160709;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=llblHDjuRzdwObovgJjTe//ioNSPoyRpZegKgEWGdOs=;
        b=FkiYAto67GSlxOhrwim4nrMoTWNYrcLOvn6oKk8h8fT+oNnSknUdzndtguVq126Fx5
         njw93dtdZV1vwlczorZ7+gA8FM6p27KlfZcK+CY1gXEiir6z5iCQ9EZZ8bt6xYTgn6BQ
         7hdKOy/39t5y20RFgNXGTy/ZrDrwf84iMGaCzLuNIJwOAwMZk+b99b5VkcHTUFjrWe+M
         8+0hVR6btjl89HxqHh+rIvT3XtA/qxnP3XrHMYB0a7O3wC7OHcH81yNdotVlgN0MYHdb
         lq0XC6f6Jv/I9OwW92vT7gNOXJaavWGEI0DxvvdXfGs0LJ63cTgVB4c3iCJ3ByaiuGtJ
         ni+Q==
X-Gm-Message-State: AC+VfDz0+t+QIAev8tZr/cCqPWV726dBorc3K220ww8X5dRcA47i6nmn
	qgmn8xNixWao4Ni+T0AVtgk=
X-Google-Smtp-Source: ACHHUZ6yD6O1sbMXJdkzsJg9s7w6GLhFX5Kt5hWPrM1g6MrxSM/fcoQvLUKDHg0FsgcJPRMkk3z8xg==
X-Received: by 2002:a0d:e647:0:b0:568:bca8:de50 with SMTP id p68-20020a0de647000000b00568bca8de50mr6918459ywe.17.1685568708928;
        Wed, 31 May 2023 14:31:48 -0700 (PDT)
Received: from unknowna0e70b2ca394.attlocal.net ([2600:1700:2f7d:1800::46])
        by smtp.googlemail.com with ESMTPSA id t63-20020a0dd142000000b0055aafcef659sm658905ywd.5.2023.05.31.14.31.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 May 2023 14:31:48 -0700 (PDT)
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
Subject: [PATCH v3 20/34] arm: Convert various functions to use ptdescs
Date: Wed, 31 May 2023 14:30:18 -0700
Message-Id: <20230531213032.25338-21-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230531213032.25338-1-vishal.moola@gmail.com>
References: <20230531213032.25338-1-vishal.moola@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230531_143149_448299_CA253954 
X-CRM114-Status: GOOD (  13.11  )
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

late_alloc() also uses the __get_free_pages() helper function. Convert
this to use pagetable_alloc() and ptdesc_address() instead to help
standardize page tables further.

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
---
 arch/arm/include/asm/tlb.h | 12 +++++++-----
 arch/arm/mm/mmu.c          |  6 +++---
 2 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/arch/arm/include/asm/tlb.h b/arch/arm/include/asm/tlb.h
index b8cbe03ad260..f40d06ad5d2a 100644
--- a/arch/arm/include/asm/tlb.h
+++ b/arch/arm/include/asm/tlb.h
@@ -39,7 +39,9 @@ static inline void __tlb_remove_table(void *_table)
 static inline void
 __pte_free_tlb(struct mmu_gather *tlb, pgtable_t pte, unsigned long addr)
 {
-	pgtable_pte_page_dtor(pte);
+	struct ptdesc *ptdesc = page_ptdesc(pte);
+
+	pagetable_pte_dtor(ptdesc);
 
 #ifndef CONFIG_ARM_LPAE
 	/*
@@ -50,17 +52,17 @@ __pte_free_tlb(struct mmu_gather *tlb, pgtable_t pte, unsigned long addr)
 	__tlb_adjust_range(tlb, addr - PAGE_SIZE, 2 * PAGE_SIZE);
 #endif
 
-	tlb_remove_table(tlb, pte);
+	tlb_remove_ptdesc(tlb, ptdesc);
 }
 
 static inline void
 __pmd_free_tlb(struct mmu_gather *tlb, pmd_t *pmdp, unsigned long addr)
 {
 #ifdef CONFIG_ARM_LPAE
-	struct page *page = virt_to_page(pmdp);
+	struct ptdesc *ptdesc = virt_to_ptdesc(pmdp);
 
-	pgtable_pmd_page_dtor(page);
-	tlb_remove_table(tlb, page);
+	pagetable_pmd_dtor(ptdesc);
+	tlb_remove_ptdesc(tlb, ptdesc);
 #endif
 }
 
diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
index 22292cf3381c..294518fd0240 100644
--- a/arch/arm/mm/mmu.c
+++ b/arch/arm/mm/mmu.c
@@ -737,11 +737,11 @@ static void __init *early_alloc(unsigned long sz)
 
 static void *__init late_alloc(unsigned long sz)
 {
-	void *ptr = (void *)__get_free_pages(GFP_PGTABLE_KERNEL, get_order(sz));
+	void *ptdesc = pagetable_alloc(GFP_PGTABLE_KERNEL, get_order(sz));
 
-	if (!ptr || !pgtable_pte_page_ctor(virt_to_page(ptr)))
+	if (!ptdesc || !pagetable_pte_ctor(ptdesc))
 		BUG();
-	return ptr;
+	return ptdesc;
 }
 
 static pte_t * __init arm_pte_alloc(pmd_t *pmd, unsigned long addr,
-- 
2.40.1


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
