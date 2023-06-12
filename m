Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE87FC7EE2F
	for <linux-um@archiver.kernel.org>; Mon, 12 Jun 2023 21:05:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=nMCTRZYafF5dG2DsHGiMTHXEzjvDh2DKh2BLsxZOz/k=; b=3eBgyxY0DneIG4
	Tat1dQ0GDr9HanIkg4Ht3mBUpbuTWFiqQfWxFdeAMxS57skTTFttg32/Vb7l8WHYbeukj28IWQvq/
	9O2IWIDqupqSWjRdeIIhQ/OlHIpx9eH53jX/ssqybeACkJ0AVy6NgEq2OI9u5rBmEe6yN383dy5FT
	vZzNn4K9pVz9o8V2+kkqRNStbjXshi151CWmndzspvsFfcIz3FGfGAKNaBC6QgLVumVXLj6QH6obQ
	0sGOsqtasWjSctTavemhP9leR4qnYQpBFVOOUMX9DIGim+/LHwWa3ctl18r7rskzSCwkqs9GphPxt
	NaB+WPQgOHWhc0azYE/w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q8ojA-005NWh-1r;
	Mon, 12 Jun 2023 21:05:28 +0000
Received: from mail-yw1-x112d.google.com ([2607:f8b0:4864:20::112d])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q8oij-005N2P-0Q;
	Mon, 12 Jun 2023 21:05:04 +0000
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-56d4f50427cso6510917b3.3;
        Mon, 12 Jun 2023 14:05:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686603900; x=1689195900;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=csibueTQMI8hz/axFpDokmCUVKS4XWTLf0OEMRBu+sg=;
        b=FDAUnHm2faFSWGwfZS5hO+D9w8GP4e4g1ML7/tmHqNMsyYqyAD51ooe/UZAynheb45
         JUNAZVEGWiy3FM+aYWlvoHKaBUFoNzNTwUdIl4kQAVJN12Picp2GbnIh1UwydO/qddyi
         DCuNf5aNp8X4OTmdAm+cAeL3CGsOgaZ27ub95e/8MTqIlBQGK4N048waW9QZBpSO9XHI
         sWfFM9CmbvJbA3uGm5rS2JNk4GtvKzbhh98S182OZhG/f2sSkxT71cjOLs4vhjGq3bqf
         ArQftxucDa5+VY1eeLZl1/JDXSt6Px6z9h8EFmxArPTIN+H3XkndN1zswUa8dX9vrXU3
         5Q2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686603900; x=1689195900;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=csibueTQMI8hz/axFpDokmCUVKS4XWTLf0OEMRBu+sg=;
        b=Y4hV9lOKh/j0D/PjFqZNp0sO4slxRFliG7TUDRX0jBJig+DfUntu2Y7WsQgeJY75YH
         OmD0ol2uJprAQFlAezBZZDhB+U+I9xYEOpgRZ68aeBYPyK/F+u2jXl7fWSVPxoUGX/mY
         LwQKRoVsZQT/6mkX9Kwxoc4xOkWeUaHS4ck+x3+P77YzH2enOvijeOQ8G4uM1ZtdEj12
         QQR7Lq7b7IMSnK9CexwhbULsPib1T8LtP/jfXIcsBMwzTlTOsFShvFZFR+7E1Sz6UOpF
         lg2+vUP4zUVpzMcoQNYk76sW5HjJnzXZIosec9t+YNDQ+Ny30asWVK2nSTA5fDOJccjn
         7eWQ==
X-Gm-Message-State: AC+VfDzheHtZxXze+MRYrTcA90FiECYjuUO+YAKHU9rGgXEP2JUL5UBs
	kCNjAtcAg04CWXtA1oYnNyg=
X-Google-Smtp-Source: ACHHUZ7XKzfLRWmcjDH1kOSVD0e6fKxxbDH/DoQa8Wv3QDYuxgXM2gpDCQ5rMsZn09dpzldtR2HsSA==
X-Received: by 2002:a0d:e294:0:b0:56d:5041:78b with SMTP id l142-20020a0de294000000b0056d5041078bmr1552114ywe.2.1686603900209;
        Mon, 12 Jun 2023 14:05:00 -0700 (PDT)
Received: from unknowna0e70b2ca394.attlocal.net ([2600:1700:2f7d:1800::16])
        by smtp.googlemail.com with ESMTPSA id s125-20020a817783000000b00569eb609458sm2757115ywc.81.2023.06.12.14.04.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 14:04:59 -0700 (PDT)
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
	"Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [PATCH v4 07/34] mm: Convert ptlock_alloc() to use ptdescs
Date: Mon, 12 Jun 2023 14:03:56 -0700
Message-Id: <20230612210423.18611-8-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230612210423.18611-1-vishal.moola@gmail.com>
References: <20230612210423.18611-1-vishal.moola@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230612_140501_265291_7764AC1E 
X-CRM114-Status: GOOD (  11.57  )
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
 include/linux/mm.h | 6 +++---
 mm/memory.c        | 4 ++--
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 088b7664f897..e6f1be2a405e 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2825,7 +2825,7 @@ static inline void pagetable_clear(void *x)
 #if USE_SPLIT_PTE_PTLOCKS
 #if ALLOC_SPLIT_PTLOCKS
 void __init ptlock_cache_init(void);
-extern bool ptlock_alloc(struct page *page);
+bool ptlock_alloc(struct ptdesc *ptdesc);
 extern void ptlock_free(struct page *page);
 
 static inline spinlock_t *ptlock_ptr(struct page *page)
@@ -2837,7 +2837,7 @@ static inline void ptlock_cache_init(void)
 {
 }
 
-static inline bool ptlock_alloc(struct page *page)
+static inline bool ptlock_alloc(struct ptdesc *ptdesc)
 {
 	return true;
 }
@@ -2867,7 +2867,7 @@ static inline bool ptlock_init(struct page *page)
 	 * slab code uses page->slab_cache, which share storage with page->ptl.
 	 */
 	VM_BUG_ON_PAGE(*(unsigned long *)&page->ptl, page);
-	if (!ptlock_alloc(page))
+	if (!ptlock_alloc(page_ptdesc(page)))
 		return false;
 	spin_lock_init(ptlock_ptr(page));
 	return true;
diff --git a/mm/memory.c b/mm/memory.c
index 80ce9dda2779..ba9579117686 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -5934,14 +5934,14 @@ void __init ptlock_cache_init(void)
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
