Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 181FCC001E0
	for <linux-um@archiver.kernel.org>; Mon, 31 Jul 2023 17:04:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ZtBKkWw2sfF8EqQjNYmHCUmI2nFQtQO8JpirJppqnWU=; b=cxztSOxCtoZLEf
	/WQdWwYTmUMKrCqgvDWgI39r7j5lXpZEyq+Niuu1NAK/TmZ4neoCd9nbuRi7DbA0WlYYx1SGJsE/M
	nW5u16muFpo8G2ph4CMs66dyja1u1nRVD5833zcbHzDndhJ3Hp8ZKVpT1MbCAUiw0eYwrzKjlFzQz
	2RvpAkrzSysa5HqmVobGZYISCRXRFLi3BhlZczJWPXR50laRA3hDUrsSdJCekIeo0AL8eZ/Hu5L51
	5FFzL+/pWSgvCK2jhyb9NLVyrfrRrjIodVNM1Fgggov0sN04jahDSAJasO26WRe6Dtfwu/c95lZTv
	lMCvoMsBerx3VjJG8eUw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qQWKF-00Gl68-2V;
	Mon, 31 Jul 2023 17:04:55 +0000
Received: from mail-yb1-xb36.google.com ([2607:f8b0:4864:20::b36])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qQWJE-00Gk3f-1y;
	Mon, 31 Jul 2023 17:03:54 +0000
Received: by mail-yb1-xb36.google.com with SMTP id 3f1490d57ef6-d1c988afebfso5035203276.2;
        Mon, 31 Jul 2023 10:03:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690823032; x=1691427832;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d0E0BACLvXh2vpBt6imfUOZqEuzu1odD4oW+AaIJCus=;
        b=YUReldkgnetLqvGL1NS71WdWnAzNWWYQnltnVm2rTkEUcOO9WrPWjz/VupfwLsV4R5
         O5U+HAQBX2TEiL7rUmM64hTiM4qIIq6sg/drG9M/BGuBJ33Wydz1s/G+0U+eMZJumoRB
         f1161HPnuyBRb78dTfpgaCSHu9Qo0gegUmxh0kC4FT9lRFkm1YwjVBx9HbpfTIAYT8q1
         zvd8Be582ZnNdhPs3i3IT6jC/uh09at7IMfH8Z/47sZBuFG6ajCrrTeAaD1eGKL98sQ4
         Picd2DUZ0mNQhUFLQyvKhXnHde4rCRB/z+5yBj02B6B5K38q9rbIBp+H/OlzOyaGOHuW
         1Lvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690823032; x=1691427832;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d0E0BACLvXh2vpBt6imfUOZqEuzu1odD4oW+AaIJCus=;
        b=OO2oIuPfH83fpfY0dBgJkUlSo/C/yc+6U4PNNBvOtmx6mtA+QDeA+0jxrWad0BbA5s
         u3Seh0MkaOv60K8Wi5vJMQQ26yrMn8mz9GmIfQsuF5XuwF2XlHd8r0XJWTqy+XIAJlA0
         wXU6K++6TvkXopAVSXjacn5NrSrqJAbTxD/uyLRFbSoBif0xAJeY6tdudRyEf7UxZ+cb
         dbp9U5Tctu5Ey5NC1s3PDxK/5LMIZpc+m7nsUcsZIuGYMMh0wbOZ8Co9YGR7C2u2e/w9
         wgnZ3d7xxhiH1tYfrhKdKeOtVNUllG1mD9pYOA6G2qUibh9yL9MlDWByCyjWxt1dDiZx
         GrJQ==
X-Gm-Message-State: ABy/qLYEahK8rvnCKvmGqY15S2E6ZFitMPky5Jj/gvKUbkmZt8oCGCyZ
	rWS+rL5uWRVXEsgf8GIGxKI=
X-Google-Smtp-Source: APBJJlHh2ZxIPqvNCWcG3uzKtYIqmu+SYBCgcUqQThaKL5dLb97zd0arq7kj2mXQ9GbTc2zqN8ZRqQ==
X-Received: by 2002:a25:84:0:b0:c67:5adb:36fc with SMTP id 126-20020a250084000000b00c675adb36fcmr11678833yba.38.1690823031787;
        Mon, 31 Jul 2023 10:03:51 -0700 (PDT)
Received: from unknowna0e70b2ca394.attlocal.net ([2600:1700:2f7d:1800::16])
        by smtp.googlemail.com with ESMTPSA id x31-20020a25ac9f000000b00c832ad2e2eesm2511833ybi.60.2023.07.31.10.03.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jul 2023 10:03:51 -0700 (PDT)
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
Subject: [PATCH mm-unstable v8 07/31] mm: Convert pmd_ptlock_init() to use ptdescs
Date: Mon, 31 Jul 2023 10:03:08 -0700
Message-Id: <20230731170332.69404-8-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230731170332.69404-1-vishal.moola@gmail.com>
References: <20230731170332.69404-1-vishal.moola@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230731_100352_678349_1E9D55A4 
X-CRM114-Status: GOOD (  10.98  )
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
index c155f82dd2cc..52ef09c100a2 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2974,12 +2974,12 @@ static inline spinlock_t *pmd_lockptr(struct mm_struct *mm, pmd_t *pmd)
 	return ptlock_ptr(pmd_ptdesc(pmd));
 }
 
-static inline bool pmd_ptlock_init(struct page *page)
+static inline bool pmd_ptlock_init(struct ptdesc *ptdesc)
 {
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
-	page->pmd_huge_pte = NULL;
+	ptdesc->pmd_huge_pte = NULL;
 #endif
-	return ptlock_init(page);
+	return ptlock_init(ptdesc_page(ptdesc));
 }
 
 static inline void pmd_ptlock_free(struct page *page)
@@ -2999,7 +2999,7 @@ static inline spinlock_t *pmd_lockptr(struct mm_struct *mm, pmd_t *pmd)
 	return &mm->page_table_lock;
 }
 
-static inline bool pmd_ptlock_init(struct page *page) { return true; }
+static inline bool pmd_ptlock_init(struct ptdesc *ptdesc) { return true; }
 static inline void pmd_ptlock_free(struct page *page) {}
 
 #define pmd_huge_pte(mm, pmd) ((mm)->pmd_huge_pte)
@@ -3015,7 +3015,7 @@ static inline spinlock_t *pmd_lock(struct mm_struct *mm, pmd_t *pmd)
 
 static inline bool pgtable_pmd_page_ctor(struct page *page)
 {
-	if (!pmd_ptlock_init(page))
+	if (!pmd_ptlock_init(page_ptdesc(page)))
 		return false;
 	__SetPageTable(page);
 	inc_lruvec_page_state(page, NR_PAGETABLE);
-- 
2.40.1


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
