Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11BD3C77B76
	for <linux-um@archiver.kernel.org>; Mon, 17 Apr 2023 21:17:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Mu5gb3rulRM1hTysY7SXSh5XAJEshfA9ABzdkPvtcTg=; b=FZtKwsjuKj1lzl
	eBX83clWGPj+PsLn1iY0x7sdnY62SmxXiBkmoEW6iqIYC6kYn4+Z65BIqEz6XOhg9ftfLI7Luqm5o
	AA3QZudVrHtWAzP0baO6clhfyPZU4NrvxzPcaq1+xuwJRifCP7kRXxxabFpFDcOPglkBHES31BNyg
	pWoYYcDQrLCnNO1+tR7O8MiQ0YOAw8EGsF/4LLqteP8yxHHmEl3/ISnnQ+YXW0lZ426b3QUq9WGR7
	vo1joPDtCHRf/xnDvF3HyNlCQmnE5deXAUYOBt00x4Di8dsjXCLbZ1vzfbQQ/lCG/7v50q9zGZFep
	iWrOWg+2Jbzmo2Oe1oWA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1poWEC-0002Nu-1m;
	Mon, 17 Apr 2023 21:17:36 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1poWE3-0002G2-1g;
	Mon, 17 Apr 2023 21:17:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=oJJ/5JNaAhhn0BtCWyESRHZW29NfaaBB7RT6Dtpfjog=; b=XIXHwZn6kzrbx55HQSZpnuBz+S
	IVm2RHKqddHF/oWSNHCqQTNEtLfKQcjzdi08CQcji4hlaCKoZ5GRaLatLbKd1FrgW7O8YcLR0IRhK
	yPFW6RGDDO/2KPUsCbojRJqpH/tpiL7HT8e5r79DSkXuDwm98a/7jEbTFHMEwRD1lC0G6raK4wxOi
	8WFv+qUYdekJmAFywNbwEEOBUEspnvvYGKc+XvcwCF0EntUJXcR6tqZZbYsCvMLJQPIzot3rKquC1
	SlbbWe+rj6FM6EE8rq833XB0drJKx7Re9YDCP9BgzMkL61pmGpXhcKFH5FHgAD6z3T8jxuRt0dUcJ
	4bnvIfaQ==;
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
	by casper.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1poVqb-00BfmA-I5; Mon, 17 Apr 2023 20:53:15 +0000
Received: by mail-pj1-x102f.google.com with SMTP id z11-20020a17090abd8b00b0024721c47ceaso14040951pjr.3;
        Mon, 17 Apr 2023 13:53:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681764793; x=1684356793;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oJJ/5JNaAhhn0BtCWyESRHZW29NfaaBB7RT6Dtpfjog=;
        b=VrQ0lWqrs/ZeVvxhrMkEnri25zysQvP6rvUVlziuAvcyoO7aiCs2Ip8nrZdL+4djlt
         EalUxXukap5u9TcR0Ypqd1nj4oCE7Zy1crkVgOFcBvFvQfkcdrgLVV5yu4aZ8sXiNQzS
         MzbdyHaLybqiTpdHLCapkJdM135ufCzQfSX7LCwPasNWotwzcPJsMf59UKAQgZOOczBx
         ZYZuB1ddeu/80rtF2gv16gY+bwHM4NdL4pbXt10qFjUxYFen/hCDj/7OzFab+Hq/fc/w
         UWRA/d9TiIVFZRkxxpOQPugklzg3SfxU/z6fpq4Q2x5DyNF+cvnkXmPJMDWg2KdcBHj4
         X1Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681764793; x=1684356793;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oJJ/5JNaAhhn0BtCWyESRHZW29NfaaBB7RT6Dtpfjog=;
        b=iw4njwEefozyS8I7MIy6DKubJ0K++L4x4QwTd8NMlOfcgeO22lhfwFzFWzOQZUP1uK
         E271C+T54p5GkewdqRhT0IiSLN8mDbMJMfVeWTxqc4M2yAB3LtmwWataEtu3RMp49Zee
         /Zlq5fQP7b2gotCF3T79Yno3/nrrTAXalsjNW1txqkSXEow/DgUy/V2JVReNY3eAYR7u
         IIbBOp4u0QKSjkGDTy4DvKvJYSkJC5yY7n961+jEU9CVlZk7NSaAcEPAqvBrp/goHb76
         5IiioXjfYU/WgDXS/MEDM1pcp8xuOJeMZJj7GK7qTQC4gmc5WKciEcFy1WuCgulO2QBu
         +NbQ==
X-Gm-Message-State: AAQBX9cZKrjFZ9UD2qSDNZQp26qg0gcM5cfEvMFY1kBdJHhmtsOAnxQN
	tFxbVkon5HtCFrMlB8EpoKc=
X-Google-Smtp-Source: AKy350Y2w7IaE9PrAymAnxztuomQd4Ga7koe4Zw+ByQfv97VTbICRP51vtaSBBH4u41LkAvC07UcrA==
X-Received: by 2002:a17:902:bd86:b0:1a6:c6d4:5586 with SMTP id q6-20020a170902bd8600b001a6c6d45586mr227041pls.13.1681764792942;
        Mon, 17 Apr 2023 13:53:12 -0700 (PDT)
Received: from fedora.hsd1.ca.comcast.net ([2601:644:937f:7f20::c139])
        by smtp.googlemail.com with ESMTPSA id h7-20020a17090ac38700b0022335f1dae2sm7609707pjt.22.2023.04.17.13.53.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Apr 2023 13:53:12 -0700 (PDT)
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
	"Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [PATCH 20/33] arm64: Convert various functions to use ptdescs
Date: Mon, 17 Apr 2023 13:50:35 -0700
Message-Id: <20230417205048.15870-21-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230417205048.15870-1-vishal.moola@gmail.com>
References: <20230417205048.15870-1-vishal.moola@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230417_215313_611490_33DCF080 
X-CRM114-Status: GOOD (  11.34  )
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
index c995d1f4594f..6cb70c247e30 100644
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
+	ptdesc_pte_dtor(ptdesc);
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
+	ptdesc_pmd_dtor(ptdesc);
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
index af6bc8403ee4..5ba005fd607e 100644
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
+	 * folded, and if so ptdesc_pte_dtor() becomes nop.
 	 */
 	if (shift == PAGE_SHIFT)
-		BUG_ON(!pgtable_pte_page_ctor(phys_to_page(pa)));
+		BUG_ON(!ptdesc_pte_dtor(ptdesc));
 	else if (shift == PMD_SHIFT)
-		BUG_ON(!pgtable_pmd_page_ctor(phys_to_page(pa)));
+		BUG_ON(!ptdesc_pte_dtor(ptdesc));
 
 	return pa;
 }
-- 
2.39.2


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
