Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26169D2F000
	for <linux-um@archiver.kernel.org>; Tue, 27 Jan 2026 12:16:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=rw3Z5uz+wN/jKEhx+ggzBvOdjGW0IdrWnEXd8bGadDI=; b=jWJIupROu6/cPnHUvqZCBArOmK
	rawX0M12IKNwLVEqj/eSxB852/+zrSvwM07lcxL5kvv7YgA6BoPBjyPq2EcBYPOQs3cHCmaqJtFDQ
	Z3S2ouZK8sjMWaAeHXGrGK9zkeeR/8XJM3WDakYyJvL+EjgGfAen6ZZnP4kspucVDZSCSBbY6LaqB
	9xYzBF93qwIBZvPxn9SU/WydDdtdyxTxY2xLGq/LZWomeibLrUfvCTc6SQ1umlaLaZsH37SrRN3Wn
	LVViZQYt1V1tZDYmW68BGN438tZcCTM7FEk4yXGoQRWclFN51q0RUEPENgQYAraFkboX1ROpgTznW
	gt0fr6qg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vkhzj-0000000EDrQ-1rZp;
	Tue, 27 Jan 2026 12:16:31 +0000
Received: from out-187.mta1.migadu.com ([2001:41d0:203:375::bb])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vkhzZ-0000000EDpK-47zX
	for linux-um@lists.infradead.org;
	Tue, 27 Jan 2026 12:16:28 +0000
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1769516168;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=rw3Z5uz+wN/jKEhx+ggzBvOdjGW0IdrWnEXd8bGadDI=;
	b=swOtWBA2Pxw+VUT1PgETbtdgbPH5WgWUXEJQKmSqNUXZeFJybWNBgbHHDf61HMLS9e9X+A
	/UbuSve74Y3SLHsizfV5uZHvGuLEqftFCcCvnoYpdjbId1/fyXQalrb4sM1LqT6/gvYfsS
	kGfQpCcXFro2mJes4NEiytnYkfPcksE=
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
	Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH v4 0/8] enable PT_RECLAIM on more 64-bit architectures
Date: Tue, 27 Jan 2026 20:12:53 +0800
Message-ID: <cover.1769515122.git.zhengqi.arch@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260127_041622_808315_CF581503 
X-CRM114-Status: GOOD (  10.67  )
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

Changes in v4:
 - convert __HAVE_ARCH_TLB_REMOVE_TABLE to CONFIG_HAVE_ARCH_TLB_REMOVE_TABLE config
 - fix a WARN_ON_ONCE() on sparc64 (and on ppc)
   (reported by Andreas Larsson)
 - collect Acked-by (Hi David, I've kept your Acked-by, feel free to drop it)
 - rebase onto the v6.19-rc7

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

This series aims to enable PT_RECLAIM on more 64-bit architectures.

On a 64-bit system, madvise(MADV_DONTNEED) may cause a large number of empty PTE
page table pages (such as 100GB+). To resolve this problem, we need to enable
PT_RECLAIM, which depends on MMU_GATHER_RCU_TABLE_FREE.

For these architectures that define its own __tlb_remove_table(), since
their page tables are not of type struct ptdesc, they cannot be supported
PT_RECLAIM.

Therefore, this series first enables MMU_GATHER_RCU_TABLE_FREE on all 64-bit
architectures, then converts __HAVE_ARCH_TLB_REMOVE_TABLE to
CONFIG_HAVE_ARCH_TLB_REMOVE_TABLE config, and finally makes PT_RECLAIM depend on
MMU_GATHER_RCU_TABLE_FREE && !HAVE_ARCH_TLB_REMOVE_TABLE. This way, PT_RECLAIM
can be enabled by default on most 64-bit architectures.

Of course, this will also be enabled on some 32-bit architectures that already
support MMU_GATHER_RCU_TABLE_FREE. That's fine, PT_RECLAIM works well on all
32-bit architectures as well. Although the benefit isn't significant, there's
still memory that can be reclaimed. Perhaps PT_RECLAIM can be enabled on all
32-bit architectures in the future.

Comments and suggestions are welcome!

Thanks,
Qi

Qi Zheng (8):
  mm: change mm/pt_reclaim.c to use asm/tlb.h instead of
    asm-generic/tlb.h
  alpha: mm: enable MMU_GATHER_RCU_TABLE_FREE
  LoongArch: mm: enable MMU_GATHER_RCU_TABLE_FREE
  mips: mm: enable MMU_GATHER_RCU_TABLE_FREE
  parisc: mm: enable MMU_GATHER_RCU_TABLE_FREE
  um: mm: enable MMU_GATHER_RCU_TABLE_FREE
  mm: convert __HAVE_ARCH_TLB_REMOVE_TABLE to
    CONFIG_HAVE_ARCH_TLB_REMOVE_TABLE config
  mm: make PT_RECLAIM depends on MMU_GATHER_RCU_TABLE_FREE

 arch/alpha/Kconfig                   | 1 +
 arch/alpha/include/asm/tlb.h         | 6 +++---
 arch/loongarch/Kconfig               | 1 +
 arch/loongarch/include/asm/pgalloc.h | 7 +++----
 arch/mips/Kconfig                    | 1 +
 arch/mips/include/asm/pgalloc.h      | 7 +++----
 arch/parisc/Kconfig                  | 1 +
 arch/parisc/include/asm/tlb.h        | 4 ++--
 arch/powerpc/Kconfig                 | 1 +
 arch/powerpc/include/asm/tlb.h       | 1 -
 arch/sparc/Kconfig                   | 1 +
 arch/sparc/include/asm/tlb_64.h      | 1 -
 arch/um/Kconfig                      | 1 +
 arch/x86/Kconfig                     | 1 -
 include/asm-generic/tlb.h            | 2 +-
 mm/Kconfig                           | 8 +++-----
 mm/pt_reclaim.c                      | 2 +-
 17 files changed, 23 insertions(+), 23 deletions(-)

-- 
2.20.1


