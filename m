Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E4B3C77B76
	for <linux-um@archiver.kernel.org>; Mon, 17 Apr 2023 21:51:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=tVYnOxTRyY5QBQZImck59SROLWH8CEVqQEyAwSA4M8k=; b=KAcpSKy8qxnErn
	rKdPhMWIiKxbdwcNNe+FKsCBOadDStbZMXtVhdo8SXECvrxs+Vb8bulsmKhPXFr1SuxWYWXW5SGlZ
	EqiW1C7DYdfUWT1gc8giEa0Fi4SHBp0ThbuY38Hx6xJHIVRsP8hZVJC2U6wTH80fUNX9S2LBDejH9
	5KhR9bEsRDMEnwJq7KHQqrhxCE8Sy7Nk7gk4QTu7utCEMz4G/M7i4OSDwEGXf4mVxgitCQQsySy2S
	bE89eU2p+gl7SvjG7eW7b7OcshixF1AWNw+tiF1FtcCFeBccgJn11L7EmZEBrzHwCD1q8CLOKZvyA
	ZQXE59TFM70a2j/1JO3w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1poWlT-0009BC-0l;
	Mon, 17 Apr 2023 21:51:59 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1poWlP-0009AS-2u;
	Mon, 17 Apr 2023 21:51:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=hd0eSPgOtTAWwT17PjaULR/3wkbhGTdpKJdeXsj3/Vw=; b=fLjNxosK4xKzajEQ/U5lYsoYyJ
	jrQ3zcvJngh68x+LDsUQ8CC/nEyi0fv1cZGoEeI0keex3OEDrLju8Q8lxV6BD73XxiMXP5EWmYSA7
	OrOYqWtm4FTecH1s8B6ti+2XVm8/WP0msexWnFvATYA7wo1HVJACE0MQcmpUBgWJ/PiO/wc8ijGEe
	JwlndbEDLv1x+PX/lqsD9I3N8sy1aIgYko1LFtTWGwqsJI593tP72ReLiXKXCdpVOSWG8ZzvJEKiX
	lHR500CmsnNkXamiwjEgdePaHjzSmq/oGRNH3e3AIumP61pOYseATyHdCCH1XxNu1a0PMQOwdpgAn
	ozFle0Vw==;
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
	by desiato.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1poVqJ-00HS3V-2L;
	Mon, 17 Apr 2023 20:53:06 +0000
Received: by mail-pj1-x102b.google.com with SMTP id fw22-20020a17090b129600b00247255b2f40so13875880pjb.1;
        Mon, 17 Apr 2023 13:52:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681764765; x=1684356765;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hd0eSPgOtTAWwT17PjaULR/3wkbhGTdpKJdeXsj3/Vw=;
        b=pldku0ysKEp0NOEJOd7l0dIaF0yyGvAqpPlnmph3EM3Z2d65YTU4pF9c8hRBI8SIkB
         bXZgcndrjQg15zyEZxLW+H7cAmzYTJGKbe6hTNRu88cjrehCSqACdUD1N8GZKEqBE4Xp
         FwmFpHRnoIb29o3voauSnQ6p7drjWK4VEEwhJEits2ZcgZwb7+ryqE7mhLT9s2Dr91lB
         24kMEEC0owKF37MtG1/RM5nwSQTWlS0iZbYOKzR4iyZZCfaJAgJ4qZTiCg2KEwK1Bku2
         sGcyojF3egYr4Kr1rOZRroFrhK9ZnYopo4hTv+rSWBcsF96wp6BJQzFP7J0YdZ6544dh
         BRmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681764765; x=1684356765;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hd0eSPgOtTAWwT17PjaULR/3wkbhGTdpKJdeXsj3/Vw=;
        b=PapGbxgGOBrLlmAfLvTnse/dz2+qoA50hYuaqJVFv/nFtGWI/udorbVpX7yzVieiGE
         pM1keqcyvkDMtO423iI8pckgc2pvYhabCzIIRjtVys+t5KgtwceKvDEePRWMDbLPpDOA
         dCL4zI2HMo2VWAFmSJC+4bS9sSlNIFbDlhLWUK9s+uX0rR/VW0k/EH33Lup71x8R1Cyp
         e+rytAk/YAXdTRjUhNNsPsZknPHiX7D2i8KkdP6ac2WIhyGCxRYVNOUmvJNzd0HYAdKw
         RAQhCIsV751oKrBgmOg82ynsw8WAHI4vEkVeSYur8bYP4EqCB2sjezfqPG4lnyup9hII
         IhuA==
X-Gm-Message-State: AAQBX9fRI1NIxlG/wzvjZU/Z2JCan0Igwh4OPinQlx3Zmm7texDU8xzW
	IQIIzLCJ+HlG0fBU1B4LVZRvFxVgWGNskw==
