Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9185C77B76
	for <linux-um@archiver.kernel.org>; Mon, 17 Apr 2023 21:59:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=dZ7dkGPlH3W3LVTPtcQOMrd51wOtWYogoB85Rclo74s=; b=c34t/Hmoh8pCUw
	86pwUNzE2ypPxhfd/01s9vOx93Si8tLD7pJM7VWo1x0hUU4PAZepbQrhMzdEC+G/RXajIKYeZUQq+
	wZU0ULQzSMlIzh1+WXrSjj/oUt816RQKoqXd6rXJyKwoHHko7vRZSbBurVJo15MoIyl9ClzpRKcpC
	e/1FywA06qG6BRrCbN35fXtML4KR2iBJE7HRk4Py7ikza/c56wTg9Zc0erb2H4aTFx5RjfVUo8H2q
	wj465cFMjc5+PgF4Xv1pjDJwAjmcDy70Mm5YlcSyoDsdnhpDkpHlgPJsYaXibcaLyf2CMunpGRCa7
	AOESRgK9UdyOlk8rjl7A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1poWsa-000Blo-10;
	Mon, 17 Apr 2023 21:59:20 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1poWsW-000Bjv-0X;
	Mon, 17 Apr 2023 21:59:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=uzUB7crKqn7Of69Iz0IiuKaVcaC8bpzNVtqjj02cJJs=; b=grNUMGCxzwAnWx5TWMxqoy8ISb
	MDh+wEV6Jlw7NAtwruwKKvbHKWY4S1K1JgV992DWyP3C19GySazVpJhMTwZ6GP3uOmgOG1HW/DPDi
	bF/dJGV86yfNvFPtx99S51X6OSSJxzL9dXHo3Ydb+D7HiFJHNKF/IHpYjL09/v7ZLPQDyyWnx9i1u
	3dASHWW5yIvHoIpQ4mzJUvddAbssZA2k3n5lQ9HWopS68PIyDvR6w8mIdEm+EaHJnZ0lx/dtIsOIR
	9pak7oFgwtFJwLOtxokEoTg6w4wuRC0lEiQMTvoYdrdzGU6k161w6MvP0nfNt7AUYA8GIt8hOHCIf
	AAznQMWA==;
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
	by desiato.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1poVqm-00HS3o-2q;
	Mon, 17 Apr 2023 20:53:31 +0000
Received: by mail-pj1-x102d.google.com with SMTP id v21-20020a17090a459500b0024776162815so6441755pjg.2;
        Mon, 17 Apr 2023 13:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681764804; x=1684356804;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uzUB7crKqn7Of69Iz0IiuKaVcaC8bpzNVtqjj02cJJs=;
        b=CQxyKkc21JMWEGZgaxo+DzkT7hmUe/EPeRLNy9307TK3NRBVO8qYFVHUBh0a+wrrFK
         REDRofZ4pQ77HB/xKTTnWP/BT1cyKC/pHZN9NhEm5iKL1tflp83IUSNn/z3JIjWng98Y
         6RfpzxV5XfPWxGKOX4DdYV/wLmmlXNt332CwEYLgb9fOwCusASfTkzDGq48OmDuUGGpq
         tIsA4gMM5D4jkK0NC3tYS5RarJ0ZWQtkI1tM39+DRuLci+gK44bt1F+fDRaPwS3T5T9g
         S4uLRylS37AnplaeXGFnk7T6Qzad8RMawrqwBO6UKOhHtptnemCZZZWNN4xJh7uqqhEQ
         vrGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681764804; x=1684356804;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uzUB7crKqn7Of69Iz0IiuKaVcaC8bpzNVtqjj02cJJs=;
        b=NketLXvM9KdTiPl7GlemDb4c98WbraKD4nEOLF4bapkS+5IILfhbGkcvRTG2731F+J
         Y0XXXbyyunzgjKxvBxhGVK5PZoIROsjfmDLnesSR70tlPInw6B4BbyDfFiGgdeW83GCG
         cHbts9uB8RNifYrXkMrNsLvFvtZWd3n7eC5rWyGm+ceSnlSxSe8magiItJ+0lrrIOQOe
         i3o0YVt0Ov/GAWofjteLoNpW1MJoULfyhln0mmpFBA8Su4bXrtRslkEJrS++cW3rFNo2
         pQNtKmnCkpejlXX7sEhwLea/wM6n8aHLTS4YpC0B4L1F9Qtw89cTM+lKX3PXNFl1ss6C
         g6aw==
