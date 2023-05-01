Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56116C77B7C
	for <linux-um@archiver.kernel.org>; Mon,  1 May 2023 20:40:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=e5ISSTSwvU4G+xAQY7fzCRu688hjVcFlk3MbbwvUGSo=; b=n7Sy/hMkb7Q+FL
	gu61xBjc5cdp/8noyLcu6uJeUivjlfMM7C9H48aJAZA8kSoOyxKcMrWeaKKKBWUbdyH6u5fvdlN/S
	gi3j81nlkmNI/WfvNURTTQEk/kXAodTAcjoH4m7JcVVGD51GcIsJ+QMW7L7IMbEPiaQCY4AtVXMEe
	lInjTPmaM1xFuh1atarBXAx2PE92yXxmWmOJVVOn0U0Ja8RreeDmYTkSNR+O3zSztr+vbit4vwxtI
	j3nqb5E5wLLIyl7WCeGRCeaHRywdS56Blqeij0FW6mLUgnYVzyFkYiI1WfEslL5It9Y9TjoRUBipH
	lyovGk67MyRitEAbYzCg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1ptaKI-00GuKD-3C;
	Mon, 01 May 2023 20:40:50 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1ptaKF-00GuFs-08;
	Mon, 01 May 2023 20:40:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=0Ii9PvRdhTMRqBop+JFdKAWa6G/XpZkmB9p8iHmrwUc=; b=VG+kBKRU6nvFBJAyKgfzr8W6uQ
	2urHjna6HlpE5Lt9JZrSfa2qGSfQEB2djne2U69TKNJLHBQZ/Ko5jm5CuzSVv6o9ID1Ho6Y3Y7Z1S
	HMtGqx61JAhCFsWScMEIMGX6Umg10FsXpkKyKhEw4YfEswBvgIw5bBPwXmCUsJHGLVzFHYuqVSXL2
	kDzxwUNYy+1DpBalr7FkFhABmiz9+MgEcHMoBTgMI7lLNe5X5EBEEnJtRReS6A2YabhyoDD6ZsEnV
	/Ux3ooXuD/Gre+RA/S9OYkLoLFfebkr9vXRxnbSeVoPE6bka7YbHGcibPCTwJ0Inp0dbukQbNYwoH
	QfYNOJig==;
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
	by desiato.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1ptZCX-00Eyyx-2B;
	Mon, 01 May 2023 19:28:47 +0000
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1a516fb6523so28445025ad.3;
        Mon, 01 May 2023 12:28:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682969323; x=1685561323;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0Ii9PvRdhTMRqBop+JFdKAWa6G/XpZkmB9p8iHmrwUc=;
        b=lFLswDg0HvrPkF+dtbJhg/asaCBgi3e00w4opfv2mri4GHWG5ahGHxm9sLAnqC4qbq
         cQ+9MPTjwHhlk51h4w8lOE5zFHDICMVPmNnmwWW2l0krumAZ2PDeWC1WEjJOX3LShLcV
         g0uvqMJBbig8RslrcZc6EAJCiGxazADIIfKt9bAt8yGDMo+5nIH4mdhXs+LaHQV1OVik
         U1EjmbMLOLA/7Pwt5TKTUK+w95+W73jVDYdL+HuxsLXipLy8KET4HB50FeUWTlZzXbc3
         qFSctTNSvV8Q7v0NapgoBkUZ/cCAkZoFPz8ver9uL6iYj4+bfmoOnnABcA11qHjnQcrq
         /yHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682969323; x=1685561323;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0Ii9PvRdhTMRqBop+JFdKAWa6G/XpZkmB9p8iHmrwUc=;
        b=TK9vVWd1o2TSoLjaXxU/UoJ7BSnGUCnLjqp8f79++ooKSdtPI/OS4aZRjpC9njxk81
         TDTc1s34PZU6uUFhh7MJgiS+JQ23QgYEqFMyZijPOFRXOYr6h0NVA6fwmjB+ueeFGvZw
         IAvma2KUEs/PVfoxHghzuilm0AAUvS9B+2Zx4CzjeH+KhCsgVxhKeRfJ0FxgyCHQ9oz4
         OqwzW5svf5/KXG5uvLLwctMEWtE63jVCNRikRUzCGVjO4k/w10HdYsWta4zc4D42AMaV
         8Q1HQnI1Sbg2nkYSJ+elb+9rZVASI1HnZPSburcnAOy+7hImVGiP3e3Xo17TI89L5upC
         i0Nw==
X-Gm-Message-State: AC+VfDziDAlp9E6X60+8jeFGeH9DqhNMTX7LN7L8xXPj44TLzeLEG3Yq
	qDKz65P8vjfFS6Dp8FSf7/w=
X-Google-Smtp-Source: ACHHUZ4gWlsAH/48zhDdvicQeallszzZORdrHEFL4BiABQ6zj3x4/LHvqIQGrX0uRjqorCk+ulIxBg==
X-Received: by 2002:a17:902:e805:b0:1aa:f6c3:ba24 with SMTP id u5-20020a170902e80500b001aaf6c3ba24mr5259994plg.4.1682969322807;
        Mon, 01 May 2023 12:28:42 -0700 (PDT)
Received: from fedora.hsd1.ca.comcast.net ([2601:644:937f:7f20::9a2c])
        by smtp.googlemail.com with ESMTPSA id u8-20020a170902bf4800b0019c13d032d8sm18175622pls.253.2023.05.01.12.28.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 May 2023 12:28:42 -0700 (PDT)
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
Subject: [PATCH v2 06/34] mm: Convert pmd_pgtable_page() to pmd_ptdesc()
Date: Mon,  1 May 2023 12:28:01 -0700
Message-Id: <20230501192829.17086-7-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230501192829.17086-1-vishal.moola@gmail.com>
References: <20230501192829.17086-1-vishal.moola@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230501_202846_089533_FC148852 
X-CRM114-Status: UNSURE (   9.50  )
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

Converts pmd_pgtable_page() to pmd_ptdesc() and all its callers. This
removes some direct accesses to struct page, working towards splitting
out struct ptdesc from struct page.

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
---
 include/linux/mm.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 258f3b730359..62c1635a9d44 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2892,15 +2892,15 @@ static inline void pgtable_pte_page_dtor(struct page *page)
 
 #if USE_SPLIT_PMD_PTLOCKS
 
-static inline struct page *pmd_pgtable_page(pmd_t *pmd)
+static inline struct ptdesc *pmd_ptdesc(pmd_t *pmd)
 {
 	unsigned long mask = ~(PTRS_PER_PMD * sizeof(pmd_t) - 1);
-	return virt_to_page((void *)((unsigned long) pmd & mask));
+	return virt_to_ptdesc((void *)((unsigned long) pmd & mask));
 }
 
 static inline spinlock_t *pmd_lockptr(struct mm_struct *mm, pmd_t *pmd)
 {
-	return ptlock_ptr(pmd_pgtable_page(pmd));
+	return ptlock_ptr(ptdesc_page(pmd_ptdesc(pmd)));
 }
 
 static inline bool pmd_ptlock_init(struct page *page)
@@ -2919,7 +2919,7 @@ static inline void pmd_ptlock_free(struct page *page)
 	ptlock_free(page);
 }
 
-#define pmd_huge_pte(mm, pmd) (pmd_pgtable_page(pmd)->pmd_huge_pte)
+#define pmd_huge_pte(mm, pmd) (pmd_ptdesc(pmd)->pmd_huge_pte)
 
 #else
 
-- 
2.39.2


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
