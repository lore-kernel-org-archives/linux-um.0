Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EFF3CF2590
	for <linux-um@archiver.kernel.org>; Wed, 19 Nov 2025 07:32:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=RM/LNY/jIqKvMu4siWA3n4g7le9dIkYSozgItVRuYzQ=; b=jD7PjaAbJX32uIPn2cxoZ2VNNF
	5WO1zamntR3pcAe5gPUAAdaci/o9pBimJBsQ0av0ZoLqPDW8vm3sfZfI4HTTbWPJ/2vnbnSVoxdDW
	wOmkpVdn93H0XKIW/tf80dQ8IVBZz/2W8crcETIFEoXwbgB78zKuKothGDXvw+mQ/bBSd8eGlLsQ2
	QyZhLKvrpBnQ7LDL4YbC7qMC8fcZXN4/MRf5dsjitKwkASr4pM2eSakhV+ixFPRKZJbxShzFiCdk6
	nW+H+A1BRbU1v7Dt1bmTUuvR2eBdyty2k3si5EDnLOFBxdB3DIHykr76bYoAPPtig7ffR5ge+KiqS
	NZ4gcXZw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vLcg8-00000002iB7-1o9m;
	Wed, 19 Nov 2025 07:32:36 +0000
Received: from out-178.mta0.migadu.com ([2001:41d0:1004:224b::b2])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vLcg5-00000002iAW-3yuk
	for linux-um@lists.infradead.org;
	Wed, 19 Nov 2025 07:32:35 +0000
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1763537550;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=RM/LNY/jIqKvMu4siWA3n4g7le9dIkYSozgItVRuYzQ=;
	b=RkrZBK3OBlnLn39KLbMXWTZHlkpQhan3nyk+UskGsUD7ugTEJOaYyfWLD3V1wFF7qXLd8d
	89T9NsZlF9okuMBocxfIwiJRSi+XwXf2ys8YqEE8dcM+bWD2FAunmOg9NrueVwybIJH4fT
	KGL4YWEpARpMdZqp/4K6fUM4DDEnpoI=
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
Subject: [PATCH v2 0/7] enable PT_RECLAIM on all 64-bit architectures
Date: Wed, 19 Nov 2025 15:31:17 +0800
Message-ID: <cover.1763537007.git.zhengqi.arch@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251118_233234_275420_246627E1 
X-CRM114-Status: UNSURE (   9.90  )
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
architectures, and finally makes PT_RECLAIM depend on 64BIT. This way,
PT_RECLAIM can be enabled by default on all 64-bit architectures.

BTW, PT_RECLAIM works well on all 32-bit architectures as well. Although the
benefit isn't significant, there's still memory that can be reclaimed. Perhaps
PT_RECLAIM can be enabled on all 32-bit architectures in the future.

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
  mm: enable PT_RECLAIM on all 64-bit architectures

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