X-Google-Smtp-Source: AKy350bJ4sdY66hQiY/gbzNJFaJpsyj9BEPw5KYAOTG4tZNrVmb2RliejTZYzbSXKDavSzAED/FXaQ==
X-Received: by 2002:a17:90b:684:b0:246:f8a8:af02 with SMTP id m4-20020a17090b068400b00246f8a8af02mr15620340pjz.5.1681764765269;
        Mon, 17 Apr 2023 13:52:45 -0700 (PDT)
Received: from fedora.hsd1.ca.comcast.net ([2601:644:937f:7f20::c139])
        by smtp.googlemail.com with ESMTPSA id h7-20020a17090ac38700b0022335f1dae2sm7609707pjt.22.2023.04.17.13.52.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Apr 2023 13:52:44 -0700 (PDT)
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
	"Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [PATCH 00/33] Split ptdesc from struct page
Date: Mon, 17 Apr 2023 13:50:15 -0700
Message-Id: <20230417205048.15870-1-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230417_215257_842569_F31C195C 
X-CRM114-Status: GOOD (  10.34  )
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

This series is rebased on next-20230417.

Vishal Moola (Oracle) (33):
  s390: Use _pt_s390_gaddr for gmap address tracking
  s390: Use pt_frag_refcount for pagetables
  pgtable: Create struct ptdesc
  mm: add utility functions for ptdesc
  mm: Convert pmd_pgtable_page() to pmd_ptdesc()
  mm: Convert ptlock_alloc() to use ptdescs
  mm: Convert ptlock_ptr() to use ptdescs
  mm: Convert pmd_ptlock_init() to use ptdescs
  mm: Convert ptlock_init() to use ptdescs
  mm: Convert pmd_ptlock_free() to use ptdescs
  mm: Convert ptlock_free() to use ptdescs
  mm: Create ptdesc equivalents for pgtable_{pte,pmd}_page_{ctor,dtor}
  powerpc: Convert various functions to use ptdescs
  x86: Convert various functions to use ptdescs
  s390: Convert various gmap functions to use ptdescs
  s390: Convert various pgalloc functions to use ptdescs
  mm: Remove page table members from struct page
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
 arch/arm/mm/mmu.c                             |   6 +-
 arch/arm64/include/asm/tlb.h                  |  14 +-
 arch/arm64/mm/mmu.c                           |   7 +-
 arch/csky/include/asm/pgalloc.h               |   4 +-
 arch/hexagon/include/asm/pgalloc.h            |   8 +-
 arch/loongarch/include/asm/pgalloc.h          |  27 ++-
 arch/loongarch/mm/pgtable.c                   |   7 +-
 arch/m68k/include/asm/mcf_pgalloc.h           |  41 ++--
 arch/m68k/include/asm/sun3_pgalloc.h          |   8 +-
 arch/m68k/mm/motorola.c                       |   4 +-
 arch/mips/include/asm/pgalloc.h               |  31 +--
 arch/mips/mm/pgtable.c                        |   7 +-
 arch/nios2/include/asm/pgalloc.h              |   8 +-
 arch/openrisc/include/asm/pgalloc.h           |   8 +-
 arch/powerpc/mm/book3s64/mmu_context.c        |  10 +-
 arch/powerpc/mm/book3s64/pgtable.c            |  32 +--
 arch/powerpc/mm/pgtable-frag.c                |  46 ++--
 arch/riscv/include/asm/pgalloc.h              |   8 +-
 arch/riscv/mm/init.c                          |  16 +-
 arch/s390/include/asm/pgalloc.h               |   4 +-
 arch/s390/include/asm/tlb.h                   |   4 +-
 arch/s390/mm/gmap.c                           | 218 +++++++++++-------
 arch/s390/mm/pgalloc.c                        | 126 +++++-----
 arch/sh/include/asm/pgalloc.h                 |   8 +-
 arch/sparc/mm/init_64.c                       |  17 +-
 arch/sparc/mm/srmmu.c                         |   5 +-
 arch/um/include/asm/pgalloc.h                 |  18 +-
 arch/x86/mm/pgtable.c                         |  46 ++--
 arch/x86/xen/mmu_pv.c                         |   2 +-
 include/asm-generic/pgalloc.h                 |  62 +++--
 include/asm-generic/tlb.h                     |  11 +
 include/linux/mm.h                            | 138 +++++++----
 include/linux/mm_types.h                      |  14 --
 include/linux/pgtable.h                       |  60 +++++
 mm/memory.c                                   |   8 +-
 38 files changed, 625 insertions(+), 446 deletions(-)

-- 
2.39.2


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
