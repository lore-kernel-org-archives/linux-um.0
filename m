Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E323C7EE2F
	for <linux-um@archiver.kernel.org>; Mon, 12 Jun 2023 21:06:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=IsCBHcXTnR0yTQ3JEp6W1X0AUMnorS2lSwPM2Vi3E1k=; b=kGCb6Ykcet4H1T
	DJX/N+eeT6uw/umvn/7EMHC3R8Xy8X7F5kINvbgsq7adq54DOq7dxgWLTaZaDo1rEzybeOrGi9jzH
	Ccdza5KT9I4eAXeFg2WGztvyIEafOtM/6O0jdY211SF8b/p5ttXrqe6ldOJWOCO4WZii5v1jKRfUS
	dYHmTIL4zRs3pB1DosIP5BfGa3L/7jQ+R/j1dL2aenYvv0sUTJLsVX4v5qGhsH3znrjr37InIdkFB
	nY5y54Zlv0C8D/0X7WoCeCIWW7j4+M/CZF1mWdBfE8f3ubuKzZmlawCy+0nyCWP7BfP91ks2MvHMP
	H4o0a8HKfCG+DkQOkfRg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q8ok2-005Ob2-09;
	Mon, 12 Jun 2023 21:06:22 +0000
Received: from mail-yw1-x1129.google.com ([2607:f8b0:4864:20::1129])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q8oj6-005NQq-0B;
	Mon, 12 Jun 2023 21:05:26 +0000
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-561b7729a12so85790897b3.1;
        Mon, 12 Jun 2023 14:05:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686603923; x=1689195923;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9BBSMNk3/NV9IPbcmTeXVmuDxVjvV9nk5pHOLLkR9Zc=;
        b=B5eteOvH/q+5UxTkqPiKmSRGXAjb4bZMizLs/WNtLaesb1E0HpRn4up+92FQaO/msD
         wl+HgJ9chyyZgdROsDvWF8ST2c98XDyJ6K5mIkqjJX4+EdwGnn3FI4jGMxc7JXWmf967
         aU1KzzzuV6U5c/qEMroqPTw1zV9aDblRqBawPVlpf/Mlyp6BjBb5H05VxOKBrkeVjlqN
         FunX9lODEGlrIj4hvPqV1OUn4lS2vKzFGXO/PdJAy/LDMA65UwEZCw3NLCYo8+J5kL9P
         iG2KwFG+0fA0Z25/Erx4n5fssjHvgoAeU/1R/dnILNKDOgbuGKGvMNK5K7M37Fiw/tnm
         j5mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686603923; x=1689195923;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9BBSMNk3/NV9IPbcmTeXVmuDxVjvV9nk5pHOLLkR9Zc=;
        b=VthcbXSw0/PHzNpelXTPnxphWxntMgMiEF7PJSvSMw0oJVUeg9P/+RLGka2VMEaDKm
         wuOgQYoX3IKNM+t5YhEbQHBKwKLBfL8fH1bMTLK1XcI3m+rjkgt+xSAz2AW7eSJS3AKZ
         snWSyB6sSm2DN4MU7LGVR2qlLuhOXj2ZHBcTNMrGDicaOjk1Xkhh3/HKpe10sC2AuNts
         tZ9Uyem1lnlvPSRCCmm+kGhiAxtcpiN/LLM1w6fCVGgtEfYLKloIJVhKSL94vj0509wu
         Tp19EmMGgzhwtvoX0p0/EnsH+E3iqDUcHKDyE8yf6tB/T8kbOri5UbmDkF/AOzIsZRb0
         rGCg==
X-Gm-Message-State: AC+VfDygKGKpOJKfZ8k92X5Giv42EdtaQuh4IFep3aHdSEVdVBbXBGD5
	OV2VA6ixClVz0O3gPYjM/Ao=
X-Google-Smtp-Source: ACHHUZ6Y5hnmbR0E296qiytbEPqdIHR5totNZCgnfGVo00JLi96ohBBFsqGnqpvBKL1saABj0PHBjA==
X-Received: by 2002:a81:8495:0:b0:56d:c8d:be26 with SMTP id u143-20020a818495000000b0056d0c8dbe26mr5358308ywf.26.1686603922720;
        Mon, 12 Jun 2023 14:05:22 -0700 (PDT)
Received: from unknowna0e70b2ca394.attlocal.net ([2600:1700:2f7d:1800::16])
        by smtp.googlemail.com with ESMTPSA id s125-20020a817783000000b00569eb609458sm2757115ywc.81.2023.06.12.14.05.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 14:05:22 -0700 (PDT)
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
	"Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [PATCH v4 18/34] mm: Remove page table members from struct page
Date: Mon, 12 Jun 2023 14:04:07 -0700
Message-Id: <20230612210423.18611-19-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230612210423.18611-1-vishal.moola@gmail.com>
References: <20230612210423.18611-1-vishal.moola@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230612_140524_139543_ED95E0E4 
X-CRM114-Status: UNSURE (   9.95  )
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

The page table members are now split out into their own ptdesc struct.
Remove them from struct page.

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
---
 include/linux/mm_types.h | 14 --------------
 include/linux/pgtable.h  |  3 ---
 2 files changed, 17 deletions(-)

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 6161fe1ae5b8..31ffa1be21d0 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -141,20 +141,6 @@ struct page {
 		struct {	/* Tail pages of compound page */
 			unsigned long compound_head;	/* Bit zero is set */
 		};
-		struct {	/* Page table pages */
-			unsigned long _pt_pad_1;	/* compound_head */
-			pgtable_t pmd_huge_pte; /* protected by page->ptl */
-			unsigned long _pt_s390_gaddr;	/* mapping */
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
index c405f74d3875..33cc19d752b3 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -1019,10 +1019,7 @@ struct ptdesc {
 TABLE_MATCH(flags, __page_flags);
 TABLE_MATCH(compound_head, pt_list);
 TABLE_MATCH(compound_head, _pt_pad_1);
-TABLE_MATCH(pmd_huge_pte, pmd_huge_pte);
 TABLE_MATCH(mapping, _pt_s390_gaddr);
-TABLE_MATCH(pt_mm, pt_mm);
-TABLE_MATCH(ptl, ptl);
 #undef TABLE_MATCH
 static_assert(sizeof(struct ptdesc) <= sizeof(struct page));
 
-- 
2.40.1


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
