Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-ed1-x541.google.com ([2a00:1450:4864:20::541])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gPeR3-0006a2-Op
 for linux-um@lists.infradead.org; Thu, 22 Nov 2018 02:09:43 +0000
Received: by mail-ed1-x541.google.com with SMTP id z28so6421937edi.8
 for <linux-um@lists.infradead.org>; Wed, 21 Nov 2018 18:09:29 -0800 (PST)
MIME-Version: 1.0
References: <20181116083215.7165-1-anton.ivanov@cambridgegreys.com>
In-Reply-To: <20181116083215.7165-1-anton.ivanov@cambridgegreys.com>
From: liwei <liwei@anbutu.com>
Date: Thu, 22 Nov 2018 10:09:16 +0800
Message-ID: <CANB_DmtJAp6aye5_mnuCzf5D_hmAES+WEJcvYOUWPsaFXBL9vQ@mail.gmail.com>
Subject: Re: [PATCH] um: Remove unnecessary kmap_atomic in uaccess on 64bit
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
To: anton.ivanov@cambridgegreys.com
Cc: richard@nod.at, linux-um@lists.infradead.org

Hi Anton,

On Fri, Nov 16, 2018 at 4:32 PM <anton.ivanov@cambridgegreys.com> wrote:
>
> From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
>
> On 64 bit architectures it is not necessary to perform highmem
> kmap_/kunmap for various copy to/from user operations. The mmu
> emulation on its own is sufficient to provide the correct address
> offset to execute a memcpy().
>
> This results in 3%-7% improvement in various copy_to/from ops.
>
> Signed-off-by: Anton Ivanov <anton.ivanov@cambridgegreys.com>
> ---
>  arch/um/kernel/skas/uaccess.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
>
> diff --git a/arch/um/kernel/skas/uaccess.c b/arch/um/kernel/skas/uaccess.c
> index d450797a3a7c..615be3ec98eb 100644
> --- a/arch/um/kernel/skas/uaccess.c
> +++ b/arch/um/kernel/skas/uaccess.c
> @@ -69,20 +69,26 @@ static int do_op_one_page(unsigned long addr, int len, int is_write,
>                 return -1;
>
>         page = pte_page(*pte);
> +       current->thread.fault_catcher = &buf;
> +       faulted = UML_SETJMP(&buf);

I'm wondering why should we move these in front of kmap_atomic(), as
in a faulted situation
this will lead to a second kmap_atomic() execution.

Thanks

> +#ifndef CONFIG_64BIT
>         addr = (unsigned long) kmap_atomic(page) +
>                 (addr & ~PAGE_MASK);
> +#else
> +       addr = (unsigned long) page_address(page) +
> +               (addr & ~PAGE_MASK);
> +#endif
>
> -       current->thread.fault_catcher = &buf;
>
> -       faulted = UML_SETJMP(&buf);
>         if (faulted == 0)
>                 n = (*op)(addr, len, arg);
>         else
>                 n = -1;
>
>         current->thread.fault_catcher = NULL;
> -
> +#ifndef CONFIG_64BIT
>         kunmap_atomic((void *)addr);
> +#endif
>
>         return n;
>  }
> --
> 2.11.0
>
>
> _______________________________________________
> linux-um mailing list
> linux-um@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-um

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

