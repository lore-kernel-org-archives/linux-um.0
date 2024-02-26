Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 059B6C48BF6
	for <linux-um@archiver.kernel.org>; Mon, 26 Feb 2024 16:56:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YapG2Iuz3DeMuojGrZ4IACVCP3buEgPcxL/agJvMeoI=; b=zxTiDU2RJEN4/rRlKtSxoRseLz
	WY8r8nq0ycTvRWEA31lVQctTa+XUCV5VUHC4VrCYD4G+PlJlDprKx7znwJk93SqJm6yK45nA65gYB
	d2DYbIGL97ycoee3emXqpC+9TewS0Ha3sK/FOvw6FcQFdXwkIMkTbLJPGYAnHDtdYWpOk5XgMs24w
	lJ9uQf+RT4DHZC1KfFetJTVbVr7eYAweJHEuBGv9wfc6Je1SR2akIIEKA9SU/VRdYT2VbmrmlzyxC
	9z7tQsEBgy9mM66XM9f5kcKOgWTGTfrdmjZCmYkcf2gB18vgERxHBlBk5VCw1EjWTeLtn8TMsKx3N
	yrVmpGWw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1reeGm-00000001mC8-1Hm9;
	Mon, 26 Feb 2024 16:56:00 +0000
Received: from mail-io1-xd30.google.com ([2607:f8b0:4864:20::d30])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1reeG5-00000001lvY-0D83
	for linux-um@lists.infradead.org;
	Mon, 26 Feb 2024 16:55:23 +0000
Received: by mail-io1-xd30.google.com with SMTP id ca18e2360f4ac-7c7894b39edso112946639f.3
        for <linux-um@lists.infradead.org>; Mon, 26 Feb 2024 08:55:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1708966516; x=1709571316; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YapG2Iuz3DeMuojGrZ4IACVCP3buEgPcxL/agJvMeoI=;
        b=PV+KDX3/XZFMX7R9t8MlrEXni+70U1pPle/Fd71j+Mkd+7JnfZ+WmM/IBSY8aUgNZK
         CooR7TahIhtkUK4jeSgisKwxcN2XHlpvdYJ8d5Bg95KrsvH4XPHShK4EDrrT3GCmSoVQ
         KLTMgm+OUpHJHkktFrwYy1XhfOoPE3b78m0MfllXOaSaGR2LEYLKfK5ynfE6EmoWUEEL
         yKDG/EwxN94zdNN0f5x4KpoudQZwAa+D8HfEZMqQcXx+aXQ+Cy4swuAniU0Vi4UNC79Y
         DqGtnxF6l3W0/rqmTkqMcswlvHqIdosJb0Ae+8cz2wghJlMGEepH92U88yzmDgjVgiPL
         +XZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708966516; x=1709571316;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YapG2Iuz3DeMuojGrZ4IACVCP3buEgPcxL/agJvMeoI=;
        b=cHm5L9ogiYQzGIA1neEuN/NJ6umArB6asMcled2QES8BrIafydM14bRDifYo803tSe
         MDFvjZ42KjpEWlIfKy+idN0hSLLzrj4EOEmBgPjwjHxL2S4/zAnRs4YXTof+0Tb689g6
         NPUaTvb+MBbx9UVTejCwX8yl6OvCyoPQlZpRYKGAf5K+f0pKUCfbt5ZpexRjv7LOEINE
         QLBRxGIS8kVf6YAxc2PD0548NMciaxbao8X49EVq/xXg6Jj35nVKfnH3Ww/fqKvyS/JZ
         WWVVcD7rn6/rwWXbZOlnc+UkHMgpS5ZEfHmf713475P1ofvsCKltAn8hIih/CbJm0TO+
         R4Uw==
X-Forwarded-Encrypted: i=1; AJvYcCXnStVMH4v+oSiPCJ1rF32bOXZ5Dwl2ShNSaC9RxEaO/T4YeNt3o53W+vIvr1l3e8uy0O2fHd6m/PN27kG5qFB6Pz5239MH/KDxWu0E
X-Gm-Message-State: AOJu0YzetXmU8+wNtbv7NRrWG75VIE+IXBpYsbmadf4REuwLcI0R6Mlf
	+aYLvBZB5/VTLmSxBqtDoE8/VeBnzA9hqaXpQU2vGUPu/n8fYAVGjZ2eEb2+Gm8=
X-Google-Smtp-Source: AGHT+IHuaCs5d/f2oApxcwZJ00c0VtAfeY0TQXQD6OLSfI1tJf749yVYK76BLp2wH1JUJFxCC31KGw==
X-Received: by 2002:a5e:c819:0:b0:7c7:247e:34c7 with SMTP id y25-20020a5ec819000000b007c7247e34c7mr9575536iol.9.1708966515786;
        Mon, 26 Feb 2024 08:55:15 -0800 (PST)
