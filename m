Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 713E7C7EE2F
	for <linux-um@archiver.kernel.org>; Mon, 12 Jun 2023 21:05:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=AFZS7F+E/RZNY8kblM0S1a6QBOeV/9hwk7aVj32QsJo=; b=4I7SFOW2Lc6cCj
	x6axD2S84SHxztMMZOrq4N8wHsEpFHz6puFUnSSxg8zzcorYeqcP64sAY1ba5fLbji2Hy49TbRjqZ
	eW+UhDJAsd1qXP+APPkM+i6jhb+PL/R2UpsSO7YjJoTzc6yBG16TBtyd+tWPBr7EcnMAueFu+MKKW
	xSTLrBoALZghBdvMll1cVwW2444yZWnG32Mk3hDM+7JeVrZDvc5n4V9G/P2bbKh7CKLrx+s2WXGEM
	YjDu3vvLM36hGhWv1CQjk3fvTBvsk8FvnRTHZK8t+8BNFG0Ni/bqkPdzrcp/hTlqDSB+mqGXl+aeO
	he9iBZSdvBXGelRP8loA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q8oje-005O9Y-3B;
	Mon, 12 Jun 2023 21:05:58 +0000
Received: from mail-yb1-xb32.google.com ([2607:f8b0:4864:20::b32])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q8oit-005ND8-1h;
	Mon, 12 Jun 2023 21:05:12 +0000
Received: by mail-yb1-xb32.google.com with SMTP id 3f1490d57ef6-bc5a3075e92so2717242276.0;
        Mon, 12 Jun 2023 14:05:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686603910; x=1689195910;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L3tBY7hT3/idMeTvV/y5HT5RaeYwytDxSu3wHZHQdRM=;
        b=RjdfKdwo6GGvbEWocjhzyfrIG+s4yeNfDttrrqwnEGORQ/YPC7ZVmdyS10JF0LYqJm
         b6bU5xmGwzXI5ZQkTCKkSHLlY6xUp5TM7mFPqEQ9UqdLvwpNas5BJtZzv+iakqyWNnr7
         ZbUjNLXHM5JpGCASroX3mIknKspaiVxCKS4EWppAxztT7eGSIBBwCNu77Cy7Q7mvbAeg
         nTWfF3Iwgf3p1K6E3gymTY1cP1wx9AawPcYyp7n9Z4TFzq2NVk0pgr/BAa6wSZIWoNVz
         1+4z+b7cL83but8FZFxeoUPYZLJOz76q6IoC2hSwlZOG2NbQ38EQV2G66LjHRDN0bxiF
         BZ7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686603910; x=1689195910;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L3tBY7hT3/idMeTvV/y5HT5RaeYwytDxSu3wHZHQdRM=;
        b=g+bdP0BAgTVuOCkaQGu2KfyqnuElJd7QD3BU+C3+EBvxil+HotLeZK6ToQVEcnAdBH
         V2w1D8CFjkcc6XZqnZ9HE3Q+dL79TC5WHKcpzRLEanPdL0cT8m/tclPbvZVMChUQLu4P
         i3gxaK6PJcaxKDIFh1s3/uf++uUNTv3pSx/W/aNc6mSoCWY5LLBoAmFyWv+kxAvhmjPX
         xkTqZNUkd9YjjYU08o1y/GA16feJqeA4T9cXSj0YJgirL8F+19YCuVWXzd28cUu1zzKG
         TonUibMlIW/fZ5P8Ta+xzhJXbv4nD30Qc+fREL6G4VYlud+y4Ks7swftTvrXJmlS2RNq
         MfxA==
X-Gm-Message-State: AC+VfDxrxSzBrM3CDLj7Z+GacOP5UksDEfbrlzW1KnRf2wa7bqYW6osh
	eVwKKV3+L2v6jWDpffJM4gU=
X-Google-Smtp-Source: ACHHUZ7G4LX/rzVzMPXBxUvcWoM4NVaiAOMXANZTQdr/GK3rhr2fg9ZSIMvpPffGov7SQ8stbPFS3w==
X-Received: by 2002:a05:6902:2c7:b0:ba6:e17a:abc2 with SMTP id w7-20020a05690202c700b00ba6e17aabc2mr8959494ybh.63.1686603910188;
        Mon, 12 Jun 2023 14:05:10 -0700 (PDT)
Received: from unknowna0e70b2ca394.attlocal.net ([2600:1700:2f7d:1800::16])
        by smtp.googlemail.com with ESMTPSA id s125-20020a817783000000b00569eb609458sm2757115ywc.81.2023.06.12.14.05.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 14:05:09 -0700 (PDT)
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
Subject: [PATCH v4 12/34] mm: Convert ptlock_free() to use ptdescs
Date: Mon, 12 Jun 2023 14:04:01 -0700
Message-Id: <20230612210423.18611-13-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230612210423.18611-1-vishal.moola@gmail.com>
References: <20230612210423.18611-1-vishal.moola@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230612_140511_565006_6BADBAE1 
X-CRM114-Status: GOOD (  10.12  )
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
 mm/memory.c        |  4 ++--
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 3b54bb4c9753..a1af7983e1bd 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2826,7 +2826,7 @@ static inline void pagetable_clear(void *x)
 #if ALLOC_SPLIT_PTLOCKS
 void __init ptlock_cache_init(void);
 bool ptlock_alloc(struct ptdesc *ptdesc);
-extern void ptlock_free(struct page *page);
+void ptlock_free(struct ptdesc *ptdesc);
 
 static inline spinlock_t *ptlock_ptr(struct ptdesc *ptdesc)
 {
@@ -2842,7 +2842,7 @@ static inline bool ptlock_alloc(struct ptdesc *ptdesc)
 	return true;
 }
 
-static inline void ptlock_free(struct page *page)
+static inline void ptlock_free(struct ptdesc *ptdesc)
 {
 }
 
@@ -2883,7 +2883,7 @@ static inline spinlock_t *pte_lockptr(struct mm_struct *mm, pmd_t *pmd)
 }
 static inline void ptlock_cache_init(void) {}
 static inline bool ptlock_init(struct ptdesc *ptdesc) { return true; }
-static inline void ptlock_free(struct page *page) {}
+static inline void ptlock_free(struct ptdesc *ptdesc) {}
 #endif /* USE_SPLIT_PTE_PTLOCKS */
 
 static inline bool pgtable_pte_page_ctor(struct page *page)
@@ -2897,7 +2897,7 @@ static inline bool pgtable_pte_page_ctor(struct page *page)
 
 static inline void pgtable_pte_page_dtor(struct page *page)
 {
-	ptlock_free(page);
+	ptlock_free(page_ptdesc(page));
 	__ClearPageTable(page);
 	dec_lruvec_page_state(page, NR_PAGETABLE);
 }
@@ -2955,7 +2955,7 @@ static inline void pmd_ptlock_free(struct ptdesc *ptdesc)
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 	VM_BUG_ON_PAGE(ptdesc->pmd_huge_pte, ptdesc_page(ptdesc));
 #endif
-	ptlock_free(ptdesc_page(ptdesc));
+	ptlock_free(ptdesc);
 }
 
 #define pmd_huge_pte(mm, pmd) (pmd_ptdesc(pmd)->pmd_huge_pte)
diff --git a/mm/memory.c b/mm/memory.c
index ba9579117686..d4d2ea5cf0fd 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -5945,8 +5945,8 @@ bool ptlock_alloc(struct ptdesc *ptdesc)
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
