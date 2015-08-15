Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <anton.ivanov@kot-begemot.co.uk>) id 1ZQeiR-0006P1-Cr
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 15 Aug 2015 16:53:55 +0000
Received: from ivanoab4.miniserver.com ([78.31.104.92])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1ZQeiO-0003K4-C5
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 15 Aug 2015 16:53:55 +0000
Received: from tun252.maui-covenant.sigsegv.cx ([192.168.17.6]
	helo=falkor.sigsegv.cx) by ivanoab4.miniserver.com with esmtps
	(TLS1.2:RSA_AES_128_CBC_SHA1:128) (Exim 4.80)
	(envelope-from <anton.ivanov@kot-begemot.co.uk>) id 1ZQeJP-0003Hj-DZ
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 15 Aug 2015 16:28:03 +0000
Received: from [213.226.63.45] (helo=[192.168.65.215])
	by falkor.sigsegv.cx with esmtpsa
	(TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.84)
	(envelope-from <anton.ivanov@kot-begemot.co.uk>) id 1ZQeJK-0002PV-T7
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 15 Aug 2015 17:28:03 +0100
Message-ID: <55CF6886.2020100@kot-begemot.co.uk>
Date: Sat, 15 Aug 2015 17:27:50 +0100
From: Anton Ivanov <anton.ivanov@kot-begemot.co.uk>
MIME-Version: 1.0
References: <1439142802.559700.2.camel@m3y3r.de> <55CEF513.90604@nod.at>
In-Reply-To: <55CEF513.90604@nod.at>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
Subject: Re: [uml-devel] [PATCH] um: Switch clocksource to hrtimers
To: user-mode-linux-devel@lists.sourceforge.net

On 15/08/15 09:15, Richard Weinberger wrote:
> Am 09.08.2015 um 19:53 schrieb Thomas Meyer:
>> Switch the UML clocksource from interval timers to posix interval timers and
>> move to a monotonic timer.
>>
>> This fixes suspend&resume related timer issues and improves network performance
>> as TCP state machines are now fed with the correct time; also correct QoS and
>> traffic shaping.
> The patch is rather big. Please describe in your commit message how exactly
> it works and why.
> It changes many internals.

Tom, I will be happy to assist with the drafting, feel free to take the 
draft conversation off-list until we are ready.

A.