X-Gm-Message-State: AAQBX9cCsFCLn1epmptCc9y2alGatfiSkVh2jinr9TFUF11lYpYEArAX
	EBqtN4lhCn487ORqax+xaRs=
X-Google-Smtp-Source: AKy350avL9PdXaEjhmJuV1ybk5n54BLKq2822oDesoZKEo2GpNTKDMiGoy71eNPEPZjYfA/nM1qr3w==
X-Received: by 2002:a17:90a:1286:b0:246:bb61:4a5b with SMTP id g6-20020a17090a128600b00246bb614a5bmr16053424pja.8.1681764804243;
        Mon, 17 Apr 2023 13:53:24 -0700 (PDT)
Received: from fedora.hsd1.ca.comcast.net ([2601:644:937f:7f20::c139])
        by smtp.googlemail.com with ESMTPSA id h7-20020a17090ac38700b0022335f1dae2sm7609707pjt.22.2023.04.17.13.53.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Apr 2023 13:53:23 -0700 (PDT)
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
Subject: [PATCH 28/33] riscv: Convert alloc_{pmd, pte}_late() to use ptdescs
Date: Mon, 17 Apr 2023 13:50:43 -0700
Message-Id: <20230417205048.15870-29-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230417205048.15870-1-vishal.moola@gmail.com>
References: <20230417205048.15870-1-vishal.moola@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230417_215329_246733_4E00EC62 
X-CRM114-Status: GOOD (  11.39  )
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
these to use ptdesc_alloc() and ptdesc_address() instead to help
standardize page tables further.

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
---
 arch/riscv/include/asm/pgalloc.h |  8 ++++----
 arch/riscv/mm/init.c             | 16 ++++++----------
 2 files changed, 10 insertions(+), 14 deletions(-)

diff --git a/arch/riscv/include/asm/pgalloc.h b/arch/riscv/include/asm/pgalloc.h
index 59dc12b5b7e8..cb5536403bd8 100644
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
+	ptdesc_pte_dtor(page_ptdesc(pte));		\
+	tlb_remove_page_ptdesc((tlb), page_ptdesc(pte));\
 } while (0)
 #endif /* CONFIG_MMU */
 
diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index 0f14f4a8d179..2737cbc4ad12 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -346,12 +346,10 @@ static inline phys_addr_t __init alloc_pte_fixmap(uintptr_t va)
 
 static phys_addr_t __init alloc_pte_late(uintptr_t va)
 {
-	unsigned long vaddr;
-
-	vaddr = __get_free_page(GFP_KERNEL);
-	BUG_ON(!vaddr || !pgtable_pte_page_ctor(virt_to_page(vaddr)));
+	struct ptdesc *ptdesc = ptdesc_alloc(GFP_KERNEL, 0);
 
-	return __pa(vaddr);
+	BUG_ON(!ptdesc || !ptdesc_pte_ctor(ptdesc));
+	return __pa((pte_t *)ptdesc_address(ptdesc));
 }
 
 static void __init create_pte_mapping(pte_t *ptep,
@@ -429,12 +427,10 @@ static phys_addr_t __init alloc_pmd_fixmap(uintptr_t va)
 
 static phys_addr_t __init alloc_pmd_late(uintptr_t va)
 {
-	unsigned long vaddr;
-
-	vaddr = __get_free_page(GFP_KERNEL);
-	BUG_ON(!vaddr || !pgtable_pmd_page_ctor(virt_to_page(vaddr)));
+	struct ptdesc *ptdesc = ptdesc_alloc(GFP_KERNEL, 0);
 
-	return __pa(vaddr);
+	BUG_ON(!ptdesc || !ptdesc_pmd_ctor(ptdesc));
+	return __pa((pmd_t *)ptdesc_address(ptdesc));
 }
 
 static void __init create_pmd_mapping(pmd_t *pmdp,
-- 
2.39.2


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
