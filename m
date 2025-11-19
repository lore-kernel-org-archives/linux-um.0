Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2F67CF2588
	for <linux-um@archiver.kernel.org>; Wed, 19 Nov 2025 07:33:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zdgUvYzcKft0e9ATGbEv1Xh5QzTrrx2Vkhg8Ynjkseo=; b=CsMnAIOlTk2ZA+o+hUEy7k/w09
	jkG7CP+rPCRKOnlBdTJlmg6uUyISWd22S1PZj4XAqg/yBfozGVj/64cs77f04u1wlBecUKxEC8Wve
	XP+e7C5rcdRFEq27OoAKM6qNhgo5oBc/Iw/QXgP2+ZHinStJYJ109BQNKPodxrLzoz4MQwLNGRX7/
	+nAD+2JPnGjl9PH9cDxkQwgQRxxlwQVdgOexF/W64yUYynx93I/QXL4AAdqkqei1xSLtECQWSsdGQ
	D358bOZppjKEABTIT7fVXj1P42+PlWDz0Bh3DnqIyp3G7cPnavb+0Kb930tzlSwgcO67bnLo/+xOO
	0/ujv2VA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vLcgn-00000002iRD-39cd;
	Wed, 19 Nov 2025 07:33:17 +0000
Received: from out-170.mta0.migadu.com ([2001:41d0:1004:224b::aa])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vLcgl-00000002iPM-023L
	for linux-um@lists.infradead.org;
	Wed, 19 Nov 2025 07:33:16 +0000
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1763537588;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zdgUvYzcKft0e9ATGbEv1Xh5QzTrrx2Vkhg8Ynjkseo=;
	b=Pb5LFJ+IU/AZ2Oz4xGklQJtAr7Es3lk5E9mJtBOlpGjpEgsHLj1bdTC0GTVwKClzrR4LOK
	intXEaBo7Ss5/OCkxQXg0NTRpmfVxlu9kTak8I4es9WvoPUCvmE9L4Qkpx6nGAl9AKSns5
	kY9KU02r2QCtq/wVBDCUyb2Auh35ZjY=
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
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Subject: [PATCH v2 4/7] mips: mm: enable MMU_GATHER_RCU_TABLE_FREE
Date: Wed, 19 Nov 2025 15:31:21 +0800
Message-ID: <1ef6075dca55a0ace4a6de6350531e4bc513080e.1763537007.git.zhengqi.arch@bytedance.com>
In-Reply-To: <cover.1763537007.git.zhengqi.arch@bytedance.com>
References: <cover.1763537007.git.zhengqi.arch@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251118_233315_197072_9798EF9B 
X-CRM114-Status: UNSURE (   9.03  )
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
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
---
 arch/mips/Kconfig               | 1 +
 arch/mips/include/asm/pgalloc.h | 7 +++----
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index e8683f58fd3e2..8b16dd4db7c08 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -99,6 +99,7 @@ config MIPS
 	select IRQ_FORCED_THREADING
 	select ISA if EISA
 	select LOCK_MM_AND_FIND_VMA
+	select MMU_GATHER_RCU_TABLE_FREE
 	select MODULES_USE_ELF_REL if MODULES
 	select MODULES_USE_ELF_RELA if MODULES && 64BIT
 	select PERF_USE_VMALLOC
diff --git a/arch/mips/include/asm/pgalloc.h b/arch/mips/include/asm/pgalloc.h
index 942af87f1cddb..9a7e5af16c00b 100644
--- a/arch/mips/include/asm/pgalloc.h
+++ b/arch/mips/include/asm/pgalloc.h
@@ -48,8 +48,7 @@ static inline void pud_populate(struct mm_struct *mm, pud_t *pud, pmd_t *pmd)
 extern void pgd_init(void *addr);
 extern pgd_t *pgd_alloc(struct mm_struct *mm);
 
-#define __pte_free_tlb(tlb, pte, address)	\
-	tlb_remove_ptdesc((tlb), page_ptdesc(pte))
+#define __pte_free_tlb(tlb, pte, address)	tlb_remove_ptdesc((tlb), page_ptdesc(pte))
 
 #ifndef __PAGETABLE_PMD_FOLDED
 
@@ -72,7 +71,7 @@ static inline pmd_t *pmd_alloc_one(struct mm_struct *mm, unsigned long address)
 	return pmd;
 }
 
-#define __pmd_free_tlb(tlb, x, addr)	pmd_free((tlb)->mm, x)
+#define __pmd_free_tlb(tlb, x, addr)	tlb_remove_ptdesc((tlb), virt_to_ptdesc(x))
 
 #endif
 
@@ -98,7 +97,7 @@ static inline void p4d_populate(struct mm_struct *mm, p4d_t *p4d, pud_t *pud)
 	set_p4d(p4d, __p4d((unsigned long)pud));
 }
 
-#define __pud_free_tlb(tlb, x, addr)	pud_free((tlb)->mm, x)
+#define __pud_free_tlb(tlb, x, addr)	tlb_remove_ptdesc((tlb), virt_to_ptdesc(x))
 
 #endif /* __PAGETABLE_PUD_FOLDED */
 
-- 
2.20.1


