Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0B8CC54E41
	for <linux-um@archiver.kernel.org>; Wed,  6 Mar 2024 23:41:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OHx3bVLlXnvaD4Lk/LqRAXihRU8d5iuk+jHowRU57+A=; b=pGGSDFUPBFKP3VjJbvjXuX5Zyw
	SY9ZYdpiHLSaluW2vYIDWjaJJoJAjrVszMo5ZmDukqNc2f4KAbXIeD1IjyojHZKft0Yk01k+fC6q8
	JTDecu2DAt5O8euPMW/eir5ZXH4gQJNgVFQKLt5QLRhDOZ26iNMdDPx2zab82CHHLJz5WQEolgF6C
	vRsYFA+1BB01RVprH0bGDmQ8bjkFtCv1y3Z7tZzOHvAa5BSa71GNLW1fz4eHxXEwTspjKEjVBLPef
	0LCmdTcB8QUXpUR8PQAcQvI86THNfqxhgw67ovTJrl2UbB0QGM/+HpQHQIF6fXF/OY42S2ZPvfqwP
	2oNg5qbw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ri0t5-00000002HVG-0x7D;
	Wed, 06 Mar 2024 23:41:27 +0000
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3] helo=gandalf.ozlabs.org)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ri0sy-00000002HQ6-0q8Y;
	Wed, 06 Mar 2024 23:41:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1709768472;
	bh=OHx3bVLlXnvaD4Lk/LqRAXihRU8d5iuk+jHowRU57+A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=dfxSn7ESt9feXa7Ah5VgnrgsTR94t0TrfqG0PcTuTf3mOM2nYClb7KzncEO44oWvJ
	 z177IwNoKxwaRwuRElWO9dM9vGP1BGgcQEfox5PbPq0mqdcUVphkGszRXScQ0d7mcO
	 jW4ikoUKpq/rq3DBl50CSj6CPBHJDbwDqtBF6NxW+foiGgFyBpZYE+I728npTZNMg3
	 1t/2+QbQypMyzr9+0O+l4J8vO9YugJeJGU6R2JxmPiIz07vqQ4qeSoMI/Ta1CVt4Pi
	 EW9aQ8ONAeTLEZ2I6yd+B+il/wLckJElOl67KFtvN0q8NsP2LkndTztEXc4YygJJsv
	 te7iy+1YEdhjg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4Tqppm50HGz4wcN;
	Thu,  7 Mar 2024 10:41:04 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Arnd Bergmann <arnd@kernel.org>, Anna-Maria Behnsen
 <anna-maria@linutronix.de>, Thomas Gleixner <tglx@linutronix.de>, Vincenzo
 Frascino <vincenzo.frascino@arm.com>, Kees Cook <keescook@chromium.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Matt Turner <mattst88@gmail.com>, Vineet
 Gupta <vgupta@kernel.org>, Russell King <linux@armlinux.org.uk>, Catalin
 Marinas <catalin.marinas@arm.com>, Guo Ren <guoren@kernel.org>, Brian Cain
 <bcain@quicinc.com>, Huacai Chen <chenhuacai@kernel.org>, Geert
 Uytterhoeven <geert@linux-m68k.org>, Michal Simek <monstr@monstr.eu>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Helge Deller
 <deller@gmx.de>, Christophe Leroy <christophe.leroy@csgroup.eu>, Palmer
 Dabbelt <palmer@dabbelt.com>, John Paul Adrian Glaubitz
 <glaubitz@physik.fu-berlin.de>, Andreas Larsson <andreas@gaisler.com>,
 Richard Weinberger <richard@nod.at>, x86@kernel.org, Max Filippov
 <jcmvbkbc@gmail.com>, Andy Lutomirski <luto@kernel.org>, Jan Kiszka
 <jan.kiszka@siemens.com>, Kieran Bingham <kbingham@kernel.org>, Andrew
 Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
 linux-alpha@vger.kernel.org, linux-snps-arc@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
 linux-hexagon@vger.kernel.org, loongarch@lists.linux.dev,
 linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
 linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
 linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
 sparclinux@vger.kernel.org, linux-um@lists.infradead.org
