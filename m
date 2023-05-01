Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07EA7C7EE24
	for <linux-um@archiver.kernel.org>; Mon,  1 May 2023 19:47:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=kyvMQ3j68E0hthAtQhw0LXat3s0NLNNVAXbdDSV8dWY=; b=0Ufq+Y7PJMbaPN
	4+ptbYfd7ZlYu1UmFylTwjtr0EMj0zeGseM+iX2/gqM2r/xqkgsucXoceE+JvrdnuXvnZ4BU5HX/e
	18y+5bUH6pdzzwkoOHD4MDyLpQrJRI9YWFrpOKsAs25A6GF3o41LXGjs3jTsW+q8ZTBRKGPfzeAJd
	0xc+guwZ1SAR5CMW0+/oVNnS9Vli/11+MC3ip9bItPs4rCtr8Nxe3wCCnvA/222Sr3MYOvak42meQ
	S+UyxvYWacET6XFickcTdmee2GdTfLIuBZj+vSSAXUN88H8CPqiwsvhrbdA+i1CAwGo95h24GmfgA
	hovT4yjnCWhtZJvkuMcA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1ptZUq-00GlRl-1o;
	Mon, 01 May 2023 19:47:40 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1ptZUc-00GlDP-2w;
	Mon, 01 May 2023 19:47:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=Pf7K/iFMD6od7/SRYpuPsYcodkkXMgOdjXv5YJvZldk=; b=jbJVUxtW4ozkclh1LEMb4VXnrK
	1/ljc2/FsNKNtAraP8NCEsG7EMbE8/BEmaAnyaFFuGV5rSwfC3YH3Z2xVL4UkXYJyaMqIASChLEaJ
	c12/OUAJLz5g5R1AOENs9TZ7H7uEiy+Ly0tF9hWB/9J4bLDjmcfoFVRi6YNMdOysfrPSu/WJD6Dx2
	9ubkCd2j7D4Km99F0E0nic4pbwEhuLB3Ro4MFgbnoAsCnSsQteiMmH2Fmet5vBZ4JSzdqmlnqfokV
	9Pyr9nyA7dpkg+m7E57Ii4EwJbgQcg1Cv9xv5KaloHRDxnEuBSHesZXQCJz43l1eWCiKiJ4uGUAPi
	t3T+WWaA==;
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
	by casper.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ptZCx-007ctF-Oo; Mon, 01 May 2023 19:29:13 +0000
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1aaea3909d1so17753455ad.2;
        Mon, 01 May 2023 12:29:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682969349; x=1685561349;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pf7K/iFMD6od7/SRYpuPsYcodkkXMgOdjXv5YJvZldk=;
        b=Ln4mDR/5PqhQgedxrHvQljALDEWoa3b+hRIGv35D/XEQopkojKeYky16q/KJiQP190
         gOXMLkWlsxRYt/qNbMMHduRgO5rwSHkWxXdTawxJdNC4w4aAhizbEp/u5yJIFvo+hvkC
         CzCza/yOOV7wQ3CRXlPMEZ6eMm1zhczAF9AJlp92How5r4l3oEpl8xhmNNQZ5IRuQriJ
         5iq8Jlorps05Qifajbp6RIvsWCW3JV3LIBqvQ7RLXCzoWQn8RP/izc4h1lgdgQ7smZ+o
         cGeex+nu9iv1OEbJv0WRRlF1TRZ+PJHxnItl8vKiR8iqu8w5u+UliAsQ4ZVuON7yHbns
         fmHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682969349; x=1685561349;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pf7K/iFMD6od7/SRYpuPsYcodkkXMgOdjXv5YJvZldk=;
        b=YMayV3+7jM1PJppAdwH5OPQ48os6by0JJpHDVAOfJVrrjdcorjot6ADXxmS8LauNaL
         ta0n602vpfRrqzF7dLKfedjLDTZ/uIOCz0ZsaBnf8oDTU7cZHAo0Tuv/cCPFmuBaSmJA
         3zAOlQYToVDP1S826FJx1FszrM1exYbDgOXcVdZpleZsp4o8AKQzmaxp7V3RLUJwY7Hv
         c3EzoHn8Z9XcTGFISxhuVzoHBCOBxhO+Cq1YMCpgBa3lLxt00ggTkHrRJTeNG+hHWQH/
         HgMLqEADuIZYhVRaMoChTxJqD+Z8Gki8DzqawuodzuUxUBxKu+ThF/tp+l6cCRUnEAgu
         32rw==
X-Gm-Message-State: AC+VfDyMiE2FXbbdNVKqqQLBzB6MoAxwkc6LnTyQfxea+U/txS3395+j
	NnTIZho1V+XGmEmWKa+yEfg=
