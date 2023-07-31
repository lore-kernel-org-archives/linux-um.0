Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 995F5C04FE0
	for <linux-um@archiver.kernel.org>; Mon, 31 Jul 2023 17:08:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=FPHoUWQFhUT2NCh2zDxGN+7zS3kaABHZcaicgqb/Euk=; b=29TuAD5uaGTkTN
	RtG+AsZ7ey4eC1O0OXJK6DbFP4O18vP58Zl5JZVSqXttKirYZ1rU/aMq9D3esRqCQNxiTEoO10ii2
	9ocxatD8RPnFWUeflp8TKDTCZGhSz4yDvH+c4KOmOmkb7OhAzO5OWrCoU1AnBcZMOcgkPbe9ZcfNS
	6QsQAUfhcvY34Bftp7EQBRuDpxtOfSVbvbNP1jhZsNp8pcAg7wIcFPunUO0jlM37y/SZoHMkqfuK/
	hUUkFHZRNZx6Svn/PfK0cFFDdWZiKSdn0GuryN2GT/kRhcwGAeL5S1LoiZw53JPQ0UEm0s6SxG48y
	xaRJwQZ1J4mqmPYQ1wtA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qQWNK-00GnIP-3A;
	Mon, 31 Jul 2023 17:08:07 +0000
Received: from mail-yb1-xb29.google.com ([2607:f8b0:4864:20::b29])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qQWJh-00GkVo-0w;
	Mon, 31 Jul 2023 17:04:23 +0000
Received: by mail-yb1-xb29.google.com with SMTP id 3f1490d57ef6-ca4a6e11f55so3743906276.1;
        Mon, 31 Jul 2023 10:04:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690823060; x=1691427860;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pBiyp2dfMpzV+NvCt1JbKOh6Ic1GEYp83948mVxRzoc=;
        b=bii0DnnL/zq4pLY7CpjLkMUsgbLkz7gqSGnWBeRCF11X6Ylp3mxYpagQ6993yGA9Tx
         PF2vUUOBG1y7FhGTNnDukjcT3Ipcja9oZIa3sMMxsfLyDTg+j7yc1He0o+q5msktzAqV
         tEhBEj/xq9sJsN95JWUc99ii1gkRP0c7o8rLJ8hSDdwHbsvR56f/IGjyS7Fnu0VAbC0Y
         XK+6J47RwKDDMwgKfIV3AfvnkXmT3IYpyeit/2cro7NXb8YvdXt0tmBkJB7s17jHD/xl
         ll9rO8u6pHah5lpvOsTcALDpgmctRONG81Iwdo4hzXBejIQu1syTEFsJtqvGtUVw0grb
         t9GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690823060; x=1691427860;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pBiyp2dfMpzV+NvCt1JbKOh6Ic1GEYp83948mVxRzoc=;
        b=XTzd8WiuNwMaw3VxzLSTCOjaYVo9eUiqgRyGJDC2dwAl4zB/hv0MPZsgH++8IdQavS
         UJZ9yhpWwKWuO1hHL0pgwGJ09HBu4nhSNpllelC71ENGpkOnF23HXnsciYAlmxXUCGAJ
         ATWKGja99tScq6W7eXniGLOJN9z3Le6lfTIIKtP8/wWhEIxoJUWVuuvG7vHb7Tcgf8KO
         LirEmKf6s6KkaDOB32bR8DUsm9Hd3HznOh2uKgPfSPblH1I/xBHA2D5f9snggKM7g3bT
         WanzXrrE0EvC20htn1/HYs5dkvNMf1Cc9GBc+IxVf7e99oj5/BEy1j/BO7sXA5rZWdhG
         CepA==
X-Gm-Message-State: ABy/qLaHqZSmM3tnF9D//2PVjhebwuF+rNydcll8AKpef3Lf5p581MHs
	NpfiHWejsiJsV+AFlS8qCq4=
X-Google-Smtp-Source: APBJJlFeS2ogl3m5ezZAcTbxwtfQRoXWWYsAvuudazx+JhR2l/mtz06faRF9RklP+vg5BWBteq8aEQ==
X-Received: by 2002:a25:d18e:0:b0:d07:d88b:4843 with SMTP id i136-20020a25d18e000000b00d07d88b4843mr7628126ybg.20.1690823060256;
        Mon, 31 Jul 2023 10:04:20 -0700 (PDT)
