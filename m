Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32758EB64DA
	for <linux-um@archiver.kernel.org>; Thu, 22 Jun 2023 20:59:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=9Q5Ubuk+5uSeC1nH8MS2xqrub1m9lgU6poooc8dD/pI=; b=S3htyxAy6stcRC
	fm5Hdy6HuljolQO+GtAvE75+s+0BPxFQTh5ysd2hy3ij7GAqzQlpj9dou/qvrUZBuoin+mMWyekFg
	Ic0b0SLpF59d1++hDQnev0BD7r6FdLtufkIiEI/FMQZEwEUciKmUTGgWDz2ugwZS/N23zTv5msr+5
	G5GGc36WvSLvGhkxS9glBK65hmOPSRR4cWP2fwEqdL5fhgigGKJWlqHp1MwcvsthTvLAuIyAmzrIp
	v1LM09rIb/3IBEoj9Q4N/An7XNdePtgPrZJJBspQhqXGS2B/5r8hJJ3zk+yTwCl3YBzyeidivganA
	uMRF5mHVncXfq0nEL6FA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qCRPG-001jLl-2c;
	Thu, 22 Jun 2023 20:59:54 +0000
Received: from mail-yb1-xb2e.google.com ([2607:f8b0:4864:20::b2e])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qCRNj-001hmy-1e;
	Thu, 22 Jun 2023 20:58:21 +0000
Received: by mail-yb1-xb2e.google.com with SMTP id 3f1490d57ef6-bb2ffa1e235so7076085276.0;
        Thu, 22 Jun 2023 13:58:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687467498; x=1690059498;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bhgUYiKwQSwYMGFv9d1r56wjiuPfdLCT9N5JwdJpvSY=;
        b=IkBs/PpafQMwMb5+bV+TjhgBJMISrd3r9Ehxv0D4bga5hDCjsodC2JnFe5fw5CuuNh
         oXzvywchS02bgspv2vVMsLaNaJfhQqRd4zMAT9dIGzvPtgGebpRn3vizNbCCeH4kxu0g
         TyHgRtXbQw9QJenBGoSSN+LcKZYEWvqLZfshqBtx5IJouxvVity8IJ3BMNOIhoxk8spN
         JqRw951qgrZvKDiFAsIL9Ao//k8BkssPPj/JxKTcUCZ9IjeC8TdTUdZgtY4aRKAk9cjf
         OLinZRYVomzL7Or7UYL6bwPiJppfDFOL1vHSgfsuBpqKRMQaWBk81ZwgHtszBi4jTAEe
         xuMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687467498; x=1690059498;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bhgUYiKwQSwYMGFv9d1r56wjiuPfdLCT9N5JwdJpvSY=;
        b=d9JeEepJCcjm4H1rELk22By83561EHIfr2dim+4swozVOdkYvqLcp0I1dXNoeiMmjy
         y6Sw5u+cNSLngj6dwwRfveo4waqhafn7aKIprSqU38t/ppXONPAyztS1HXneZdi5BvoY
         S5jKYYV8/JbGnwQ0VrtLaE0+FVWxtHeJd1ex3N/seOxFDixARhlwooNeShf1LzAWBpw9
         COD9MPQQdDgE+3n0/C+DzQqVEW0+g0mILyIz/FE0RFORU6tuN03zuvWeia9f7ySyCZKc
         eDbxOZnkQMRM4RorWgdb/FFLc8tvme/7I869twJzGuJ5TWYUh2J51Mt9H5isEfDTuEaE
         XOQQ==
X-Gm-Message-State: AC+VfDxQGyYgbrk5MFyX7aO4wwvjZMXkDlnudGfVntcoIuHu6ZbeycRy
	Er4ZSVySvqrxThN+01LHT1g=
