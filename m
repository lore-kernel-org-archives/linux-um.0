Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from ivanoab7.miniserver.com ([37.128.132.42]
 helo=www.kot-begemot.co.uk)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1klfkD-0007QS-1y
 for linux-um@lists.infradead.org; Sat, 05 Dec 2020 22:09:35 +0000
Subject: Re: [PATCH 2/2] um: allocate a guard page to helper threads
References: <20201205215016.eac3b08ee1a2.I47d69ccd6a474726b83813c60a75aa82556b69ae@changeid>
 <20201205215016.c9770d63195d.I816f5a22bff56c55095e7c847df8449d08e9514c@changeid>
From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Message-ID: <20f9d000-d4a9-59cc-9dba-9673d9185def@cambridgegreys.com>
Date: Sat, 5 Dec 2020 22:09:24 +0000
MIME-Version: 1.0
In-Reply-To: <20201205215016.c9770d63195d.I816f5a22bff56c55095e7c847df8449d08e9514c@changeid>
Content-Language: en-US
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
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: Johannes Berg <johannes@sipsolutions.net>, linux-um@lists.infradead.org
Cc: Johannes Berg <johannes.berg@intel.com>

On 05/12/2020 20:50, Johannes Berg wrote:
> From: Johannes Berg <johannes.berg@intel.com>
> 
> We've been running into stack overflows in helper threads
> corrupting memory (e.g. because somebody put printf() or
> os_info() there), so to avoid those causing hard-to-debug
> issues later on, allocate a guard page for helper thread
> stacks and mark it read-only.
> 
> Unfortunately, the crash dump at that point is useless as
> the stack tracer will try to backtrace the *kernel* thread,
> not the helper thread, but at least we don't survive to a
> random issue caused by corruption.
> 
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> ---
>   arch/um/drivers/ubd_kern.c         |  2 +-
>   arch/um/include/shared/kern_util.h |  2 +-
>   arch/um/kernel/process.c           | 11 +++++++----
>   arch/um/os-Linux/helper.c          |  4 ++--
>   4 files changed, 11 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/um/drivers/ubd_kern.c b/arch/um/drivers/ubd_kern.c
> index d4c39e595c72..390edda0794f 100644
> --- a/arch/um/drivers/ubd_kern.c
> +++ b/arch/um/drivers/ubd_kern.c
> @@ -1192,7 +1192,7 @@ static int __init ubd_driver_init(void){
>   		/* Letting ubd=sync be like using ubd#s= instead of ubd#= is
>   		 * enough. So use anyway the io thread. */
>   	}
> -	stack = alloc_stack(0, 0);
> +	stack = alloc_stack(0);
>   	io_pid = start_io_thread(stack + PAGE_SIZE - sizeof(void *),
>   				 &thread_fd);
>   	if(io_pid < 0){
> diff --git a/arch/um/include/shared/kern_util.h b/arch/um/include/shared/kern_util.h
> index 2888ec812f6e..d8c279e3312f 100644
> --- a/arch/um/include/shared/kern_util.h
> +++ b/arch/um/include/shared/kern_util.h
> @@ -19,7 +19,7 @@ extern int kmalloc_ok;
>   #define UML_ROUND_UP(addr) \
>   	((((unsigned long) addr) + PAGE_SIZE - 1) & PAGE_MASK)
>   
> -extern unsigned long alloc_stack(int order, int atomic);
> +extern unsigned long alloc_stack(int atomic);
>   extern void free_stack(unsigned long stack, int order);
>   
>   struct pt_regs;
> diff --git a/arch/um/kernel/process.c b/arch/um/kernel/process.c
> index f0f50eae2293..37490c27f711 100644
> --- a/arch/um/kernel/process.c
> +++ b/arch/um/kernel/process.c
> @@ -32,6 +32,7 @@
>   #include <os.h>
>   #include <skas.h>
>   #include <linux/time-internal.h>
> +#include <asm/set_memory.h>
>   
>   /*
>    * This is a per-cpu array.  A processor only modifies its entry and it only
> @@ -62,16 +63,18 @@ void free_stack(unsigned long stack, int order)
>   	free_pages(stack, order);
>   }
>   
> -unsigned long alloc_stack(int order, int atomic)
> +unsigned long alloc_stack(int atomic)
>   {
> -	unsigned long page;
> +	unsigned long addr;
>   	gfp_t flags = GFP_KERNEL;
>   
>   	if (atomic)
>   		flags = GFP_ATOMIC;
> -	page = __get_free_pages(flags, order);
> +	addr = __get_free_pages(flags, 1);

Why are you dropping order? I believe we do not fit in a stack of order 
less than 2 on newer 64 bit and we need even more with valgrind.

>   
> -	return page;
> +	set_memory_ro(addr, 1);
> +
> +	return addr + PAGE_SIZE;
>   }
>   
>   static inline void set_current(struct task_struct *task)
> diff --git a/arch/um/os-Linux/helper.c b/arch/um/os-Linux/helper.c
> index 9fa6e4187d4f..feb48d796e00 100644
> --- a/arch/um/os-Linux/helper.c
> +++ b/arch/um/os-Linux/helper.c
> @@ -45,7 +45,7 @@ int run_helper(void (*pre_exec)(void *), void *pre_data, char **argv)
>   	unsigned long stack, sp;
>   	int pid, fds[2], ret, n;
>   
> -	stack = alloc_stack(0, __cant_sleep());
> +	stack = alloc_stack(__cant_sleep());
>   	if (stack == 0)
>   		return -ENOMEM;
>   
> @@ -116,7 +116,7 @@ int run_helper_thread(int (*proc)(void *), void *arg, unsigned int flags,
>   	unsigned long stack, sp;
>   	int pid, status, err;
>   
> -	stack = alloc_stack(0, __cant_sleep());
> +	stack = alloc_stack(__cant_sleep());
>   	if (stack == 0)
>   		return -ENOMEM;
>   
> 


-- 
Anton R. Ivanov
Cambridgegreys Limited. Registered in England. Company Number 10273661
https://www.cambridgegreys.com/

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

