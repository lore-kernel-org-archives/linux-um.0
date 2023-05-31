Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2E3BC77B7A
	for <linux-um@archiver.kernel.org>; Wed, 31 May 2023 22:42:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=FYKwjmyfOdmfnBotKvbCvRSIDzOhJjv0j9UiGGVFlvI=; b=syQ8ic6kyhD28L
	4y9Nz2XFsG2GRT41SG4hUGMdxcV1PrxEq8f46baAS2TjxzbN7wWYmcWNdct1+NEWBygkvuvRd/d7/
	VLzkOKp/ANR+DT23cagG3yRDmHV8natO+J0+0m9vwxm42raSp40mYc4yrUNkK0BIQ7zc4enlKmKxr
	O5ZV1cSTCNHeOv+HHZz+9ec2i9Q5Rk+B1JwLNh43xDZvU9agbjMeIolrSvYaiMll47CdproVIPYXH
	B5bZotRsj8BpTQa8ItTg45AiCZVchW12G3x7wUtscXhOeSXMso9qm4sXoelaJZGogi5YRfpHMJd/q
	OB2e976FOTt0ZOax3hWA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q4UW9-001Lix-1u;
	Wed, 31 May 2023 22:42:09 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q4UW7-001LhP-14;
	Wed, 31 May 2023 22:42:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=GKvAry2ucxH/XDx2KcG3A/KGUGQDtp2kelP1IwoS25g=; b=hsAz/b6KSearQVJZdNxltbtvvn
	hL6LA9S6hMAg3qLUqzioPrs3yeyB4ENfNxRQGJLLqIq3EwRVoqXkI811Emu3hVO58joGcl4cEQgxG
	U6bM+3/RmJnuGrxCExEUL4J2Ll+oBERSlVlfA5LGISa/2FxK8xZmgxRzVHiFwal2Oo0RrYqBHJ5QV
	5HCuqbnTJ3KcwUXoo1Pu/WcO5KRjK5ESA8VQ+ISl8M4vptYA2tiW8c88idO+GB1ywyxnFSDkJr1WQ
	0LyvoikQWeo0rYOcQu7ZnL9u7YzOLscdS/B+PV2778VcWMBP43Eudu7fhRbQL1WmjFDIT4Kh3Fx66
	Gzf47xKg==;
Received: from mail-yw1-x1134.google.com ([2607:f8b0:4864:20::1134])
	by desiato.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q4TQD-00FdKh-1C;
	Wed, 31 May 2023 21:32:05 +0000
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-565aa2cc428so863677b3.1;
        Wed, 31 May 2023 14:31:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685568717; x=1688160717;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GKvAry2ucxH/XDx2KcG3A/KGUGQDtp2kelP1IwoS25g=;
        b=Y3FtUHVtc1fwM5WsLpUiDBg6/rzXML83Sf1SpHo45QrbJM4hkZ47EVZ9Jzx+YqMx//
         BHSo5V7SZU5qK6dRGkjND3aVt+qVlirBx9EWbYVMgnm+L6iMxxMix1wZ5PVLi/ijI+Ey
         kjhf04CYPPVWH8GpyPUK1r6JzDlEPiRQAM9NSrBfw3+VwNYXW3xAcUEWGbHBzHelo4Pu
         bF0T8t1NtshEajz0mqHjS6WkCiELQh858kC5qsY7VIk5maPoFZeAKP9V+myVulhgPyK+
         zsaBkoumThJ6EqDdX5m4PI3pGkx/pRFHiZHFkTEVJ/iNtjtCRgnvofJL1HddDTqxb4fu
         tjHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685568717; x=1688160717;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GKvAry2ucxH/XDx2KcG3A/KGUGQDtp2kelP1IwoS25g=;
        b=iKBlErOrLRMoFqRyyYm5TThotsuAN2IM6Jp0rcYd2T8E8rUz7Byc/7aLq0BscKIr40
         XMZh/nXg1r8ofDOvmykSVcwO29UXqUqTdlbQaeWgn40+o5w+OQdLSR2UpHKIAdH5Dl6r
         Nj8OVh7IGMYeB47YnGcGYp9wZUFDMpXV4Uqzoj691eshU0GUAI5XWqjMPtL4yYUrCOEe
         lITW8kwXGUy/zu998A5e9iJa8d/l4H8gP9ASIiCN1t8jeGTjWuZsAETpn/hrskAXkz4U
         abWbnnLq8zZD1Nc5wXyahaI9YuXWeJ4nfC+rOy38lYHqB26Vqskv/cOpLFZFDCcNV53b
         g0DA==
X-Gm-Message-State: AC+VfDxKCohk0rTzEFioQBZvPvLeCFjCc+OLTXME/YU3Zi2S4h6xHnZP
	fFHJzq7b5Vq6DV3gUodMtapWALVMfsGJFg==
X-Google-Smtp-Source: ACHHUZ4onSH62Fs1UXCoMXHHySj60ubOs649jT/DcV3u5CJS2oOZodlnCpjMB+cFBzv/roEimAjFGg==
X-Received: by 2002:a0d:df10:0:b0:55a:6100:c0e6 with SMTP id i16-20020a0ddf10000000b0055a6100c0e6mr6709224ywe.47.1685568716762;
        Wed, 31 May 2023 14:31:56 -0700 (PDT)
Received: from unknowna0e70b2ca394.attlocal.net ([2600:1700:2f7d:1800::46])
        by smtp.googlemail.com with ESMTPSA id t63-20020a0dd142000000b0055aafcef659sm658905ywd.5.2023.05.31.14.31.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 May 2023 14:31:56 -0700 (PDT)
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
Subject: [PATCH v3 24/34] loongarch: Convert various functions to use ptdescs
Date: Wed, 31 May 2023 14:30:22 -0700
Message-Id: <20230531213032.25338-25-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230531213032.25338-1-vishal.moola@gmail.com>
References: <20230531213032.25338-1-vishal.moola@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230531_223200_633464_9A4C9437 
X-CRM114-Status: GOOD (  14.16  )
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
---
 arch/loongarch/include/asm/pgalloc.h | 27 +++++++++++++++------------
 arch/loongarch/mm/pgtable.c          |  7 ++++---
 2 files changed, 19 insertions(+), 15 deletions(-)

diff --git a/arch/loongarch/include/asm/pgalloc.h b/arch/loongarch/include/asm/pgalloc.h
index af1d1e4a6965..5f5afbf1f10c 100644
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
+	pmd = (pmd_t *)ptdesc_address(ptdesc);
 	pmd_init(pmd);
 	return pmd;
 }
@@ -80,10 +80,13 @@ static inline pmd_t *pmd_alloc_one(struct mm_struct *mm, unsigned long address)
 static inline pud_t *pud_alloc_one(struct mm_struct *mm, unsigned long address)
 {
 	pud_t *pud;
+	struct ptdesc *ptdesc = pagetable_alloc(GFP_KERNEL, 0);
 
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
index 36a6dc0148ae..cdba10ffc0df 100644
--- a/arch/loongarch/mm/pgtable.c
+++ b/arch/loongarch/mm/pgtable.c
@@ -11,10 +11,11 @@
 
 pgd_t *pgd_alloc(struct mm_struct *mm)
 {
-	pgd_t *ret, *init;
+	pgd_t *init, *ret = NULL;
+	struct ptdesc *ptdesc = pagetable_alloc(GFP_KERNEL, 0);
 
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
