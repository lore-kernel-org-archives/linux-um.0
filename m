Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22780C61DF0
	for <linux-um@archiver.kernel.org>; Mon, 31 Aug 2026 05:43:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=+sjajWrfj2wM9zCU9qb6V0Zy3xK1fZ/kgY+W3FSBiiw=; b=sEzwx4A/oTO/fHnZSeAPTH71Iu
	mwEuo5rYJKd4cY+5K1wFl9muzkU2NGWQRH+PUQ7TJewbODU5g0ZG4bhVqgHw/isKjm/23/F7dn7L2
	yZfetYi2zqGgcKFjlsz9NAliodyVJGQfsjrDTXaej90JgEmOp904lKQt0yRGIC5VecF2MGTqNVBla
	Gb4Hrz51S4oNAidm8gdKM/rB6cI+BGa037y2EH7EQ0DMIBdFrMyswtxLD17s7t2LFAwUhs8a3xHG+
	6n8QZBEWAbhSGG7EVe9S7o/tJ6ue26wlvLslgJIwvACWcBSULlVtkqZsjAOZBbQ2FOMraj1xyS2q/
	Ifj/ghmw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x0uo3-00000008XLE-3bxz;
	Mon, 31 Aug 2026 05:43:43 +0000
Received: from foss.arm.com ([217.140.110.172])
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x0uny-00000008XJ7-0wgE;
	Mon, 31 Aug 2026 05:43:42 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5511914BF;
	Sun, 30 Aug 2026 22:43:31 -0700 (PDT)
Received: from localhost (a085714.arm.com [10.164.19.28])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5B2D73F85F;
	Sun, 30 Aug 2026 22:43:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1788155015; bh=QKfwc4zep2ayth9wQau6lhc5F2hRk7N0saDoBUOnEqo=;
	h=From:To:Cc:Subject:Date:From;
	b=BqfKECU337E7qsCYRaYZ551VunTXFknuFyCaLMIudB5TVUVPy9lcqXU9kDceG55xE
	 3k/uh1THmhFNmRViRgc/nMwvFC4fkZ8h2ai9fhKnQX7Hczm+O8oU7JE/xv/FBEfkCv
	 3sSZnJfiyZzjdo3E1Ch5J2JPk2brrk5Zet6wHHlk=
From: Anshuman Khandual <anshuman.khandual@arm.com>
To: linux-mm@kvack.org
Cc: samuel.holland@sifive.com,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	David Hildenbrand <david@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	Helge Deller <deller@gmx.de>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	linux-alpha@vger.kernel.org,
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
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/8] mm: Drop pxd_ERROR()
Date: Mon, 31 Aug 2026 11:13:22 +0530
Message-ID: <20260831054331.625505-1-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260830_224338_527626_159DF3C1 
X-CRM114-Status: GOOD (  13.56  )
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

pxd_ERROR() macros have been provided by all platforms, which are very much
identical and can be dropped off completely if these pgtable printing could
be moved to callers in generic MM aka all pxd_clear_bad().

But first cleanups and re-organizations are required in some platforms that
are using these macros internally. Afterwards [pte|pmd|pud|p4d|pgd]_ERROR()
macros have been completely dropped from the entire tree.

This series is based on v7.3-rc1 after the following patch and has also been
built tested on multiple platforms.

Changes in V1:

- Moved ptval_to_str() and adjcent declarations inside <include/linux/pgtable.h>
- Fixed type s/ptrval_to_str/ptval_to_str in [PATCH 1/8]
- Dropped PTE_FMT from riscv platform
- Added all tags received

Changes in RFC V3:

https://lore.kernel.org/all/20260818040041.1891769-1-anshuman.khandual@arm.com/

- Moved ptrval_to_str() as header in a separate patch
- Stopped using pxd_ERROR() in generic MM in a separate patch
- Dropped pxd_ERRO() macros from all platforms in a separate patch
- Dropped print_bad_pte() and also cleaned up set_pte_phys()
- Added some pr_error() messages in __get_pte_phys()
- Cleaned up error messages and used ptrval_to_str() in platforms

Changes in RFC V2:

https://lore.kernel.org/all/20260811042119.3652929-1-anshuman.khandual@arm.com/

- Added clean up patches for platforms with existing pxd_ERROR() usage
- Dropped __FILE__ and __LINE__ from all print sections per David

Changes in RFC V1:

https://lore.kernel.org/all/20260806080639.1916749-1-anshuman.khandual@arm.com/

