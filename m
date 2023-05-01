Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61BC3C77B7C
	for <linux-um@archiver.kernel.org>; Mon,  1 May 2023 19:47:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=jT9xjAxOqutc5Qmuks2OJBVO+owwzgK4WneuAZ/L4BY=; b=oUQpbfqx6QE0p4
	Kfp0xo1AmO2p3mfPlndtUCW5t7XMp/hnXrqUVFrDua14AEvLpThLsiQbKMN9ryTZt5nApQLvSt3Yw
	2jZ/kQiMA/BfFEtAPtAe8q7K84na30I8W0ZhabG0USte+sw8wit/iNdu1l4NU8//9q1iWdVl2dbYx
	3q9ZxuOprVHS6dQLfpnfKk/OfONBib33LBKstgoocFS4e5sEQa0uw0DqKsZV3OyO2Y1TCkMBbNGZ0
	P2SoXKt8/ZOm9TkZy6IHB9T256+eA16ZlmU12Q6AdskOsOobEGFcZBGmtfDaaoK/zerPu/K/00BZA
	JRecxh7kCAdlM2R3Gokg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1ptZUl-00GlMw-2Q;
	Mon, 01 May 2023 19:47:35 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1ptZUc-00GlDP-0K;
	Mon, 01 May 2023 19:47:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=kyicI3UFSJTH3R33HGjLFGEyUDrTPXlIkqJCgIfzdrc=; b=MnxrByItDKEc/0cAZtjj6hLFgg
	cfNxVsvyK+23BA0sJWwSFx6k91SifWc5omBtJUgSokQyOsBqMEynQySCDztzbys7YYTlsQvFHiwRR
	rv80WYjVtju8Xt9RxHtT7snaXsAuVDAnnGuUUCI6Ex2Ds/DIuo317pG6RPlVAEWttaEgMhx4oMBfu
	Gew8l7NxJANOIIPEp4RVEdhdec0ZdQPnDy2gpS/mpxNEFYsqU21LcVg0gh7dIDV1pQfO08PVlexSF
	BE5OhhP7ccwMLjb6i0VftZpq9uZb8QH7t5vZw9kCgoDnHbPepfEuJGFPhTMZdAJkGD/7REJySM3My
	sUiRw0LQ==;
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
	by casper.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ptZD0-007cuC-3b; Mon, 01 May 2023 19:29:16 +0000
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1aaea43def7so13449405ad.2;
        Mon, 01 May 2023 12:29:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682969352; x=1685561352;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kyicI3UFSJTH3R33HGjLFGEyUDrTPXlIkqJCgIfzdrc=;
        b=bIC3wiMrkZ043YRG29tisEfS2j+UeOAsmyII3EDzrldtjEb8icghvzgUTYdQYM4doj
         vdu0JKDKQcL03t0/j67MJsK3EMdVvlx3Lc/9NrJJJYh+5KdPrYzRKBiHtTGqpBRhkA5a
         ZboUsEenHMS9VrUn3gKI66CrCL9Z8GCruZLIMyl89zj2oR4Tg7uJGI/BsPQUk9uXq4w7
         IEqVWzOt4YqC8i9AxlAbu1JP49n5XnekAOLER4FSWBBd0M0ka47bttpu+oGYYPDkowKQ
         ep35YwloCTCGYeII4Pobz7D0t4NcJCq50AMppyxrvfN/Wt0IBRqMUSxoDgh1JHSYp5Pm
         g50g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682969352; x=1685561352;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kyicI3UFSJTH3R33HGjLFGEyUDrTPXlIkqJCgIfzdrc=;
        b=kam0jzN6Ziz+Bbd2W3QX/ybKYjACWUad4prWt6YggxY8XTtFLKP1BEO6VaSOc9ozjj
         3HgwCVDq4DW01ENtwdrAgVTfxk7e9qZpoPi09+mlVzaPYod4cRY5JWfvOWfJrlkT05m4
         lKgU2N2+ChMYGWAWi+8TPzW0ZUaL4kHjo1bQHMs3hSb+BpnNDhz17d+RqxVr5d99WIa4
         uFgl+dk+0McelKs+yYEMtsfYVyNdlpY7GI5ptNT/tqf0XwuSQwzyvKfeFWpD4NrWkt3i
         M7HmzJPbF4tcLO0S5MLDR4cPHvHjcZaGOMrHV4jzW/dDvel1LtcjESbMvmLmabu5/KgE
         bXSg==
X-Gm-Message-State: AC+VfDzY6oto8s0UX3/xKfjE4a2KHAVeksmunkCtqDpPCXbC30N2vJVm
	32ogGLslWeLRcLJZMr4mpLQ=
X-Google-Smtp-Source: ACHHUZ6JGwiASceIv2N+eQzagLfWHlR6lj5LsM9PIBmbvfqlnJYs1oK6NLyKl7E/zGC8k10AZHOifw==
X-Received: by 2002:a17:902:ea0b:b0:1a6:3b9c:7fea with SMTP id s11-20020a170902ea0b00b001a63b9c7feamr19311944plg.36.1682969351902;
        Mon, 01 May 2023 12:29:11 -0700 (PDT)
