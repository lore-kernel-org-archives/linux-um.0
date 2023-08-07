Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2CA4C04E69
	for <linux-um@archiver.kernel.org>; Mon,  7 Aug 2023 23:05:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=awj63jNmmjcVfIXmC8ajqtqz5PfNz72GGv2aHtrapmA=; b=Egt0Os7IyfIZN/
	Ca8+a5MOXg9q5eYVSxZGi/zaw/mZQAr2ePe7nE8QJo+4/PcmuFsQ08OJk3apWL2uruIWdfyYmnk81
	rb9aqekXjTly4mVmURj2919EGh/iqf7sDASOf1dBziSRKwSMrwGrgeV8eeCIBf2FtbZ35bE1nE/aE
	+jTG5gOO3FBpOkdKQmdIwsYqo9mx0YQxadZ92Hh9WCID2emFod7stK8HX+qmlWLCT6hcJzWls17eM
	wPEVJ3EvrT14WVGpv95YVaMMVf/7SJ/Xukvu62jlecvEX2zHuQJAUXDBGzWtOo75oD3lcbceUDWi4
	NwtW1/to4vNe/iPrRBsw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qT9IM-0014rd-0X;
	Mon, 07 Aug 2023 23:05:50 +0000
Received: from mail-oi1-x229.google.com ([2607:f8b0:4864:20::229])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qT9I2-0014T8-1P;
	Mon, 07 Aug 2023 23:05:32 +0000
Received: by mail-oi1-x229.google.com with SMTP id 5614622812f47-3a6f87b2993so3744786b6e.3;
        Mon, 07 Aug 2023 16:05:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691449528; x=1692054328;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xo55EeeiRtqMJzFppY7LfosEC+4EKSW+Y1wbH/R/zko=;
        b=Q3CUliICB5ucW5n1+cyfiOVvgvAwhYv3ZRrcZge/C2xN1y7mPAKTaAhnTC4tg457In
         GS5yV5pdx2fEbQ6Paw0G9gZpAwxLk7uLiA6v3+SIa2nM9cjP9BC4TMrWHjABBg1TkaAc
         jFqkxuJnd0T58a+3c4oi7Pn3k6jPqHaryISvoGLWFF1pysLGpyRN4pc1ANxWoEwI+30p
         K69XzaaIceuwI5auke9JvMGfHaTbti7Lrj0CNiE6K9RZ1Cm9I6s2gJdVHKhyUn9Bc8fw
         XFhL6ezBClgRYA33kHsXSFVngHlISmggGRScePESZQUU6OPVK5MugkAHJIXH8vtrGuLn
         AiPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691449528; x=1692054328;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xo55EeeiRtqMJzFppY7LfosEC+4EKSW+Y1wbH/R/zko=;
        b=SwUNmO/zQxdKCmOKvFfgjIjKemevOz6tplcesnM9fY2mCgQCwbYcsg0kVnL1GhuK/r
         Tlp6vlffVxfdLdkGYs7XgI8UKUJYG6NI8p2IJ0GuVCmYY413qKRxllmXgcgJQG1AuOMd
         /3kLv9wsvIFZh31zwhHDBAEAP05KuYqdjqOFgykPs3vGypEGZy9fMYizw1VU5HYaYivv
         vCYU6xzLi8VG28jTf6BFgifKaJmfmdyEpERkAQKeiVlFjeTj8cCT8fz6/xk1RIClZXnn
         XWrBpgsArXFwfSk4ccC5nF4hm4XgnhkYALSKKG9FthBdaVKFShza2XpoYkbnq4uQKdK7
         RAbQ==
X-Gm-Message-State: AOJu0Yxaa+/h5AtXV38+VKcV3WThetRSmRUIPOPRo43ltaV/LEsoCwqf
	yuaKyay/9vR4qNoiiV5oVdc=
X-Google-Smtp-Source: AGHT+IEuvpqTpP0gccwCdePAresyzfHn008a21Ty6dvsje55NxjSSMn6qMCPG3M+rc/X2+vc3Y/lYA==
X-Received: by 2002:a54:4886:0:b0:3a7:238a:143e with SMTP id r6-20020a544886000000b003a7238a143emr10421463oic.2.1691449528538;
        Mon, 07 Aug 2023 16:05:28 -0700 (PDT)
Received: from unknowna0e70b2ca394.attlocal.net ([2600:1700:2f7d:1800::16])
        by smtp.googlemail.com with ESMTPSA id d190-20020a25cdc7000000b00d3596aca5bcsm2545203ybf.34.2023.08.07.16.05.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 16:05:28 -0700 (PDT)
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
Subject: [PATCH mm-unstable v9 05/31] mm: Convert ptlock_alloc() to use ptdescs
Date: Mon,  7 Aug 2023 16:04:47 -0700
Message-Id: <20230807230513.102486-6-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230807230513.102486-1-vishal.moola@gmail.com>
References: <20230807230513.102486-1-vishal.moola@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230807_160530_530283_C3B86B2E 
X-CRM114-Status: GOOD (  11.74  )
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
 include/linux/mm.h | 6 +++---
 mm/memory.c        | 4 ++--
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index f6d14a5fe747..6aea8fb671f1 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2860,7 +2860,7 @@ static inline void pagetable_free(struct ptdesc *pt)
 #if USE_SPLIT_PTE_PTLOCKS
 #if ALLOC_SPLIT_PTLOCKS
 void __init ptlock_cache_init(void);
-extern bool ptlock_alloc(struct page *page);
+bool ptlock_alloc(struct ptdesc *ptdesc);
 extern void ptlock_free(struct page *page);
 
 static inline spinlock_t *ptlock_ptr(struct page *page)
@@ -2872,7 +2872,7 @@ static inline void ptlock_cache_init(void)
 {
 }
 
-static inline bool ptlock_alloc(struct page *page)
+static inline bool ptlock_alloc(struct ptdesc *ptdesc)
 {
 	return true;
 }
@@ -2902,7 +2902,7 @@ static inline bool ptlock_init(struct page *page)
 	 * slab code uses page->slab_cache, which share storage with page->ptl.
 	 */
 	VM_BUG_ON_PAGE(*(unsigned long *)&page->ptl, page);
-	if (!ptlock_alloc(page))
+	if (!ptlock_alloc(page_ptdesc(page)))
 		return false;
 	spin_lock_init(ptlock_ptr(page));
 	return true;
diff --git a/mm/memory.c b/mm/memory.c
index 956aad8aff34..3606ef72ba70 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -6134,14 +6134,14 @@ void __init ptlock_cache_init(void)
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
