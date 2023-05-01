Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7D35C77B7C
	for <linux-um@archiver.kernel.org>; Mon,  1 May 2023 19:47:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=wgIRyDc7C1HD/0a3cvgQ+JAsWu+yrOvGtDnYdiMATpo=; b=WYA0+Hzth/yrxH
	qG5xZNEtFtp8mLTKWCXQ5H19K5YUJpYmuxjiFO96e5976txdLMchpu2m/0Aa727cjDgw34ssbA/io
	AkTqIhrFHSyYdELihXT4hiSl0W9XVfMiMlU9D5M4pDo9iFTANOVnZtWRKtw3qgx4gR2kB68FgaOkj
	4Nhm57+xOwPP6qIZNVbw+rbMFoV7R9/jKgfwfxGNQ9kiYsYZnk+MCjNsqJuQehzRNCSjhCZeh3lUP
	3sbS2iJJorDyppFucDjSA+7So2p1X1hhWqYiNqbrQoJdn3ykn6DitXlBhI1BJuMk6ugeEICMMpPDk
	tx9GBYvrZDZLrOy1kQvg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1ptZUw-00GlYq-1s;
	Mon, 01 May 2023 19:47:46 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1ptZUe-00GlDP-2Q;
	Mon, 01 May 2023 19:47:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=gfpIRfFq9zSU9T7uNfhlcYr/W6dIxhZkZgP28wF3SDA=; b=IrtxjewI3M5+k4K2MYJeKUJb6H
	tdZ96KlQTxi8CzDRkS+ByXKZ6NasmxIfL7XPWBqdaBGMTHD8Co0OgAGOtk1bd0yNR86fV/+mC2etn
	F6UqXj11Jdgjovtq6Dz0GThLizTR1LgwE6rXOASSiEmQyAL1Esd/AUIUW6eQliEC+EjRo9xC0bAhO
	3np6VXTXYGU/XngAJAwTfscG9aF/H21lVLBWFE6mKDdB5L++TcnjY2I44ox2YE4nPFixG9iAvqYX0
	QB1aCmksPOC3Lq707kh/kOlCKyExEOYgFNQMH8jO03GVH0c3x9nnh6GMqnxR0SuUB9Bahyl1tIlqs
	Q9txDYBw==;
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
	by casper.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ptZCr-007cqP-4u; Mon, 01 May 2023 19:29:07 +0000
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1aae1bb61edso21694105ad.1;
        Mon, 01 May 2023 12:29:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682969343; x=1685561343;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gfpIRfFq9zSU9T7uNfhlcYr/W6dIxhZkZgP28wF3SDA=;
        b=Qau1TBSyVipNmef8PNT07M/JoK5y55d5cqgZDlN4vhhP79tr9yaRETSYXvwSfxkzpQ
         1wzTUy/T5LzAEZJEeUbvFZuE+VickGgRQkGj6paYz1jDOFsUn9ZCDLvNYYI/Zyr2RUmg
         bm3l9m5jLCH0toRw7+aEb6gYmXflBLWLMpuQeA0OVXisZ1A5osNX02KzemiZmkdGT+6d
         H7+k3mn0V3HtUXPo/S8coTYf23tz7uGdOWK0nFPfjqqe58njMrJom/cuk3n4mMysX8dy
         jTZaIlbFQNlLjrIuXwQgtdhVp6dM9pTxTSdYHIHgZYka1AJxhJpIcTRf9fC09oM2h4fK
         Ax0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682969343; x=1685561343;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gfpIRfFq9zSU9T7uNfhlcYr/W6dIxhZkZgP28wF3SDA=;
        b=TAAA0d/D2WKBuBO8H2O2UoHCoGP0F87FFo3FJGtVNQVZiLa062aZMmfyueg95xgc4G
         WObzTSDYyA6R2JYzkSmyw/on89y6Pc6xUZ8oEtURI35Ii3amPoVOmjRnYMZyftPXpQiE
         +uVzj1Tz+GBrv4KmETjvKtks7mCuL9QPJpMtzrbFJy9HjqzA4VPKzfL638eUzg0vv8vU
         LD+IWOy4+JgVit7BRIqb7nRmRhTa/kkRVBdS/QTydpfcg6jtjoRPHB7ZOa+Edw32fwqi
         WawhoIKjVZjG/bl3cS2f/4mg1wWCIj39BKXjvBsUTpdZTxazuYuJ1sf1c3puYhViULzb
         8MWQ==
