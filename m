Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2182AC77B76
	for <linux-um@archiver.kernel.org>; Mon, 17 Apr 2023 22:01:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=UN6mymRWL+jTykYPm0+cSogV6pv2EZCiHZoNiQ5V0nw=; b=kgA4/EZQQh8Ibp
	SkQkrhePImUIaf525luYoO8SLr3sK0e5GUPGPYSLHrm6Cb4r+VHZM1cN3FGRNrmX10DxIpH1ImG6U
	iD6MMYbxfiOgdTcwQVrH7v9FD/ddePfTW7d0kn2WfdVuEt3eOjU/iisfNO32XVXgwHnNY684sn2KF
	uXGEzMk9yFA3Uk2J+K0AgZKBBnTD8ASHZ/57X/I/oxpSM2WTXeQONptc0BiHauyIFQf/FmW4jMYjg
	aTPudmu7OdzXd3K7NJgYBX0qmyPiSqL7KQQMLAiMI3ptQdW7GnSdTQMsve6f0FARKKpxbQyFCVTlj
	tAtKW9cgfxAkzNJUgDHQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1poWv1-000DBs-2K;
	Mon, 17 Apr 2023 22:01:51 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1poWuy-000D9b-1V;
	Mon, 17 Apr 2023 22:01:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=Hc0m/U8RaSqOAaIvHe2pZ8la6AwQPtvql1ppirfWYYQ=; b=h3UYe0VPo1xlDQe8WwI4wIAioD
	oQXn9B7l9PYZJ8+8ZzH5ikvCd1aQQ18GUqmxtwNV5r3ZQvkJy9z/MwWsHE5MMUjpxVRPFCGDylU+D
	ulMG+PZqj47rt9BzvSsJs78kIV+kEfyj+CyLXh2QGLlInIy0x7tV6v8SphN2PmgF1kJI6VdVclaX5
	eorfQ/1Ds3xVsyb09oPaHUMdFTNVVtFCqyXqZG+q6JAuvjLu772IuofEbyS8vuZ6qTLa4oqQUa4tu
	V4JU9lFk3gRI9GSUv4cj3Iqk86HFCKWW3V39cbKg8xvOiFdBD69NqeRmid7OeEjn7rTM5Jc0KStHz
	QaZapasw==;
Received: from mail-pj1-f51.google.com ([209.85.216.51])
	by desiato.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1poVqR-00HS6W-1u;
	Mon, 17 Apr 2023 20:53:14 +0000
Received: by mail-pj1-f51.google.com with SMTP id w11so27721540pjh.5;
        Mon, 17 Apr 2023 13:53:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681764781; x=1684356781;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hc0m/U8RaSqOAaIvHe2pZ8la6AwQPtvql1ppirfWYYQ=;
        b=FTIIrhTe8vfWt4jgLQ0zryZ+NfsJ/OFhYpHyrwEJjHtN6fYrjayv1wmbuEiWrZWNBG
         Ab6oC0JEVFKaVtr5ERs/HGyia4m0cuJPp54Y6qKJvGxwoWwnKA3jL+mq6GAMCgFGvFWn
         bEbIp/iuCRzaSQasJ9iYfHsEIZ8C5L6UBjIsqJjVLRNCdj3wFA0VCJaoyvqsQShlPxAr
         nn14k2m42+J6xR2hfl2ffw8tFItkZsF+DKNsuBC18vZWoMB4mE4FcDOZiJ4pqP0DqYky
         PjLPxBMY5gAsTXZg/iGvnD4lxFGHfkuFymQLt7EWHTlIBpCDY+iSj33ZpMo6EFdNFztz
         HYrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681764781; x=1684356781;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hc0m/U8RaSqOAaIvHe2pZ8la6AwQPtvql1ppirfWYYQ=;
        b=PKUG+/+/r4ljSe4gIsedwBvgVJ+Ugspc1x0+9aYQ+jpm0egWnXuEKpsQhdrV+tjZoA
         R7Lp8h+B/weI5eOuEqi3UBswdrOFfkXjFWi0uz9n0s0DwkpH5GOqKC0Pr2qS7+73Vyup
         S8irzUXmx4uIYZsGIY57huO5nzNgD5RYDwt0ySWR2NDSEbt2KqiByo/PQgrYe7meLgeU
         C0xzpQkh5+qX8fzGuLcEfLqBEYf/ZeJk9gvHVL9eqqNANDOOnbvi6j2uH6HS10H+usqO
         r0VDOvZVd77g5w2KqNXi9V8Siu8CsaWrV0rP4978J1MBCFae6pIeulY37FS/CpLoRd3v
         oqdA==
