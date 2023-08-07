Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38C87C001B0
	for <linux-um@archiver.kernel.org>; Mon,  7 Aug 2023 23:08:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=/xJNLrZZ1J7R3vKqNliJoL12nmYYD9Nk4xyJb89Ab1w=; b=Is5jkorzQmDBs5
	/6skpLXxn8+1PXxr/A5uWEQvEcdQ7gqTjQ5q50RpH1DhvpggljyIE1qIJpS2RRsnlfuXn6UMZbpkE
	otlpHJIOb2y3eqXF2xYcvguakgSziXNEEnfSeFltPHZbz4iYokhZ5q1+AnOyr8bhikBaolYK9tsiM
	bGo22n4vINB9ZdPrwzI5ecrWB51n7bgl4OYAtlFr3a+gDToDH6X77li2a2lt3B3hoAnQu45urF+NZ
	9Mv0RPJiOTH1K+sI1TTAt/PQqbKkrjspUx1Bdw9W4NMPGRraiTSHiZZYIKFGMUCtjVGJ0GuWsILFs
	GxRmBHiVOp2mglrV6lfQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qT9KX-0017FW-2l;
	Mon, 07 Aug 2023 23:08:05 +0000
Received: from mail-yb1-xb35.google.com ([2607:f8b0:4864:20::b35])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qT9IY-001568-0p;
	Mon, 07 Aug 2023 23:06:04 +0000
Received: by mail-yb1-xb35.google.com with SMTP id 3f1490d57ef6-d4789fd9317so2925223276.1;
        Mon, 07 Aug 2023 16:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691449561; x=1692054361;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VD2saKmHCgP979K/4Ur2DZD5lv+pCsAy+26MDZ4lRXE=;
        b=KaA5Xf0Zq7VankK3QOvVnhKCvDQA0idGZ5r/QtBaYpBUZhM7IUDDnipX0Mck9NuTr6
         FMzfUiWHWV61utAYtiNJjvsmZyQrjEGqV1vWWuYtjGooZk9wKA6pHj8JXiEh77Vd66gm
         gq9wCdtohtsBXI+QiM0g5DM3RYb5yVm35tcAKNI7nQZaFVODWjyuyXisRnjCevekbcDp
         QweW3qBvEiOtjGdP8+KO+Ai79xaww40f8oFcpzIoZ31G0t7vkt4E3RfT7Asw6Y6mNUmW
         4v5tgaFeOHT3yezqwQ6Pv7HkjczS8wtW/o3vWALkNkC7/L83lM6ERIvU0onlnalg95pZ
         XQOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691449561; x=1692054361;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VD2saKmHCgP979K/4Ur2DZD5lv+pCsAy+26MDZ4lRXE=;
        b=AMS2ELeejqzlQaiu0ak7z2vxv6zwWSinrIK36TG5yK5SFc6ALo8QJcx1HxEBy6xJlX
         NWNxvF6EseJdSepjGYYHOI+4CqMkbwy7AzexHP2xnhaC+dFm0RC/To7NwUe3G45ubiDp
         nP1xN5vtz81dbduIprRLX4XR/0LM+OzzsQe6aKbunbHZvT2cljnEXj7sSmFwqUXKSrvP
         lJxyZhYyKOLIv/EIMyoeSbKzFSICsilE3Qw7PGANQeSEeMjtIKrl+vS7tTDdEnO71ob2
         /CRdGVpewfOldSwqWppd9tQJtt/zEoIPHTkiN2KQfj2fDKqLNa0ik2VQcH/Va+hefDeJ
         J2sg==
X-Gm-Message-State: AOJu0YyxQi1t0d5G6/gKrSEZ60TBpAxdlgG+vLZKUhCcgNvqtm/1ariV
	yCVtUwKv7f8pv0vhsc5zi0s=
X-Google-Smtp-Source: AGHT+IGT7jcZ858GNZbGv2ymKyHkNCq6k2xr+zx9+OdmxVuwoAhnOKduGJp0I6ObmWSEyVKiLNM8sw==
X-Received: by 2002:a25:8210:0:b0:d39:fa2f:8b63 with SMTP id q16-20020a258210000000b00d39fa2f8b63mr13670853ybk.25.1691449561057;
        Mon, 07 Aug 2023 16:06:01 -0700 (PDT)
Received: from unknowna0e70b2ca394.attlocal.net ([2600:1700:2f7d:1800::16])
        by smtp.googlemail.com with ESMTPSA id d190-20020a25cdc7000000b00d3596aca5bcsm2545203ybf.34.2023.08.07.16.05.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 16:06:00 -0700 (PDT)
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
Subject: [PATCH mm-unstable v9 21/31] loongarch: Convert various functions to use ptdescs
Date: Mon,  7 Aug 2023 16:05:03 -0700
Message-Id: <20230807230513.102486-22-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230807230513.102486-1-vishal.moola@gmail.com>
References: <20230807230513.102486-1-vishal.moola@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230807_160602_401649_93B688A9 
X-CRM114-Status: GOOD (  13.60  )
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

Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>
Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
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
index 1260cf30e3ee..b14343e211b6 100644
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
