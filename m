Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7706C54E41
	for <linux-um@archiver.kernel.org>; Wed,  6 Mar 2024 14:15:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=2NVyVWtX83JpVFGJEVt2MXG3hxzuuk7kB6J6mJH088Q=; b=qOGZrP9TlM9oXbRLD7rez5bga6
	fsGApjRwv+PMEbZDyfOKl+dBNoHijv+ZNCjn2ogF+odYWcBYzSYzz1T/NaQeRIx2W88o9/1gqCEwf
	cvpYDBqyAoeI5Q6I10BPqpGe0hRxPlDj0575oM0Tpb2ebW1b6Hm67Oz/4g4P2Zj1+u1o5W6rb0FnU
	lWD+o0HvNxBZIrTiXuO9Uvw/jMph/cUJjn002lQvb3vJgZTeu88yHfwZ6uhbaNhZ4+3FeUbqefra1
	vNTsiCz1K0NyTD5S3zoVk+qpUM96IUkCkgfs65K4TEAkdjne2gqiE7tdql+jrNWx1gvlQ4980I04z
	4MD9KzDw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rhs3K-00000000WYp-1ddS;
	Wed, 06 Mar 2024 14:15:26 +0000
Received: from sin.source.kernel.org ([145.40.73.55])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rhs3F-00000000WWi-0vfA;
	Wed, 06 Mar 2024 14:15:23 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id E69E5CE21D8;
	Wed,  6 Mar 2024 14:15:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F782C433F1;
	Wed,  6 Mar 2024 14:15:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709734517;
	bh=6p2hAt3DJTtWEmWkGiNmsPvIqV/lUSZTutyoSUX5wpE=;
	h=From:To:Cc:Subject:Date:From;
	b=LqIp2kZTKEk6BDtlGN9YtFBVHmwGfTij/0yFkUBE5XGhta0eqXHuPZZJ3/MIusuUG
	 1/ai7edE6AbiuxHWjDBSN5GwSx4jO1RwWivNR0PUtakQUcitU1uJh1+vHWYGSiPn+I
	 /dBaVrtPErxMiFpuWjYe3LW95xWi64gxsDrEvpuJ8OizSORBDPypoeSsLWyXEUGdmf
	 fJeiWqTrhJi5qxh7Jya6058wrIYZrMi99CnlK2WXNiIm+MJuSG+gSvaihlsEMOBWt5
	 2fKuqVl7eyYLUWkzPRqLl2zDWANVIuecGX2Qr2I58K0QII0FK3WksaSXHLTuDSmpIM
	 TYoPCbqqY5j5A==
From: Arnd Bergmann <arnd@kernel.org>
To: Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Kees Cook <keescook@chromium.org>
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
Subject: [v2 PATCH 0/3] arch: mm, vdso: consolidate PAGE_SIZE definition
Date: Wed,  6 Mar 2024 15:14:50 +0100
Message-Id: <20240306141453.3900574-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240306_061521_665102_617B28E2 
X-CRM114-Status: GOOD (  18.52  )
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

The vdso patch series now has a temporary workaround, but I still want to
get this into v6.9 so we can place the hack with CONFIG_PAGE_SIZE
in the vdso.

I've applied this to the asm-generic tree already, please let me know if
there are still remaining issues. It's really close to the merge window
already, so I'd probably give this a few more days before I send a pull
request, or defer it to v6.10 if anything goes wrong.

Sorry for the delay, I was still waiting to resolve the m68k question,
but there were no further replies in the end, so I kept my original
version.

Changes from v1:

 - improve Kconfig help texts
 - remove an extraneous line in hexagon

      Arnd

Link: https://lore.kernel.org/lkml/CA+G9fYtrXXm_KO9fNPz3XaRxHV7UD_yQp-TEuPQrNRHU+_0W_Q@mail.gmail.com/
Link: https://lore.kernel.org/all/65dc6c14.170a0220.f4a3f.91dd@mx.google.com/
Link: https://lore.kernel.org/lkml/20240226161414.2316610-1-arnd@kernel.org/

Arnd Bergmann (3):
  arch: consolidate existing CONFIG_PAGE_SIZE_*KB definitions
  arch: simplify architecture specific page size configuration
  arch: define CONFIG_PAGE_SIZE_*KB on all architectures

 arch/Kconfig                       | 92 +++++++++++++++++++++++++++++-
 arch/alpha/Kconfig                 |  1 +
 arch/alpha/include/asm/page.h      |  2 +-
 arch/arc/Kconfig                   |  3 +
 arch/arc/include/uapi/asm/page.h   |  6 +-
 arch/arm/Kconfig                   |  1 +
 arch/arm/include/asm/page.h        |  2 +-
 arch/arm64/Kconfig                 | 29 +++++-----
 arch/arm64/include/asm/page-def.h  |  2 +-
 arch/csky/Kconfig                  |  1 +
 arch/csky/include/asm/page.h       |  2 +-
 arch/hexagon/Kconfig               | 24 ++------
 arch/hexagon/include/asm/page.h    |  6 +-
 arch/loongarch/Kconfig             | 21 ++-----
 arch/loongarch/include/asm/page.h  | 10 +---
 arch/m68k/Kconfig                  |  3 +
 arch/m68k/Kconfig.cpu              |  2 +
 arch/m68k/include/asm/page.h       |  6 +-
 arch/microblaze/Kconfig            |  1 +
 arch/microblaze/include/asm/page.h |  2 +-
 arch/mips/Kconfig                  | 58 ++-----------------
 arch/mips/include/asm/page.h       | 16 +-----
 arch/nios2/Kconfig                 |  1 +
 arch/nios2/include/asm/page.h      |  2 +-
 arch/openrisc/Kconfig              |  1 +
 arch/openrisc/include/asm/page.h   |  2 +-
 arch/parisc/Kconfig                |  3 +
 arch/parisc/include/asm/page.h     | 10 +---
 arch/powerpc/Kconfig               | 31 ++--------
 arch/powerpc/include/asm/page.h    |  2 +-
 arch/riscv/Kconfig                 |  1 +
 arch/riscv/include/asm/page.h      |  2 +-
 arch/s390/Kconfig                  |  1 +
 arch/s390/include/asm/page.h       |  2 +-
 arch/sh/include/asm/page.h         | 13 +----
 arch/sh/mm/Kconfig                 | 42 ++++----------
 arch/sparc/Kconfig                 |  2 +
 arch/sparc/include/asm/page_32.h   |  2 +-
 arch/sparc/include/asm/page_64.h   |  3 +-
 arch/um/Kconfig                    |  1 +
 arch/um/include/asm/page.h         |  2 +-
 arch/x86/Kconfig                   |  1 +
 arch/x86/include/asm/page_types.h  |  2 +-
 arch/xtensa/Kconfig                |  1 +
 arch/xtensa/include/asm/page.h     |  2 +-
 scripts/gdb/linux/constants.py.in  |  2 +-
 scripts/gdb/linux/mm.py            |  2 +-
 47 files changed, 185 insertions(+), 238 deletions(-)

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

