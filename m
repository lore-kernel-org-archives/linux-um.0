Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 254AFC77B78
	for <linux-um@archiver.kernel.org>; Mon, 17 Apr 2023 20:59:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=kyvMQ3j68E0hthAtQhw0LXat3s0NLNNVAXbdDSV8dWY=; b=g8DkDPJYMxVd/e
	1GFomQU2BwGK3zHNcwDCpEZn1KNutffKgneDp9dKRmS5GT4ARYh8ZpOHb+JOQBqroILmc5gvR0SwY
	EhB+pf5LrT3JNtZ9/sYi/eIkNuVzcywhMhmHE1zU2Cl7J0CzY4mSmxjjMLR2AP5RxNhZNX3cMcBqI
	E6MvzcYANV+Fh4c8oDlReO2YkUEOB2b8st+sul97xq6hxFnmA000Hch3AZfQtipmVtFTkthlEwwBa
	zhvN8afedPSwk9F5UJpNKznViWyCeJu1JFDtFxXJsEq93fE60HEYoav7Ev62+8q8z9RjFygA42vEw
	drQL+flDdgEf4HZO4tdQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1poVwY-00005A-2T;
	Mon, 17 Apr 2023 20:59:22 +0000
Received: from mail-qt1-x836.google.com ([2607:f8b0:4864:20::836])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1poVwU-00Hb7B-2O;
	Mon, 17 Apr 2023 20:59:20 +0000
Received: by mail-qt1-x836.google.com with SMTP id z1so16147460qti.5;
        Mon, 17 Apr 2023 13:59:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681765157; x=1684357157;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pf7K/iFMD6od7/SRYpuPsYcodkkXMgOdjXv5YJvZldk=;
        b=TaGOw3bqeuXVtlu7FgvXmPHtvZYoEP1QpOqbKxjcX9GiTci0LxlY71Q1ojoxRuT7DG
         bQv3I/Il3uXvZpz7jXf5yYU458EObsWNcHjvsoQGPBhZ9ahJyUwnRa/02IZpY1NXKHyj
         aJLslYHysA1h9XweauRR1dB0+yntkOMc7qPsPaEBtvaJxrxyvJFN4UJp2j2zlIoFgMmt
         b+rcrFsS0TEQ4ytNpXYPJiOJIHeQ1vFOwFlTMumBJr5/NB+rNuirGu7UKKAXLtfFWbRi
         4D4CLDILVJV6S6V/LzKKB64/SBlQKZVPYdR9DV/Rxo1FCim0PHbjpe5264iyMWIOcSI8
         Pp6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681765157; x=1684357157;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pf7K/iFMD6od7/SRYpuPsYcodkkXMgOdjXv5YJvZldk=;
        b=Az8yXuybBEvfzCT1f7xVgZFbnXZN0ikoa2YeMOy5Prgi612CVD9RJHhOAf8EHmlmqX
         d3czuJGsNFq1e0MyEYILWF/uD7mDnt4UuXIoZGUPv3nYtXvIng0Nul1326QjkAHEAXIv
         ASzTANyi+rbGG3Q7tQSiavuu57n8GfdaI+t8UrcbjhWvQbVZqjWqWoGz6Qdm1EJwj2Qn
         7iF53b44YRYghm/PLORbawGCNgRDs8gHnC2bLjXjWNo85O7JCvTJQ2sbzMDqiPEMgCFu
         i2D9latAWgvgn4+P5N9i/rp8ZJvOxuQ3Q8C8svNrEEpYuzRnT6HX8MWa+Ftfruo4ROk1
         3mig==
X-Gm-Message-State: AAQBX9fRHgJD+7CYSo64CwyLKl/Cgsc5wa3rcPOOjQbevcxJzOEjw+QK
	uyCg2SQF7c4Jy9zH0a/kXAOMljvaxwULqg==
X-Google-Smtp-Source: AKy350YGLzUMfl8U7k4p6Sd9nO3FUwkbMa1TWeVYLUOOgANIZAClkJJEoJzR0+dt425gFfwmjH24tg==
X-Received: by 2002:a17:90a:ab12:b0:246:8b47:3d5b with SMTP id m18-20020a17090aab1200b002468b473d5bmr16661185pjq.18.1681764797279;
        Mon, 17 Apr 2023 13:53:17 -0700 (PDT)
Received: from fedora.hsd1.ca.comcast.net ([2601:644:937f:7f20::c139])
        by smtp.googlemail.com with ESMTPSA id h7-20020a17090ac38700b0022335f1dae2sm7609707pjt.22.2023.04.17.13.53.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Apr 2023 13:53:17 -0700 (PDT)
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
Subject: [PATCH 23/33] loongarch: Convert various functions to use ptdescs
Date: Mon, 17 Apr 2023 13:50:38 -0700
Message-Id: <20230417205048.15870-24-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230417205048.15870-1-vishal.moola@gmail.com>
References: <20230417205048.15870-1-vishal.moola@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230417_135918_776902_90090FA9 
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
