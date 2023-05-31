Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7A2FC7EE23
	for <linux-um@archiver.kernel.org>; Wed, 31 May 2023 22:45:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=aFoE6u1JfP+uyIhxxlqCx0XcD3x9Q4UGHX9F9VNzrCc=; b=T+h23OpLdJU55G
	iuLMyazqQAcUuk/h2hzHDDIro5MpfhiWeNg3p+/rIG06Hgt8AD0tcj0q9k0eyfvEMRECclS1g07Rw
	lNdmcwlpFvdismyW2EgeiEzHY3HRs0ma0k1tuFebqZmreey+OpLkaM6k3vS7DjZGHPF1lsMuoyjBH
	hJytw5EhXzetie4xZu7/QeX3BEdqZ1aLczDERruRBAyC9gNdFEJALQJLpxgG3QshngZ21xNxtdH94
	u6gCXfbdd63FG/NYuqqQ3E9GGcmcwSsEdLeun6Dr7kI06eecfdCljtHnBNL58fxFf8sAer4LS7R+8
	nQzKB2oYB5GVc91uovWA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q4UZf-001Nve-18;
	Wed, 31 May 2023 22:45:47 +0000
Received: from mail-yw1-x1131.google.com ([2607:f8b0:4864:20::1131])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q4TQ1-001A2P-1G;
	Wed, 31 May 2023 21:31:46 +0000
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-565cdb77b01so924707b3.0;
        Wed, 31 May 2023 14:31:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685568705; x=1688160705;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o9eRM/zDkfdSk+8A/Hewm27be7ojppibpTW/4yMTPrs=;
        b=cEdd+3JqSM8NFS7GIxJNDGEwvf5zLrjyKSP/sMa+M4iyqruEv0NeTXFNM3FuEOve0w
         BIidhyYZPlXr46Gag37ah0Z9lK+/zubpEH8qTvbGBEkRrc++Uy/9vmo7kzodV2wrSQQX
         I30LmfVEDViclfTqhhCm9JCK+j60eB88X4OE4kx5hV9tTa2skQgGrRsYDfbJW0ibMSeL
         XGmJa+8fFqRfTTRXmPxLl8Ng1lVV80Cc71vk49EsIYa6/DzcwK4zi4KQyIaDphcDsbUr
         cdzc/H0c6XAN15Wd27KyDlOf+VJeKUYgNs/w5+avyyLu4TkMCo4jGnCkWr4fOUgF3X5G
         tX9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685568705; x=1688160705;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o9eRM/zDkfdSk+8A/Hewm27be7ojppibpTW/4yMTPrs=;
        b=WhnR2GpUN3kJENnTwIhVntgHomzn5YQIkgedinX1soBNOcpRLWC667eJT8xxHMNcQp
         xpb6yVM4QeKuCzJJ1XcjGvzFwmc275IpoIUbo7FmeTXTNzyRb5OGomC+kr/UB/t3E1YJ
         zrlJji+qkt4pBNSZIyeytN60QYioLKfVFMiarCn45PzVKPAf9vOSg6EYOLPwZop5KCIu
         9M2EIpmR9zjy2XM/78b3sA1cnADRvWk/Df5l24Qx8ujY0GcCh/hqs5N4GI70lM9xvf1f
         sDS86fZ49xpYDmdGULX4y8ODrytj3jWg0l1xPb/7uXKBewsGozzYlMG+LKMBMbt7Fvu4
         JByQ==
X-Gm-Message-State: AC+VfDzRz3guXmRc5RBOxcty9Wlp90UMOGxS9iUvlW0G1HuuZzrEdvd2
	aToTeybEM0t04Wg9IcJQj2c=
X-Google-Smtp-Source: ACHHUZ6qsHeUoao2+s8uy7ftoyOjIWcEzXHhSNjnyPVGfYnJHG4o2q2q2wEf6DyMGhXFqCryp1fDIQ==
X-Received: by 2002:a81:778b:0:b0:565:ee47:5844 with SMTP id s133-20020a81778b000000b00565ee475844mr7319022ywc.38.1685568704868;
        Wed, 31 May 2023 14:31:44 -0700 (PDT)
Received: from unknowna0e70b2ca394.attlocal.net ([2600:1700:2f7d:1800::46])
        by smtp.googlemail.com with ESMTPSA id t63-20020a0dd142000000b0055aafcef659sm658905ywd.5.2023.05.31.14.31.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 May 2023 14:31:44 -0700 (PDT)
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
Subject: [PATCH v3 18/34] mm: Remove page table members from struct page
Date: Wed, 31 May 2023 14:30:16 -0700
Message-Id: <20230531213032.25338-19-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230531213032.25338-1-vishal.moola@gmail.com>
References: <20230531213032.25338-1-vishal.moola@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230531_143145_429854_DA1A271F 
X-CRM114-Status: GOOD (  10.43  )
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
index 5f12622d1521..3b89dd028973 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -1020,10 +1020,7 @@ struct ptdesc {
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