>
>> Signed-off-by: Thomas Meyer <thomas@m3y3r.de>
> Please honor also the original author of the patch.
>
>> ---
>>   arch/um/Makefile                        |   2 +-
>>   arch/um/include/shared/os.h             |  15 +-
>>   arch/um/include/shared/skas/stub-data.h |   5 +-
>>   arch/um/include/shared/timer-internal.h |  13 ++
>>   arch/um/kernel/process.c                |   6 +-
>>   arch/um/kernel/skas/clone.c             |   5 -
>>   arch/um/kernel/skas/mmu.c               |   2 +
>>   arch/um/kernel/time.c                   |  80 +++++++----
>>   arch/um/os-Linux/internal.h             |   1 -
>>   arch/um/os-Linux/main.c                 |   6 +-
>>   arch/um/os-Linux/process.c              |   5 +
>>   arch/um/os-Linux/signal.c               |  35 +++--
>>   arch/um/os-Linux/skas/process.c         |  44 ++----
>>   arch/um/os-Linux/time.c                 | 248 ++++++++++++++++----------------
>>   14 files changed, 234 insertions(+), 233 deletions(-)
>>   create mode 100644 arch/um/include/shared/timer-internal.h
>>   delete mode 100644 arch/um/os-Linux/internal.h
>>
>> diff --git a/arch/um/Makefile b/arch/um/Makefile
>> index 098ab33..eb79b4b 100644
>> --- a/arch/um/Makefile
>> +++ b/arch/um/Makefile
>> @@ -131,7 +131,7 @@ export LDS_ELF_FORMAT := $(ELF_FORMAT)
>>   # The wrappers will select whether using "malloc" or the kernel allocator.
>>   LINK_WRAPS = -Wl,--wrap,malloc -Wl,--wrap,free -Wl,--wrap,calloc
>>   
>> -LD_FLAGS_CMDLINE = $(foreach opt,$(LDFLAGS),-Wl,$(opt))
>> +LD_FLAGS_CMDLINE = $(foreach opt,$(LDFLAGS),-Wl,$(opt)) -lrt
>>   
>>   # Used by link-vmlinux.sh which has special support for um link
>>   export CFLAGS_vmlinux := $(LINK-y) $(LINK_WRAPS) $(LD_FLAGS_CMDLINE)
>> diff --git a/arch/um/include/shared/os.h b/arch/um/include/shared/os.h
>> index ad3fa3a..7519c98 100644
>> --- a/arch/um/include/shared/os.h
>> +++ b/arch/um/include/shared/os.h
>> @@ -183,6 +183,7 @@ extern int create_mem_file(unsigned long long len);
>>   /* process.c */
>>   extern unsigned long os_process_pc(int pid);
>>   extern int os_process_parent(int pid);
>> +extern void os_alarm_process(int pid);
>>   extern void os_stop_process(int pid);
>>   extern void os_kill_process(int pid, int reap_child);
>>   extern void os_kill_ptraced_process(int pid, int reap_child);
>> @@ -217,7 +218,7 @@ extern int set_umid(char *name);
>>   extern char *get_umid(void);
>>   
>>   /* signal.c */
>> -extern void timer_init(void);
>> +extern void timer_set_signal_handler(void);
>>   extern void set_sigstack(void *sig_stack, int size);
>>   extern void remove_sigstack(void);
>>   extern void set_handler(int sig);
>> @@ -238,12 +239,16 @@ extern void um_early_printk(const char *s, unsigned int n);
>>   extern void os_fix_helper_signals(void);
>>   
>>   /* time.c */
>> -extern void idle_sleep(unsigned long long nsecs);
>> -extern int set_interval(void);
>> -extern int timer_one_shot(int ticks);
>> -extern long long disable_timer(void);
>> +extern void os_idle_sleep(unsigned long long nsecs);
>> +extern int os_timer_create(void* timer);
>> +extern int os_timer_set_interval(void* timer, void* its);
>> +extern int os_timer_one_shot(int ticks);
>> +extern long long os_timer_disable(void);
>> +extern long os_timer_remain(void* timer);
>>   extern void uml_idle_timer(void);
>> +extern long long os_persistent_clock_emulation(void);
>>   extern long long os_nsecs(void);
>> +extern long long os_vnsecs(void);
>>   
>>   /* skas/mem.c */
>>   extern long run_syscall_stub(struct mm_id * mm_idp,
>> diff --git a/arch/um/include/shared/skas/stub-data.h b/arch/um/include/shared/skas/stub-data.h
>> index f6ed92c..e09d8fd 100644
>> --- a/arch/um/include/shared/skas/stub-data.h
>> +++ b/arch/um/include/shared/skas/stub-data.h
>> @@ -6,12 +6,11 @@
>>   #ifndef __STUB_DATA_H
>>   #define __STUB_DATA_H
>>   
>> -#include <sys/time.h>
>> +#include <time.h>
>>   
>>   struct stub_data {
>> -	long offset;
>> +	unsigned long offset;
>>   	int fd;
>> -	struct itimerval timer;
>>   	long err;
>>   };
>>   
>> diff --git a/arch/um/include/shared/timer-internal.h b/arch/um/include/shared/timer-internal.h
>> new file mode 100644
>> index 0000000..03e6f21
>> --- /dev/null
>> +++ b/arch/um/include/shared/timer-internal.h
>> @@ -0,0 +1,13 @@
>> +/*
>> + * Copyright (C) 2012 - 2014 Cisco Systems
>> + * Copyright (C) 2000 - 2007 Jeff Dike (jdike@{addtoit,linux.intel}.com)
>> + * Licensed under the GPL
>> + */
>> +
>> +#ifndef __TIMER_INTERNAL_H__
>> +#define __TIMER_INTERNAL_H__
>> +
>> +#define TIMER_MULTIPLIER 256
>> +#define TIMER_MIN_DELTA  500
>> +
>> +#endif
>> diff --git a/arch/um/kernel/process.c b/arch/um/kernel/process.c
>> index 68b9119..2ce38c1 100644
>> --- a/arch/um/kernel/process.c
>> +++ b/arch/um/kernel/process.c
>> @@ -27,6 +27,7 @@
>>   #include <kern_util.h>
>>   #include <os.h>
>>   #include <skas.h>
>> +#include <timer-internal.h>
>>   
>>   /*
>>    * This is a per-cpu array.  A processor only modifies its entry and it only
>> @@ -201,11 +202,8 @@ void initial_thread_cb(void (*proc)(void *), void *arg)
>>   
>>   void arch_cpu_idle(void)
>>   {
>> -	unsigned long long nsecs;
>> -
>>   	cpu_tasks[current_thread_info()->cpu].pid = os_getpid();
>> -	nsecs = disable_timer();
>> -	idle_sleep(nsecs);
>> +	os_idle_sleep(UM_NSEC_PER_SEC);
>>   	local_irq_enable();
>>   }
>>   
>> diff --git a/arch/um/kernel/skas/clone.c b/arch/um/kernel/skas/clone.c
>> index 289771d..498148b 100644
>> --- a/arch/um/kernel/skas/clone.c
>> +++ b/arch/um/kernel/skas/clone.c
>> @@ -35,11 +35,6 @@ stub_clone_handler(void)
>>   	if (err)
>>   		goto out;
>>   
>> -	err = stub_syscall3(__NR_setitimer, ITIMER_VIRTUAL,
>> -			    (long) &data->timer, 0);
>> -	if (err)
>> -		goto out;
>> -
> By removing this call from our clone stub, you change the way how SKAS0
> works. Please explain why this is needed.
>
>>   	remap_stack(data->fd, data->offset);
>>   	goto done;
>>   
>> diff --git a/arch/um/kernel/skas/mmu.c b/arch/um/kernel/skas/mmu.c
>> index fda1deb..42e2988 100644
>> --- a/arch/um/kernel/skas/mmu.c
>> +++ b/arch/um/kernel/skas/mmu.c
>> @@ -61,10 +61,12 @@ int init_new_context(struct task_struct *task, struct mm_struct *mm)
>>   	if (current->mm != NULL && current->mm != &init_mm)
>>   		from_mm = &current->mm->context;
>>   
>> +	block_signals();
>>   	if (from_mm)
>>   		to_mm->id.u.pid = copy_context_skas0(stack,
>>   						     from_mm->id.u.pid);
>>   	else to_mm->id.u.pid = start_userspace(stack);
>> +	unblock_signals();
> Why do we have to block signals here?
>
>>   	if (to_mm->id.u.pid < 0) {
>>   		ret = to_mm->id.u.pid;
>> diff --git a/arch/um/kernel/time.c b/arch/um/kernel/time.c
>> index 117568d..29f1125 100644
>> --- a/arch/um/kernel/time.c
>> +++ b/arch/um/kernel/time.c
>> @@ -1,4 +1,5 @@
>>   /*
>> + * Copyright (C) 2012-2014 Cisco Systems
>>    * Copyright (C) 2000 - 2007 Jeff Dike (jdike@{addtoit,linux.intel}.com)
>>    * Licensed under the GPL
>>    */
>> @@ -7,11 +8,15 @@
>>   #include <linux/init.h>
>>   #include <linux/interrupt.h>
>>   #include <linux/jiffies.h>
>> +#include <linux/mm.h>
>> +#include <linux/sched.h>
>> +#include <linux/spinlock.h>
>>   #include <linux/threads.h>
>>   #include <asm/irq.h>
>>   #include <asm/param.h>
>>   #include <kern_util.h>
>>   #include <os.h>
>> +#include <timer-internal.h>
>>   
>>   void timer_handler(int sig, struct siginfo *unused_si, struct uml_pt_regs *regs)
>>   {
>> @@ -22,18 +27,20 @@ void timer_handler(int sig, struct siginfo *unused_si, struct uml_pt_regs *regs)
>>   	local_irq_restore(flags);
>>   }
>>   
>> -static void itimer_set_mode(enum clock_event_mode mode,
>> +static void timer_set_mode(enum clock_event_mode mode,
>>   			    struct clock_event_device *evt)
>>   {
>>   	switch (mode) {
>>   	case CLOCK_EVT_MODE_PERIODIC:
>> -		set_interval();
>> +		os_timer_set_interval(NULL, NULL);
>>   		break;
>>   
>> +	case CLOCK_EVT_MODE_ONESHOT:
>> +		os_timer_one_shot(1);
>> +
>>   	case CLOCK_EVT_MODE_SHUTDOWN:
>>   	case CLOCK_EVT_MODE_UNUSED:
>> -	case CLOCK_EVT_MODE_ONESHOT:
>> -		disable_timer();
>> +		os_timer_disable();
>>   		break;
>>   
>>   	case CLOCK_EVT_MODE_RESUME:
>> @@ -41,68 +48,79 @@ static void itimer_set_mode(enum clock_event_mode mode,
>>   	}
>>   }
>>   
>> -static int itimer_next_event(unsigned long delta,
>> +static int timer_next_event(unsigned long delta,
>>   			     struct clock_event_device *evt)
>>   {
>> -	return timer_one_shot(delta + 1);
>> +	return os_timer_one_shot(delta);
> Why did you replace "delta + 1" by "delta"?
>
>
>>   }
>>   
>> -static struct clock_event_device itimer_clockevent = {
>> -	.name		= "itimer",
>> +static struct clock_event_device timer_clockevent = {
>> +	.name		= "posix-timer",
>>   	.rating		= 250,
>>   	.cpumask	= cpu_all_mask,
>>   	.features	= CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT,
>> -	.set_mode	= itimer_set_mode,
>> -	.set_next_event = itimer_next_event,
>> -	.shift		= 32,
>> +	.set_mode	= timer_set_mode,
>> +	.set_next_event = timer_next_event,
>> +	.shift		= 0,
>> +	.max_delta_ns	= 0xffffffff,
>> +	.min_delta_ns	= TIMER_MIN_DELTA, //microsecond resolution should be enough for anyone, same as 640K RAM
>>   	.irq		= 0,
>> +	.mult		= 1,
>>   };
>>   
>> -static irqreturn_t um_timer(int irq, void *dev)
>> +static irqreturn_t um_timer_irq(int irq, void *dev)
>>   {
>> -	(*itimer_clockevent.event_handler)(&itimer_clockevent);
>> +	if (get_current()->mm != NULL)
>> +	{
>> +		os_alarm_process(get_current()->mm->context.id.u.pid);
>> +	}
>> +
>> +	(*timer_clockevent.event_handler)(&timer_clockevent);
>>   
>>   	return IRQ_HANDLED;
>>   }
>>   
>> -static cycle_t itimer_read(struct clocksource *cs)
>> +static cycle_t timer_read(struct clocksource *cs)
>>   {
>> -	return os_nsecs() / 1000;
>> +	return os_nsecs() / TIMER_MULTIPLIER;
>>   }
>>   
>> -static struct clocksource itimer_clocksource = {
>> -	.name		= "itimer",
>> +static struct clocksource timer_clocksource = {
>> +	.name		= "timer",
>>   	.rating		= 300,
>> -	.read		= itimer_read,
>> +	.read		= timer_read,
>>   	.mask		= CLOCKSOURCE_MASK(64),
>>   	.flags		= CLOCK_SOURCE_IS_CONTINUOUS,
>>   };
>>   
>> -static void __init setup_itimer(void)
>> +static void __init timer_setup(void)
>>   {
>>   	int err;
>>   
>> -	err = request_irq(TIMER_IRQ, um_timer, 0, "timer", NULL);
>> -	if (err != 0)
>> +	err = request_irq(TIMER_IRQ, um_timer_irq, IRQF_TIMER, "hr timer", NULL);
>> +	if (err != 0) {
>>   		printk(KERN_ERR "register_timer : request_irq failed - "
>>   		       "errno = %d\n", -err);
>> +		return;
>> +    }
>> +
>> +    err = os_timer_create(NULL);
>> +    if (err != 0) {
>> +        printk(KERN_ERR "creation of timer failed - errno = %d\n", -err);
>> +        return;
>> +    }
>>   
>> -	itimer_clockevent.mult = div_sc(HZ, NSEC_PER_SEC, 32);
>> -	itimer_clockevent.max_delta_ns =
>> -		clockevent_delta2ns(60 * HZ, &itimer_clockevent);
>> -	itimer_clockevent.min_delta_ns =
>> -		clockevent_delta2ns(1, &itimer_clockevent);
>> -	err = clocksource_register_hz(&itimer_clocksource, USEC_PER_SEC);
>> +	err = clocksource_register_hz(&timer_clocksource, NSEC_PER_SEC/TIMER_MULTIPLIER);
>>   	if (err) {
>>   		printk(KERN_ERR "clocksource_register_hz returned %d\n", err);
>>   		return;
>>   	}
>> -	clockevents_register_device(&itimer_clockevent);
>> +	clockevents_register_device(&timer_clockevent);
>>   }
>>   
>>   void read_persistent_clock(struct timespec *ts)
>>   {
>> -	long long nsecs = os_nsecs();
>> +	long long nsecs = os_persistent_clock_emulation();
>>   
>>   	set_normalized_timespec(ts, nsecs / NSEC_PER_SEC,
>>   				nsecs % NSEC_PER_SEC);
>> @@ -110,6 +128,6 @@ void read_persistent_clock(struct timespec *ts)
>>   
>>   void __init time_init(void)
>>   {
>> -	timer_init();
>> -	late_time_init = setup_itimer;
>> +	timer_set_signal_handler();
>> +	late_time_init = timer_setup;
>>   }
>> diff --git a/arch/um/os-Linux/internal.h b/arch/um/os-Linux/internal.h
>> deleted file mode 100644
>> index 0dc2c9f..0000000
>> --- a/arch/um/os-Linux/internal.h
>> +++ /dev/null
>> @@ -1 +0,0 @@
>> -void alarm_handler(int sig, struct siginfo *unused_si, mcontext_t *mc);
>> diff --git a/arch/um/os-Linux/main.c b/arch/um/os-Linux/main.c
>> index df9191a..6e36f0f 100644
>> --- a/arch/um/os-Linux/main.c
>> +++ b/arch/um/os-Linux/main.c
>> @@ -163,13 +163,13 @@ int __init main(int argc, char **argv, char **envp)
>>   
>>   	/*
>>   	 * This signal stuff used to be in the reboot case.  However,
>> -	 * sometimes a SIGVTALRM can come in when we're halting (reproducably
>> +	 * sometimes a timer signal can come in when we're halting (reproducably
>>   	 * when writing out gcov information, presumably because that takes
>>   	 * some time) and cause a segfault.
>>   	 */
>>   
>> -	/* stop timers and set SIGVTALRM to be ignored */
>> -	disable_timer();
>> +	/* stop timers and set timer signal to be ignored */
>> +	os_timer_disable();
>>   
>>   	/* disable SIGIO for the fds and set SIGIO to be ignored */
>>   	err = deactivate_all_fds();
>> diff --git a/arch/um/os-Linux/process.c b/arch/um/os-Linux/process.c
>> index 8408aba..f3bd983 100644
>> --- a/arch/um/os-Linux/process.c
>> +++ b/arch/um/os-Linux/process.c
>> @@ -89,6 +89,11 @@ int os_process_parent(int pid)
>>   	return parent;
>>   }
>>   
>> +void os_alarm_process(int pid)
>> +{
>> +	kill(pid, SIGALRM);
>> +}
>> +
>>   void os_stop_process(int pid)
>>   {
>>   	kill(pid, SIGSTOP);
>> diff --git a/arch/um/os-Linux/signal.c b/arch/um/os-Linux/signal.c
>> index 036d0db..e04a4cd 100644
>> --- a/arch/um/os-Linux/signal.c
>> +++ b/arch/um/os-Linux/signal.c
>> @@ -13,7 +13,6 @@
>>   #include <kern_util.h>
>>   #include <os.h>
>>   #include <sysdep/mcontext.h>
>> -#include "internal.h"
>>   
>>   void (*sig_info[NSIG])(int, struct siginfo *, struct uml_pt_regs *) = {
>>   	[SIGTRAP]	= relay_signal,
>> @@ -23,7 +22,8 @@ void (*sig_info[NSIG])(int, struct siginfo *, struct uml_pt_regs *) = {
>>   	[SIGBUS]	= bus_handler,
>>   	[SIGSEGV]	= segv_handler,
>>   	[SIGIO]		= sigio_handler,
>> -	[SIGVTALRM]	= timer_handler };
>> +	[SIGALRM]	= timer_handler
>> +};
>>   
>>   static void sig_handler_common(int sig, struct siginfo *si, mcontext_t *mc)
>>   {
>> @@ -38,7 +38,7 @@ static void sig_handler_common(int sig, struct siginfo *si, mcontext_t *mc)
>>   	}
>>   
>>   	/* enable signals if sig isn't IRQ signal */
>> -	if ((sig != SIGIO) && (sig != SIGWINCH) && (sig != SIGVTALRM))
>> +	if ((sig != SIGIO) && (sig != SIGWINCH) && (sig != SIGALRM))
>>   		unblock_signals();
>>   
>>   	(*sig_info[sig])(sig, si, &r);
>> @@ -55,8 +55,8 @@ static void sig_handler_common(int sig, struct siginfo *si, mcontext_t *mc)
>>   #define SIGIO_BIT 0
>>   #define SIGIO_MASK (1 << SIGIO_BIT)
>>   
>> -#define SIGVTALRM_BIT 1
>> -#define SIGVTALRM_MASK (1 << SIGVTALRM_BIT)
>> +#define SIGALRM_BIT 1
>> +#define SIGALRM_MASK (1 << SIGALRM_BIT)
>>   
>>   static int signals_enabled;
>>   static unsigned int signals_pending;
>> @@ -78,36 +78,34 @@ void sig_handler(int sig, struct siginfo *si, mcontext_t *mc)
>>   	set_signals(enabled);
>>   }
>>   
>> -static void real_alarm_handler(mcontext_t *mc)
>> +static void timer_real_alarm_handler(mcontext_t *mc)
>>   {
>>   	struct uml_pt_regs regs;
>>   
>>   	if (mc != NULL)
>>   		get_regs_from_mc(&regs, mc);
>> -	regs.is_user = 0;
>> -	unblock_signals();
>> -	timer_handler(SIGVTALRM, NULL, &regs);
>> +	timer_handler(SIGALRM, NULL, &regs);
>>   }
>>   
>> -void alarm_handler(int sig, struct siginfo *unused_si, mcontext_t *mc)
>> +void timer_alarm_handler(int sig, struct siginfo *unused_si, mcontext_t *mc)
>>   {
>>   	int enabled;
>>   
>>   	enabled = signals_enabled;
>>   	if (!signals_enabled) {
>> -		signals_pending |= SIGVTALRM_MASK;
>> +		signals_pending |= SIGALRM_MASK;
>>   		return;
>>   	}
>>   
>>   	block_signals();
>>   
>> -	real_alarm_handler(mc);
>> +	timer_real_alarm_handler(mc);
>>   	set_signals(enabled);
>>   }
>>   
>> -void timer_init(void)
>> +void timer_set_signal_handler(void)
>>   {
>> -	set_handler(SIGVTALRM);
>> +	set_handler(SIGALRM);
>>   }
>>   
>>   void set_sigstack(void *sig_stack, int size)
>> @@ -131,10 +129,9 @@ static void (*handlers[_NSIG])(int sig, struct siginfo *si, mcontext_t *mc) = {
>>   
>>   	[SIGIO] = sig_handler,
>>   	[SIGWINCH] = sig_handler,
>> -	[SIGVTALRM] = alarm_handler
>> +	[SIGALRM] = timer_alarm_handler
>>   };
>>   
>> -
>>   static void hard_handler(int sig, siginfo_t *si, void *p)
>>   {
>>   	struct ucontext *uc = p;
>> @@ -188,9 +185,9 @@ void set_handler(int sig)
>>   
>>   	/* block irq ones */
>>   	sigemptyset(&action.sa_mask);
>> -	sigaddset(&action.sa_mask, SIGVTALRM);
>>   	sigaddset(&action.sa_mask, SIGIO);
>>   	sigaddset(&action.sa_mask, SIGWINCH);
>> +	sigaddset(&action.sa_mask, SIGALRM);
>>   
>>   	if (sig == SIGSEGV)
>>   		flags |= SA_NODEFER;
>> @@ -283,8 +280,8 @@ void unblock_signals(void)
>>   		if (save_pending & SIGIO_MASK)
>>   			sig_handler_common(SIGIO, NULL, NULL);
>>   
>> -		if (save_pending & SIGVTALRM_MASK)
>> -			real_alarm_handler(NULL);
>> +		if (save_pending & SIGALRM_MASK)
>> +			timer_real_alarm_handler(NULL);
>>   	}
>>   }
>>   
>> diff --git a/arch/um/os-Linux/skas/process.c b/arch/um/os-Linux/skas/process.c
>> index 3dddedb..5ae4752 100644
>> --- a/arch/um/os-Linux/skas/process.c
>> +++ b/arch/um/os-Linux/skas/process.c
>> @@ -45,7 +45,7 @@ static int ptrace_dump_regs(int pid)
>>    * Signals that are OK to receive in the stub - we'll just continue it.
>>    * SIGWINCH will happen when UML is inside a detached screen.
>>    */
>> -#define STUB_SIG_MASK ((1 << SIGVTALRM) | (1 << SIGWINCH))
>> +#define STUB_SIG_MASK ((1 << SIGALRM) | (1 << SIGWINCH))
>>   
>>   /* Signals that the stub will finish with - anything else is an error */
>>   #define STUB_DONE_MASK (1 << SIGTRAP)
>> @@ -179,19 +179,13 @@ extern char __syscall_stub_start[];
>>   static int userspace_tramp(void *stack)
>>   {
>>   	void *addr;
>> -	int err, fd;
>> +	int fd;
>>   	unsigned long long offset;
>>   
>>   	ptrace(PTRACE_TRACEME, 0, 0, 0);
>>   
>>   	signal(SIGTERM, SIG_DFL);
>>   	signal(SIGWINCH, SIG_IGN);
>> -	err = set_interval();
>> -	if (err) {
>> -		printk(UM_KERN_ERR "userspace_tramp - setting timer failed, "
>> -		       "errno = %d\n", err);
>> -		exit(1);
>> -	}
>>   
>>   	/*
>>   	 * This has a pte, but it can't be mapped in with the usual
>> @@ -282,7 +276,7 @@ int start_userspace(unsigned long stub_stack)
>>   			       "errno = %d\n", errno);
>>   			goto out_kill;
>>   		}
>> -	} while (WIFSTOPPED(status) && (WSTOPSIG(status) == SIGVTALRM));
>> +	} while (WIFSTOPPED(status) && (WSTOPSIG(status) == SIGALRM));
>>   
>>   	if (!WIFSTOPPED(status) || (WSTOPSIG(status) != SIGSTOP)) {
>>   		err = -EINVAL;
>> @@ -315,8 +309,6 @@ int start_userspace(unsigned long stub_stack)
>>   
>>   void userspace(struct uml_pt_regs *regs)
>>   {
>> -	struct itimerval timer;
>> -	unsigned long long nsecs, now;
>>   	int err, status, op, pid = userspace_pid[0];
>>   	/* To prevent races if using_sysemu changes under us.*/
>>   	int local_using_sysemu;
>> @@ -325,13 +317,8 @@ void userspace(struct uml_pt_regs *regs)
>>   	/* Handle any immediate reschedules or signals */
>>   	interrupt_end();
>>   
>> -	if (getitimer(ITIMER_VIRTUAL, &timer))
>> -		printk(UM_KERN_ERR "Failed to get itimer, errno = %d\n", errno);
>> -	nsecs = timer.it_value.tv_sec * UM_NSEC_PER_SEC +
>> -		timer.it_value.tv_usec * UM_NSEC_PER_USEC;
>> -	nsecs += os_nsecs();
>> -
>>   	while (1) {
>> +
>>   		/*
>>   		 * This can legitimately fail if the process loads a
>>   		 * bogus value into a segment register.  It will
>> @@ -401,18 +388,7 @@ void userspace(struct uml_pt_regs *regs)
>>   			case SIGTRAP:
>>   				relay_signal(SIGTRAP, (struct siginfo *)&si, regs);
>>   				break;
>> -			case SIGVTALRM:
>> -				now = os_nsecs();
>> -				if (now < nsecs)
>> -					break;
>> -				block_signals();
>> -				(*sig_info[sig])(sig, (struct siginfo *)&si, regs);
>> -				unblock_signals();
>> -				nsecs = timer.it_value.tv_sec *
>> -					UM_NSEC_PER_SEC +
>> -					timer.it_value.tv_usec *
>> -					UM_NSEC_PER_USEC;
>> -				nsecs += os_nsecs();
>> +			case SIGALRM:
>>   				break;
>>   			case SIGIO:
>>   			case SIGILL:
>> @@ -460,7 +436,6 @@ __initcall(init_thread_regs);
>>   
>>   int copy_context_skas0(unsigned long new_stack, int pid)
>>   {
>> -	struct timeval tv = { .tv_sec = 0, .tv_usec = UM_USEC_PER_SEC / UM_HZ };
>>   	int err;
>>   	unsigned long current_stack = current_stub_stack();
>>   	struct stub_data *data = (struct stub_data *) current_stack;
>> @@ -472,11 +447,10 @@ int copy_context_skas0(unsigned long new_stack, int pid)
>>   	 * prepare offset and fd of child's stack as argument for parent's
>>   	 * and child's mmap2 calls
>>   	 */
>> -	*data = ((struct stub_data) { .offset	= MMAP_OFFSET(new_offset),
>> -				      .fd	= new_fd,
>> -				      .timer    = ((struct itimerval)
>> -					           { .it_value = tv,
>> -						     .it_interval = tv }) });
>> +	*data = ((struct stub_data) {
>> +			.offset	= MMAP_OFFSET(new_offset),
>> +			.fd     = new_fd
>> +	});
> As written above, you change the way how SKAS0 works, this needs
> much more explaination.
>
>>   	err = ptrace_setregs(pid, thread_regs);
>>   	if (err < 0) {
>> diff --git a/arch/um/os-Linux/time.c b/arch/um/os-Linux/time.c
>> index e9824d5..0e2bb7d 100644
>> --- a/arch/um/os-Linux/time.c
>> +++ b/arch/um/os-Linux/time.c
>> @@ -1,4 +1,5 @@
>>   /*
>> + * Copyright (C) 2012-2014 Cisco Systems
>>    * Copyright (C) 2000 - 2007 Jeff Dike (jdike{addtoit,linux.intel}.com)
>>    * Licensed under the GPL
>>    */
>> @@ -10,177 +11,172 @@
>>   #include <sys/time.h>
>>   #include <kern_util.h>
>>   #include <os.h>
>> -#include "internal.h"
>> +#include <string.h>
>> +#include <timer-internal.h>
>>   
>> -int set_interval(void)
>> -{
>> -	int usec = UM_USEC_PER_SEC / UM_HZ;
>> -	struct itimerval interval = ((struct itimerval) { { 0, usec },
>> -							  { 0, usec } });
>> -
>> -	if (setitimer(ITIMER_VIRTUAL, &interval, NULL) == -1)
>> -		return -errno;
>> +static timer_t event_high_res_timer = 0;
>>   
>> -	return 0;
>> +static inline long long timeval_to_ns(const struct timeval *tv)
>> +{
>> +	return ((long long) tv->tv_sec * UM_NSEC_PER_SEC) +
>> +		tv->tv_usec * UM_NSEC_PER_USEC;
>>   }
>>   
>> -int timer_one_shot(int ticks)
>> +static inline long long timespec_to_ns(const struct timespec *ts)
>>   {
>> -	unsigned long usec = ticks * UM_USEC_PER_SEC / UM_HZ;
>> -	unsigned long sec = usec / UM_USEC_PER_SEC;
>> -	struct itimerval interval;
>> -
>> -	usec %= UM_USEC_PER_SEC;
>> -	interval = ((struct itimerval) { { 0, 0 }, { sec, usec } });
>> +	return ((long long) ts->tv_sec * UM_NSEC_PER_SEC) +
>> +		ts->tv_nsec;
>> +}
>>   
>> -	if (setitimer(ITIMER_VIRTUAL, &interval, NULL) == -1)
>> -		return -errno;
>> +long long os_persistent_clock_emulation (void) {
>> +	struct timespec realtime_tp;
>>   
>> -	return 0;
>> +	clock_gettime(CLOCK_REALTIME, &realtime_tp);
>> +	return timespec_to_ns(&realtime_tp);
>>   }
>>   
>>   /**
>> - * timeval_to_ns - Convert timeval to nanoseconds
>> - * @ts:		pointer to the timeval variable to be converted
>> - *
>> - * Returns the scalar nanosecond representation of the timeval
>> - * parameter.
>> - *
>> - * Ripped from linux/time.h because it's a kernel header, and thus
>> - * unusable from here.
>> + * os_timer_create() - create an new posix (interval) timer
>>    */
>> -static inline long long timeval_to_ns(const struct timeval *tv)
>> -{
>> -	return ((long long) tv->tv_sec * UM_NSEC_PER_SEC) +
>> -		tv->tv_usec * UM_NSEC_PER_USEC;
>> +int os_timer_create(void* timer) {
>> +
>> +	timer_t* t = timer;
>> +
>> +	if(t == NULL) {
>> +		t = &event_high_res_timer;
>> +	}
>> +
>> +	if (timer_create(
>> +		CLOCK_MONOTONIC,
>> +		NULL,
>> +		t) == -1) {
>> +		return -1;
>> +	}
>> +	return 0;
>>   }
>>   
>> -long long disable_timer(void)
>> +int os_timer_set_interval(void* timer, void* i)
>>   {
>> -	struct itimerval time = ((struct itimerval) { { 0, 0 }, { 0, 0 } });
>> -	long long remain, max = UM_NSEC_PER_SEC / UM_HZ;
>> +	struct itimerspec its;
>> +	unsigned long long nsec;
>> +	timer_t* t = timer;
>> +	struct itimerspec* its_in = i;
>>   
>> -	if (setitimer(ITIMER_VIRTUAL, &time, &time) < 0)
>> -		printk(UM_KERN_ERR "disable_timer - setitimer failed, "
>> -		       "errno = %d\n", errno);
>> +	if(t == NULL) {
>> +		t = &event_high_res_timer;
>> +	}
>>   
>> -	remain = timeval_to_ns(&time.it_value);
>> -	if (remain > max)
>> -		remain = max;
>> +	nsec = UM_NSEC_PER_SEC / UM_HZ;
>>   
>> -	return remain;
>> -}
>> +	if(its_in != NULL) {
>> +		its.it_value.tv_sec = its_in->it_value.tv_sec;
>> +		its.it_value.tv_nsec = its_in->it_value.tv_nsec;
>> +	} else {
>> +		its.it_value.tv_sec = 0;
>> +		its.it_value.tv_nsec = nsec;
>> +	}
>>   
>> -long long os_nsecs(void)
>> -{
>> -	struct timeval tv;
>> +	its.it_interval.tv_sec = 0;
>> +	its.it_interval.tv_nsec = nsec;
>>   
>> -	gettimeofday(&tv, NULL);
>> -	return timeval_to_ns(&tv);
>> -}
>> +	if(timer_settime(*t, 0, &its, NULL) == -1) {
>> +		return -errno;
>> +	}
>>   
>> -#ifdef UML_CONFIG_NO_HZ_COMMON
>> -static int after_sleep_interval(struct timespec *ts)
>> -{
>>   	return 0;
>>   }
>>   
>> -static void deliver_alarm(void)
>> +/**
>> + * os_timer_remain() - returns the remaining nano seconds of the given interval
>> + *                     timer
>> + * Because this is the remaining time of an interval timer, which correspondends
>> + * to HZ, this value can never be bigger than one second. Just
>> + * the nanosecond part of the timer is returned.
>> + * The returned time is relative to the start time of the interval timer.
>> + * Return an negative value in an error case.
>> + */
>> +long os_timer_remain(void* timer)
>>   {
>> -	alarm_handler(SIGVTALRM, NULL, NULL);
>> -}
>> +	struct itimerspec its;
>> +	timer_t* t = timer;
>>   
>> -static unsigned long long sleep_time(unsigned long long nsecs)
>> -{
>> -	return nsecs;
>> -}
>> +	if(t == NULL) {
>> +		t = &event_high_res_timer;
>> +	}
>>   
>> -#else
>> -unsigned long long last_tick;
>> -unsigned long long skew;
>> +	if(timer_gettime(t, &its) == -1) {
>> +		return -errno;
>> +	}
>> +
>> +	return its.it_value.tv_nsec;
>> +}
>>   
>> -static void deliver_alarm(void)
>> +int os_timer_one_shot(int ticks)
>>   {
>> -	unsigned long long this_tick = os_nsecs();
>> -	int one_tick = UM_NSEC_PER_SEC / UM_HZ;
>> +	struct itimerspec its;
>> +	unsigned long long nsec;
>> +	unsigned long sec;
>>   
>> -	/* Protection against the host's time going backwards */
>> -	if ((last_tick != 0) && (this_tick < last_tick))
>> -		this_tick = last_tick;
>> +    nsec = (ticks + 1);
>> +    sec = nsec / UM_NSEC_PER_SEC;
>> +	nsec = nsec % UM_NSEC_PER_SEC;
>>   
>> -	if (last_tick == 0)
>> -		last_tick = this_tick - one_tick;
>> +	its.it_value.tv_sec = nsec / UM_NSEC_PER_SEC;
>> +	its.it_value.tv_nsec = nsec;
>>   
>> -	skew += this_tick - last_tick;
>> +	its.it_interval.tv_sec = 0;
>> +	its.it_interval.tv_nsec = 0; // we cheat here
>>   
>> -	while (skew >= one_tick) {
>> -		alarm_handler(SIGVTALRM, NULL, NULL);
>> -		skew -= one_tick;
>> -	}
>> -
>> -	last_tick = this_tick;
>> +	timer_settime(event_high_res_timer, 0, &its, NULL);
>> +	return 0;
>>   }
>>   
>> -static unsigned long long sleep_time(unsigned long long nsecs)
>> +/**
>> + * os_timer_disable() - disable the posix (interval) timer
>> + * Returns the remaining interval timer time in nanoseconds
>> + */
>> +long long os_timer_disable(void)
>>   {
>> -	return nsecs > skew ? nsecs - skew : 0;
>> +	struct itimerspec its;
>> +
>> +	memset(&its, 0, sizeof(struct itimerspec));
>> +	timer_settime(event_high_res_timer, 0, &its, &its);
>> +
>> +	return its.it_value.tv_sec * UM_NSEC_PER_SEC + its.it_value.tv_nsec;
>>   }
>>   
>> -static inline long long timespec_to_us(const struct timespec *ts)
>> +long long os_vnsecs(void)
>>   {
>> -	return ((long long) ts->tv_sec * UM_USEC_PER_SEC) +
>> -		ts->tv_nsec / UM_NSEC_PER_USEC;
>> +	struct timespec ts;
>> +
>> +	clock_gettime(CLOCK_PROCESS_CPUTIME_ID,&ts);
>> +	return timespec_to_ns(&ts);
>>   }
>>   
>> -static int after_sleep_interval(struct timespec *ts)
>> +long long os_nsecs(void)
>>   {
>> -	int usec = UM_USEC_PER_SEC / UM_HZ;
>> -	long long start_usecs = timespec_to_us(ts);
>> -	struct timeval tv;
>> -	struct itimerval interval;
>> -
>> -	/*
>> -	 * It seems that rounding can increase the value returned from
>> -	 * setitimer to larger than the one passed in.  Over time,
>> -	 * this will cause the remaining time to be greater than the
>> -	 * tick interval.  If this happens, then just reduce the first
>> -	 * tick to the interval value.
>> -	 */
>> -	if (start_usecs > usec)
>> -		start_usecs = usec;
>> -
>> -	start_usecs -= skew / UM_NSEC_PER_USEC;
>> -	if (start_usecs < 0)
>> -		start_usecs = 0;
>> -
>> -	tv = ((struct timeval) { .tv_sec  = start_usecs / UM_USEC_PER_SEC,
>> -				 .tv_usec = start_usecs % UM_USEC_PER_SEC });
>> -	interval = ((struct itimerval) { { 0, usec }, tv });
>> -
>> -	if (setitimer(ITIMER_VIRTUAL, &interval, NULL) == -1)
>> -		return -errno;
>> +	struct timespec ts;
>>   
>> -	return 0;
>> +	clock_gettime(CLOCK_MONOTONIC,&ts);
>> +	return timespec_to_ns(&ts);
>>   }
>> -#endif
>>   
>> -void idle_sleep(unsigned long long nsecs)
>> +/**
>> + * os_idle_sleep() - sleep for a given time of nsecs
>> + * @nsecs: nanoseconds to sleep
>> + */
>> +void os_idle_sleep(unsigned long long nsecs)
>>   {
>>   	struct timespec ts;
>>   
>> -	/*
>> -	 * nsecs can come in as zero, in which case, this starts a
>> -	 * busy loop.  To prevent this, reset nsecs to the tick
>> -	 * interval if it is zero.
>> -	 */
>> -	if (nsecs == 0)
>> -		nsecs = UM_NSEC_PER_SEC / UM_HZ;
>> -
>> -	nsecs = sleep_time(nsecs);
>> -	ts = ((struct timespec) { .tv_sec	= nsecs / UM_NSEC_PER_SEC,
>> -				  .tv_nsec	= nsecs % UM_NSEC_PER_SEC });
>> -
>> -	if (nanosleep(&ts, &ts) == 0)
>> -		deliver_alarm();
>> -	after_sleep_interval(&ts);
>> +	if (nsecs <= 0) {
>> +		return;
>> +	}
>> +
>> +	ts = ((struct timespec) {
>> +			.tv_sec  = nsecs / UM_NSEC_PER_SEC,
>> +			.tv_nsec = nsecs % UM_NSEC_PER_SEC
>> +	});
>> +
>> +	clock_nanosleep(CLOCK_MONOTONIC, 0, &ts, NULL);
>>   }
>>
> Thanks,
> //richard
>
> ------------------------------------------------------------------------------
> _______________________________________________
> User-mode-linux-devel mailing list
> User-mode-linux-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
>


------------------------------------------------------------------------------
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

