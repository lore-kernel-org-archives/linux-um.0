Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1D89C77B76
	for <linux-um@archiver.kernel.org>; Mon, 17 Apr 2023 21:18:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=jKNmsul99IqdFevQ+zg1W6FTHdlu8IsTHBG3K7hAp1U=; b=VqXgrgnTGjrXoZ
	xzar0lVN6vZUB+TE9Em1qyBGZRBuOTR8ZIry19xwGvlGEzXQVZnoflTEzbXavQuhtWzCoAoYW2/27
	EaSHm+BoGvJBS6Dg5ixVoo+Pied/Ognb6cAx7dDqGIe3w1aab1S5tgsWouk37WjtkH9MRgGLKtzs5
	83dQ9bxeWKiNmibTPdj87AuyvwCkLp2bLIP6ILWU9112sR/Bev29i7CSnxcNSpCH9vTgRoOMc4Rdm
	HCpL+h1+yebFaExhpCeSqNQSPnZEuw6IB171L+3hzBxt99ZPMCSLqj5wfn3nQrwDV02FuafTWzPI6
	036V12yejAUhlR1i7UJQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1poWF5-0003CL-0Q;
	Mon, 17 Apr 2023 21:18:31 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1poWE8-0002G2-2V;
	Mon, 17 Apr 2023 21:17:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=7rEN7TkKGGrS4Nr1e9+VSo1FDhdsaSEXyIULzlMdAE4=; b=jmiT6dMwR1o8l3n/2xfLix3Yxq
	ZiUM6OP/NRB9kXBW3RHHUNYR6BdPA8YH703hQ8cn0hJbnt6UknEM4YLrRc7tivPwq3L8W7HlcImaQ
	+vz+uUc/TTz6gejFJj5fhlhJ0CBqdTz/dQzXDYbC6BO4ATz8CQs189YWt2CDg1iLWwvFd54r4ND0C
	wwDkRF3vo/2QS6pYqWIbPv8dPDvcyG5clmp5UQj9Sua7NVFIZSq8+lDXZX/NXSyHNDOOvRDtgb/A4
	vy0eX+2NKOpntrZTUew9v+evhZZqE4/cIHTXRKyz8QfuekUEpEb1OAxi24eINqpPXJ7/+/xju24L6
	6F5bhw/g==;
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
	by casper.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1poVqM-00BfmE-KA; Mon, 17 Apr 2023 20:53:00 +0000
Received: by mail-pj1-x1030.google.com with SMTP id hg14-20020a17090b300e00b002471efa7a8fso14355454pjb.0;
        Mon, 17 Apr 2023 13:52:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681764775; x=1684356775;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7rEN7TkKGGrS4Nr1e9+VSo1FDhdsaSEXyIULzlMdAE4=;
        b=EY4pAo5dPiMdURcOVQM/Apa82VCO0I/XR1aYYt5qSz76HGumyOhUfKwA9+Mr5OFHh6
         y4qX3lmzBRH5sE5hiL3G5H7+P1vU90VNiEuutpY92Aii8KdV81S7nJ0QBzccPQA4L2A1
         H0r+gFj2e0wYN/AG4aVILv2cjCWqAiomeMPXPkWjszJF01iQ5TmXH8Bsz45QUOgwxoQ4
         sHC8DrgU25+a1fsqdhglJSyR11j/cBOYD1x2MxJDA6rfBM+Ci8Y+wWCZicg642iTcaFB
         y1U70avkZLTukuwNbayq0JR0dDmctnOUY0ghxZuZ1egx4BqGjtzmW9DXZrJYTWGZ5wwv
         sRpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681764775; x=1684356775;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7rEN7TkKGGrS4Nr1e9+VSo1FDhdsaSEXyIULzlMdAE4=;
        b=GRBAU7WWT0x8XW33H8dXzZGE0NYiTY2JHVBxOK1QG7/w22vlB0K5O+TRzLX5g+ZgSM
         CPEd+Su8EvoAcacqpnNT10I18hhDXfd5H4z/RbwDJDBM8m3pSoJ8Xm4lj3Vo+MoaEPdz
         tBuaZ8O+A9WUHF21CA9g4BkxMfawqSIcPvHYW0q1R5tZy0Fn2/N6AxbGHNq+BMNK5PMO
         dkxc34zF7kuIKs/YAgQoJCc35j3u/2tntt7PX814lMqpyOKWmhSsgfzOfRc09Urhq2/T
         HVvv2Ixfy8AfbmF2dR3VHZvDAH0PkXv4u/ntt1XbA+legZlbUTTXphZs5Jm92nVxAeF/
         RAhw==
