Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D919C021B1
	for <linux-um@archiver.kernel.org>; Mon, 17 Feb 2025 19:10:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DQ8pEjsubtBd0+r7ArW3+Pwnui7gFm3cbKmo8d222fI=; b=FiX0pJkX9xROya5Zz/5UzjhaLs
	xb3nS7AI6i816PRQ+inXUf+FGsChinZJ81vnUVXVUkpUKjWvAqR0NxENNZ5fdgS/nTIuR007mHPd8
	DLDhRmlgTmydJwZJdIyZaInu8TwghDjzgIt55+7TnsUhfI4SgcKIE3c4h7+YGTQ4eP+cJ0EUMdLS4
	YYSzb5Us3Rwxm39PgsFOJPlZ3r67CfjGLMD6NN/VxRRy9o+xbDG/WQhCXtFrpq9ru3NkznhVRgHni
	jW5TQol86WkIjg0xieNvZNFy7LSXoNAK9tIWiruOCk8ZPvRWgaJ9TR9pbtwJIlezyNOW1P6AvFEwz
	TkQcGK0A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tk6W2-00000005iNN-3h1R;
	Mon, 17 Feb 2025 19:10:50 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tk6U4-00000005hzR-4AsC
	for linux-um@bombadil.infradead.org;
	Mon, 17 Feb 2025 19:08:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=DQ8pEjsubtBd0+r7ArW3+Pwnui7gFm3cbKmo8d222fI=; b=VviXey2+gk7RQlHla7fyP62RbI
	TWt5oMDGkBP4sH/ZbqUgWk8bfKkMHOigOck3TrdZiCNDAVRbOYFTGqv5DDvX6UgttQFSlvwPw9TsP
	NLCPz9fidRWT/lWflrucyZKu1lXBP23nJGb0UafoScOJ+2xcIjlAcbGJMsM2zrZXqcmVXIjmeSe70
	VL1w0cEd8G7h/4R9o4P/G74QbYHA+UQJmatysUlnLAXoPic8p1UTx+k06XYAUa5hXp5ikTZ/C8t5t
	ckJWGnG7IdVoN3DVdUN95CMcdnIYHnW+v4WLn46jowGmawC3q3v17uKqvUt3MTrWYlS4Vm4MxDull
	HBNOJXwg==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tk6Tu-00000001pBD-2cvi;
	Mon, 17 Feb 2025 19:08:38 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: linux-mm@kvack.org
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-arch@vger.kernel.org,
	x86@kernel.org,
	linux-s390@vger.kernel.org,
	sparclinux@vger.kernel.org,
	linux-um@lists.infradead.org
Subject: [PATCH 1/7] mm: Set the pte dirty if the folio is already dirty
Date: Mon, 17 Feb 2025 19:08:28 +0000
Message-ID: <20250217190836.435039-2-willy@infradead.org>
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

If the first access to a folio is a read that is then followed by a
write, we can save a page fault.  s390 implemented this in their
mk_pte() in commit abf09bed3cce ("s390/mm: implement software dirty
bits"), but other architectures can also benefit from this.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 arch/s390/include/asm/pgtable.h | 7 +------
 mm/memory.c                     | 2 ++
 2 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/arch/s390/include/asm/pgtable.h b/arch/s390/include/asm/pgtable.h
index 3ca5af4cfe43..3ee495b5171e 100644
--- a/arch/s390/include/asm/pgtable.h
+++ b/arch/s390/include/asm/pgtable.h
@@ -1451,12 +1451,7 @@ static inline pte_t mk_pte_phys(unsigned long physpage, pgprot_t pgprot)
 
 static inline pte_t mk_pte(struct page *page, pgprot_t pgprot)
 {
-	unsigned long physpage = page_to_phys(page);
-	pte_t __pte = mk_pte_phys(physpage, pgprot);
-
-	if (pte_write(__pte) && PageDirty(page))
-		__pte = pte_mkdirty(__pte);
-	return __pte;
+	return mk_pte_phys(page_to_phys(page), pgprot);
 }
 
 #define pgd_index(address) (((address) >> PGDIR_SHIFT) & (PTRS_PER_PGD-1))
diff --git a/mm/memory.c b/mm/memory.c
index 539c0f7c6d54..4330560eee55 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -5124,6 +5124,8 @@ void set_pte_range(struct vm_fault *vmf, struct folio *folio,
 
 	if (write)
 		entry = maybe_mkwrite(pte_mkdirty(entry), vma);
+	else if (pte_write(entry) && folio_test_dirty(folio))
+		entry = pte_mkdirty(entry);
 	if (unlikely(vmf_orig_pte_uffd_wp(vmf)))
 		entry = pte_mkuffd_wp(entry);
 	/* copy-on-write page */
-- 
2.47.2


