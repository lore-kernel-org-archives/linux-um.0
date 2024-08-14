Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFC60C52D7D
	for <linux-um@archiver.kernel.org>; Wed, 14 Aug 2024 15:44:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=Y8GzTtU2QoStw/WgTavIsPk3vntaV6mcfxUlw+vTkw4=; b=ItErEizn1TJJj5YntemBkIIwTJ
	7bqEBKXof88QyKREx8BZR7ITcR2MfxhCERPV8p+CA5r5f+Dk3RMPhd6QguRAiE0CCEzxPL4V3A81X
	/fzrbRfCvhlkpVFXL/b2EypFBPLQs0XTW+VTbCYv+3VkmYDqMaJknxlvR/M70gngcqsgaN26uGSzg
	CRWV56JQln4rZz+t1FjP9/h60Gc+qRNg9Uog63OXvyqmPSlQjcniRvz/wk1ZZjxGVcO1e/5ZO70tn
	p0UWcjLrFB2uSWxTvOSzDCHKA/sb8XOmtal3pj5gzrcGd1uAJfAicMnjjh3+A3tQQb/dI1Np8r66E
	PzicOBtw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1seGBF-00000007WF6-3uXb;
	Wed, 14 Aug 2024 15:44:57 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1seGAt-00000007W42-0lRH
	for linux-um@bombadil.infradead.org;
	Wed, 14 Aug 2024 15:44:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=Y8GzTtU2QoStw/WgTavIsPk3vntaV6mcfxUlw+vTkw4=; b=Nlp68Wv4gWlG8g9amXu9RSnoTE
	bGIkORrON8YDkyXuNB3pHR0x3EWS8Cj46g5V0nmkoNra8NLu3eoLcdQDcSfXtQUcNoQv73JbO5irY
	YO/2KtHV5uYXpcKre5wKy5/4Hv3pAdgjf5CgBoylTiilTIclax+k/Y1qqeGMWDIu25oBopw+ZSuo/
	+PbCg3gzutTroTrptbNhWjqMZBqJlVGdigr+h7eL9Gwfxuq3uaXQEiYu6lJesN6VHloOF2NJxcVQ5
	g8Bi5zp2BmmvlEC8p4EYP5Qf2CZacyuv2wEMcW0vqzDern12I/bCWq9yZIfLqu4qinNlF3KSoMUbe
	DgnzBqVg==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1seGAr-00000000gH2-3gSE;
	Wed, 14 Aug 2024 15:44:33 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: linux-mm@kvack.org,
	linux-arch@vger.kernel.org
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-s390@vger.kernel.org,
	linux-um@lists.infradead.org,
	x86@kernel.org
Subject: [PATCH 0/5] Provide a single definition of mk_pte()
Date: Wed, 14 Aug 2024 16:44:20 +0100
Message-ID: <20240814154427.162475-1-willy@infradead.org>
X-Mailer: git-send-email 2.45.2
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

Each architecturee must provide a definition of mk_pte() today.  They must
also provide pfn_pte().  Usually the former is defined in terms of the
latter, but not on some architectures.  I was trying to decide what we
should do for creating PTEs in a folio world, and it struck me that we
should have architectures only provide pfn_pte() and then I don't need
to trouble the arch maintainers with whatever MM API I come up with.

The architectures not on the cc list I considered trivial.  The
architectures who have named patches are less trivial, and I did my
best to write a decent commit message explaining why I did what I did
to each architecture.

I have some followup patches which remove folio->page conversions, but
if this set of patches are wrong on any architecture, then they'll also
be wrong, so I'm not sending them right now.

Matthew Wilcox (Oracle) (5):
  mm: Introduce a common definition of mk_pte()
  x86: Remove custom definition of mk_pte()
  um: Remove custom definition of mk_pte()
  s390: Remove custom definition of mk_pte()
  mm: Make mk_pte() definition unconditional

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
 arch/parisc/include/asm/pgtable.h        |  2 --
 arch/powerpc/include/asm/pgtable.h       |  1 -
 arch/riscv/include/asm/pgtable.h         |  2 --
 arch/s390/include/asm/pgtable.h          | 10 ----------
 arch/sh/include/asm/pgtable_32.h         |  8 --------
 arch/sparc/include/asm/pgtable_32.h      |  9 ++-------
 arch/sparc/include/asm/pgtable_64.h      |  1 -
 arch/um/include/asm/pgtable-2level.h     |  1 -
 arch/um/include/asm/pgtable-3level.h     |  9 ---------
 arch/um/include/asm/pgtable.h            | 17 ++++++++++-------
 arch/x86/include/asm/pgtable.h           | 19 +++----------------
 arch/xtensa/include/asm/pgtable.h        |  1 -
 include/linux/pgtable.h                  |  5 +++++
 27 files changed, 20 insertions(+), 134 deletions(-)

-- 
2.43.0


