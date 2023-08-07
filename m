Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A8B6C001DF
	for <linux-um@archiver.kernel.org>; Mon,  7 Aug 2023 23:06:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Eo5L6XcPB8BYf7YSlCCMbEg4KDoAS1t/LFCqqWLnWZA=; b=04EgZs7imYT7vN
	bvxoMtC7bBEDwX46BE/lYlITcyU/i2jTwjieEZPU8dUMVBWrQjlXwAhdB9OBA212q27nA1UWDgtvn
	fXjsRekiSj6TSAibRn/9jvKuKXXAunHyOYOMoheo02pykCKQSbCXH137cMnbq4NnNqWkIaWDNm2Tb
	GCQ400QB/JMLY3M7B0W9yCALPYkzIBCdT/WkYYKjMRzQRG75pV5f8hwcQsUXsEK9nRYwPhRHfS0RL
	i/qOjzBPb0OI070xJ2A+xEfbMhVwXPUJL7aZndykjlSKMey8r9VUle4NQ7ZLY/MUWY6A+7QixhRzO
	UhhjVkg7X/rz6Oz8eSUg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qT9IU-00150s-2i;
	Mon, 07 Aug 2023 23:05:58 +0000
Received: from mail-yb1-xb31.google.com ([2607:f8b0:4864:20::b31])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qT9I5-0014VZ-2Z;
	Mon, 07 Aug 2023 23:05:35 +0000
Received: by mail-yb1-xb31.google.com with SMTP id 3f1490d57ef6-d16639e16e6so4157213276.3;
        Mon, 07 Aug 2023 16:05:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691449530; x=1692054330;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nhRFpHY9Gkw1pvDSPH6l3PWFnY0Equ+A7zpvUAn8VQI=;
        b=i3yG/elNSvAKIQpu+LnaQkf9aWr2RTSDWZ0bD6C1RLjObUv19W0XGp5nQ/WUHqv97k
         3F3d9T+x+RGssi2D5sQsk0sbYNBszDeUty4Uz3WYnNNnOAOtum0uoqfNv64CjbJYI2vt
         5W+yDKCq8CPlPCKNltLocOrpvWmx0Hi9m5r7qQtJGuYnsVLA+FFqMS9EVAuWM7bu2InG
         Y2OLsVw1zQ1ypzE/Wu4y0WN08yQxAbeMR9OdyOcp5d10YTszQgqk88e/T18v49VnUb5a
         Be+cx3DsqCXaxjSPwUg4xCjeVNpaDlwm4eDVW83zp+7fbc6H/u+IOUuZtg+F6GjbM9PA
         0MXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691449530; x=1692054330;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nhRFpHY9Gkw1pvDSPH6l3PWFnY0Equ+A7zpvUAn8VQI=;
        b=bI9YS84vHXeafD7CyRuyQIJ1QCbK3oQVQws+QeH/6kMrp2MBwCZWfP/9cYBQA7iA3m
         3AgQfhogmlwQheC9SPFgvOxhjt30Vy5MMSNO+E+0PHE8xcW66j1Wah+m3C9M9clOMk3f
         Rg51oRhYf2IN1JVYE3jRa0DgbwFqdVZydSoIKYcKrym69nOWS7hcAdMf6YeUdLhXDfAQ
         37mg/KcLHnBalUiVX9nm3os/UwZHmbBBdDVQu9AnbMUfxO8bIXx2j2fJfaU4JXIIcakz
         01LlkkX1zbRCTQHDf+C7AsDLEL4zf+Ap5yclKlBIH2NJIpMINC9YZ76fcNez2gKKFfiy
         p4WA==
X-Gm-Message-State: AOJu0YyBvyBI4hfjgjsgw7UmBTiRDMwlZkLjKa1NhjXIW1kaqRSF1mKg
	MHYLUG8d4/uT11R+MxqO9MU=
X-Google-Smtp-Source: AGHT+IH0ZW2oaxdE5zMBv/D24ibnqwE3DqpI9lmZfRLWAk1KAOJsXcFTPw6pcD+tvJtRgJ78+52WaA==
X-Received: by 2002:a25:fc3:0:b0:c21:4bc4:331d with SMTP id 186-20020a250fc3000000b00c214bc4331dmr6829336ybp.43.1691449530544;
        Mon, 07 Aug 2023 16:05:30 -0700 (PDT)
Received: from unknowna0e70b2ca394.attlocal.net ([2600:1700:2f7d:1800::16])
        by smtp.googlemail.com with ESMTPSA id d190-20020a25cdc7000000b00d3596aca5bcsm2545203ybf.34.2023.08.07.16.05.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 16:05:30 -0700 (PDT)
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
Subject: [PATCH mm-unstable v9 06/31] mm: Convert ptlock_ptr() to use ptdescs
Date: Mon,  7 Aug 2023 16:04:48 -0700
Message-Id: <20230807230513.102486-7-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230807230513.102486-1-vishal.moola@gmail.com>
References: <20230807230513.102486-1-vishal.moola@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230807_160533_943899_1410EEBC 
X-CRM114-Status: GOOD (  11.56  )
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

Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>
Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
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
index 6aea8fb671f1..bc82a64e5f01 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2863,9 +2863,9 @@ void __init ptlock_cache_init(void);
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
@@ -2881,15 +2881,15 @@ static inline void ptlock_free(struct page *page)
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
@@ -2904,7 +2904,7 @@ static inline bool ptlock_init(struct page *page)
 	VM_BUG_ON_PAGE(*(unsigned long *)&page->ptl, page);
 	if (!ptlock_alloc(page_ptdesc(page)))
 		return false;
-	spin_lock_init(ptlock_ptr(page));
+	spin_lock_init(ptlock_ptr(page_ptdesc(page)));
 	return true;
 }
 
@@ -2990,7 +2990,7 @@ static inline struct ptdesc *pmd_ptdesc(pmd_t *pmd)
 
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
