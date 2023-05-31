Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1E68C7EE23
	for <linux-um@archiver.kernel.org>; Wed, 31 May 2023 22:43:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Jz7RZYjisk72BzrTCgzMnXV7jVdDemdBGf42shmdntM=; b=dZLE829AOZyo+V
	7NtSRSzscuFNj2tCAV9sgaZnspd5Zr73ln7Vbm4Lulz0d4i7dm08FLzKnwkuR+uMNXj41XjW9K6Dw
	l2GE8GFGqjT7bxirvJlb67uoYOvfeolRcBPp7LmAL2yR86il9P73X0izyQWgq6gmGW0u6Vx4WbcW+
	NwrOF1fNtxOsjKln+wrUoQ4U2oSAUZEUjSv0ONAiNuIw7E+q/sdMzJ0a1c+aJQRsw3PcE1MIoRl+1
	cdenHGIkSPuG9DIAPv+jZ64Np1nAADYUdU/kmbFhA9wPVlShrTV3SWiSLcL1T1KRMn8blEvNEy8uk
	JSQM3UkWru90L2Uuk16g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q4UXJ-001MSg-0S;
	Wed, 31 May 2023 22:43:21 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q4UWe-001LzK-2c;
	Wed, 31 May 2023 22:42:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=M8eY/8E6JF8s/V5NNW8TZkaDOnTKuaiqrBMcG8UrW5A=; b=InzSuqZ43yeTcDwChq2k21D3rI
	/AuKgTQ6G5ghHsffLpY+scql4QNaLPdRtxo6PMyk6Spodi2tOCWIseYvQxUabY5ylby4oEo+bBSos
	mQOMgAJNOkuD+pNSfDW6jCroeOJGUKQ17RQm2/CLQpxfEEJag7JeHxOpDLhlOJJmheSKQyZnNh6IU
	wcBBACZH0qQVzfkwC+YXs/Lr6cFaeNa7Jc4Ylya+ecWgFVw6iXIwcPqCj8Bwe99GdnjKffRW3Dupe
	GgobTVYv0EZi1ir9X0k2K5tNpWiLHdqd9NTeAlLjnhV0qBc0/o6Fz2D8qm2OTjlxlNHvxQ/waI9D6
	Z7QBzHUg==;
Received: from mail-yw1-x1134.google.com ([2607:f8b0:4864:20::1134])
	by desiato.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q4TPm-00FdKh-1S;
	Wed, 31 May 2023 21:31:43 +0000
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-565aa2cc428so858687b3.1;
        Wed, 31 May 2023 14:31:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685568687; x=1688160687;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M8eY/8E6JF8s/V5NNW8TZkaDOnTKuaiqrBMcG8UrW5A=;
        b=F74YoiyArmyQwVgOOUW2kfK/7YQSeytT5Qdq4W7jztqrHFW+OxsR62y2z0sZiEV/Pj
         CHUjkMgQ+tHkrFh4S6EPBTtuP0+8wu5BQZyij+e15SnoNrkShPqGZvWdjF5BKJMv2Qv9
         d//2kHJUZF8y/wk4PqE5bOyyg7AT91rLlQi2SzidEtRHvmTf0yi6wamtogBgC9EY9N9P
         uw5EAPHRhzcCUSce1FYm7EE8CHhgk2SNgdWG+thFtb+Fd9K9ZtkE1HL6Lqu8zbrIjBxa
         OBo4gwjzqO/AwYTPpiaC4MdC5Mq0f0RkoLNLDnNUh3I4ll9vsxHX0eJNI6QQ67EeV90U
         TdMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685568687; x=1688160687;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M8eY/8E6JF8s/V5NNW8TZkaDOnTKuaiqrBMcG8UrW5A=;
        b=j83MDMEqA6zFYC+smOI6X+o3rxqbP3arUi5dmcUGvgTIGUDhejJg7CAaIpJn956BvW
         CmW2SlRhIQXPzu6y1ripJivt+vev8RFis++IoYeHkX1MQlQaqRuCHzeplJE1Ongxp7wh
         Qyi8bLRs4Q7Y0eoEOH9gHBKx7Y43/5sJjGlJKIQjxYvb2xUADa3o9cyralbJjE4lrBDk
         BnlCAgi0zKmqw77lkjFyqvIH7NmRvxRrrTuLrRc1E3lDOuxm38e3KxSG/mvMxz5v7YT8
         MNEm1pVcf4vdRkn3u9+2yN7Fmfs6CAcqBem1Yd9AflpvnvfFtkcwaz41Erb31E26L1fc
         1iaQ==
X-Gm-Message-State: AC+VfDwy9y1SwHiPs0HHeT/VpMK2JULQEGOfdNCRtlTtsM+pfqiylg2e
	YSgGdtHcpl7SKXBGxV8exGCCfG62Af070w==
X-Google-Smtp-Source: ACHHUZ7+UFYbIzpavTgJ7f/w4fvGAPRL0PNa3hATkUDplqTdJkdO52BS/n5X3DMJ5Uv/pNitevHZ/Q==
X-Received: by 2002:a0d:dd92:0:b0:568:be91:c2c0 with SMTP id g140-20020a0ddd92000000b00568be91c2c0mr6597562ywe.6.1685568687247;
        Wed, 31 May 2023 14:31:27 -0700 (PDT)
Received: from unknowna0e70b2ca394.attlocal.net ([2600:1700:2f7d:1800::46])
        by smtp.googlemail.com with ESMTPSA id t63-20020a0dd142000000b0055aafcef659sm658905ywd.5.2023.05.31.14.31.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 May 2023 14:31:26 -0700 (PDT)
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
Subject: [PATCH v3 09/34] mm: Convert pmd_ptlock_init() to use ptdescs
Date: Wed, 31 May 2023 14:30:07 -0700
Message-Id: <20230531213032.25338-10-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230531213032.25338-1-vishal.moola@gmail.com>
References: <20230531213032.25338-1-vishal.moola@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230531_223133_153707_CD62FFFC 
X-CRM114-Status: GOOD (  10.93  )
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
index 6f7263fcd821..8e63e60c399c 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2923,12 +2923,12 @@ static inline spinlock_t *pmd_lockptr(struct mm_struct *mm, pmd_t *pmd)
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
@@ -2948,7 +2948,7 @@ static inline spinlock_t *pmd_lockptr(struct mm_struct *mm, pmd_t *pmd)
 	return &mm->page_table_lock;
 }
 
-static inline bool pmd_ptlock_init(struct page *page) { return true; }
+static inline bool pmd_ptlock_init(struct ptdesc *ptdesc) { return true; }
 static inline void pmd_ptlock_free(struct page *page) {}
 
 #define pmd_huge_pte(mm, pmd) ((mm)->pmd_huge_pte)
@@ -2964,7 +2964,7 @@ static inline spinlock_t *pmd_lock(struct mm_struct *mm, pmd_t *pmd)
 
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
