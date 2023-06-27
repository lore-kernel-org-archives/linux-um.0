Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 439AAC001B3
	for <linux-um@archiver.kernel.org>; Tue, 27 Jun 2023 03:18:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=HztBWag1ntkeJiDDuVmLLqaVmPkW2mwCBtL3dBLcxfo=; b=QNjLBQnrS8IPFv
	2DC66NGx89i4goGx8eNisjawIjFf7jhbMN7qTeNDGJOoC5jecWSE3UVRou+jIXId/xOusDvgkQE8I
	NREF+6jVteridgT2sfP9anfyD38RQNhmvYjgeuhf3qAc3jwqhCvS7exFj4zvGHztLEGv9w3OWlKzz
	55dYzq2J9s3D6Y6eGQWBlFAFQWIwBm4/tZgnDG8FivNFtwTKIPEJYx3QiA9x2PQzmbz/gSOCpFlnL
	z+K1nrTiU6Zls7gNBK0PeHoRaMmMpOynwZXOOxmm/icq9kUvp1kDdShP/o12U0pff6+cr4NwRsnP1
	1CZraDBch+6ZCmnCBfDA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qDzDl-00BYHp-1h;
	Tue, 27 Jun 2023 03:18:25 +0000
Received: from mail-yw1-x112a.google.com ([2607:f8b0:4864:20::112a])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qDzBF-00BVwe-01;
	Tue, 27 Jun 2023 03:16:00 +0000
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-57040e313c5so62556347b3.0;
        Mon, 26 Jun 2023 20:15:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687835748; x=1690427748;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jHkn+4hWn6cNWfQmftBQOtWQYQb9iJJIYcRZZNmu6iY=;
        b=pEoqTDJnBy0mCqMkui4NdE0+Cwn3eLpTYrB/bC5trNXcVXfSLt5Z5R8YIAYFQDP+fU
         oHaVR+r3yqYLt41ruRoFntv6iwVJI6k1WqPqr0CaczRFTmURyku+1Wh096jhdpaix/Yw
         TPjMea9fKHZjosCsh+ySOFuhqRhCq2RDcuYke4iWdPlhdEuluthF5cnNEQKZ+c5Hc7fG
         +fx7g6BPukH/s549n7Tu5GqJ8+5PFdtaVRB8v1bDc72Rwv3o28GHJ8X1zhRwfXU/u/w5
         Ysny8z2GqEVJln+w7kgofDjg2/U0lPQrPRqE+xKNvOs2VewEz52G+iOBPJ4WaFg8E+aM
         IwPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687835748; x=1690427748;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jHkn+4hWn6cNWfQmftBQOtWQYQb9iJJIYcRZZNmu6iY=;
        b=YU1VWALei0dbOz0tYub8CDkH6Dm7UkNpGWwPUVqVIC1spnB5he9R3d6Md5/YjelOl2
         0J0FhrQ0wtwHTOSHikRipFZYsKPmdiHQDZEQVVK3s86rLs4VaUMr5y/DzVB5JyMWotb0
         1Bd5fXGfCISijMpYKe7jOP+Vo+Qil9O7GJeXjdHZhZLFmBMTYpqFUPVPwEP/OSHGfNc9
         sYKNRJlUJWnBuOnakRh0L4Dtzldnuew52bTqeIRLXVpAT4NqsbesalIUwGSvSgjapcM6
         Dwcx9aesP4rDZeiAkaGH5ZCIXnM5NVh6mFn5eTkDhf1S/luM8C/QH/tJuINi7DU9yXYl
         OSMA==
X-Gm-Message-State: AC+VfDy+9F2EsFMcIUfK5HVnrM0ud9a5fv9lvpwsZdt5bQmn8tY+X3ma
	V+niBUlfnHDNj7/Px9lhETQmI0TWKj7CtA==
X-Google-Smtp-Source: ACHHUZ6p2ufkJSMv8EFIrIVima6CHOhkXf0TNdBTXqyjA7XsBDI65pfDIOBZhup550aSGjYhkYTA/w==
X-Received: by 2002:a0d:d988:0:b0:56c:e260:e2d5 with SMTP id b130-20020a0dd988000000b0056ce260e2d5mr41557377ywe.7.1687835748072;
        Mon, 26 Jun 2023 20:15:48 -0700 (PDT)
Received: from unknowna0e70b2ca394.attlocal.net ([2600:1700:2f7d:1800::16])
        by smtp.googlemail.com with ESMTPSA id s4-20020a0dd004000000b0057399b3bd26sm1614798ywd.33.2023.06.26.20.15.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jun 2023 20:15:47 -0700 (PDT)
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
Subject: [PATCH v6 19/33] arm: Convert various functions to use ptdescs
Date: Mon, 26 Jun 2023 20:14:17 -0700
Message-Id: <20230627031431.29653-20-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230627031431.29653-1-vishal.moola@gmail.com>
References: <20230627031431.29653-1-vishal.moola@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230626_201549_098335_751EE5D9 
X-CRM114-Status: GOOD (  12.81  )
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
Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>
---
 arch/arm/include/asm/tlb.h | 12 +++++++-----
 arch/arm/mm/mmu.c          |  7 ++++---
 2 files changed, 11 insertions(+), 8 deletions(-)

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
index 13fc4bb5f792..fdeaee30d167 100644
--- a/arch/arm/mm/mmu.c
+++ b/arch/arm/mm/mmu.c
@@ -737,11 +737,12 @@ static void __init *early_alloc(unsigned long sz)
 
 static void *__init late_alloc(unsigned long sz)
 {
-	void *ptr = (void *)__get_free_pages(GFP_PGTABLE_KERNEL, get_order(sz));
+	void *ptdesc = pagetable_alloc(GFP_PGTABLE_KERNEL & ~__GFP_HIGHMEM,
+			get_order(sz));
 
-	if (!ptr || !pgtable_pte_page_ctor(virt_to_page(ptr)))
+	if (!ptdesc || !pagetable_pte_ctor(ptdesc))
 		BUG();
-	return ptr;
+	return ptdesc_to_virt(ptdesc);
 }
 
 static pte_t * __init arm_pte_alloc(pmd_t *pmd, unsigned long addr,
-- 
2.40.1


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
