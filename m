Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 385ACE71091
	for <linux-um@archiver.kernel.org>; Thu, 21 Sep 2023 15:59:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=UAZCG+Y4fVBeViccdYVQ9p8MGQiRa7B/wDQtuo1yjcU=; b=MRiXq8MQeyuXcX
	5B4YCBam3GwQVzc8t1rpluVJvNA2JFCnab3tu7koL3Tps2Ig5UDJtT2HZvYCDGFLxWvFumJqzbpVY
	GQlgjN4MOVyURys5dMNg5OoQV5CFkeJXG1M9myoe2+7hY1u56AL+hjSp5Dvrh9q5KbLowQgiYvAuz
	L7Nyb08kevZ4mhWyS+vIYZY+UdZkLMYfyFO5pxXQSgV2ZIfVSvLYorL8oZ0RCB6OdXVhpTm3ZEzeR
	9q76AoXsCQXY25K6cUEqqZeU0RW7aXGG7UhtoIIEbi0MANSH5LxoP04PUg9Bj26I5pz0iq42QzeJi
	Zjs0zjOhmgyW1l0qd9dA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qjM5j-006Scb-38;
	Thu, 21 Sep 2023 15:59:47 +0000
Received: from ns1.kot-begemot.co.uk ([217.160.28.25] helo=www.kot-begemot.co.uk)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qjM5g-006ScC-1Q
	for linux-um@lists.infradead.org;
	Thu, 21 Sep 2023 15:59:46 +0000
Received: from [192.168.17.6] (helo=jain.kot-begemot.co.uk)
	by www.kot-begemot.co.uk with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <anton.ivanov@cambridgegreys.com>)
	id 1qjM5e-002ZD7-T4; Thu, 21 Sep 2023 15:59:43 +0000
Received: from jain.kot-begemot.co.uk ([192.168.3.3])
	by jain.kot-begemot.co.uk with esmtp (Exim 4.94.2)
	(envelope-from <anton.ivanov@cambridgegreys.com>)
	id 1qjM5c-001CGA-6U; Thu, 21 Sep 2023 16:59:42 +0100
