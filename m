Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6D14D65529
	for <linux-um@archiver.kernel.org>; Wed, 17 Dec 2025 09:47:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WjvVUE6PLFuQKn8iudCm/UQAhzXxbds5MAnD30p0biw=; b=zz9y92ykTdSlP6ich0NPKONgsp
	JhLWH1AYAJEJlgaTSAc1oulFcdBzrJEfxQIMHQKrioWgYht2bcd+u4XW69keuiZGMUoUp7X/LHXx+
	h76jhDZhAU4yKuo6FIPSaKxoMNrBrhqg63sNiau11ZBSVhIYzkfwHv466LnLheNE/7xwacLPPP6Ba
	ypfmtqBQItKBuao11L0uUqJeDrC0fHr6+QI/pjZS0zpGXL9N8GmFhbFTbM7mLfSDRuOE9p9vwYY8U
	EPeBrDNVNP0P2V+oOL7GWpff+eT92EYGQocQM7Wq/u5HRrzzgsIDL10vxiafw964nvSWTsfLqYp5H
	1dze8Eew==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vVo7l-00000006SrZ-1lai;
	Wed, 17 Dec 2025 09:47:13 +0000
Received: from out-176.mta1.migadu.com ([95.215.58.176])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vVo7i-00000006SpS-0ZzW
	for linux-um@lists.infradead.org;
	Wed, 17 Dec 2025 09:47:11 +0000
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1765964827;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WjvVUE6PLFuQKn8iudCm/UQAhzXxbds5MAnD30p0biw=;
	b=brOaZf2K2ad6KJwOD2w1YutexFLGuWsWBcWsSFSW9Rhbh0uxRAqynp0B/EeXVhrva+cXWe
	gZB0oCXryrPE12cWqlsQwhYB5Dx/EC0LkrSQOTkvtYLvI3X0HBt+KxidI0BnlqQYnQoYUU
	wdwCgfkrV6k+l3/j3AAJV14uDlUcyGw=
From: Qi Zheng <qi.zheng@linux.dev>
To: will@kernel.org,
	aneesh.kumar@kernel.org,
	npiggin@gmail.com,
	peterz@infradead.org,
	dev.jain@arm.com,
	akpm@linux-foundation.org,
	david@kernel.org,
	ioworker0@gmail.com,
	linmag7@gmail.com
Cc: linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-alpha@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-mips@vger.kernel.org,
	linux-parisc@vger.kernel.org,
	linux-um@lists.infradead.org,
	Qi Zheng <zhengqi.arch@bytedance.com>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>
Subject: [PATCH v3 3/7] LoongArch: mm: enable MMU_GATHER_RCU_TABLE_FREE
Date: Wed, 17 Dec 2025 17:45:44 +0800
Message-ID: <dae0a0b490e912273a62a49be9d92f470fbcaf04.1765963770.git.zhengqi.arch@bytedance.com>
In-Reply-To: <cover.1765963770.git.zhengqi.arch@bytedance.com>
References: <cover.1765963770.git.zhengqi.arch@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251217_014710_499789_621DCBF7 
X-CRM114-Status: UNSURE (   7.40  )
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
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

From: Qi Zheng <zhengqi.arch@bytedance.com>

On a 64-bit system, madvise(MADV_DONTNEED) may cause a large number of
empty PTE page table pages (such as 100GB+). To resolve this problem,
first enable MMU_GATHER_RCU_TABLE_FREE to prepare for enabling the
PT_RECLAIM feature, which resolves this problem.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
Cc: Huacai Chen <chenhuacai@kernel.org>
Cc: WANG Xuerui <kernel@xen0n.name>
---
 arch/loongarch/Kconfig               | 1 +
 arch/loongarch/include/asm/pgalloc.h | 7 +++----
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
index 730f342145197..43d5b863e1fb2 100644
--- a/arch/loongarch/Kconfig
+++ b/arch/loongarch/Kconfig
@@ -187,6 +187,7 @@ config LOONGARCH
 	select IRQ_LOONGARCH_CPU
 	select LOCK_MM_AND_FIND_VMA
 	select MMU_GATHER_MERGE_VMAS if MMU
+	select MMU_GATHER_RCU_TABLE_FREE
 	select MODULES_USE_ELF_RELA if MODULES
 	select NEED_PER_CPU_EMBED_FIRST_CHUNK
 	select NEED_PER_CPU_PAGE_FIRST_CHUNK
diff --git a/arch/loongarch/include/asm/pgalloc.h b/arch/loongarch/include/asm/pgalloc.h
index 08dcc698ec184..248f62d0b590e 100644
--- a/arch/loongarch/include/asm/pgalloc.h
+++ b/arch/loongarch/include/asm/pgalloc.h
@@ -55,8 +55,7 @@ static inline pte_t *pte_alloc_one_kernel(struct mm_struct *mm)
 	return pte;
 }
 
-#define __pte_free_tlb(tlb, pte, address)	\
-	tlb_remove_ptdesc((tlb), page_ptdesc(pte))
+#define __pte_free_tlb(tlb, pte, address)	tlb_remove_ptdesc((tlb), page_ptdesc(pte))
 
 #ifndef __PAGETABLE_PMD_FOLDED
 
@@ -79,7 +78,7 @@ static inline pmd_t *pmd_alloc_one(struct mm_struct *mm, unsigned long address)
 	return pmd;
 }
 
-#define __pmd_free_tlb(tlb, x, addr)	pmd_free((tlb)->mm, x)
+#define __pmd_free_tlb(tlb, x, addr)	tlb_remove_ptdesc((tlb), virt_to_ptdesc(x))
 
 #endif
 
@@ -99,7 +98,7 @@ static inline pud_t *pud_alloc_one(struct mm_struct *mm, unsigned long address)
 	return pud;
 }
 
-#define __pud_free_tlb(tlb, x, addr)	pud_free((tlb)->mm, x)
+#define __pud_free_tlb(tlb, x, addr)	tlb_remove_ptdesc((tlb), virt_to_ptdesc(x))
 
 #endif /* __PAGETABLE_PUD_FOLDED */
 
-- 
2.20.1


