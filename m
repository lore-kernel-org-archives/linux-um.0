Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFD7ED2F005
	for <linux-um@archiver.kernel.org>; Tue, 27 Jan 2026 12:16:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fkW1q5oTlkchrLBj7uhW1/fyT/NJTp0qrNRVsGoiJYg=; b=cDlPgV13JdaZj8U+4vjo7xlDtZ
	BdnlgDntdXBT/bpeGE0UVkAIkrwzxAcrJ1PqgmfbtHOakhzCllOCh/QZbMjq27QwKoH/QfhUhf++2
	CD9/TozrGnRcrHcFPL53Nz1cPTzPf5jAiOfCNFxpV9DYx+NRLAL0CsANNwXJI+DQZHMG6ArhMogDi
	dOXL9kj3t9UDR1/+PZMald0E9TOwluddbSed55+Qy0mnPSw4tu9X0F6Ls1Pdh7hQpuoqfFi2M8Y4S
	i3CKuon7zN3hvvCQGSlhiTz7V+tbtLRmUvsVFTvaRw+MOpF0mzGqMvFPOWB8i2FDDJMTTjIq+nff7
	q2wvyC1Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vkhzs-0000000EDxR-26WI;
	Tue, 27 Jan 2026 12:16:40 +0000
Received: from out-176.mta1.migadu.com ([95.215.58.176])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vkhzp-0000000EDuV-0jHP
	for linux-um@lists.infradead.org;
	Tue, 27 Jan 2026 12:16:39 +0000
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1769516194;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fkW1q5oTlkchrLBj7uhW1/fyT/NJTp0qrNRVsGoiJYg=;
	b=sFZyeoHJIKbye9uwcywAcpjl2xzdJccXUsdUJIt0TNtOYHgA7a208ZAIF7HqUNMoKtlbs6
	TW0o13FMFBrSCMFPpUnlYGDJlzuL1Fr0k5t+5kHxBoiaDB3yOgkQV/YzB2ftvcx1Aazeg3
	1xj0enzbG3UIgCeH+LduDr8+xkNa3bA=
From: Qi Zheng <qi.zheng@linux.dev>
To: david@kernel.org,
	andreas@gaisler.com,
	richard.weiyang@gmail.com,
	will@kernel.org,
	peterz@infradead.org,
	aneesh.kumar@kernel.org,
	npiggin@gmail.com,
	dev.jain@arm.com,
	ioworker0@gmail.com,
	linmag7@gmail.com,
	akpm@linux-foundation.org
Cc: linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-alpha@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-mips@vger.kernel.org,
	linux-parisc@vger.kernel.org,
	linux-um@lists.infradead.org,
	sparclinux@vger.kernel.org,
	Qi Zheng <zhengqi.arch@bytedance.com>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Subject: [PATCH v4 4/8] mips: mm: enable MMU_GATHER_RCU_TABLE_FREE
Date: Tue, 27 Jan 2026 20:12:57 +0800
Message-ID: <0d17f00a724f77aaca2da7c847acd490c3a47571.1769515122.git.zhengqi.arch@bytedance.com>
In-Reply-To: <cover.1769515122.git.zhengqi.arch@bytedance.com>
References: <cover.1769515122.git.zhengqi.arch@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260127_041637_371463_5AA90F1E 
X-CRM114-Status: UNSURE (   8.34  )
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
index b88b97139fa8e..c0c94e26ce396 100644
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
index 7a04381efa0b5..895bf79e76762 100644
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
 
@@ -97,7 +96,7 @@ static inline void p4d_populate(struct mm_struct *mm, p4d_t *p4d, pud_t *pud)
 	set_p4d(p4d, __p4d((unsigned long)pud));
 }
 
-#define __pud_free_tlb(tlb, x, addr)	pud_free((tlb)->mm, x)
+#define __pud_free_tlb(tlb, x, addr)	tlb_remove_ptdesc((tlb), virt_to_ptdesc(x))
 
 #endif /* __PAGETABLE_PUD_FOLDED */
 
-- 
2.20.1


