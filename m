Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C8CECD4F57
	for <linux-um@archiver.kernel.org>; Fri, 22 Sep 2023 10:57:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=xoxY6ZWXYuje0CfvOH1p3cfKQk0srfDCN5gc3QGK8nI=; b=QbLvegZKEKN8uQ
	d2mBZY9dEOQDx8ZkdJh2Av6eMmxoGHczvZlebqIdpEK6qFlhccVKN+ecsOeondp63do/7XOUpYEdo
	vm1FT0V5YBp8iBybOhO2ETWMFyJa8rV2en2SdYEIjp5laf2pXxhwZJqGJ8knZRB8dKSprtKiyRExo
	3KJJ8bSbs6Uc6hrt1Y/VG662ISmncJFyxH/MEEXtU+JgWDwUcX+Wy8gWl0i565Ev1jBU9t+VTDRY+
	xE6FhInIcSa5g4Mcbm+9eoGwlhMSbvajQCwI3Mx/ihJY4Z3XswpCw7IP6oKdUqhB+SXKahmNYMGy8
	yNfp0euL/03Xof2t8sIg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qjdqI-008u1l-1q;
	Fri, 22 Sep 2023 10:57:02 +0000
Received: from ns1.kot-begemot.co.uk ([217.160.28.25] helo=www.kot-begemot.co.uk)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qjdqE-008u15-1q
	for linux-um@lists.infradead.org;
	Fri, 22 Sep 2023 10:57:00 +0000
Received: from [192.168.17.6] (helo=jain.kot-begemot.co.uk)
	by www.kot-begemot.co.uk with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <anton.ivanov@cambridgegreys.com>)
	id 1qjdqC-002bky-Rw; Fri, 22 Sep 2023 10:56:57 +0000
Received: from jain.kot-begemot.co.uk ([192.168.3.3])
	by jain.kot-begemot.co.uk with esmtp (Exim 4.94.2)
	(envelope-from <anton.ivanov@cambridgegreys.com>)
	id 1qjdq9-002IEC-WA; Fri, 22 Sep 2023 11:56:56 +0100
Message-ID: <7631d9f7-d8d6-4e66-db2c-5aeaef5d52c8@cambridgegreys.com>
Date: Fri, 22 Sep 2023 11:56:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v6] um: Enable preemption in UML
Content-Language: en-US
To: linux-um@lists.infradead.org
Cc: johannes@sipsolutions.net, richard@nod.at
References: <20230922105609.545573-1-anton.ivanov@cambridgegreys.com>
From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
In-Reply-To: <20230922105609.545573-1-anton.ivanov@cambridgegreys.com>
X-Clacks-Overhead: GNU Terry Pratchett
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230922_035658_767846_DDCFD67B 
X-CRM114-Status: GOOD (  35.59  )
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



On 22/09/2023 11:56, anton.ivanov@cambridgegreys.com wrote:
> From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
> 
> 1. Preemption requires saving/restoring FPU state. This patch
> adds support for it using GCC intrinsics as well as appropriate
> storage space in the thread structure.
> 
> 2. irq critical sections need preempt_disable()/preempt_enable().
> 
> 3. TLB critical sections need preempt_disable()/preempt_enable().

New in this patch - 4 and 5.

