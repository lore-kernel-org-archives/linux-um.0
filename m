Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D008C7EE39
	for <linux-um@archiver.kernel.org>; Mon, 27 Feb 2023 17:57:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=+LG30ZSGxzWdrzomcblMrgPE8prf22pQ9nZF1J5Tdzg=; b=HOw2TfRO+TiZ+/
	9Hqk8VpQofAEbV6FD6KB0JDlXzAJnSdQT4tqdIWJz40XXowgwE542GJ0KpSmypdBIjjyUfXCN4JOE
	NH8r4y7vpIZul+GX1QPuAuR1zQtLAfbJk8yr9qG4wq4a4K0HDGnzHjWeWomJqUcs+1mzXfS9fOAmp
	nfKHPseLPQ375z/fvRmCAsKFEKJez4D1SvQuxF7nwMk3ii3Y+QUm1uOBaaHrK5uLKayniPCrDMvzo
	GQ5qiFBh4cp1M6yOA9VK2+eJsWMlbC2UxgO5P/sAvWID47vqg7oDsSAYVF5YagTgG7wWGuVbjrlZm
	cFGbdKqiPjfO2Oje1TKw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pWhl7-00Ac7u-49; Mon, 27 Feb 2023 17:57:57 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pWhky-00Ac2e-Md
	for linux-um@bombadil.infradead.org; Mon, 27 Feb 2023 17:57:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=dtiP3hUvA6nDur052lXOuZXkJQbzfHLCDQRu6Y0/CbA=; b=XBOe25D8ILBHFTarSSJcSeNA9I
	1ho9edMN4WMOW+STKHU1Fjrea3rZodyLYFfxge7XDJMmfzMLJ5pCij5ce+T8U8wF/UdpEm7/Bz/qs
	9nM2/FbCHKKykm8iTTCuAlGyTgQE/GycxrAz4ODI7DXc3tJUA+rJSGPORBHP1Q1tDn6els/rAcXNu
	nyYSpLPPd/TdxuXWCWgvTme17TJDDIgRhLDaoyZ4+jc4P1FBu1uKCgWDbTmRzt9YGRbp3MINfC48D
	n14ezuCiX8fXSt33c5Q2tTPA1dQpdTi3Rtl9mrNc5frwFSRQaNc0nMoT7sy55aFkqJjuw/TB8oH1V
	MaBmNMxg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pWhkw-000IYY-7M; Mon, 27 Feb 2023 17:57:46 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: linux-mm@kvack.org,
	linux-arch@vger.kernel.org
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-kernel@vger.kernel.org,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	linux-um@lists.infradead.org
Subject: [PATCH v2 24/30] um: Implement the new page table range API
Date: Mon, 27 Feb 2023 17:57:35 +0000
Message-Id: <20230227175741.71216-25-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230227175741.71216-1-willy@infradead.org>
References: <20230227175741.71216-1-willy@infradead.org>
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

Add set_ptes() and update_mmu_cache_range().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: Richard Weinberger <richard@nod.at>
Cc: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Cc: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-um@lists.infradead.org
---
 arch/um/include/asm/pgtable.h | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/arch/um/include/asm/pgtable.h b/arch/um/include/asm/pgtable.h
index a70d1618eb35..ca78c90ae74f 100644
--- a/arch/um/include/asm/pgtable.h
+++ b/arch/um/include/asm/pgtable.h
@@ -242,12 +242,20 @@ static inline void set_pte(pte_t *pteptr, pte_t pteval)
 	if(pte_present(*pteptr)) *pteptr = pte_mknewprot(*pteptr);
 }
 
-static inline void set_pte_at(struct mm_struct *mm, unsigned long addr,
-			      pte_t *pteptr, pte_t pteval)
+static inline void set_ptes(struct mm_struct *mm, unsigned long addr,
+		pte_t *ptep, pte_t pte, unsigned int nr)
 {
-	set_pte(pteptr, pteval);
+	for (;;) {
+		set_pte(ptep, pte);
+		if (--nr == 0)
+			break;
+		ptep++;
+		pte_val(pte) += PAGE_SIZE;
+	}
 }
 
+#define set_pte_at(mm, addr, ptep, pte)	set_ptes(mm, addr, ptep, pte, 1)
+
 #define __HAVE_ARCH_PTE_SAME
 static inline int pte_same(pte_t pte_a, pte_t pte_b)
 {
@@ -290,6 +298,7 @@ struct mm_struct;
 extern pte_t *virt_to_pte(struct mm_struct *mm, unsigned long addr);
 
 #define update_mmu_cache(vma,address,ptep) do {} while (0)
+#define update_mmu_cache_range(vma, address, ptep, nr) do {} while (0)
 
 /*
  * Encode/decode swap entries and swap PTEs. Swap PTEs are all PTEs that
-- 
2.39.1


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
