Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C8D0C001E0
	for <linux-um@archiver.kernel.org>; Thu, 22 Jun 2023 20:59:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=BZI559jDex4mtwF+gLzr3eQp7r/sLPKi0yZ02rcqr/w=; b=ViTNSbavQQVR4j
	F9ARokQln3GXDhEcVsscVf8OcaKai351Z6FJS8kX63CgcOa4+JFIxOl3lpV4FZbZjYHdKg1sGGpj1
	4fPNRHU7fPmhH9dZ6HdGGKarQY02UXAzvu3rLxIk1dVN8Oq34/zlEojsONt01RE+wk05PB5mKI4Bb
	anCYZFX+hdl1+hcE6tHmI4QgtMCiUPDj5h9SjGzs/G6pL8EYJF7rj+TYaMRrX9q3Nyp558+JAVq7o
	FURf+O62DUfhY9RurqWsL18u2ouNBz0RymkN6BPdwK92qE32+JaIhoGjMAQ6rqX+zV2kylaU9MWl5
	l7zo+AOIGzalLDbb4bDg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qCROR-001iZU-0c;
	Thu, 22 Jun 2023 20:59:03 +0000
Received: from mail-oo1-xc33.google.com ([2607:f8b0:4864:20::c33])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qCRNZ-001hdK-3B;
	Thu, 22 Jun 2023 20:58:12 +0000
Received: by mail-oo1-xc33.google.com with SMTP id 006d021491bc7-5608bb16496so2706687eaf.3;
        Thu, 22 Jun 2023 13:58:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687467488; x=1690059488;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sr5TgrSX24KD5rPSp2rkPhxpII4heal/IIgk1FACoIs=;
        b=UtF2QiZk6b9G+hZ8o+uaaa8jIMv9kwu5Z4W+DnKhqSxtuxZLeuCmgWiQ2UyCbKdGf3
         JlKYQP1/9HAEwi4YcMuZIpkc1UasphklUD1y4PAfxdaiUenlc82pk0MDNgE4UyvTP/Ti
         WAZ4mtTP+0UbBT6PIwdrRUvrUpbxA+faq7jSe2iTSffGzc1HNKXsxuak3eG36Kz3Hx1p
         3Bw014l7N9peXiYCyjbUvF7k31KviCnInVoJPhH8kz/FXkdJ8oxWXWbjuOh6BjmUEfNL
         NLvkARmq7C0ZzVI4l8HT21OfZWS/swkiU6k+jkbLgeAOyE/KVS/34HjWz0qthh2YGY4M
         vuhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687467488; x=1690059488;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sr5TgrSX24KD5rPSp2rkPhxpII4heal/IIgk1FACoIs=;
        b=cZM4CWxqjUsKYh01QLXBSM+VbwQ7SDC8ov80EHnEgTj6bPvlyoZChIyhBpi7Dqxowk
         r8M1oceSThGKh3+x4OSR3PnvWA5jsWt/KxNP0LJfaqZulzbfqsdnim2XctZXJLyIGfrH
         CGNcR30+y/nH2ezSa+sOkQ/CMYHxX2g+HiEAeQ9ZlL9ZRJzPTDbI/gnc7TOGczVXFDjo
         Dx1a5xIH+SoZhcDEh+GMJ/X7SNVWR4sR03htLaFIY/sUnyp8FwDcvm/yz7RBGqwrfWAP
         Mbu33tOVxifJSAQa6+0BtinGoM4iazydsA/dWrRNeLDv9fVGvBk3FzsqTMAfs1a85BCC
         wm6A==
X-Gm-Message-State: AC+VfDwo1VCidR2CLv7+aF2Mq0IolI4cvIe2GkEnZ+nT6IE5hWDSjOnt
	joEGhb8susthQFB4e9c0SC8=
X-Google-Smtp-Source: ACHHUZ6Wv4q+lCV8nxexJGI3S2vfJP94k7k+pAexpWAqQNNuxMHJpmGx+Tn2Ll2+HAYtwXHgGRnsHw==
X-Received: by 2002:a05:6358:9f9f:b0:132:d8bc:b15b with SMTP id fy31-20020a0563589f9f00b00132d8bcb15bmr1343396rwb.2.1687467488545;
        Thu, 22 Jun 2023 13:58:08 -0700 (PDT)
Received: from unknowna0e70b2ca394.attlocal.net ([2600:1700:2f7d:1800::36])
        by smtp.googlemail.com with ESMTPSA id d18-20020a5b0c52000000b00bc501a1b062sm1684937ybr.42.2023.06.22.13.58.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jun 2023 13:58:08 -0700 (PDT)
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
Subject: [PATCH v5 06/33] mm: Convert ptlock_alloc() to use ptdescs
Date: Thu, 22 Jun 2023 13:57:18 -0700
Message-Id: <20230622205745.79707-7-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230622205745.79707-1-vishal.moola@gmail.com>
References: <20230622205745.79707-1-vishal.moola@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230622_135810_123232_F32226AF 
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
Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>
---
 include/linux/mm.h | 6 +++---
 mm/memory.c        | 4 ++--
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 1511faf0263c..39b0a4661e44 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2798,7 +2798,7 @@ static inline void pagetable_free(struct ptdesc *pt)
 #if USE_SPLIT_PTE_PTLOCKS
 #if ALLOC_SPLIT_PTLOCKS
 void __init ptlock_cache_init(void);
-extern bool ptlock_alloc(struct page *page);
+bool ptlock_alloc(struct ptdesc *ptdesc);
 extern void ptlock_free(struct page *page);
 
 static inline spinlock_t *ptlock_ptr(struct page *page)
@@ -2810,7 +2810,7 @@ static inline void ptlock_cache_init(void)
 {
 }
 
-static inline bool ptlock_alloc(struct page *page)
+static inline bool ptlock_alloc(struct ptdesc *ptdesc)
 {
 	return true;
 }
@@ -2840,7 +2840,7 @@ static inline bool ptlock_init(struct page *page)
 	 * slab code uses page->slab_cache, which share storage with page->ptl.
 	 */
 	VM_BUG_ON_PAGE(*(unsigned long *)&page->ptl, page);
-	if (!ptlock_alloc(page))
+	if (!ptlock_alloc(page_ptdesc(page)))
 		return false;
 	spin_lock_init(ptlock_ptr(page));
 	return true;
diff --git a/mm/memory.c b/mm/memory.c
index 80faf3e76232..2ff14f50c7b3 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -5920,14 +5920,14 @@ void __init ptlock_cache_init(void)
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
