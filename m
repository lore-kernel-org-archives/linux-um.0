Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 503F3C54798
	for <linux-um@archiver.kernel.org>; Tue, 27 Feb 2024 13:46:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MoE3Qct5U8+LLRW28dCD9D3KdKx02ozSB8fXqU9GVOY=; b=M08iZ4rdp2bIvOkiJKJi9bsdGC
	8eTFL8sP9NvMYaAHsNKXw1EkN2AaqNERptDKQgk4EbaIMRP+AQdg6BusJ4SvssJhIKWofjhNrmhLX
	x4GsBthHn+ONsPqDpOGPvzgIgwknk9g1LPaM9MPLNupRTkTRX1SfkQDG+kAM13Cm5Zc2iZGTsXi4s
	xAgbU2qUlZVO3h9TpRR13lVwsjviqbqKO+0FSHid3FoxKkywumsBdl0NlUSJJqkRpVLzQS3N//CBl
	/EeeBQQ25/IwOY46cG6chyDRuiyhPZjCLNVulOHC9NGN7MsddvQrGTGe7d6C8r8GIAIO7HCxfgfOA
	LtEPB3bw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rexnM-00000005ReV-1bGP;
	Tue, 27 Feb 2024 13:46:56 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rexnH-00000005Rbo-2WJ7;
	Tue, 27 Feb 2024 13:46:53 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id F00A260A47;
	Tue, 27 Feb 2024 13:46:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CB54C43390;
	Tue, 27 Feb 2024 13:46:42 +0000 (UTC)
Date: Tue, 27 Feb 2024 13:46:40 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Kees Cook <keescook@chromium.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Arnd Bergmann <arnd@arndb.de>, Matt Turner <mattst88@gmail.com>,
	Vineet Gupta <vgupta@kernel.org>,
	Russell King <linux@armlinux.org.uk>, Guo Ren <guoren@kernel.org>,
	Brian Cain <bcain@quicinc.com>, Huacai Chen <chenhuacai@kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Michal Simek <monstr@monstr.eu>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Helge Deller <deller@gmx.de>, Michael Ellerman <mpe@ellerman.id.au>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Andreas Larsson <andreas@gaisler.com>,
	Richard Weinberger <richard@nod.at>, x86@kernel.org,
	Max Filippov <jcmvbkbc@gmail.com>,
	Andy Lutomirski <luto@kernel.org>,
	Jan Kiszka <jan.kiszka@siemens.com>,
	Kieran Bingham <kbingham@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org,
	linux-snps-arc@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
	linux-hexagon@vger.kernel.org, loongarch@lists.linux.dev,
	linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
	linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
	sparclinux@vger.kernel.org, linux-um@lists.infradead.org,
	Linux Kernel Functional Testing <lkft@linaro.org>
Subject: Re: [PATCH 4/4] vdso: avoid including asm/page.h
Message-ID: <Zd3nwGX2oevtj_hQ@arm.com>
References: <20240226161414.2316610-1-arnd@kernel.org>
 <20240226161414.2316610-5-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240226161414.2316610-5-arnd@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240227_054651_705684_C30A89E7 
X-CRM114-Status: GOOD (  12.38  )
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

On Mon, Feb 26, 2024 at 05:14:14PM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The recent change to the vdso_data_store broke building compat VDSO
> on at least arm64 because it includes headers outside of the include/vdso/
> namespace:
> 
> In file included from arch/arm64/include/asm/lse.h:5,
>                  from arch/arm64/include/asm/cmpxchg.h:14,
>                  from arch/arm64/include/asm/atomic.h:16,
>                  from include/linux/atomic.h:7,
>                  from include/asm-generic/bitops/atomic.h:5,
>                  from arch/arm64/include/asm/bitops.h:25,
>                  from include/linux/bitops.h:68,
>                  from arch/arm64/include/asm/memory.h:209,
>                  from arch/arm64/include/asm/page.h:46,
>                  from include/vdso/datapage.h:22,
>                  from lib/vdso/gettimeofday.c:5,
>                  from <command-line>:
> arch/arm64/include/asm/atomic_ll_sc.h:298:9: error: unknown type name 'u128'
>   298 |         u128 full;
> 
> Use an open-coded page size calculation based on the new CONFIG_PAGE_SHIFT
> Kconfig symbol instead.
> 
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> Fixes: a0d2fcd62ac2 ("vdso/ARM: Make union vdso_data_store available for all architectures")
> Link: https://lore.kernel.org/lkml/CA+G9fYtrXXm_KO9fNPz3XaRxHV7UD_yQp-TEuPQrNRHU+_0W_Q@mail.gmail.com/
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>