Received: from [100.64.0.1] ([170.85.6.200])
        by smtp.gmail.com with ESMTPSA id f23-20020a6be817000000b007c7938867adsm1309067ioh.33.2024.02.26.08.55.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Feb 2024 08:55:15 -0800 (PST)
Message-ID: <764fafb0-2206-4ab1-84ea-ebb7848c8ff2@sifive.com>
Date: Mon, 26 Feb 2024 10:55:11 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] arch: consolidate existing CONFIG_PAGE_SIZE_*KB
 definitions
Content-Language: en-US
To: Arnd Bergmann <arnd@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Vincenzo Frascino <vincenzo.frascino@arm.com>,
 Kees Cook <keescook@chromium.org>,
 Anna-Maria Behnsen <anna-maria@linutronix.de>
Cc: Arnd Bergmann <arnd@arndb.de>, Matt Turner <mattst88@gmail.com>,
 Vineet Gupta <vgupta@kernel.org>, Russell King <linux@armlinux.org.uk>,
 Catalin Marinas <catalin.marinas@arm.com>, Guo Ren <guoren@kernel.org>,
 Brian Cain <bcain@quicinc.com>, Huacai Chen <chenhuacai@kernel.org>,
 Geert Uytterhoeven <geert@linux-m68k.org>, Michal Simek <monstr@monstr.eu>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Helge Deller
 <deller@gmx.de>, Michael Ellerman <mpe@ellerman.id.au>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 Andreas Larsson <andreas@gaisler.com>, Richard Weinberger <richard@nod.at>,
 x86@kernel.org, Max Filippov <jcmvbkbc@gmail.com>,
 Andy Lutomirski <luto@kernel.org>, Jan Kiszka <jan.kiszka@siemens.com>,
 Kieran Bingham <kbingham@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
 linux-alpha@vger.kernel.org, linux-snps-arc@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
 linux-hexagon@vger.kernel.org, loongarch@lists.linux.dev,
 linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
 linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
 linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
 sparclinux@vger.kernel.org, linux-um@lists.infradead.org
References: <20240226161414.2316610-1-arnd@kernel.org>
 <20240226161414.2316610-2-arnd@kernel.org>
From: Samuel Holland <samuel.holland@sifive.com>
In-Reply-To: <20240226161414.2316610-2-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240226_085517_431352_19AE347D 
X-CRM114-Status: GOOD (  23.40  )
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

On 2024-02-26 10:14 AM, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> These four architectures define the same Kconfig symbols for configuring
> the page size. Move the logic into a common place where it can be shared
> with all other architectures.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/Kconfig                      | 58 +++++++++++++++++++++++++++++--
>  arch/hexagon/Kconfig              | 25 +++----------
>  arch/hexagon/include/asm/page.h   |  6 +---
>  arch/loongarch/Kconfig            | 21 ++++-------
>  arch/loongarch/include/asm/page.h | 10 +-----
>  arch/mips/Kconfig                 | 58 +++----------------------------
>  arch/mips/include/asm/page.h      | 16 +--------
>  arch/sh/include/asm/page.h        | 13 +------
>  arch/sh/mm/Kconfig                | 42 +++++++---------------
>  9 files changed, 88 insertions(+), 161 deletions(-)
> 
> diff --git a/arch/Kconfig b/arch/Kconfig
> index a5af0edd3eb8..237cea01ed9b 100644
> --- a/arch/Kconfig
> +++ b/arch/Kconfig
> @@ -1078,17 +1078,71 @@ config HAVE_ARCH_COMPAT_MMAP_BASES
>  	  and vice-versa 32-bit applications to call 64-bit mmap().
>  	  Required for applications doing different bitness syscalls.
>  
> +config HAVE_PAGE_SIZE_4KB
> +	bool
> +
> +config HAVE_PAGE_SIZE_8KB
> +	bool
> +
> +config HAVE_PAGE_SIZE_16KB
> +	bool
> +
> +config HAVE_PAGE_SIZE_32KB
> +	bool
> +
> +config HAVE_PAGE_SIZE_64KB
> +	bool
> +
> +config HAVE_PAGE_SIZE_256KB
> +	bool
> +
> +choice
> +	prompt "MMU page size"

Should this have some generic help text (at least a warning about compatibility)?

