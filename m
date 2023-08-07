Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0ACCCC001B0
	for <linux-um@archiver.kernel.org>; Mon,  7 Aug 2023 23:05:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=vmx7KeDa7i2yfbxW1AEAxUZspF6evvkjdouITdCZaQM=; b=YfoPMUGv0ipWP9
	wR7AYU/YVzfZEEtH7q/UgoDzml2a8kcH37s72HCqsHH4WT4SL8/kYUFwg32dWCer3c34nBWiPCAxN
	F0VzsZ802q8E3ulQ0PfxYlXJhzoe8GuFVrZgIYbe6GWvv5vhPDVtHexT5x+xDugZM+HsAvXfLOalp
	h8sMiouR15jcbazjFjHz5Q4x6PZgRKTR4JqsaU6Gwep8l9bvRW0F5Fawq1hzQKvtzvexrBBPll67M
	FhcHYDRBf6FseTMpaabEI/ZD33Un4Kcx3ZpxG5rpmjj6RdE1dcGzukkkwhj2+OfUAe2cUuc9GVc80
	ZfJS6+iQxb18AaUKAbQg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qT9Hy-0014Qm-1E;
	Mon, 07 Aug 2023 23:05:26 +0000
Received: from mail-oi1-x230.google.com ([2607:f8b0:4864:20::230])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qT9Hs-0014Nf-3A;
	Mon, 07 Aug 2023 23:05:22 +0000
Received: by mail-oi1-x230.google.com with SMTP id 5614622812f47-3a6f87b2993so3744655b6e.3;
        Mon, 07 Aug 2023 16:05:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691449518; x=1692054318;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BgGe0Il0C7dlkrriaFCN0meYItalZZUDKy884yxXSME=;
        b=kkOLGueMrzxHvvdT5O8JIC8nC89W6/6UqoBnx7sB0VLAWpoO0/QHm5tLARAi96zyvU
         EAiiieHkpJTC9s5qvXPj39j6R2OQuCyqiEOwPTIq50/LHvV7fjReDxpsCX5Ya8M70FRF
         Bv+KZVFj7Mytss2brk2EH7Z9tHAP9yxEVCzntaEZzdSmQz9vPa1mUTDeJlBFV79lhO4m
         YdB4aoA79x9pkxJ/XBt7ZG1CR58HGrAi0v/zgewNhzm8aq6TJsefwLnAAAHjOqkPytFk
         EiZRzEbAgPBMpklpMOtlFM2muNSx1qBww2MBrDwGN8Akv7FqeHgJ4R5d3wn1SAH6io9W
         CEdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691449518; x=1692054318;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BgGe0Il0C7dlkrriaFCN0meYItalZZUDKy884yxXSME=;
        b=G9s5HuB3sGHnm817sixn9qF5FqLDvNBqvFMJrTOnlnwsN3Eljco9SkAnEGth+iDSZC
         TGd8h+9RSpGUY9NGrpSqlIstnuIrLI7M7CjJeVjsez1oMv05u2r90+1d3OzhhcTo6KF2
         ks0s9EejROmKQi2OwWzrKVAGvon3eR2KKKLqqMUFhq4x5x9mbvlbu2i5XPhG2R/qvGsL
         XkhFqH8cDwzfMPYYZWJM4ptODL14FDjCJ3QL4NVyHiPVe8+UrJFZizfOsmNDVZoAj+LF
         lmKB+xGCoGOctARIPQsjo0Gl0YZXFnw2qe5baPKUq8FNOTCtwm5W13VIgswWZtEJGaBk
         9yBQ==
X-Gm-Message-State: AOJu0YzXtbrqYG8dspS1W0G2CBDUUtQOTxqV7/VUlqoxa583VvzwD8Bm
	Crt1r+wtapn3tj3aduUDrPw=
X-Google-Smtp-Source: AGHT+IHI1CCxgU6LoWPuJYJEyHtYip1YJBCUFIlnO8SlV49xsFZp+VSY6a51skH1ZTqS0RRAJqit6Q==
X-Received: by 2002:aca:d12:0:b0:3a1:f237:ec62 with SMTP id 18-20020aca0d12000000b003a1f237ec62mr10346742oin.48.1691449518360;
        Mon, 07 Aug 2023 16:05:18 -0700 (PDT)
Received: from unknowna0e70b2ca394.attlocal.net ([2600:1700:2f7d:1800::16])
        by smtp.googlemail.com with ESMTPSA id d190-20020a25cdc7000000b00d3596aca5bcsm2545203ybf.34.2023.08.07.16.05.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 16:05:17 -0700 (PDT)
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
	Hugh Dickins <hughd@google.com>,
	"Vishal Moola (Oracle)" <vishal.moola@gmail.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Huacai Chen <chenhuacai@kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Dinh Nguyen <dinguyen@kernel.org>,
	Jonas Bonn <jonas@southpole.se>,
	David Hildenbrand <david@redhat.com>,
	Claudio Imbrenda <imbrenda@linux.ibm.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	"David S. Miller" <davem@davemloft.net>,
	Richard Weinberger <richard@nod.at>,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH mm-unstable v9 00/31] Split ptdesc from struct page
Date: Mon,  7 Aug 2023 16:04:42 -0700
Message-Id: <20230807230513.102486-1-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230807_160521_024750_F93B75FF 
X-CRM114-Status: GOOD (  11.39  )
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

