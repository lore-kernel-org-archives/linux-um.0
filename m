Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1374BC001B1
	for <linux-um@archiver.kernel.org>; Thu, 22 Jun 2023 21:00:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=OdHHj9QdbthABICYUBQ/cD/7BSaqwt+ZQ0n6DwGyHsk=; b=WYHrKtE4X4pIJN
	8qxkfCEpiNC2YhC6KMknPKlsHl1MySFXnLelNuj7Nqmn8F6oZIovhGbWxbl+zmWVXDh4n09h7tLgc
	SzMHEu2+356ULyrlw6KOfr4H17pccpEqQI09YF2dEBgINbsrEGntkv70OWCFRNhH0oq4rxLsRDofM
	S0GxRW2bRAB5HsKyRkLnfFpZIOgCP7B/CBxYvntUd4aeoezzSR47J12VOC72YRMlGWgOWo0buJFRw
	0xbr0Mt9puiSHjVWUv+scc+8AxJfOC/LsMq057AZ1Bt62M+y0j7r3GWuSE2Kv2ZNqilj2f2WVmE+r
	LosijwnlN9E/BdKB150A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qCRQ1-001k8Q-1W;
	Thu, 22 Jun 2023 21:00:41 +0000
Received: from mail-qk1-x729.google.com ([2607:f8b0:4864:20::729])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qCRNx-001i0P-0Z;
	Thu, 22 Jun 2023 20:58:35 +0000
Received: by mail-qk1-x729.google.com with SMTP id af79cd13be357-76244657caeso578955385a.0;
        Thu, 22 Jun 2023 13:58:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687467511; x=1690059511;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nccUzLka7Xkr4OuMpYk05u/KaIGQrzDFYQttz/vcmHQ=;
        b=bxkxtD+QQAC8zd161RKeCcg6MaoPAPE7L+CauClsYEL0Xy9+Td62VuxUGsgYxnFiq0
         O6uvJ71cZ3HzaD3sn95/EOTS8BXKpmL+IQrAYm0nHFHW9S+p9vWLuqdK4qFg64CCRbun
         joR+Hl/5hsxihcXKPDNMSOwFhI08HqC+OD8d0u+5w8Qz5HarhFJT9jfwORvF779fEL9V
         zRFvHmiRuYANo66EVjgtR36nI9raB2GVIEDQNVqxyl97sNwtEBiuGHRD00zHWqOmK+wx
         CCZ2jYpmNaAVgCE8uPmkzzzOyp8bu94YHjJqAydk7W1+LKznmMU3DWFCBUl+KliiUs4D
         rLQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687467511; x=1690059511;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nccUzLka7Xkr4OuMpYk05u/KaIGQrzDFYQttz/vcmHQ=;
        b=DIQi1HBUCuoDyq8MwrMvGftlsRTyyuRzoscSVOo4dK+vRGW8kP2CsBcLg6W0V8myxX
         Afq2KepyRZoWJ2/VVhshQ6dZA4JXs0sHC6LQZE1TiNLIElZAyw+xxOgQxOT+Wnh8r5/x
         itapA01/iaAxBXKTlKm8ysYXmo1UbGmMpaZXyyVgVQantAIqSfMKig2040vLacJYidBV
         5S1nkV3KXvbkJRaUbJM7w88vk7j5/qDeuzu8eRkbONo77P9uLCShYZ4BozOX+jvK/XlI
         OxQ90o+1+E7e7r5WDbRmw75GmpSbm4rbYGRF1PDxTy2Imqq94M3C/i8XXHB3cRLszAKp
         VpDQ==
X-Gm-Message-State: AC+VfDybbTKyJyBn87Jc+1bRwagph23gJGwaZPzOqNp1jtGdQIgKcede
	/GyjDDIpwIaw7UYBdUdHbD8=
X-Google-Smtp-Source: ACHHUZ4ad8Rj1cEO907Psdq+ajLgAiK0FYJ6eHB9wwgKt19FWwArd1FWX8Y4TNXwZH2eE/VH/YBYiA==
X-Received: by 2002:a05:620a:4790:b0:765:41c1:31eb with SMTP id dt16-20020a05620a479000b0076541c131ebmr1410020qkb.48.1687467511080;
        Thu, 22 Jun 2023 13:58:31 -0700 (PDT)
Received: from unknowna0e70b2ca394.attlocal.net ([2600:1700:2f7d:1800::36])
        by smtp.googlemail.com with ESMTPSA id d18-20020a5b0c52000000b00bc501a1b062sm1684937ybr.42.2023.06.22.13.58.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jun 2023 13:58:30 -0700 (PDT)
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
Subject: [PATCH v5 17/33] mm: Remove page table members from struct page
Date: Thu, 22 Jun 2023 13:57:29 -0700
Message-Id: <20230622205745.79707-18-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230622205745.79707-1-vishal.moola@gmail.com>
References: <20230622205745.79707-1-vishal.moola@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230622_135833_250980_FFE56F40 
X-CRM114-Status: UNSURE (   9.66  )
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
Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>
---
 include/linux/mm_types.h | 14 --------------
 include/linux/pgtable.h  |  3 ---
 2 files changed, 17 deletions(-)

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index fbbe4e93a9ba..434e54440686 100644
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
index e9bb5f18cade..daeacfe3930d 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -1044,10 +1044,7 @@ struct ptdesc {
 TABLE_MATCH(flags, __page_flags);
 TABLE_MATCH(compound_head, pt_list);
 TABLE_MATCH(compound_head, _pt_pad_1);
-TABLE_MATCH(pmd_huge_pte, pmd_huge_pte);
 TABLE_MATCH(mapping, _pt_s390_gaddr);
-TABLE_MATCH(pt_mm, pt_mm);
-TABLE_MATCH(ptl, ptl);
 TABLE_MATCH(rcu_head, pt_rcu_head);
 #ifdef CONFIG_MEMCG
 TABLE_MATCH(memcg_data, pt_memcg_data);
-- 
2.40.1


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
