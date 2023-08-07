Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF57DC41513
	for <linux-um@archiver.kernel.org>; Mon,  7 Aug 2023 23:06:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=HdhyIGY+9UX6M3bQ9DNFGfdDQ69b16Aw3G0F3VUFCa4=; b=sjVSjXD9IxN1yB
	o/eDrwzFo0PxAcdqQYS8dMcFauRY2AUeSA5yFBojSLUCbQa1ek+6N+C7OLgLRFWzoyyy+5I/rMa+e
	543DGt5jpEzVHeIE79i4liXZlD2ErpJJfSSkZZ+07ViYPYLWlYJEb3aMVMFxjO9XHByoRSlMkIhxG
	w0/BEPCS1DntJVYglS3CbBznXGDwCwLTuIpnwiXJUpJ3R6zJIwlhtM1PZcHGwCjqk7r5slCxg9QcJ
	PIVKIqSfs9bdhMwNQ06MXaH+4MiSyNTJ9AEWzKGM0Uosk3M2j1Lme04yCQZcuEYNCP+ldDnd0qzY3
	MlimY/VDyQmz2SJrSbGw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qT9JC-0015ss-0x;
	Mon, 07 Aug 2023 23:06:42 +0000
Received: from mail-yb1-xb29.google.com ([2607:f8b0:4864:20::b29])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qT9ID-0014eO-28;
	Mon, 07 Aug 2023 23:05:44 +0000
Received: by mail-yb1-xb29.google.com with SMTP id 3f1490d57ef6-d35a9d7a5bdso5116675276.0;
        Mon, 07 Aug 2023 16:05:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691449538; x=1692054338;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rO3hRWVBo6Y9vRkkphMYimV7kP+YdlMpTAZzrYQT330=;
        b=Xru6G6uiZe/OuMY5nm6nRGhKKZT+cMjFr3ywYmjJVtK6bJQBvGQe4lb67TeNeIpRR1
         vU6ROYd5sljoul9DQ182dcYNUtIjSE0g9ryH9BBQnyweF2i9F3a0tNr39lnubSpEzEzx
         D9dlEQ3L7Z6V9tMyRKOuG3jp1VK2LuxNqNXMsa/r8JF3v1c5M1/VvDBiBALX9JEbGcjF
         BYD5zunEjYtVpsA/+5S4bzMaVg5Xls19tVXYJS5Y3GWWrR9cQxHo66Iare/M20jic/7P
         QScGaLnDnqCa6oKmv6Q3fNTRqyTkrnI7S8dkrsktkT3ibHnZIlamT/1RRAzAV+HV4mnX
         P1Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691449538; x=1692054338;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rO3hRWVBo6Y9vRkkphMYimV7kP+YdlMpTAZzrYQT330=;
        b=FFiMY666gMizReJq0nSnQBGVAhn3h5TEHrVBvCsVtrhEiyJ94fQ6CGAUICsubMXuNP
         eFomGBdzSaUs+nNU3VS4y1GjtSRv0o4B3WzD2tKjp+ARi58keZVcFVxyiDQlrc26mSY6
         JX99M33e9iTs0QYtMGCsHhKT9vjQYn87/QBaXtj/8tB3x9YJjKeVNgfxKKjBPL5EC418
         T3/roHRv9f3pNo/hdJvsyXjjqli/+hBhlgRrDzvnQP7WoPZ0jDRbSWPjmiYfGj1FfoxM
         ZT9MJOJLUaFbxgmt1pdACzdqMC9txdNfanWU4Ds5u+vW8zEEdlNjpzqbDZjqoy8DGHlp
         waFA==
X-Gm-Message-State: AOJu0Yx2KlvPgoRW7G3dSjFXpjt0U5AhwJlkcd/xpuR+dK4t+hQmdQOc
	7HICjWCPMjlV2vkLKcOd+vg=
