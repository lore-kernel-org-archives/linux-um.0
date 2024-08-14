Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8966C52D7B
	for <linux-um@archiver.kernel.org>; Wed, 14 Aug 2024 15:44:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZfJtp4EbP1iZkIk82oFzdjbw9nzCO7poA8zUpczfu6w=; b=Ddcoxw9T00C0FB8z21/8YroX3z
	3F5/Zfjv3abKCYi/ZkUndGEVTRQGaqhuxYTcSacLYo9IrkrNUwKVUbdQmA+fyNw8UJECtoASdlN4e
	I09eF6DRH4pBe/Hs6PnEyfzssy80C6WLH2013bcQYUtEZPinXaRvmT4tKY4atyNcxV5bknkgED8tb
	c7zHxA9952bIZ0dttKtdsCQgWdpD4hmvRHDN6uKos/h/ogIf5D08Mbdwg+yvns6izvyEg0F9OxJBt
	I2ZwFHfbEAVu8yNScxDYfhqMNA08Dfj4C5yE9wQWVXNmx/mJ28iMjD2oRq3O/k+e+AOuORUhZKuM/
	9VDf+A1Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1seGBG-00000007WFH-1Cwc;
	Wed, 14 Aug 2024 15:44:58 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1seGAt-00000007W47-1764
	for linux-um@bombadil.infradead.org;
	Wed, 14 Aug 2024 15:44:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=ZfJtp4EbP1iZkIk82oFzdjbw9nzCO7poA8zUpczfu6w=; b=cx/fp8n6YDoLDZDivZBEBUPoBf
	7ObTXu6V8ldOrCsCH5JZwR6HapYacQsPn0OkQwh3rD/6MX+Z7ptLSqPxtGA1Ga9ROwWnR1pGnGe2Y
	Y6qIoYBD6p4j31Jmi38iLW6ye9WfdpNIuDoGkZtb/wxSPxL8w3nmWuNji790lX/oyS0K7mQGE92Nu
	lXbS4ZKPeV3GwTbi1i/jYpk1PMHy47lXAOQzZs0rPeUZnOJD1K2CVm1acSk1oBiPMZG/CoeU8DyzP
	Lq2/qMKI2u7/MdGoMqnYWaUiFBqT1wAM7IpT0SmLSX3naLwhT9HOeg9srCDiFcjf3FH5XKnMQdEWn
	O9oGjloQ==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1seGAs-00000000gHE-0SrN;
	Wed, 14 Aug 2024 15:44:34 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: linux-mm@kvack.org,
	linux-arch@vger.kernel.org
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-s390@vger.kernel.org,
	linux-um@lists.infradead.org,
	x86@kernel.org
Subject: [PATCH 2/5] x86: Remove custom definition of mk_pte()
Date: Wed, 14 Aug 2024 16:44:22 +0100
Message-ID: <20240814154427.162475-3-willy@infradead.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240814154427.162475-1-willy@infradead.org>
References: <20240814154427.162475-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

Move the shadow stack check to pfn_pte() which lets us use the common
definition of mk_pte().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 arch/x86/include/asm/pgtable.h | 19 +++----------------
 1 file changed, 3 insertions(+), 16 deletions(-)

diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index a7c1e9cfea41..59baf4e183b2 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -760,6 +760,9 @@ static inline pgprotval_t check_pgprot(pgprot_t pgprot)
 static inline pte_t pfn_pte(unsigned long page_nr, pgprot_t pgprot)
 {
 	phys_addr_t pfn = (phys_addr_t)page_nr << PAGE_SHIFT;
+	/* This bit combination is used to mark shadow stacks */
+	WARN_ON_ONCE((pgprot_val(pgprot) & (_PAGE_DIRTY | _PAGE_RW)) ==
+			_PAGE_DIRTY);
 	pfn ^= protnone_mask(pgprot_val(pgprot));
 	pfn &= PTE_PFN_MASK;
 	return __pte(pfn | check_pgprot(pgprot));
@@ -1056,22 +1059,6 @@ static inline unsigned long pmd_page_vaddr(pmd_t pmd)
  */
 #define pmd_page(pmd)	pfn_to_page(pmd_pfn(pmd))
 
-/*
- * Conversion functions: convert a page and protection to a page entry,
- * and a page entry and page directory to the page they refer to.
- *
- * (Currently stuck as a macro because of indirect forward reference
- * to linux/mm.h:page_to_nid())
- */
-#define mk_pte(page, pgprot)						  \
-({									  \
-	pgprot_t __pgprot = pgprot;					  \
-									  \
-	WARN_ON_ONCE((pgprot_val(__pgprot) & (_PAGE_DIRTY | _PAGE_RW)) == \
-		    _PAGE_DIRTY);					  \
-	pfn_pte(page_to_pfn(page), __pgprot);				  \
-})
-
 static inline int pmd_bad(pmd_t pmd)
 {
 	return (pmd_flags(pmd) & ~(_PAGE_USER | _PAGE_ACCESSED)) !=
-- 
2.43.0


