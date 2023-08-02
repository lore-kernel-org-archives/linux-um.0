Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2953C04E69
	for <linux-um@archiver.kernel.org>; Wed,  2 Aug 2023 15:14:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=YqUjFeOsbu0bw9u10uyoHEcmqq/L98UVmINoPKQ+F00=; b=cvHCVSXvjuv3Sb
	i+Fzn7dMbycAhfAU9vGroW2Titc5qkd06PMikNghQdmGj6lanbeh+SRu+MAtqrbnsHFo8BJ0XPHSD
	nKigWPOZ/CnoG7AXnCRafxCVCv50rNNQr1wC4DOnhyTU5zZsFLLDDh2rCOQeTbnZkExi0Go0zIRls
	SFS9iYWDJFBUplqsGeWfIorKTvds/HdF1j19JAqurw03VOZ0AkjUIDpUjHLkrgSwWCSfQZJUcCK2t
	nRVUyHpfdSEPW/K3JSxuvLdmjjnb543zwieJ6XV2lDjiNaqyLp+tBPV5fMjte9PNEvDQTeWblxVnM
	yLdFfws5E7xhUVMZfdXg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qRDYE-005CGj-0g;
	Wed, 02 Aug 2023 15:14:14 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qRDYC-005CFX-2t
	for linux-um@bombadil.infradead.org;
	Wed, 02 Aug 2023 15:14:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=4kjTMLR4yS/6wlkWfd894MUQRkbdXeC/iqVMekxk9eo=; b=UOIVkEMNZdOCGJnBsxzHwsX40o
	rr8/nyntKl6RORHkEVc1Y7ojv/VnFqITY+WiWPjPixGsd1y2B5+NOHhmwf+2hoVCzXh4QzqCB51Jj
	S4sAYQbo/cu4/lif1d8gBk+xM5TeGeQ7HZ0MQXLvNvnLFEmz/KPVffPBW9bKSD+uPgF+m+QoBoTDx
	2kBNipEaB9ZEhOUlwI68RO5gDnOB1PMs9QWwKD0CUH1tSy//cA/SA+GLemgzGXwDKcJj2uRKJLBmf
	MZXx5Fw05aEfsxobMifW/lp5H8loR+8MXo8bAWCO7qbbTqc+kZfnueekrMvjcRkRcBPjxVf43ti3N
	TknOGAaw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1qRDYB-00Ffku-2a; Wed, 02 Aug 2023 15:14:11 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-arch@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Mike Rapoport <rppt@kernel.org>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	linux-um@lists.infradead.org
Subject: [PATCH v6 27/38] um: Implement the new page table range API
Date: Wed,  2 Aug 2023 16:13:55 +0100
Message-Id: <20230802151406.3735276-28-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230802151406.3735276-1-willy@infradead.org>
References: <20230802151406.3735276-1-willy@infradead.org>
MIME-Version: 1.0
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

Add PFN_PTE_SHIFT and update_mmu_cache_range().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>
Cc: Richard Weinberger <richard@nod.at>
Cc: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Cc: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-um@lists.infradead.org
---
 arch/um/include/asm/pgtable.h | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/arch/um/include/asm/pgtable.h b/arch/um/include/asm/pgtable.h
index a70d1618eb35..44f6c76167d9 100644
--- a/arch/um/include/asm/pgtable.h
+++ b/arch/um/include/asm/pgtable.h
@@ -242,11 +242,7 @@ static inline void set_pte(pte_t *pteptr, pte_t pteval)
 	if(pte_present(*pteptr)) *pteptr = pte_mknewprot(*pteptr);
 }
 
-static inline void set_pte_at(struct mm_struct *mm, unsigned long addr,
-			      pte_t *pteptr, pte_t pteval)
-{
-	set_pte(pteptr, pteval);
-}
+#define PFN_PTE_SHIFT		PAGE_SHIFT
 
 #define __HAVE_ARCH_PTE_SAME
 static inline int pte_same(pte_t pte_a, pte_t pte_b)
@@ -290,6 +286,7 @@ struct mm_struct;
 extern pte_t *virt_to_pte(struct mm_struct *mm, unsigned long addr);
 
 #define update_mmu_cache(vma,address,ptep) do {} while (0)
+#define update_mmu_cache_range(vmf, vma, address, ptep, nr) do {} while (0)
 
 /*
  * Encode/decode swap entries and swap PTEs. Swap PTEs are all PTEs that
-- 
2.40.1


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
