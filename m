Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51563E7108F
	for <linux-um@archiver.kernel.org>; Thu, 21 Sep 2023 15:42:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:Cc:From:To:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=WY/4xVkJd8TrjZfIRGH+wFJGmYWDmyOuqlmFFPK6104=; b=FH/a2SYOWaYFNd
	xcN7EU7RG/lR5PbLF9geqPsIpKqtgNLZZl6Qu55m7LZsvsmO8Snw3oulgKE6LctFyselSGz4aK75P
	rLoWFLBvJ0HvMsdItcmR3IFphyu/2Kel6WVTizfPUCA6JfgAsThoL2yLILT/+VGGDa7c0fWriQ1IY
	bEHhj+W92Go8yQq3emQAgkAMZhG/62z1ZImAcn8N/PpWlSlAGekE0s8bZgKjQNYPqg5vgIi9TfObT
	Iq+6km/a7gtGFZXrO8cQtwvCB83IZATxcCA/hhYdBTVmcV/9kUioSS9a/EKokTulb+qQaKUOi9f7O
	0m5s9IQMk45KimWVRXlg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qjLp9-006Qsz-0q;
	Thu, 21 Sep 2023 15:42:39 +0000
Received: from mail-4018.proton.ch ([185.70.40.18])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qjLp6-006Qru-1i
	for linux-um@lists.infradead.org;
	Thu, 21 Sep 2023 15:42:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=n8pjl.ca;
	s=protonmail2; t=1695310952; x=1695570152;
	bh=WnuzrlfYOP1ucd04giwXmOzxXkwEhdbYm6tQHvvVEaY=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=KmTHqDwALc94IGnM11EgkTNkS1dWh/e/2LCnjMXSEMpD7NNjxsJkMzZcqBaJ05J6m
	 v8BrLQoGKisDn6OBXDfq0vsBciAQFwl92kdtUJk9i/XkZjJADWLF3pGJWLe+Ug1+pu
	 OGXSOjWdcJeCdmNXmueopShSk0eByKcSavwvH5Wmx3WSoLDfjyd8pUGpbbgDLx5sR9
	 W8T8lmLei5qfGSucOxUu6g7pdFuSdnvi2iBFRjznqYna9+spQfr/imz6H2PflqoZGz
	 iPTxTLfgIHvczdmWpmmfLFMoXYZrlq/f55ZoZF5Bs1X19ZT9sFISUVP5mDcrbdq0qd
	 LjKmdSOGso74w==
Date: Thu, 21 Sep 2023 15:42:15 +0000
To: anton.ivanov@cambridgegreys.com
From: Peter Lafreniere <peter@n8pjl.ca>
Cc: johannes@sipsolutions.net, linux-um@lists.infradead.org, richard@nod.at
Subject: Re: [PATCH v3] um: Enable preemption in UML
Message-ID: <20230921154211.59412-1-peter@n8pjl.ca>
In-Reply-To: <20230921153204.278427-1-anton.ivanov@cambridgegreys.com>
References: <20230921153204.278427-1-anton.ivanov@cambridgegreys.com>
Feedback-ID: 53133685:user:proton
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230921_084236_744401_E6436547 
X-CRM114-Status: GOOD (  26.08  )
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

On Thu, Sep 21, 2023 at 11:32, anton.ivanov@cambridgegreys.com wrote:

> From: Anton Ivanov anton.ivanov@cambridgegreys.com
> 
> 
> Preemption requires saving/restoring FPU state. This patch
> adds support for it using GCC intrinsics.
> 
> Signed-off-by: Anton Ivanov anton.ivanov@cambridgegreys.com
> 
> ---
> arch/um/Kconfig | 1 -
> arch/um/include/asm/fpu/api.h | 6 +-
> arch/um/include/asm/processor-generic.h | 3 +
> arch/um/kernel/Makefile | 4 ++
> arch/um/kernel/fpu.c | 77 +++++++++++++++++++++++++
> arch/um/kernel/irq.c | 2 +
> 6 files changed, 91 insertions(+), 2 deletions(-)
> create mode 100644 arch/um/kernel/fpu.c
> 
> diff --git a/arch/um/Kconfig b/arch/um/Kconfig
> index b5e179360534..603f5fd82293 100644
> --- a/arch/um/Kconfig
> +++ b/arch/um/Kconfig
> @@ -11,7 +11,6 @@ config UML
> select ARCH_HAS_KCOV
> select ARCH_HAS_STRNCPY_FROM_USER
> select ARCH_HAS_STRNLEN_USER
> - select ARCH_NO_PREEMPT
> select HAVE_ARCH_AUDITSYSCALL
> select HAVE_ARCH_KASAN if X86_64
> select HAVE_ARCH_KASAN_VMALLOC if HAVE_ARCH_KASAN
> diff --git a/arch/um/include/asm/fpu/api.h b/arch/um/include/asm/fpu/api.h
> index 71bfd9ef3938..76ffa9c3c4b9 100644
> --- a/arch/um/include/asm/fpu/api.h
> +++ b/arch/um/include/asm/fpu/api.h
> @@ -7,9 +7,13 @@
> * A set of "dummy" defines to allow the direct inclusion
> * of x86 optimized copy, xor, etc routines into the
> * UML code tree. /
> -
> +#if defined(CONFIG_PREEMPT) || defined(CONFIG_PREEMPT_VOLUNTRARY)

Typo, should be CONFIG_PREEMPT_VOLUNTARY

> +extern void kernel_fpu_begin(void);
> +extern void kernel_fpu_end(void);
> +#else
> #define kernel_fpu_begin() (void)0
> #define kernel_fpu_end() (void)0
> +#endif
> 
> static inline bool irq_fpu_usable(void)
> {
> diff --git a/arch/um/include/asm/processor-generic.h b/arch/um/include/asm/processor-generic.h
> index 7414154b8e9a..d9362f5a2212 100644
> --- a/arch/um/include/asm/processor-generic.h
> +++ b/arch/um/include/asm/processor-generic.h
> @@ -44,6 +44,9 @@ struct thread_struct {
> } cb;
> } u;
> } request;
> +#if defined(CONFIG_PREEMPT) || defined(CONFIG_PREEMPT_VOLUNTRARY)

Same typo again.

