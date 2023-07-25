Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8691EB64DD
	for <linux-um@archiver.kernel.org>; Tue, 25 Jul 2023 04:23:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=HztBWag1ntkeJiDDuVmLLqaVmPkW2mwCBtL3dBLcxfo=; b=N/Xjx0qQSjV/8f
	OtVzat7DhnWlwlNCzJzBAaW8j2zjGx1ZD/k0J1aDZ5mnf07CcgHgpxOI0mT+U/zT86ovuV/w8kI2/
	nVuAyHKkNlJ2Hg3L1FzMuP6ZfeP1JHfeXLDLP2q+3kFhWEi+d+yvykczxUyNKcynjn7EiXL7XYQF4
	hwMq2UPdYRxRT/vtqQUavwgmzSpWOvvDj2kSE5VUHuG61ySuX3qNGqQkY9VVWsgkyZp/QkK9UDGmT
	n/nMH0GlPYCI8ksMAXnJJBHnGTVGUUOa2M7UlJQNK57A7zaxJJat/PYT4RWtRAdNPb/ezGp8Q1Vmb
	V1OgO4kezenE6vEWt9eg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qO9aW-0069Lg-19;
	Tue, 25 Jul 2023 04:23:56 +0000
Received: from mail-yb1-xb2a.google.com ([2607:f8b0:4864:20::b2a])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qO9YN-0067TV-0J;
	Tue, 25 Jul 2023 04:21:45 +0000
Received: by mail-yb1-xb2a.google.com with SMTP id 3f1490d57ef6-d129edb8261so1958185276.1;
        Mon, 24 Jul 2023 21:21:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690258902; x=1690863702;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jHkn+4hWn6cNWfQmftBQOtWQYQb9iJJIYcRZZNmu6iY=;
        b=YmaPL1Vi+BQChOKWGw1MlFqz3AIULFncYrkFnUsVyfilrIdeasoH5GHm0MEpRXKgmq
         DwC9KwXiAQ3MN8gwuAbymt06/p5z+8sYZZRmtF0QZ8N7W0KJLZlIdtmS/iEXcHfRR9pY
         2ULSywNr2+fCENRH3Q/SedxdAZmlqvHkU4bXO0Iy6mLyj0C0e7FNRd96oXnepKXsjgBp
         DVfpoX3+8pHS5yXYZY0DswmNPSsrKwOikBQLnb77xz8k9ebKbrK+QxqOENWwGszD02R4
         u3nvQUFC/AuDK1NFsePOhCwUQCv2T+yjXJkyc6tTHY68z6Qz4nIbLO6jQDPO+Xjl6VQM
         RJag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690258902; x=1690863702;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jHkn+4hWn6cNWfQmftBQOtWQYQb9iJJIYcRZZNmu6iY=;
        b=izr0cY7N7hTIaEJ5B1CEitUkDfoz6+3vyuziryGPn+DaLg5Hik3toOuL/chNlBK9Zj
         fqNIMWY2C5gh1twJ20v7xslNrjc6m1LzeUb2Ehki5+l+nWmnVAo8mEriLzSvulHAWoJw
         NOQPhXNoJvrPc6imAlHaLvytDTF4S8XBluQze8CThLFZvRLUvTiyWT2VXuTKVJBToWL1
         a5l7B5/5+SCSDKhHKXHtEVe8P43MPJwHQWn/4710HP3SKceP9q1Q7WzVGnHJIxD+PHSu
         8SKmqyG0gsKB++3u3vSd+YGzlElgljO5yU+V+dvGkbHsR5p1KPEMhDM63i+NFrQF2bxV
         z58A==
X-Gm-Message-State: ABy/qLZZdPtIMW9PRb1NKfdyWYhTZiL8FJkl1JeiKXr7TfcuA/BFPMiC
	aLLj2mBmW/p3d4G5lEn2JqM=
X-Google-Smtp-Source: APBJJlF19R+0iLSXwcqdh2p0QPj8gjsaDLf4/piQLSANpJDw+A6xil+mrxUfv/BGU2XCVUHQZlpYDQ==
X-Received: by 2002:a25:dbce:0:b0:bcf:e2a6:7085 with SMTP id g197-20020a25dbce000000b00bcfe2a67085mr1287878ybf.23.1690258902247;
        Mon, 24 Jul 2023 21:21:42 -0700 (PDT)
Received: from unknowna0e70b2ca394.attlocal.net ([2600:1700:2f7d:1800::16])
        by smtp.googlemail.com with ESMTPSA id h9-20020a25b189000000b00d0db687ef48sm1175540ybj.61.2023.07.24.21.21.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jul 2023 21:21:41 -0700 (PDT)
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
Subject: [PATCH mm-unstable v7 17/31] arm: Convert various functions to use ptdescs
Date: Mon, 24 Jul 2023 21:20:37 -0700
Message-Id: <20230725042051.36691-18-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230725042051.36691-1-vishal.moola@gmail.com>
References: <20230725042051.36691-1-vishal.moola@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230724_212143_170972_3A1BBB12 
X-CRM114-Status: GOOD (  12.84  )
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
