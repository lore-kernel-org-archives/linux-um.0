Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4604AE71094
	for <linux-um@archiver.kernel.org>; Thu, 21 Sep 2023 16:46:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=e1TrgY9ZnrCnov3DstRH53lT1K/KyuPLIXYbK+ACbPI=; b=EFMFhHd4jMxF5p
	TAe1GADUJPtiy6uGzzmj8AHoTGDKG+2FpqDUO+1eE7WQ0f+dOAIS3GoGt5YYiF/86DeUTG0o/HfIb
	pziQci2X7dR0zSjlmVW6XN1bSxes5MVcwYl5Ap52X0CXYoq528ewXWb4H9jRq1BAfiDGB8cnBt263
	A4fMOQWqIUXGaVeGfIKaKgnzuFIafc8Q9zwxjUVuBGdWdues8ao0orcM18PCGQSKgGbWhinu2iiel
	By2uvDZp+aHdSpRXnv6ZJi3R7wV5nk16jA+9XK+lmYIw3BHwcqOorWCkGU8l6JNPEzMjU2iL7aeQL
	4Xj1POSqfjXWZ8Fz9Z+g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qjMoa-006Y3f-1U;
	Thu, 21 Sep 2023 16:46:08 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qjLi2-006Pwp-1V
	for linux-um@bombadil.infradead.org;
	Thu, 21 Sep 2023 15:35:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=QSdkT7SfRvkh7ulUQaG3xU5IFpUrk6A3dRjY5u2cO5s=; b=VDf2zFnEUam488qAA/E1vKVcx5
	LZmncugU7+QLNTAH53crmOjImJul10brK2RDRALeFMwFm8MXXVCJ3SCWXbBy9T57X0K8oteB6RETE
	HSe9bJAQRLMgTAy63yuJq9ruJosxCBT1lCDtlZQlVlpC5HAF3akFQzy3VicRxgAFoIviQIQuY166F
	hxNNRFxrEaYJYNGYgLNXAGI7leEmJWeYL+0WtTEC5kxrwEM0mq50z/1IRWRX30vhYFPTYluFdwfoc
	e+U+zr8Ztas2NQ39csv4oALENxBIygoomc7DMPWu0BPBJxbGo/12AXmaiUYqmHpr4wFmd6SuCHSqJ
	3pGUPntw==;
Received: from ns1.kot-begemot.co.uk ([217.160.28.25] helo=www.kot-begemot.co.uk)
	by desiato.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qjLhx-00FU4U-1s
	for linux-um@lists.infradead.org;
	Thu, 21 Sep 2023 15:35:17 +0000
Received: from [192.168.17.6] (helo=jain.kot-begemot.co.uk)
	by www.kot-begemot.co.uk with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <anton.ivanov@cambridgegreys.com>)
	id 1qjLhy-002Z7d-1q; Thu, 21 Sep 2023 15:35:14 +0000
Received: from jain.kot-begemot.co.uk ([192.168.3.3])
	by jain.kot-begemot.co.uk with esmtp (Exim 4.94.2)
	(envelope-from <anton.ivanov@cambridgegreys.com>)
	id 1qjLhv-001AhN-7i; Thu, 21 Sep 2023 16:35:13 +0100
Message-ID: <40109d01-ee50-8844-7ec2-afe27ba9cd03@cambridgegreys.com>
Date: Thu, 21 Sep 2023 16:35:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v3] um: Enable preemption in UML
Content-Language: en-US
To: linux-um@lists.infradead.org
Cc: johannes@sipsolutions.net, richard@nod.at
References: <20230921153204.278427-1-anton.ivanov@cambridgegreys.com>
From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
In-Reply-To: <20230921153204.278427-1-anton.ivanov@cambridgegreys.com>
X-Clacks-Overhead: GNU Terry Pratchett
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230921_163515_207554_D662062D 
X-CRM114-Status: GOOD (  27.39  )
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



On 21/09/2023 16:32, anton.ivanov@cambridgegreys.com wrote:
> From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
> 
> Preemption requires saving/restoring FPU state. This patch
> adds support for it using GCC intrinsics.
> 
> Signed-off-by: Anton Ivanov <anton.ivanov@cambridgegreys.com>
> ---
>   arch/um/Kconfig                         |  1 -
>   arch/um/include/asm/fpu/api.h           |  6 +-
>   arch/um/include/asm/processor-generic.h |  3 +
>   arch/um/kernel/Makefile                 |  4 ++
>   arch/um/kernel/fpu.c                    | 77 +++++++++++++++++++++++++
>   arch/um/kernel/irq.c                    |  2 +
>   6 files changed, 91 insertions(+), 2 deletions(-)
>   create mode 100644 arch/um/kernel/fpu.c


Fixes:
	1. Defines. I messed them up in v2.
	2. Makes build selective on CONFIG_PREEMPT. If preemption is not enabled fpu.o is
not build.
	3. CFLAGS are altered only for fpu.o

Performance change is the same - from 20minutes for find /usr and cat to /dev/null down to 3
and from unusable under stress to fairly reasonable.

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
> index 71bfd9ef3938..76ffa9c3c4b9 100644
> --- a/arch/um/include/asm/fpu/api.h
> +++ b/arch/um/include/asm/fpu/api.h
> @@ -7,9 +7,13 @@
>    * A set of "dummy" defines to allow the direct inclusion
>    * of x86 optimized copy, xor, etc routines into the
>    * UML code tree. */
> -
> +#if defined(CONFIG_PREEMPT) || defined(CONFIG_PREEMPT_VOLUNTRARY)
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
> index 7414154b8e9a..d9362f5a2212 100644
> --- a/arch/um/include/asm/processor-generic.h
> +++ b/arch/um/include/asm/processor-generic.h
> @@ -44,6 +44,9 @@ struct thread_struct {
>   			} cb;
>   		} u;
>   	} request;
> +#if defined(CONFIG_PREEMPT) || defined(CONFIG_PREEMPT_VOLUNTRARY)
> +    u8 fpu[2048] __aligned(64); /* Intel docs require xsave/xrestore area to be aligned to 16 bytes */
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