X-Google-Smtp-Source: ACHHUZ7Pa6VOZ8zc9ZXGMhVrxtFlOQ5CfM1HOMla01BhywdpE01k0n5trNDAUGdHgqy9w/StTvGJbA==
X-Received: by 2002:a25:aaa9:0:b0:ba8:66fb:dd86 with SMTP id t38-20020a25aaa9000000b00ba866fbdd86mr17182535ybi.25.1687467498635;
        Thu, 22 Jun 2023 13:58:18 -0700 (PDT)
Received: from unknowna0e70b2ca394.attlocal.net ([2600:1700:2f7d:1800::36])
        by smtp.googlemail.com with ESMTPSA id d18-20020a5b0c52000000b00bc501a1b062sm1684937ybr.42.2023.06.22.13.58.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jun 2023 13:58:18 -0700 (PDT)
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
Subject: [PATCH v5 11/33] mm: Convert ptlock_free() to use ptdescs
Date: Thu, 22 Jun 2023 13:57:23 -0700
Message-Id: <20230622205745.79707-12-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230622205745.79707-1-vishal.moola@gmail.com>
References: <20230622205745.79707-1-vishal.moola@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230622_135819_587376_C19A05EB 
X-CRM114-Status: GOOD (  10.02  )
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
 include/linux/mm.h | 10 +++++-----
 mm/memory.c        |  4 ++--
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 0221675e4dc5..69e6d6696c44 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2799,7 +2799,7 @@ static inline void pagetable_free(struct ptdesc *pt)
 #if ALLOC_SPLIT_PTLOCKS
 void __init ptlock_cache_init(void);
 bool ptlock_alloc(struct ptdesc *ptdesc);
-extern void ptlock_free(struct page *page);
+void ptlock_free(struct ptdesc *ptdesc);
 
 static inline spinlock_t *ptlock_ptr(struct ptdesc *ptdesc)
 {
@@ -2815,7 +2815,7 @@ static inline bool ptlock_alloc(struct ptdesc *ptdesc)
 	return true;
 }
 
-static inline void ptlock_free(struct page *page)
+static inline void ptlock_free(struct ptdesc *ptdesc)
 {
 }
 
@@ -2856,7 +2856,7 @@ static inline spinlock_t *pte_lockptr(struct mm_struct *mm, pmd_t *pmd)
 }
 static inline void ptlock_cache_init(void) {}
 static inline bool ptlock_init(struct ptdesc *ptdesc) { return true; }
-static inline void ptlock_free(struct page *page) {}
+static inline void ptlock_free(struct ptdesc *ptdesc) {}
 #endif /* USE_SPLIT_PTE_PTLOCKS */
 
 static inline bool pgtable_pte_page_ctor(struct page *page)
@@ -2870,7 +2870,7 @@ static inline bool pgtable_pte_page_ctor(struct page *page)
 
 static inline void pgtable_pte_page_dtor(struct page *page)
 {
-	ptlock_free(page);
+	ptlock_free(page_ptdesc(page));
 	__ClearPageTable(page);
 	dec_lruvec_page_state(page, NR_PAGETABLE);
 }
@@ -2939,7 +2939,7 @@ static inline void pmd_ptlock_free(struct ptdesc *ptdesc)
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 	VM_BUG_ON_PAGE(ptdesc->pmd_huge_pte, ptdesc_page(ptdesc));
 #endif
-	ptlock_free(ptdesc_page(ptdesc));
+	ptlock_free(ptdesc);
 }
 
 #define pmd_huge_pte(mm, pmd) (pmd_ptdesc(pmd)->pmd_huge_pte)
diff --git a/mm/memory.c b/mm/memory.c
index 2ff14f50c7b3..8743aef6095b 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -5931,8 +5931,8 @@ bool ptlock_alloc(struct ptdesc *ptdesc)
 	return true;
 }
 
-void ptlock_free(struct page *page)
+void ptlock_free(struct ptdesc *ptdesc)
 {
-	kmem_cache_free(page_ptl_cachep, page->ptl);
+	kmem_cache_free(page_ptl_cachep, ptdesc->ptl);
 }
 #endif
-- 
2.40.1


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
