Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from lithops.sigma-star.at ([195.201.40.130])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gfMTf-0005Rt-6h
 for linux-um@lists.infradead.org; Fri, 04 Jan 2019 10:13:21 +0000
From: Richard Weinberger <richard@nod.at>
Subject: Re: [PATCH] um: Try to avoid kmalloc in signal handling
Date: Fri, 04 Jan 2019 11:13:06 +0100
Message-ID: <2157515.SUgOQPs8Ts@blindfold>
In-Reply-To: <20190104100517.9809-1-anton.ivanov@cambridgegreys.com>
References: <20190104100517.9809-1-anton.ivanov@cambridgegreys.com>
MIME-Version: 1.0
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
Cc: linux-um@lists.infradead.org

Am Freitag, 4. Januar 2019, 11:05:17 CET schrieb anton.ivanov@cambridgegreys.com:
> From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
> 
> Signal handling (which maps to interrupt handling in UML) needs
> to pass current registers to the relevant handlers and was
> allocating a structure for that using kmalloc. It is possible
> to avoid this kmalloc by using a small "signal register stack".
> A depth of 4 suffices for normal use. If it is exceeded
> further sets of registers are allocated as before via kmalloc.
> 
> The end result is >10% performance increase in networking
> as measured by iperf and >5% across the board.
> 
> Signed-off-by: Anton Ivanov <anton.ivanov@cambridgegreys.com>
> ---
>  arch/um/include/shared/os.h |  4 ++++
>  arch/um/kernel/signal.c     | 31 +++++++++++++++++++++++++++++++
>  arch/um/os-Linux/signal.c   | 16 ++++------------
>  3 files changed, 39 insertions(+), 12 deletions(-)
> 
> diff --git a/arch/um/include/shared/os.h b/arch/um/include/shared/os.h
> index ebf23012a59b..4ec1bc63213b 100644
> --- a/arch/um/include/shared/os.h
> +++ b/arch/um/include/shared/os.h
> @@ -319,4 +319,8 @@ extern unsigned long os_get_top_address(void);
>  
>  long syscall(long number, ...);
>  
> +/* signal.c */
> +extern struct uml_pt_regs *get_save_register_state(void);
> +extern void release_save_register_state(struct uml_pt_regs *r);
> +
>  #endif
> diff --git a/arch/um/kernel/signal.c b/arch/um/kernel/signal.c
> index 57acbd67d85d..558ac7e4df97 100644
> --- a/arch/um/kernel/signal.c
> +++ b/arch/um/kernel/signal.c
> @@ -6,11 +6,18 @@
>  #include <linux/module.h>
>  #include <linux/ptrace.h>
>  #include <linux/sched.h>
> +#include <linux/slab.h>
>  #include <asm/siginfo.h>
>  #include <asm/signal.h>
>  #include <asm/unistd.h>
>  #include <frame_kern.h>
>  #include <kern_util.h>
> +#include <os.h>
> +
> +static atomic_t reg_depth;
> +
> +static struct uml_pt_regs reg_file[4];
> +#define REG_SWITCH_TO_KMALLOC_DEPTH 3

I fear this is not correct.
Think of task switching, if you push something to reg_file[],
it is not guaranteed that the same task will run next and pop the item.
The order can change.

Thanks,
//richard





_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

