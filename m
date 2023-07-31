Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09137C05051
	for <linux-um@archiver.kernel.org>; Mon, 31 Jul 2023 17:06:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=JNYwqoPKmnANg1g3mv+/KS7jJ6cpWBp7YAq7SifBTXE=; b=J2b+TBW1xQuioe
	+Y4DZU8RHkb42lSsLgKSZmy+djueKuWyCb3qcBPvNxtxKv/ZlGUCukw6LOHmrgXyossxBGeKPFedu
	1wPj2anVOVRBdEWxtsP9btdiS/WLurfgjuWqCZTq/rzOC748guRSI5kr/wSZcxKV02uws4d5XQ/pj
	yYUZ+n3buN+EHAyhT96w7gKam1YjD7DvQ7wMqsJ1L4MgZ6VDm0flTAb94KZPvtYvz1Fw3aXKGJfte
	ughUs0qX6hsO1ZfOZKhjN6m6NNC4ul3n3+xQx8t2ccgz73uA+L1FC4HsWK3YVuDWO7rTtYPngak/o
	lJj36NiFVzKRr1T/nsqA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qQWLs-00GmGE-1c;
	Mon, 31 Jul 2023 17:06:36 +0000
Received: from mail-yb1-xb29.google.com ([2607:f8b0:4864:20::b29])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qQWJU-00GkK2-3C;
	Mon, 31 Jul 2023 17:04:10 +0000
Received: by mail-yb1-xb29.google.com with SMTP id 3f1490d57ef6-d09ba80fbcaso4920648276.2;
        Mon, 31 Jul 2023 10:04:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690823048; x=1691427848;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hoPDwBR7UkDBRqaPTC6ObTEe9OrRslO4Jma44jkeaBI=;
        b=OAbNNQBEQXMPsZxDdWqbwpvcbcC9brAkDdGEYZZSxmgS9fU/KaG8Vdw1eojjPxifHR
         dAgpTgfKnNikXik7mZu8QxravKkUxiIYGVER2PrkOqRriotSLF3T4LElpBmapph98PeJ
         CgANJas/sYwEcas//U7Qxkrb0B57mEkHjJFVkSuOLhuhDwIKccn09v9YrEs6kDdqLy4T
         Ieqhh+PAHMUzo7yeR/3qM+URoXymEQxqZDFSNR+LNsEWiMnR0aGkUyMFjyNfNubh1n44
         qou+GBpn9D5SWlHqMqT15mOyIOurWshKH34ovdJcmzrKIbB8XOImOByAI5BjQB0TmzE9
         Sl9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690823048; x=1691427848;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hoPDwBR7UkDBRqaPTC6ObTEe9OrRslO4Jma44jkeaBI=;
        b=ffbps5vQBpgewQfRnjqnlEWiGvvzMnzsE6leFn06diXz79T/86KHW0sfH2lwDX0M1K
         76Lo9wlsSG8BPotk7cf3jAjq7lEybnpzSv/HIDJyNmMn/wvtPEFfeb1g0eooSw01aZFX
         C0EMjSdZ0Q9I5Os+i/B2Ncw6/6j166jSt8xRKcVZu35A4uC+S76fiURzrJrN/sKdulq5
         V3Kpc/ysveQHUnmd31sXhc+8k+S1igZ1OzhLABNph+f098EVuhra8UeZtKm5nJIEQrfZ
         0JmtlkMvZXaRqovDsU59MgqYDKi06rwK+XKwTWYE/Q/kgY/uHsvhkRrIriXQdwlJnZVg
         cCoA==
X-Gm-Message-State: ABy/qLbJqSk6zad/pv8bIcLzgkcNqB8ubn8rOs7X7ESP7HKTzo6dvUox
	3brJJk8OjpFH7Mi/AGwhBlk=
X-Google-Smtp-Source: APBJJlFKcIKM/utvbiiE7uhCLg+4EyOcJ7OdfVdmr1i+MWfEQcViSbVO+c8ELmOI+htD8mvz1eRjLA==
X-Received: by 2002:a25:f626:0:b0:d10:d237:b03d with SMTP id t38-20020a25f626000000b00d10d237b03dmr9909607ybd.53.1690823048043;
        Mon, 31 Jul 2023 10:04:08 -0700 (PDT)
Received: from unknowna0e70b2ca394.attlocal.net ([2600:1700:2f7d:1800::16])
        by smtp.googlemail.com with ESMTPSA id x31-20020a25ac9f000000b00c832ad2e2eesm2511833ybi.60.2023.07.31.10.04.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jul 2023 10:04:07 -0700 (PDT)
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
Subject: [PATCH mm-unstable v8 15/31] mm: Remove page table members from struct page
Date: Mon, 31 Jul 2023 10:03:16 -0700
Message-Id: <20230731170332.69404-16-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230731170332.69404-1-vishal.moola@gmail.com>
References: <20230731170332.69404-1-vishal.moola@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230731_100409_063529_A0A22BAB 
X-CRM114-Status: GOOD (  10.94  )
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

The page table members are now split out into their own ptdesc struct.
Remove them from struct page.

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>
---
 include/linux/mm_types.h | 18 ------------------
 include/linux/pgtable.h  |  3 ---
 2 files changed, 21 deletions(-)

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index da538ff68953..aae6af098031 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -141,24 +141,6 @@ struct page {
 		struct {	/* Tail pages of compound page */
 			unsigned long compound_head;	/* Bit zero is set */
 		};
-		struct {	/* Page table pages */
-			unsigned long _pt_pad_1;	/* compound_head */
-			pgtable_t pmd_huge_pte; /* protected by page->ptl */
-			/*
-			 * A PTE page table page might be freed by use of
-			 * rcu_head: which overlays those two fields above.
-			 */
-			unsigned long _pt_pad_2;	/* mapping */
-			union {
-				struct mm_struct *pt_mm; /* x86 pgds only */
-				atomic_t pt_frag_refcount; /* powerpc */
-			};
-#if ALLOC_SPLIT_PTLOCKS
-			spinlock_t *ptl;
-#else
-			spinlock_t ptl;
-#endif
-		};
 		struct {	/* ZONE_DEVICE pages */
 			/** @pgmap: Points to the hosting device page map. */
 			struct dev_pagemap *pgmap;
diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index 250fdeba68f3..1a984c300d45 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -1051,10 +1051,7 @@ struct ptdesc {
 TABLE_MATCH(flags, __page_flags);
 TABLE_MATCH(compound_head, pt_list);
 TABLE_MATCH(compound_head, _pt_pad_1);
-TABLE_MATCH(pmd_huge_pte, pmd_huge_pte);
 TABLE_MATCH(mapping, __page_mapping);
-TABLE_MATCH(pt_mm, pt_mm);
-TABLE_MATCH(ptl, ptl);
 TABLE_MATCH(rcu_head, pt_rcu_head);
 TABLE_MATCH(page_type, __page_type);
 TABLE_MATCH(_refcount, _refcount);
-- 
2.40.1


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
