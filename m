Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D7CDC54E4A
	for <linux-um@archiver.kernel.org>; Mon, 26 Feb 2024 16:14:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=SZ/JLh/NSacC9JehElzjN/XIJz1UVIO+puJM10GPPSI=; b=U4ZI84lGcIj42Y4dBWvVLmpLNh
	b8hHFKeHPirBxp55Zwu6Ac1/IU22XVbEdYPkjcMR9nxDwsvY7kSuPvGkr/ySMYljWpi7Sws+64QuU
	kDaGDMpRjgOhD0osvhNx5aUA0sp6Z2a+kVkrPyBWJfwmhJI7ey9PBA0InaTmCCCGWlVxuGzdEH5px
	NlgI2G3VZOp2z3MbuFr1Xm4zEPsxPRADbQJXxMArbDu2EkmLyrDZrTXwgJD3fgK25tQAipgmZDxf2
	gdvF0xemzJtBR4zVQQ3PusjbPUywLyF2j9/OEqVUm7id8KCeCYsnnpbrPk+/dzZA3n7lsZH0gDqSm
	t/9pj8dg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1redcs-00000001b5j-3lI0;
	Mon, 26 Feb 2024 16:14:46 +0000
Received: from sin.source.kernel.org ([145.40.73.55])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1redcl-00000001b2t-0eIi;
	Mon, 26 Feb 2024 16:14:42 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 68305CE181F;
	Mon, 26 Feb 2024 16:14:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5D63C433C7;
	Mon, 26 Feb 2024 16:14:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708964073;
	bh=zxbqCp3xg1MTZv6nVkuYc0VOPy7Z/0KoLu5xdBZOcDY=;
	h=From:To:Cc:Subject:Date:From;
	b=ouv+E5W1cQ1zHWEvJshxERHNgYSjJzR7JdvZMtKsmjTnnYsjb50xz7yQ6NNDLjL+R
	 zIivYPxRBLqLiotGJhvVTBVfzRjkLFR+UKz+Blle7mLm83hZaxjZLxJiSIm8KsFpk8
	 T2yQYC7g3LmUbscrU9t5jUZdMHfRtyoT7a/p66cZn/Wi8wvAOCFlueNWvORfaCli+Z
	 S5t1BgjPEeJ3eGf1KMTEe7SIO0Rv5QLKXRaKqNQXL1yQWzRzHXLOOgf0gh7VMNEgGS
	 /h/uyIFz30OGZTAygrSMurYRpnmZAOjoQMG9QUrFxlxLnbjp2UPK2IvIxVWUAhRAM9
	 8PLY/d6Nx9Yzg==
From: Arnd Bergmann <arnd@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Kees Cook <keescook@chromium.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Matt Turner <mattst88@gmail.com>,
	Vineet Gupta <vgupta@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Guo Ren <guoren@kernel.org>,
	Brian Cain <bcain@quicinc.com>,
	Huacai Chen <chenhuacai@kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Michal Simek <monstr@monstr.eu>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Helge Deller <deller@gmx.de>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Andreas Larsson <andreas@gaisler.com>,
	Richard Weinberger <richard@nod.at>,
	x86@kernel.org,
	Max Filippov <jcmvbkbc@gmail.com>,
	Andy Lutomirski <luto@kernel.org>,
	Jan Kiszka <jan.kiszka@siemens.com>,
	Kieran Bingham <kbingham@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org,
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
	linux-um@lists.infradead.org
Subject: [PATCH 0/4] arch: mm, vdso: consolidate PAGE_SIZE definition
Date: Mon, 26 Feb 2024 17:14:10 +0100
Message-Id: <20240226161414.2316610-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240226_081441_142650_59285C86 
X-CRM114-Status: GOOD (  17.50  )
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

From: Arnd Bergmann <arnd@arndb.de>

Naresh noticed that the newly added usage of the PAGE_SIZE macro in
include/vdso/datapage.h introduced a build regression. I had an older
patch that I revived to have this defined through Kconfig rather than
through including asm/page.h, which is not allowed in vdso code.

I rebased and tested on top of the tip/timers/core branch that
introduced the regression. If these patches get added, the
compat VDSOs all build again, but the changes are a bit invasive.

      Arnd

