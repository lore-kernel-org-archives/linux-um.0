Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48010EB64DC
	for <linux-um@archiver.kernel.org>; Sun, 25 Jun 2023 21:46:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Date:Cc:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=jkPElsqx9UuQVQCDG/GJxOTLlZUxUF/SukUFN6yen/c=; b=xrG0hlJkGNKG4P
	CKP3Unc3JgsQBbS+bey/n7MZMebCbIAAWkNvBxDglGxbXzRGoxia5r3Etw+0mFV94WoAW+Ahx5SAh
	zkPgflBnmTjCvCosPk+XhkyuwDV3l+w095x+VoBL/6BNNU2oV+auwuNTtksSuVL+51dRRf+mrgvgG
	XtDOSZ7wGAQQvhtv5yRrMezPQqaeCCcEehW0BwQBXFmrmFWS9iyUbc4hUI1RT5afkLS5E98vxZq81
	IFb/nYwBPoiuJvcjw5ydgJ4EZLRFi1O3RfkCSpDElDiopdrypeMiJXOGF+SubHJGl1LPf/jgS0eMK
	8XMmCvEeMe6PvgqTIlgA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qDXYy-008mSz-00;
	Sun, 25 Jun 2023 21:46:28 +0000
Received: from outpost1.zedat.fu-berlin.de ([130.133.4.66])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qDXYt-008mS4-29;
	Sun, 25 Jun 2023 21:46:25 +0000
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.95)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1qDXYW-002uoq-2P; Sun, 25 Jun 2023 23:46:00 +0200
Received: from dynamic-089-014-168-195.89.14.pool.telefonica.de ([89.14.168.195] helo=[192.168.1.11])
          by inpost2.zedat.fu-berlin.de (Exim 4.95)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1qDXYV-000RqL-Po; Sun, 25 Jun 2023 23:45:59 +0200
Message-ID: <eb2e34f5ebd541e648a6052e022d219cf0d65583.camel@physik.fu-berlin.de>
Subject: Re: [patch 08/17] sh/cpu: Switch to arch_cpu_finalize_init()
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>
Cc: x86@kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, Nikolay
 Borisov <nik.borisov@suse.com>, "Ahmed S. Darwish" <darwi@linutronix.de>,
 Arnd Bergmann <arnd@arndb.de>, Yoshinori Sato <ysato@users.sourceforge.jp>,
 Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org, Russell King
 <linux@armlinux.org.uk>,  linux-arm-kernel@lists.infradead.org,
 linux-ia64@vger.kernel.org, Huacai Chen <chenhuacai@kernel.org>, WANG
 Xuerui <kernel@xen0n.name>,  loongarch@lists.linux.dev, Geert Uytterhoeven
 <geert@linux-m68k.org>,  linux-m68k@lists.linux-m68k.org, Thomas
 Bogendoerfer <tsbogend@alpha.franken.de>,  linux-mips@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>,  sparclinux@vger.kernel.org,
 Richard Weinberger <richard@nod.at>, Anton Ivanov
 <anton.ivanov@cambridgegreys.com>, Johannes Berg
 <johannes@sipsolutions.net>,  linux-um@lists.infradead.org, Richard
 Henderson <richard.henderson@linaro.org>,  "James E.J. Bottomley"
 <James.Bottomley@HansenPartnership.com>, Michael Ellerman
 <mpe@ellerman.id.au>, Chris Zankel <chris@zankel.net>, Tom Lendacky
 <thomas.lendacky@amd.com>
Date: Sun, 25 Jun 2023 23:45:58 +0200
In-Reply-To: <20230613224545.371697797@linutronix.de>
References: <20230613223827.532680283@linutronix.de>
	 <20230613224545.371697797@linutronix.de>
User-Agent: Evolution 3.48.3 
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-Originating-IP: 89.14.168.195
X-ZEDAT-Hint: PO
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230625_144623_872741_C708A7BD 
X-CRM114-Status: GOOD (  19.17  )
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

