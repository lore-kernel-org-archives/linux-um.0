Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6B18C77B73
	for <linux-um@archiver.kernel.org>; Mon,  1 May 2023 20:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=jdFs1DXM41XaS5Yy0yKgVzXPjZXHT6c1J6n3qVVbSkg=; b=FRa+QD7uObqNx1
	Xu180mCGkHu5Axfj/p30XNOgZrYvBx2kH4d37+DWQU71BBOsG4S+ZGNlOeK7qZtzYVoUPaQh08kMi
	RAvUgEzSCTMpsqPtntX+enMos36oZ9lkbZVaZzT15on7k2PuGsiFN6Vkaq/K435//5uTw3qFExqji
	ftXQrsUYv3dpxXBmRrY4CYOZpXS/+E/VIwPcuJWe/N8uhGHYjd+i4ELKJaAj7PYYfVW0aMua1CieN
	3wMm44+x6mZdsb+YG1z7sADTMXUpIW59XgtFfrTTDSurYrBSHOA2cHH1ZUX2ty9c41BsPKnT0NYUU
	jVN5YxB90VnNqfKMo1Jg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1ptaAF-00Gs9d-1i;
	Mon, 01 May 2023 20:30:27 +0000
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1ptZCd-00GhD8-1D;
	Mon, 01 May 2023 19:28:52 +0000
Received: by mail-pg1-x536.google.com with SMTP id 41be03b00d2f7-517c840f181so1426261a12.3;
        Mon, 01 May 2023 12:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682969329; x=1685561329;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qTcYn70jypAxoGiZWNhXW/f3wJ7PRfT+UBBqvcdtR7Y=;
        b=lB3Z6fcbmN3PCDkgSSAUdLyGGv/N+aWg88Xq/3YBAOLHjjeKvsEOyPJ7qOvQJsTwm/
         r41UWIzlQ/5Ax+ha7xRNy8kdIkTNxjA3q1QX8n9bXAh3z/8wB6GEn84UnvlT4jKe1qmu
         sQyc9OGXZjTePH+r4Y6e6ozh0UMlJ+VYjsnu2YRncxwQaVJ+Cf7Nqth6cXAsabwTRyMX
         v6eeeBBdHDjqYX6OiT4X4zQkg5l42dCb/DNQDsMWC1atimcSE8JSmejQfjKp+N8Ip6uu
         zd2ZsR9jcfUX1/JB5xCLWPO6fdSMIACYocvg6A/MPAxkpU5nLiRN3WCB2A8Uz52//cN+
         kz+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682969329; x=1685561329;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qTcYn70jypAxoGiZWNhXW/f3wJ7PRfT+UBBqvcdtR7Y=;
        b=Bnse+PlEMaZR9cl4f+ekc5zb8ZiATTDmUntJ/2UxEC5Y76O5cjFI3UoKL153W/QDa5
         +crFhEgHsGL77n8Ve20zSKOhdpI7emaxiG6NnQZYFrFQ46aXcukA8axCqwzXwe+ahM/2
         FhhXZ9CUe3UawkzpwDvH18JCx8x7WMgeR//XdPAfKRXGbnf2GyxZuI0U+X2+JphHzLPl
         NpOmnXLAEdmQJJvS1D36ev4zWx9WZvSE0b62csRcz03ok8zbPaO+92ZkTfgSPnTRJDhZ
         EAo1Ilf/BuP0obokv2rB0rQcaBezEHt9yeRQAnugbEi9vA4+3i9Jt5ioJmXRtetOagRB
         ydvg==
X-Gm-Message-State: AC+VfDzxKghn3GccfoqOtbD4WdfhUACvlRLX7q5PFDqbHQvAM0iow5qz
	EdCtY8u806A4kU/WmKPU63U=
X-Google-Smtp-Source: ACHHUZ6RkKtjORSVVTbvqSb/nEXqQaQ9JTIasvSEW6m9mcivHjmudekwdvS8zsaYUeAaqoCEzf8v6w==
X-Received: by 2002:a17:903:24c:b0:1a6:4a64:4d27 with SMTP id j12-20020a170903024c00b001a64a644d27mr17386318plh.40.1682969329458;
        Mon, 01 May 2023 12:28:49 -0700 (PDT)
Received: from fedora.hsd1.ca.comcast.net ([2601:644:937f:7f20::9a2c])
        by smtp.googlemail.com with ESMTPSA id u8-20020a170902bf4800b0019c13d032d8sm18175622pls.253.2023.05.01.12.28.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 May 2023 12:28:49 -0700 (PDT)
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
Subject: [PATCH v2 11/34] mm: Convert pmd_ptlock_free() to use ptdescs
Date: Mon,  1 May 2023 12:28:06 -0700
Message-Id: <20230501192829.17086-12-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230501192829.17086-1-vishal.moola@gmail.com>
References: <20230501192829.17086-1-vishal.moola@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230501_122851_432259_B50BC113 
X-CRM114-Status: UNSURE (   9.59  )
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
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index bbd44f43e375..a2a1bca84ada 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2911,12 +2911,12 @@ static inline bool pmd_ptlock_init(struct ptdesc *ptdesc)
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
@@ -2929,7 +2929,7 @@ static inline spinlock_t *pmd_lockptr(struct mm_struct *mm, pmd_t *pmd)
 }
 
 static inline bool pmd_ptlock_init(struct ptdesc *ptdesc) { return true; }
-static inline void pmd_ptlock_free(struct page *page) {}
+static inline void pmd_ptlock_free(struct ptdesc *ptdesc) {}
 
 #define pmd_huge_pte(mm, pmd) ((mm)->pmd_huge_pte)
 
@@ -2953,7 +2953,7 @@ static inline bool pgtable_pmd_page_ctor(struct page *page)
 
 static inline void pgtable_pmd_page_dtor(struct page *page)
 {
-	pmd_ptlock_free(page);
+	pmd_ptlock_free(page_ptdesc(page));
 	__ClearPageTable(page);
 	dec_lruvec_page_state(page, NR_PAGETABLE);
 }
-- 
2.39.2


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
