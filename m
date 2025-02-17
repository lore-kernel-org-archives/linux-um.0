Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1954AC021AE
	for <linux-um@archiver.kernel.org>; Mon, 17 Feb 2025 19:10:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OumVES33M5Q6KKLjsks+HzN6mA4d4PgrDi4hyJXhstQ=; b=5EiqzpCEZENpfYJm0iP4PyAYLs
	TwP4kxj1odcQLkXEMWANrRPtg4Uu8omeRiRn2WH2xdf83P1HB2EC0RLTZ+BCkLWNtW2kGSLCbBgGw
	MHDR+8e385NkRLbYsH2UwKIiAlY3aRyxRn2tS4fZOndlC/gvjuUEzTcu1ap/mxBaH7Utaz/kHN2/B
	PumxLiMWDHnbDRHc6BHCZh5xQGPBEjAt17rQ6LXCGot6X8aZftA0di59BU27CkQ5dGGqusIZXwqde
	h/Q1DkdLOPLpbY0Ui8v01uP/d/MoGZTQR/rRll8xQcjQ6N5NKV+sqyleKPaTrFCVbtK7l+ezrKyUO
	aHM0cliA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tk6W1-00000005iMI-3Z9o;
	Mon, 17 Feb 2025 19:10:49 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tk6Tw-00000005hwR-1emp
	for linux-um@bombadil.infradead.org;
	Mon, 17 Feb 2025 19:08:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=OumVES33M5Q6KKLjsks+HzN6mA4d4PgrDi4hyJXhstQ=; b=StCMnrt6vOSAYjFMqqQquk050o
	hn1znvvg9gYx0AwLbFVElug1d1bW6SEWC5H6dYMk8J4C7mg0KKFEgL/HFVJvoA99AQ/0JSkSUErr2
	TtcqV5Ev5F8iW4alNv2SNQPl6S01DglwDe5jooRarQpgbJ/l/ZVAqSfnmiymy+RfLGQx4SSUgETnn
	TzhasKCnq5rTeSL7GLZAICQkeu663hIrRckIbtwLo9icbmZqKxQSO+kiWs4EGAl7Z15/lwEfa3F4Y
	L5EvDNIT5UdATOp5oZB+3Y/6WYY/Q5HETXGUent6CVnm3bZ/1K5o8X6f6yqK63/mHxlPMryWUmXdG
	kBG41KUw==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tk6Tv-00000001pBk-19SY;
	Mon, 17 Feb 2025 19:08:39 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: linux-mm@kvack.org
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-arch@vger.kernel.org,
	x86@kernel.org,
	linux-s390@vger.kernel.org,
	sparclinux@vger.kernel.org,
	linux-um@lists.infradead.org
Subject: [PATCH 7/7] mm: Add folio_mk_pte()
Date: Mon, 17 Feb 2025 19:08:34 +0000
Message-ID: <20250217190836.435039-8-willy@infradead.org>
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

Removes a cast from folio to page in four callers of mk_pte().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/mm.h | 15 +++++++++++++++
 mm/memory.c        |  6 +++---
 mm/userfaultfd.c   |  2 +-
 3 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 62dccde9c561..b1e311bae6b7 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1921,6 +1921,21 @@ static inline pte_t mk_pte(struct page *page, pgprot_t pgprot)
 {
 	return pfn_pte(page_to_pfn(page), pgprot);
 }
+
+/**
+ * folio_mk_pte - Create a PTE for this folio
+ * @folio: The folio to create a PTE for
+ * @pgprot: The page protection bits to use
+ *
+ * Create a page table entry for the first page of this folio.
+ * This is suitable for passing to set_ptes().
+ *
+ * Return: A page table entry suitable for mapping this folio.
+ */
+static inline pte_t folio_mk_pte(struct folio *folio, pgprot_t pgprot)
+{
+	return pfn_pte(folio_pfn(folio), pgprot);
+}
 #endif
 
 /**
diff --git a/mm/memory.c b/mm/memory.c
index 4330560eee55..72411a6d696f 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -936,7 +936,7 @@ copy_present_page(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma
 	rss[MM_ANONPAGES]++;
 
 	/* All done, just insert the new page copy in the child */
-	pte = mk_pte(&new_folio->page, dst_vma->vm_page_prot);
+	pte = folio_mk_pte(new_folio, dst_vma->vm_page_prot);
 	pte = maybe_mkwrite(pte_mkdirty(pte), dst_vma);
 	if (userfaultfd_pte_wp(dst_vma, ptep_get(src_pte)))
 		/* Uffd-wp needs to be delivered to dest pte as well */
@@ -3480,7 +3480,7 @@ static vm_fault_t wp_page_copy(struct vm_fault *vmf)
 			inc_mm_counter(mm, MM_ANONPAGES);
 		}
 		flush_cache_page(vma, vmf->address, pte_pfn(vmf->orig_pte));
-		entry = mk_pte(&new_folio->page, vma->vm_page_prot);
+		entry = folio_mk_pte(new_folio, vma->vm_page_prot);
 		entry = pte_sw_mkyoung(entry);
 		if (unlikely(unshare)) {
 			if (pte_soft_dirty(vmf->orig_pte))
@@ -4892,7 +4892,7 @@ static vm_fault_t do_anonymous_page(struct vm_fault *vmf)
 	 */
 	__folio_mark_uptodate(folio);
 
-	entry = mk_pte(&folio->page, vma->vm_page_prot);
+	entry = folio_mk_pte(folio, vma->vm_page_prot);
 	entry = pte_sw_mkyoung(entry);
 	if (vma->vm_flags & VM_WRITE)
 		entry = pte_mkwrite(pte_mkdirty(entry), vma);
diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index af3dfc3633db..507a9e3caec7 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -1066,7 +1066,7 @@ static int move_present_pte(struct mm_struct *mm,
 	folio_move_anon_rmap(src_folio, dst_vma);
 	src_folio->index = linear_page_index(dst_vma, dst_addr);
 
-	orig_dst_pte = mk_pte(&src_folio->page, dst_vma->vm_page_prot);
+	orig_dst_pte = folio_mk_pte(src_folio, dst_vma->vm_page_prot);
 	/* Follow mremap() behavior and treat the entry dirty after the move */
 	orig_dst_pte = pte_mkwrite(pte_mkdirty(orig_dst_pte), dst_vma);
 
-- 
2.47.2


