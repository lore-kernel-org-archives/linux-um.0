Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8BCEC77B73
	for <linux-um@archiver.kernel.org>; Mon,  1 May 2023 20:40:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=U2I+aMqN+pCwfOjS16XJpZgnKz0BnOScd7SXyv6wOvY=; b=u5JO4fgOsDHe0y
	wVCsD9ihdmKQ42X1ZP5Sa6XNBJCOlIY2XNVXCf4S2+MMi7nLgyUCXLlwXONo+0TMw3QY6h60ps+EH
	pBzMDFusG0QI4qBWgPAvfWIVNcEBYBwdGl1oHAmbjlwvD26jCH5wjmWOY2dDdvEq4DUYFsjMfkUmC
	8tG2gOKJojmWHRgRxrnEA9rddT5x60RdbTQ91CI1ns6p5Dnzv8i9TUMe8/C2nZOPTVJp86vZjSw+g
	4Spg9z/2967sIYfZ9GAKGuru6xV2pNpkB6b679o093OnUfdyUjbp5s8tf14O3UpZ782sdplOPJzBe
	n6+3HMZUSvnVa0I5MUXg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1ptaK0-00Gu2S-0i;
	Mon, 01 May 2023 20:40:32 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1ptaJx-00Gu0J-0U;
	Mon, 01 May 2023 20:40:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=l1ckLKbyzk3TycCfORfJ/TBkh9kewWK+wgbsmWovkLc=; b=ckhc9TKSMzk00fsYD8C/aKQtoA
	m/CEdKAXuHAqdEtbklu1P/+kpT3ziEi7Z6Fjol8PLw/bgw7aX/eqrAgeASAHhKoK7Bm/Di/Tn+PYT
	4M2v61plaWEHtgSf0iW6gTqjjBs8b/iAU0jZT9xUrGg+Va/leBixh+d4pew/Yh8D2+hWlEsJEuxAP
	XV3k36yq2KlMwrcMOU4gzKWsbducGxqsq460+/rbTeBZixekcmFtJCWZZbISgnqiysWGxidAE+tAe
	xQkzDJP8EM9zdBLPDldGqJjVdtV70L039FYFRAYb/XjK/TDoR6xesvr089eYF1TYFHzYKrDs+6yg7
	u95pOD/A==;
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
	by desiato.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1ptZD3-00Ez0f-24;
	Mon, 01 May 2023 19:29:19 +0000
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1aaff9c93a5so6145205ad.2;
        Mon, 01 May 2023 12:29:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682969357; x=1685561357;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l1ckLKbyzk3TycCfORfJ/TBkh9kewWK+wgbsmWovkLc=;
        b=QOhINfLsJScPCSo/IfeyIyqWMqeIs48D8yaoqlS6ttjMbmNZXsD0pl2iRSwsAXqRrv
         zUUJOXK9c/ejP/aK8PhIumKGyTM6wx4FMhZyB9B20DcTQunSql+VvjSwHErAI8TxAw4R
         Y99zvhqhTYwxHGbhjSdsPxRy9B+yD0izY9vTuFFo+4wz8Jz2C37zAT+8c8EYp2fDz24U
         oGrB6CUieeF0SbwTG14XhJhloKyt3nzbHvCyZJJU6u4aL5aKMUavEI+jK4qMtp6ZB84A
         TmLf+lTqOkVGEF+wZ1coiBesyT5OIE5Gk6hWNsWKJwTKVv0S28KrIjiosst3fU+17ZhU
         2bkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682969357; x=1685561357;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l1ckLKbyzk3TycCfORfJ/TBkh9kewWK+wgbsmWovkLc=;
        b=Rcv19Cfq8FML/z/FVLzj8r+Sif1PoLBsI/u694gPcpJJosv03i2wPv0TtCePeWA95K
         6lF3sDfW1OlSVBEmAtmxKsoiEGo79dZjGHqI1Jvc1aKEUP64kn/TLkOA3q6W0R0ZI7bM
         l20WUtPPyAsY5s+gdnV3En5fFBpHXEqKJJZdN4gilLmGIrHUx8XCpASazMCqxq/RfnLC
         zDl5JeYbAGBl4CFUIZJpInWRKoOMyihHafp70Pjcx41HVTYj0MxyWYNleqOiZuPX4AYC
         ep83VhaSGfdn8YRIryMpTPWa71ZHtkwQbwUC3EJ/MaYCMhY0sn4pQZaB0RDbRZSNV+rQ
         +joA==
X-Gm-Message-State: AC+VfDyX5Sg74SY13+ce9pvtsZMhJUwTJDKfk2IkSoB7kfprdyWZ7sxh
	xAu8UVFF7jjhhRBXI8DCSdo=
X-Google-Smtp-Source: ACHHUZ5ad9gvhcfa1XbL+pCFsXQ41wyEuU00A0VqKiT0180mGKgTi8tTwjBbR7r20yn6kHE8l0iQaQ==
X-Received: by 2002:a17:902:ce91:b0:1aa:ef83:34be with SMTP id f17-20020a170902ce9100b001aaef8334bemr6350222plg.47.1682969356855;
        Mon, 01 May 2023 12:29:16 -0700 (PDT)
Received: from fedora.hsd1.ca.comcast.net ([2601:644:937f:7f20::9a2c])
        by smtp.googlemail.com with ESMTPSA id u8-20020a170902bf4800b0019c13d032d8sm18175622pls.253.2023.05.01.12.29.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 May 2023 12:29:16 -0700 (PDT)
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
	Paul Walmsley <paul.walmsley@sifive.com>
Subject: [PATCH v2 29/34] riscv: Convert alloc_{pmd, pte}_late() to use ptdescs
Date: Mon,  1 May 2023 12:28:24 -0700
Message-Id: <20230501192829.17086-30-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230501192829.17086-1-vishal.moola@gmail.com>
References: <20230501192829.17086-1-vishal.moola@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230501_202917_976132_8D642968 
X-CRM114-Status: GOOD (  12.20  )
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
index eb8173a91ce3..8f1982664687 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -353,12 +353,10 @@ static inline phys_addr_t __init alloc_pte_fixmap(uintptr_t va)
 
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
@@ -436,12 +434,10 @@ static phys_addr_t __init alloc_pmd_fixmap(uintptr_t va)
 
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
