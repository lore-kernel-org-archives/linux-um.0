Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0294EE7D0A1
	for <linux-um@archiver.kernel.org>; Thu, 21 Sep 2023 17:11:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:Cc:From:To:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=4oUsiHd9qrDp5UlgMuXveeHqdlX6bUDcwMTWA+WYF6U=; b=p/yAlE0Hu5VF8H
	NfME3SOyk6Ry3+zXQn/T40vK2hC4orz2IKVRDb7Uv1PY8H4Q0O9jqnCInkOSwtJjuxnijTgcwbuZn
	A7/1eWu/nIb93F8KGRf6l5lV7HofoEHrrNAIPSnyLdr6Iu+P8M8B6XtTtRqGyfGOin5cQ2damD/qM
	L11tZlTU35DN107h0NMFF9INZJrpSgBi92aBGQk+cZtOF0FgSXcaJDzkv/RDss5U6kzIJaC3D6fhg
	qevdMEng/saSM/GRg+Uy23Vmd1d90zmTnr6XYdmagB+CmcnNDIQlWO4wG5PpACK6yLDLhNO9ef5su
	CIJ1w8gVdysuwupWlIYA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qjNDR-006byt-1W;
	Thu, 21 Sep 2023 17:11:49 +0000
Received: from mail-4317.proton.ch ([185.70.43.17])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qjNDO-006bwt-0P
	for linux-um@lists.infradead.org;
	Thu, 21 Sep 2023 17:11:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=n8pjl.ca;
	s=protonmail2; t=1695316301; x=1695575501;
	bh=0HLkfJPmx0nAORPX8Lze3eXIf9CLrPiGy1o8ePDuds0=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=b5+xzJOhym/g2GyujU+KafkllniM9n6txYK+DUUuixPT9wPRQvEso2hKm8gemNLlM
	 IODXxpSuj+sU+/0pKuW90Ecb+g23jXeMqjI++slh6fXXgHkvdJsouxX2zlZBmO16Ir
	 rbxzV0ezdVi2zmLBc/I+1hHCla5L/+9Jsa7kW6shbkJP74DC5F/BUbBoT0WYdnO6wu
	 uskGe2NPgPjFHvtcZd7waACxe7bMg35+pjPuJPzFq6zE6XuNDIE/t48g75LaMpIvlT
	 JfQVrwShuZSFCDt5UFHMyGV0lpJUMbGa1xvWC5uvNd4KVpcZlVDoEzQ/OkGgTyqN6G
	 7MsUngEkd9nNA==
Date: Thu, 21 Sep 2023 17:11:19 +0000
To: anton.ivanov@cambridgegreys.com
From: Peter Lafreniere <peter@n8pjl.ca>
Cc: johannes@sipsolutions.net, linux-um@lists.infradead.org, richard@nod.at, Peter Lafreniere <peter@n8pjl.ca>
Subject: Re: [PATCH v4] um: Enable preemption in UML
Message-ID: <20230921171040.4198-1-peter@n8pjl.ca>
In-Reply-To: <20230921155522.283582-1-anton.ivanov@cambridgegreys.com>
References: <20230921155522.283582-1-anton.ivanov@cambridgegreys.com>
Feedback-ID: 53133685:user:proton
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230921_101147_415261_030CA786 
X-CRM114-Status: GOOD (  25.02  )
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

On Thu, Sep 21, 2023 at 11:55, anton.ivanov@cambridgegreys.com wrote:
> 
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
> arch/um/include/asm/fpu/api.h | 9 ++-
> arch/um/include/asm/processor-generic.h | 3 +
> arch/um/kernel/Makefile | 4 ++
> arch/um/kernel/fpu.c | 77 +++++++++++++++++++++++++
> arch/um/kernel/irq.c | 2 +
> 6 files changed, 92 insertions(+), 4 deletions(-)
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
> index 71bfd9ef3938..9e7680bf48f0 100644
> --- a/arch/um/include/asm/fpu/api.h
> +++ b/arch/um/include/asm/fpu/api.h
> @@ -4,12 +4,15 @@
> 
> /* Copyright (c) 2020 Cambridge Greys Ltd
> * Copyright (c) 2020 Red Hat Inc.
> - * A set of "dummy" defines to allow the direct inclusion
> - * of x86 optimized copy, xor, etc routines into the
> - * UML code tree. */
> + /
> 
> +#if defined(CONFIG_PREEMPT) || defined(CONFIG_PREEMPT_VOLUNTARY)
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
> index 7414154b8e9a..c08e8c5b0249 100644
> --- a/arch/um/include/asm/processor-generic.h
> +++ b/arch/um/include/asm/processor-generic.h
> @@ -44,6 +44,9 @@ struct thread_struct {
> } cb;
> } u;
> } request;
> +#if defined(CONFIG_PREEMPT) || defined(CONFIG_PREEMPT_VOLUNTARY)
> + u8 fpu[2048] __aligned(64); / Intel docs require xsave/xrestore area to be aligned to 64 bytes /
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

Tiny nit, but you use two different styles of block comments here.
You did the same with the copyright declarations.

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
> --
> 2.30.2

I'm happy with this as it is. The issue with AVX registers being clobbered
when xsave isn't supported is unlikely to matter in practice, and can
be fixed with a patch afterwards.

Reviewed-by: Peter Lafreniere <peter@n8pjl.ca>

Cheers,
Peter


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