Cc: David Hildenbrand (Arm) <david@kernel.org>
Cc: Mike Rapoport (Microsoft) <rppt@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Lorenzo Stoakes <ljs@kernel.org>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: Rich Felker <dalias@libc.org>
Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
Cc: Helge Deller <deller@gmx.de>
Cc: Huacai Chen <chenhuacai@kernel.org>
Cc: WANG Xuerui <kernel@xen0n.name>
Cc: linux-alpha@vger.kernel.org
Cc: linux-snps-arc@lists.infradead.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-csky@vger.kernel.org
Cc: linux-hexagon@vger.kernel.org
Cc: loongarch@lists.linux.dev
Cc: linux-m68k@lists.linux-m68k.org
Cc: linux-mips@vger.kernel.org
Cc: linux-openrisc@vger.kernel.org
Cc: linux-parisc@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org
Cc: linux-riscv@lists.infradead.org
Cc: linux-s390@vger.kernel.org
Cc: linux-sh@vger.kernel.org
Cc: sparclinux@vger.kernel.org
Cc: linux-um@lists.infradead.org
Cc: linux-arch@vger.kernel.org
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org

Anshuman Khandual (8):
  mm: Make ptval_to_str() generally available
  mm: Stop using pxd_ERROR()
  loongarch/mm: Stop using pte_ERROR()
  parisc/mm: Directly use generic [pmd|pgd]_clear_bad()
  sh/mm: Stop using pte_ERROR()
  sh/mm: Stop using [p4d|pud|pmd]_ERROR()
  sh/mm: Stop using pgd_ERROR()
  mm: Drop pxd_ERROR()

 arch/alpha/include/asm/pgtable.h              |  7 -------
 arch/arc/include/asm/pgtable-levels.h         | 11 ----------
 arch/arm/include/asm/pgtable.h                |  7 -------
 arch/arm/kernel/traps.c                       | 17 ----------------
 arch/arm64/include/asm/pgtable.h              | 15 --------------
 arch/csky/include/asm/pgtable.h               |  4 ----
 arch/hexagon/include/asm/pgtable.h            |  3 ---
 arch/loongarch/include/asm/pgtable.h          | 13 ------------
 arch/loongarch/mm/init.c                      |  4 +++-
 arch/m68k/include/asm/mcf_pgtable.h           |  6 ------
 arch/m68k/include/asm/motorola_pgtable.h      |  8 --------
 arch/m68k/include/asm/sun3_pgtable.h          |  7 -------
 arch/microblaze/include/asm/pgtable.h         |  7 -------
 arch/mips/include/asm/pgtable-32.h            | 10 ----------
 arch/mips/include/asm/pgtable-64.h            | 13 ------------
 arch/nios2/include/asm/pgtable.h              |  7 -------
 arch/openrisc/include/asm/pgtable.h           |  7 -------
 arch/parisc/include/asm/pgtable.h             |  9 ---------
 arch/parisc/kernel/pci-dma.c                  |  6 ++----
 arch/powerpc/include/asm/book3s/32/pgtable.h  |  2 --
 arch/powerpc/include/asm/book3s/64/pgtable.h  |  7 -------
 arch/powerpc/include/asm/nohash/32/pgtable.h  |  2 --
 .../include/asm/nohash/64/pgtable-4k.h        |  3 ---
 arch/powerpc/include/asm/nohash/64/pgtable.h  |  5 -----
 arch/riscv/include/asm/page.h                 |  6 ------
 arch/riscv/include/asm/pgtable-64.h           |  9 ---------
 arch/riscv/include/asm/pgtable.h              |  4 ----
 arch/s390/include/asm/pgtable.h               | 11 ----------
 arch/sh/include/asm/pgtable-3level.h          |  3 ---
 arch/sh/include/asm/pgtable_32.h              | 13 ------------
 arch/sh/mm/init.c                             | 16 ++++++++-------
 arch/sparc/include/asm/pgtable_32.h           |  3 ---
 arch/sparc/include/asm/pgtable_64.h           | 10 ----------
 arch/um/include/asm/pgtable-2level.h          |  7 -------
 arch/um/include/asm/pgtable-4level.h          | 13 ------------
 arch/x86/include/asm/pgtable-2level.h         |  5 -----
 arch/x86/include/asm/pgtable-3level.h         | 11 ----------
 arch/x86/include/asm/pgtable_64.h             | 18 -----------------
 arch/xtensa/include/asm/pgtable.h             |  4 ----
 include/asm-generic/pgtable-nop4d.h           |  1 -
 include/asm-generic/pgtable-nopmd.h           |  1 -
 include/asm-generic/pgtable-nopud.h           |  1 -
 include/linux/pgtable.h                       | 14 +++++++++++++
 mm/memory.c                                   | 15 +-------------
 mm/pgtable-generic.c                          | 20 +++++++++++++++----
 45 files changed, 45 insertions(+), 320 deletions(-)

-- 
2.43.0


