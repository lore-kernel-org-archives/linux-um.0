Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0652C001DD
	for <linux-um@archiver.kernel.org>; Thu, 22 Jun 2023 20:59:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=wT8aaeXmY7dsDrDD+hbp3I+qUSVjamspMzhvDOpYUN8=; b=yb7QB27tPbUS0b
	5yguf6eGRbkn2kGDZdElW0TRV5upG4SPaSYlhQ10621eEe08/iSK2bt8a+YDOPyO9Uw75DrEyVYvz
	SU+8RlDczqsEOvtv86bP9i2evw/AhlonswVQeUp7P8/9+VpA7siH2N1CYAIZHvxJsGVBSMz5rcmic
	enqxL6WFNZNeyg3/dkyoVNjCiPzgHbkmDhVlTrrHEHMyx1cJfTa2eVfsdUsUMOlZnExuWbd7eavpm
	bU//TjLmi7vZoORF49gUTddR06kHtOnNaL3rXuhJUKQX7KwvIITHiW3GPZENdDvbgQCFft5RlMN7e
	VqOt29GvfKSqcAs71cKg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qCROo-001iwS-1D;
	Thu, 22 Jun 2023 20:59:26 +0000
Received: from mail-yw1-x112c.google.com ([2607:f8b0:4864:20::112c])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qCRNe-001hhi-0v;
	Thu, 22 Jun 2023 20:58:15 +0000
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-561b7729a12so16639807b3.1;
        Thu, 22 Jun 2023 13:58:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687467492; x=1690059492;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QwvXTPG+SvX1bm+f7lh9ddV99LBkA8HMSnaL5DvtP/w=;
        b=V7iIPiXuenZc5LxLPVAYTxoBribtdhvsXYi0NcHOJsAsyDJa0lFaEv3HMhCS8nZW6D
         tBGbKDLUXgq6SXB+UHfoUVwA1VP1oc9uyCsQtJaaWpV0A9i7GdGsTkpa9yZ5PdH4EtVM
         Ni1Gr88vaVkgSSmwVNY0eyneVDMvJ4SahI/dxEEDmyh7acczYA1fdB5Q85cg9BE7TeJ5
         v+qGG39VtOAMjNZakRVRxe4b5fNSSUnmW+YdbvmJDes0xjF1gJ/GuHYdLYvgYUIG6iI6
         eUC4zgsXmS8SGsNdBxCv7WeYY6IHbiVQmbpLNYO57IVPmerTWPsJRHKkJEBcDrOn9Fu9
         t5Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687467492; x=1690059492;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QwvXTPG+SvX1bm+f7lh9ddV99LBkA8HMSnaL5DvtP/w=;
        b=D1+vo5IBdva4fub3mhYV/29UQ6sAZVH+PiEl7IXTgZYe2SmMEtgwqquqKxWj1mdlEF
         GyycmvjcnVNpy8Rv2oXOpmeB8XZdjWnOK6Mh34mzKRGtLlfChaIqStLBeXehb0elst8f
         O6AmD4CU63skev8MzrUg8GxJdJndoUokyo77NYGyQFUYy09G+CS67lAcWqQpTBZxd39v
         zXwAJjGNaLf84EM5Wrucj6SUnKKOVFu4SU5tEH70YQ4rXoCwtWTtKtQsi4pHBzyOajhA
         5MvKE36bn/TLUy6RFG3IkkapgL4DSiFkroGba0ji6ptkJoKQvstw/UHhO+XkubKn779H
         PvxQ==
X-Gm-Message-State: AC+VfDwG0URj1qNkzg7AK/RpaOOuO0Vq+TeoqAuNzjNfKqA1H2mlPdcE
	j63MNZLjxD+5loe2V68lBwk=
X-Google-Smtp-Source: ACHHUZ6ppOE9aJqUa6Cvm3ZqXuUeTC6rF3mEFKF1yW3aWJUSdADhBmOmFOGnjJA0vfHR/02sJ+sTQw==
X-Received: by 2002:a25:1406:0:b0:b9d:766d:f72b with SMTP id 6-20020a251406000000b00b9d766df72bmr17309619ybu.31.1687467492519;
        Thu, 22 Jun 2023 13:58:12 -0700 (PDT)
Received: from unknowna0e70b2ca394.attlocal.net ([2600:1700:2f7d:1800::36])
        by smtp.googlemail.com with ESMTPSA id d18-20020a5b0c52000000b00bc501a1b062sm1684937ybr.42.2023.06.22.13.58.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jun 2023 13:58:12 -0700 (PDT)
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
Subject: [PATCH v5 08/33] mm: Convert pmd_ptlock_init() to use ptdescs
Date: Thu, 22 Jun 2023 13:57:20 -0700
Message-Id: <20230622205745.79707-9-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230622205745.79707-1-vishal.moola@gmail.com>
References: <20230622205745.79707-1-vishal.moola@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230622_135814_325202_9C35859A 
X-CRM114-Status: GOOD (  10.24  )
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
index 0b230d5d229a..1c4c6a7b69b3 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2926,12 +2926,12 @@ static inline spinlock_t *pmd_lockptr(struct mm_struct *mm, pmd_t *pmd)
 	return ptlock_ptr(pmd_ptdesc(pmd));
 }
 
-static inline bool pmd_ptlock_init(struct page *page)
+static inline bool pmd_ptlock_init(struct ptdesc *ptdesc)
 {
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
-	page->pmd_huge_pte = NULL;
+	ptdesc->pmd_huge_pte = NULL;
 #endif
-	return ptlock_init(page);
+	return ptlock_init(ptdesc_page(ptdesc));
 }
 
 static inline void pmd_ptlock_free(struct page *page)
@@ -2951,7 +2951,7 @@ static inline spinlock_t *pmd_lockptr(struct mm_struct *mm, pmd_t *pmd)
 	return &mm->page_table_lock;
 }
 
-static inline bool pmd_ptlock_init(struct page *page) { return true; }
+static inline bool pmd_ptlock_init(struct ptdesc *ptdesc) { return true; }
 static inline void pmd_ptlock_free(struct page *page) {}
 
 #define pmd_huge_pte(mm, pmd) ((mm)->pmd_huge_pte)
@@ -2967,7 +2967,7 @@ static inline spinlock_t *pmd_lock(struct mm_struct *mm, pmd_t *pmd)
 
 static inline bool pgtable_pmd_page_ctor(struct page *page)
 {
-	if (!pmd_ptlock_init(page))
+	if (!pmd_ptlock_init(page_ptdesc(page)))
 		return false;
 	__SetPageTable(page);
 	inc_lruvec_page_state(page, NR_PAGETABLE);
-- 
2.40.1


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
