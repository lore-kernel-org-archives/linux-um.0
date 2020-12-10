Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-qk1-x741.google.com ([2607:f8b0:4864:20::741])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1knUad-0004PH-5D
 for linux-um@lists.infradead.org; Thu, 10 Dec 2020 22:39:11 +0000
Received: by mail-qk1-x741.google.com with SMTP id d14so6023532qkc.13
 for <linux-um@lists.infradead.org>; Thu, 10 Dec 2020 14:39:10 -0800 (PST)
MIME-Version: 1.0
References: <20201112195718.6070-1-anton.ivanov@cambridgegreys.com>
In-Reply-To: <20201112195718.6070-1-anton.ivanov@cambridgegreys.com>
From: Richard Weinberger <richard.weinberger@gmail.com>
Date: Thu, 10 Dec 2020 23:38:58 +0100
Message-ID: <CAFLxGvxiQiiS5Di3UqZKPyANd5EQC0DwzBZ-9r8skcbe=YYY7w@mail.gmail.com>
Subject: Re: [PATCH v2] um: add a UML specific futex implementation
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
To: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Cc: Richard Weinberger <richard@nod.at>, linux-um <linux-um@lists.infradead.org>

On Thu, Nov 12, 2020 at 8:57 PM <anton.ivanov@cambridgegreys.com> wrote:
>
> From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
>
> The generic asm futex implementation emulates atomic access to
> memory by doing a get_user followed by put_user. These translate
> to two mapping operations on UML with paging enabled in the
> meantime. This, in turn may end up changing interrupts,
> invoking the signal loop, etc.
>
> This replaces the generic implementation by a mapping followed
> by an operation on the mapped segment. It is for now limited
> to 64 bit as the 32 bit may also need to take care of highmem,
> etc.
>
> Signed-off-by: Anton Ivanov <anton.ivanov@cambridgegreys.com>
> ---
>  arch/um/include/asm/futex.h   |  20 ++++++
>  arch/um/kernel/skas/uaccess.c | 119 ++++++++++++++++++++++++++++++++++
>  2 files changed, 139 insertions(+)
>  create mode 100644 arch/um/include/asm/futex.h
>
> diff --git a/arch/um/include/asm/futex.h b/arch/um/include/asm/futex.h
> new file mode 100644
> index 000000000000..9af35ab66b6e
> --- /dev/null
> +++ b/arch/um/include/asm/futex.h
> @@ -0,0 +1,20 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _ASM_GENERIC_FUTEX_H
> +#define _ASM_GENERIC_FUTEX_H
> +
> +#ifdef CONFIG_64BIT
> +
> +#include <linux/futex.h>
> +#include <linux/uaccess.h>
> +#include <asm/errno.h>
> +
> +
> +extern int arch_futex_atomic_op_inuser(int op, u32 oparg, int *oval, u32 __user *uaddr);
> +extern int futex_atomic_cmpxchg_inatomic(u32 *uval, u32 __user *uaddr,
> +                             u32 oldval, u32 newval);
> +
> +#else
> +#include <"asm-generic/futex.h">
> +#endif /* CONFIG_64BIT */
> +
> +#endif
> diff --git a/arch/um/kernel/skas/uaccess.c b/arch/um/kernel/skas/uaccess.c
> index 2dec915abe6f..21a8f2b283bb 100644
> --- a/arch/um/kernel/skas/uaccess.c
> +++ b/arch/um/kernel/skas/uaccess.c
> @@ -11,6 +11,7 @@
>  #include <asm/current.h>
>  #include <asm/page.h>
>  #include <kern_util.h>
> +#include <asm/futex.h>
>  #include <os.h>
>
>  pte_t *virt_to_pte(struct mm_struct *mm, unsigned long addr)
> @@ -248,3 +249,121 @@ long __strnlen_user(const void __user *str, long len)
>         return 0;
>  }
>  EXPORT_SYMBOL(__strnlen_user);
> +
> +/**
> + * arch_futex_atomic_op_inuser() - Atomic arithmetic operation with constant
> + *                       argument and comparison of the previous
> + *                       futex value with another constant.
> + *
> + * @encoded_op:        encoded operation to execute
> + * @uaddr:     pointer to user space address
> + *
> + * Return:
> + * 0 - On success
> + * -EFAULT - User access resulted in a page fault
> + * -EAGAIN - Atomic operation was unable to complete due to contention
> + * -ENOSYS - Operation not supported
> + */
> +int arch_futex_atomic_op_inuser(int op, u32 oparg, int *oval, u32 __user *uaddr)

Does this even build in 32bits mode?
AFAICT the generic futex implementation has
arch_futex_atomic_op_inuser() as static inline...

-- 
Thanks,
//richard

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