> +
> +config PAGE_SIZE_4KB
> +	bool "4KB pages"
> +	depends on HAVE_PAGE_SIZE_4KB
> +
> +config PAGE_SIZE_8KB
> +	bool "8KB pages"
> +	depends on HAVE_PAGE_SIZE_8KB
> +
> +config PAGE_SIZE_16KB
> +	bool "16KB pages"
> +	depends on HAVE_PAGE_SIZE_16KB
> +
> +config PAGE_SIZE_32KB
> +	bool "32KB pages"
> +	depends on HAVE_PAGE_SIZE_32KB
> +
> +config PAGE_SIZE_64KB
> +	bool "64KB pages"
> +	depends on HAVE_PAGE_SIZE_64KB
> +
> +config PAGE_SIZE_256KB
> +	bool "256KB pages"
> +	depends on HAVE_PAGE_SIZE_256KB
> +
> +endchoice
> +
>  config PAGE_SIZE_LESS_THAN_64KB
>  	def_bool y
> -	depends on !ARM64_64K_PAGES
>  	depends on !PAGE_SIZE_64KB
> -	depends on !PARISC_PAGE_SIZE_64KB
>  	depends on PAGE_SIZE_LESS_THAN_256KB
>  
>  config PAGE_SIZE_LESS_THAN_256KB
>  	def_bool y
>  	depends on !PAGE_SIZE_256KB
>  
> +config PAGE_SHIFT
> +	int
> +	default 12 if PAGE_SIZE_4KB
> +	default 13 if PAGE_SIZE_8KB
> +	default 14 if PAGE_SIZE_16KB
> +	default 15 if PAGE_SIZE_32KB
> +	default 16 if PAGE_SIZE_64KB
> +	default 18 if PAGE_SIZE_256KB
> +
>  # This allows to use a set of generic functions to determine mmap base
>  # address by giving priority to top-down scheme only if the process
>  # is not in legacy mode (compat task, unlimited stack size or
> diff --git a/arch/hexagon/Kconfig b/arch/hexagon/Kconfig
> index a880ee067d2e..aac46ee1a000 100644
> --- a/arch/hexagon/Kconfig
> +++ b/arch/hexagon/Kconfig
> @@ -8,6 +8,11 @@ config HEXAGON
>  	select ARCH_HAS_SYNC_DMA_FOR_DEVICE
>  	select ARCH_NO_PREEMPT
>  	select DMA_GLOBAL_POOL
> +	select FRAME_POINTER

Looks like a paste error.

> +	select HAVE_PAGE_SIZE_4KB
> +	select HAVE_PAGE_SIZE_16KB
> +	select HAVE_PAGE_SIZE_64KB
> +	select HAVE_PAGE_SIZE_256KB
>  	# Other pending projects/to-do items.
>  	# select HAVE_REGS_AND_STACK_ACCESS_API
>  	# select HAVE_HW_BREAKPOINT if PERF_EVENTS
> @@ -120,26 +125,6 @@ config NR_CPUS
>  	  This is purely to save memory - each supported CPU adds
>  	  approximately eight kilobytes to the kernel image.
>  
> -choice
> -	prompt "Kernel page size"
> -	default PAGE_SIZE_4KB
> -	help
> -	  Changes the default page size; use with caution.
> -
> -config PAGE_SIZE_4KB
> -	bool "4KB"
> -
> -config PAGE_SIZE_16KB
> -	bool "16KB"
> -
> -config PAGE_SIZE_64KB
> -	bool "64KB"
> -
> -config PAGE_SIZE_256KB
> -	bool "256KB"
> -
> -endchoice
> -
>  source "kernel/Kconfig.hz"
>  
>  endmenu
> diff --git a/arch/hexagon/include/asm/page.h b/arch/hexagon/include/asm/page.h
> index 10f1bc07423c..65c9bac639fa 100644
> --- a/arch/hexagon/include/asm/page.h
> +++ b/arch/hexagon/include/asm/page.h
> @@ -13,27 +13,22 @@
>  /*  This is probably not the most graceful way to handle this.  */
>  
>  #ifdef CONFIG_PAGE_SIZE_4KB
> -#define PAGE_SHIFT 12
>  #define HEXAGON_L1_PTE_SIZE __HVM_PDE_S_4KB
>  #endif
>  
>  #ifdef CONFIG_PAGE_SIZE_16KB
> -#define PAGE_SHIFT 14
>  #define HEXAGON_L1_PTE_SIZE __HVM_PDE_S_16KB
>  #endif
>  
>  #ifdef CONFIG_PAGE_SIZE_64KB
> -#define PAGE_SHIFT 16
>  #define HEXAGON_L1_PTE_SIZE __HVM_PDE_S_64KB
>  #endif
>  
>  #ifdef CONFIG_PAGE_SIZE_256KB
> -#define PAGE_SHIFT 18
>  #define HEXAGON_L1_PTE_SIZE __HVM_PDE_S_256KB
>  #endif
>  
>  #ifdef CONFIG_PAGE_SIZE_1MB
> -#define PAGE_SHIFT 20
>  #define HEXAGON_L1_PTE_SIZE __HVM_PDE_S_1MB
>  #endif

The corresponding Kconfig option does not exist (and did not exist before this
patch).

>  
> @@ -50,6 +45,7 @@
>  #define HVM_HUGEPAGE_SIZE 0x5
>  #endif
>  
> +#define PAGE_SHIFT CONFIG_PAGE_SHIFT
>  #define PAGE_SIZE  (1UL << PAGE_SHIFT)
>  #define PAGE_MASK  (~((1 << PAGE_SHIFT) - 1))
>  