X-Gm-Message-State: AAQBX9exp8zzq79cXCQCgerauLVLddhSxTwyYLKAcyZZ31OOYzkMZtsA
	5do4PDRoAStSIlpYatgj43c=
X-Google-Smtp-Source: AKy350ZMofF2taT9lCtSfGwXj3mTLikp6R4dNTLL/p579XSegIqzslR/71TUEAWTkG6EWBZpLey91g==
X-Received: by 2002:a17:90a:d143:b0:23b:2c51:6e7 with SMTP id t3-20020a17090ad14300b0023b2c5106e7mr16554327pjw.21.1681764780697;
        Mon, 17 Apr 2023 13:53:00 -0700 (PDT)
Received: from fedora.hsd1.ca.comcast.net ([2601:644:937f:7f20::c139])
        by smtp.googlemail.com with ESMTPSA id h7-20020a17090ac38700b0022335f1dae2sm7609707pjt.22.2023.04.17.13.52.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Apr 2023 13:53:00 -0700 (PDT)
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
Subject: [PATCH 11/33] mm: Convert ptlock_free() to use ptdescs
Date: Mon, 17 Apr 2023 13:50:26 -0700
Message-Id: <20230417205048.15870-12-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230417205048.15870-1-vishal.moola@gmail.com>
References: <20230417205048.15870-1-vishal.moola@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230417_215305_041463_EEE2D68C 
X-CRM114-Status: UNSURE (   9.65  )
X-CRM114-Notice: Please train this message.
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
index 2390fc2542aa..17a64cfd1430 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2787,7 +2787,7 @@ static inline void ptdesc_clear(void *x)
 #if ALLOC_SPLIT_PTLOCKS
 void __init ptlock_cache_init(void);
 bool ptlock_alloc(struct ptdesc *ptdesc);
-extern void ptlock_free(struct page *page);
+void ptlock_free(struct ptdesc *ptdesc);
 
 static inline spinlock_t *ptlock_ptr(struct ptdesc *ptdesc)
 {
@@ -2803,7 +2803,7 @@ static inline bool ptlock_alloc(struct ptdesc *ptdesc)
 	return true;
 }
 
-static inline void ptlock_free(struct page *page)
+static inline void ptlock_free(struct ptdesc *ptdesc)
 {
 }
 
@@ -2844,7 +2844,7 @@ static inline spinlock_t *pte_lockptr(struct mm_struct *mm, pmd_t *pmd)
 }
 static inline void ptlock_cache_init(void) {}
 static inline bool ptlock_init(struct ptdesc *ptdesc) { return true; }
-static inline void ptlock_free(struct page *page) {}
+static inline void ptlock_free(struct ptdesc *ptdesc) {}
 #endif /* USE_SPLIT_PTE_PTLOCKS */
 
 static inline bool pgtable_pte_page_ctor(struct page *page)
@@ -2858,7 +2858,7 @@ static inline bool pgtable_pte_page_ctor(struct page *page)
 
 static inline void pgtable_pte_page_dtor(struct page *page)
 {
-	ptlock_free(page);
+	ptlock_free(page_ptdesc(page));
 	__ClearPageTable(page);
 	dec_lruvec_page_state(page, NR_PAGETABLE);
 }
@@ -2916,7 +2916,7 @@ static inline void pmd_ptlock_free(struct ptdesc *ptdesc)
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 	VM_BUG_ON_PAGE(ptdesc->pmd_huge_pte, ptdesc_page(ptdesc));
 #endif
-	ptlock_free(ptdesc_page(ptdesc));
+	ptlock_free(ptdesc);
 }
 
 #define pmd_huge_pte(mm, pmd) (pmd_ptdesc(pmd)->pmd_huge_pte)
diff --git a/mm/memory.c b/mm/memory.c
index 37d408ac1b8d..ca74425c9405 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -5937,8 +5937,8 @@ bool ptlock_alloc(struct ptdesc *ptdesc)
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
2.39.2


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