X-Gm-Message-State: AAQBX9cPY/Lysc8o/vL4g/C1vcyaEhg7KSMFCN4FQuqhHVUi+KzdSKQ6
	dj3pD0FoVOBwNXZXwmIMJdA=
X-Google-Smtp-Source: AKy350Yghynh+/JYw1Y4OeSQkY97RuGOXV9v1JZPlpoHn0H6WhBdjqt/CneUg+QzYmLvk18Z1w5zNw==
X-Received: by 2002:a05:6a20:394f:b0:ef:b02a:b35b with SMTP id r15-20020a056a20394f00b000efb02ab35bmr6833020pzg.0.1681764775054;
        Mon, 17 Apr 2023 13:52:55 -0700 (PDT)
Received: from fedora.hsd1.ca.comcast.net ([2601:644:937f:7f20::c139])
        by smtp.googlemail.com with ESMTPSA id h7-20020a17090ac38700b0022335f1dae2sm7609707pjt.22.2023.04.17.13.52.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Apr 2023 13:52:54 -0700 (PDT)
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
Subject: [PATCH 07/33] mm: Convert ptlock_ptr() to use ptdescs
Date: Mon, 17 Apr 2023 13:50:22 -0700
Message-Id: <20230417205048.15870-8-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230417205048.15870-1-vishal.moola@gmail.com>
References: <20230417205048.15870-1-vishal.moola@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230417_215258_786290_F59A0405 
X-CRM114-Status: GOOD (  11.18  )
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
 arch/x86/xen/mmu_pv.c |  2 +-
 include/linux/mm.h    | 14 +++++++-------
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/x86/xen/mmu_pv.c b/arch/x86/xen/mmu_pv.c
index fdc91deece7e..a1c9f8dcbb5a 100644
--- a/arch/x86/xen/mmu_pv.c
+++ b/arch/x86/xen/mmu_pv.c
@@ -651,7 +651,7 @@ static spinlock_t *xen_pte_lock(struct page *page, struct mm_struct *mm)
 	spinlock_t *ptl = NULL;
 
 #if USE_SPLIT_PTE_PTLOCKS
-	ptl = ptlock_ptr(page);
+	ptl = ptlock_ptr(page_ptdesc(page));
 	spin_lock_nest_lock(ptl, &mm->page_table_lock);
 #endif
 
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 17dc6e37ea03..ed8dd0464841 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2789,9 +2789,9 @@ void __init ptlock_cache_init(void);
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
@@ -2807,15 +2807,15 @@ static inline void ptlock_free(struct page *page)
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
@@ -2830,7 +2830,7 @@ static inline bool ptlock_init(struct page *page)
 	VM_BUG_ON_PAGE(*(unsigned long *)&page->ptl, page);
 	if (!ptlock_alloc(page_ptdesc(page)))
 		return false;
-	spin_lock_init(ptlock_ptr(page));
+	spin_lock_init(ptlock_ptr(page_ptdesc(page)));
 	return true;
 }
 
@@ -2900,7 +2900,7 @@ static inline struct ptdesc *pmd_ptdesc(pmd_t *pmd)
 
 static inline spinlock_t *pmd_lockptr(struct mm_struct *mm, pmd_t *pmd)
 {
-	return ptlock_ptr(ptdesc_page(pmd_ptdesc(pmd)));
+	return ptlock_ptr(pmd_ptdesc(pmd));
 }
 
 static inline bool pmd_ptlock_init(struct page *page)
-- 
2.39.2


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
