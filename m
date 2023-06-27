Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 834CEC0015E
	for <linux-um@archiver.kernel.org>; Tue, 27 Jun 2023 03:17:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=OdHHj9QdbthABICYUBQ/cD/7BSaqwt+ZQ0n6DwGyHsk=; b=TarWWL5/Bdlt5j
	Z5dR+/mLMDF/YUx98Zg9CQ0wqFgKaQUHbJK84T/lsOinPfQPblWA8c6C27Jtzcxz/K9VFWFJjf+SB
	16PAU5d+6KLFRuyir9Ug+zF85EXbygxhCJnlOfDgQ+KlPCNtqNID4O+9WVBXKPYY4PchXGOQatzh6
	U+qRRIMELfACORoYXcFqQmPnxD3eJ7mtr6SoHgEgODsIqg0D54Kk2/arclS28ow0ZaChUAuxm6baq
	fbbMm5AJwUZGUDUeWxMEoaXAIpkm8R4wZq2b9fhVZ9Fq7DSAvgFiSrhif4FhKlTCaCJyKVEutl5pv
	fD68LegqbEFgH1jDOvSA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qDzD1-00BXdn-04;
	Tue, 27 Jun 2023 03:17:39 +0000
Received: from mail-yw1-x1129.google.com ([2607:f8b0:4864:20::1129])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qDzBA-00BVqv-20;
	Tue, 27 Jun 2023 03:15:49 +0000
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-57338656a8aso30876667b3.0;
        Mon, 26 Jun 2023 20:15:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687835744; x=1690427744;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nccUzLka7Xkr4OuMpYk05u/KaIGQrzDFYQttz/vcmHQ=;
        b=HLcNThhCjrF2lW2DbUB2arEo4ko3B6allhXZIcElXjdr6H7L2X1FZfSho548An2x+c
         a+9K7HsBcoezl8dCiHuvfAoLyrYuTYtD9E2TWwaVAxGHkBxxc2/5TZ6nFsMXNvk6remM
         jx+8EfWgo0KYBg7GjeDiKlLbwiB7jM460FpLAi7tKdSlKxxDWqFHsa1UXC/mbPJcCtbU
         yj4Rp4J3hy1xGdNYGZKCLJPZo1cDJDTZZ/8LhFsRol7Jja96ui1kFTq+O1Fx747WJ4sF
         vLKKmUtgz/Vt/5vQzW3HaVNESXDRtjCa2KGe7DVgUo3lXiMXBnrUqjQNRU6qXKgQgpLj
         HQ8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687835744; x=1690427744;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nccUzLka7Xkr4OuMpYk05u/KaIGQrzDFYQttz/vcmHQ=;
        b=PhkhIQFmSJ4gAIY7HC6JxF6jNfWH1rb53IVpgr+UcgxY/mzb8JR5HAVapjfim1jxav
         AYqjT75IfLTJ/7sLbc4rqrZfHoVi8ILWVUWKzqsUZgNWGeC0Rhi25Ah/ub/5438GWsme
         732vfuru50qNsvJZ5TzH8UthK9as2F1elS8SuxM64n1xXvH/JGTAIhbIRe/inaPO7hq8
         KfzemnzEvkOuYTi+qGSvXMGXubnzt7yCp+UeE5z/sqSpNrhy6A6U+okAMqIEPJdQ5KMm
         4mB9m2h0iE9pfGlnpLKNtKFlws/cjgGa1AyoJDJe/3INyvonVu12BDJqTCNU6AgTc9+E
         2cew==
X-Gm-Message-State: AC+VfDwFVFzkKnYRshmIXeqKc7EZSTcjqqUBnUed1UL+f+PzHmCy2jeV
	tTeAsiF+wZmQ60jE0zoFoUo=
X-Google-Smtp-Source: ACHHUZ4vo/lElRqyF24hRbACCzJ93507ECpcyy5/0zyyAPcDbkzDTEVAwpHPMKxzXN5UZzQtaYrpVQ==
X-Received: by 2002:a81:6bc5:0:b0:576:8fcd:270f with SMTP id g188-20020a816bc5000000b005768fcd270fmr7059365ywc.19.1687835743726;
        Mon, 26 Jun 2023 20:15:43 -0700 (PDT)
Received: from unknowna0e70b2ca394.attlocal.net ([2600:1700:2f7d:1800::16])
        by smtp.googlemail.com with ESMTPSA id s4-20020a0dd004000000b0057399b3bd26sm1614798ywd.33.2023.06.26.20.15.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jun 2023 20:15:43 -0700 (PDT)
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
Subject: [PATCH v6 17/33] mm: Remove page table members from struct page
Date: Mon, 26 Jun 2023 20:14:15 -0700
Message-Id: <20230627031431.29653-18-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230627031431.29653-1-vishal.moola@gmail.com>
References: <20230627031431.29653-1-vishal.moola@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230626_201544_753833_91022FFC 
X-CRM114-Status: GOOD (  10.12  )
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