X-Google-Smtp-Source: ACHHUZ4pGEgDP0ct3SBtbJjK9qWlsOBNKoJkb8hPo4/muNsqGBXZA1NHW06v64HPJmj4Ckit7F5PBA==
X-Received: by 2002:a17:903:2352:b0:1aa:ed6f:29c2 with SMTP id c18-20020a170903235200b001aaed6f29c2mr6827893plh.11.1682969349038;
        Mon, 01 May 2023 12:29:09 -0700 (PDT)
Received: from fedora.hsd1.ca.comcast.net ([2601:644:937f:7f20::9a2c])
        by smtp.googlemail.com with ESMTPSA id u8-20020a170902bf4800b0019c13d032d8sm18175622pls.253.2023.05.01.12.29.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 May 2023 12:29:08 -0700 (PDT)
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
	Huacai Chen <chenhuacai@kernel.org>
Subject: [PATCH v2 24/34] loongarch: Convert various functions to use ptdescs
Date: Mon,  1 May 2023 12:28:19 -0700
Message-Id: <20230501192829.17086-25-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230501192829.17086-1-vishal.moola@gmail.com>
References: <20230501192829.17086-1-vishal.moola@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230501_202911_850749_C33EF46A 
X-CRM114-Status: GOOD (  13.25  )
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
 arch/loongarch/include/asm/pgalloc.h | 27 +++++++++++++++------------
 arch/loongarch/mm/pgtable.c          |  7 ++++---
 2 files changed, 19 insertions(+), 15 deletions(-)

diff --git a/arch/loongarch/include/asm/pgalloc.h b/arch/loongarch/include/asm/pgalloc.h
index af1d1e4a6965..1fe074f85b6b 100644
--- a/arch/loongarch/include/asm/pgalloc.h
+++ b/arch/loongarch/include/asm/pgalloc.h
@@ -45,9 +45,9 @@ extern void pagetable_init(void);
 extern pgd_t *pgd_alloc(struct mm_struct *mm);
 
 #define __pte_free_tlb(tlb, pte, address)			\
-do {							\
-	pgtable_pte_page_dtor(pte);			\
-	tlb_remove_page((tlb), pte);			\
+do {								\
+	ptdesc_pte_dtor(page_ptdesc(pte));			\
+	tlb_remove_page_ptdesc((tlb), page_ptdesc(pte));	\
 } while (0)
 
 #ifndef __PAGETABLE_PMD_FOLDED
@@ -55,18 +55,18 @@ do {							\
 static inline pmd_t *pmd_alloc_one(struct mm_struct *mm, unsigned long address)
 {
 	pmd_t *pmd;
-	struct page *pg;
+	struct ptdesc *ptdesc;
 
-	pg = alloc_page(GFP_KERNEL_ACCOUNT);
-	if (!pg)
+	ptdesc = ptdesc_alloc(GFP_KERNEL_ACCOUNT, 0);
+	if (!ptdesc)
 		return NULL;
 
-	if (!pgtable_pmd_page_ctor(pg)) {
-		__free_page(pg);
+	if (!ptdesc_pmd_ctor(ptdesc)) {
+		ptdesc_free(ptdesc);
 		return NULL;
 	}
 
-	pmd = (pmd_t *)page_address(pg);
+	pmd = (pmd_t *)ptdesc_address(ptdesc);
 	pmd_init(pmd);
 	return pmd;
 }
@@ -80,10 +80,13 @@ static inline pmd_t *pmd_alloc_one(struct mm_struct *mm, unsigned long address)
 static inline pud_t *pud_alloc_one(struct mm_struct *mm, unsigned long address)
 {
 	pud_t *pud;
+	struct ptdesc *ptdesc = ptdesc_alloc(GFP_KERNEL, 0);
 
-	pud = (pud_t *) __get_free_page(GFP_KERNEL);
-	if (pud)
-		pud_init(pud);
+	if (!ptdesc)
+		return NULL;
+	pud = (pud_t *)ptdesc_address(ptdesc);
+
+	pud_init(pud);
 	return pud;
 }
 
diff --git a/arch/loongarch/mm/pgtable.c b/arch/loongarch/mm/pgtable.c
index 36a6dc0148ae..ff07b8f1ef30 100644
--- a/arch/loongarch/mm/pgtable.c
+++ b/arch/loongarch/mm/pgtable.c
@@ -11,10 +11,11 @@
 
 pgd_t *pgd_alloc(struct mm_struct *mm)
 {
-	pgd_t *ret, *init;
+	pgd_t *init, *ret = NULL;
+	struct ptdesc *ptdesc = ptdesc_alloc(GFP_KERNEL, 0);
 
-	ret = (pgd_t *) __get_free_page(GFP_KERNEL);
-	if (ret) {
+	if (ptdesc) {
+		ret = (pgd_t *)ptdesc_address(ptdesc);
 		init = pgd_offset(&init_mm, 0UL);
 		pgd_init(ret);
 		memcpy(ret + USER_PTRS_PER_PGD, init + USER_PTRS_PER_PGD,
-- 
2.39.2


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