Message-ID: <6940d7cf-e8a7-10e9-09b5-a3dce96d6902@cambridgegreys.com>
Date: Thu, 21 Sep 2023 16:59:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v4] um: Enable preemption in UML
Content-Language: en-US
To: linux-um@lists.infradead.org
Cc: johannes@sipsolutions.net, richard@nod.at
References: <20230921155522.283582-1-anton.ivanov@cambridgegreys.com>
From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
In-Reply-To: <20230921155522.283582-1-anton.ivanov@cambridgegreys.com>
X-Clacks-Overhead: GNU Terry Pratchett
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230921_085944_484081_CC87C8D2 
X-CRM114-Status: GOOD (  26.04  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org



On 21/09/2023 16:55, anton.ivanov@cambridgegreys.com wrote:
> From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
> 
> Preemption requires saving/restoring FPU state. This patch
> adds support for it using GCC intrinsics.
> 
> Signed-off-by: Anton Ivanov <anton.ivanov@cambridgegreys.com>
> ---
>   arch/um/Kconfig                         |  1 -
>   arch/um/include/asm/fpu/api.h           |  9 ++-
>   arch/um/include/asm/processor-generic.h |  3 +
>   arch/um/kernel/Makefile                 |  4 ++
>   arch/um/kernel/fpu.c                    | 77 +++++++++++++++++++++++++
>   arch/um/kernel/irq.c                    |  2 +
>   6 files changed, 92 insertions(+), 4 deletions(-)
>   create mode 100644 arch/um/kernel/fpu.c

Cleanup of typos and stale comments from older versions.

> 
> diff --git a/arch/um/Kconfig b/arch/um/Kconfig
> index b5e179360534..603f5fd82293 100644
> --- a/arch/um/Kconfig
> +++ b/arch/um/Kconfig
> @@ -11,7 +11,6 @@ config UML
>   	select ARCH_HAS_KCOV
>   	select ARCH_HAS_STRNCPY_FROM_USER
>   	select ARCH_HAS_STRNLEN_USER
> -	select ARCH_NO_PREEMPT
>   	select HAVE_ARCH_AUDITSYSCALL
>   	select HAVE_ARCH_KASAN if X86_64
>   	select HAVE_ARCH_KASAN_VMALLOC if HAVE_ARCH_KASAN
> diff --git a/arch/um/include/asm/fpu/api.h b/arch/um/include/asm/fpu/api.h
> index 71bfd9ef3938..9e7680bf48f0 100644
> --- a/arch/um/include/asm/fpu/api.h
> +++ b/arch/um/include/asm/fpu/api.h
> @@ -4,12 +4,15 @@
>   
>   /* Copyright (c) 2020 Cambridge Greys Ltd
>    * Copyright (c) 2020 Red Hat Inc.
> - * A set of "dummy" defines to allow the direct inclusion
> - * of x86 optimized copy, xor, etc routines into the
> - * UML code tree. */
> + */
>   
> +#if defined(CONFIG_PREEMPT) || defined(CONFIG_PREEMPT_VOLUNTARY)
> +extern void kernel_fpu_begin(void);
> +extern void kernel_fpu_end(void);
> +#else
>   #define kernel_fpu_begin() (void)0
>   #define kernel_fpu_end() (void)0
> +#endif
>   
>   static inline bool irq_fpu_usable(void)
>   {
> diff --git a/arch/um/include/asm/processor-generic.h b/arch/um/include/asm/processor-generic.h
> index 7414154b8e9a..c08e8c5b0249 100644
> --- a/arch/um/include/asm/processor-generic.h
> +++ b/arch/um/include/asm/processor-generic.h
> @@ -44,6 +44,9 @@ struct thread_struct {
>   			} cb;
>   		} u;
>   	} request;
> +#if defined(CONFIG_PREEMPT) || defined(CONFIG_PREEMPT_VOLUNTARY)
> +    u8 fpu[2048] __aligned(64); /* Intel docs require xsave/xrestore area to be aligned to 64 bytes */
> +#endif
>   };
>   
>   #define INIT_THREAD \
> diff --git a/arch/um/kernel/Makefile b/arch/um/kernel/Makefile
> index 811188be954c..c616e884a488 100644
> --- a/arch/um/kernel/Makefile
> +++ b/arch/um/kernel/Makefile
> @@ -26,9 +26,13 @@ obj-$(CONFIG_OF) += dtb.o
>   obj-$(CONFIG_EARLY_PRINTK) += early_printk.o
>   obj-$(CONFIG_STACKTRACE) += stacktrace.o
>   obj-$(CONFIG_GENERIC_PCI_IOMAP) += ioport.o
> +obj-$(CONFIG_PREEMPT) += fpu.o
> +obj-$(CONFIG_PREEMPT_VOLUNTARY) += fpu.o
>   
>   USER_OBJS := config.o
>   
> +CFLAGS_fpu.o += -mxsave -mxsaveopt
> +
>   include $(srctree)/arch/um/scripts/Makefile.rules
>   
>   targets := config.c config.tmp capflags.c
> diff --git a/arch/um/kernel/fpu.c b/arch/um/kernel/fpu.c
> new file mode 100644
> index 000000000000..346c07236185
> --- /dev/null
> +++ b/arch/um/kernel/fpu.c
> @@ -0,0 +1,77 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (C) 2023 Cambridge Greys Ltd
> + * Copyright (C) 2023 Red Hat Inc
> + */
> +
> +#include <linux/cpu.h>
> +#include <linux/init.h>
> +#include <asm/fpu/api.h>
> +#include <asm/cpufeature.h>
> +
> +/*
> + * The critical section between kernel_fpu_begin() and kernel_fpu_end()
> + * is non-reentrant. It is the caller's responsibility to avoid reentrance.
> + */
> +
> +static DEFINE_PER_CPU(bool, in_kernel_fpu);
> +
> +/* UML and driver code it pulls out of the x86 tree knows about 387 features
> + * up to and including AVX512. TILE, etc are not yet supported.
> + */
> +
> +#define KNOWN_387_FEATURES 0xFF
> +
> +
> +void kernel_fpu_begin(void)
> +{
> +	preempt_disable();
> +
> +	WARN_ON(this_cpu_read(in_kernel_fpu));
> +
> +	this_cpu_write(in_kernel_fpu, true);
> +
> +#ifdef CONFIG_64BIT
> +	if (likely(cpu_has(&boot_cpu_data, X86_FEATURE_XSAVEOPT)))
> +		__builtin_ia32_xsaveopt64(&current->thread.fpu, KNOWN_387_FEATURES);
> +	else {
> +		if (likely(cpu_has(&boot_cpu_data, X86_FEATURE_XSAVE)))
> +			__builtin_ia32_xsave64(&current->thread.fpu, KNOWN_387_FEATURES);
> +		else
> +			__builtin_ia32_fxsave64(&current->thread.fpu);
> +	}
> +#else
> +	if (likely(cpu_has(&boot_cpu_data, X86_FEATURE_XSAVEOPT)))
> +		__builtin_ia32_xsaveopt(&current->thread.fpu, KNOWN_387_FEATURES);
> +	else {
> +		if (likely(cpu_has(&boot_cpu_data, X86_FEATURE_XSAVE)))
> +			__builtin_ia32_xsave(&current->thread.fpu, KNOWN_387_FEATURES);
> +		else
> +			__builtin_ia32_fxsave(&current->thread.fpu);
> +	}
> +#endif
> +}
> +
> +EXPORT_SYMBOL_GPL(kernel_fpu_begin);
> +
> +void kernel_fpu_end(void)
> +{
> +	WARN_ON(!this_cpu_read(in_kernel_fpu));
> +
> +#ifdef CONFIG_64BIT
> +	if (likely(cpu_has(&boot_cpu_data, X86_FEATURE_XSAVE)))
> +		__builtin_ia32_xrstor64(&current->thread.fpu, KNOWN_387_FEATURES);
> +	else
> +		__builtin_ia32_fxrstor64(&current->thread.fpu);
> +#else
> +	if (likely(cpu_has(&boot_cpu_data, X86_FEATURE_XSAVE)))
> +		__builtin_ia32_xrstor(&current->thread.fpu, KNOWN_387_FEATURES);
> +	else
> +		__builtin_ia32_fxrstor(&current->thread.fpu);
> +#endif
> +	this_cpu_write(in_kernel_fpu, false);
> +
> +	preempt_enable();
> +}
> +EXPORT_SYMBOL_GPL(kernel_fpu_end);
> +
> diff --git a/arch/um/kernel/irq.c b/arch/um/kernel/irq.c
> index 635d44606bfe..c02525da45df 100644
> --- a/arch/um/kernel/irq.c
> +++ b/arch/um/kernel/irq.c
> @@ -195,7 +195,9 @@ static void _sigio_handler(struct uml_pt_regs *regs,
>   
>   void sigio_handler(int sig, struct siginfo *unused_si, struct uml_pt_regs *regs)
>   {
> +	preempt_disable();
>   	_sigio_handler(regs, irqs_suspended);
> +	preempt_enable();
>   }
>   
>   static struct irq_entry *get_irq_entry_by_fd(int fd)

-- 
Anton R. Ivanov
Cambridgegreys Limited. Registered in England. Company Number 10273661
https://www.cambridgegreys.com/

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
