Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF002C77B73
	for <linux-um@archiver.kernel.org>; Mon,  1 May 2023 20:41:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=PnKuKnfc9E/HGnjomTU7u+8z47O8f4pTQLEK8ZLQ3U4=; b=y0Q+9BhQla/qUa
	0Gb0Qy51wEkLcaqMHyoZyltnaEv9FYJe+hqFPyOMNlDBOl8HegryZ7/4ZGzWpOwI7/Dzlax8whsiD
	AhxgD25qDg9BMM7VfVsThFNuvQPZfJiUcaunLdZYeh74f1OpBU5ErLhXl9MP4XZkTOxddeIyKRaL7
	YtXyPir9DgY5/PP74t59GyBx3xClkG0YGNLlxm9FrzwDvqoraqMuleeErv9RmaqsZPsPCqJxlKphV
	ZZL7G0cXHo3CAFjyNZGY83bWN9lku2/Mof2bOpYiSp6PAZXvS9gD7yi+5atF5gG06J3iR4TfUYuRt
	sQBeKx6iUpYGNmo93C4A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1ptaKd-00Gudi-2o;
	Mon, 01 May 2023 20:41:11 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1ptaKP-00GuPo-0C;
	Mon, 01 May 2023 20:40:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=Mt3HE6L47sPJBYnAKPMz0/DxNRKvA6oRz72+XbjGX9E=; b=Ezc5mIp77OC2QIG1wGulU0Dk1x
	AR2sWZuTz9VeKg3wrbeRQ+H706FxEohcLA6Cv+Ah6B6jDayw5Qypb1sMZkwSOK/hGlnUJapWMX0GD
	Z+lyBY6FhGWHP092J52RXrJ5wO4/sZESwvDNREbnBJRTugb8RGl5dBQm/AOYfGhQt39QNz1uXTpT+
	NoFhWYqw2aG/knhUEyU43I2RsOnIJc9kKrB3d5PypxhAEGLm+mMfnsYM7xe0gU4xPaYzVXd2ZMqys
	UyHMF+ZuT9UuEpvB9drmtD/tMwmce3JzC+/6e+7cEWJljklb4xsS9P9dhFMfK6kBmT5WR8KVEsBdW
	BnohLw6A==;
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
	by desiato.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1ptZCn-00Ez1C-32;
	Mon, 01 May 2023 19:29:04 +0000
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-64115e652eeso29038907b3a.0;
        Mon, 01 May 2023 12:28:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682969331; x=1685561331;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mt3HE6L47sPJBYnAKPMz0/DxNRKvA6oRz72+XbjGX9E=;
        b=bRmqBPTZgCa5IrhecvrTPyLDuab4M/2pWmm67Ij9kB88cqyNYvHpKZf2c822tlLINs
         V7g4wokwjyA5yoaxqgkTwqtzjgfghwoIfl0NbPXtXdg2Gw3C4PIS2FYz/KLko7etiChc
         s5Y++dzV39ZBew8o5WYNHoWZR+E9Lx1p8UATOni2Z3kTd3MdcR3ji+KJhcCE5jLMM79j
         4rcgjvbB4U2t2rwTpoiUyWgvBTuTWbg65E+Konk9GYsk7NMgNhoUvQ9jMEmXFDz/6lzW
         5y5R3ETL6C6d8IdLyMxau5jgOeNqS9ewzuT1HexEBx4VHGUimuQrmfTb2llKzaIBnzUu
         BV2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682969331; x=1685561331;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mt3HE6L47sPJBYnAKPMz0/DxNRKvA6oRz72+XbjGX9E=;
        b=G6YswteQsQ+TtXlHW5AwLW7GccYyU1+tA+UahxCMjGwab3DCsU91kG7QWN+99EcF12
         WaVdCOs1wEq7TMBJhlInKUGFCSLqCjxw/Ao8MCCOdwTXWiAjwfNLUJvzXKIZkzGk1qVd
         8FHNL4iU6zYjuhxnnWmNWydmNjEd4sS3L6QR2Fmnapubwxza10/Sdk3F1x3y5Euusx4W
         IoNpqnopGlwaBuYZ4AWKi3X2k/1NTQU39fr1/ujIKaXJ/qZl2xZ6RjeYBdmHNOC2J1Vi
         7lR+DsGocIWG2ZrbGKZWWSYkEx8UXY/rEFZZ0WFQWh0XOQMw+0VilVGPUkmIvng0FIvE
         8M7Q==
X-Gm-Message-State: AC+VfDwNhdl9XPYRGQBePm6I15+PKvxL4irgnSXKEfZbsplHAfGeDGl4
	6grD7ti+gHQ6rBK8KaxoZIk=
X-Google-Smtp-Source: ACHHUZ6xNyoMsdtkeuJYwr4JFA16W7bSDCfft0wt/spwymptVQy+yHqySIROmads3b5d2VYC5oAliA==
X-Received: by 2002:a17:902:ced1:b0:1a9:3c1d:66de with SMTP id d17-20020a170902ced100b001a93c1d66demr18699403plg.15.1682969330907;
        Mon, 01 May 2023 12:28:50 -0700 (PDT)
Received: from fedora.hsd1.ca.comcast.net ([2601:644:937f:7f20::9a2c])
        by smtp.googlemail.com with ESMTPSA id u8-20020a170902bf4800b0019c13d032d8sm18175622pls.253.2023.05.01.12.28.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 May 2023 12:28:50 -0700 (PDT)
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
Subject: [PATCH v2 12/34] mm: Convert ptlock_free() to use ptdescs
Date: Mon,  1 May 2023 12:28:07 -0700
Message-Id: <20230501192829.17086-13-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230501192829.17086-1-vishal.moola@gmail.com>
References: <20230501192829.17086-1-vishal.moola@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230501_202902_775658_49532E37 
X-CRM114-Status: GOOD (  10.26  )
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
index a2a1bca84ada..58c911341a33 100644
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
index ba0dd1b2d616..7a0b36560e28 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -5950,8 +5950,8 @@ bool ptlock_alloc(struct ptdesc *ptdesc)
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
