Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87BC1C77B78
	for <linux-um@archiver.kernel.org>; Mon, 17 Apr 2023 22:00:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=tygD8THd18GEA4onlerPV6UVNak0fGgU491bslm764s=; b=Og4wG2W9rK1IJ3
	on7uoCbCsZoaA9nd7txxCnaeVDw10UWjvpiB2Eaq4OPiz1EzdKZfZwI+aKMGhvd1MqzQUTptBmLvy
	h823iK66p2YgRR1ezKahg200eMYg+bIMtpN5CvvlSSqfEpFF1OO5rWRAwQQRCRlhM280NUzs1dnmr
	4hSSyyFXqRx6o/uqtnPFxePEmfRWYrTBpold0YAuQBEywP8KtHYvkJKNBfnZmNChXhj8OL+erH7Gy
	4cRwxhEX2WXJFojE7ViIX+zQ3x/MOfEIjeUoRKGPrAvmpE9J3lEl4HG+9PB2QhAxUPdE9eE1hLDlE
	Yf30i1SNib8+o3zmFv+Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1poWtl-000CN1-0e;
	Mon, 17 Apr 2023 22:00:33 +0000
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1poVvz-00Hb1s-2g;
	Mon, 17 Apr 2023 20:58:49 +0000
Received: by mail-pj1-x1034.google.com with SMTP id cm18-20020a17090afa1200b0024713adf69dso15414956pjb.3;
        Mon, 17 Apr 2023 13:58:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681765126; x=1684357126;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ySUR2NhNYIi45iieMc0XGAHKG7J++HPTQWlVu2Tasao=;
        b=RRr9urI50p9mdiLNmvh5Bc2UvLi7M12LQnVrK1IW2dCP5gh7Q45vBGO6fEuQ+1Qf2i
         9tkk7bz0iZ/KmQzhCP3IXPY5zE8lMYBS3ehqpHTtHlzRfw4RmVVZ8Otiwh/rlgZkoLXD
         4KZ04e5w3y8ASS3u7+fRHUW2FbGqvcC2ewNT6hpayTwJgOCliWhFT53d6zrBsYIU12xG
         OA86sVTZyas44LPOhqg4/KFlTOinOiSK0/SHLqMDKzIPMaAk23m6CMH5Y/CvNPufvYKy
         OTeY/+JOA9SdtlMYpPxldcmGr0N6B5lLoPbPiOncbPMb5muKbsphzIlvxtohQPJW1gUp
         2HnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681765126; x=1684357126;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ySUR2NhNYIi45iieMc0XGAHKG7J++HPTQWlVu2Tasao=;
        b=DT57YPuHKO2vmAuDhLG/JosNYUXT62r6wz/w/JPYgPSBpRoMTaqj5/+Z8vQT7XdJnw
         i10zzneGAVZ2A8lSK5wSHE0szbfM7ZpXjEhsG5wWbK+1e8FZatsHTn//qKZNgjR/i/ae
         mMUXj6hRac7aiah7a7l1G+U8CYDw5Of/iOyVx+myCsvjACAhyvkw6qJt40e9OQ5BN4e3
         qTKKLfg9NPjCj4n8f6sxIaXiC3UErsR9nZXN45pKtDOAkynyk6q3rOqs7fw/IEiwA6F2
         Ehh5KGYCCXs61qwkJLEL2DNiyhrNzjRON4RfOD4MbpGWVChkoQeUbCAwPpkODxuPL2ZP
         WlRw==
X-Gm-Message-State: AAQBX9fXf/FrcUSY+xQwZcz9/68ZDUSO1bwOD7kWE/rX4dvon6a67bHX
	1XZO2Zb/Gfh4vfLyOXoO2lcl3hdPxBfEJg==
X-Google-Smtp-Source: AKy350ZVl3PNdJ0+nN/Rb9LpMw5+uyjbe8u9t4N4aIteNFpQkEwBCpgg7+YRGDc+SZWH4x4d964lpw==
X-Received: by 2002:a17:90a:d205:b0:234:409:9752 with SMTP id o5-20020a17090ad20500b0023404099752mr15223725pju.25.1681764789129;
        Mon, 17 Apr 2023 13:53:09 -0700 (PDT)
Received: from fedora.hsd1.ca.comcast.net ([2601:644:937f:7f20::c139])
        by smtp.googlemail.com with ESMTPSA id h7-20020a17090ac38700b0022335f1dae2sm7609707pjt.22.2023.04.17.13.53.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Apr 2023 13:53:08 -0700 (PDT)
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
Subject: [PATCH 17/33] mm: Remove page table members from struct page
Date: Mon, 17 Apr 2023 13:50:32 -0700
Message-Id: <20230417205048.15870-18-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230417205048.15870-1-vishal.moola@gmail.com>
References: <20230417205048.15870-1-vishal.moola@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230417_135847_872017_50801A63 
X-CRM114-Status: UNSURE (   9.55  )
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
index 2616d64c0e8c..4355f95abc5a 100644
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
index 7cd803aa38eb..8cacdf1fc411 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -91,9 +91,6 @@ TABLE_MATCH(flags, __page_flags);
 TABLE_MATCH(compound_head, pt_list);
 TABLE_MATCH(compound_head, _pt_pad_1);
 TABLE_MATCH(mapping, _pt_s390_gaddr);
-TABLE_MATCH(pmd_huge_pte, pmd_huge_pte);
-TABLE_MATCH(pt_mm, pt_mm);
-TABLE_MATCH(ptl, ptl);
 #undef TABLE_MATCH
 static_assert(sizeof(struct ptdesc) <= sizeof(struct page));
 
-- 
2.39.2


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