On Wed, 2023-06-14 at 01:39 +0200, Thomas Gleixner wrote:
> check_bugs() is about to be phased out. Switch over to the new
> arch_cpu_finalize_init() implementation.
> 
> No functional change.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
> Cc: Rich Felker <dalias@libc.org>
> Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
> Cc: linux-sh@vger.kernel.org
> ---
>  arch/sh/Kconfig                 |    1 
>  arch/sh/include/asm/bugs.h      |   74 ----------------------------------------
>  arch/sh/include/asm/processor.h |    2 +
>  arch/sh/kernel/idle.c           |    1 
>  arch/sh/kernel/setup.c          |   55 +++++++++++++++++++++++++++++
>  5 files changed, 59 insertions(+), 74 deletions(-)
> 
> --- a/arch/sh/Kconfig
> +++ b/arch/sh/Kconfig
> @@ -6,6 +6,7 @@ config SUPERH
>  	select ARCH_ENABLE_MEMORY_HOTREMOVE if SPARSEMEM && MMU
>  	select ARCH_HAVE_NMI_SAFE_CMPXCHG if (GUSA_RB || CPU_SH4A)
>  	select ARCH_HAS_BINFMT_FLAT if !MMU
> +	select ARCH_HAS_CPU_FINALIZE_INIT
>  	select ARCH_HAS_CURRENT_STACK_POINTER
>  	select ARCH_HAS_GIGANTIC_PAGE
>  	select ARCH_HAS_GCOV_PROFILE_ALL
> --- a/arch/sh/include/asm/bugs.h
> +++ /dev/null
> @@ -1,74 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0 */
> -#ifndef __ASM_SH_BUGS_H
> -#define __ASM_SH_BUGS_H
> -
> -/*
> - * This is included by init/main.c to check for architecture-dependent bugs.
> - *
> - * Needs:
> - *	void check_bugs(void);
> - */
> -
> -/*
> - * I don't know of any Super-H bugs yet.
> - */
> -
> -#include <asm/processor.h>
> -
> -extern void select_idle_routine(void);
> -
> -static void __init check_bugs(void)
> -{
> -	extern unsigned long loops_per_jiffy;
> -	char *p = &init_utsname()->machine[2]; /* "sh" */
> -
> -	select_idle_routine();
> -
> -	current_cpu_data.loops_per_jiffy = loops_per_jiffy;
> -
> -	switch (current_cpu_data.family) {
> -	case CPU_FAMILY_SH2:
> -		*p++ = '2';
> -		break;
> -	case CPU_FAMILY_SH2A:
> -		*p++ = '2';
> -		*p++ = 'a';
> -		break;
> -	case CPU_FAMILY_SH3:
> -		*p++ = '3';
> -		break;
> -	case CPU_FAMILY_SH4:
> -		*p++ = '4';
> -		break;
> -	case CPU_FAMILY_SH4A:
> -		*p++ = '4';
> -		*p++ = 'a';
> -		break;
> -	case CPU_FAMILY_SH4AL_DSP:
> -		*p++ = '4';
> -		*p++ = 'a';
> -		*p++ = 'l';
> -		*p++ = '-';
> -		*p++ = 'd';
> -		*p++ = 's';
> -		*p++ = 'p';
> -		break;
> -	case CPU_FAMILY_UNKNOWN:
> -		/*
> -		 * Specifically use CPU_FAMILY_UNKNOWN rather than
> -		 * default:, so we're able to have the compiler whine
> -		 * about unhandled enumerations.
> -		 */
> -		break;
> -	}
> -
> -	printk("CPU: %s\n", get_cpu_subtype(&current_cpu_data));
> -
> -#ifndef __LITTLE_ENDIAN__
> -	/* 'eb' means 'Endian Big' */
> -	*p++ = 'e';
> -	*p++ = 'b';
> -#endif
> -	*p = '\0';
> -}
> -#endif /* __ASM_SH_BUGS_H */
> --- a/arch/sh/include/asm/processor.h
> +++ b/arch/sh/include/asm/processor.h
> @@ -166,6 +166,8 @@ extern unsigned int instruction_size(uns
>  #define instruction_size(insn)	(2)
>  #endif
>  
> +void select_idle_routine(void);
> +
>  #endif /* __ASSEMBLY__ */
>  
>  #include <asm/processor_32.h>
> --- a/arch/sh/kernel/idle.c
> +++ b/arch/sh/kernel/idle.c
> @@ -15,6 +15,7 @@
>  #include <linux/irqflags.h>
>  #include <linux/smp.h>
>  #include <linux/atomic.h>
> +#include <asm/processor.h>
>  #include <asm/smp.h>
>  #include <asm/bl_bit.h>
>  
> --- a/arch/sh/kernel/setup.c
> +++ b/arch/sh/kernel/setup.c
> @@ -43,6 +43,7 @@
>  #include <asm/smp.h>
>  #include <asm/mmu_context.h>
>  #include <asm/mmzone.h>
> +#include <asm/processor.h>
>  #include <asm/sparsemem.h>
>  #include <asm/platform_early.h>
>  
> @@ -354,3 +355,57 @@ int test_mode_pin(int pin)
>  {
>  	return sh_mv.mv_mode_pins() & pin;
>  }
> +
> +void __init arch_cpu_finalize_init(void)
> +{
> +	char *p = &init_utsname()->machine[2]; /* "sh" */
> +
> +	select_idle_routine();
> +
> +	current_cpu_data.loops_per_jiffy = loops_per_jiffy;
> +
> +	switch (current_cpu_data.family) {
> +	case CPU_FAMILY_SH2:
> +		*p++ = '2';
> +		break;
> +	case CPU_FAMILY_SH2A:
> +		*p++ = '2';
> +		*p++ = 'a';
> +		break;
> +	case CPU_FAMILY_SH3:
> +		*p++ = '3';
> +		break;
> +	case CPU_FAMILY_SH4:
> +		*p++ = '4';
> +		break;
> +	case CPU_FAMILY_SH4A:
> +		*p++ = '4';
> +		*p++ = 'a';
> +		break;
> +	case CPU_FAMILY_SH4AL_DSP:
> +		*p++ = '4';
> +		*p++ = 'a';
> +		*p++ = 'l';
> +		*p++ = '-';
> +		*p++ = 'd';
> +		*p++ = 's';
> +		*p++ = 'p';
> +		break;
> +	case CPU_FAMILY_UNKNOWN:
> +		/*
> +		 * Specifically use CPU_FAMILY_UNKNOWN rather than
> +		 * default:, so we're able to have the compiler whine
> +		 * about unhandled enumerations.
> +		 */
> +		break;
> +	}
> +
> +	pr_info("CPU: %s\n", get_cpu_subtype(&current_cpu_data));
> +
> +#ifndef __LITTLE_ENDIAN__
> +	/* 'eb' means 'Endian Big' */
> +	*p++ = 'e';
> +	*p++ = 'b';
> +#endif
> +	*p = '\0';
> +}

Acked-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
