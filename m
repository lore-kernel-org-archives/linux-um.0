Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57BB5C00528
	for <linux-um@archiver.kernel.org>; Thu, 22 Jun 2023 20:59:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=NLoFmgQvrTo+qP5nn4vwV6/wmM9qqFeRuvyFWNxln8I=; b=RuAXvfOckqmgg0
	+aTcdoVe5EUlTdf7GvYSj3mzTXOBkduNXZZlEaJnXDK8mqQY5/GMk8ruIl2747qkGTiEa0Qi70pKP
	hnotvtHCMFwYyjyeEmSymK9Et0aKgj4Mpex4SNLPmXOsfCAp6drtwYrU6SgqIeYfr5eDO7HkJHtbn
	t0Hbp8LDupAOcQUwj19gE8DW36Qvrf2yGdKWo6roj0bDKKkc4b76vAvnIaA+sB+wFDlRn4qnZvFdl
	iKyZbxUtDZq6258y+6btdNu2beXvITQmUVa7upmL+F0PldvOOaM9SCN4+UFvW/fQI7f3E0cYq/pB7
	UvRKiCz/lX/jnZGh/qlQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qCROw-001j3N-2D;
	Thu, 22 Jun 2023 20:59:34 +0000
Received: from mail-yb1-xb35.google.com ([2607:f8b0:4864:20::b35])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qCRNf-001hjU-1I;
	Thu, 22 Jun 2023 20:58:16 +0000
Received: by mail-yb1-xb35.google.com with SMTP id 3f1490d57ef6-bc4e41b7bc9so7406199276.2;
        Thu, 22 Jun 2023 13:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687467494; x=1690059494;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uRcW1jW+95PozpJhE7MOWGztyyXp9a8KAqI8T3AvQGQ=;
        b=HsKWFMjgc4nubz/CGqFDPycebn/IPCG8iEQx6Mn71pJrvZNcRYxgpmqqwFpryLpJLe
         U6CGU7xvBFlirMshzGg8T6i9YZLzGTtKn+CcBm+t56pm6lJ3TVyGOGzuaYqSKVupajIy
         2DQcn5crUg65j6RvjiPUyIXYF96jtw4qqx3rhyDnmY0a3BGeHq9tpmXxMVnvgVEpyfbE
         yzd/PSl+jlwziFt4f/K0ChaqSr0HvoaTl5CqhIJz/dAvHyE0NXDWuGcwuqDlT7PKZ2aX
         gZRI6eIDsk4xWFnXPJdwPbiPss9pl0UJqOUtsNLHKXkhccURxnMshNZ4JT+gJbW9Nc9s
         Wlpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687467494; x=1690059494;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uRcW1jW+95PozpJhE7MOWGztyyXp9a8KAqI8T3AvQGQ=;
        b=PIboWT0uwpiAPivd3FqglIPuQcxGUAKD5RdS+p7kK7r7dTe4LI6CvnE+GLeq5yHChw
         /13vIu/7MidEkjzHVr33MHO8C9n9xipJgccSAouSmWSmnvzxOCOFJ37vD96ZHTf40Mpz
         zV/kylbk9ZIJ3/n0kxazEeCDsyaok1ylKJm9j2sDfX6ZQl8ngfouOaBc0cV9rloWtw9C
         TnjZW8ccgzvxNhV9oTEVkqYL2ZMuCIEO7syXGc1vJvz4NRSZyEqEYSTk+2Khb+eV4XhF
         lIyDQEN1KNY52sjsRqk6Bkn+Is3CWkXk0wUNqwlSL7u0fcB5hIuw/cgj0gIgcU4MLq0n
         N/+Q==
X-Gm-Message-State: AC+VfDzB1dr8dQ6/Qkde2kjv2o0xHAuegQRjMAilannIUBo8zcHtRdrd
	suQ8t4MtmJyDc9BKZ0pBHRZ1CZy8eq+e2A==
X-Google-Smtp-Source: ACHHUZ6cGkwHgROFidQ6wg7SrcN0EGNFb8Fy55CY8QeCStx6HVI/iqe9yVRaoh7RjiWHDP58CRtZwQ==
X-Received: by 2002:a25:f902:0:b0:bff:209a:9034 with SMTP id q2-20020a25f902000000b00bff209a9034mr4880542ybe.22.1687467494535;
        Thu, 22 Jun 2023 13:58:14 -0700 (PDT)
Received: from unknowna0e70b2ca394.attlocal.net ([2600:1700:2f7d:1800::36])
        by smtp.googlemail.com with ESMTPSA id d18-20020a5b0c52000000b00bc501a1b062sm1684937ybr.42.2023.06.22.13.58.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jun 2023 13:58:14 -0700 (PDT)
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
Subject: [PATCH v5 09/33] mm: Convert ptlock_init() to use ptdescs
Date: Thu, 22 Jun 2023 13:57:21 -0700
Message-Id: <20230622205745.79707-10-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230622205745.79707-1-vishal.moola@gmail.com>
References: <20230622205745.79707-1-vishal.moola@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230622_135815_444754_4F00FAC5 
X-CRM114-Status: UNSURE (   9.96  )
X-CRM114-Notice: Please train this message.
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
 include/linux/mm.h | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 1c4c6a7b69b3..4af424e4015a 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2830,7 +2830,7 @@ static inline spinlock_t *pte_lockptr(struct mm_struct *mm, pmd_t *pmd)
 	return ptlock_ptr(page_ptdesc(pmd_page(*pmd)));
 }
 
-static inline bool ptlock_init(struct page *page)
+static inline bool ptlock_init(struct ptdesc *ptdesc)
 {
 	/*
 	 * prep_new_page() initialize page->private (and therefore page->ptl)
@@ -2839,10 +2839,10 @@ static inline bool ptlock_init(struct page *page)
 	 * It can happen if arch try to use slab for page table allocation:
 	 * slab code uses page->slab_cache, which share storage with page->ptl.
 	 */
-	VM_BUG_ON_PAGE(*(unsigned long *)&page->ptl, page);
-	if (!ptlock_alloc(page_ptdesc(page)))
+	VM_BUG_ON_PAGE(*(unsigned long *)&ptdesc->ptl, ptdesc_page(ptdesc));
+	if (!ptlock_alloc(ptdesc))
 		return false;
-	spin_lock_init(ptlock_ptr(page_ptdesc(page)));
+	spin_lock_init(ptlock_ptr(ptdesc));
 	return true;
 }
 
@@ -2855,13 +2855,13 @@ static inline spinlock_t *pte_lockptr(struct mm_struct *mm, pmd_t *pmd)
 	return &mm->page_table_lock;
 }
 static inline void ptlock_cache_init(void) {}
-static inline bool ptlock_init(struct page *page) { return true; }
+static inline bool ptlock_init(struct ptdesc *ptdesc) { return true; }
 static inline void ptlock_free(struct page *page) {}
 #endif /* USE_SPLIT_PTE_PTLOCKS */
 
 static inline bool pgtable_pte_page_ctor(struct page *page)
 {
-	if (!ptlock_init(page))
+	if (!ptlock_init(page_ptdesc(page)))
 		return false;
 	__SetPageTable(page);
 	inc_lruvec_page_state(page, NR_PAGETABLE);
@@ -2931,7 +2931,7 @@ static inline bool pmd_ptlock_init(struct ptdesc *ptdesc)
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 	ptdesc->pmd_huge_pte = NULL;
 #endif
-	return ptlock_init(ptdesc_page(ptdesc));
+	return ptlock_init(ptdesc);
 }
 
 static inline void pmd_ptlock_free(struct page *page)
-- 
2.40.1


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