Received: from unknowna0e70b2ca394.attlocal.net ([2600:1700:2f7d:1800::16])
        by smtp.googlemail.com with ESMTPSA id x31-20020a25ac9f000000b00c832ad2e2eesm2511833ybi.60.2023.07.31.10.04.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jul 2023 10:04:20 -0700 (PDT)
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
	Huacai Chen <chenhuacai@kernel.org>,
	Mike Rapoport <rppt@kernel.org>
Subject: [PATCH mm-unstable v8 21/31] loongarch: Convert various functions to use ptdescs
Date: Mon, 31 Jul 2023 10:03:22 -0700
Message-Id: <20230731170332.69404-22-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230731170332.69404-1-vishal.moola@gmail.com>
References: <20230731170332.69404-1-vishal.moola@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230731_100421_359510_63E09D64 
X-CRM114-Status: GOOD (  14.37  )
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
these to use pagetable_alloc() and ptdesc_address() instead to help
standardize page tables further.

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>
---
 arch/loongarch/include/asm/pgalloc.h | 27 +++++++++++++++------------
 arch/loongarch/mm/pgtable.c          |  7 ++++---
 2 files changed, 19 insertions(+), 15 deletions(-)

diff --git a/arch/loongarch/include/asm/pgalloc.h b/arch/loongarch/include/asm/pgalloc.h
index af1d1e4a6965..23f5b1107246 100644
--- a/arch/loongarch/include/asm/pgalloc.h
+++ b/arch/loongarch/include/asm/pgalloc.h
@@ -45,9 +45,9 @@ extern void pagetable_init(void);
 extern pgd_t *pgd_alloc(struct mm_struct *mm);
 
 #define __pte_free_tlb(tlb, pte, address)			\
-do {							\
-	pgtable_pte_page_dtor(pte);			\
-	tlb_remove_page((tlb), pte);			\
+do {								\
+	pagetable_pte_dtor(page_ptdesc(pte));			\
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
+	ptdesc = pagetable_alloc(GFP_KERNEL_ACCOUNT, 0);
+	if (!ptdesc)
 		return NULL;
 
-	if (!pgtable_pmd_page_ctor(pg)) {
-		__free_page(pg);
+	if (!pagetable_pmd_ctor(ptdesc)) {
+		pagetable_free(ptdesc);
 		return NULL;
 	}
 
-	pmd = (pmd_t *)page_address(pg);
+	pmd = ptdesc_address(ptdesc);
 	pmd_init(pmd);
 	return pmd;
 }
@@ -80,10 +80,13 @@ static inline pmd_t *pmd_alloc_one(struct mm_struct *mm, unsigned long address)
 static inline pud_t *pud_alloc_one(struct mm_struct *mm, unsigned long address)
 {
 	pud_t *pud;
+	struct ptdesc *ptdesc = pagetable_alloc(GFP_KERNEL & ~__GFP_HIGHMEM, 0);
 
-	pud = (pud_t *) __get_free_page(GFP_KERNEL);
-	if (pud)
-		pud_init(pud);
+	if (!ptdesc)
+		return NULL;
+	pud = ptdesc_address(ptdesc);
+
+	pud_init(pud);
 	return pud;
 }
 
diff --git a/arch/loongarch/mm/pgtable.c b/arch/loongarch/mm/pgtable.c
index 36a6dc0148ae..5bd102b51f7c 100644
--- a/arch/loongarch/mm/pgtable.c
+++ b/arch/loongarch/mm/pgtable.c
@@ -11,10 +11,11 @@
 
 pgd_t *pgd_alloc(struct mm_struct *mm)
 {
-	pgd_t *ret, *init;
+	pgd_t *init, *ret = NULL;
+	struct ptdesc *ptdesc = pagetable_alloc(GFP_KERNEL & ~__GFP_HIGHMEM, 0);
 
-	ret = (pgd_t *) __get_free_page(GFP_KERNEL);
-	if (ret) {
+	if (ptdesc) {
+		ret = (pgd_t *)ptdesc_address(ptdesc);
 		init = pgd_offset(&init_mm, 0UL);
 		pgd_init(ret);
 		memcpy(ret + USER_PTRS_PER_PGD, init + USER_PTRS_PER_PGD,
-- 
2.40.1


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
