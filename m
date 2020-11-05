Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from ivanoab7.miniserver.com ([37.128.132.42]
 helo=www.kot-begemot.co.uk)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kak4u-00085x-Qu
 for linux-um@lists.infradead.org; Thu, 05 Nov 2020 18:33:45 +0000
Subject: Re: [PATCH] um: add support for TIF_NOTIFY_SIGNAL
References: <d0b7533b-9c4c-369e-3a3d-6f98a18417d9@kernel.dk>
From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Message-ID: <27d9aa86-5409-f381-0742-294d27dbcfa9@cambridgegreys.com>
Date: Thu, 5 Nov 2020 18:15:04 +0000
MIME-Version: 1.0
In-Reply-To: <d0b7533b-9c4c-369e-3a3d-6f98a18417d9@kernel.dk>
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
To: Jens Axboe <axboe@kernel.dk>, linux-um@lists.infradead.org



On 29/10/2020 16:23, Jens Axboe wrote:
> Wire up TIF_NOTIFY_SIGNAL handling for um.
> 
> Cc: linux-um@lists.infradead.org
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> ---
> 
> 5.11 has support queued up for TIF_NOTIFY_SIGNAL, see this posting
> for details:
> 
> https://lore.kernel.org/io-uring/20201026203230.386348-1-axboe@kernel.dk/
> 
> As part of that work, I'm adding TIF_NOTIFY_SIGNAL support to all archs,
> as that will enable a set of cleanups once all of them support it. I'm
> happy carrying this patch if need be, or it can be funelled through the
> arch tree. Let me know.
> 
>   arch/um/include/asm/thread_info.h | 2 ++
>   arch/um/kernel/process.c          | 3 ++-
>   2 files changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/um/include/asm/thread_info.h b/arch/um/include/asm/thread_info.h
> index 4c19ce4c49f1..3b1cb8b3b186 100644
> --- a/arch/um/include/asm/thread_info.h
> +++ b/arch/um/include/asm/thread_info.h
> @@ -57,6 +57,7 @@ static inline struct thread_info *current_thread_info(void)
>   #define TIF_SYSCALL_TRACE	0	/* syscall trace active */
>   #define TIF_SIGPENDING		1	/* signal pending */
>   #define TIF_NEED_RESCHED	2	/* rescheduling necessary */
> +#define TIF_NOTIFY_SIGNAL	3	/* signal notifications exist */
>   #define TIF_RESTART_BLOCK	4
>   #define TIF_MEMDIE		5	/* is terminating due to OOM killer */
>   #define TIF_SYSCALL_AUDIT	6
> @@ -67,6 +68,7 @@ static inline struct thread_info *current_thread_info(void)
>   #define _TIF_SYSCALL_TRACE	(1 << TIF_SYSCALL_TRACE)
>   #define _TIF_SIGPENDING		(1 << TIF_SIGPENDING)
>   #define _TIF_NEED_RESCHED	(1 << TIF_NEED_RESCHED)
> +#define _TIF_NOTIFY_SIGNAL	(1 << TIF_NOTIFY_SIGNAL)
>   #define _TIF_MEMDIE		(1 << TIF_MEMDIE)
>   #define _TIF_SYSCALL_AUDIT	(1 << TIF_SYSCALL_AUDIT)
>   #define _TIF_SECCOMP		(1 << TIF_SECCOMP)
> diff --git a/arch/um/kernel/process.c b/arch/um/kernel/process.c
> index 3bed09538dd9..9e19da9e6198 100644
> --- a/arch/um/kernel/process.c
> +++ b/arch/um/kernel/process.c
> @@ -99,7 +99,8 @@ void interrupt_end(void)
>   
>   	if (need_resched())
>   		schedule();
> -	if (test_thread_flag(TIF_SIGPENDING))
> +	if (test_thread_flag(TIF_SIGPENDING) ||
> +	    test_thread_flag(TIF_NOTIFY_SIGNAL))
>   		do_signal(regs);
>   	if (test_thread_flag(TIF_NOTIFY_RESUME))
>   		tracehook_notify_resume(regs);
> 

Acked-By: Anton Ivanov <anton.ivanov@cambridgegreys.com>

-- 
Anton R. Ivanov
Cambridgegreys Limited. Registered in England. Company Number 10273661
https://www.cambridgegreys.com/

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