X-Gm-Message-State: AC+VfDxlbRJRMNngzsxvcxHdowLgKbfl4WEt/uxezKfo8qLbp9rsFU9I
	3jafUsACR0Y0nN1ncHwaCKI=
X-Google-Smtp-Source: ACHHUZ7gDAee3JEsjrpH2Z6atN7OAzqWZ2l6e0m4gqF7AbuDA0ihHMvj1UGUNCCunfz91CTNrFO0iw==
X-Received: by 2002:a17:902:e547:b0:1ab:8f4:af3a with SMTP id n7-20020a170902e54700b001ab08f4af3amr217267plf.39.1682969342957;
        Mon, 01 May 2023 12:29:02 -0700 (PDT)
Received: from fedora.hsd1.ca.comcast.net ([2601:644:937f:7f20::9a2c])
        by smtp.googlemail.com with ESMTPSA id u8-20020a170902bf4800b0019c13d032d8sm18175622pls.253.2023.05.01.12.29.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 May 2023 12:29:02 -0700 (PDT)
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
Subject: [PATCH v2 20/34] arm: Convert various functions to use ptdescs
Date: Mon,  1 May 2023 12:28:15 -0700
Message-Id: <20230501192829.17086-21-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230501192829.17086-1-vishal.moola@gmail.com>
References: <20230501192829.17086-1-vishal.moola@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230501_202905_221086_7131AC77 
X-CRM114-Status: GOOD (  12.31  )
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
this to use ptdesc_alloc() and ptdesc_address() instead to help
standardize page tables further.

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
---
 arch/arm/include/asm/tlb.h | 12 +++++++-----
 arch/arm/mm/mmu.c          |  6 +++---
 2 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/arch/arm/include/asm/tlb.h b/arch/arm/include/asm/tlb.h
index b8cbe03ad260..9ab8a6929d35 100644
--- a/arch/arm/include/asm/tlb.h
+++ b/arch/arm/include/asm/tlb.h
@@ -39,7 +39,9 @@ static inline void __tlb_remove_table(void *_table)
 static inline void
 __pte_free_tlb(struct mmu_gather *tlb, pgtable_t pte, unsigned long addr)
 {
-	pgtable_pte_page_dtor(pte);
+	struct ptdesc *ptdesc = page_ptdesc(pte);
+
+	ptdesc_pte_dtor(ptdesc);
 
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
+	ptdesc_pmd_dtor(ptdesc);
+	tlb_remove_ptdesc(tlb, ptdesc);
 #endif
 }
 
diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
index 463fc2a8448f..7add505bd797 100644
--- a/arch/arm/mm/mmu.c
+++ b/arch/arm/mm/mmu.c
@@ -737,11 +737,11 @@ static void __init *early_alloc(unsigned long sz)
 
 static void *__init late_alloc(unsigned long sz)
 {
-	void *ptr = (void *)__get_free_pages(GFP_PGTABLE_KERNEL, get_order(sz));
+	void *ptdesc = ptdesc_alloc(GFP_PGTABLE_KERNEL, get_order(sz));
 
-	if (!ptr || !pgtable_pte_page_ctor(virt_to_page(ptr)))
+	if (!ptdesc || !ptdesc_pte_ctor(ptdesc))
 		BUG();
-	return ptr;
+	return ptdesc;
 }
 
 static pte_t * __init arm_pte_alloc(pmd_t *pmd, unsigned long addr,
-- 
2.39.2


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
