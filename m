Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5926C021AD
	for <linux-um@archiver.kernel.org>; Mon, 17 Feb 2025 19:10:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=j0C36cwE02tcp83xir3MVAFQIG4vvurnU5t2AtfKn0w=; b=m5JQqNwlXxvC2UoF4b6CIwutUZ
	ewpc2qDhJokjF4Bo6u/VxrhvR9CcMWJH9HCqof1hZz5+nLpLpAVQc0QuIXaSDBnJKdtPzhFNFPMN2
	v2A+3EGdpupn+KmVijhYzLQv61qopqGa/tocLowRpQ+HZSAggDPMm8R+SKv4FqX2Y56yOvx7cZRRd
	eKhk4vj4W9krWuj2pH0Bx5p5v0SY4LnmVmEuJz00yJx0txDIAgqFs6jNW8eZm1njd0TBhITa082Mz
	oHRx9PQDNxYwZLjIAyg0FRjLMaSf/LGbKPodLDyK5tcUA9SZRjMZpAHk01VKsgHIlwFqSryMcogxC
	42/MvRSg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tk6W0-00000005iLV-3qzJ;
	Mon, 17 Feb 2025 19:10:48 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tk6Tw-00000005hwN-0fft
	for linux-um@bombadil.infradead.org;
	Mon, 17 Feb 2025 19:08:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=j0C36cwE02tcp83xir3MVAFQIG4vvurnU5t2AtfKn0w=; b=QnkS/IDlpFNbxP+1NPSLKrdsh0
	W3YPFFdUYdE5bv+IkKv1DttNFhjdfeK3JoNCcH2tDcwHkIiWvg/C2a4wH/u3IHTb4YM/lxTlMkakQ
	MgeRGI7FcqDMPeId+YYyjBB4W86R7pZIdHQq7dYEXsK1M2u2KGFAQTokc2mFFTRlaoenqS0bKIjqZ
	aJ6NzWzfDrjw12g+GkzYADGVkGEOfzkaxmBopCBOeVfBtOQq/NWVXjDBWokSfk0bSXo2D78KbAe3A
	Xdwcq0TaABahPOiqCpI7JbV5wN8PwHPqxR0WfXpLKmBzkFD+B3iU+27xyl7mm17JJpUaSP1DZgs8B
	tKN5k9xw==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tk6Tu-00000001pBH-3P3E;
	Mon, 17 Feb 2025 19:08:38 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: linux-mm@kvack.org
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-arch@vger.kernel.org,
	x86@kernel.org,
	linux-s390@vger.kernel.org,
	sparclinux@vger.kernel.org,
	linux-um@lists.infradead.org
Subject: [PATCH 3/7] sparc32: Remove custom definition of mk_pte()
Date: Mon, 17 Feb 2025 19:08:30 +0000
Message-ID: <20250217190836.435039-4-willy@infradead.org>
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

Instead of defining pfn_pte() in terms of mk_pte(), make pfn_pte() the
base implementation.  That lets us use the generic definition of mk_pte().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 arch/sparc/include/asm/pgtable_32.h | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/arch/sparc/include/asm/pgtable_32.h b/arch/sparc/include/asm/pgtable_32.h
index 62bcafe38b1f..1454ebe91539 100644
--- a/arch/sparc/include/asm/pgtable_32.h
+++ b/arch/sparc/include/asm/pgtable_32.h
@@ -255,7 +255,11 @@ static inline pte_t pte_mkyoung(pte_t pte)
 }
 
 #define PFN_PTE_SHIFT			(PAGE_SHIFT - 4)
-#define pfn_pte(pfn, prot)		mk_pte(pfn_to_page(pfn), prot)
+
+static inline pte_t pfn_pte(unsigned long pfn, pgprot_t pgprot)
+{
+	return __pte((pfn << PFN_PTE_SHIFT) | pgprot_val(pgprot));
+}
 
 static inline unsigned long pte_pfn(pte_t pte)
 {
@@ -272,15 +276,6 @@ static inline unsigned long pte_pfn(pte_t pte)
 
 #define pte_page(pte)	pfn_to_page(pte_pfn(pte))
 
-/*
- * Conversion functions: convert a page and protection to a page entry,
- * and a page entry and page directory to the page they refer to.
- */
-static inline pte_t mk_pte(struct page *page, pgprot_t pgprot)
-{
-	return __pte((page_to_pfn(page) << (PAGE_SHIFT-4)) | pgprot_val(pgprot));
-}
-
 static inline pte_t mk_pte_phys(unsigned long page, pgprot_t pgprot)
 {
 	return __pte(((page) >> 4) | pgprot_val(pgprot));
-- 
2.47.2


