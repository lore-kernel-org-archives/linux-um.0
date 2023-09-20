Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0493ECE79DE
	for <linux-um@archiver.kernel.org>; Wed, 20 Sep 2023 14:50:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:Cc:From:To:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=6DBRzD+CHddyv3pNpI3/DYqwZHiLFmFssrJFSTLjvDI=; b=bD5CvLUOzlqL8T
	ngDMzbnQbje8vhVb8MDF4cSMpwKH5fg9xfZkrSB9sGNSwiFe7OoUlb9129gDDDmlzzX5ASxxP0KaU
	RHyn2xx/S0ZXoZ7cCtF2jGiUJEPi7DvYPZRdecLE+HHTUBwa4VPb19+Rp73/E3D8qjAdLcnPCzUDh
	Qn8ol8J8uAk5zIy1fwE5PNjaPUK/6U62x5KvnjnrX9KUMrOwTNrzLV+n9B9OhSR/oDFJ9ELvRj9sB
	MWX/L7/QdJRIjywwJ2H7HC7bf4jte4sEuRgNe/551U4uUWVHKdsDOob1XB8ntQd/jEUKXsC71jB5s
	/uJauxhgxiw9/w+QCD1w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qiyWo-003Q9e-2M;
	Wed, 20 Sep 2023 14:50:10 +0000
Received: from mail-4317.proton.ch ([185.70.43.17])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qiyWj-003Q7o-2P
	for linux-um@lists.infradead.org;
	Wed, 20 Sep 2023 14:50:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=n8pjl.ca;
	s=protonmail2; t=1695221399; x=1695480599;
	bh=4VWNLXXLOELdOA1f44llnSxegZ0fzKMEoF5Sd7ZlvYA=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=e8U6UIaAETk8fB7cg/gyjHGpUy/XAXcOW7+Rt3EpDgplnOzJhVe61rx7JmxKdcNpP
	 qKmiNNeooUPMZFlMxihvGfaPcgC9wUDLh9P8jxByv9AJAjDS3Tl2h3y3ShzYZ5KFaF
	 KOHNrwQrpmYM2uInQIp+MjsmL5rG5fJ6Uj6ZgBaLDSmJoc+67oMSP+X8EPZZfAUuZp
	 PhjYARGrQptvd9+TE3LBRpnP7c0ZficFaZH8yMH//Vp5+s47S0+4S6wUp/WfyT7w0M
	 mipLSf8ICzcpLhHXJCqvxDp/M6kt5EEo6oD1qbt4e6D8Pyr7saz/Gm8Ho6IhuoSVKl
	 Sq7t/JJE66OjA==
Date: Wed, 20 Sep 2023 14:49:49 +0000
To: anton.ivanov@cambridgegreys.com
From: Peter Lafreniere <peter@n8pjl.ca>
Cc: johannes@sipsolutions.net, linux-um@lists.infradead.org, richard@nod.at
Subject: Re: [PATCH] um: Enable preemption in UML
Message-ID: <20230920144943.19271-1-peter@n8pjl.ca>
In-Reply-To: <20230920123115.4106721-1-anton.ivanov@cambridgegreys.com>
References: <20230920123115.4106721-1-anton.ivanov@cambridgegreys.com>
Feedback-ID: 53133685:user:proton
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230920_075007_509411_A46B871D 
X-CRM114-Status: GOOD (  23.67  )
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

On Wed, Sep 20, 2023 at 08:31, anton.ivanov@cambridgegreys.com wrote:
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
> arch/um/Makefile | 3 +-
> arch/um/include/asm/fpu/api.h | 4 +-
> arch/um/include/asm/processor-generic.h | 1 +
> arch/um/kernel/Makefile | 2 +-
> arch/um/kernel/fpu.c | 49 +++++++++++++++++++++++++
> 6 files changed, 55 insertions(+), 5 deletions(-)
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
> diff --git a/arch/um/Makefile b/arch/um/Makefile
> index 82f05f250634..35a059baadeb 100644
> --- a/arch/um/Makefile
> +++ b/arch/um/Makefile
> @@ -61,7 +61,8 @@ KBUILD_CFLAGS += $(CFLAGS) $(CFLAGS-y) -D__arch_um__ \
> $(ARCH_INCLUDE) $(MODE_INCLUDE) -Dvmap=kernel_vmap \
> -Dlongjmp=kernel_longjmp -Dsetjmp=kernel_setjmp \
> -Din6addr_loopback=kernel_in6addr_loopback \
> - -Din6addr_any=kernel_in6addr_any -Dstrrchr=kernel_strrchr
> + -Din6addr_any=kernel_in6addr_any -Dstrrchr=kernel_strrchr \
> + -mxsave

