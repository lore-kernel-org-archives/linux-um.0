Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from ivanoab7.miniserver.com ([37.128.132.42]
 helo=www.kot-begemot.co.uk)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kk8lS-0002Ui-CZ
 for linux-um@lists.infradead.org; Tue, 01 Dec 2020 16:44:31 +0000
Subject: Re: [PATCH v6 4/5] um: support suspend to RAM
References: <20201130121550.173513-1-johannes@sipsolutions.net>
 <20201130131520.80e9b1810786.I3e8e33cbe3196d9325946af3a5655f7b6719382d@changeid>
From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Message-ID: <ba5e0b62-df77-b96a-651e-48e56d3e7102@cambridgegreys.com>
Date: Tue, 1 Dec 2020 16:44:23 +0000
MIME-Version: 1.0
In-Reply-To: <20201130131520.80e9b1810786.I3e8e33cbe3196d9325946af3a5655f7b6719382d@changeid>
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



On 30/11/2020 12:15, Johannes Berg wrote:
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
> in a select() call that only needs to return; thus also from
> this mode, any arbitrary other signal that we catch and that
> doesn't cause UML to abort (e.g. SIGIO) works.
> 
> In order to implement selective resume from certain devices,
> and not have any arbitrary device interrupt wake up, suspend
> interrupts by removing SIGIO notification (O_ASYNC) from all
> the FDs that are not supposed to wake up the system. Then,
> suspend SIGIO handling by installing a dummy noop handler.
> 
> Since we're in an infinite select, the mere act of receiving
> SIGIO wakes us up, and then after things have been restored
> enough, re-set O_ASYNC for all previously suspended FDs,
> reinstall the proper SIGIO handler, and send SIGIO to self
> to process anything that might now be pending.
> 
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> ---
>   arch/um/include/shared/kern_util.h |  1 +
>   arch/um/include/shared/os.h        |  4 ++
>   arch/um/kernel/irq.c               | 81 ++++++++++++++++++++++++++++++
>   arch/um/kernel/process.c           |  2 +-
>   arch/um/kernel/um_arch.c           | 42 ++++++++++++++++
>   arch/um/os-Linux/signal.c          | 23 ++++++++-
>   6 files changed, 150 insertions(+), 3 deletions(-)
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
> index 78250a05394a..df64a3b98c54 100644
> --- a/arch/um/include/shared/os.h
> +++ b/arch/um/include/shared/os.h
> @@ -233,6 +233,8 @@ extern void timer_set_signal_handler(void);
>   extern void set_sigstack(void *sig_stack, int size);
>   extern void remove_sigstack(void);
>   extern void set_handler(int sig);
> +extern void suspend_sigio(void);
> +extern void send_sigio_to_self(void);
>   extern int change_sig(int signal, int on);
>   extern void block_signals(void);
>   extern void unblock_signals(void);
> @@ -307,6 +309,8 @@ extern int os_mod_epoll_fd(int events, int fd, void *data);
>   extern int os_del_epoll_fd(int fd);
>   extern void os_set_ioignore(void);
>   extern void os_close_epoll_fd(void);
> +extern void um_irqs_suspend(void);
> +extern void um_irqs_resume(void);
>   
>   /* sigio.c */
>   extern int add_sigio_fd(int fd);
> diff --git a/arch/um/kernel/irq.c b/arch/um/kernel/irq.c
> index bbf5a466b44c..5c9798d0037f 100644
> --- a/arch/um/kernel/irq.c
> +++ b/arch/um/kernel/irq.c
> @@ -36,12 +36,14 @@ struct irq_reg {
>   	int events;
>   	bool active;
>   	bool pending;
> +	bool wakeup;

That is on top of the other patch series where there is an issue with patch 7.

Are we going to park this one until we have sorted IRQ Handling Cleanups?

1-3 look good.


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
> @@ -367,6 +369,84 @@ int um_request_irq(int irq, int fd, enum um_irq_type type,
>   
>   EXPORT_SYMBOL(um_request_irq);
>   
> +#ifdef CONFIG_PM_SLEEP
> +void um_irqs_suspend(void)
> +{
> +	struct irq_entry *entry;
> +	unsigned long flags;
> +
> +	suspend_sigio();
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
> +	set_handler(SIGIO);
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
> @@ -383,6 +463,7 @@ static struct irq_chip normal_irq_type = {
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
> index 0a2ea84033b4..85a7283b166c 100644
> --- a/arch/um/os-Linux/signal.c
> +++ b/arch/um/os-Linux/signal.c
> @@ -203,13 +203,17 @@ static void hard_handler(int sig, siginfo_t *si, void *p)
>   	} while (pending);
>   }
>   
> -void set_handler(int sig)
> +static void noop_handler(int sig, siginfo_t *si, void *p)
> +{
> +}
> +
> +static void _set_handler(int sig, bool suspend)
>   {
>   	struct sigaction action;
>   	int flags = SA_SIGINFO | SA_ONSTACK;
>   	sigset_t sig_mask;
>   
> -	action.sa_sigaction = hard_handler;
> +	action.sa_sigaction = suspend ? noop_handler : hard_handler;
>   
>   	/* block irq ones */
>   	sigemptyset(&action.sa_mask);
> @@ -234,6 +238,21 @@ void set_handler(int sig)
>   		panic("sigprocmask failed - errno = %d\n", errno);
>   }
>   
> +void set_handler(int sig)
> +{
> +	_set_handler(sig, false);
> +}
> +
> +void suspend_sigio(void)
> +{
> +	_set_handler(SIGIO, true);
> +}
> +
> +void send_sigio_to_self(void)
> +{
> +	kill(0, SIGIO);
> +}
> +
>   int change_sig(int signal, int on)
>   {
>   	sigset_t sigset;
> 

-- 
Anton R. Ivanov
Cambridgegreys Limited. Registered in England. Company Number 10273661
https://www.cambridgegreys.com/

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

