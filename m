Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1407C7EE26
	for <linux-um@archiver.kernel.org>; Mon,  1 May 2023 20:40:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=OKlEr58rZZXB/FSIcsvbzPHHL/59nftRVMoYO/m3mMw=; b=sZtrsFMXPhgWcK
	BgHqP8Zh++2fvypZWWqTBHrYX/X/1ILc+3JGWPCS1H4UdgOPhp6osBemue7d3YnvQ5anoCNhleJM0
	dATquyv2WIx2iKZLHfLn89yUvp8KJjkCSewf9cMdcqvHeBRgsgDKtJRO2po74/QPTFike7mez6vZh
	plybnJb7zIUKqEx002ESlUp8HyK8d8hbLz1+lDKSpRPbLt5Ulo8R+oTM58l7kPWaYSRazeobewCOF
	zKX5LQW7lvXmK0vgO66bxSC71qlRBoukl5dvdyMCgRjnEwcI7er8vh+JtxUNXjFmJZ8sxzLRQh1EN
	ez36bWS1GcCvFJtdc4wg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1ptaK7-00Gu7x-0b;
	Mon, 01 May 2023 20:40:39 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1ptaK1-00Gu2N-1B;
	Mon, 01 May 2023 20:40:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=wHprEtJ9ence/xzqPBz4IJf2z5UW2zl5tMMosQGe/i0=; b=lytTrWzhignE4seWOnMgqjkRxT
	wuRwPjzrCSdGFaAlSjNzF3mrihgfIuyMpXN9yFO7XRD81T2rgRukXclpfJWxeBD+W7/Wwor9QNtk3
	hyfGnLupoqPQHm2halNQr2fRJV0vfScrTTmCxjVU1wTloccA7xF1BBh5+MJBIVuOalAdt6qNeSD5M
	TGNeKXBrH8j0zeHBPivUFwwspdIiJl+5SqmQS1PJ59d+uPnpoiB6oSHGqOK+LQNeHGbYHOC2OXJQr
	OS2YwcoGEkN2sjdP6tcZpox5nFzttuGWi6K+rByK706+X6mkDnYZoE0yEKDC66bPCec1It833r0on
	/3hjeAog==;
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
	by desiato.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1ptZCo-00Ez0f-0a;
	Mon, 01 May 2023 19:29:08 +0000
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1aaff9c93a5so6141015ad.2;
        Mon, 01 May 2023 12:28:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682969328; x=1685561328;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wHprEtJ9ence/xzqPBz4IJf2z5UW2zl5tMMosQGe/i0=;
        b=PY19zV8eUjDo/XMGG1Fc34r7BzCEZH74vj9MdJuOaMu+i1F5EHabpfUbH5/UkV5r7u
         xDPodd9s+AIKUKlEgX8AIGrVTqPfTCCV19VkI5iB53+1hWJANYdEVCUSRnMghYWfpO7M
         cjlz4mTJKg6lVp3kGic5xzqQRsLBSUE+d02rlXiSiKdYRR/2g0lktCdvpXk87E+WP0bW
         PyWsq2WmVkZLx+/D9I3aZnTNSq5u2Ks8EcfSEB3bP53mV0saqVpK3cKwl8Vm7ptPZTKs
         sMCaD1Y/vK3rtRXkw0c64x6M8sUBtgZ+i4WFX1gLvu6Qtr7y6/c6crVIx9ttRb0VBr94
         CwWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682969328; x=1685561328;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wHprEtJ9ence/xzqPBz4IJf2z5UW2zl5tMMosQGe/i0=;
        b=C8hCdzST65wAUADfZU8b8fn1WM8HFboDr1Rj0tMXqbMtKOY9fn9UfemZMrYu2WhF9l
         eaAq1iVjFPl7qr9MCQQr6sayjUDr2sTlgMpsf51GGa9SofCDIJks/prxSivwI9N6avyp
         nPAWo68309jfq06zw8AWYX23LdHMNdZeIdGbA+vYbKox/Tvj+GaStUmESnv/2eTsIu+C
         umTvow+1KVDVdevh9AbJG/XBY8Gvu5jDwRZRi/DKKt6PM04hxlyTYJtTc7Xr2y0uhNex
         K8rVrmPvq0voRpFCYaHNbFgiaBbqVPBDQSjjztvg9tBiyAHKDahjm/F6DEyLRgTU+aI5
         psYQ==
X-Gm-Message-State: AC+VfDyNZpquH+kAAsvqYAxyi5lswB4ZS3r5zJ45jQQGDehrsKGAAGM0
	LBbG/vdux1ieyCnJVnj1jek=
X-Google-Smtp-Source: ACHHUZ7Z//gnFWu5Wh7IVebCi2ECb1TkUFb7V74C+bMLVwpZ6jGbtiv1kPkjLZLQcQGCrs+Dltn26Q==
X-Received: by 2002:a17:902:c745:b0:1a6:6fe3:df91 with SMTP id q5-20020a170902c74500b001a66fe3df91mr11845223plq.50.1682969328214;
        Mon, 01 May 2023 12:28:48 -0700 (PDT)
Received: from fedora.hsd1.ca.comcast.net ([2601:644:937f:7f20::9a2c])
        by smtp.googlemail.com with ESMTPSA id u8-20020a170902bf4800b0019c13d032d8sm18175622pls.253.2023.05.01.12.28.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 May 2023 12:28:47 -0700 (PDT)
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
Subject: [PATCH v2 10/34] mm: Convert ptlock_init() to use ptdescs
Date: Mon,  1 May 2023 12:28:05 -0700
Message-Id: <20230501192829.17086-11-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230501192829.17086-1-vishal.moola@gmail.com>
References: <20230501192829.17086-1-vishal.moola@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230501_202905_910234_2201356E 
X-CRM114-Status: GOOD (  10.20  )
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
index 044c9f874b47..bbd44f43e375 100644
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
