Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56BB9C531DD
	for <linux-um@archiver.kernel.org>; Wed, 14 Aug 2024 15:44:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RiQi1xwu7xn6bnJpfQHAtVQLm2/6ihErCEfVj9tkBvo=; b=l/D289D97+x1x2YxvnZ6tWU5L7
	JHysHs/oSbJnMT838swpba9c2e+e7iwDtcP9rbtXXKGQX3XKzBHmNIloTSG9r9JE5fTVlFZ+0nelD
	wxLKKMGP4nLlGrzku/OxcLVPFaL6DMYHwD/1wCO/2U7Dw9ihksSuEYI9Qv5qPxhT/OIAMgKWicgXa
	FvzQFYXy6G6ouF1VH2xYqPpmP6K9+ybKn4W7+zMcUOKUmoaVtSCcFsiSaMOW58htLTrl4f510YsZ1
	rHSYOYe2CFMD3mjb3pbF8ik7jxXLUITSKviOSOMfPlv73Qr67I9mfvwxY8l7dL7IjwgEgIJYcwgRE
	IhVIRN9Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1seGBH-00000007WFk-034B;
	Wed, 14 Aug 2024 15:44:59 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1seGAt-00000007W4A-2H3i
	for linux-um@bombadil.infradead.org;
	Wed, 14 Aug 2024 15:44:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=RiQi1xwu7xn6bnJpfQHAtVQLm2/6ihErCEfVj9tkBvo=; b=eHUARuZI/k2Siw5xMucTFO1tFs
	05neo4SYQKbnin4Egz7zuBogKPG7eGd9qUe7d4gppGr4IWqI61e9aBFE0AMunOrIKk369OGVndms1
	9RaI4Kvd8Hw6ZxPySlCYJ9s5YkPUOWlsq11SKMfD40O2Q9Ik/HDtitTLPVqcHmFnclYyvmjKD+7Ct
	oF+1Ux/f0lDn/OUtQAziz0DQupDEF0WHKsIVzAN5EUjXqCZhBKwAr1Oqn2ubs+PYN6cGLQYDKbgha
	LK0VRLXkQXOb7gRUbIOhFqZMEhlXSt6QSbUkVgKguotrrcms4P06UNwWnMMeMAk8rfvoAYzYdVEN1
	1vZAwaZw==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1seGAs-00000000gHU-1YgC;
	Wed, 14 Aug 2024 15:44:34 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: linux-mm@kvack.org,
	linux-arch@vger.kernel.org
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-s390@vger.kernel.org,
	linux-um@lists.infradead.org,
	x86@kernel.org
Subject: [PATCH 4/5] s390: Remove custom definition of mk_pte()
Date: Wed, 14 Aug 2024 16:44:24 +0100
Message-ID: <20240814154427.162475-5-willy@infradead.org>
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

I believe the test for PageDirty() is no longer needed.  The
commit adding it was abf09bed3cce with the rationale that this
avoided faults for tmpfs and shmem pages.  shmem does not mark
newly allocated folios as dirty since 2016 (commit 75edd345e8ed)
so this test has been ineffective since then.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 arch/s390/include/asm/pgtable.h | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/arch/s390/include/asm/pgtable.h b/arch/s390/include/asm/pgtable.h
index 6a21d947a687..1bb7f33394d0 100644
--- a/arch/s390/include/asm/pgtable.h
+++ b/arch/s390/include/asm/pgtable.h
@@ -1413,17 +1413,6 @@ static inline pte_t mk_pte_phys(unsigned long physpage, pgprot_t pgprot)
 	return pte_mkyoung(__pte);
 }
 
-static inline pte_t mk_pte(struct page *page, pgprot_t pgprot)
-{
-	unsigned long physpage = page_to_phys(page);
-	pte_t __pte = mk_pte_phys(physpage, pgprot);
-
-	if (pte_write(__pte) && PageDirty(page))
-		__pte = pte_mkdirty(__pte);
-	return __pte;
-}
-#define mk_pte mk_pte
-
 #define pgd_index(address) (((address) >> PGDIR_SHIFT) & (PTRS_PER_PGD-1))
 #define p4d_index(address) (((address) >> P4D_SHIFT) & (PTRS_PER_P4D-1))
 #define pud_index(address) (((address) >> PUD_SHIFT) & (PTRS_PER_PUD-1))
-- 
2.43.0