The MM subsystem is trying to shrink struct page. This patchset
introduces a memory descriptor for page table tracking - struct ptdesc.

This patchset introduces ptdesc, splits ptdesc from struct page, and
converts many callers of page table constructor/destructors to use ptdescs.

Ptdesc is a foundation to further standardize page tables, and eventually
allow for dynamic allocation of page tables independent of struct page.
However, the use of pages for page table tracking is quite deeply
ingrained and varied across archictectures, so there is still a lot of
work to be done before that can happen.

This applies cleanly onto the current unstable after dropping v8 of this
series.

v9:
  Fix build errors for NOMMU configs - trying to define ptdesc before
spinlock_t and struct page were defined.
  Moved definition of struct ptdesc to include/linux/mm_types.h instead
include/linux/pgtable.h

Vishal Moola (Oracle) (31):
  mm: Add PAGE_TYPE_OP folio functions
  pgtable: create struct ptdesc
  mm: add utility functions for ptdesc
  mm: Convert pmd_pgtable_page() callers to use pmd_ptdesc()
  mm: Convert ptlock_alloc() to use ptdescs
  mm: Convert ptlock_ptr() to use ptdescs
  mm: Convert pmd_ptlock_init() to use ptdescs
  mm: Convert ptlock_init() to use ptdescs
  mm: Convert pmd_ptlock_free() to use ptdescs
  mm: Convert ptlock_free() to use ptdescs
  mm: Create ptdesc equivalents for pgtable_{pte,pmd}_page_{ctor,dtor}
  powerpc: Convert various functions to use ptdescs
  x86: Convert various functions to use ptdescs
  s390: Convert various pgalloc functions to use ptdescs
  mm: remove page table members from struct page
  pgalloc: Convert various functions to use ptdescs
  arm: Convert various functions to use ptdescs
  arm64: Convert various functions to use ptdescs
  csky: Convert __pte_free_tlb() to use ptdescs
  hexagon: Convert __pte_free_tlb() to use ptdescs
  loongarch: Convert various functions to use ptdescs
  m68k: Convert various functions to use ptdescs
  mips: Convert various functions to use ptdescs
  nios2: Convert __pte_free_tlb() to use ptdescs
  openrisc: Convert __pte_free_tlb() to use ptdescs
  riscv: Convert alloc_{pmd, pte}_late() to use ptdescs
  sh: Convert pte_free_tlb() to use ptdescs
  sparc64: Convert various functions to use ptdescs
  sparc: Convert pgtable_pte_page_{ctor, dtor}() to ptdesc equivalents
  um: Convert {pmd, pte}_free_tlb() to use ptdescs
  mm: Remove pgtable_{pmd, pte}_page_{ctor, dtor}() wrappers

 Documentation/mm/split_page_table_lock.rst    |  12 +-
 .../zh_CN/mm/split_page_table_lock.rst        |  14 +-
 arch/arm/include/asm/tlb.h                    |  12 +-
 arch/arm/mm/mmu.c                             |   7 +-
 arch/arm64/include/asm/tlb.h                  |  14 +-
 arch/arm64/mm/mmu.c                           |   7 +-
 arch/csky/include/asm/pgalloc.h               |   4 +-
 arch/hexagon/include/asm/pgalloc.h            |   8 +-
 arch/loongarch/include/asm/pgalloc.h          |  27 ++--
 arch/loongarch/mm/pgtable.c                   |   7 +-
 arch/m68k/include/asm/mcf_pgalloc.h           |  47 +++---
 arch/m68k/include/asm/sun3_pgalloc.h          |   8 +-
 arch/m68k/mm/motorola.c                       |   4 +-
 arch/mips/include/asm/pgalloc.h               |  32 ++--
 arch/mips/mm/pgtable.c                        |   8 +-
 arch/nios2/include/asm/pgalloc.h              |   8 +-
 arch/openrisc/include/asm/pgalloc.h           |   8 +-
 arch/powerpc/mm/book3s64/mmu_context.c        |  10 +-
 arch/powerpc/mm/book3s64/pgtable.c            |  32 ++--
 arch/powerpc/mm/pgtable-frag.c                |  58 +++----
 arch/riscv/include/asm/pgalloc.h              |   8 +-
 arch/riscv/mm/init.c                          |  16 +-
 arch/s390/include/asm/pgalloc.h               |   4 +-
 arch/s390/include/asm/tlb.h                   |   4 +-
 arch/s390/mm/pgalloc.c                        | 128 +++++++--------
 arch/sh/include/asm/pgalloc.h                 |   9 +-
 arch/sparc/mm/init_64.c                       |  17 +-
 arch/sparc/mm/srmmu.c                         |   5 +-
 arch/um/include/asm/pgalloc.h                 |  18 +--
 arch/x86/mm/pgtable.c                         |  47 +++---
 arch/x86/xen/mmu_pv.c                         |   2 +-
 include/asm-generic/pgalloc.h                 |  88 +++++-----
 include/asm-generic/tlb.h                     |  11 ++
 include/linux/mm.h                            | 151 +++++++++++++-----
 include/linux/mm_types.h                      |  97 ++++++++---
 include/linux/page-flags.h                    |  30 +++-
 mm/memory.c                                   |   8 +-
 37 files changed, 585 insertions(+), 385 deletions(-)

-- 
2.40.1


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
