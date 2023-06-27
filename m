Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB4C9C04A6A
	for <linux-um@archiver.kernel.org>; Tue, 27 Jun 2023 03:16:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=wT8aaeXmY7dsDrDD+hbp3I+qUSVjamspMzhvDOpYUN8=; b=AVo6cDFPbFTqQv
	FIH0dELThHjEnUEJvuroZut2GmjyFy0dNylw/1TvRZSIG/frb08HvZF2bIMP2oxdyzVn9JxCsc25h
	MPAsvpnpkxLxHIFfKAbCHPYvslOfVr4mCgi+rAhb+aEN9cUCOfLMBs8su7hGBp2WJWJRiy0g7+/Vt
	rUoHVHqfWiGjvJ0HsM5QQuuDa6x2n/lwTeLwPYe0I1PpCqCe08+wcc1Hip6WGRhMG7E1EnMkG/thW
	nu5pG+VtiE/H3r7RD31rBn7/fRL8UjsQllpR3OUbnouRBGh390OVxv+e/5jj+U1FQgR2YYIA3kbjs
	xEflYgKnhoBxVAFKoKmQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qDzC1-00BWl8-0r;
	Tue, 27 Jun 2023 03:16:37 +0000
Received: from mail-yw1-x112c.google.com ([2607:f8b0:4864:20::112c])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qDzAr-00BVVs-1n;
	Tue, 27 Jun 2023 03:15:27 +0000
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-5768a7e3adbso46467237b3.0;
        Mon, 26 Jun 2023 20:15:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687835724; x=1690427724;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QwvXTPG+SvX1bm+f7lh9ddV99LBkA8HMSnaL5DvtP/w=;
        b=bw9pNUcuMxpubm9pq3maPyXbc62B+bsuNNloL1m8ijygS8iq7WYtlX4XdEVQIeg/Zh
         Ngyg1Az+rnDUxxJdpkw2Xv9RrFezRnlEtGz+ikp5CpgXDK/wyBh05TsohR9gIqLikIrz
         XQJZpHLygL22WsyZKTUtr35hO5G+O3BbEJWU1trW1sFmIRDgY2iyZUpnQW0acaV8lKSP
         bClQykA4VjSGm4LzvwTtemLaGQIugu/qzT0WXVHTnnvGtI1PeGca+HTzzD6jettWBhDo
         8pn250bIB0NJGxFmMTfFNawkBicAYzNWGl1omwNwRWLI+9cdDNXLQFqbUAr8KIK7W1AA
         kzkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687835724; x=1690427724;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QwvXTPG+SvX1bm+f7lh9ddV99LBkA8HMSnaL5DvtP/w=;
        b=jQTCk/6yh02CzaiiZQfI9xNvDhXCthO/xKwfcOclpS4AAQxj4d/PspLbwqE8cRd5PV
         MQhv1kTSSmP7tOPdOvzNrqAOvdiRETmfT8FA0925Lxu8A2qcmR3OskfGFkkj0Wn3nBYD
         i0EXKWTwA43Vd0Xirm2WJeSy6lBL8kIjn6qh/A14iLS9TngfJqJ6HzKd+0QaE2KTjAv/
         hjkTVFzNEifxxKNPAvUk87Icr8p3QpHDMx7eJW7Lno7o4kbioAjvWgXgAOddIHcPDgkV
         EZhcoaSpV1QsAXHkvUGmz/KJr40ynCHjfPMY7sEHhC3AKKQSh22fj4/8+u6xbLHEyN/E
         09xA==
X-Gm-Message-State: AC+VfDy6CHp8VcnBi2tO080aQhzYfGGWGRoDKBi33EgETyhLYIMeV2/b
	zDnHviTlIiyt9qEmFLKn07o=
X-Google-Smtp-Source: ACHHUZ4U3kYwykXpP1FzDZUmgCkvLtNAT31XIQI7+ns8f+sP4iaCy71EJqjX8aE3VjJuNDesXn/JrA==
X-Received: by 2002:a81:48d0:0:b0:56d:6dd:c1e0 with SMTP id v199-20020a8148d0000000b0056d06ddc1e0mr35914739ywa.21.1687835724632;
        Mon, 26 Jun 2023 20:15:24 -0700 (PDT)
Received: from unknowna0e70b2ca394.attlocal.net ([2600:1700:2f7d:1800::16])
        by smtp.googlemail.com with ESMTPSA id s4-20020a0dd004000000b0057399b3bd26sm1614798ywd.33.2023.06.26.20.15.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jun 2023 20:15:24 -0700 (PDT)
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
Subject: [PATCH v6 08/33] mm: Convert pmd_ptlock_init() to use ptdescs
Date: Mon, 26 Jun 2023 20:14:06 -0700
Message-Id: <20230627031431.29653-9-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230627031431.29653-1-vishal.moola@gmail.com>
References: <20230627031431.29653-1-vishal.moola@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230626_201525_623014_01DBFE62 
X-CRM114-Status: GOOD (  10.62  )
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
index 0b230d5d229a..1c4c6a7b69b3 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2926,12 +2926,12 @@ static inline spinlock_t *pmd_lockptr(struct mm_struct *mm, pmd_t *pmd)
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
@@ -2951,7 +2951,7 @@ static inline spinlock_t *pmd_lockptr(struct mm_struct *mm, pmd_t *pmd)
 	return &mm->page_table_lock;
 }
 
-static inline bool pmd_ptlock_init(struct page *page) { return true; }
+static inline bool pmd_ptlock_init(struct ptdesc *ptdesc) { return true; }
 static inline void pmd_ptlock_free(struct page *page) {}
 
 #define pmd_huge_pte(mm, pmd) ((mm)->pmd_huge_pte)
@@ -2967,7 +2967,7 @@ static inline spinlock_t *pmd_lock(struct mm_struct *mm, pmd_t *pmd)
 
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
