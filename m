Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 532F5C0729B
	for <linux-um@archiver.kernel.org>; Tue, 25 Jul 2023 04:22:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=uVxtv7frebX8aJtbL45Gba0tgyK4ftPkkJGSpebL1/w=; b=NmWRwPDeLFcfUn
	KZVGHm3M5o/+VRGafFTAp2HQPTNwXM37TiTdbcID5NNw9+b7EOAQFGqfeKKXPgyAuo7eaRHUqfChz
	SewHG0fuYApbC1CRyxGhYnLEGcXYRkfvFyDj/GfGSRET+BEdD3rc4SYbE7CeCD7iTS8qA1QR6EjCp
	D+obS3pHMgOheh1wl67UvvPDRtJeFjKqQ5kdbGoRflHson0UOmv28eO5bgnHJkFCQK5a1KJxsu/jb
	iIe3o8yUbFbaMwfUuMyNc8u0UhSBZ9xv5/q39742NjEOB72R29f7GMfR/GFKaAFsv4N6uh8aCIoYW
	JCGitY6eqmMh0uf6He9Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qO9Yh-0067os-2Y;
	Tue, 25 Jul 2023 04:22:03 +0000
Received: from mail-yb1-xb29.google.com ([2607:f8b0:4864:20::b29])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qO9Xy-00674c-01;
	Tue, 25 Jul 2023 04:21:19 +0000
Received: by mail-yb1-xb29.google.com with SMTP id 3f1490d57ef6-c5cf26e9669so4296608276.0;
        Mon, 24 Jul 2023 21:21:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690258877; x=1690863677;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hLtCJBysrabsGyMeKlbK2lKTjEzHhmjaMpElw0hOQuQ=;
        b=gPFq/JoYwJjLf9rVCoB8Lw8LOssqafkFQKm1MRAos7/YFfmCVQ5zZtnC0rhhBdQCXk
         N7cP2rb2Gc3I1sIFDEA6WDVqpFvuzV9g0ksMwxcFOLrW1SrVCbGbF2JEMKH7iGrlo6kh
         szCDqr3K9qHITaCMG+6I4Bv2DGuidVlNjZotb70C80Hqf3ER0SLHbbdax/uMFjYuJbcP
         w5E647QIdwTWza0fMIXSMCOI01eppzdj1zv2JddPFf9pPmBUxHnIhf/jhE5I9HeeHTOn
         pGU0qrcAaECYa9O8B/YJzvoVn8SSXjyAEPRTA5PEQfVza6O4EJzAJ9koweASwJRx6Tml
         xocw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690258877; x=1690863677;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hLtCJBysrabsGyMeKlbK2lKTjEzHhmjaMpElw0hOQuQ=;
        b=gTzCw55/kDSIAPE/0EjU6VCq89T8+SHqoO+RN5NfLOYQMQaXqH7WstqKLo+TXho1jh
         owDoYJkqjvzXsJ0bphozwme/wlVzz8pg/n769xXxCWAolBrLB5Na46dDtsin5bW1q03h
         2i/csBBa4FFO4HuHqvQQpo3XNFGkK2T3QhTCydNytz3nFmVSeuyFbQrcf9w09I9VeSLs
         +2rsRuJMuFJCCyi/iGGxCv38MfLPqxjBauZVAPiEBlfgMJKHEmONkHxBTKXeXwZW3IHf
         /uiGfSqVduIQQkk9h+vJatLmnjTqUuQdcFO29/Myghv+V95yW7fcHhgMpNqrYp8DqCVA
         l1pg==
X-Gm-Message-State: ABy/qLaHXY1ccaetU5uX8R/5voIwphCqtcGdzaw9bhV+Cb2wx+B3ias7
	HERw0ezIK7DsNBNKhAB7MtI=
X-Google-Smtp-Source: APBJJlHyqmJ7X8HSspT6LddsJqdqN9Il/WFvcTF4BUwycttfbECYy8j8wA/EIsdExukzdWEa0jT4RQ==
X-Received: by 2002:a25:4cca:0:b0:d01:52da:9625 with SMTP id z193-20020a254cca000000b00d0152da9625mr7877273yba.13.1690258877265;
        Mon, 24 Jul 2023 21:21:17 -0700 (PDT)
Received: from unknowna0e70b2ca394.attlocal.net ([2600:1700:2f7d:1800::16])
        by smtp.googlemail.com with ESMTPSA id h9-20020a25b189000000b00d0db687ef48sm1175540ybj.61.2023.07.24.21.21.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jul 2023 21:21:16 -0700 (PDT)
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
Subject: [PATCH mm-unstable v7 05/31] mm: Convert ptlock_alloc() to use ptdescs
Date: Mon, 24 Jul 2023 21:20:25 -0700
Message-Id: <20230725042051.36691-6-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230725042051.36691-1-vishal.moola@gmail.com>
References: <20230725042051.36691-1-vishal.moola@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230724_212118_045510_D4DB676E 
X-CRM114-Status: GOOD (  11.87  )
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
 include/linux/mm.h | 6 +++---
 mm/memory.c        | 4 ++--
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index bf552a106e4a..b3fce0bfe201 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2841,7 +2841,7 @@ static inline void pagetable_free(struct ptdesc *pt)
 #if USE_SPLIT_PTE_PTLOCKS
 #if ALLOC_SPLIT_PTLOCKS
 void __init ptlock_cache_init(void);
-extern bool ptlock_alloc(struct page *page);
+bool ptlock_alloc(struct ptdesc *ptdesc);
 extern void ptlock_free(struct page *page);
 
 static inline spinlock_t *ptlock_ptr(struct page *page)
@@ -2853,7 +2853,7 @@ static inline void ptlock_cache_init(void)
 {
 }
 
-static inline bool ptlock_alloc(struct page *page)
+static inline bool ptlock_alloc(struct ptdesc *ptdesc)
 {
 	return true;
 }
@@ -2883,7 +2883,7 @@ static inline bool ptlock_init(struct page *page)
 	 * slab code uses page->slab_cache, which share storage with page->ptl.
 	 */
 	VM_BUG_ON_PAGE(*(unsigned long *)&page->ptl, page);
-	if (!ptlock_alloc(page))
+	if (!ptlock_alloc(page_ptdesc(page)))
 		return false;
 	spin_lock_init(ptlock_ptr(page));
 	return true;
diff --git a/mm/memory.c b/mm/memory.c
index 2130bad76eb1..4fee273595e2 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -6231,14 +6231,14 @@ void __init ptlock_cache_init(void)
 			SLAB_PANIC, NULL);
 }
 
-bool ptlock_alloc(struct page *page)
+bool ptlock_alloc(struct ptdesc *ptdesc)
 {
 	spinlock_t *ptl;
 
 	ptl = kmem_cache_alloc(page_ptl_cachep, GFP_KERNEL);
 	if (!ptl)
 		return false;
-	page->ptl = ptl;
+	ptdesc->ptl = ptl;
 	return true;
 }
 
-- 
2.40.1


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
