Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from ivanoab7.miniserver.com ([37.128.132.42]
 helo=www.kot-begemot.co.uk)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kkmsX-000443-1i
 for linux-um@lists.infradead.org; Thu, 03 Dec 2020 11:34:30 +0000
Subject: Re: [PATCH v7 4/5] um: support suspend to RAM
References: <20201202195808.244645-1-johannes@sipsolutions.net>
 <20201202205659.aee91a932c38.I3e8e33cbe3196d9325946af3a5655f7b6719382d@changeid>
From: Anton Ivanov <anton.ivanov@kot-begemot.co.uk>
Message-ID: <717ba48f-2000-d146-5f55-56d85888760a@kot-begemot.co.uk>
Date: Thu, 3 Dec 2020 11:34:24 +0000
MIME-Version: 1.0
In-Reply-To: <20201202205659.aee91a932c38.I3e8e33cbe3196d9325946af3a5655f7b6719382d@changeid>
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



On 02/12/2020 19:58, Johannes Berg wrote:
> From: Johannes Berg <johannes.berg@intel.com>
> 
> With all the previous bits in place, we can now also support
> suspend to RAM, in the sense that everything is suspended,
> not just most, including userspace, processes like in s2idle.
> 
> Since um_idle_sleep() now waits forever, we can simply call
> that to "suspend" the system.
> 
> As before, you can wake it up using SIGUSR1 since we're just
> in a pause() call that only needs to return.
> 
> In order to implement selective resume from certain devices,
> and not have any arbitrary device interrupt wake up, suspend
> interrupts by removing SIGIO notification (O_ASYNC) from all
> the FDs that are not supposed to wake up the system. However,
> swap out the handler so we don't actually handle the SIGIO as
> an interrupt.
> 
> Since we're in pause(), the mere act of receiving SIGIO wakes
> us up, and then after things have been restored enough, re-set
> O_ASYNC for all previously suspended FDs, reinstall the proper
> SIGIO handler, and send SIGIO to self to process anything that
> might now be pending.
> 
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> ---
> v7:
>   - clean up a bit
>   - send SIGIO to self properly, not to the entire group
> ---
>   arch/um/include/shared/kern_util.h |  1 +
>   arch/um/include/shared/os.h        |  3 +
>   arch/um/kernel/irq.c               | 88 +++++++++++++++++++++++++++++-
>   arch/um/kernel/process.c           |  2 +-
>   arch/um/kernel/um_arch.c           | 42 ++++++++++++++
>   arch/um/os-Linux/signal.c          |  5 ++
>   6 files changed, 139 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/um/include/shared/kern_util.h b/arch/um/include/shared/kern_util.h
> index 9c08e728a675..2888ec812f6e 100644
> --- a/arch/um/include/shared/kern_util.h
> +++ b/arch/um/include/shared/kern_util.h
> @@ -68,5 +68,6 @@ extern void bus_handler(int sig, struct siginfo *si, struct uml_pt_regs *regs);
>   extern void winch(int sig, struct siginfo *unused_si, struct uml_pt_regs *regs);
>   extern void fatal_sigsegv(void) __attribute__ ((noreturn));
>   
> +void um_idle_sleep(void);
>   
>   #endif
> diff --git a/arch/um/include/shared/os.h b/arch/um/include/shared/os.h
> index 78250a05394a..cd750d4edfb5 100644
> --- a/arch/um/include/shared/os.h
> +++ b/arch/um/include/shared/os.h
> @@ -233,6 +233,7 @@ extern void timer_set_signal_handler(void);
>   extern void set_sigstack(void *sig_stack, int size);
>   extern void remove_sigstack(void);
>   extern void set_handler(int sig);
> +extern void send_sigio_to_self(void);
>   extern int change_sig(int signal, int on);
>   extern void block_signals(void);
>   extern void unblock_signals(void);
> @@ -307,6 +308,8 @@ extern int os_mod_epoll_fd(int events, int fd, void *data);
>   extern int os_del_epoll_fd(int fd);
>   extern void os_set_ioignore(void);
>   extern void os_close_epoll_fd(void);
> +extern void um_irqs_suspend(void);
> +extern void um_irqs_resume(void);
>   
>   /* sigio.c */
>   extern int add_sigio_fd(int fd);
> diff --git a/arch/um/kernel/irq.c b/arch/um/kernel/irq.c
> index 482269580b79..ea43312cbfd3 100644
> --- a/arch/um/kernel/irq.c
> +++ b/arch/um/kernel/irq.c
> @@ -20,6 +20,7 @@
>   #include <os.h>
>   #include <irq_user.h>
>   #include <irq_kern.h>
> +#include <as-layout.h>
>   
>   
>   extern void free_irqs(void);
> @@ -36,12 +37,14 @@ struct irq_reg {
>   	int events;
>   	bool active;
>   	bool pending;
> +	bool wakeup;
>   };
>   
>   struct irq_entry {
>   	struct list_head list;
>   	int fd;
>   	struct irq_reg reg[NUM_IRQ_TYPES];
> +	bool suspended;
>   };
>   
>   static DEFINE_SPINLOCK(irq_lock);
> @@ -70,6 +73,11 @@ static void irq_io_loop(struct irq_reg *irq, struct uml_pt_regs *regs)
>   	}
>   }
>   
> +void sigio_handler_suspend(int sig, struct siginfo *unused_si, struct uml_pt_regs *regs)
> +{
> +	/* nothing */
> +}
> +
>   void sigio_handler(int sig, struct siginfo *unused_si, struct uml_pt_regs *regs)
>   {
>   	struct irq_entry *irq_entry;
> @@ -365,9 +373,86 @@ int um_request_irq(int irq, int fd, enum um_irq_type type,
>   	clear_bit(irq, irqs_allocated);
>   	return err;
>   }
> -
>   EXPORT_SYMBOL(um_request_irq);
>   
> +#ifdef CONFIG_PM_SLEEP
> +void um_irqs_suspend(void)
> +{
> +	struct irq_entry *entry;
> +	unsigned long flags;
> +
> +	sig_info[SIGIO] = sigio_handler_suspend;
> +
> +	spin_lock_irqsave(&irq_lock, flags);
> +	list_for_each_entry(entry, &active_fds, list) {
> +		enum um_irq_type t;
> +		bool wake = false;
> +
> +		for (t = 0; t < NUM_IRQ_TYPES; t++) {
> +			if (!entry->reg[t].events)
> +				continue;
> +
> +			if (entry->reg[t].wakeup) {
> +				wake = true;
> +				break;
> +			}
> +		}
> +
> +		if (!wake) {
> +			entry->suspended = true;
> +			os_clear_fd_async(entry->fd);
> +		}
> +	}
> +	spin_unlock_irqrestore(&irq_lock, flags);
> +}
> +
> +void um_irqs_resume(void)
> +{
> +	struct irq_entry *entry;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&irq_lock, flags);
> +	list_for_each_entry(entry, &active_fds, list) {
> +		if (entry->suspended) {
> +			int err = os_set_fd_async(entry->fd);
> +
> +			WARN(err < 0, "os_set_fd_async returned %d\n", err);
> +			entry->suspended = false;
> +		}
> +	}
> +	spin_unlock_irqrestore(&irq_lock, flags);
> +
> +	sig_info[SIGIO] = sigio_handler;
> +	send_sigio_to_self();
> +}
> +
> +static int normal_irq_set_wake(struct irq_data *d, unsigned int on)
> +{
> +	struct irq_entry *entry;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&irq_lock, flags);
> +	list_for_each_entry(entry, &active_fds, list) {
> +		enum um_irq_type t;
> +
> +		for (t = 0; t < NUM_IRQ_TYPES; t++) {
> +			if (!entry->reg[t].events)
> +				continue;
> +
> +			if (entry->reg[t].irq != d->irq)
> +				continue;
> +			entry->reg[t].wakeup = on;
> +			goto unlock;
> +		}
> +	}
> +unlock:
> +	spin_unlock_irqrestore(&irq_lock, flags);
> +	return 0;
> +}
> +#else
> +#define normal_irq_set_wake NULL
> +#endif
> +
>   /*
>    * irq_chip must define at least enable/disable and ack when
>    * the edge handler is used.
> @@ -384,6 +469,7 @@ static struct irq_chip normal_irq_type = {
>   	.irq_ack = dummy,
>   	.irq_mask = dummy,
>   	.irq_unmask = dummy,
> +	.irq_set_wake = normal_irq_set_wake,
>   };
>   
>   static struct irq_chip alarm_irq_type = {
> diff --git a/arch/um/kernel/process.c b/arch/um/kernel/process.c
> index 0686fabba576..f0f50eae2293 100644
> --- a/arch/um/kernel/process.c
> +++ b/arch/um/kernel/process.c
> @@ -202,7 +202,7 @@ void initial_thread_cb(void (*proc)(void *), void *arg)
>   	kmalloc_ok = save_kmalloc_ok;
>   }
>   
> -static void um_idle_sleep(void)
> +void um_idle_sleep(void)
>   {
>   	if (time_travel_mode != TT_MODE_OFF)
>   		time_travel_sleep();
> diff --git a/arch/um/kernel/um_arch.c b/arch/um/kernel/um_arch.c
> index 237a8d73a096..9c7e6d7ea1b3 100644
> --- a/arch/um/kernel/um_arch.c
> +++ b/arch/um/kernel/um_arch.c
> @@ -385,6 +385,45 @@ void uml_pm_wake(void)
>   	pm_system_wakeup();
>   }
>   
> +static int um_suspend_valid(suspend_state_t state)
> +{
> +	return state == PM_SUSPEND_MEM;
> +}
> +
> +static int um_suspend_prepare(void)
> +{
> +	um_irqs_suspend();
> +	return 0;
> +}
> +
> +static int um_suspend_enter(suspend_state_t state)
> +{
> +	if (WARN_ON(state != PM_SUSPEND_MEM))
> +		return -EINVAL;
> +
> +	/*
> +	 * This is identical to the idle sleep, but we've just
> +	 * (during suspend) turned off all interrupt sources
> +	 * except for the ones we want, so now we can only wake
> +	 * up on something we actually want to wake up on. All
> +	 * timing has also been suspended.
> +	 */
> +	um_idle_sleep();
> +	return 0;
> +}
> +
> +static void um_suspend_finish(void)
> +{
> +	um_irqs_resume();
> +}
> +
> +const struct platform_suspend_ops um_suspend_ops = {
> +	.valid = um_suspend_valid,
> +	.prepare = um_suspend_prepare,
> +	.enter = um_suspend_enter,
> +	.finish = um_suspend_finish,
> +};
> +
>   static int init_pm_wake_signal(void)
>   {
>   	/*
> @@ -397,6 +436,9 @@ static int init_pm_wake_signal(void)
>   	 */
>   	if (time_travel_mode != TT_MODE_EXTERNAL)
>   		register_pm_wake_signal();
> +
> +	suspend_set_ops(&um_suspend_ops);
> +
>   	return 0;
>   }
>   
> diff --git a/arch/um/os-Linux/signal.c b/arch/um/os-Linux/signal.c
> index 0a2ea84033b4..510e956b4320 100644
> --- a/arch/um/os-Linux/signal.c
> +++ b/arch/um/os-Linux/signal.c
> @@ -234,6 +234,11 @@ void set_handler(int sig)
>   		panic("sigprocmask failed - errno = %d\n", errno);
>   }
>   
> +void send_sigio_to_self(void)
> +{
> +	kill(os_getpid(), SIGIO);
> +}
> +
>   int change_sig(int signal, int on)
>   {
>   	sigset_t sigset;
> 

Anton Ivanov <anton.ivanov@cambridgegreys.com>

-- 
Anton R. Ivanov
https://www.kot-begemot.co.uk/

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

