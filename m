Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64340E77198
	for <linux-um@archiver.kernel.org>; Fri,  3 Jan 2025 18:45:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=ZontuwCoinBEbae73Q0bAKKpV+MGIErfthpPUUzIUcI=; b=46ztPuEt1zdF4SK+wtw2gCD0VP
	FnhlMdgyS7fwYD0sp2bWLZYSEWGvVkfFdBp4tvj2PDw+TLgDykY3ie+wlhFEWY5vUqf5hzPc1gCbS
	R15HZAKfCvo18vHHlnB37/LGSMl7n3r5U1MneF/GWKwSBL+EzqatLcsqU4NHNWMoB1wzH1RVi/BZI
	YH8yKWj5BlETXDKLj7szpW+AXREdzu2p3f5QEp2RfKAvKlRlOMjnyRUhYpmYsHr8vucGaRSHB71qh
	kTvpFHwPkNTIHrCxF9J7GBz57Rm0EUZ4y/d8mzNTAAPu4mjReF+cIpArCyrAG+rZ6JuJJD3FJpExP
	2lESaV3Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tTmg8-0000000DjzB-2DLu;
	Fri, 03 Jan 2025 18:45:48 +0000
Received: from foss.arm.com ([217.140.110.172])
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tTmet-0000000DjGU-3rcu;
	Fri, 03 Jan 2025 18:44:33 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 561C61480;
	Fri,  3 Jan 2025 10:44:57 -0800 (PST)
Received: from e123572-lin.arm.com (e123572-lin.cambridge.arm.com [10.1.194.54])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1D3DB3F673;
	Fri,  3 Jan 2025 10:44:24 -0800 (PST)
From: Kevin Brodsky <kevin.brodsky@arm.com>
To: linux-mm@kvack.org
Cc: Kevin Brodsky <kevin.brodsky@arm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	"Mike Rapoport (IBM)" <rppt@kernel.org>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Will Deacon <will@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	Qi Zheng <zhengqi.arch@bytedance.com>,
	linux-alpha@vger.kernel.org,
	linux-arch@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-csky@vger.kernel.org,
	linux-hexagon@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-m68k@lists.linux-m68k.org,
	linux-mips@vger.kernel.org,
	linux-openrisc@vger.kernel.org,
	linux-parisc@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	linux-snps-arc@lists.infradead.org,
	linux-um@lists.infradead.org,
	loongarch@lists.linux.dev,
	x86@kernel.org
Subject: [PATCH v2 0/6] Account page tables at all levels
Date: Fri,  3 Jan 2025 18:44:09 +0000
Message-ID: <20250103184415.2744423-1-kevin.brodsky@arm.com>
X-Mailer: git-send-email 2.47.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250103_104432_058405_C4699145 
X-CRM114-Status: GOOD (  11.51  )
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

v1: https://lore.kernel.org/linux-mm/20241219164425.2277022-1-kevin.brodsky@arm.com/

This series should be considered in conjunction with Qi's series [1].
Together, they ensure that page table ctor/dtor are called at all levels
(PTE to PGD) and all architectures, where page tables are regular pages.
Besides the improvement in accounting and general cleanup, this also
create a single place where construction/destruction hooks can be called
for all page tables, namely the now-generic pagetable_dtor() introduced
by Qi, and __pagetable_ctor() introduced in this series.

v2 is essentially v1 rebased on top of mm-unstable, which includes Qi's
v4 series. A number of patches from v1 were dropped:

* v1 patch 4 is superseded by patch 6 in Qi's series.
* v1 patch 5 and 6 moved to Qi's series from v3 onwards.
* v1 patch 7 is superseded by patch 4 in Qi's series.

Changes from v1 in the remaining patches:

* Patch 1 only introduces __pagetable_ctor() as there is now a single
  generic pagetable_dtor(). 

* Patch 3 and 6: in arch/m68k/mm/motorola.c, free_pointer_table() can
  now unconditionally call pagetable_dtor() since it is the same for all
  levels.

* Patch 6 just uses pagetable_dtor() instead of introducing
  pagetable_pgd_dtor().

* Added Dave Hansen's Acked-by to all patches.

- Kevin

[1] https://lore.kernel.org/linux-mm/cover.1735549103.git.zhengqi.arch@bytedance.com/
---
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: "Mike Rapoport (IBM)" <rppt@kernel.org>
Cc: Ryan Roberts <ryan.roberts@arm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Will Deacon <will@kernel.org>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Qi Zheng <zhengqi.arch@bytedance.com>
Cc: linux-alpha@vger.kernel.org
Cc: linux-arch@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-csky@vger.kernel.org
Cc: linux-hexagon@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-m68k@lists.linux-m68k.org
Cc: linux-mips@vger.kernel.org
Cc: linux-openrisc@vger.kernel.org
Cc: linux-parisc@vger.kernel.org
Cc: linux-riscv@lists.infradead.org
Cc: linux-s390@vger.kernel.org
Cc: linux-snps-arc@lists.infradead.org
Cc: linux-um@lists.infradead.org
Cc: loongarch@lists.linux.dev
Cc: x86@kernel.org
---
Kevin Brodsky (6):
  mm: Move common part of pagetable_*_ctor to helper
  parisc: mm: Ensure pagetable_pmd_[cd]tor are called
  m68k: mm: Add calls to pagetable_pmd_[cd]tor
  ARM: mm: Rename PGD helpers
  asm-generic: pgalloc: Provide generic __pgd_{alloc,free}
  mm: Introduce ctor/dtor at PGD level

 arch/alpha/mm/init.c                     |  2 +-
 arch/arc/include/asm/pgalloc.h           |  9 ++----
 arch/arm/mm/pgd.c                        | 16 +++++-----
 arch/arm64/mm/pgd.c                      |  4 +--
 arch/csky/include/asm/pgalloc.h          |  2 +-
 arch/hexagon/include/asm/pgalloc.h       |  2 +-
 arch/loongarch/mm/pgtable.c              |  7 ++---
 arch/m68k/include/asm/mcf_pgalloc.h      |  3 +-
 arch/m68k/include/asm/motorola_pgalloc.h |  6 ++--
 arch/m68k/include/asm/sun3_pgalloc.h     |  2 +-
 arch/m68k/mm/motorola.c                  | 21 +++++++++----
 arch/microblaze/include/asm/pgalloc.h    |  7 +----
 arch/mips/include/asm/pgalloc.h          |  6 ----
 arch/mips/mm/pgtable.c                   |  8 ++---
 arch/nios2/mm/pgtable.c                  |  3 +-
 arch/openrisc/include/asm/pgalloc.h      |  6 ++--
 arch/parisc/include/asm/pgalloc.h        | 39 ++++++++----------------
 arch/riscv/include/asm/pgalloc.h         |  3 +-
 arch/s390/include/asm/pgalloc.h          |  9 +++++-
 arch/um/kernel/mem.c                     |  7 ++---
 arch/x86/mm/pgtable.c                    | 24 +++++++--------
 arch/xtensa/include/asm/pgalloc.h        |  2 +-
 include/asm-generic/pgalloc.h            | 28 ++++++++++++++++-
 include/linux/mm.h                       | 31 ++++++++++---------
 24 files changed, 126 insertions(+), 121 deletions(-)


base-commit: e2ce19225db5818f5dc22864cd225f8c425c3775
-- 
2.47.0


