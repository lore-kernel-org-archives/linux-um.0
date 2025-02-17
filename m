Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFABBC021B0
	for <linux-um@archiver.kernel.org>; Mon, 17 Feb 2025 19:10:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=xPK3eVt9+7xzyAPyUDSt55ICTTIrX4D95c1avul6TRk=; b=NO9ipjdzTJVo+bdLtwrAF+nkNS
	ktZiDSp6kbSTQ7nl49UF7/c/Oc3u4H5pibk94LALSN54LF2yb8Og98vzDnZZH6G6LtBx76nYWjEsS
	Kt4JH0J0AgK3fKDGU3aHmS9SCv4DN++Crz4t3QZgbTWG/DVuORYpOZRhCPcHyhxp5am7ov0MrPIH5
	T4ihsD8vtWVBqFEH+Xh57l33hUzCe4iFOPMu7mebnTJK07PTCGpajenD2/w05OfZsyQAZjhpfTXPp
	ORFVdgWhfXZBBISTuqGtXCltfHMTE4dmrNxTyy2GISYEA7lZ8eiMBnYNha1C7hKrDQ+goZ5SL56K0
	0JueKWIA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tk6W2-00000005iN8-2AlZ;
	Mon, 17 Feb 2025 19:10:50 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tk6U1-00000005hyJ-3nPX
	for linux-um@bombadil.infradead.org;
	Mon, 17 Feb 2025 19:08:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=xPK3eVt9+7xzyAPyUDSt55ICTTIrX4D95c1avul6TRk=; b=Jz34MUBk12WoNx3nG8DYnhoKOG
	5TdzeRiHmtpKkxk3YXdh4WT9xz/u9O9dg4xXajm73CZ4nwIf4hXUUIxmUVzFDLLEyA49LyHVhFg/9
	jU6cGlj48Pp3AWlNkp0kOGJcYR/oBWOnJAzuGrKSBapUz5885RV7u33SS6rGZosC/WoLJ7AznBLb/
	EZvh5DXpj7mTNzZeCv/ZM98Mo2dpj/YL54x3ceiSxdjzRgT8zbBhqErxpxXc0wRy2tCqrBVz6bvp+
	cPfmrAjIb2VvaLUmvPF5AYOczpX9oO0vXS9N0GfX3WQ14h4ExIX+z2eRJHTarDPAnImAruOehyCzZ
	6W7zMzMw==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tk6Tu-00000001pBB-2EX9;
	Mon, 17 Feb 2025 19:08:38 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: linux-mm@kvack.org
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-arch@vger.kernel.org,
	x86@kernel.org,
	linux-s390@vger.kernel.org,
	sparclinux@vger.kernel.org,
	linux-um@lists.infradead.org
Subject: [PATCH 0/7] Add folio_mk_pte() and simplify mk_pte()
Date: Mon, 17 Feb 2025 19:08:27 +0000
Message-ID: <20250217190836.435039-1-willy@infradead.org>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

The intent is to add folio_mk_pte() to remove the conversion from folio
to page necessary to call mk_pte().  Eventually we might end up removing
mk_pte(), but that's not what's being proposed today.

I didn't want to add folio_mk_pte() to each architecture, and I didn't
want to lose any optimisations that architectures have from their own
implementation of mk_pte().  Fortunately, most architectures have by
now turned their mk_pte() into a fairly bland variant of pfn_pte(),
but s390 is different.

So patch 1 hoists the optimisation of calling pte_mkdirty() from s390
to generic code.  I'd appreciate some eyes on this from mm people who
understand this better than I do.  I originally had

-	if (write)
+	if (write || folio_test_dirty(folio))
		entry = maybe_mkwrite(pte_mkdirty(entry), vma);

and I think that broke COW under some circumstances that 01.org could
reproduce and I couldn't.

The various architecture maintainers might care to make sure that what
I've done is an equivalent transformation.  x86 was particularly tricky.
The build bots say it works ... at least now I've dealt with the pesky
!MMU problem.

The last patch to actually use folio_mk_pte() ought to be the least likely
to have a problem  since it's equivalent to calling mk_pte(&folio->page).

Matthew Wilcox (Oracle) (7):
  mm: Set the pte dirty if the folio is already dirty
  mm: Introduce a common definition of mk_pte()
  sparc32: Remove custom definition of mk_pte()
  x86: Remove custom definition of mk_pte()
  um: Remove custom definition of mk_pte()
  mm: Make mk_pte() definition unconditional
  mm: Add folio_mk_pte()

 arch/alpha/include/asm/pgtable.h         |  7 -------
 arch/arc/include/asm/pgtable-levels.h    |  1 -
 arch/arm/include/asm/pgtable.h           |  1 -
 arch/arm64/include/asm/pgtable.h         |  6 ------
 arch/csky/include/asm/pgtable.h          |  5 -----
 arch/hexagon/include/asm/pgtable.h       |  3 ---
 arch/loongarch/include/asm/pgtable.h     |  6 ------
 arch/m68k/include/asm/mcf_pgtable.h      |  6 ------
 arch/m68k/include/asm/motorola_pgtable.h |  6 ------
 arch/m68k/include/asm/sun3_pgtable.h     |  6 ------
 arch/microblaze/include/asm/pgtable.h    |  8 --------
 arch/mips/include/asm/pgtable.h          |  6 ------
 arch/nios2/include/asm/pgtable.h         |  6 ------
 arch/openrisc/include/asm/pgtable.h      |  2 --
 arch/parisc/include/asm/pgtable.h        |  6 ------
 arch/powerpc/include/asm/pgtable.h       |  3 +--
 arch/riscv/include/asm/pgtable.h         |  2 --
 arch/s390/include/asm/pgtable.h          | 10 ----------
 arch/sh/include/asm/pgtable_32.h         |  8 --------
 arch/sparc/include/asm/pgtable_32.h      | 15 +++++----------
 arch/sparc/include/asm/pgtable_64.h      |  1 -
 arch/um/include/asm/pgtable-2level.h     |  1 -
 arch/um/include/asm/pgtable-4level.h     |  9 ---------
 arch/um/include/asm/pgtable.h            | 18 ++++++++----------
 arch/x86/include/asm/pgtable.h           | 19 +++----------------
 arch/xtensa/include/asm/pgtable.h        |  6 ------
 include/linux/mm.h                       | 22 ++++++++++++++++++++++
 mm/memory.c                              |  8 +++++---
 mm/userfaultfd.c                         |  2 +-
 29 files changed, 45 insertions(+), 154 deletions(-)

-- 
2.47.2


