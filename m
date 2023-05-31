Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA914C7EE23
	for <linux-um@archiver.kernel.org>; Wed, 31 May 2023 22:43:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=k7u75PQDYm+mBiWOQ4VQcE5oIDI0VdxsUZzvGFdW2DI=; b=X5/8Wi0c6GKe+/
	QZt7JbqwAeg2O96f/2I56Wt0Asefzm5BlJWTOVnQrOVBkw/0zxctqtpC4Q7wJ3d4lvCCMAIQKT4CD
	fkOP1lWI0uBW6f/+lJivLHSe0czl0Eu351MMAblkqbpWfOfDdT0H2qYOQd22Vyf0mMJrZXHmMo9dZ
	2+dakaBi1uv/zy9Hmsu/2VNbZeou93fEl8QKp863t7dj14ds646Phkx7xQbO5dIt4Fk83a0JhlyxG
	3Kq9IOgq8Ihoh2PZLFHu0o3kCzog1t+T4Pd5mgMiTxQlXBTCebP4IqsJjnYSzmOWW7L5QLQcnrMSv
	KRp2raU/mrwa7me9Aqug==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q4UXV-001Mc9-0S;
	Wed, 31 May 2023 22:43:33 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q4UWk-001M27-1l;
	Wed, 31 May 2023 22:42:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=xowfOyB08CJw8MKGIIgRKSCkyhh2uF8MvUFj9KXpTSw=; b=SaI5OznizU0hUVFJ2eZcJKuCOc
	MxhK2O4qVEebABiZZv4vhmX2ESuWaU/IqqmrPVTeSYQDrG+2eaYb9LehGXuJJ2QQDnfwI/zYoD7TK
	r4/ThEGIYolMz60w1ageK1r4CPwmp1ulWq7+kaVOlmAExyHfE+334QW4TNAMZmTZpdTj+1Q0eh1Fs
	TIPoqnhXckCsKcR9+B7aZBxoOI1yILzyCbk7UHSXxkIrGSzQpna/Mng0n6lM/T1cqDP9Eo0dXsQs4
	X1R1dEWDPkEibtvcxwlboibjCPtbE9m/9WMJX7ajHb04VmfDb7KPG9J5LKs7P9itjCB0RFXYcFQma
	8pf05niA==;
Received: from mail-yw1-x112d.google.com ([2607:f8b0:4864:20::112d])
	by desiato.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q4TPp-00FdKp-29;
	Wed, 31 May 2023 21:31:43 +0000
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-565e6beb7aaso736047b3.2;
        Wed, 31 May 2023 14:31:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685568689; x=1688160689;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xowfOyB08CJw8MKGIIgRKSCkyhh2uF8MvUFj9KXpTSw=;
        b=L8ygLqSRY2eqB8nseiiMf24A2f/spwq3tiGOrBuR5p7dj9EWG9ImFwe46ZZwXRtvRX
         /V86q8xSGkCuVPlvQOJ2SMa4rsoFmPrmu5autDJLeyd3yfLXEA6bbO2/4Yqm1LlWBfgW
         xJxuutRSGFBvTral/NTreMAMCGbSkBu5TZ5qxdEeFHUTponOUVV1jiviowhgii7tWLBq
         MEHuHS4DCf2z1UfCtRdUmDITSqJKFDRP0C3+jLAFaOsLApRcLJ8PsQ+aNZLN1wbuZUBY
         Px85P6DC+zY+Gwn3bCa+FGLrsmclVsP0ccqay7jLihOMLhj3/zlw+zFLVxYDPwbySfXO
         VKRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685568689; x=1688160689;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xowfOyB08CJw8MKGIIgRKSCkyhh2uF8MvUFj9KXpTSw=;
        b=fms/OsPg3Bl0eCDdrK1QJocfSPW99e8y0u6D1FkDN6ce3ZtkSPsW3OoMYPGavn8gmF
         ev/mbVAaJhJEX+D1FmgCUtsrqgHwiIVtSixhMXF+DWWWuvwWgVx66Q2uUzhmQmyshPRm
         gobj7IKngvsFWddA+/ODCJQ/xol/BV1okIN/2JB6XFrqGRmdcPO4S9gMW2nNLXtasCL7
         AwnbvMHGVNfSr2iY2iCI6a7wUE07OPrG0yci/pb6rYhp2pi5wCyst21IDb7gzG778Y7T
         0XPuKaH8bzX7L5fHzVeqjdlkC/IDRW99E79VXCZKto61ElakOtP46rIKZCVb23AYGfD7
         yINA==