Since we're now using a new isa extention, I would add a check in
linux_main() with a warning message if xsave is not available.

It also wouldn't hurt to only require xsave if CONFIG_PREEMPT is enabled. 

> 
> KBUILD_RUSTFLAGS += -Crelocation-model=pie
> 
> diff --git a/arch/um/include/asm/fpu/api.h b/arch/um/include/asm/fpu/api.h
> index 71bfd9ef3938..0094624ae9b4 100644
> --- a/arch/um/include/asm/fpu/api.h
> +++ b/arch/um/include/asm/fpu/api.h
> @@ -8,8 +8,8 @@
> * of x86 optimized copy, xor, etc routines into the
> * UML code tree. /
> 
> -#define kernel_fpu_begin() (void)0
> -#define kernel_fpu_end() (void)0
> +void kernel_fpu_begin(void);
> +void kernel_fpu_end(void);
> 
> static inline bool irq_fpu_usable(void)
> {
> diff --git a/arch/um/include/asm/processor-generic.h b/arch/um/include/asm/processor-generic.h
> index 7414154b8e9a..1c3287f1a444 100644
> --- a/arch/um/include/asm/processor-generic.h
> +++ b/arch/um/include/asm/processor-generic.h
> @@ -44,6 +44,7 @@ struct thread_struct {
> } cb;
> } u;
> } request;
> + u8 fpu[512] __aligned(16); / Intel docs require xsave/xrestore area to be aligned to 16 bytes /
> };
> 
> #define INIT_THREAD \
> diff --git a/arch/um/kernel/Makefile b/arch/um/kernel/Makefile
> index 811188be954c..5d9fbaa544be 100644
> --- a/arch/um/kernel/Makefile
> +++ b/arch/um/kernel/Makefile
> @@ -16,7 +16,7 @@ extra-y := vmlinux.lds
> 
> obj-y = config.o exec.o exitcode.o irq.o ksyms.o mem.o \
> physmem.o process.o ptrace.o reboot.o sigio.o \
> - signal.o sysrq.o time.o tlb.o trap.o \
> + signal.o sysrq.o time.o tlb.o trap.o fpu.o\
> um_arch.o umid.o maccess.o kmsg_dump.o capflags.o skas/
> obj-y += load_file.o
> 
> diff --git a/arch/um/kernel/fpu.c b/arch/um/kernel/fpu.c
> new file mode 100644
> index 000000000000..4142a08c474d
> --- /dev/null
> +++ b/arch/um/kernel/fpu.c
> @@ -0,0 +1,49 @@
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
> +
> +/*
> + * The critical section between kernel_fpu_begin() and kernel_fpu_end()
> + * is non-reentrant. It is the caller's responsibility to avoid reentrance.
> + */
> +
> +static DEFINE_PER_CPU(bool, in_kernel_fpu);
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
> + __builtin_ia32_fxsave64(&current->thread.fpu);
> 
> +#else
> + __builtin_ia32_fxsave(&current->thread.fpu);
> 
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
> + __builtin_ia32_fxrstor64(&current->thread.fpu);
> 
> +#else
> + __builtin_ia32_fxrstor(&current->thread.fpu);
> 
> +#endif
> + this_cpu_write(in_kernel_fpu, false);
> +
> + preempt_enable();
> +}
> +EXPORT_SYMBOL_GPL(kernel_fpu_end);
> +

According to https://www.felixcloutier.com/x86/fxsave, the fxsave and fxrstor
instructions do not save ymm, zmm, or mask registers. Please make that explicit
in your comment, or replace intrinsics with inline assembler to support those
registers.

Several x86 crypto routines use these larger registers which could overwrite
userspace registers. These modules aren't built by default, and may not be
available on UML. Even so, this issue is worth a comment, at the least.

On my system, lscpu within uml shows all the feature flags that are available
on the host system, which includes AVX extentions.

Cheers,
Peter Lafreniere


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
