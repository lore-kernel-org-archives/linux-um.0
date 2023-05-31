Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F379DC77B7A
	for <linux-um@archiver.kernel.org>; Wed, 31 May 2023 22:41:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=l66ZYdmtULIT4dx859W7LVapJGxskV3sZ+SsYhT4QwU=; b=d4so8vGN+ksY4b
	GC58McDWDZ0Rgh1zjspLYp67G5l+7oG47BobgKNK3kUTvDqubsd7fYMg+u2f01Llt5/vRpeBNHuhu
	Q9hCTbX8+XPxbl1UZHiRXrd2lt+hBlCronwqKiC5/DVrREUtKoO6PKqwPVVcg39L+XsXy4f3sQznE
	W1uQ2DwhI8b/+PZBub6D1ND4RBQfXYG4JnimEnv+y4a0CIp2yFEQUMj+gvBtrYjrpbC1871QVolDd
	Qs937i8PoxZJ2Jex8XxipyKVJZEizRAf5nNGFlxfM5+ZdbEyND1zTtZrQbQSDiQOPgwWbFpw36KDy
	E8JSwjx505qMOU/wv+/w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q4UVa-001LSn-20;
	Wed, 31 May 2023 22:41:34 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q4UVQ-001LOz-0z;
	Wed, 31 May 2023 22:41:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=JALdXD/M7jBu0Q8jfR4m4Tx9IinYQtlxZ5YXkrMJ3RM=; b=q69qw+j14mPZvIWyETX0QIL1DZ
	pJFQqtxJ1RA7A3eEdZYmGDCkTRkHdc4duJHtqfdNU9H9p9cyNh2eEM7gg09sGuz/prxGGWDFmar3E
	W2ejc3tvT5OPhpsVOvIMSvc8i3xNrYEbbQDY9k0WKvMelxDTz0V27x5n9e+x659UsNx01ph7u25/c
	93nL7zNbcLrydlFt6TL7q1iRbuXefj91RZaitjZRfnO5PFX8KnUb5V835c0MiVajNfE5GG0iHR4ll
	dbfPV/+OGqpmHXwQBEs9vTQ9nOo14+zkIn/znfUACiDcjRppLr3pHbVtjX/hsaCZ2s8gCW4cKczCd
	f7G+521Q==;
Received: from mail-yw1-x1136.google.com ([2607:f8b0:4864:20::1136])
	by desiato.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q4TPq-00FdN0-32;
	Wed, 31 May 2023 21:31:43 +0000
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-561c1436c75so804577b3.1;
        Wed, 31 May 2023 14:31:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685568693; x=1688160693;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JALdXD/M7jBu0Q8jfR4m4Tx9IinYQtlxZ5YXkrMJ3RM=;
        b=SDECzrupkY8P71D5Bx9Ena6q3wieNwuGBpSv8ettDWf4PjEIxkW1kzC+/sNtzTCciF
         08YPq8+A8ip8H8kzMs94GMf7GyNCyBFe+MQWmq4tDFaYpFFNOE6UTqgnOULDbhNW0X9R
         mptdXbgDm5NvfVfzaMpwLm1cS6nmZ7EARb4uqJGF+rFwJSp8Gd0Dc+nu6W5F2EiHrPlp
         wvBO17QGrS6gAkojPK4/lKp5/gxat5ehsK5W06KJyleVWDfyXvKL/KtB/UxjcTPMijxH
         kcvx1/i/I9fdgW5R6GrMiCaj6gwLScpZ5XR6LtwZa6L23gJoAxE1JEulvsNvUD9DStHW
         I/CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685568693; x=1688160693;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JALdXD/M7jBu0Q8jfR4m4Tx9IinYQtlxZ5YXkrMJ3RM=;
        b=T61m6sfBb3K6aVGMPBeq54zLujpTno3SvESchy3KW5UKm4833ULbf+wiI7hVuJ0ak7
         sJVnCcxFDfX9YztWJ6qdz9mrfmKKOiUop+A2knBJ7JuSvnPenK/nPnZ4g8rI1ZdOuZnw
         y7B7CzpqTcOxwZJtNW0pfUFHMmgUxWUyHpWaU/ISRIlBTjLrVfmyo4d28Sfpc2mRWZPR
         pnHfgbgD5H36OiEy6paUAmM8gzuSbjfbkhWWWWD/eYYuIfs2RR6TYB4jjMTBj1Ja91A1
         1ZDfS8cxi8Fjo6No+Ge8z/UuDLvL6ErNqU+weyw38aixtkCfkznX/vepzML2VEVjjFDu
         x0SQ==