X-Google-Smtp-Source: AGHT+IFQ1sRvJZAfCY+VUYCk9fa9DxUgaBX+22XersqRcqzji4wcHGi6IN2gPixXkKaq4oGn1g4mnw==
X-Received: by 2002:a25:8001:0:b0:d0f:ea4b:1dff with SMTP id m1-20020a258001000000b00d0fea4b1dffmr9335056ybk.8.1691449538435;
        Mon, 07 Aug 2023 16:05:38 -0700 (PDT)
Received: from unknowna0e70b2ca394.attlocal.net ([2600:1700:2f7d:1800::16])
        by smtp.googlemail.com with ESMTPSA id d190-20020a25cdc7000000b00d3596aca5bcsm2545203ybf.34.2023.08.07.16.05.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 16:05:38 -0700 (PDT)
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
Subject: [PATCH mm-unstable v9 10/31] mm: Convert ptlock_free() to use ptdescs
Date: Mon,  7 Aug 2023 16:04:52 -0700
Message-Id: <20230807230513.102486-11-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230807230513.102486-1-vishal.moola@gmail.com>
References: <20230807230513.102486-1-vishal.moola@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230807_160541_926448_96251DFE 
X-CRM114-Status: GOOD (  10.19  )
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
 include/linux/mm.h | 10 +++++-----
 mm/memory.c        |  4 ++--
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index aa6f77c71453..94984d49ab01 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2861,7 +2861,7 @@ static inline void pagetable_free(struct ptdesc *pt)
 #if ALLOC_SPLIT_PTLOCKS
 void __init ptlock_cache_init(void);
 bool ptlock_alloc(struct ptdesc *ptdesc);
-extern void ptlock_free(struct page *page);
+void ptlock_free(struct ptdesc *ptdesc);
 
 static inline spinlock_t *ptlock_ptr(struct ptdesc *ptdesc)
 {
@@ -2877,7 +2877,7 @@ static inline bool ptlock_alloc(struct ptdesc *ptdesc)
 	return true;
 }
 
-static inline void ptlock_free(struct page *page)
+static inline void ptlock_free(struct ptdesc *ptdesc)
 {
 }
 
@@ -2918,7 +2918,7 @@ static inline spinlock_t *pte_lockptr(struct mm_struct *mm, pmd_t *pmd)
 }
 static inline void ptlock_cache_init(void) {}
 static inline bool ptlock_init(struct ptdesc *ptdesc) { return true; }
-static inline void ptlock_free(struct page *page) {}
+static inline void ptlock_free(struct ptdesc *ptdesc) {}
 #endif /* USE_SPLIT_PTE_PTLOCKS */
 
 static inline bool pgtable_pte_page_ctor(struct page *page)
@@ -2932,7 +2932,7 @@ static inline bool pgtable_pte_page_ctor(struct page *page)
 
 static inline void pgtable_pte_page_dtor(struct page *page)
 {
-	ptlock_free(page);
+	ptlock_free(page_ptdesc(page));
 	__ClearPageTable(page);
 	dec_lruvec_page_state(page, NR_PAGETABLE);
 }
@@ -3006,7 +3006,7 @@ static inline void pmd_ptlock_free(struct ptdesc *ptdesc)
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 	VM_BUG_ON_PAGE(ptdesc->pmd_huge_pte, ptdesc_page(ptdesc));
 #endif
-	ptlock_free(ptdesc_page(ptdesc));
+	ptlock_free(ptdesc);
 }
 
 #define pmd_huge_pte(mm, pmd) (pmd_ptdesc(pmd)->pmd_huge_pte)
diff --git a/mm/memory.c b/mm/memory.c
index 3606ef72ba70..d003076b218d 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -6145,8 +6145,8 @@ bool ptlock_alloc(struct ptdesc *ptdesc)
 	return true;
 }
 
-void ptlock_free(struct page *page)
+void ptlock_free(struct ptdesc *ptdesc)
 {
-	kmem_cache_free(page_ptl_cachep, page->ptl);
+	kmem_cache_free(page_ptl_cachep, ptdesc->ptl);
 }
 #endif
-- 
2.40.1


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