X-Gm-Message-State: AC+VfDyqCiX+fgugO51QlpsG6ba1v9UWi59raB1eQfNuv0rHqOv0/MHZ
	HtC5+1gENOysBRrKAf96Zro=
X-Google-Smtp-Source: ACHHUZ4HC/p6n5oc2YZUDdXfXImpqPK7MSZMtRTu8JGDzMkRUKKOQ8wmCGx7YESYze8Eib1xLonoHg==
X-Received: by 2002:a81:5357:0:b0:561:c5c3:9d79 with SMTP id h84-20020a815357000000b00561c5c39d79mr7593955ywb.45.1685568689113;
        Wed, 31 May 2023 14:31:29 -0700 (PDT)
Received: from unknowna0e70b2ca394.attlocal.net ([2600:1700:2f7d:1800::46])
        by smtp.googlemail.com with ESMTPSA id t63-20020a0dd142000000b0055aafcef659sm658905ywd.5.2023.05.31.14.31.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 May 2023 14:31:28 -0700 (PDT)
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
Subject: [PATCH v3 10/34] mm: Convert ptlock_init() to use ptdescs
Date: Wed, 31 May 2023 14:30:08 -0700
Message-Id: <20230531213032.25338-11-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230531213032.25338-1-vishal.moola@gmail.com>
References: <20230531213032.25338-1-vishal.moola@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230531_223137_021305_AAA1A603 
X-CRM114-Status: GOOD (  10.65  )
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
 include/linux/mm.h | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 8e63e60c399c..bc2f139de4e7 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2838,7 +2838,7 @@ static inline spinlock_t *pte_lockptr(struct mm_struct *mm, pmd_t *pmd)
 	return ptlock_ptr(page_ptdesc(pmd_page(*pmd)));
 }
 
-static inline bool ptlock_init(struct page *page)
+static inline bool ptlock_init(struct ptdesc *ptdesc)
 {
 	/*
 	 * prep_new_page() initialize page->private (and therefore page->ptl)
@@ -2847,10 +2847,10 @@ static inline bool ptlock_init(struct page *page)
 	 * It can happen if arch try to use slab for page table allocation:
 	 * slab code uses page->slab_cache, which share storage with page->ptl.
 	 */
-	VM_BUG_ON_PAGE(*(unsigned long *)&page->ptl, page);
-	if (!ptlock_alloc(page_ptdesc(page)))
+	VM_BUG_ON_PAGE(*(unsigned long *)&ptdesc->ptl, ptdesc_page(ptdesc));
+	if (!ptlock_alloc(ptdesc))
 		return false;
-	spin_lock_init(ptlock_ptr(page_ptdesc(page)));
+	spin_lock_init(ptlock_ptr(ptdesc));
 	return true;
 }
 
@@ -2863,13 +2863,13 @@ static inline spinlock_t *pte_lockptr(struct mm_struct *mm, pmd_t *pmd)
 	return &mm->page_table_lock;
 }
 static inline void ptlock_cache_init(void) {}
-static inline bool ptlock_init(struct page *page) { return true; }
+static inline bool ptlock_init(struct ptdesc *ptdesc) { return true; }
 static inline void ptlock_free(struct page *page) {}
 #endif /* USE_SPLIT_PTE_PTLOCKS */
 
 static inline bool pgtable_pte_page_ctor(struct page *page)
 {
-	if (!ptlock_init(page))
+	if (!ptlock_init(page_ptdesc(page)))
 		return false;
 	__SetPageTable(page);
 	inc_lruvec_page_state(page, NR_PAGETABLE);
@@ -2928,7 +2928,7 @@ static inline bool pmd_ptlock_init(struct ptdesc *ptdesc)
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 	ptdesc->pmd_huge_pte = NULL;
 #endif
-	return ptlock_init(ptdesc_page(ptdesc));
+	return ptlock_init(ptdesc);
 }
 
 static inline void pmd_ptlock_free(struct page *page)
-- 
2.40.1


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