X-Gm-Message-State: AC+VfDx2jPmJcgoX5dFb5vcfPdVrt5tKSuh2SBzZxO5Ma7r4qew1UHFf
	ez8MpakY15FlrBYtuypD2Kk=
X-Google-Smtp-Source: ACHHUZ7Dif7B1ZpmhmssBZICB8FP9/M3ln6TJpLdw+EDe49hetyZ/pJac8jXPpLostqsKq4KAza0XA==
X-Received: by 2002:a81:4ed2:0:b0:568:4ef1:ba63 with SMTP id c201-20020a814ed2000000b005684ef1ba63mr7706752ywb.14.1685568692854;
        Wed, 31 May 2023 14:31:32 -0700 (PDT)
Received: from unknowna0e70b2ca394.attlocal.net ([2600:1700:2f7d:1800::46])
        by smtp.googlemail.com with ESMTPSA id t63-20020a0dd142000000b0055aafcef659sm658905ywd.5.2023.05.31.14.31.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 May 2023 14:31:32 -0700 (PDT)
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
Subject: [PATCH v3 12/34] mm: Convert ptlock_free() to use ptdescs
Date: Wed, 31 May 2023 14:30:10 -0700
Message-Id: <20230531213032.25338-13-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230531213032.25338-1-vishal.moola@gmail.com>
References: <20230531213032.25338-1-vishal.moola@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230531_223138_188426_A0A442F9 
X-CRM114-Status: GOOD (  10.71  )
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
 include/linux/mm.h | 10 +++++-----
 mm/memory.c        |  4 ++--
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index ffc82355fea6..72725aa6c30d 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2807,7 +2807,7 @@ static inline void pagetable_clear(void *x)
 #if ALLOC_SPLIT_PTLOCKS
 void __init ptlock_cache_init(void);
 bool ptlock_alloc(struct ptdesc *ptdesc);
-extern void ptlock_free(struct page *page);
+void ptlock_free(struct ptdesc *ptdesc);
 
 static inline spinlock_t *ptlock_ptr(struct ptdesc *ptdesc)
 {
@@ -2823,7 +2823,7 @@ static inline bool ptlock_alloc(struct ptdesc *ptdesc)
 	return true;
 }
 
-static inline void ptlock_free(struct page *page)
+static inline void ptlock_free(struct ptdesc *ptdesc)
 {
 }
 
@@ -2864,7 +2864,7 @@ static inline spinlock_t *pte_lockptr(struct mm_struct *mm, pmd_t *pmd)
 }
 static inline void ptlock_cache_init(void) {}
 static inline bool ptlock_init(struct ptdesc *ptdesc) { return true; }
-static inline void ptlock_free(struct page *page) {}
+static inline void ptlock_free(struct ptdesc *ptdesc) {}
 #endif /* USE_SPLIT_PTE_PTLOCKS */
 
 static inline bool pgtable_pte_page_ctor(struct page *page)
@@ -2878,7 +2878,7 @@ static inline bool pgtable_pte_page_ctor(struct page *page)
 
 static inline void pgtable_pte_page_dtor(struct page *page)
 {
-	ptlock_free(page);
+	ptlock_free(page_ptdesc(page));
 	__ClearPageTable(page);
 	dec_lruvec_page_state(page, NR_PAGETABLE);
 }
@@ -2936,7 +2936,7 @@ static inline void pmd_ptlock_free(struct ptdesc *ptdesc)
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 	VM_BUG_ON_PAGE(ptdesc->pmd_huge_pte, ptdesc_page(ptdesc));
 #endif
-	ptlock_free(ptdesc_page(ptdesc));
+	ptlock_free(ptdesc);
 }
 
 #define pmd_huge_pte(mm, pmd) (pmd_ptdesc(pmd)->pmd_huge_pte)
diff --git a/mm/memory.c b/mm/memory.c
index 8d37dd302f2f..df0251243dfa 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -5949,8 +5949,8 @@ bool ptlock_alloc(struct ptdesc *ptdesc)
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