Subject: Re: [PATCH v2 1/3] arch: consolidate existing CONFIG_PAGE_SIZE_*KB
 definitions
In-Reply-To: <20240306141453.3900574-2-arnd@kernel.org>
References: <20240306141453.3900574-1-arnd@kernel.org>
 <20240306141453.3900574-2-arnd@kernel.org>
Date: Thu, 07 Mar 2024 10:41:02 +1100
Message-ID: <87sf13nd2p.fsf@mail.lhotse>
MIME-Version: 1.0
Content-Type: text/plain
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240306_154120_663912_9E9767F6 
X-CRM114-Status: GOOD (  13.41  )
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

Hi Arnd,

Arnd Bergmann <arnd@kernel.org> writes:
> From: Arnd Bergmann <arnd@arndb.de>
>
> These four architectures define the same Kconfig symbols for configuring
> the page size. Move the logic into a common place where it can be shared
> with all other architectures.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> Changes from v1:
>  - improve Kconfig help texts
>  - fix Hexagon Kconfig
>
>  arch/Kconfig                      | 92 ++++++++++++++++++++++++++++++-
>  arch/hexagon/Kconfig              | 24 ++------
>  arch/hexagon/include/asm/page.h   |  6 +-
>  arch/loongarch/Kconfig            | 21 ++-----
>  arch/loongarch/include/asm/page.h | 10 +---
>  arch/mips/Kconfig                 | 58 ++-----------------
>  arch/mips/include/asm/page.h      | 16 +-----
>  arch/sh/include/asm/page.h        | 13 +----
>  arch/sh/mm/Kconfig                | 42 ++++----------
>  9 files changed, 121 insertions(+), 161 deletions(-)

There's a few "help" lines missing, which breaks the build:

  arch/Kconfig:1134: syntax error
  arch/Kconfig:1133: invalid statement
  arch/Kconfig:1134: invalid statement
  arch/Kconfig:1135:warning: ignoring unsupported character '.'
  arch/Kconfig:1135:warning: ignoring unsupported character '.'
  arch/Kconfig:1135: invalid statement
  arch/Kconfig:1136: invalid statement
  arch/Kconfig:1137:warning: ignoring unsupported character '.'
  arch/Kconfig:1137: invalid statement
  arch/Kconfig:1143: syntax error
  arch/Kconfig:1142: invalid statement
  arch/Kconfig:1143: invalid statement
  arch/Kconfig:1144:warning: ignoring unsupported character '.'
  arch/Kconfig:1144: invalid statement
  arch/Kconfig:1145: invalid statement
  arch/Kconfig:1146: invalid statement
  arch/Kconfig:1147: invalid statement
  arch/Kconfig:1148:warning: ignoring unsupported character '.'
  arch/Kconfig:1148: invalid statement
  make[4]: *** [../scripts/kconfig/Makefile:85: syncconfig] Error 1

Fixup diff is:

diff --git a/arch/Kconfig b/arch/Kconfig
index 56d45a75f625..f2295fa3b48c 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -1130,6 +1130,7 @@ config PAGE_SIZE_16KB
 config PAGE_SIZE_32KB
        bool "32KiB pages"
        depends on HAVE_PAGE_SIZE_32KB
+       help
          Using 32KiB page size will result in slightly higher performance
          kernel at the price of higher memory consumption compared to
          16KiB pages.  This option is available only on cnMIPS cores.
@@ -1139,6 +1140,7 @@ config PAGE_SIZE_32KB
 config PAGE_SIZE_64KB
        bool "64KiB pages"
        depends on HAVE_PAGE_SIZE_64KB
+       help
          Using 64KiB page size will result in slightly higher performance
          kernel at the price of much higher memory consumption compared to
          4KiB or 16KiB pages.


cheers

