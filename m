Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB4A7C04AAB
	for <linux-um@archiver.kernel.org>; Fri, 22 Sep 2023 12:00:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:Cc:From:To:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=FgMlxOkWVSQlj/aOINZodOpci6lMzch100hLm9Quk0A=; b=wWVc5Gw4qHrns1
	yohLSiEE8yB0IVEcXGWEgUjoWJIdYz29EWjpBVselAc27kz1K3KaNMQji1KXkpHd5e+RtvvtRRSPX
	iC4J3Boqf6rlnc7OjGOVhXrBwrc0VfYDBNnJ0TXYSkCOIkyyI015s25kRDSyTqPL9qjw9YhfZLWCe
	HfVGKx1PIu9EfL/0Nc7BGA4svijE63R+kfubTY/mQwHyIgtq9CHjZayK/6cSjfJuC2yOppyhYHf5D
	9SOf911guT+RDXp7KjmVjK+aFvU5+wKc7TWgj1FLX8j4DzIWWHOsibI+zNH9Hw36DTYmjwuV3WTdq
	+e/+nLdrOeZh+Ct4sUVg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qjepG-0090eq-2d;
	Fri, 22 Sep 2023 12:00:02 +0000
Received: from mail-4317.proton.ch ([185.70.43.17])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qjepC-0090cb-00
	for linux-um@lists.infradead.org;
	Fri, 22 Sep 2023 12:00:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=n8pjl.ca;
	s=protonmail2; t=1695383993; x=1695643193;
	bh=2ztYyA0wmiYS5Y9EhV45dkDdzhhhInwFVZf1GZKFTWM=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=YbBdquNCzhsSaYLErUK+8P7IqDvCuvfubAPWex89bC3X7nUtbBu6tHMyMXJuFYrtE
	 yLGli9SV5xw0MfUKNl2X9ZT4dUj26LSbXd1jv6TWAETN9ptIc+fU6bgM0EeMxBiQSa
	 XRyHCsA7Jsak6rIMewl8tMWjuwBad8kALCLWFAqCRMlJDNVbeSSYSA1jCIbYNkjPKP
	 cL+cesir2Htkrh9aWvJhJTAuhvyPvNxD3vG2Ig9NgdkpOhzvmdkzEZsPInZkgigSg3
	 r/P98ZTM3pzIQfcIJ6x+kAbfkuA9WwJuWRq9MlRGj8aoRORcTtP+CnMG6HhGAWJx+K
	 ySqbC4xoRt99g==
Date: Fri, 22 Sep 2023 11:59:48 +0000
To: anton.ivanov@cambridgegreys.com
From: Peter Lafreniere <peter@n8pjl.ca>
Cc: johannes@sipsolutions.net, linux-um@lists.infradead.org, richard@nod.at
Subject: Re: [PATCH v6] um: Enable preemption in UML
Message-ID: <20230922115942.19988-1-peter@n8pjl.ca>
In-Reply-To: <20230922105609.545573-1-anton.ivanov@cambridgegreys.com>
References: <20230922105609.545573-1-anton.ivanov@cambridgegreys.com>
Feedback-ID: 53133685:user:proton
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230922_045959_680764_F31B3AC5 
X-CRM114-Status: GOOD (  34.01  )
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

On Fri, Sept 22, 2023 at 06:56, anton.ivanov@cambridgegreys.com wrote:
> 
> From: Anton Ivanov anton.ivanov@cambridgegreys.com
> 
> 
> 1. Preemption requires saving/restoring FPU state. This patch
> adds support for it using GCC intrinsics as well as appropriate
> storage space in the thread structure.
> 
> 2. irq critical sections need preempt_disable()/preempt_enable().
> 
> 3. TLB critical sections need preempt_disable()/preempt_enable().
> 
> 4. UML TLB flush is also invoked during a fork. This happens
> with interrupts and preempt disabled which disagrees with the
> standard mm locking via rwsem. The mm lock for this code path
> had to be replaced with an rcu.

"Had to be"? Why? It's a very unconventional locking method
and should have some justification.

> 
> 5. The FPU state area is statically allocated depending on
> the enabled PREEMPT options. PREEMPT_DYNAMIC and chosing the
> preemption model at start time is disabled for the UM arch.
> 
> Signed-off-by: Anton Ivanov anton.ivanov@cambridgegreys.com
> 
> ---
> arch/um/Kconfig | 2 +-
> arch/um/include/asm/fpu/api.h | 9 ++-
> arch/um/include/asm/processor-generic.h | 4 ++
> arch/um/kernel/Makefile | 4 ++
> arch/um/kernel/fpu.c | 75 +++++++++++++++++++++++++
> arch/um/kernel/irq.c | 2 +
> arch/um/kernel/tlb.c | 21 ++++++-
> 7 files changed, 111 insertions(+), 6 deletions(-)
> create mode 100644 arch/um/kernel/fpu.c
> 
> diff --git a/arch/um/Kconfig b/arch/um/Kconfig
> index b5e179360534..19176fde82f3 100644
> --- a/arch/um/Kconfig
> +++ b/arch/um/Kconfig
> @@ -11,7 +11,7 @@ config UML
> select ARCH_HAS_KCOV
> select ARCH_HAS_STRNCPY_FROM_USER
> select ARCH_HAS_STRNLEN_USER
> - select ARCH_NO_PREEMPT
> + select ARCH_NO_PREEMPT_DYNAMIC
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
> index 7414154b8e9a..9970e70be1e4 100644
> --- a/arch/um/include/asm/processor-generic.h
> +++ b/arch/um/include/asm/processor-generic.h
> @@ -44,6 +44,10 @@ struct thread_struct {
> } cb;
> } u;
> } request;
> +#if defined(CONFIG_PREEMPT) || defined(CONFIG_PREEMPT_VOLUNTARY)
> +/ Intel docs require xsave/xrestore area to be aligned to 64 bytes /
> + u8 fpu[2048] __aligned(64);
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
> index 000000000000..4817276b2a26
> --- /dev/null
> +++ b/arch/um/kernel/fpu.c
> @@ -0,0 +1,75 @@
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
> +EXPORT_SYMBOL_GPL(kernel_fpu_begin);
> +

Johannes is right about how flattening the else branch makes
it a bit more readable, imo.

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

--->8---

> @@ -597,8 +609,13 @@ void force_flush_all(void)
> struct vm_area_struct vma;
> VMA_ITERATOR(vmi, mm, 0);
> 
> - mmap_read_lock(mm);
> + / We use a RCU lock instead of a mm lock, because
> + * this can be invoked out of critical/atomic sections
> + * and that does not agree with the sleepable semantics
> + * of the standard semaphore based mm lock.
> + */

As Johannes said, this comment doesn't explain why it's needed,
just that an rcu lock is needed.

> + rcu_read_lock();
> for_each_vma(vmi, vma)
> fix_range(mm, vma->vm_start, vma->vm_end, 1);
> 
> - mmap_read_unlock(mm);
> + rcu_read_unlock();
> }
> --
> 2.30.2

I didn't audit the assortment of preempt_{enable,disable}() pairs,
but I did test this patch with defconfig + debug.config + CONFIG_PREEMPT=y
for 15 minutes and I didn't see any warnings that used to show up.

I think that we should fix what currently exists, then rebase this
PREEMPT patch on top of the results. Plus that'll give me time to look
into the avx + !xsave edge case :)

Cheers,
Peter


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
