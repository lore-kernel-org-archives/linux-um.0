Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7811C001DE
	for <linux-um@archiver.kernel.org>; Mon, 31 Jul 2023 17:04:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=LZVkzGOg94JZTRaytyU+mTouXzVQiNdAP0CH4oQ5rW8=; b=YyUonTv4oRyxuO
	xbh2kiVb6UaneqqcGBnJbS466DexCUvmQLPaBQLuSdp1o8dvMHmkK4YACvW1R6nzGvioJMxmd0NkH
	+DBJa85J2U53jnpM1nC1jT015DZiHJ2wPgAsvmcWq31BGNoZEcXv2VDkLyCFCdVNcWPYGLAIXqolp
	vF+ShUUgH9uHoUgAj4fsyC77NcvGJnjsKxRLX/7W7g3bCAdXGG7dNuDSUgfTAo4mCob3UBFrDijW/
	pab5Va5xRcyU5tz5ao3Hi7E1HF7+hB3bjyyNNqcfulqfzVEHlAX68npgaaPhuO5cKFUL3goxGA0aC
	5ey3yMjnbOG71AqKmcKg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qQWKG-00Gl6f-0V;
	Mon, 31 Jul 2023 17:04:56 +0000
Received: from mail-yb1-xb29.google.com ([2607:f8b0:4864:20::b29])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qQWJF-00Gk1y-09;
	Mon, 31 Jul 2023 17:03:54 +0000
Received: by mail-yb1-xb29.google.com with SMTP id 3f1490d57ef6-d35a9d7a5bdso498168276.0;
        Mon, 31 Jul 2023 10:03:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690823030; x=1691427830;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uNVCmnQN0ufsotHop6mLPsVoSXSsgvYy2QMaIqEOqi4=;
        b=HGhOeQ1TmAKeV2HnCN1WTfuLUUGtIM4rPFVA9FLFfXc9y1teMeCMXYfLrn52VreEZa
         +8fuD8Eo9GHKIiGXji1nVJr6hJp1UgozAoPycNtpjPeWKRtcHWia112SYBPlfjErevM1
         f1KBsm+b9biDP/8hsnmQLIxx1WqbIsap7/B5vxAAg5UayZGm1/xCMe4ANNoVXkXqO5f9
         zYPLJX2R/yJdpXd33yeHG335BLgfWD5asDdFJsvc7qa94OZvu247hqr11p/tySJkF1N3
         XZqqjnjnJwS4MTyfAeLK5z9Se8l+uTUdMKVbakuD0ppwzC8LFvwdJ3Q2bHVnQ+Hr6zUD
         fqZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690823030; x=1691427830;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uNVCmnQN0ufsotHop6mLPsVoSXSsgvYy2QMaIqEOqi4=;
        b=kB4bbbr9wIILr2NG5f+u/a9HH4dc1VPeg0ReyWOoJ94Mqf5H+cwDouFcb5HAtxSN4U
         BbzuKIXBvzbJ/tA9z9p/WIUI5yGAIvx1NmxyhGkL4QQMlIDYN5UqlRoXtg+pyXs2SaHs
         s7Xoyt0eE02g7EtYomNzsDVjaGwy7xGfRai3UJMotA5p9vjZ2HZVi8QB7tq6znTjDeMO
         s6kxYtyYmfT5XIkw87gSAPxT8YCCUigVby+kKii3NY8PuDHbAwDvegPhnLPB6eMt5b0Q
         X3fG8tEO57x7Nb1GjoiY8G6WCHQNXwbInJ2J5vIpXY87AFxKvHCk59sY1Q5MqwXBGFbR
         EY4w==
X-Gm-Message-State: ABy/qLZyFmkKHqSLm4Vj1dHSN7+S2BaiROzAv0RXulARF9SIsMbYadQc
	xBiisbwLvvSfwsDUrGKW3Wc=
X-Google-Smtp-Source: APBJJlEF5eMDgJhVfaLglGwfP9JkFsRVPWZwav0NLe508KhOsIkmqr6LHjKMWH59Isg1gKZnQYYAJw==
X-Received: by 2002:a25:ae5c:0:b0:c73:9f38:2b3a with SMTP id g28-20020a25ae5c000000b00c739f382b3amr9095220ybe.48.1690823029862;
        Mon, 31 Jul 2023 10:03:49 -0700 (PDT)
Received: from unknowna0e70b2ca394.attlocal.net ([2600:1700:2f7d:1800::16])
        by smtp.googlemail.com with ESMTPSA id x31-20020a25ac9f000000b00c832ad2e2eesm2511833ybi.60.2023.07.31.10.03.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jul 2023 10:03:49 -0700 (PDT)
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
Subject: [PATCH mm-unstable v8 06/31] mm: Convert ptlock_ptr() to use ptdescs
Date: Mon, 31 Jul 2023 10:03:07 -0700
Message-Id: <20230731170332.69404-7-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230731170332.69404-1-vishal.moola@gmail.com>
References: <20230731170332.69404-1-vishal.moola@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230731_100353_095409_34451266 
X-CRM114-Status: GOOD (  12.05  )
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
index b3fce0bfe201..c155f82dd2cc 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2844,9 +2844,9 @@ void __init ptlock_cache_init(void);
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
@@ -2862,15 +2862,15 @@ static inline void ptlock_free(struct page *page)
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
@@ -2885,7 +2885,7 @@ static inline bool ptlock_init(struct page *page)
 	VM_BUG_ON_PAGE(*(unsigned long *)&page->ptl, page);
 	if (!ptlock_alloc(page_ptdesc(page)))
 		return false;
-	spin_lock_init(ptlock_ptr(page));
+	spin_lock_init(ptlock_ptr(page_ptdesc(page)));
 	return true;
 }
 
@@ -2971,7 +2971,7 @@ static inline struct ptdesc *pmd_ptdesc(pmd_t *pmd)
 
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
