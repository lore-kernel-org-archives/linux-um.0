Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBE17C04FE2
	for <linux-um@archiver.kernel.org>; Tue, 25 Jul 2023 04:22:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=q+vgYgNnFIPv6/m53xkTx75C7BJETMjVq3uruvzFAzw=; b=qvLKDuHboZbl/6
	XnhUpIYJvnsUnl0nYJGFLjsR8Hb0gZCi3EEwt5wnjD1NNoSAqhuW+j2Glv3zlX8xL3sCl7+uo9ZAo
	/7EIoW6lM7efetzc8N1jf84kasJeIP2ouqTHDUkuk7KVXg/35rXreaMiPDGwpyEODz3Qrw4JowOqG
	PnNxCjyiAtUKeebk4wAgWKicF7L75kAufIX3m9XOjBT34C9lxIterXzOPjv7c5MQEfcpmHntdYC8S
	a7xAQXEWAtKXlwppOyec7HqjgDbs4Ss4npZklEt9zXhv/p48ScfO0GxjtvNOjKEvXsoPGpHjHvrtw
	81lOqnYQ0MHj4v81XtzQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qO9Z6-0068E7-0y;
	Tue, 25 Jul 2023 04:22:28 +0000
Received: from mail-yb1-xb36.google.com ([2607:f8b0:4864:20::b36])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qO9Y3-0067AD-30;
	Tue, 25 Jul 2023 04:21:26 +0000
Received: by mail-yb1-xb36.google.com with SMTP id 3f1490d57ef6-d167393b95aso1020971276.0;
        Mon, 24 Jul 2023 21:21:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690258883; x=1690863683;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iy/rMhqpUcv/05FOZn+4srvOxwPFLEA5us+pK4Rb6lw=;
        b=DwndbpJ6ZJrYKMHpG4xKikBhk7x+krWdi68yaEUskEkiop40SD81D3SbVY3seOkRYX
         /kBw1kbEHeLJuAWxODh8wznz3CeaeUpUO4YYOfw0VBoc804gVI4mMhkv5lDO7g/hc/Ox
         TXEzhNof0Ms0qo0Det2yGSzvCCxAKXVShq3qZYqhwj2d67+5rTird7vmREAL8b8Si8Ac
         tOq0IFFx/OCdHFNMMX58/9jGd+Cn0j6BluiHfy+sp+cwHgX7LWNmOOEbAbHaR8hHlJNg
         plgZtGI8EoaWjuEjbu+IQ9bgYRh88XsoYPHoE7Qno7Yp+zMkk++OeXafcS4wt+s+lSyS
         wNUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690258883; x=1690863683;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iy/rMhqpUcv/05FOZn+4srvOxwPFLEA5us+pK4Rb6lw=;
        b=gRiGCYV2YhP4NgEoZPQ9BcGNNdlzvaLVsiu/z6oigJ7UnsOiUlKZYoZ3i61SUn7Ywd
         czgIZqo3yteRjGq5AJmxLFG+HMrRmZ3BxNLol1E0kmxT8Do82Rc6O6WHlCDUg9F28n5w
         UKOds0Ro1I7z6iJ0gFTgC0vlKmyV9VxI92n3bqKwD1z3NyNNdw1JBVDF5CJZry3B6jxM
         NcB5RJBT+orrX3GtXILXre+AkfCaQjWQvfMGq0yy9dMYy4lImmoEAhN07jVySdtjvx1s
         75rB7BMR+pe3HHHlte41G8I6MqQS3j9hWHpVsjRzM9oEEDbowVMAY6h/dcE5P74XUbI6
         y7EA==
X-Gm-Message-State: ABy/qLZC1rGoYDhZbBh3fq/6mu+3MlpuqgQh0vv+64mlJ3CC0P9PHW1K
	Zk+52NP7xS14PYxhwwBUXeg=
X-Google-Smtp-Source: APBJJlF+SF4cjauiYcGzSv/LhxAh6sYfbdxhzn585BID5O/OlI17XEMKbBKdqUp1OW6pVPf/RqCKZQ==
X-Received: by 2002:a25:908e:0:b0:d07:b677:3349 with SMTP id t14-20020a25908e000000b00d07b6773349mr1259438ybl.25.1690258883131;
        Mon, 24 Jul 2023 21:21:23 -0700 (PDT)
Received: from unknowna0e70b2ca394.attlocal.net ([2600:1700:2f7d:1800::16])
        by smtp.googlemail.com with ESMTPSA id h9-20020a25b189000000b00d0db687ef48sm1175540ybj.61.2023.07.24.21.21.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jul 2023 21:21:22 -0700 (PDT)
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
Subject: [PATCH mm-unstable v7 08/31] mm: Convert ptlock_init() to use ptdescs
Date: Mon, 24 Jul 2023 21:20:28 -0700
Message-Id: <20230725042051.36691-9-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230725042051.36691-1-vishal.moola@gmail.com>
References: <20230725042051.36691-1-vishal.moola@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230724_212123_985598_E05AC07E 
X-CRM114-Status: GOOD (  10.27  )
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
index 52ef09c100a2..675972d3f7e4 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2873,7 +2873,7 @@ static inline spinlock_t *pte_lockptr(struct mm_struct *mm, pmd_t *pmd)
 	return ptlock_ptr(page_ptdesc(pmd_page(*pmd)));
 }
 
-static inline bool ptlock_init(struct page *page)
+static inline bool ptlock_init(struct ptdesc *ptdesc)
 {
 	/*
 	 * prep_new_page() initialize page->private (and therefore page->ptl)
@@ -2882,10 +2882,10 @@ static inline bool ptlock_init(struct page *page)
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
 
@@ -2898,13 +2898,13 @@ static inline spinlock_t *pte_lockptr(struct mm_struct *mm, pmd_t *pmd)
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
@@ -2979,7 +2979,7 @@ static inline bool pmd_ptlock_init(struct ptdesc *ptdesc)
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
