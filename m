Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A6C4C77B7A
	for <linux-um@archiver.kernel.org>; Mon, 17 Apr 2023 21:18:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=aANuheP4quNdn1PCOJdWz95WEpE3xR/AEG2iMi/ls6E=; b=mzQ2GO9E+llaCt
	V2UqvT24TPTZR2ZjwmrhmjHS4hRQkf94I8So8Ns0nrpAcvrVgvglpaWW9gUl6ASGYkMV/ElOTSos2
	nB8Y29fsSi7rm8cIVn0UEcVpDBkLr5Vygs5kvGCbSTJhaMf5AEv1872yWuyoGV1/LslUMs219HO9F
	kKBHIvOxburVgsOhbEeJHmogUBIsf7rMhQceh/0UmbuBEiRJlLO7QYwjRJnOi8Jiw+cuhVDh5fcvU
	KwVbXu8HjCMpLxC/ThV/vdG7TJbSs8035owTbs+f/CMaYyPNQ1awRVrh5nr5qAD5FvAgq2zVcfx47
	80vpYvpn5XfQVUCtpc9Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1poWEp-0002z9-0L;
	Mon, 17 Apr 2023 21:18:15 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1poWE8-0002G2-1L;
	Mon, 17 Apr 2023 21:17:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=I0S9vHWOxLue2VyFd3w8q0WLRZoA25NyvyllT+RcawU=; b=MJcSFGFI4R+qD5xS1ylym6xwAn
	88Qc2pJP4MwV0AQ/7MrHJ9DDEq/t+oiTpGduv7VIK5hrpMVcDXudE6RTfNh2eltdZPvrzJt9rxVz1
	F4gXWcFkxW7uvY9HzfERofhhHl6HgNcqPdgcG/B0Jphn4lCTzR4NHMvP7fNN6z/T/qQKgtnrWeEZb
	AqFNkO20tWeRplWbtMH2uoKeaftH2qwX6dtvMF9V0p9EA6L/KCwclc0QbBHQYMw7a3bPlOkoSUZSa
	EWVMC5/zqHspC4jUIe/C562FdpeL6DnCwjqkkV8g52TfZRlINqL8qCAtkIwkgZGVz4TlEN+0QQWNE
	zjcXscpg==;
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
	by casper.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1poVqO-00Bfn0-DS; Mon, 17 Apr 2023 20:53:02 +0000
Received: by mail-pj1-x1029.google.com with SMTP id k65-20020a17090a3ec700b00247131783f7so280586pjc.0;
        Mon, 17 Apr 2023 13:52:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681764776; x=1684356776;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I0S9vHWOxLue2VyFd3w8q0WLRZoA25NyvyllT+RcawU=;
        b=XGW0pwJ3AeguS3BSEjZkQda83npB8B7RbJEymTCypauBOGiv3vWjnUTzzYfl8eoJ/G
         l8vpSac3iXyBMdZp/fMD6sum0gW4MOCVqLS502CXgyi0RUYYf3ntgvAGSXGBolZoNn2i
         V+ToiFcIdhtDlP2wctGltXpdu2C91rdsIF1S9oPOQ0O7Jf0vF/Q8QloTMvDXpKn4JpZo
         XwyusDwNIWazvsnj/elh4vmpM936WP8JEzePXhLQ+OdbmLb8t8oYaUiKKrqV8mjQTuNV
         U8/37jTeHtYYWs9KLzMjZZ9An2VnMVkd7CaDSgdHdeupgwKBIBRRGFzwxZa8/Q4lnujL
         ZhVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681764776; x=1684356776;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I0S9vHWOxLue2VyFd3w8q0WLRZoA25NyvyllT+RcawU=;
        b=kptZGuoe+8+4OpQbyMxIbHdK7SRSsA1338bPhcFBForjFQM6sQwrW92PlPPTswsI2o
         clsDpXqWFMbJXBx89PRkMSAn9dbylSB2+n47T1gAYTzOBBJjEUyhF4jFZblU7POjCsDI
         t8/DoAsyrIxmIA2dfgo3JJS/lh3Y2tpjLjhsAvfO6GSZnsjsxtefbxHTWdQixfbsJnpd
         in+h2bDryXKFGV+BOSCkKnF/bLgKo5xXonlyIHg9uO/XevbRr5P6dPRlCQ82SzTszJhs
         uGVnh6gEzfJOdndUR+O2H8MZPt2Q6R0qmqzAx7TZ/NEIMKkomXJ+XE8iIM7UwgSO5dJ9
         Bf8Q==
X-Gm-Message-State: AAQBX9euNG3BCkAQaF962I+9W+kjccQdKEJnggF5xSrMLay58pO8dXpy
	cBHWHJ7QKULlV2HADd78DUI=
X-Google-Smtp-Source: AKy350ZxT8mmBCzqXXqE8vhbMJvpIdAkvQhshhpl/b9NVru4kEOX264b08aZJzrt7Emcu03WoO14SQ==
X-Received: by 2002:a17:90a:3fc8:b0:23d:15d8:1bc3 with SMTP id u8-20020a17090a3fc800b0023d15d81bc3mr16271900pjm.39.1681764776607;
        Mon, 17 Apr 2023 13:52:56 -0700 (PDT)
Received: from fedora.hsd1.ca.comcast.net ([2601:644:937f:7f20::c139])
        by smtp.googlemail.com with ESMTPSA id h7-20020a17090ac38700b0022335f1dae2sm7609707pjt.22.2023.04.17.13.52.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Apr 2023 13:52:56 -0700 (PDT)
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
Subject: [PATCH 08/33] mm: Convert pmd_ptlock_init() to use ptdescs
Date: Mon, 17 Apr 2023 13:50:23 -0700
Message-Id: <20230417205048.15870-9-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230417205048.15870-1-vishal.moola@gmail.com>
References: <20230417205048.15870-1-vishal.moola@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230417_215300_478407_CD9E90B2 
X-CRM114-Status: GOOD (  10.66  )
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
index ed8dd0464841..7eb562909b2c 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2903,12 +2903,12 @@ static inline spinlock_t *pmd_lockptr(struct mm_struct *mm, pmd_t *pmd)
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
@@ -2928,7 +2928,7 @@ static inline spinlock_t *pmd_lockptr(struct mm_struct *mm, pmd_t *pmd)
 	return &mm->page_table_lock;
 }
 
-static inline bool pmd_ptlock_init(struct page *page) { return true; }
+static inline bool pmd_ptlock_init(struct ptdesc *ptdesc) { return true; }
 static inline void pmd_ptlock_free(struct page *page) {}
 
 #define pmd_huge_pte(mm, pmd) ((mm)->pmd_huge_pte)
@@ -2944,7 +2944,7 @@ static inline spinlock_t *pmd_lock(struct mm_struct *mm, pmd_t *pmd)
 
 static inline bool pgtable_pmd_page_ctor(struct page *page)
 {
-	if (!pmd_ptlock_init(page))
+	if (!pmd_ptlock_init(page_ptdesc(page)))
 		return false;
 	__SetPageTable(page);
 	inc_lruvec_page_state(page, NR_PAGETABLE);
-- 
2.39.2


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