> + u8 fpu[2048] __aligned(64); / Intel docs require xsave/xrestore area to be aligned to 16 bytes /
> +#endif
> };
> 
> #define INIT_THREAD \
> diff --git a/arch/um/kernel/Makefile b/arch/um/kernel/Makefile
> index 811188be954c..c616e884a488 100644
> --- a/arch/um/kernel/Makefile
> +++ b/arch/um/kernel/Makefile
> @@ -26,9 +26,13 @@ obj-$(CONFIG_OF) += dtb.o
> obj-$(CONFIG_EARLY_PRINTK) += early_printk.o
> obj-$(CONFIG_STACKTRACE) += stacktrace.o
> obj-$(CONFIG_GENERIC_PCI_IOMAP) += ioport.o
> +obj-$(CONFIG_PREEMPT) += fpu.o
> +obj-$(CONFIG_PREEMPT_VOLUNTARY) += fpu.o
> 
> USER_OBJS := config.o
> 
> +CFLAGS_fpu.o += -mxsave -mxsaveopt
> +
> include $(srctree)/arch/um/scripts/Makefile.rules
> 
> targets := config.c config.tmp capflags.c
> diff --git a/arch/um/kernel/fpu.c b/arch/um/kernel/fpu.c
> new file mode 100644
> index 000000000000..346c07236185
> --- /dev/null
> +++ b/arch/um/kernel/fpu.c
> @@ -0,0 +1,77 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/
> + * Copyright (C) 2023 Cambridge Greys Ltd
> + * Copyright (C) 2023 Red Hat Inc
> + */
> +
> +#include <linux/cpu.h>
> 
> +#include <linux/init.h>
> 
> +#include <asm/fpu/api.h>
> 
> +#include <asm/cpufeature.h>
> 
> +
> +/*
> + * The critical section between kernel_fpu_begin() and kernel_fpu_end()
> + * is non-reentrant. It is the caller's responsibility to avoid reentrance.
> + /
> +
> +static DEFINE_PER_CPU(bool, in_kernel_fpu);
> +
> +/ UML and driver code it pulls out of the x86 tree knows about 387 features
> + * up to and including AVX512. TILE, etc are not yet supported.
> + */
> +
> +#define KNOWN_387_FEATURES 0xFF
> +
> +
> +void kernel_fpu_begin(void)
> +{
> + preempt_disable();
> +
> + WARN_ON(this_cpu_read(in_kernel_fpu));
> +
> + this_cpu_write(in_kernel_fpu, true);
> +
> +#ifdef CONFIG_64BIT
> + if (likely(cpu_has(&boot_cpu_data, X86_FEATURE_XSAVEOPT)))
> + __builtin_ia32_xsaveopt64(&current->thread.fpu, KNOWN_387_FEATURES);
> 
> + else {
> + if (likely(cpu_has(&boot_cpu_data, X86_FEATURE_XSAVE)))
> + __builtin_ia32_xsave64(&current->thread.fpu, KNOWN_387_FEATURES);
> 
> + else
> + __builtin_ia32_fxsave64(&current->thread.fpu);
> 
> + }
> +#else
> + if (likely(cpu_has(&boot_cpu_data, X86_FEATURE_XSAVEOPT)))
> + __builtin_ia32_xsaveopt(&current->thread.fpu, KNOWN_387_FEATURES);
> 
> + else {
> + if (likely(cpu_has(&boot_cpu_data, X86_FEATURE_XSAVE)))
> + __builtin_ia32_xsave(&current->thread.fpu, KNOWN_387_FEATURES);
> 
> + else
> + __builtin_ia32_fxsave(&current->thread.fpu);
> 
> + }
> +#endif
> +}
> +
> +EXPORT_SYMBOL_GPL(kernel_fpu_begin);
> +
> +void kernel_fpu_end(void)
> +{
> + WARN_ON(!this_cpu_read(in_kernel_fpu));
> +
> +#ifdef CONFIG_64BIT
> + if (likely(cpu_has(&boot_cpu_data, X86_FEATURE_XSAVE)))
> + __builtin_ia32_xrstor64(&current->thread.fpu, KNOWN_387_FEATURES);
> 
> + else
> + __builtin_ia32_fxrstor64(&current->thread.fpu);
> 
> +#else
> + if (likely(cpu_has(&boot_cpu_data, X86_FEATURE_XSAVE)))
> + __builtin_ia32_xrstor(&current->thread.fpu, KNOWN_387_FEATURES);
> 
> + else
> + __builtin_ia32_fxrstor(&current->thread.fpu);
> 
> +#endif
> + this_cpu_write(in_kernel_fpu, false);
> +
> + preempt_enable();
> +}
> +EXPORT_SYMBOL_GPL(kernel_fpu_end);
> +
> diff --git a/arch/um/kernel/irq.c b/arch/um/kernel/irq.c
> index 635d44606bfe..c02525da45df 100644
> --- a/arch/um/kernel/irq.c
> +++ b/arch/um/kernel/irq.c
> @@ -195,7 +195,9 @@ static void _sigio_handler(struct uml_pt_regs *regs,
> 
> void sigio_handler(int sig, struct siginfo *unused_si, struct uml_pt_regs *regs)
> {
> + preempt_disable();
> _sigio_handler(regs, irqs_suspended);
> + preempt_enable();
> }
> 
> static struct irq_entry *get_irq_entry_by_fd(int fd)

Everything other than the typos look good to me. I still think that there
should be some limits on reflection, at least when fxsave is being used
(when running on a poorly-confgured VM with AVX and no xsave, for example).

Cheers,

Peter Lafreniere
<peter@n8pjl.ca>


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
