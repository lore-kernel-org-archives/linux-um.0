Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA590C04E69
	for <linux-um@archiver.kernel.org>; Mon, 31 Jul 2023 17:05:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=DypMrFk8jnGC+/E4Rk9l8G48RdtvUUjK2qGCofr1GKs=; b=XEWfUDnZYGiPCn
	Qd+SmBgd6Syigut2BHBx60YnMka7FaHaMURfyK5qEVpP23zkaBaCujzNPaWaFiCer3JEiNN8lzdku
	bcZbfqN3TWlh/T3ulyw/sBUXRMGHglKZKHV3c2UnA1tg9fo52KXbVGzxWrkRjamPDQMbTU2QCf7tM
	bdA5F8/sBBSKyiqXZVTbUnB1WbV/y7MEDJRynlfGBZAD1tLdLCq2ZmgGbgD2iCENccYieYA5FT1lw
	5+K1YvvRHaivnEuAVTquSHBd6r1nlRlOpxbz2i01n49rYBCIQGyZmlz6f+iMeKyFbwHZ0arbioF/B
	gyL66s3wGslpVD0mS27g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qQWL3-00Glf3-08;
	Mon, 31 Jul 2023 17:05:45 +0000
Received: from mail-il1-x133.google.com ([2607:f8b0:4864:20::133])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qQWJL-00Gk7F-1y;
	Mon, 31 Jul 2023 17:04:01 +0000
Received: by mail-il1-x133.google.com with SMTP id e9e14a558f8ab-34928e9f24bso2448345ab.0;
        Mon, 31 Jul 2023 10:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690823036; x=1691427836;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iZ7ozcISUSGoixC5UzzNE5tJz0+L18C1Imj6XmV/DYM=;
        b=YpVyYPxPRtPTKHT9+tyvzqfvzCuhkFnhsMCX6nJF7RWviYaDE6pxTcvqFICRytHQ3F
         mk3OEWmycmo6ouKKcTZJZ/J9GI0O0U+IOIhkq6cf5NcWzs3F3Ep7I9wPm/bnxo3IbGbP
         5A5D1El9yg833uJSmp138hZ30DYMCVkIUWUYXAVHfkbTx4hT6PxevukL8QnCpSiv14Rw
         Ab1JsXOoVAvxWjOf0Fsk8pxufrrxg62ZUs/sWVYn8yXcxdG4Ij3aN3bFcjr1GQQkDcpq
         XCDoC5WGNDUaZUPNMTX8kXKJ799hVc0z6s0hq6YfOkQjqMhJ1aFCFD+uKI8XA047G16z
         xszQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690823036; x=1691427836;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iZ7ozcISUSGoixC5UzzNE5tJz0+L18C1Imj6XmV/DYM=;
        b=hP0WLrepZI44AwRcpPPPooyoytgvs43WlAdB+QtXiUpWHG0LCzyO5h4Dr5HBtzbBAW
         LT0VW0lhHVPkTGvF8rnyty3Nvd8pBPBDdLJGpA0R+JI4HKtMl8wttECOmK+C8uBgHmjS
         M0ZfLsLjTl8+gafKU3YFiQSVdZDrZWeQnLU3SN4vF3eARR3QTUgbI+ZXD7T5sCQZMY/N
         xKmK0jRkI1WHAyDSBp6saLct51dPbv82HniUe+311il9m6VfexdchjvL7sBcT+hWntjz
         pljtbHGgnaQfx6uuhxEOhoDnZJgRHF/rW76m5M7ca0J23qNGk+THLGNXKJtRlWtuMBmF
         DNAQ==
X-Gm-Message-State: ABy/qLYcMIrMXvc5GQBKncjiTU7yWwY7N/sraxbEErQ6ko9hlGLcRDPc
	FTRc+oUqvfdc03K6yEAf160=
X-Google-Smtp-Source: APBJJlHoVkOsri9H/NdsUsto2q+Ey0kzzV9aD886+MBagBeourqVjWpbCtZ0aJitRhXpadhn4PaeZQ==
X-Received: by 2002:a05:6e02:1c26:b0:348:b910:313d with SMTP id m6-20020a056e021c2600b00348b910313dmr9675086ilh.14.1690823035707;
        Mon, 31 Jul 2023 10:03:55 -0700 (PDT)
Received: from unknowna0e70b2ca394.attlocal.net ([2600:1700:2f7d:1800::16])
        by smtp.googlemail.com with ESMTPSA id x31-20020a25ac9f000000b00c832ad2e2eesm2511833ybi.60.2023.07.31.10.03.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jul 2023 10:03:55 -0700 (PDT)
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
Subject: [PATCH mm-unstable v8 09/31] mm: Convert pmd_ptlock_free() to use ptdescs
Date: Mon, 31 Jul 2023 10:03:10 -0700
Message-Id: <20230731170332.69404-10-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230731170332.69404-1-vishal.moola@gmail.com>
References: <20230731170332.69404-1-vishal.moola@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230731_100359_651192_633E4216 
X-CRM114-Status: GOOD (  10.25  )
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
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 675972d3f7e4..774fe83c0c16 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2982,12 +2982,12 @@ static inline bool pmd_ptlock_init(struct ptdesc *ptdesc)
 	return ptlock_init(ptdesc);
 }
 
-static inline void pmd_ptlock_free(struct page *page)
+static inline void pmd_ptlock_free(struct ptdesc *ptdesc)
 {
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
-	VM_BUG_ON_PAGE(page->pmd_huge_pte, page);
+	VM_BUG_ON_PAGE(ptdesc->pmd_huge_pte, ptdesc_page(ptdesc));
 #endif
-	ptlock_free(page);
+	ptlock_free(ptdesc_page(ptdesc));
 }
 
 #define pmd_huge_pte(mm, pmd) (pmd_ptdesc(pmd)->pmd_huge_pte)
@@ -3000,7 +3000,7 @@ static inline spinlock_t *pmd_lockptr(struct mm_struct *mm, pmd_t *pmd)
 }
 
 static inline bool pmd_ptlock_init(struct ptdesc *ptdesc) { return true; }
-static inline void pmd_ptlock_free(struct page *page) {}
+static inline void pmd_ptlock_free(struct ptdesc *ptdesc) {}
 
 #define pmd_huge_pte(mm, pmd) ((mm)->pmd_huge_pte)
 
@@ -3024,7 +3024,7 @@ static inline bool pgtable_pmd_page_ctor(struct page *page)
 
 static inline void pgtable_pmd_page_dtor(struct page *page)
 {
-	pmd_ptlock_free(page);
+	pmd_ptlock_free(page_ptdesc(page));
 	__ClearPageTable(page);
 	dec_lruvec_page_state(page, NR_PAGETABLE);
 }
-- 
2.40.1


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
