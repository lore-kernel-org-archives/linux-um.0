Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C41FC77B76
	for <linux-um@archiver.kernel.org>; Mon, 17 Apr 2023 21:18:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=HWPHBuhqKRObKXrFL/MTBPQGPqbJtnYlbh12LDO/ec4=; b=mp+OA+UPF4ID6T
	/Kvj94lRmn/B6FfXnfPHkRXOfP0lMp8W1vyITC5AH0PrFfYGvSPDh2+UPjvEpWFUZnmyfi4WiTVV7
	z+HF4UAqmhugba3qNH2qMcbzvu9faS1dpn6LxcQ89j9EGH0H+/HFBRRAfpGmDQqhQMwT+9VZx2URh
	fV7EEk29muHhwFKV3anqBftadkrAyD/KaJTeODInEKgpMW1VWJsvyomGWAv5mSNBr+6sdFjl5Q8uz
	wL2m+dgBFHADOyMbErNC+SPnY7lUR5hsn4YGUSC4QBFuTGSsZjSfjGJJUHNtTGQXKRvVuWWx2PjhR
	hCZxykZltVkzkBMuSrqg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1poWEY-0002kj-0T;
	Mon, 17 Apr 2023 21:17:58 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1poWE8-0002G2-0D;
	Mon, 17 Apr 2023 21:17:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=X2z4+jy2VvwYGAEqDadtXD4/9gzlnrS5efeNMpJ5P9k=; b=meQyHqGE15L87OlwDMtoyNOwL6
	sisOJMkxB+l+0+NtQwmcUprIJTzGgbCSqbD9dBWQ3B9VX/fOf2Gjq585vDKbjBvqqzamzZF8h38i6
	5a+g5N7UUjfye/EGNlJORs7+0xklPXy2LKdmu9MCDCkt17oNv5d/hvjp2yfTpIJGnFM2ae+5BKEp2
	/aLgBEfg/AU1xkG5i9R2aD/hoYI/oWd3KK+gVUoTsvdgimzlxJsILAREsxFi62kFhTchvPVU49FzW
	313RmosMqB/R03zBe1ruHA12hyO78c5itbvZKRrDd2iVJh0OC7PRxvVBbT4inMfmJw7hfJQ0l8ZM+
	S0kHIopQ==;
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
	by casper.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1poVqO-00Bfn7-RM; Mon, 17 Apr 2023 20:53:03 +0000
Received: by mail-pl1-x633.google.com with SMTP id la15so4090119plb.11;
        Mon, 17 Apr 2023 13:53:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681764778; x=1684356778;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X2z4+jy2VvwYGAEqDadtXD4/9gzlnrS5efeNMpJ5P9k=;
        b=I/h1pnbYM2DwgRZCSJteD0jcjPogajwYvoNTWu05FIt8Dug2P9e0wRrWLPxc4zYyi2
         bF+AVTemVcp3diPO+7OSxLM72RxW/MppC8vSDXDjD8liqzM1pBLkxoUoebzionO/oxsa
         qHKGIp7d97W6jlem/3yxXQy6r/jNX2Q0ie6VB85Wwsz/8JpbJnzPVNlM6MFS7XC7iPJr
         OFMLKNx0UPHxfGtNqDckarA/92oBRif46FzIncuYkpkQ+fhRc09HfBoH8I7mBRTJiPxj
         c4VsiDutZTNuFgmpjh8q1KLiugVszPA4Gaz711F805EB6LUcut5gmvOb7RYuzrO1w3sO
         Wqsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681764778; x=1684356778;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X2z4+jy2VvwYGAEqDadtXD4/9gzlnrS5efeNMpJ5P9k=;
        b=JuIYGbIed0fyIEG8F4Yw6w2rSktn8E4UnXUZ5CMe9G5UZ9k9Cjk6Wb7qw0LiK6ycAh
         XrLkRE1HkQ6l6+RTZrJF6OFp4iH4hF/993NZXCoZqh6K0jiHj/akU3NwJGHq/ootyaEa
         sd+K/SdxXSgIervWr2nOUHnWBTG6b3ZMNoMqD+buEJqIKAla+qPNqRmk+3RZOzUK+Gva
         UTyS6jgfKRf4FhBOr8Ba2TyhG8DkMNlYf7Pc0QkOymiw59msoCEp1B9x4V87bnf8g0q2
         J3hN3F1Wk+0WFjf9kU6XNJDn7oxK435F+6Q7ypilS5cljQSLmevSx9ETg2u8h9vSSkgw
         xTIw==
X-Gm-Message-State: AAQBX9fNMlHcXAAG3Y1DGEGA4TJ0odCq3w6lma04GqleW5VIWPDWMA1Z
	Elqg3YF8pJgM6SpfDXSDs5s=
X-Google-Smtp-Source: AKy350a6Xakm9Y4oYLvOvIWfyGM8BNUM3uv3d+WixCRDkQ1rcDDo2rZhVhsbndThyou7yfhT1XyHRg==
X-Received: by 2002:a17:90a:8a04:b0:247:14ac:4d3a with SMTP id w4-20020a17090a8a0400b0024714ac4d3amr17877854pjn.20.1681764778063;
        Mon, 17 Apr 2023 13:52:58 -0700 (PDT)
Received: from fedora.hsd1.ca.comcast.net ([2601:644:937f:7f20::c139])
        by smtp.googlemail.com with ESMTPSA id h7-20020a17090ac38700b0022335f1dae2sm7609707pjt.22.2023.04.17.13.52.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Apr 2023 13:52:57 -0700 (PDT)
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
	"Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [PATCH 09/33] mm: Convert ptlock_init() to use ptdescs
Date: Mon, 17 Apr 2023 13:50:24 -0700
Message-Id: <20230417205048.15870-10-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230417205048.15870-1-vishal.moola@gmail.com>
References: <20230417205048.15870-1-vishal.moola@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230417_215300_922211_1F428AC5 
X-CRM114-Status: GOOD (  10.28  )
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
---
 include/linux/mm.h | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 7eb562909b2c..d2485a110936 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2818,7 +2818,7 @@ static inline spinlock_t *pte_lockptr(struct mm_struct *mm, pmd_t *pmd)
 	return ptlock_ptr(page_ptdesc(pmd_page(*pmd)));
 }
 
-static inline bool ptlock_init(struct page *page)
+static inline bool ptlock_init(struct ptdesc *ptdesc)
 {
 	/*
 	 * prep_new_page() initialize page->private (and therefore page->ptl)
@@ -2827,10 +2827,10 @@ static inline bool ptlock_init(struct page *page)
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
 
@@ -2843,13 +2843,13 @@ static inline spinlock_t *pte_lockptr(struct mm_struct *mm, pmd_t *pmd)
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
@@ -2908,7 +2908,7 @@ static inline bool pmd_ptlock_init(struct ptdesc *ptdesc)
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 	ptdesc->pmd_huge_pte = NULL;
 #endif
-	return ptlock_init(ptdesc_page(ptdesc));
+	return ptlock_init(ptdesc);
 }
 
 static inline void pmd_ptlock_free(struct page *page)
-- 
2.39.2


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
