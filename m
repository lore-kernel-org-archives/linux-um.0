Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B20ABE706FB
	for <linux-um@archiver.kernel.org>; Thu, 21 Sep 2023 09:34:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:To:Subject:MIME-Version:
	Date:Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=iQnzJAG2MAoY2E7nLUlOYboCsxrhKpU60O7IW8vg3js=; b=pynfunTN1Hb8naPp44t8a9wTjh
	q11FTTpPyz61adJDcphj1vCS40Zx0rtuMQ2SIxy5t8Rts9KvIxOsI0i943HltK1a/kkEow379nhUE
	aIxpUVgpC//wxyYhql+TjEAMe3vRFGiy4S6SayWktqEYRZWmWrRIHkHyK1gd+KWusgspwGYc2OJUS
	LdWKVuJlKoyYz6pq+ScTeF/dpV9H69zVeWBrhrN4Zge3LAkgljGAjyKbxMysJPQb1uHvCka8+Q+R9
	AYk0rJ/YtEw0xLLwutK0NowdlWhpB9eLiUdbctBDttp4kPWYE4Z92JIhTZWJxCRbdpJZOd2J2ehu8
	5k6HmUbA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qjG5H-005bi9-2e;
	Thu, 21 Sep 2023 09:34:55 +0000
Received: from ns1.kot-begemot.co.uk ([217.160.28.25] helo=www.kot-begemot.co.uk)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qjG5E-005bgq-00
	for linux-um@lists.infradead.org;
	Thu, 21 Sep 2023 09:34:54 +0000
Received: from [192.168.17.6] (helo=jain.kot-begemot.co.uk)
	by www.kot-begemot.co.uk with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <anton.ivanov@kot-begemot.co.uk>)
	id 1qjG5B-002YL6-JP
	for linux-um@lists.infradead.org; Thu, 21 Sep 2023 09:34:49 +0000
Received: from jain.kot-begemot.co.uk ([192.168.3.3])
	by jain.kot-begemot.co.uk with esmtp (Exim 4.94.2)
	(envelope-from <anton.ivanov@kot-begemot.co.uk>)
	id 1qjG58-000nv8-Oy
	for linux-um@lists.infradead.org; Thu, 21 Sep 2023 10:34:49 +0100
Message-ID: <6934482b-f210-b86f-3fab-23355c989a56@kot-begemot.co.uk>
Date: Thu, 21 Sep 2023 10:34:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2] um: Enable preemption in UML
Content-Language: en-US
To: linux-um@lists.infradead.org
References: <20230921092836.190291-1-anton.ivanov@cambridgegreys.com>
From: Anton Ivanov <anton.ivanov@kot-begemot.co.uk>
In-Reply-To: <20230921092836.190291-1-anton.ivanov@cambridgegreys.com>
X-Clacks-Overhead: GNU Terry Pratchett
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230921_023452_177765_F801E096 
X-CRM114-Status: GOOD (  24.60  )
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



On 21/09/2023 10:28, anton.ivanov@cambridgegreys.com wrote:
> From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
> 
> Preemption requires saving/restoring FPU state. This patch
> adds support for it using GCC intrinsics.

Marginally slower than before

3m 03s for find /usr -type f -exec cat {} > /dev/null \;

Still, better than the non-PREEMPT 20 minutes for the same job

Tested including the use of stress: stress --cpu 16 --io 16 --hdd 16 --timeout 60

This test was making non-PREEMPT unusable. You had to wait until it completes to get it to
respond to anything. PREEMPT remains usable and responsive throughout.

All in all - we have to go back and finish the CPU flags translation work as we really
need working alternatives and/or borrowing the CPU stuff from the x86 tree instead of
reimplementing it.

