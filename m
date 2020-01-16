Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-qk1-x741.google.com ([2607:f8b0:4864:20::741])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1is19e-0006wm-Kj
 for linux-um@lists.infradead.org; Thu, 16 Jan 2020 09:09:36 +0000
Received: by mail-qk1-x741.google.com with SMTP id z14so18432329qkg.9
 for <linux-um@lists.infradead.org>; Thu, 16 Jan 2020 01:09:30 -0800 (PST)
MIME-Version: 1.0
References: <20200115182816.33892-1-trishalfonso@google.com>
In-Reply-To: <20200115182816.33892-1-trishalfonso@google.com>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Thu, 16 Jan 2020 10:09:17 +0100
Message-ID: <CACT4Y+ahnhTXQPfxcJPEFOA1saAr4xOGY583am8buW7kMJiq8w@mail.gmail.com>
Subject: Re: [RFC PATCH] UML: add support for KASAN under x86_64
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
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: Patricia Alfonso <trishalfonso@google.com>
Cc: Richard Weinberger <richard@nod.at>, Jeff Dike <jdike@addtoit.com>, Brendan Higgins <brendanhiggins@google.com>, LKML <linux-kernel@vger.kernel.org>, kasan-dev <kasan-dev@googlegroups.com>, linux-um@lists.infradead.org, David Gow <davidgow@google.com>, Andrey Ryabinin <aryabinin@virtuozzo.com>, anton.ivanov@cambridgegreys.com

On Wed, Jan 15, 2020 at 7:28 PM Patricia Alfonso
<trishalfonso@google.com> wrote:
> diff --git a/arch/um/include/asm/kasan.h b/arch/um/include/asm/kasan.h
> new file mode 100644
> index 000000000000..ca4c43a35d41
> --- /dev/null
> +++ b/arch/um/include/asm/kasan.h
> @@ -0,0 +1,32 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef __ASM_UM_KASAN_H
> +#define __ASM_UM_KASAN_H
> +
> +#include <linux/init.h>
> +#include <linux/const.h>
> +
> +#define KASAN_SHADOW_OFFSET _AC(CONFIG_KASAN_SHADOW_OFFSET, UL)
> +#ifdef CONFIG_X86_64
> +#define KASAN_SHADOW_SIZE 0x100000000000UL

How was this number computed? Can we replace this with some formula?
I suspect this may be an order of magnitude off. Isn't 0x10000000000 enough?

> +#else
> +#error "KASAN_SHADOW_SIZE is not defined in this sub-architecture"
> +#endif
> +
> +// used in kasan_mem_to_shadow to divide by 8
> +#define KASAN_SHADOW_SCALE_SHIFT 3
> +
> +#define KASAN_SHADOW_START (KASAN_SHADOW_OFFSET)
> +#define KASAN_SHADOW_END (KASAN_SHADOW_START + KASAN_SHADOW_SIZE)
> +
> +#ifdef CONFIG_KASAN
> +void kasan_init(void);
> +void kasan_map_shadow(void);
> +#else
> +static inline void kasan_early_init(void) { }
> +static inline void kasan_init(void) { }
> +#endif /* CONFIG_KASAN */
> +
> +void kasan_map_memory(void *start, unsigned long len);

This better be moved under #ifdef CONFIG_KASAN, it's not defined
otherwise, right?

> +void kasan_unpoison_shadow(const void *address, size_t size);

This is defined by <linux/kasan.h>. It's better to include that file
where you need this function. Or there are some issues with that?

> +
> +#endif /* __ASM_UM_KASAN_H */



> diff --git a/arch/um/kernel/kasan_init_um.c b/arch/um/kernel/kasan_init_um.c
> new file mode 100644
> index 000000000000..2e9a85216fb5
> --- /dev/null
> +++ b/arch/um/kernel/kasan_init_um.c
> @@ -0,0 +1,20 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <asm/kasan.h>
> +#include <linux/sched.h>
> +#include <linux/sched/task.h>
> +#include <asm/dma.h>
> +#include <as-layout.h>
> +
> +void kasan_init(void)
> +{
> +       kasan_map_memory((void *)KASAN_SHADOW_START, KASAN_SHADOW_SIZE);
> +
> +       // unpoison the kernel text which is form uml_physmem -> uml_reserved

Why do we need to unpoison _text_? Who is accessing shadow for it? Do
you mean data/bss?
But on a more general point, we just allocated it with mmap, mmap
always gives zeroed memory and asan shadow is specifically arranged so
that 0's mean "good". So I don't think we need to unpoison anything
separately.

What may be more useful is to poison (or better mprotect, unmap, not
mmap) regions that kernel is not supposed to ever touch. One such
region is shadow self-mapping (shadow for shadow), in user-space we
mprotect that region. For KASAN we don't map shadow for user-space
part of VM, but I don't know if UML has such separation. We could also
protect other UML-specific regions if there are any, e.g does anybody
read/write text?


> +       kasan_unpoison_shadow((void *)uml_physmem, physmem_size);
> +
> +       // unpoison the vmalloc region, which is start_vm -> end_vm
> +       kasan_unpoison_shadow((void *)start_vm, (end_vm - start_vm + 1));
> +
> +       init_task.kasan_depth = 0;
> +       pr_info("KernelAddressSanitizer initialized\n");
> +}

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

