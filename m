Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CD29C77B76
	for <linux-um@archiver.kernel.org>; Mon, 17 Apr 2023 21:59:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=jT9xjAxOqutc5Qmuks2OJBVO+owwzgK4WneuAZ/L4BY=; b=FrclDfxVgxKGUX
	jFoOO/PKgjVNfK2SGdinUSBhY53dJxgVZkkm/hlBH4TlLPFEIq0lrsxvi4Cb8OVPZ5VPe43HkuoBI
	e5dOkKm6uqvUT0emKerEbisVcT0tfyIa7rKYQaCzHtk4i6wbEHbtp2wd6+PK5xuvYpDWrxBoclMho
	8NNXzt8y34XJ92vLIwGB1rw/mp1QcspUXr33/gIQ3TG5ppvOEbuW3Jared0WwX7Xmg9nkJQ7HKQWe
	NnsEvsSar2I38LgR1tb9m1CrEcFNI1ukZvykt0yDngjwpkKEuAQohMBz9EhJ/5eCNqs7JQmoav7Ti
	YEJmk/DmwK/Kyw7TnqjQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1poWsm-000Brg-2k;
	Mon, 17 Apr 2023 21:59:32 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1poWsj-000BpY-1U;
	Mon, 17 Apr 2023 21:59:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=kyicI3UFSJTH3R33HGjLFGEyUDrTPXlIkqJCgIfzdrc=; b=LBIXwuHpcbmxt23lPcGZ7jHW6x
	EvezF9aCKY4L5w+sdxab1nLoFVZTNk0dzd6F97cjZcbQp8lvLOp652DZlWEwwbhQA36ZX55bE3yf3
	G5UwxHDCZZXoGoLtDS6sPv0yMe405wGgr/oLxwouGi6UNPeAElFsktWG79csWZlBAlBebbcgS3VQi
	OWUaCYHCN8nsMJaYt2g3ztIS0vvMX47CCfVdxxYX2aTVO3nIHyWzjxdIqraA75uCzoT9YNYx80qyt
	20e/SAH0a8r19WdvE6ipVxKB6d1ZNHa2UqrvWVuJbliNDHTr7uqw0Y0YLN6xwANRF5zC6ROlTu3Rw
	/6Y4c3CA==;
Received: from mail-yw1-x112e.google.com ([2607:f8b0:4864:20::112e])
	by desiato.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1poVxh-00HSUG-2j;
	Mon, 17 Apr 2023 21:00:37 +0000
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-54f8b46d031so15386087b3.3;
        Mon, 17 Apr 2023 14:00:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681765228; x=1684357228;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kyicI3UFSJTH3R33HGjLFGEyUDrTPXlIkqJCgIfzdrc=;
        b=eFTwCheIPLi7v2//O72VDeMHtkh8k8nxg6t87EaRWaiwgWOm4TnXmmM5o9lvUO5PLn
         Hc9sulYZXmKHt3+PAdp4Ao3uIhsoupFXES56Axn8WdaIGA0fyfKO5vIAHDboXV8qUdF6
         T/d7Rs7QzZVYhIjR/nmDeSwf4sMbZzLuNy0zv1usiumRqx+O/vzVNwE5s7DzpJ7/lstM
         1rmrCReFyeb4di4WtGKxi1v/iMA33/BW57+PaIuV+DRK7Yphe+uSqQlfLKyUNAx6F5La
         Hz8gSAjqzgV6NIyte4Bxdg+ctOvLf0mbEhSVfjbT9/s/VTNUUBjXB+X9rfb8RRCOuMJe
         S1ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681765228; x=1684357228;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kyicI3UFSJTH3R33HGjLFGEyUDrTPXlIkqJCgIfzdrc=;
        b=iBqcZdUIEMAOLspKoPRBdt8Nrc1oUYC4ZQZ+u8gAPhwNYlgG61d7fG2ib5WXzIQH7k
         o90FBB6kKVm9d9rWuORCcG7Phq/LFQe/37+yZL3RxvkwvAKnLjL0RfgSPPM+WrwKA9Hj
         OAVhNXau+ASCEJcm0KCIOaMBD4Wd2+CBl7gwlzHysdzAn3uohPuBUGSJBCWwM+oBsn9+
         pAd4uYHDCkZV7tiM+Bra5y1eIVFNtjzxCcnfuActE3Ju0tV3em6Cy6uZ5ovkyuyPRQEE
         rRNUCOx6gtREIm9Tm/k1asK+x6Do+d+JXP8P7h2zCDvQTpKXV6iXSxUGsMVVizXm+3mo
         vJSQ==
X-Gm-Message-State: AAQBX9eBeLLDBuO56CRK2nOVnQ98yUjfswTJ3z9qqZH22midPaWfcUzI
	WahVNccOGhhYOwn5ZkIembCubUdgXT6xZg==
X-Google-Smtp-Source: AKy350b8thcmecOoaOKiNwMZgeAazmiEiQ9V6nLrivAsLyOgVvPy05KEMe/JXWQl3cGgcJMZ1iU0KA==
X-Received: by 2002:a17:90b:3848:b0:247:4ad1:f69b with SMTP id nl8-20020a17090b384800b002474ad1f69bmr11748993pjb.26.1681764800112;
        Mon, 17 Apr 2023 13:53:20 -0700 (PDT)
Received: from fedora.hsd1.ca.comcast.net ([2601:644:937f:7f20::c139])
        by smtp.googlemail.com with ESMTPSA id h7-20020a17090ac38700b0022335f1dae2sm7609707pjt.22.2023.04.17.13.53.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Apr 2023 13:53:19 -0700 (PDT)
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
Subject: [PATCH 25/33] mips: Convert various functions to use ptdescs
Date: Mon, 17 Apr 2023 13:50:40 -0700
Message-Id: <20230417205048.15870-26-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230417205048.15870-1-vishal.moola@gmail.com>
References: <20230417205048.15870-1-vishal.moola@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230417_220034_153921_DCD55530 
X-CRM114-Status: GOOD (  13.10  )
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
