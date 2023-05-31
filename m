Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DBEDC7EE23
	for <linux-um@archiver.kernel.org>; Wed, 31 May 2023 21:33:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=2goO4g7VgHKq7mwZNlzEQ5T/XvEJ5np4p15AxD73aJg=; b=EMg4HkIIqpLStU
	WjNf6DWQufhixHlyytdSZomClolP8CXeuccHBY0bjI55GQqX1kk2GVqed1+tR8cK6ADTWkIHtPtSd
	4q6GLLpZEWPZroYGo4XL19YGMAptso2j5EyZIowGNXwx/1NPO1CKQWeJGxpOX0p9UHF20bN00qBFj
	8TCIYU2U86ST9LeLH6+gR82bSS97C4eE/7kJfA2qfvYaGqrIXiXDFJUp9MS0VNEt1iJo93lNK82LR
	RZdpATinKOn3biI6l3dB+V449Tt2nGKbdNIwjqoUGiKu2JVhlokNwcC/BJ8JWOdbm8C3c8ihA5tmK
	CGAzqnm+H73eyyKXZNfg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q4TRR-001B3a-2K;
	Wed, 31 May 2023 21:33:13 +0000
Received: from mail-yw1-x1133.google.com ([2607:f8b0:4864:20::1133])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q4TQN-001ASe-1e;
	Wed, 31 May 2023 21:32:08 +0000
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-565bdae581eso792317b3.2;
        Wed, 31 May 2023 14:32:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685568727; x=1688160727;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lnBVr922X+M85c+6VJKDI+Caz3ny3LZ2fwcpIuiP1/4=;
        b=XZ3kJddTkoKufk0kwBdOVZQZoSVtcE5HG6sX6rRRHvCe7Om9x7xY0K4IiCL0nHsHxQ
         9eGr6MZvVeUtc5fgyKg5P1qBSWAOsfbcmSPQlXFPghUVu6fp2sIDmm+5U3bq4g7lRHpB
         Zld4cy93/rMGN07+QSO9q6jJf8+GwNN3p+hTYG0BRIQZI6tNs0RI+r52u0EH3fUAXWUT
         KW3t0eM8fAoeH75fwVt/7iugc0BvPA69n2m/eo4szwTaUcjtnQ0rOZaZxJ3/gvL6spZ8
         hnUdu2Pp/aCFMWHQdwhDEFfy8i7DytzgyU5VaM/fnvmpMyEanQ53VlCHmZFkS4f807YX
         H9xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685568727; x=1688160727;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lnBVr922X+M85c+6VJKDI+Caz3ny3LZ2fwcpIuiP1/4=;
        b=NsNvJ85Aep5Z38sMXXgvoauZJN2KMXj7fwL8z2KvbT7QE8N6NJ4DEnbwQnFk/F8l0y
         ZP3wXUuBhaxUeOg3Gq85fEcIGMx85thjAIh+GlW14U3ztQYUpOzj72GPv7xYErCg6ZpA
         MASqRQd8TFATV77W5ZG7wowkw+hAinNL+pL5OLjF4QlDhPNMeoKzAOQZIkbKtTVzBAvj
         J2npQ7ga5IBS25mOQr1cMkVWviCzvazkMxSdn90m6LMbthKhO9oZc7IoBVUdpfQmGzJ1
         Fx3u4MpzeA1OGftQ1f27+GRZGjHxiRiwo3XTjJKM3ew7iuZD35iYTVSwhqXtGh46Qd5A
         HeHA==
X-Gm-Message-State: AC+VfDzarzlMIMa4BYfTKXqm10YfhtcqzWMZ7KtKCoSEnHYAw1OaK40N
	ct0iRe/tMjZ8Xutm2JJnjo7nRmswaihcXw==
X-Google-Smtp-Source: ACHHUZ5mU9zEYCdDSqHlmf5fji+LZR6GnrVvINr+QLg2em3BFf1b9EHyVp5oT6zaLyXHcWvIl6C56g==
X-Received: by 2002:a0d:e212:0:b0:55d:a4fb:864a with SMTP id l18-20020a0de212000000b0055da4fb864amr6942187ywe.14.1685568726728;
        Wed, 31 May 2023 14:32:06 -0700 (PDT)
