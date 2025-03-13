Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BD62C282DE
	for <linux-um@archiver.kernel.org>; Thu, 13 Mar 2025 13:53:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=q3twzRg7JFtCcj4wct+pthKqDwlnYSVDhBZsfaP3eKQ=; b=l3u98Hd2J2ZhRz/FzAM/7QONVg
	RtvV/+kME8Y3gURiiIvtRGMM7mcFwZY5pG90GjIItT/1YwUNcNdp5167AtLACqB1B7jDzGGie/gs8
	4MeX0QXpOw0EC7+cEVXf5/9QPTwRoWNIX7/wpln382G7/xBnAwF6yM014dCwq0iCtL0w/4kLD8yfw
	kXvKgeZnDCYP7DDbcZAAI7V2NLiqto74zruHuA5ktpA4hjS4MpY/2f3MAWc9tQmFrweKw8Geb0MHD
	tRz2Yvj4zEw3jztKp9wJmN3ZKWbcgznER1LzxU8QdsmvFq+87Fm3nGuKJg9eufcLVsSI+4cio2kd0
	NQegQXPA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tsizj-0000000BRdQ-0OzC;
	Thu, 13 Mar 2025 13:53:07 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tsixC-0000000BQjp-3wFV;
	Thu, 13 Mar 2025 13:50:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=q3twzRg7JFtCcj4wct+pthKqDwlnYSVDhBZsfaP3eKQ=; b=iG/p7YuCG4MfQw89LNk72vralS
	Yi+Ri7OYIeYgjGtFCQy+K5dVuSZ16g/x4JVlEPJLVWZTzmKP3GWaKlW/8AR811DtJWCpIlIjeMnDT
	tmbwdZU+r37A+QExq0AIkOoedBb9B0/Df0xTJskbx/ah6Zp0LNiEs9SaEx2/XeqZeG8lMcH1z+sFZ
	KoVex6tnp4r8JLM/6QcPIXTM5K3tF5Ke1ZRtb+yZhFVI/txPR3uQi+IEBs4VgIGar1+n8u60k2KqH
	1jDvjJ6UVQ6+D50sCuVkhm6VlrNXSvbOhYxG1335gBbsf2eAeLK0+IsYCMZURd2LOFafJbZPkNZyw
	9yFinc5w==;
Received: from nyc.source.kernel.org ([147.75.193.91])
	by desiato.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tsix9-00000002eMf-07Ad;
	Thu, 13 Mar 2025 13:50:29 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 3BAE8A474BF;
	Thu, 13 Mar 2025 13:44:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C704BC4CEEA;
	Thu, 13 Mar 2025 13:50:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741873822;
	bh=62myLVbZVVZFvzPE89he3yMa/a5QAFc2vHsMKxeLVb8=;
	h=From:To:Cc:Subject:Date:From;
	b=aBWKPm/h37x/i5+4FCPzxXZYbNjC4QtR+6/uzYQ4j82YaZ0nkwcNlRiBhZ3s4R+Lr
	 UbF6tAw/GLOmZOSjCm3jrX37f1OqnkT6FdjX3Szfhc1wjS/Zyf835B0imLzLMqYjcF
	 W5cI3ghKtUKRswhAYc77+5GSp1YmJnwSpf+x4AqcOGMZBAqFa6QHJIit/O7bFjGzmZ
	 g/lU9Dt6wqDCDU2wFqrq4LXF68UvvU/ytVgt54uUuF2Vagcx8WobuHEk6mGKRWMGKp
	 aLWh5ch4M9p8CvWw5jWVVvEJFFmiQHZ9S4CLDqJpDLqZJs/1wj2uAhd2lAzYblfH7W
	 BgZb5J0KHNyow==
From: Mike Rapoport <rppt@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
	Andreas Larsson <andreas@gaisler.com>,
	Andy Lutomirski <luto@kernel.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Borislav Petkov <bp@alien8.de>,
	Brian Cain <bcain@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Dinh Nguyen <dinguyen@kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Guo Ren <guoren@kernel.org>,
	Heiko Carstens <hca@linux.ibm.com>,
	Helge Deller <deller@gmx.de>,
	Huacai Chen <chenhuacai@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Mark Brown <broonie@kernel.org>,
	Matt Turner <mattst88@gmail.com>,
	Max Filippov <jcmvbkbc@gmail.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Michal Simek <monstr@monstr.eu>,
	Mike Rapoport <rppt@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Richard Weinberger <richard@nod.at>,
	Russell King <linux@armlinux.org.uk>,
	Stafford Horne <shorne@gmail.com>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Vineet Gupta <vgupta@kernel.org>,
	Will Deacon <will@kernel.org>,
	linux-alpha@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-snps-arc@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-csky@vger.kernel.org,
	linux-hexagon@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-m68k@lists.linux-m68k.org,
	linux-mips@vger.kernel.org,
	linux-openrisc@vger.kernel.org,
	linux-parisc@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	linux-sh@vger.kernel.org,
	sparclinux@vger.kernel.org,
	linux-um@lists.infradead.org,
	linux-arch@vger.kernel.org,
	linux-mm@kvack.org,
	x86@kernel.org
