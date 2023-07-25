Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32A75C04FE0
	for <linux-um@archiver.kernel.org>; Tue, 25 Jul 2023 04:22:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ZtBKkWw2sfF8EqQjNYmHCUmI2nFQtQO8JpirJppqnWU=; b=1T5vQtImwYDbFE
	FJy16N8Zmlqy4AJiIi9LjCcCJkWVDdcpNEwRMIbsUW17LxRzhdCXRB/FSEZb5dtqT4YKghnz8BIhs
	cH/Fy2NdvA0csmBX2K+QKZCobsyO6ejDN5B7+3w70smAtcsyliPzJCfkU/CZ7ASCytDzA3Q5efC22
	X/kXdaa7lixvd2FMVYuc+9n36PzmNHrhPOgrpnZr9qIskTXNysDZUyoUHji0I2pLrq/34IGPbmWe9
	0RDfJKH8OUhJPq/8294U3YimcSYRJTEL/vqhFjvs7Aqtz2UsbtPPq3BLQewAVVByMaOCLLRl/tcLU
	QdsQl+MLb0qeJj1f5OIg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qO9Z5-0068DX-2V;
	Tue, 25 Jul 2023 04:22:27 +0000
Received: from mail-yb1-xb34.google.com ([2607:f8b0:4864:20::b34])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qO9Y4-00678D-1H;
	Tue, 25 Jul 2023 04:21:26 +0000
Received: by mail-yb1-xb34.google.com with SMTP id 3f1490d57ef6-cb19b1b9a36so5683214276.0;
        Mon, 24 Jul 2023 21:21:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690258881; x=1690863681;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d0E0BACLvXh2vpBt6imfUOZqEuzu1odD4oW+AaIJCus=;
        b=jYui+PKKLrYwW/9bkeBCxZuH30ZLFCfjk6k83i08YHGZs5qBvg098warmUkrhehPA7
         w4YGyti6UCNUragO2itKU02HUpV/ViBpQF9TFUZFW/NNv47MTUMBLJ+3J2/znigqsRJs
         QhHBOUaU/0pdlJBDEn1DtnKR6Jjb52zcMeUqfdcetzMdFupe+5WkVJfD4fN5fJJOsgL0
         e1lfCQXQItA0Ro7t73ofq2YB2adhnzcCWoT2HIbviNcoaPhOqdkOZB4a44aYijkjfd8z
         BHV0Z8ytCVZzLV7QMejslcSqJexW00RaRFmpSqinl2bowLcrU0F1887NS/OPVowYeO94
         sAOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690258881; x=1690863681;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d0E0BACLvXh2vpBt6imfUOZqEuzu1odD4oW+AaIJCus=;
        b=XV3Vx44T3RL4X7utOZaJ3f8r+TPWfT30BywuXE1s1NUEUHyNapGYjRPaojxIjD1huX
         w29FZdubVoMDmPH1P22TkHscNPE9irRcrIQAHMzi6Bd2fzee4Jr7mlqmKloC1hRTbUeL
         nDiOTyy49E9DAqL8GlyNltYbY1Hsjjma3frmYj9U490dMiNiN0HQ6vJu+ieZUjzXGNv4
         9Qb/D6sH0CbOpjgZhV0N82wWjjtrc2gf6w0RoLIrPIPzfC/7GBS2X+Uuuuj78n0EdcnO
         WA8sDnNAOYF5EhmgkKPh4PA5+j5WIFmLJnFHaJWIa4Slhy4GyfrU/I8ANEr9rMLy0nvk
         zWrQ==
X-Gm-Message-State: ABy/qLbVlCSAsFSuonFvDCgmz3bVsVnFoHJEwafRbToaMzSwHOvm5RtS
	Tnp/t2g6N/J+2+r7Kqu242Q=
X-Google-Smtp-Source: APBJJlGCGmZmbOTlDUcCFEi74mEzBDVKNi9w9+0D8ZZZqBiNJxZc6NQL85g34qQbwNZIlG7Tv+r/mA==
X-Received: by 2002:a25:356:0:b0:d0b:ed07:7f56 with SMTP id 83-20020a250356000000b00d0bed077f56mr5325321ybd.18.1690258881187;
        Mon, 24 Jul 2023 21:21:21 -0700 (PDT)
Received: from unknowna0e70b2ca394.attlocal.net ([2600:1700:2f7d:1800::16])
        by smtp.googlemail.com with ESMTPSA id h9-20020a25b189000000b00d0db687ef48sm1175540ybj.61.2023.07.24.21.21.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jul 2023 21:21:20 -0700 (PDT)
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
	Mike Rapoport <rppt@kernel.org>
Subject: [PATCH mm-unstable v7 07/31] mm: Convert pmd_ptlock_init() to use ptdescs
Date: Mon, 24 Jul 2023 21:20:27 -0700
Message-Id: <20230725042051.36691-8-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230725042051.36691-1-vishal.moola@gmail.com>
References: <20230725042051.36691-1-vishal.moola@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230724_212124_474553_58C97274 
X-CRM114-Status: GOOD (  10.54  )
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

This removes some direct accesses to struct page, working towards
splitting out struct ptdesc from struct page.

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>
---
 include/linux/mm.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index c155f82dd2cc..52ef09c100a2 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2974,12 +2974,12 @@ static inline spinlock_t *pmd_lockptr(struct mm_struct *mm, pmd_t *pmd)
 	return ptlock_ptr(pmd_ptdesc(pmd));
 }
 
-static inline bool pmd_ptlock_init(struct page *page)
+static inline bool pmd_ptlock_init(struct ptdesc *ptdesc)
 {
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
-	page->pmd_huge_pte = NULL;
+	ptdesc->pmd_huge_pte = NULL;
 #endif
-	return ptlock_init(page);
+	return ptlock_init(ptdesc_page(ptdesc));
 }
 
 static inline void pmd_ptlock_free(struct page *page)
@@ -2999,7 +2999,7 @@ static inline spinlock_t *pmd_lockptr(struct mm_struct *mm, pmd_t *pmd)
 	return &mm->page_table_lock;
 }
 
-static inline bool pmd_ptlock_init(struct page *page) { return true; }
+static inline bool pmd_ptlock_init(struct ptdesc *ptdesc) { return true; }
 static inline void pmd_ptlock_free(struct page *page) {}
 
 #define pmd_huge_pte(mm, pmd) ((mm)->pmd_huge_pte)
@@ -3015,7 +3015,7 @@ static inline spinlock_t *pmd_lock(struct mm_struct *mm, pmd_t *pmd)
 
 static inline bool pgtable_pmd_page_ctor(struct page *page)
 {
-	if (!pmd_ptlock_init(page))
+	if (!pmd_ptlock_init(page_ptdesc(page)))
 		return false;
 	__SetPageTable(page);
 	inc_lruvec_page_state(page, NR_PAGETABLE);
-- 
2.40.1


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
