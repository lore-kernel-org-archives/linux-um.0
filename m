Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C772DC001DF
	for <linux-um@archiver.kernel.org>; Mon,  7 Aug 2023 23:08:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=c8dKL5lwVEmOeq6kxJO2VebGTCXKNluB3YBR7CZpBPU=; b=JvmxE4W8s24UYH
	hJi3EMhY/N0aj1s30KIiT14OPaNrNY6UXbWdxm7xfYY4rCyWVLU69Yk3VSTI1uq1eQbGarX0M9G+s
	5yTkY04QLYn5kDfv+GnNFjphPpqaSIkGGeVH4zC4T/wMYIjTNp2YFPYmPxCiSnD6dxVCWXzhhG8fN
	2QatzDH9ULO0sv2ducDoTni9z43R3/+Xujdtlc0dJkii2T7/LK/pB3QcQcI0UPpw2HvpdVHOBtFNG
	nTVu/SgVTcEg5YXrTrZ43Dp0fjgNXGaW+BTT2ZTobRERC9PeulRnVh7rH27zs3v+Pmv72BEr8Lqw9
	5N0jPJSFNE7S4eczJ/Fg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qT9KQ-00176p-2x;
	Mon, 07 Aug 2023 23:07:58 +0000
Received: from mail-yb1-xb2e.google.com ([2607:f8b0:4864:20::b2e])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qT9IP-0014vU-2e;
	Mon, 07 Aug 2023 23:05:57 +0000
Received: by mail-yb1-xb2e.google.com with SMTP id 3f1490d57ef6-d59da7115bdso263798276.3;
        Mon, 07 Aug 2023 16:05:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691449552; x=1692054352;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mSWx8dFer3K04xJe2FS2V6S19uUh9FiSOjAjYMXRNjw=;
        b=mEF5uAs6LPH63FkNSBplLFspkb60DHxm6zOnUwvAQJc3E/pOwbhAIiNFZBUYHiCsiM
         p2tbQp60CKHpnlFx92kmBMq0iICGLFKDwXQ0LyWNPB5CTFYLszQ4c8mEuzgfzEni9mwM
         Ttmf1qUiq6AjtyU7518jshwfi+pChbC60Sh5kSbXAB+lvEOcHSUd/ZfP7MFS2PgNjGFo
         r7Bvb+zEwdMz3ovaFVdL7n7AY1JJbQH54hsJVFdRCSvSwoDtl5zIXSCLg5x4eEWrxL65
         mP+yB5DlcuhDlbUdEBdiXWCJptk41KogbXQLbDgKd5NU/tlto4itztjaP5et2Hvpw0rt
         7VEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691449552; x=1692054352;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mSWx8dFer3K04xJe2FS2V6S19uUh9FiSOjAjYMXRNjw=;
        b=kHo/y2l1rK151JSGoPVPcKKcVe/JcmbVPgjfBv1VWSn1qf576v8mu6duppvqdb9rEh
         D7y+G3DEWfCvSqNPr5J9JBuA9DPczwpRzqV1rdrbmENDX9IzglvaK8ldXQJKf5X5InHB
         i8zkYJV1a0/o4+5k7/MqvN3wMiHTazd7I7TfnQmMbo+85cwMdR0vHfXUtwdXu9UPBMLv
         MUh5MQ1+WgWH8xQc9EcxOzDqqaIDYhVBMrc+nLB6H9rCdw+Cy8oCXULC5VqHMirwDPfG
         e3pIIK3LilVj89FKwXYsO/3/zNEBVgtZAtddH4StdEkqNzpy7IJ9pVXy1aRHmCo5P13F
         rfeQ==
X-Gm-Message-State: AOJu0YyQ+nL299bsEUAt3Pc40BJW1zP965znLfRKtEsxBvZOKwswjlM/
	DhRNY7vyn394sFVEV11PcwQ=
X-Google-Smtp-Source: AGHT+IFZB5AVL/MxN7IM/ds0EZn0mK90E4BWht9Xyb7zBcTjMbr/Qp8cCY+l+/2imbi83tiWiC1i0w==
X-Received: by 2002:a25:4e05:0:b0:d12:3108:f90f with SMTP id c5-20020a254e05000000b00d123108f90fmr10423741ybb.24.1691449552662;
        Mon, 07 Aug 2023 16:05:52 -0700 (PDT)
Received: from unknowna0e70b2ca394.attlocal.net ([2600:1700:2f7d:1800::16])
        by smtp.googlemail.com with ESMTPSA id d190-20020a25cdc7000000b00d3596aca5bcsm2545203ybf.34.2023.08.07.16.05.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 16:05:52 -0700 (PDT)
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
Subject: [PATCH mm-unstable v9 17/31] arm: Convert various functions to use ptdescs
Date: Mon,  7 Aug 2023 16:04:59 -0700
Message-Id: <20230807230513.102486-18-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230807230513.102486-1-vishal.moola@gmail.com>
References: <20230807230513.102486-1-vishal.moola@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230807_160553_908265_B5940ED0 
X-CRM114-Status: GOOD (  12.52  )
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

Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>
Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
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
index c9981c23e8e9..674ed71573a8 100644
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
