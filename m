Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6789EB64DD
	for <linux-um@archiver.kernel.org>; Tue, 25 Jul 2023 04:22:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=DypMrFk8jnGC+/E4Rk9l8G48RdtvUUjK2qGCofr1GKs=; b=sfqiQKon2iUpPP
	uOuPuszzA+eZ6EyPl1ckqvRkH9TS7RvZ/FznXjTGkqf2WcxrSzv/5a+LqDjRUJKUz8rqFlsyb8qfN
	O32uzZ1KNrvI7UW24rvTgiwakJTtF2WSjochV2q76w4aLRW0YlHmi0cFX6Tf8/d6eY4pMRhBynMlB
	U83Cp5Rbnkn6TCpvqzQHxN9Egt0+NYkJfuiA9fPKfp/RmAW3UOexzx76HZWCHxoZwZve2Y2FnBCLT
	Ryy3VVYcF7DerX6+3JcWTGVwQRLiF8Yv0UIHqr4E0O5uk/JYuVW/sQlhK7N4UUrjlIXeLlC+H8dK9
	VKZ9kpcXp6nijAcCh2Ow==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qO9ZF-0068M7-13;
	Tue, 25 Jul 2023 04:22:37 +0000
Received: from mail-yb1-xb36.google.com ([2607:f8b0:4864:20::b36])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qO9Y6-0067CY-0V;
	Tue, 25 Jul 2023 04:21:27 +0000
Received: by mail-yb1-xb36.google.com with SMTP id 3f1490d57ef6-cf284f4d7afso5663615276.3;
        Mon, 24 Jul 2023 21:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690258885; x=1690863685;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iZ7ozcISUSGoixC5UzzNE5tJz0+L18C1Imj6XmV/DYM=;
        b=gPlpDfbgQUaDh17nMUuxk8LJn1nYdgEAVfSMEcDpmwNJCwXKDaomTlh0BY+xZkFMKd
         tFRmLrBoE1Vp0IzzPSrF8bgPZVxB+9aP3VrUcSHjKLr+y7jNlD4PpyjtmGaGnI3Rciw5
         xPEUpzqKKaVrLEfBMw5DD9c3Ng9G9PKL+n4eQ6Zcvb2wmVEKnYUeBmB54WntK+cvg6UK
         QgMdLEB/drGqPOPjrgcd99xnUW0qMuGMWDmaVMRTFx92PXfEsSeKT6B4JdtVKY4BOuL7
         QKWH8kGjoeg6j0VlgnYB4AI/+z50XhZH+jdg01QIwrxx7GkpXjxyDTkcgrBZeXNJtHxg
         DmIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690258885; x=1690863685;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iZ7ozcISUSGoixC5UzzNE5tJz0+L18C1Imj6XmV/DYM=;
        b=eGSpSU3KVLUBUMDjzJNKXjmhGGQmVW+VDkY/sQ1Izmx92nxeCiBmdvFh3bDM87idsc
         zQrpwEUDzf9ZcE1f+ikoDfK2M5DLb00GLOUkgqBxyOnzKR14BTRqT8Fk+h4fCXDjXgxR
         cqcR7EyI7DxU3/GFaDp8R1esi5LrAtvAAuHgDP+7XvoPGElBXdINEgiFLdYBqMwScSz2
         f/pnEso1WjwR1NVjhst+KVh3l0w1pwFe/fi5tObt4H/Bel4PikfUcHZnEvpzcD4yb2ZE
         vKLQc/LrJFrPki7brG/M+8cmks/pTVdBAvvBriFhTHIJ25HenahS2ZxOBQLE6Cegx0Lo
         nZmA==
X-Gm-Message-State: ABy/qLZWJ+/WvPUeDQkLsj725f3sn2SYB0067wKPdT78T5YM1BuiJ6cX
	fOyLGUks+rXJTWV5qJ1i3Z1Ccy61fCJpNA==
X-Google-Smtp-Source: APBJJlEU2X68Ojav0w5cqMxtXa5ryZpYlhi5g+xNY8vonB7Weqi80FZO/gUhwzOoBC/kjqTB4Zo1Gw==
X-Received: by 2002:a25:f827:0:b0:d0e:794f:64ef with SMTP id u39-20020a25f827000000b00d0e794f64efmr4552557ybd.0.1690258885213;
        Mon, 24 Jul 2023 21:21:25 -0700 (PDT)
Received: from unknowna0e70b2ca394.attlocal.net ([2600:1700:2f7d:1800::16])
        by smtp.googlemail.com with ESMTPSA id h9-20020a25b189000000b00d0db687ef48sm1175540ybj.61.2023.07.24.21.21.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jul 2023 21:21:24 -0700 (PDT)
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
Subject: [PATCH mm-unstable v7 09/31] mm: Convert pmd_ptlock_free() to use ptdescs
Date: Mon, 24 Jul 2023 21:20:29 -0700
Message-Id: <20230725042051.36691-10-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230725042051.36691-1-vishal.moola@gmail.com>
References: <20230725042051.36691-1-vishal.moola@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230724_212126_206301_ACA3E62F 
X-CRM114-Status: UNSURE (   9.61  )
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
Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>
---
 include/linux/mm.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 675972d3f7e4..774fe83c0c16 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2982,12 +2982,12 @@ static inline bool pmd_ptlock_init(struct ptdesc *ptdesc)
 	return ptlock_init(ptdesc);
 }
 
-static inline void pmd_ptlock_free(struct page *page)
+static inline void pmd_ptlock_free(struct ptdesc *ptdesc)
 {
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
-	VM_BUG_ON_PAGE(page->pmd_huge_pte, page);
+	VM_BUG_ON_PAGE(ptdesc->pmd_huge_pte, ptdesc_page(ptdesc));
 #endif
-	ptlock_free(page);
+	ptlock_free(ptdesc_page(ptdesc));
 }
 
 #define pmd_huge_pte(mm, pmd) (pmd_ptdesc(pmd)->pmd_huge_pte)
@@ -3000,7 +3000,7 @@ static inline spinlock_t *pmd_lockptr(struct mm_struct *mm, pmd_t *pmd)
 }
 
 static inline bool pmd_ptlock_init(struct ptdesc *ptdesc) { return true; }
-static inline void pmd_ptlock_free(struct page *page) {}
+static inline void pmd_ptlock_free(struct ptdesc *ptdesc) {}
 
 #define pmd_huge_pte(mm, pmd) ((mm)->pmd_huge_pte)
 
@@ -3024,7 +3024,7 @@ static inline bool pgtable_pmd_page_ctor(struct page *page)
 
 static inline void pgtable_pmd_page_dtor(struct page *page)
 {
-	pmd_ptlock_free(page);
+	pmd_ptlock_free(page_ptdesc(page));
 	__ClearPageTable(page);
 	dec_lruvec_page_state(page, NR_PAGETABLE);
 }
-- 
2.40.1


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