Received: from unknowna0e70b2ca394.attlocal.net ([2600:1700:2f7d:1800::46])
        by smtp.googlemail.com with ESMTPSA id t63-20020a0dd142000000b0055aafcef659sm658905ywd.5.2023.05.31.14.32.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 May 2023 14:32:06 -0700 (PDT)
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
	"Vishal Moola (Oracle)" <vishal.moola@gmail.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@rivosinc.com>
Subject: [PATCH v3 29/34] riscv: Convert alloc_{pmd, pte}_late() to use ptdescs
Date: Wed, 31 May 2023 14:30:27 -0700
Message-Id: <20230531213032.25338-30-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230531213032.25338-1-vishal.moola@gmail.com>
References: <20230531213032.25338-1-vishal.moola@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230531_143207_560264_04EE19E6 
X-CRM114-Status: GOOD (  12.66  )
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

As part of the conversions to replace pgtable constructor/destructors with
ptdesc equivalents, convert various page table functions to use ptdescs.

Some of the functions use the *get*page*() helper functions. Convert
these to use pagetable_alloc() and ptdesc_address() instead to help
standardize page tables further.

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
---
 arch/riscv/include/asm/pgalloc.h |  8 ++++----
 arch/riscv/mm/init.c             | 16 ++++++----------
 2 files changed, 10 insertions(+), 14 deletions(-)

diff --git a/arch/riscv/include/asm/pgalloc.h b/arch/riscv/include/asm/pgalloc.h
index 59dc12b5b7e8..d169a4f41a2e 100644
--- a/arch/riscv/include/asm/pgalloc.h
+++ b/arch/riscv/include/asm/pgalloc.h
@@ -153,10 +153,10 @@ static inline pgd_t *pgd_alloc(struct mm_struct *mm)
 
 #endif /* __PAGETABLE_PMD_FOLDED */
 
-#define __pte_free_tlb(tlb, pte, buf)   \
-do {                                    \
-	pgtable_pte_page_dtor(pte);     \
-	tlb_remove_page((tlb), pte);    \
+#define __pte_free_tlb(tlb, pte, buf)			\
+do {							\
+	pagetable_pte_dtor(page_ptdesc(pte));		\
+	tlb_remove_page_ptdesc((tlb), page_ptdesc(pte));\
 } while (0)
 #endif /* CONFIG_MMU */
 
diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index 2f7a7c345a6a..2fe6ca1b1f95 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -353,12 +353,10 @@ static inline phys_addr_t __init alloc_pte_fixmap(uintptr_t va)
 
 static phys_addr_t __init alloc_pte_late(uintptr_t va)
 {
-	unsigned long vaddr;
-
-	vaddr = __get_free_page(GFP_KERNEL);
-	BUG_ON(!vaddr || !pgtable_pte_page_ctor(virt_to_page((void *)vaddr)));
+	struct ptdesc *ptdesc = pagetable_alloc(GFP_KERNEL, 0);
 
-	return __pa(vaddr);
+	BUG_ON(!ptdesc || !pagetable_pte_ctor(ptdesc));
+	return __pa((pte_t *)ptdesc_address(ptdesc));
 }
 
 static void __init create_pte_mapping(pte_t *ptep,
@@ -436,12 +434,10 @@ static phys_addr_t __init alloc_pmd_fixmap(uintptr_t va)
 
 static phys_addr_t __init alloc_pmd_late(uintptr_t va)
 {
-	unsigned long vaddr;
-
-	vaddr = __get_free_page(GFP_KERNEL);
-	BUG_ON(!vaddr || !pgtable_pmd_page_ctor(virt_to_page((void *)vaddr)));
+	struct ptdesc *ptdesc = pagetable_alloc(GFP_KERNEL, 0);
 
-	return __pa(vaddr);
+	BUG_ON(!ptdesc || !pagetable_pmd_ctor(ptdesc));
+	return __pa((pmd_t *)ptdesc_address(ptdesc));
 }
 
 static void __init create_pmd_mapping(pmd_t *pmdp,
-- 
2.40.1


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
