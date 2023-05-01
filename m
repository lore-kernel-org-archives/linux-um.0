Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEE4FC7EE21
	for <linux-um@archiver.kernel.org>; Mon,  1 May 2023 20:40:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=W9ntS2kgA5OzeaxmtHQzfkjdXlidDxVla8NziI4tqO8=; b=s750xJEyvaKTh9
	VQayoNmGACJg2V+ksHuDJtZli63T+E6p+HLPpJTBXnzIu8Stb8DTFZ2mmr66c6OTa4hcE8k0LveJF
	MBfnKmRfdoCfyN5UynjAMgH9QTwwOeIkWkrykO3f9QGGfE29d+Uzp8rw7wQHKYF9eGi2wBPqWIiWm
	aFTcBQgaXJCqkhib1DFSZp4ExjD0ZuAddry7c4RaPVgprjz1gNqf9il5hz6lcRSmDHJSXwMhHTH7m
	a5YOWxoYWVZnawSdyLkWnUBijYy1OpJrxx4xcDmh0Ve8Mfh60mYrOFV7b4Sy+L/Az8Ml/1lGJEKfN
	4zN5ULMMvCJXq9txMSQg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1ptaK9-00GuAP-14;
	Mon, 01 May 2023 20:40:41 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1ptaK4-00Gu3d-2M;
	Mon, 01 May 2023 20:40:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=+5AaOHEPf+h0pPpRdylr/G5bcmt7vW9RVYKqYfsRH1I=; b=KuK3LAh4vXMZHeI6hCX/5gWySP
	1Jv55C3dhBU45eK6vNbAGnQwLRX+YuI1O3v/B0UOoDCGbVJf1pRdkjeuYjWkRzIVuulIIY1QS/0PK
	cF0MXMHANPC5zBA9fGND83+ClJDa5A3Mqna0x/zxjYsZ8rVL73ZtpVZQnFPCRbjgkeMIq0URPubf5
	yALNkIOs/UbF0dHa3yg9fVmDFOTzYzL0mjQPS0wWBXObhs152PXgcD04LuBmwhX5U3LJmYvbVxRVP
	ivIHsxxyFrzYm3XL/YQZQ8KJpDrxzd/i1dSUA+L+lZG1em2AzVfOwg8FAJPYiwZXL3xKMbVN+OH4z
	niJhj/PQ==;
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
	by desiato.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1ptZCY-00EyzE-1M;
	Mon, 01 May 2023 19:28:48 +0000
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1a5197f00e9so21148205ad.1;
        Mon, 01 May 2023 12:28:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682969324; x=1685561324;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+5AaOHEPf+h0pPpRdylr/G5bcmt7vW9RVYKqYfsRH1I=;
        b=roKi10VJs9dRiilqVeW0uT+zBJLQBRTUlVbgvCysCoLkLcBaFtSDJFWEbNs2bywIGo
         H3vsreWJ1ZpYCtBmz7ULTfsdWW+yedXBXQs/IwteaEsgFryEWzy4p352hRLq6aefxJE1
         6kRZZ9T8eU7cXFjWBj8Pc1GfIk6+0XR5y+mT0ED8uGwr4lyimQw2Z0aiiwvL0/TUCnLz
         1YAzhf+9hpLKk/t8M1Z7w1Ox1h7cTnYF1yo9NW5nVgHqgkVIivMOhZpN29c9g57SmIug
         sEztd2i0kQBJZgz4HOMkQSUf4qdi6lxWXkVGt+hsJgx7i60d4BQr0JdQ/AyxEv6LKtIb
         /zeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682969324; x=1685561324;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+5AaOHEPf+h0pPpRdylr/G5bcmt7vW9RVYKqYfsRH1I=;
        b=Z1Cf1rQ7z2cCa/T4quwLXnsYFS5mNpVXEppyztSa9C4HaWJyXC7MfnYtuIXc7XoORi
         vWJbM40jT6G0cfzU+a9XlUJqNW6X/QFdIt4F1ZgBaKcQwdxSGAjem14PWorMCELgI+fL
         NA7/3HORfa9htz8PyTcEqHZZBAa8Rtg2kzSxVfG0HBSPbS9lbcBuWK/qmEBYo617Omd+
         Y2GIctOt9IxBDnvXz9wRC2IhzWPNW5Ar5Wr4Kyf9lw5jbBh+wRTYUUwWZlXKyP2ih8GO
         rtoYZt+w9ZZz80pWY8/nKpdBvq6+ILLYZf8qavwMzLFu1HjlZ4gnq/Lym2iqfvIlh7sz
         7oAg==
X-Gm-Message-State: AC+VfDywHVSRxKivUe0bOU5SExcuSMnym5etbfaCT0yE7ZkS6pXOYGDr
	DCMcKshROHZFyJNWiXSLLYo=
X-Google-Smtp-Source: ACHHUZ4PPvDcr1ZSfGKsFuoX96n8X09PGID8nEMj55TFVd8R4rz9suoKbv6A+ENi8FZ5wQLN727S7w==
X-Received: by 2002:a17:902:ca0d:b0:1a6:5274:c1b0 with SMTP id w13-20020a170902ca0d00b001a65274c1b0mr12751445pld.60.1682969324101;
        Mon, 01 May 2023 12:28:44 -0700 (PDT)
Received: from fedora.hsd1.ca.comcast.net ([2601:644:937f:7f20::9a2c])
        by smtp.googlemail.com with ESMTPSA id u8-20020a170902bf4800b0019c13d032d8sm18175622pls.253.2023.05.01.12.28.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 May 2023 12:28:43 -0700 (PDT)
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
Subject: [PATCH v2 07/34] mm: Convert ptlock_alloc() to use ptdescs
Date: Mon,  1 May 2023 12:28:02 -0700
Message-Id: <20230501192829.17086-8-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230501192829.17086-1-vishal.moola@gmail.com>
References: <20230501192829.17086-1-vishal.moola@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230501_202846_842312_9F0534FD 
X-CRM114-Status: GOOD (  11.81  )
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
index 62c1635a9d44..565da5f39376 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2786,7 +2786,7 @@ static inline void ptdesc_clear(void *x)
 #if USE_SPLIT_PTE_PTLOCKS
 #if ALLOC_SPLIT_PTLOCKS
 void __init ptlock_cache_init(void);
-extern bool ptlock_alloc(struct page *page);
+bool ptlock_alloc(struct ptdesc *ptdesc);
 extern void ptlock_free(struct page *page);
 
 static inline spinlock_t *ptlock_ptr(struct page *page)
@@ -2798,7 +2798,7 @@ static inline void ptlock_cache_init(void)
 {
 }
 
-static inline bool ptlock_alloc(struct page *page)
+static inline bool ptlock_alloc(struct ptdesc *ptdesc)
 {
 	return true;
 }
@@ -2828,7 +2828,7 @@ static inline bool ptlock_init(struct page *page)
 	 * slab code uses page->slab_cache, which share storage with page->ptl.
 	 */
 	VM_BUG_ON_PAGE(*(unsigned long *)&page->ptl, page);
-	if (!ptlock_alloc(page))
+	if (!ptlock_alloc(page_ptdesc(page)))
 		return false;
 	spin_lock_init(ptlock_ptr(page));
 	return true;
diff --git a/mm/memory.c b/mm/memory.c
index 5e2c6b1fc00e..ba0dd1b2d616 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -5939,14 +5939,14 @@ void __init ptlock_cache_init(void)
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
2.39.2


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