> 
> Signed-off-by: Anton Ivanov <anton.ivanov@cambridgegreys.com>
> ---
>   arch/um/Kconfig                         |  1 -
>   arch/um/Makefile                        |  3 +-
>   arch/um/include/asm/fpu/api.h           |  4 +-
>   arch/um/include/asm/processor-generic.h |  3 +
>   arch/um/kernel/Makefile                 |  2 +-
>   arch/um/kernel/fpu.c                    | 83 +++++++++++++++++++++++++
>   arch/um/kernel/irq.c                    |  2 +
>   7 files changed, 93 insertions(+), 5 deletions(-)
>   create mode 100644 arch/um/kernel/fpu.c
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
> diff --git a/arch/um/Makefile b/arch/um/Makefile
> index 82f05f250634..6454f735cc9a 100644
> --- a/arch/um/Makefile
> +++ b/arch/um/Makefile
> @@ -61,7 +61,8 @@ KBUILD_CFLAGS += $(CFLAGS) $(CFLAGS-y) -D__arch_um__ \
>   	$(ARCH_INCLUDE) $(MODE_INCLUDE) -Dvmap=kernel_vmap	\
>   	-Dlongjmp=kernel_longjmp -Dsetjmp=kernel_setjmp \
>   	-Din6addr_loopback=kernel_in6addr_loopback \
> -	-Din6addr_any=kernel_in6addr_any -Dstrrchr=kernel_strrchr
> +	-Din6addr_any=kernel_in6addr_any -Dstrrchr=kernel_strrchr \
> +	-mxsave -mxsaveopt
>   
>   KBUILD_RUSTFLAGS += -Crelocation-model=pie
>   
> diff --git a/arch/um/include/asm/fpu/api.h b/arch/um/include/asm/fpu/api.h
> index 71bfd9ef3938..0094624ae9b4 100644
> --- a/arch/um/include/asm/fpu/api.h
> +++ b/arch/um/include/asm/fpu/api.h
> @@ -8,8 +8,8 @@
>    * of x86 optimized copy, xor, etc routines into the
>    * UML code tree. */
>   
> -#define kernel_fpu_begin() (void)0
> -#define kernel_fpu_end() (void)0
> +void kernel_fpu_begin(void);
> +void kernel_fpu_end(void);
>   
>   static inline bool irq_fpu_usable(void)
>   {
> diff --git a/arch/um/include/asm/processor-generic.h b/arch/um/include/asm/processor-generic.h
> index 7414154b8e9a..d5924d0e16a7 100644
> --- a/arch/um/include/asm/processor-generic.h
> +++ b/arch/um/include/asm/processor-generic.h
> @@ -44,6 +44,9 @@ struct thread_struct {
>   			} cb;
>   		} u;
>   	} request;
> +#if defined(PREEMPT) || defined(PREEMPT_VOLUNTRARY)
> +    u8 fpu[2048] __aligned(64); /* Intel docs require xsave/xrestore area to be aligned to 16 bytes */
> +#endif
>   };
>   
>   #define INIT_THREAD \
> diff --git a/arch/um/kernel/Makefile b/arch/um/kernel/Makefile
> index 811188be954c..5d9fbaa544be 100644
> --- a/arch/um/kernel/Makefile
> +++ b/arch/um/kernel/Makefile
> @@ -16,7 +16,7 @@ extra-y := vmlinux.lds
>   
>   obj-y = config.o exec.o exitcode.o irq.o ksyms.o mem.o \
>   	physmem.o process.o ptrace.o reboot.o sigio.o \
> -	signal.o sysrq.o time.o tlb.o trap.o \
> +	signal.o sysrq.o time.o tlb.o trap.o fpu.o\
>   	um_arch.o umid.o maccess.o kmsg_dump.o capflags.o skas/
>   obj-y += load_file.o
>   
> diff --git a/arch/um/kernel/fpu.c b/arch/um/kernel/fpu.c
> new file mode 100644
> index 000000000000..fb90da5a0227
> --- /dev/null
> +++ b/arch/um/kernel/fpu.c
> @@ -0,0 +1,83 @@
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
> +#if defined(PREEMPT) || defined(PREEMPT_VOLUNTRARY)
> +static DEFINE_PER_CPU(bool, in_kernel_fpu);
> +#endif
> +
> +/* UML knows about 387 features up to and including AVX512, tile, etc are not yet
> + * supported.
> + */
> +
> +#define KNOWN_387_FEATURES 0xFF
> +
> +
> +void kernel_fpu_begin(void)
> +{
> +#if defined(PREEMPT) || defined(PREEMPT_VOLUNTRARY)
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
> +		if (cpu_has(&boot_cpu_data, X86_FEATURE_XSAVE))
> +			__builtin_ia32_xsave64(&current->thread.fpu, KNOWN_387_FEATURES);
> +		else
> +			__builtin_ia32_fxsave64(&current->thread.fpu);
> +	}
> +#else
> +	if (likely(cpu_has(&boot_cpu_data, X86_FEATURE_XSAVEOPT)))
> +		__builtin_ia32_xsaveopt(&current->thread.fpu, KNOWN_387_FEATURES);
> +	else {
> +		if (cpu_has(&boot_cpu_data, X86_FEATURE_XSAVE))
> +			__builtin_ia32_xsave(&current->thread.fpu, KNOWN_387_FEATURES);
> +		else
> +			__builtin_ia32_fxsave(&current->thread.fpu);
> +	}
> +#endif
> +#endif
> +}
> +
> +EXPORT_SYMBOL_GPL(kernel_fpu_begin);
> +
> +void kernel_fpu_end(void)
> +{
> +#if defined(PREEMPT) || defined(PREEMPT_VOLUNTRARY)
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
> +#endif
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
https://www.kot-begemot.co.uk/

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