Received: from fedora.hsd1.ca.comcast.net ([2601:644:937f:7f20::9a2c])
        by smtp.googlemail.com with ESMTPSA id u8-20020a170902bf4800b0019c13d032d8sm18175622pls.253.2023.05.01.12.29.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 May 2023 12:29:11 -0700 (PDT)
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
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Subject: [PATCH v2 26/34] mips: Convert various functions to use ptdescs
Date: Mon,  1 May 2023 12:28:21 -0700
Message-Id: <20230501192829.17086-27-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230501192829.17086-1-vishal.moola@gmail.com>
References: <20230501192829.17086-1-vishal.moola@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230501_202914_182520_A9346F1B 
X-CRM114-Status: GOOD (  13.17  )
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
 arch/mips/include/asm/pgalloc.h | 31 +++++++++++++++++--------------
 arch/mips/mm/pgtable.c          |  7 ++++---
 2 files changed, 21 insertions(+), 17 deletions(-)

diff --git a/arch/mips/include/asm/pgalloc.h b/arch/mips/include/asm/pgalloc.h
index f72e737dda21..7f7cc3140b27 100644
--- a/arch/mips/include/asm/pgalloc.h
+++ b/arch/mips/include/asm/pgalloc.h
@@ -51,13 +51,13 @@ extern pgd_t *pgd_alloc(struct mm_struct *mm);
 
 static inline void pgd_free(struct mm_struct *mm, pgd_t *pgd)
 {
-	free_pages((unsigned long)pgd, PGD_TABLE_ORDER);
+	ptdesc_free(virt_to_ptdesc(pgd));
 }
 
-#define __pte_free_tlb(tlb,pte,address)			\
-do {							\
-	pgtable_pte_page_dtor(pte);			\
-	tlb_remove_page((tlb), pte);			\
+#define __pte_free_tlb(tlb, pte, address)			\
+do {								\
+	ptdesc_pte_dtor(page_ptdesc(pte));			\
+	tlb_remove_page_ptdesc((tlb), page_ptdesc(pte));	\
 } while (0)
 
 #ifndef __PAGETABLE_PMD_FOLDED
@@ -65,18 +65,18 @@ do {							\
 static inline pmd_t *pmd_alloc_one(struct mm_struct *mm, unsigned long address)
 {
 	pmd_t *pmd;
-	struct page *pg;
+	struct ptdesc *ptdesc;
 
-	pg = alloc_pages(GFP_KERNEL_ACCOUNT, PMD_TABLE_ORDER);
-	if (!pg)
+	ptdesc = ptdesc_alloc(GFP_KERNEL_ACCOUNT, PMD_TABLE_ORDER);
+	if (!ptdesc)
 		return NULL;
 
-	if (!pgtable_pmd_page_ctor(pg)) {
-		__free_pages(pg, PMD_TABLE_ORDER);
+	if (!ptdesc_pmd_ctor(ptdesc)) {
+		ptdesc_free(ptdesc);
 		return NULL;
 	}
 
-	pmd = (pmd_t *)page_address(pg);
+	pmd = (pmd_t *)ptdesc_address(ptdesc);
 	pmd_init(pmd);
 	return pmd;
 }
@@ -90,10 +90,13 @@ static inline pmd_t *pmd_alloc_one(struct mm_struct *mm, unsigned long address)
 static inline pud_t *pud_alloc_one(struct mm_struct *mm, unsigned long address)
 {
 	pud_t *pud;
+	struct ptdesc *ptdesc = ptdesc_alloc(GFP_KERNEL, PUD_TABLE_ORDER);
 
-	pud = (pud_t *) __get_free_pages(GFP_KERNEL, PUD_TABLE_ORDER);
-	if (pud)
-		pud_init(pud);
+	if (!ptdesc)
+		return NULL;
+	pud = (pud_t *)ptdesc_address(ptdesc);
+
+	pud_init(pud);
 	return pud;
 }
 
diff --git a/arch/mips/mm/pgtable.c b/arch/mips/mm/pgtable.c
index b13314be5d0e..d626db9ac224 100644
--- a/arch/mips/mm/pgtable.c
+++ b/arch/mips/mm/pgtable.c
@@ -10,10 +10,11 @@
 
 pgd_t *pgd_alloc(struct mm_struct *mm)
 {
-	pgd_t *ret, *init;
+	pgd_t *init, *ret = NULL;
+	struct ptdesc *ptdesc = ptdesc_alloc(GFP_KERNEL, PGD_TABLE_ORDER);
 
-	ret = (pgd_t *) __get_free_pages(GFP_KERNEL, PGD_TABLE_ORDER);
-	if (ret) {
+	if (ptdesc) {
+		ret = (pgd_t *) ptdesc_address(ptdesc);
 		init = pgd_offset(&init_mm, 0UL);
 		pgd_init(ret);
 		memcpy(ret + USER_PTRS_PER_PGD, init + USER_PTRS_PER_PGD,
-- 
2.39.2


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