> 
> 4. UML TLB flush is also invoked during a fork. This happens
> with interrupts and preempt disabled which disagrees with the
> standard mm locking via rwsem. The mm lock for this code path
> had to be replaced with an rcu.
> 
> 5. The FPU state area is statically allocated depending on
> the enabled PREEMPT options. PREEMPT_DYNAMIC and chosing the
> preemption model at start time is disabled for the UM arch.
> 
> Signed-off-by: Anton Ivanov <anton.ivanov@cambridgegreys.com>
> ---
>   arch/um/Kconfig                         |  2 +-
>   arch/um/include/asm/fpu/api.h           |  9 ++-
>   arch/um/include/asm/processor-generic.h |  4 ++
>   arch/um/kernel/Makefile                 |  4 ++
>   arch/um/kernel/fpu.c                    | 75 +++++++++++++++++++++++++
>   arch/um/kernel/irq.c                    |  2 +
>   arch/um/kernel/tlb.c                    | 21 ++++++-
>   7 files changed, 111 insertions(+), 6 deletions(-)
>   create mode 100644 arch/um/kernel/fpu.c
> 
> diff --git a/arch/um/Kconfig b/arch/um/Kconfig
> index b5e179360534..19176fde82f3 100644
> --- a/arch/um/Kconfig
> +++ b/arch/um/Kconfig
> @@ -11,7 +11,7 @@ config UML
>   	select ARCH_HAS_KCOV
>   	select ARCH_HAS_STRNCPY_FROM_USER
>   	select ARCH_HAS_STRNLEN_USER
> -	select ARCH_NO_PREEMPT
> +	select ARCH_NO_PREEMPT_DYNAMIC
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
> index 7414154b8e9a..9970e70be1e4 100644
> --- a/arch/um/include/asm/processor-generic.h
> +++ b/arch/um/include/asm/processor-generic.h
> @@ -44,6 +44,10 @@ struct thread_struct {
>   			} cb;
>   		} u;
>   	} request;
> +#if defined(CONFIG_PREEMPT) || defined(CONFIG_PREEMPT_VOLUNTARY)
> +/* Intel docs require xsave/xrestore area to be aligned to 64 bytes */
> +	u8 fpu[2048] __aligned(64);
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
> index 000000000000..4817276b2a26
> --- /dev/null
> +++ b/arch/um/kernel/fpu.c
> @@ -0,0 +1,75 @@
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
> diff --git a/arch/um/kernel/tlb.c b/arch/um/kernel/tlb.c
> index 7d050ab0f78a..00b1870c2d62 100644
> --- a/arch/um/kernel/tlb.c
> +++ b/arch/um/kernel/tlb.c
> @@ -322,6 +322,8 @@ static void fix_range_common(struct mm_struct *mm, unsigned long start_addr,
>   	unsigned long addr = start_addr, next;
>   	int ret = 0, userspace = 1;
>   
> +	preempt_disable();
> +
>   	hvc = INIT_HVC(mm, force, userspace);
>   	pgd = pgd_offset(mm, addr);
>   	do {
> @@ -346,6 +348,7 @@ static void fix_range_common(struct mm_struct *mm, unsigned long start_addr,
>   		       "process: %d\n", task_tgid_vnr(current));
>   		mm_idp->kill = 1;
>   	}
> +	preempt_enable();
>   }
>   
>   static int flush_tlb_kernel_range_common(unsigned long start, unsigned long end)
> @@ -362,6 +365,9 @@ static int flush_tlb_kernel_range_common(unsigned long start, unsigned long end)
>   
>   	mm = &init_mm;
>   	hvc = INIT_HVC(mm, force, userspace);
> +
> +	preempt_disable();
> +
>   	for (addr = start; addr < end;) {
>   		pgd = pgd_offset(mm, addr);
>   		if (!pgd_present(*pgd)) {
> @@ -449,6 +455,9 @@ static int flush_tlb_kernel_range_common(unsigned long start, unsigned long end)
>   
>   	if (err < 0)
>   		panic("flush_tlb_kernel failed, errno = %d\n", err);
> +
> +	preempt_enable();
> +
>   	return updated;
>   }
>   
> @@ -466,6 +475,8 @@ void flush_tlb_page(struct vm_area_struct *vma, unsigned long address)
>   
>   	address &= PAGE_MASK;
>   
> +	preempt_disable();
> +
>   	pgd = pgd_offset(mm, address);
>   	if (!pgd_present(*pgd))
>   		goto kill;
> @@ -520,6 +531,7 @@ void flush_tlb_page(struct vm_area_struct *vma, unsigned long address)
>   
>   	*pte = pte_mkuptodate(*pte);
>   
> +	preempt_enable();
>   	return;
>   
>   kill:
> @@ -597,8 +609,13 @@ void force_flush_all(void)
>   	struct vm_area_struct *vma;
>   	VMA_ITERATOR(vmi, mm, 0);
>   
> -	mmap_read_lock(mm);
> +	/* We use a RCU lock instead of a mm lock, because
> +	 * this can be invoked out of critical/atomic sections
> +	 * and that does not agree with the sleepable semantics
> +	 * of the standard semaphore based mm lock.
> +	 */
> +	rcu_read_lock();
>   	for_each_vma(vmi, vma)
>   		fix_range(mm, vma->vm_start, vma->vm_end, 1);
> -	mmap_read_unlock(mm);
> +	rcu_read_unlock();
>   }

-- 
Anton R. Ivanov
Cambridgegreys Limited. Registered in England. Company Number 10273661
https://www.cambridgegreys.com/

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
