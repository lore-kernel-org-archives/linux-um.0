Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 569D4C636D4
	for <linux-um@archiver.kernel.org>; Sun, 29 Jan 2023 12:43:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=0P9ldSP0r01tzTRp9Gjp5rnuV74hKw2UOO/NzA5V6Xs=; b=Qqk6uucfLxGLEQ
	caVda3ZrqqUp82zDlk/qklTBEaR8rsKE3Xxv6ehxFBStCRukbySTzvAL9ZLGQvwmRNBr+4S1Rawl7
	3baLf9KxSw59Uzxzd8+PhCqPk1RscwNlBSEDiEZyt/nhLhhG3LWJYzoty7+B3IVpCReromBvj/YgZ
	IiEC81SL7eY913pc/FylZUnd6O9oTmsqn0F0LnbPJK+iLVkc6bd+XgX98OOSlLiR+eEDkyP+HFIDC
	iTNrVIMv3Jr6def2ddSvYW8Vsir35+PLzo7Fo9bq7go0QXdhiox6amGtSb3G4uUcj0ndn/N5i4G3O
	FmbaZxPUy4NWK7xH7lwQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pM71g-001RVt-CW; Sun, 29 Jan 2023 12:43:16 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pM71Q-001RRe-Kk; Sun, 29 Jan 2023 12:43:02 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 5C2F760D30;
	Sun, 29 Jan 2023 12:42:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E716EC433D2;
	Sun, 29 Jan 2023 12:42:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1674996176;
	bh=8RQZps3hA/u1mdRRQGYSzSx3iKFm4iTs/37kan3EXRs=;
	h=From:To:Cc:Subject:Date:From;
	b=nZUZmSKw7/syf9RrBIFurd/O3AkMNzmfegfK+1AS6FvCaH0OhJOzBAu3UXC6av8P5
	 uY9AOa46F/d5yj77Ho8Ndgvw8xxJHw4nNHTmwjtslAXWyegt5vS1IKaYW+Stnwyuiy
	 2a+kHtcUtcTQ5Rqh9d7F2WecpHec0CXwi5TSyt1qClHpJLOA2sydJTb6OF8VZPCNps
	 3fd8EBQ67Wgcl+xTfrf7oQnKtinBQv8tebZZGSc5tamZZbBvwb6yYhdPyn1uALV1nu
	 d2H6gUYCo1lWTN9F7fs+AKTM2279BJ7XhGhJhYj0+jZo3axy2AgunU1xbS8ZdbQ6oz
	 oCSDE8gtPikyw==
From: Mike Rapoport <rppt@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Brian Cain <bcain@quicinc.com>,
	"David S. Miller" <davem@davemloft.net>,
	Dinh Nguyen <dinguyen@kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Greg Ungerer <gerg@linux-m68k.org>,
	Guo Ren <guoren@kernel.org>,
	Helge Deller <deller@gmx.de>,
	Huacai Chen <chenhuacai@kernel.org>,
	Matt Turner <mattst88@gmail.com>,
	Max Filippov <jcmvbkbc@gmail.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Michal Simek <monstr@monstr.eu>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Rich Felker <dalias@libc.org>,
	Richard Weinberger <richard@nod.at>,
	Russell King <linux@armlinux.org.uk>,
	Stafford Horne <shorne@gmail.com>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Vineet Gupta <vgupta@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	linux-alpha@vger.kernel.org,
	linux-arch@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-csky@vger.kernel.org,
	linux-hexagon@vger.kernel.org,
	linux-ia64@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-m68k@lists.linux-m68k.org,
	linux-mips@vger.kernel.org,
	linux-mm@kvack.org,
	linux-parisc@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-sh@vger.kernel.org,
	linux-snps-arc@lists.infradead.org,
	linux-um@lists.infradead.org,
	linux-xtensa@linux-xtensa.org,
	linuxppc-dev@lists.ozlabs.org,
	loongarch@lists.linux.dev,
	openrisc@lists.librecores.org,
	sparclinux@vger.kernel.org,
	x86@kernel.org,
	"Mike Rapoport (IBM)" <rppt@kernel.org>
Subject: [PATCH v2 0/4] mm, arch: add generic implementation of pfn_valid() for FLATMEM
Date: Sun, 29 Jan 2023 14:42:31 +0200
Message-Id: <20230129124235.209895-1-rppt@kernel.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230129_044300_804585_6D58448E 
X-CRM114-Status: GOOD (  11.46  )
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

From: "Mike Rapoport (IBM)" <rppt@kernel.org>

Hi,

Every architecture that supports FLATMEM memory model defines its own
version of pfn_valid() that essentially compares a pfn to max_mapnr.

Use mips/powerpc version implemented as static inline as a generic
implementation of pfn_valid() and drop its per-architecture definitions

v2:
* fix build on ARM and xtensa
* add Acked- and Reviewed-by, thanks everybody

v1: https://lore.kernel.org/all/20230125190757.22555-1-rppt@kernel.org

Mike Rapoport (IBM) (4):
  arm: include asm-generic/memory_model.h from page.h rather than
    memory.h
  m68k: use asm-generic/memory_model.h for both MMU and !MMU
  mips: drop definition of pfn_valid() for DISCONTIGMEM
  mm, arch: add generic implementation of pfn_valid() for FLATMEM

 arch/alpha/include/asm/page.h      |  4 ----
 arch/arc/include/asm/page.h        |  1 -
 arch/arm/include/asm/memory.h      |  2 --
 arch/arm/include/asm/page.h        |  2 ++
 arch/csky/include/asm/page.h       |  1 -
 arch/hexagon/include/asm/page.h    |  1 -
 arch/ia64/include/asm/page.h       |  4 ----
 arch/loongarch/include/asm/page.h  | 13 -------------
 arch/m68k/include/asm/page.h       |  6 +-----
 arch/m68k/include/asm/page_mm.h    |  1 -
 arch/m68k/include/asm/page_no.h    |  4 ----
 arch/microblaze/include/asm/page.h |  1 -
 arch/mips/include/asm/page.h       | 28 ----------------------------
 arch/nios2/include/asm/page.h      |  9 ---------
 arch/openrisc/include/asm/page.h   |  2 --
 arch/parisc/include/asm/page.h     |  4 ----
 arch/powerpc/include/asm/page.h    |  9 ---------
 arch/riscv/include/asm/page.h      |  5 -----
 arch/sh/include/asm/page.h         |  3 ---
 arch/sparc/include/asm/page_32.h   |  1 -
 arch/um/include/asm/page.h         |  1 -
 arch/x86/include/asm/page_32.h     |  4 ----
 arch/x86/include/asm/page_64.h     |  4 ----
 arch/xtensa/include/asm/page.h     |  4 ++--
 include/asm-generic/memory_model.h | 12 ++++++++++++
 include/asm-generic/page.h         |  2 --
 26 files changed, 17 insertions(+), 111 deletions(-)


base-commit: 2241ab53cbb5cdb08a6b2d4688feb13971058f65
-- 
2.35.1


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
