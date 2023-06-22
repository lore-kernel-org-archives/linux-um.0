Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25929C001DD
	for <linux-um@archiver.kernel.org>; Thu, 22 Jun 2023 20:59:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=S4MwHls9DHa5ksAHufu/c4ysiUgLBwBnegMq9Nhu+ZM=; b=ihHuA/tQuYUegi
	wiQbBHdjOi1FQT6mh4rzSTiAnSTEc/2lt76OwueuobEGziC7E+jZf7qgILRwEu0Cf2cCixlgg8V07
	qv/6WfQ1wg0JkJhbc/ex1+W5OLomgWv02MlfBMZ3Adj0gM0LdOEQNB2BtUIfcg2IDjYsDuAM8gMLd
	hDxM8IicjMJjFL9IdHMgXCEy4x2s6yDmsmMHTVs1pqE2uaopb0ChANXwL9GYZ0daSH4a2TEvcVvRR
	XjMNmxzOyvL/bgNjwgsbP2J2m0qa14r8AZ8WknJy6mzxMLwXhVI1CnFypJk3UkG0cZCQWSYasJR1X
	dAzema9EYzLHPHO0gEYg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qCROd-001ini-2u;
	Thu, 22 Jun 2023 20:59:16 +0000
Received: from mail-yb1-xb35.google.com ([2607:f8b0:4864:20::b35])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qCRNb-001hf6-2m;
	Thu, 22 Jun 2023 20:58:13 +0000
Received: by mail-yb1-xb35.google.com with SMTP id 3f1490d57ef6-bad0c4f6f50so1707022276.1;
        Thu, 22 Jun 2023 13:58:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687467490; x=1690059490;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z9Q71kHk0zB6vt5ahL9ZHs7069+SCA/PofhBzVdlAuY=;
        b=SXnr3kTV6njYUvauamdMyIGRqi3Z41OxkG9JlPzJUx0NriTeoHWuqaMEo3l+9h8t2a
         VYkat48qctNxV1/ppcRnfQARZuWAzrRCUbykSbsoBMp8966TwG20r91mIMZZWqpjcTmW
         hdpH7DDiGoYlRwkaTlsQfcolxJPdgdCgC9/4W8c/dT4apJrOeLX3lj0oWu+YQP0DxUAd
         osWDaPCIsD5h/hDouYKm/GWbJh0+G1rOXddszwPTKiRotQWqfvXUbSh9a+2twyPuDXpa
         FZNLCmQA2AiifhKNd54UF2voysI7AeqYSwKdAxxqSAv3Uf/qcrBy28RD1vznPZVN3aBc
         SnyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687467490; x=1690059490;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z9Q71kHk0zB6vt5ahL9ZHs7069+SCA/PofhBzVdlAuY=;
        b=as8uTSwqCGqlIFvoW3+Aaou+2WcIkgMc0mIjMkIcaZvoRiHnCmFfqKnoKSZAtI4oE6
         X95aLiJ5Hkr/aPDYFSEAUq9zMJI46cUeUJd6pPIlDXZtEnGQy9W8sOxoka2jReiMa2iO
         uPIEpVJOXPQlkS49u3aUAuvdhcLjZKecf28p7l7MKmvNxxQpih8u35PFAQ41GqRjgx/B
         Xi3LM0Yjy/PUqDtUI5mMTbH1Ce/w7ZD4FoZahOPRkz03kyrKl226Wpk7fBooG7mHZZ4G
         UbC0MYllbAR//3clI+fIfJcNOwe2RiPi0h39wF8O+0e6dikE5Buf+Qit9O/rz3Y9iN7k
         GA4g==
X-Gm-Message-State: AC+VfDzdtLcnFJ2WHgcy2zQcKI6oOExXdY3t2RA9zIs9u4H2cvixVqP4
	MRowWNtcgwv3dp9cMK4yiX8=
