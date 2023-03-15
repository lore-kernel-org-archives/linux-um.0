Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30FADC7619A
	for <linux-um@archiver.kernel.org>; Wed, 15 Mar 2023 05:14:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=2RbI3ReyaAtTWtFcVI9aYn8pYhlt5VAzl+dRwHYEjp4=; b=UCn0uRufbgnl0C
	rraJUX4VQXbFzqztPy+OHGIJEfm2l+otMLiIRBQkgCutyOo9YdyrbOwTIcv5l+O/aiYQJQLx4RNB2
	fNIs3aun1YgEsOTK/vxeJ36OLf624s8yC1jPlEMXPEv+LK3DutcY5ym2OI7UV0mK88p3rykb0gB11
	ccD+dhgddYpClLqrI93GywJ1yEC8Z9EVO8kiHTDoLkzehX8RUn7CVfNnCISsmI/vp3Qbf1epzwRjR
	cJn2/BOvj1Omi053cEsUs8eQKCNEkn5ms0QI1ioU7QDj0rdKZTJa1E1n4AIpQKBIYNsjhj0l1CFix
	5y9Tpv3hmTAWGGjq2rxw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pcJTR-00CMBL-33;
	Wed, 15 Mar 2023 05:14:53 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pcJTP-00CM9Y-2X
	for linux-um@bombadil.infradead.org;
	Wed, 15 Mar 2023 05:14:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=BhDHElA1+7XNNQUc53zmXL/VNEpjb/1kRYcXHjVwh6U=; b=L3nJEGj//+nPckdFL5A0mFETmy
	lr7XPYbTtAaH2vP0P5HP+wBtnDWlG5b7uYikWQ/fJi0a4Vt9b/xt8Sww93NIb2vKIimPE9Oy6GZdz
	mNvJFBOvv5hx4U2SLTqASBtB1VDHjrNZWSQ+UdnoaSfxl1n7daNmCihmbbled4/1UbvtRe3hhL2pE
	++KLiRw8n0BqJ1AyiIcC/wm4+19G7IrigGstnEw8/D20hnfrAf+fialHk4Z3PtzZWdFJRgr9KzqBY
	JJ/8fbBrEaXLPR+F5jk9C2hUICZcfm6Hd9VNJs/p60YKGbDlvTMwSV0WS5LbQ7KG72LW5GboZTm3y
	scb/WSSg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pcJTN-00DYD1-Ht; Wed, 15 Mar 2023 05:14:49 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: linux-arch@vger.kernel.org
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	linux-um@lists.infradead.org
Subject: [PATCH v4 26/36] um: Implement the new page table range API
Date: Wed, 15 Mar 2023 05:14:34 +0000
Message-Id: <20230315051444.3229621-27-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230315051444.3229621-1-willy@infradead.org>
References: <20230315051444.3229621-1-willy@infradead.org>
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
Cc: Richard Weinberger <richard@nod.at>
Cc: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Cc: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-um@lists.infradead.org
---
 arch/um/include/asm/pgtable.h | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/arch/um/include/asm/pgtable.h b/arch/um/include/asm/pgtable.h
index a70d1618eb35..ea5f8122f128 100644
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
+#define update_mmu_cache_range(vma, address, ptep, nr) do {} while (0)
 
 /*
  * Encode/decode swap entries and swap PTEs. Swap PTEs are all PTEs that
-- 
2.39.2


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