Subject: [PATCH v2 00/13] arch, mm: reduce code duplication in mem_init()
Date: Thu, 13 Mar 2025 15:49:50 +0200
Message-ID: <20250313135003.836600-1-rppt@kernel.org>
X-Mailer: git-send-email 2.47.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250313_135027_393658_14C1D962 
X-CRM114-Status: GOOD (  15.35  )
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

From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>

Hi,

Every architecture has implementation of mem_init() function and some
even more than one. All these release free memory to the buddy
allocator, most of them set high_memory to the end of directly
addressable memory and many of them set max_mapnr for FLATMEM case.

These patches pull the commonalities into the generic code and refactor
some of the mem_init() implementations so that many of them can be just
dropped.

v2 changes:
* don't use generic version for setting high_memory on architectures
  that use that varialble earlier than free_area_init()
* use memblock_alloc_or_panig() to allocate zero pages on MIPS and s390
* fix alignment in allocation of zero pages on s390
* add Acked-by

v1: https://lore.kernel.org/all/20250306185124.3147510-1-rppt@kernel.org

Mike Rapoport (Microsoft) (13):
  arm: mem_init: use memblock_phys_free() to free DMA memory on SA1111
  csky: move setup_initrd() to setup.c
  hexagon: move initialization of init_mm.context init to paging_init()
  MIPS: consolidate mem_init() for NUMA machines
  MIPS: make setup_zero_pages() use memblock
  nios2: move pr_debug() about memory start and end to setup_arch()
  s390: make setup_zero_pages() use memblock
  xtensa: split out printing of virtual memory layout to a function
  arch, mm: set max_mapnr when allocating memory map for FLATMEM
  arch, mm: set high_memory in free_area_init()
  arch, mm: streamline HIGHMEM freeing
  arch, mm: introduce arch_mm_preinit
  arch, mm: make releasing of memory to page allocator more explicit

 arch/alpha/mm/init.c               |  8 ----
 arch/arc/mm/init.c                 | 25 +----------
 arch/arm/mm/init.c                 | 43 +------------------
 arch/arm64/mm/init.c               | 12 +-----
 arch/csky/kernel/setup.c           | 43 +++++++++++++++++++
 arch/csky/mm/init.c                | 67 ------------------------------
 arch/hexagon/mm/init.c             | 32 ++------------
 arch/loongarch/kernel/numa.c       |  6 ---
 arch/loongarch/mm/init.c           |  8 ----
 arch/m68k/mm/init.c                |  2 -
 arch/microblaze/mm/init.c          | 25 -----------
 arch/mips/include/asm/mmzone.h     |  2 -
 arch/mips/loongson64/numa.c        |  7 ----
 arch/mips/mm/init.c                | 51 ++++-------------------
 arch/mips/sgi-ip27/ip27-memory.c   |  9 ----
 arch/nios2/kernel/setup.c          |  3 +-
 arch/nios2/mm/init.c               | 16 +------
 arch/openrisc/mm/init.c            |  6 ---
 arch/parisc/mm/init.c              |  4 --
 arch/powerpc/kernel/setup-common.c |  2 -
 arch/powerpc/mm/mem.c              | 18 +-------
 arch/riscv/mm/init.c               |  5 +--
 arch/s390/mm/init.c                | 20 +--------
 arch/sh/mm/init.c                  | 10 -----
 arch/sparc/mm/init_32.c            | 31 +-------------
 arch/sparc/mm/init_64.c            |  4 --
 arch/um/include/shared/mem_user.h  |  1 -
 arch/um/kernel/mem.c               |  9 ++--
 arch/um/kernel/physmem.c           | 12 ------
 arch/um/kernel/um_arch.c           |  2 -
 arch/x86/include/asm/highmem.h     |  3 --
 arch/x86/include/asm/numa.h        |  4 --
 arch/x86/include/asm/numa_32.h     | 13 ------
 arch/x86/kernel/setup.c            |  2 -
 arch/x86/mm/Makefile               |  2 -
 arch/x86/mm/highmem_32.c           | 34 ---------------
 arch/x86/mm/init_32.c              | 41 ++----------------
 arch/x86/mm/init_64.c              |  7 ++--
 arch/x86/mm/numa_32.c              |  3 --
 arch/xtensa/mm/init.c              | 66 +++++++----------------------
 include/asm-generic/memory_model.h |  5 ++-
 include/linux/memblock.h           |  1 -
 include/linux/mm.h                 | 13 +-----
 mm/internal.h                      |  3 +-
 mm/memblock.c                      |  3 +-
 mm/memory.c                        | 16 -------
 mm/mm_init.c                       | 65 +++++++++++++++++++++++++----
 mm/nommu.c                         |  6 ---
 48 files changed, 158 insertions(+), 612 deletions(-)
 delete mode 100644 arch/x86/include/asm/numa_32.h
 delete mode 100644 arch/x86/mm/highmem_32.c


base-commit: d082ecbc71e9e0bf49883ee4afd435a77a5101b6
-- 
2.47.2