X-Google-Smtp-Source: ACHHUZ6BwDtDcu2DafE0mELxOK/IzeJcBBP6EuYjmA8bqRWBwzcd6lelREQA4aNwT3EjfCEygFsIlw==
X-Received: by 2002:a25:2144:0:b0:bce:5e08:c330 with SMTP id h65-20020a252144000000b00bce5e08c330mr18770867ybh.29.1687467490539;
        Thu, 22 Jun 2023 13:58:10 -0700 (PDT)
Received: from unknowna0e70b2ca394.attlocal.net ([2600:1700:2f7d:1800::36])
        by smtp.googlemail.com with ESMTPSA id d18-20020a5b0c52000000b00bc501a1b062sm1684937ybr.42.2023.06.22.13.58.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jun 2023 13:58:10 -0700 (PDT)
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
Subject: [PATCH v5 07/33] mm: Convert ptlock_ptr() to use ptdescs
Date: Thu, 22 Jun 2023 13:57:19 -0700
Message-Id: <20230622205745.79707-8-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230622205745.79707-1-vishal.moola@gmail.com>
References: <20230622205745.79707-1-vishal.moola@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230622_135811_914401_4960D556 
X-CRM114-Status: GOOD (  11.39  )
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
 arch/x86/xen/mmu_pv.c |  2 +-
 include/linux/mm.h    | 14 +++++++-------
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/x86/xen/mmu_pv.c b/arch/x86/xen/mmu_pv.c
index e0a975165de7..8796ec310483 100644
--- a/arch/x86/xen/mmu_pv.c
+++ b/arch/x86/xen/mmu_pv.c
@@ -667,7 +667,7 @@ static spinlock_t *xen_pte_lock(struct page *page, struct mm_struct *mm)
 	spinlock_t *ptl = NULL;
 
 #if USE_SPLIT_PTE_PTLOCKS
-	ptl = ptlock_ptr(page);
+	ptl = ptlock_ptr(page_ptdesc(page));
 	spin_lock_nest_lock(ptl, &mm->page_table_lock);
 #endif
 
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 39b0a4661e44..0b230d5d229a 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2801,9 +2801,9 @@ void __init ptlock_cache_init(void);
 bool ptlock_alloc(struct ptdesc *ptdesc);
 extern void ptlock_free(struct page *page);
 
-static inline spinlock_t *ptlock_ptr(struct page *page)
+static inline spinlock_t *ptlock_ptr(struct ptdesc *ptdesc)
 {
-	return page->ptl;
+	return ptdesc->ptl;
 }
 #else /* ALLOC_SPLIT_PTLOCKS */
 static inline void ptlock_cache_init(void)
@@ -2819,15 +2819,15 @@ static inline void ptlock_free(struct page *page)
 {
 }
 
-static inline spinlock_t *ptlock_ptr(struct page *page)
+static inline spinlock_t *ptlock_ptr(struct ptdesc *ptdesc)
 {
-	return &page->ptl;
+	return &ptdesc->ptl;
 }
 #endif /* ALLOC_SPLIT_PTLOCKS */
 
 static inline spinlock_t *pte_lockptr(struct mm_struct *mm, pmd_t *pmd)
 {
-	return ptlock_ptr(pmd_page(*pmd));
+	return ptlock_ptr(page_ptdesc(pmd_page(*pmd)));
 }
 
 static inline bool ptlock_init(struct page *page)
@@ -2842,7 +2842,7 @@ static inline bool ptlock_init(struct page *page)
 	VM_BUG_ON_PAGE(*(unsigned long *)&page->ptl, page);
 	if (!ptlock_alloc(page_ptdesc(page)))
 		return false;
-	spin_lock_init(ptlock_ptr(page));
+	spin_lock_init(ptlock_ptr(page_ptdesc(page)));
 	return true;
 }
 
@@ -2923,7 +2923,7 @@ static inline struct ptdesc *pmd_ptdesc(pmd_t *pmd)
 
 static inline spinlock_t *pmd_lockptr(struct mm_struct *mm, pmd_t *pmd)
 {
-	return ptlock_ptr(ptdesc_page(pmd_ptdesc(pmd)));
+	return ptlock_ptr(pmd_ptdesc(pmd));
 }
 
 static inline bool pmd_ptlock_init(struct page *page)
-- 
2.40.1


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
