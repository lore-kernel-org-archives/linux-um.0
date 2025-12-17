Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86194D65526
	for <linux-um@archiver.kernel.org>; Wed, 17 Dec 2025 09:47:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=oN9R7byRGmHEs6T0OtpuwOuRpbJv46Zq9CpZBf5+XJg=; b=1fg0Po6aFSJzHCMPs0iLD0v5Vs
	vtytj91cv/lqRfPyMd7juQrk79Y2M39JaDQBKEqGTD7Nhx/b1+NVY8GtALhtqpwVQbH9WW5ExI71/
	oR5aIJldzbGeRoEjt6r2+IA5RJMWDatCQtTG6e0CNDEu5I0BoN5B18X4Kv9lgNudKuhIAgmZ/K3oS
	P7uxjUncVOW4xgSmAqfaSC4WWwrNhR/s+zS2ehHPrcgjk5Ys1DsI9YGCjuanK5+G63SFqmune6eB8
	AkTTivUoL2EewrVvVvR/IJ2wjwBJ8+fcgBTN0dWg3i8MBDXyicJTXrVQeeli/s+Rq46SWDvPzBVzJ
	b8VJWpbg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vVo7k-00000006Sqz-0fWE;
	Wed, 17 Dec 2025 09:47:12 +0000
Received: from out-173.mta1.migadu.com ([2001:41d0:203:375::ad])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vVo7f-00000006Snv-3OiD
	for linux-um@lists.infradead.org;
	Wed, 17 Dec 2025 09:47:10 +0000
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1765964813;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=oN9R7byRGmHEs6T0OtpuwOuRpbJv46Zq9CpZBf5+XJg=;
	b=MRO4qPIxxsVdDqwXzC7u9PLqRjNXx7wnrDSDf1lYyiYd50PIXjJACLh+SJDhboDde2AFBp
	xudEn7lhZost3Ms/RAgSJ4rwmF9QHLUnd5iBfmp1YPdZeHPAwkC3Dg4lXkpK8Qt3kXk60G
	KOm9TW1XYyMer/EiQIPn82zf46FXx9c=
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
	Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH v3 0/7] enable PT_RECLAIM on all 64-bit architectures
Date: Wed, 17 Dec 2025 17:45:41 +0800
Message-ID: <cover.1765963770.git.zhengqi.arch@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251217_014708_002453_6BF5611C 
X-CRM114-Status: UNSURE (   9.80  )
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

Changes in v3:
 - modify the commit message in [PATCH v3 1/7] (suggested by David Hildenbrand)
 - make PT_RECLAIM depends on MMU_GATHER_RCU_TABLE_FREE instead of 64BIT
 - collect Acked-by
 - rebase onto the next-20251217

Changelog in v2:
 - fix compilation errors (reported by Magnus Lindholm and kernel test robot)
 - adjust some code style (suggested by Huacai Chen)
 - make PT_RECLAIM user-unselectable (suggested by David Hildenbrand)
 - rebase onto the next-20251119

Hi all,

This series aims to enable PT_RECLAIM on all 64-bit architectures.

On a 64-bit system, madvise(MADV_DONTNEED) may cause a large number of empty PTE
page table pages (such as 100GB+). To resolve this problem, we need to enable
PT_RECLAIM, which depends on MMU_GATHER_RCU_TABLE_FREE.

Therefore, this series first enables MMU_GATHER_RCU_TABLE_FREE on all 64-bit
architectures, and finally makes PT_RECLAIM depend on MMU_GATHER_RCU_TABLE_FREE.
This way, PT_RECLAIM can be enabled by default on all 64-bit architectures.

Of course, this will also be enabled on some 32-bit architectures that already
support MMU_GATHER_RCU_TABLE_FREE. That's fine, PT_RECLAIM works well on all
32-bit architectures as well. Although the benefit isn't significant, there's
still memory that can be reclaimed. Perhaps PT_RECLAIM can be enabled on all
32-bit architectures in the future.

Comments and suggestions are welcome!

Thanks,
Qi

Qi Zheng (7):
  mm: change mm/pt_reclaim.c to use asm/tlb.h instead of
    asm-generic/tlb.h
  alpha: mm: enable MMU_GATHER_RCU_TABLE_FREE
  LoongArch: mm: enable MMU_GATHER_RCU_TABLE_FREE
  mips: mm: enable MMU_GATHER_RCU_TABLE_FREE
  parisc: mm: enable MMU_GATHER_RCU_TABLE_FREE
  um: mm: enable MMU_GATHER_RCU_TABLE_FREE
  mm: make PT_RECLAIM depends on MMU_GATHER_RCU_TABLE_FREE

 arch/alpha/Kconfig                   | 1 +
 arch/alpha/include/asm/tlb.h         | 6 +++---
 arch/loongarch/Kconfig               | 1 +
 arch/loongarch/include/asm/pgalloc.h | 7 +++----
 arch/mips/Kconfig                    | 1 +
 arch/mips/include/asm/pgalloc.h      | 7 +++----
 arch/parisc/Kconfig                  | 1 +
 arch/parisc/include/asm/tlb.h        | 4 ++--
 arch/um/Kconfig                      | 1 +
 arch/x86/Kconfig                     | 1 -
 mm/Kconfig                           | 9 ++-------
 mm/pt_reclaim.c                      | 2 +-
 12 files changed, 19 insertions(+), 22 deletions(-)

-- 
2.20.1


