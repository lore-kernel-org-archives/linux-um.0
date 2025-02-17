Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C090BC021A9
	for <linux-um@archiver.kernel.org>; Mon, 17 Feb 2025 19:10:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=F91J/zBN9mXNlWAyjwC2ekau5s1Hok6GIOYF8L/kjeM=; b=jtzatXJjtyC6n6MrRRRxcK/DXT
	5VxdnUR8fdKRzMit8CBtWmn8Jfd33loVhS/Pw/eq4c3grRlps5YAspWxDvYdXEH/9VFYFgym2bfyd
	hRw/CqQ0Eh5x9AWlx0d1ztlRKK72mCgu6EA47N76m10/M3tvh0m+2SyyFB+7ts8G00BZihwoHkovy
	l7LDB5GClPFqIRspaFrKNSveFQBDHv6LCtj1ShNdN92OFFM64kKvmJggm8rDa234l6TePdPHg99m8
	SU+maY27UYhtvSkmW5CjiLHC74/V/Mq4HeVrAKS7jtQApLUjo1zWLsfcyysjan66OmevayEID2hAq
	Szl9CEUg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tk6W0-00000005iLJ-2eJA;
	Mon, 17 Feb 2025 19:10:48 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tk6Tw-00000005hwO-0fqW
	for linux-um@bombadil.infradead.org;
	Mon, 17 Feb 2025 19:08:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=F91J/zBN9mXNlWAyjwC2ekau5s1Hok6GIOYF8L/kjeM=; b=Yjd8aRGz2wgGTd2aQB03xz1svM
	pad6TWhGTet5r5tkDe5SPhvMligYOVpyvs8WL4GxNO3hvIiEeBBIeCu/08/Luori/Y3kOo7Y6a6ls
	g/RoDjqKdMXrQyVKmAGtS1ozR0x2KsU9A2P0tsGgkGZVKEuthTil9oVE1RihJ3Y71jZzs1PKj8FzN
	zpO1z7+a8WFQeCo4AOBmoLja/ks9OdskhNB1xSwp9dHSHwK0Rs8lvQQZ2z21oHVDaiIfYXt6S3ASX
	Lyueov9us25LJavEjIEBNwgmazTmKMGvvc10FWFfHGwQXXr4Qo+EwBPukrmN6+DbyBLrqDZhjxErB
	EbkbBikA==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tk6Tu-00000001pBJ-3kf2;
	Mon, 17 Feb 2025 19:08:38 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: linux-mm@kvack.org
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-arch@vger.kernel.org,
	x86@kernel.org,
	linux-s390@vger.kernel.org,
	sparclinux@vger.kernel.org,
	linux-um@lists.infradead.org
Subject: [PATCH 4/7] x86: Remove custom definition of mk_pte()
Date: Mon, 17 Feb 2025 19:08:31 +0000
Message-ID: <20250217190836.435039-5-willy@infradead.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250217190836.435039-1-willy@infradead.org>
References: <20250217190836.435039-1-willy@infradead.org>
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
index 593f10aabd45..9f480bdafd20 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -784,6 +784,9 @@ static inline pgprotval_t check_pgprot(pgprot_t pgprot)
 static inline pte_t pfn_pte(unsigned long page_nr, pgprot_t pgprot)
 {
 	phys_addr_t pfn = (phys_addr_t)page_nr << PAGE_SHIFT;
+	/* This bit combination is used to mark shadow stacks */
+	WARN_ON_ONCE((pgprot_val(pgprot) & (_PAGE_DIRTY | _PAGE_RW)) ==
+			_PAGE_DIRTY);
 	pfn ^= protnone_mask(pgprot_val(pgprot));
 	pfn &= PTE_PFN_MASK;
 	return __pte(pfn | check_pgprot(pgprot));
@@ -1080,22 +1083,6 @@ static inline unsigned long pmd_page_vaddr(pmd_t pmd)
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
2.47.2


