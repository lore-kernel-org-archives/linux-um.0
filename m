Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2475AC77B72
	for <linux-um@archiver.kernel.org>; Mon, 17 Apr 2023 21:17:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=imEUL/EZNDmwPYxQGbI81+4h8t7nLqbV9OJ/YoJt0JM=; b=Oy5U/njUYB7TWo
	2ZqnQIlkJqARWiMAhwzsRNkAphGqxUaBEAONiCxjNffAL7ALel+UBouG4I9Vqn83CH028CqigSoSj
	ZCdxfWcN108gcJ11qlrF6Dl47mjTcVL5b9KB/e+1K1ggOePKLRb8iSdns23A30ACFVAqHwDmfzyrs
	ZoDSSF57BXIKX8TiS91l+mEljhhqjhhsfC/sR9SmQ3gfxRNBonBQJ2MsPc7O1H7pEL1P8SAeoJnCV
	kdZGknFylagJ5+4bHzqpdhBBWc2WyQf6xJ628QQlHTKCHVFlI3vPFdov0eqmOZh/c0wvpzOfVu3u7
	y3QCKa2rLO8Ev7TbS17A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1poWES-0002eF-1e;
	Mon, 17 Apr 2023 21:17:52 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1poWE6-0002G2-1z;
	Mon, 17 Apr 2023 21:17:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=X3zVXX/N6SOzga9RDJq+tPAqPrrx50X9RMNZ27hRgPo=; b=a4IpSkhhsu6QAIOt8unOTJnzlg
	3O5eB5GNENdJ8odIR5vvq8Vl26bpK/NMh80eYPmUmCTFgr1be1UGcx76wTFxCGiZS2wIqeITjXSM7
	CAreDMeLtLQE2/AWoNQmTDqtNPMQXrBoZOjPR3pIeMh1zs9iXGkeLVMkPmbGxl/logpJbJ3C4L97l
	S9+tKOVQwUKyPlv8hyU6RXEcW+gdjgIzLiOS0/uy0dhJRB6VuZbyjALRtJ4jC1SBzp35EBvYBNzbK
	Nsro2g8Lbr3nUPeV/rBq5N8bNTZonw/gCUBqRqGoC5oodJ4rEyGXtaTnK/gVZgehbTAymmZW2d2G6
	8ZFqxovA==;
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
	by casper.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1poVqR-00Bfo5-Px; Mon, 17 Apr 2023 20:53:06 +0000
Received: by mail-pl1-x62c.google.com with SMTP id kh6so25752740plb.0;
        Mon, 17 Apr 2023 13:53:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681764779; x=1684356779;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X3zVXX/N6SOzga9RDJq+tPAqPrrx50X9RMNZ27hRgPo=;
        b=sICUrUNhKpAOA4VRjrqbzI2X/H4tUjO6T2SdOnpuj4Iy+PajhE1DrUSbcJznfffRrX
         L+wg0APu+UnJsiMWo07D8eesoEiJoCPkIf7iFkO3frlAWKtnOneztwNYCGmhOQpiZeuy
         AXohiTFVSZ6j/QYK9dyhVhIaufaLIPexDAAJXmf6qW3dNeCDEUq++V0vxfiKc0g0e7Ab
         Ewxv8L1qYPD4uyzx9cQ6CGY815b+pAM3zpWc0XUF8sLnRhkHRA/O3qjcuWg0cKvRpE4M
         YyoU6OpnuIHEQ4e7n1BxpYaP+3T9kR2hf6Oim0PIubi0gprGsuCOvZCKtVwS9TGYF6kY
         TvEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681764779; x=1684356779;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X3zVXX/N6SOzga9RDJq+tPAqPrrx50X9RMNZ27hRgPo=;
        b=f1wZ/vz3L4kPQlbPxLmU1MH+1/q6H62iIQU+f/qnxFi6lRSJg/6JFgNPbnDVzMve/W
         obxpodVVbrA+bF0qCu0OsS0vQcwHHl7YUeuZVXbaT7IcRumo9iSlfLUzmclyuu+26/wE
         U+I6ap8q0KMmpp4vqZFec+l4V54k2a0CE7JngZErtwwEDwfcbIEl2RqymDba6u92aCKI
         BwfHSf2gyuE+Br4fORfrLHJqnIcESlZTmop00ZT4iOAPCROJUMh1qi5eT4ws1WDbuEQg
         BLWoyswrWHGYzgumISdIjC93KdOIeDkfmMwhIJdVaQjt7vfJKz7gUWaGZWWREnpB4W/K
         syYA==
X-Gm-Message-State: AAQBX9eJOXhnbZBAhbtM0EhKvJRjDoaHxSmY2mzUvU6Z/AnYoP46GKi1
	dibg2ONT9iVOHH9bSq5uzi0=
X-Google-Smtp-Source: AKy350aL1Q/BuQU4b/coHWha7jodau934g5ZfPpWwX1i7O384OcXkkUs5sEaNrPzHDYpgrYCEKrWgg==
X-Received: by 2002:a17:90a:cb8c:b0:233:f393:f6cd with SMTP id a12-20020a17090acb8c00b00233f393f6cdmr15121483pju.5.1681764779380;
        Mon, 17 Apr 2023 13:52:59 -0700 (PDT)
Received: from fedora.hsd1.ca.comcast.net ([2601:644:937f:7f20::c139])
        by smtp.googlemail.com with ESMTPSA id h7-20020a17090ac38700b0022335f1dae2sm7609707pjt.22.2023.04.17.13.52.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Apr 2023 13:52:59 -0700 (PDT)
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
Subject: [PATCH 10/33] mm: Convert pmd_ptlock_free() to use ptdescs
Date: Mon, 17 Apr 2023 13:50:25 -0700
Message-Id: <20230417205048.15870-11-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230417205048.15870-1-vishal.moola@gmail.com>
References: <20230417205048.15870-1-vishal.moola@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230417_215304_061722_8C2899CE 
X-CRM114-Status: UNSURE (   9.37  )
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
---
 include/linux/mm.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index d2485a110936..2390fc2542aa 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2911,12 +2911,12 @@ static inline bool pmd_ptlock_init(struct ptdesc *ptdesc)
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
@@ -2929,7 +2929,7 @@ static inline spinlock_t *pmd_lockptr(struct mm_struct *mm, pmd_t *pmd)
 }
 
 static inline bool pmd_ptlock_init(struct ptdesc *ptdesc) { return true; }
-static inline void pmd_ptlock_free(struct page *page) {}
+static inline void pmd_ptlock_free(struct ptdesc *ptdesc) {}
 
 #define pmd_huge_pte(mm, pmd) ((mm)->pmd_huge_pte)
 
@@ -2953,7 +2953,7 @@ static inline bool pgtable_pmd_page_ctor(struct page *page)
 
 static inline void pgtable_pmd_page_dtor(struct page *page)
 {
-	pmd_ptlock_free(page);
+	pmd_ptlock_free(page_ptdesc(page));
 	__ClearPageTable(page);
 	dec_lruvec_page_state(page, NR_PAGETABLE);
 }
-- 
2.39.2


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