Link: https://lore.kernel.org/lkml/CA+G9fYtrXXm_KO9fNPz3XaRxHV7UD_yQp-TEuPQrNRHU+_0W_Q@mail.gmail.com/
Link: https://lore.kernel.org/all/65dc6c14.170a0220.f4a3f.91dd@mx.google.com/

Arnd Bergmann (4):
  arch: consolidate existing CONFIG_PAGE_SIZE_*KB definitions
  arch: simplify architecture specific page size configuration
  arch: define CONFIG_PAGE_SIZE_*KB on all architectures
  vdso: avoid including asm/page.h

 arch/Kconfig                       | 58 ++++++++++++++++++++++++++++--
 arch/alpha/Kconfig                 |  1 +
 arch/alpha/include/asm/page.h      |  2 +-
 arch/arc/Kconfig                   |  3 ++
 arch/arc/include/uapi/asm/page.h   |  6 ++--
 arch/arm/Kconfig                   |  1 +
 arch/arm/include/asm/page.h        |  2 +-
 arch/arm64/Kconfig                 | 29 +++++++--------
 arch/arm64/include/asm/page-def.h  |  2 +-
 arch/csky/Kconfig                  |  1 +
 arch/csky/include/asm/page.h       |  2 +-
 arch/hexagon/Kconfig               | 25 +++----------
 arch/hexagon/include/asm/page.h    |  6 +---
 arch/loongarch/Kconfig             | 21 ++++-------
 arch/loongarch/include/asm/page.h  | 10 +-----
 arch/m68k/Kconfig                  |  3 ++
 arch/m68k/Kconfig.cpu              |  2 ++
 arch/m68k/include/asm/page.h       |  6 +---
 arch/microblaze/Kconfig            |  1 +
 arch/microblaze/include/asm/page.h |  2 +-
 arch/mips/Kconfig                  | 58 +++---------------------------
 arch/mips/include/asm/page.h       | 16 +--------
 arch/nios2/Kconfig                 |  1 +
 arch/nios2/include/asm/page.h      |  2 +-
 arch/openrisc/Kconfig              |  1 +
 arch/openrisc/include/asm/page.h   |  2 +-
 arch/parisc/Kconfig                |  3 ++
 arch/parisc/include/asm/page.h     | 10 +-----
 arch/powerpc/Kconfig               | 31 ++++------------
 arch/powerpc/include/asm/page.h    |  2 +-
 arch/riscv/Kconfig                 |  1 +
 arch/riscv/include/asm/page.h      |  2 +-
 arch/s390/Kconfig                  |  1 +
 arch/s390/include/asm/page.h       |  2 +-
 arch/sh/include/asm/page.h         | 13 +------
 arch/sh/mm/Kconfig                 | 42 +++++++---------------
 arch/sparc/Kconfig                 |  2 ++
 arch/sparc/include/asm/page_32.h   |  2 +-
 arch/sparc/include/asm/page_64.h   |  3 +-
 arch/um/Kconfig                    |  1 +
 arch/um/include/asm/page.h         |  2 +-
 arch/x86/Kconfig                   |  1 +
 arch/x86/include/asm/page_types.h  |  2 +-
 arch/xtensa/Kconfig                |  1 +
 arch/xtensa/include/asm/page.h     |  2 +-
 include/vdso/datapage.h            |  4 +--
 scripts/gdb/linux/constants.py.in  |  2 +-
 scripts/gdb/linux/mm.py            |  2 +-
 48 files changed, 153 insertions(+), 241 deletions(-)

-- 
2.39.2
To: Thomas Gleixner <tglx@linutronix.de>
To: Vincenzo Frascino <vincenzo.frascino@arm.com>
To: Kees Cook <keescook@chromium.org>
To: Anna-Maria Behnsen <anna-maria@linutronix.de>
Cc: Matt Turner <mattst88@gmail.com>
Cc: Vineet Gupta <vgupta@kernel.org>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Guo Ren <guoren@kernel.org>
Cc: Brian Cain <bcain@quicinc.com>
Cc: Huacai Chen <chenhuacai@kernel.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Michal Simek <monstr@monstr.eu>
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: Helge Deller <deller@gmx.de>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Palmer Dabbelt <palmer@dabbelt.com>
Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: Andreas Larsson <andreas@gaisler.com>
Cc: Richard Weinberger <richard@nod.at>
Cc: x86@kernel.org
Cc: Max Filippov <jcmvbkbc@gmail.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Kieran Bingham <kbingham@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org
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

