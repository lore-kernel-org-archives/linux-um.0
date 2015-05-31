Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <thomas@m3y3r.de>) id 1YzBFf-0001dY-4a
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 31 May 2015 21:58:39 +0000
Received: from www17.your-server.de ([213.133.104.17])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1YzBFb-00074v-Hc
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 31 May 2015 21:58:39 +0000
Message-ID: <1433109506.8871.17.camel@m3y3r.de>
From: Thomas Meyer <thomas@m3y3r.de>
Date: Sun, 31 May 2015 23:58:26 +0200
In-Reply-To: <556B8202.6030501@nod.at>
References: <bbdd39b2-dcac-41c8-bfb4-73645e73c7b7@email.android.com>
	<556AED66.3030706@nod.at> <1433098827.8871.13.camel@m3y3r.de>
	<556B8202.6030501@nod.at>
Mime-Version: 1.0
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
To: Richard Weinberger <richard@nod.at>
Cc: user-mode-linux-devel <user-mode-linux-devel@lists.sourceforge.net>

Am Sonntag, den 31.05.2015, 23:49 +0200 schrieb Richard Weinberger:
> Am 31.05.2015 um 21:00 schrieb Thomas Meyer:
> > > Ping.
> > > Would be nice to have this patch for the 4.2 merge window.
> > 
> > I can provide you the current version of the patch, but I'm not 
> > sure if
> > it's ready for inclusion yet.
> 
> That's fine. I'll look at it.
> Just rebase it against Linus' tree or uml-next.
> https://git.kernel.org/cgit/linux/kernel/git/rw/uml.git/log/?h=linux
> -next
> > For example:
> > - With this patch I see new zombie processes of UML userspace
> > processes. I'm not sure what's going on here.
> > - Anton reported some hang he sees with this patch
> > - A person from cicso is worried about the potential idle CPU usage
> > after the patch, because of the many timers started, i.e. a host 
> > with
> > hundreds of UMLs.
> > 
> > Also meanwhile I think is not the correct thing to start a new 
> > timer
> > for each UML userspace process, because the timer will also trigger 
> > the
> > userspace process, even the corresponding process isn't scheduled 
> > by
> > the kernel currently. I think the previous behaviour with the 
> > itimer
> > was okay, because the virtual timer only did execute when the 
> > process
> > was executing which is the correct thing to do for the currently 
> > active
> > task in the UML kernel.
> > I see two solutions for above problem: cascade the kernel timer 
> > into
> > the current active task; there is actually no need to start a timer 
> > in
> > each userspace process.
> > Start/stop each timer when a userspace process becomes active resp.
> > becomes inactive again.
> > I hope above logic makes some sense at all! What do you think about
> > this?
> 
> Hm, we definitely don't want a new timer for each userspace proc. The 
> timer
> has to work as a regular clock source.
> But I'll have to read your/Anton's code in detail first.

Hi,

rebased against current Linus' tree:
- Currently I'm not sure at all why the individual itimers are created
for each usespace process and if we need to copy these mechanism for
posix interval timers.

Please have a look at the patch, this should apply cleanly against
linus tree:

commit c091d1f11649d39dbdd1653139954bf1feff0c80
Author: Thomas Meyer <thomas@m3y3r.de>
Date:   Sun May 31 19:40:22 2015 +0200

    um: Switch clocksource to hrtimers
    
    Switch the UML clocksource from interval timers to posix interval timers and
    move to a monotonic timer.
    
    This fixes suspend&resume related timer issues and improves network performance
    as TCP state machines are now fed with the correct time; also correct QoS and
    traffic shaping.
    
    Signed-off-by: Thomas Meyer <thomas@m3y3r.de>

diff --git a/arch/um/Makefile b/arch/um/Makefile
index 17d4460..a4a434f 100644
--- a/arch/um/Makefile
+++ b/arch/um/Makefile
@@ -130,7 +130,7 @@ export LDS_ELF_FORMAT := $(ELF_FORMAT)
 # The wrappers will select whether using "malloc" or the kernel allocator.
 LINK_WRAPS = -Wl,--wrap,malloc -Wl,--wrap,free -Wl,--wrap,calloc
 
-LD_FLAGS_CMDLINE = $(foreach opt,$(LDFLAGS),-Wl,$(opt))
+LD_FLAGS_CMDLINE = $(foreach opt,$(LDFLAGS),-Wl,$(opt)) -lrt
 
 # Used by link-vmlinux.sh which has special support for um link
 export CFLAGS_vmlinux := $(LINK-y) $(LINK_WRAPS) $(LD_FLAGS_CMDLINE)
diff --git a/arch/um/include/shared/os.h b/arch/um/include/shared/os.h
index d824528..2e738b0 100644
--- a/arch/um/include/shared/os.h
+++ b/arch/um/include/shared/os.h
@@ -217,7 +217,7 @@ extern int set_umid(char *name);
 extern char *get_umid(void);
 
 /* signal.c */
-extern void timer_init(void);
+extern void timer_set_signal_handler(void);
 extern void set_sigstack(void *sig_stack, int size);
 extern void remove_sigstack(void);
 extern void set_handler(int sig);
@@ -238,12 +238,16 @@ extern void um_early_printk(const char *s, unsigned int n);
 extern void os_fix_helper_signals(void);
 
 /* time.c */
-extern void idle_sleep(unsigned long long nsecs);
-extern int set_interval(void);
-extern int timer_one_shot(int ticks);
-extern long long disable_timer(void);
+extern void os_idle_sleep(unsigned long long nsecs);
+extern int os_timer_create(void* timer);
+extern int os_timer_set_interval(void* timer, void* its);
+extern int os_timer_one_shot(int ticks);
+extern long long os_timer_disable(void);
+extern long os_timer_remain(void* timer);
 extern void uml_idle_timer(void);
+extern long long os_persistent_clock_emulation(void);
 extern long long os_nsecs(void);
+extern long long os_vnsecs(void);
 
 /* skas/mem.c */
 extern long run_syscall_stub(struct mm_id * mm_idp,
diff --git a/arch/um/include/shared/skas/stub-data.h b/arch/um/include/shared/skas/stub-data.h
index f6ed92c..f98b9e2 100644
--- a/arch/um/include/shared/skas/stub-data.h
+++ b/arch/um/include/shared/skas/stub-data.h
@@ -6,12 +6,12 @@
 #ifndef __STUB_DATA_H
 #define __STUB_DATA_H
 
-#include <sys/time.h>
+#include <time.h>
 
 struct stub_data {
-       long offset;
+       unsigned long offset;
        int fd;
-       struct itimerval timer;
+       struct itimerspec timer;
        long err;
 };
 
diff --git a/arch/um/include/shared/timer-internal.h b/arch/um/include/shared/timer-internal.h
new file mode 100644
index 0000000..03e6f21
--- /dev/null
+++ b/arch/um/include/shared/timer-internal.h
@@ -0,0 +1,13 @@
+/*
+ * Copyright (C) 2012 - 2014 Cisco Systems
+ * Copyright (C) 2000 - 2007 Jeff Dike (jdike@{addtoit,linux.intel}.com)
+ * Licensed under the GPL
+ */
+
+#ifndef __TIMER_INTERNAL_H__
+#define __TIMER_INTERNAL_H__
+
+#define TIMER_MULTIPLIER 256
+#define TIMER_MIN_DELTA  500
+
+#endif
diff --git a/arch/um/kernel/process.c b/arch/um/kernel/process.c
index 68b9119..3b936f8 100644
--- a/arch/um/kernel/process.c
+++ b/arch/um/kernel/process.c
@@ -27,6 +27,7 @@
 #include <kern_util.h>
 #include <os.h>
 #include <skas.h>
+#include <timer-internal.h>
 
 /*
  * This is a per-cpu array.  A processor only modifies its entry and it only
@@ -201,11 +202,8 @@ void initial_thread_cb(void (*proc)(void *), void *arg)
 
 void arch_cpu_idle(void)
 {
-       unsigned long long nsecs;
-
        cpu_tasks[current_thread_info()->cpu].pid = os_getpid();
-       nsecs = disable_timer();
-       idle_sleep(nsecs);
+       os_idle_sleep(UM_NSEC_PER_SEC / UM_HZ);
        local_irq_enable();
 }
 
diff --git a/arch/um/kernel/skas/clone.c b/arch/um/kernel/skas/clone.c
index 289771d..814ec8b 100644
--- a/arch/um/kernel/skas/clone.c
+++ b/arch/um/kernel/skas/clone.c
@@ -24,6 +24,7 @@ void __attribute__ ((__section__ (".__syscall_stub")))
 stub_clone_handler(void)
 {
        struct stub_data *data = (struct stub_data *) STUB_DATA;
+       timer_t timerid;
        long err;
 
        err = stub_syscall2(__NR_clone, CLONE_PARENT | CLONE_FILES | SIGCHLD,
@@ -35,8 +36,14 @@ stub_clone_handler(void)
        if (err)
                goto out;
 
-       err = stub_syscall3(__NR_setitimer, ITIMER_VIRTUAL,
-                           (long) &data->timer, 0);
+       /* create posix interval timer */
+       err = stub_syscall3(__NR_timer_create, CLOCK_MONOTONIC, 0l, (long) &timerid);
+       if (err)
+               goto out;
+
+       /* set interval to the given value from copy_context_skas0() */
+       err = stub_syscall4(__NR_timer_settime, (long) timerid, 0l,
+                                               (long) &data->timer, 0l);
        if (err)
                goto out;
 
diff --git a/arch/um/kernel/time.c b/arch/um/kernel/time.c
index 117568d..d15966c 100644
--- a/arch/um/kernel/time.c
+++ b/arch/um/kernel/time.c
@@ -1,4 +1,5 @@
 /*
+ * Copyright (C) 2012-2014 Cisco Systems
  * Copyright (C) 2000 - 2007 Jeff Dike (jdike@{addtoit,linux.intel}.com)
  * Licensed under the GPL
  */
@@ -8,10 +9,12 @@
 #include <linux/interrupt.h>
 #include <linux/jiffies.h>
 #include <linux/threads.h>
+#include <linux/spinlock.h>
 #include <asm/irq.h>
 #include <asm/param.h>
 #include <kern_util.h>
 #include <os.h>
+#include <timer-internal.h>
 
 void timer_handler(int sig, struct siginfo *unused_si, struct uml_pt_regs *regs)
 {
@@ -22,18 +25,20 @@ void timer_handler(int sig, struct siginfo *unused_si, struct uml_pt_regs *regs)
        local_irq_restore(flags);
 }
 
-static void itimer_set_mode(enum clock_event_mode mode,
+static void timer_set_mode(enum clock_event_mode mode,
                            struct clock_event_device *evt)
 {
        switch (mode) {
        case CLOCK_EVT_MODE_PERIODIC:
-               set_interval();
+               os_timer_set_interval(NULL, NULL);
                break;
 
+       case CLOCK_EVT_MODE_ONESHOT:
+               os_timer_one_shot(1);
+
        case CLOCK_EVT_MODE_SHUTDOWN:
        case CLOCK_EVT_MODE_UNUSED:
-       case CLOCK_EVT_MODE_ONESHOT:
-               disable_timer();
+               os_timer_disable();
                break;
 
        case CLOCK_EVT_MODE_RESUME:
@@ -41,68 +46,74 @@ static void itimer_set_mode(enum clock_event_mode mode,
        }
 }
 
-static int itimer_next_event(unsigned long delta,
+static int timer_next_event(unsigned long delta,
                             struct clock_event_device *evt)
 {
-       return timer_one_shot(delta + 1);
+       return os_timer_one_shot(delta);
 }
 
-static struct clock_event_device itimer_clockevent = {
-       .name           = "itimer",
+static struct clock_event_device timer_clockevent = {
+       .name           = "posix-timer",
        .rating         = 250,
        .cpumask        = cpu_all_mask,
        .features       = CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT,
-       .set_mode       = itimer_set_mode,
-       .set_next_event = itimer_next_event,
-       .shift          = 32,
+       .set_mode       = timer_set_mode,
+       .set_next_event = timer_next_event,
+       .shift          = 0,
+       .max_delta_ns   = 0xffffffff,
+       .min_delta_ns   = TIMER_MIN_DELTA, //microsecond resolution should be enough for anyone, same as 640K RAM
        .irq            = 0,
+       .mult           = 1,
 };
 
-static irqreturn_t um_timer(int irq, void *dev)
+static irqreturn_t um_timer_irq(int irq, void *dev)
 {
-       (*itimer_clockevent.event_handler)(&itimer_clockevent);
+       (*timer_clockevent.event_handler)(&timer_clockevent);
 
        return IRQ_HANDLED;
 }
 
-static cycle_t itimer_read(struct clocksource *cs)
+static cycle_t timer_read(struct clocksource *cs)
 {
-       return os_nsecs() / 1000;
+       return os_nsecs() / TIMER_MULTIPLIER;
 }
 
-static struct clocksource itimer_clocksource = {
-       .name           = "itimer",
+static struct clocksource timer_clocksource = {
+       .name           = "timer",
        .rating         = 300,
-       .read           = itimer_read,
+       .read           = timer_read,
        .mask           = CLOCKSOURCE_MASK(64),
        .flags          = CLOCK_SOURCE_IS_CONTINUOUS,
 };
 
-static void __init setup_itimer(void)
+static void __init timer_setup(void)
 {
        int err;
 
-       err = request_irq(TIMER_IRQ, um_timer, 0, "timer", NULL);
-       if (err != 0)
+       err = request_irq(TIMER_IRQ, um_timer_irq, IRQF_TIMER, "hr timer", NULL);
+       if (err != 0) {
                printk(KERN_ERR "register_timer : request_irq failed - "
                       "errno = %d\n", -err);
+               return;
+    }
+
+    err = os_timer_create(NULL);
+    if (err != 0) {
+        printk(KERN_ERR "creation of timer failed - errno = %d\n", -err);
+        return;
+    }
 
-       itimer_clockevent.mult = div_sc(HZ, NSEC_PER_SEC, 32);
-       itimer_clockevent.max_delta_ns =
-               clockevent_delta2ns(60 * HZ, &itimer_clockevent);
-       itimer_clockevent.min_delta_ns =
-               clockevent_delta2ns(1, &itimer_clockevent);
-       err = clocksource_register_hz(&itimer_clocksource, USEC_PER_SEC);
+       err = clocksource_register_hz(&timer_clocksource, NSEC_PER_SEC/TIMER_MULTIPLIER);
        if (err) {
                printk(KERN_ERR "clocksource_register_hz returned %d\n", err);
                return;
        }
-       clockevents_register_device(&itimer_clockevent);
+       clockevents_register_device(&timer_clockevent);
 }
 
 void read_persistent_clock(struct timespec *ts)
 {
-       long long nsecs = os_nsecs();
+       long long nsecs = os_persistent_clock_emulation();
 
        set_normalized_timespec(ts, nsecs / NSEC_PER_SEC,
                                nsecs % NSEC_PER_SEC);
@@ -110,6 +121,6 @@ void read_persistent_clock(struct timespec *ts)
 
 void __init time_init(void)
 {
-       timer_init();
-       late_time_init = setup_itimer;
+       timer_set_signal_handler();
+       late_time_init = timer_setup;
 }
diff --git a/arch/um/os-Linux/internal.h b/arch/um/os-Linux/internal.h
deleted file mode 100644
index 0dc2c9f..0000000
--- a/arch/um/os-Linux/internal.h
+++ /dev/null
@@ -1 +0,0 @@
-void alarm_handler(int sig, struct siginfo *unused_si, mcontext_t *mc);
diff --git a/arch/um/os-Linux/main.c b/arch/um/os-Linux/main.c
index df9191a..6e36f0f 100644
--- a/arch/um/os-Linux/main.c
+++ b/arch/um/os-Linux/main.c
@@ -163,13 +163,13 @@ int __init main(int argc, char **argv, char **envp)
 
        /*
         * This signal stuff used to be in the reboot case.  However,
-        * sometimes a SIGVTALRM can come in when we're halting (reproducably
+        * sometimes a timer signal can come in when we're halting (reproducably
         * when writing out gcov information, presumably because that takes
         * some time) and cause a segfault.
         */
 
-       /* stop timers and set SIGVTALRM to be ignored */
-       disable_timer();
+       /* stop timers and set timer signal to be ignored */
+       os_timer_disable();
 
        /* disable SIGIO for the fds and set SIGIO to be ignored */
        err = deactivate_all_fds();
diff --git a/arch/um/os-Linux/signal.c b/arch/um/os-Linux/signal.c
index 7b605e4..4a9be55 100644
--- a/arch/um/os-Linux/signal.c
+++ b/arch/um/os-Linux/signal.c
@@ -13,7 +13,6 @@
 #include <kern_util.h>
 #include <os.h>
 #include <sysdep/mcontext.h>
-#include "internal.h"
 
 void (*sig_info[NSIG])(int, struct siginfo *, struct uml_pt_regs *) = {
        [SIGTRAP]       = relay_signal,
@@ -23,7 +22,8 @@ void (*sig_info[NSIG])(int, struct siginfo *, struct uml_pt_regs *) = {
        [SIGBUS]        = bus_handler,
        [SIGSEGV]       = segv_handler,
        [SIGIO]         = sigio_handler,
-       [SIGVTALRM]     = timer_handler };
+       [SIGALRM]       = timer_handler
+};
 
 static void sig_handler_common(int sig, struct siginfo *si, mcontext_t *mc)
 {
@@ -38,7 +38,7 @@ static void sig_handler_common(int sig, struct siginfo *si, mcontext_t *mc)
        }
 
        /* enable signals if sig isn't IRQ signal */
-       if ((sig != SIGIO) && (sig != SIGWINCH) && (sig != SIGVTALRM))
+       if ((sig != SIGIO) && (sig != SIGWINCH) && (sig != SIGALRM))
                unblock_signals();
 
        (*sig_info[sig])(sig, si, &r);
@@ -55,8 +55,8 @@ static void sig_handler_common(int sig, struct siginfo *si, mcontext_t *mc)
 #define SIGIO_BIT 0
 #define SIGIO_MASK (1 << SIGIO_BIT)
 
-#define SIGVTALRM_BIT 1
-#define SIGVTALRM_MASK (1 << SIGVTALRM_BIT)
+#define SIGALRM_BIT 1
+#define SIGALRM_MASK (1 << SIGALRM_BIT)
 
 static int signals_enabled;
 static unsigned int signals_pending;
@@ -78,46 +78,47 @@ void sig_handler(int sig, struct siginfo *si, mcontext_t *mc)
        set_signals(enabled);
 }
 
-static void real_alarm_handler(mcontext_t *mc)
+static void timer_real_alarm_handler(mcontext_t *mc)
 {
        struct uml_pt_regs regs;
 
        if (mc != NULL)
                get_regs_from_mc(&regs, mc);
        regs.is_user = 0;
-       unblock_signals();
-       timer_handler(SIGVTALRM, NULL, &regs);
+       timer_handler(SIGALRM, NULL, &regs);
 }
 
-void alarm_handler(int sig, struct siginfo *unused_si, mcontext_t *mc)
+void timer_alarm_handler(int sig, struct siginfo *unused_si, mcontext_t *mc)
 {
        int enabled;
 
        enabled = signals_enabled;
        if (!signals_enabled) {
-               signals_pending |= SIGVTALRM_MASK;
+               signals_pending |= SIGALRM_MASK;
                return;
        }
 
        block_signals();
-
-       real_alarm_handler(mc);
+       timer_real_alarm_handler(mc);
        set_signals(enabled);
 }
 
-void timer_init(void)
+void timer_set_signal_handler(void)
 {
-       set_handler(SIGVTALRM);
+       set_handler(SIGALRM);
 }
 
 void set_sigstack(void *sig_stack, int size)
 {
-       stack_t stack = ((stack_t) { .ss_flags  = 0,
-                                    .ss_sp     = (__ptr_t) sig_stack,
-                                    .ss_size   = size - sizeof(void *) });
+       stack_t stack = ((stack_t) {
+                   .ss_flags = 0,
+                               .ss_sp    = (__ptr_t) sig_stack,
+                               .ss_size  = size - sizeof(void *)
+       });
 
-       if (sigaltstack(&stack, NULL) != 0)
+       if (sigaltstack(&stack, NULL) != 0) {
                panic("enabling signal stack failed, errno = %d\n", errno);
+       }
 }
 
 static void (*handlers[_NSIG])(int sig, struct siginfo *si, mcontext_t *mc) = {
@@ -129,10 +130,9 @@ static void (*handlers[_NSIG])(int sig, struct siginfo *si, mcontext_t *mc) = {
 
        [SIGIO] = sig_handler,
        [SIGWINCH] = sig_handler,
-       [SIGVTALRM] = alarm_handler
+       [SIGALRM] = timer_alarm_handler
 };
 
-
 static void hard_handler(int sig, siginfo_t *si, void *p)
 {
        struct ucontext *uc = p;
@@ -186,9 +186,9 @@ void set_handler(int sig)
 
        /* block irq ones */
        sigemptyset(&action.sa_mask);
-       sigaddset(&action.sa_mask, SIGVTALRM);
        sigaddset(&action.sa_mask, SIGIO);
        sigaddset(&action.sa_mask, SIGWINCH);
+       sigaddset(&action.sa_mask, SIGALRM);
 
        if (sig == SIGSEGV)
                flags |= SA_NODEFER;
@@ -281,8 +281,8 @@ void unblock_signals(void)
                if (save_pending & SIGIO_MASK)
                        sig_handler_common(SIGIO, NULL, NULL);
 
-               if (save_pending & SIGVTALRM_MASK)
-                       real_alarm_handler(NULL);
+               if (save_pending & SIGALRM_MASK)
+                       timer_real_alarm_handler(NULL);
        }
 }
 
diff --git a/arch/um/os-Linux/skas/process.c b/arch/um/os-Linux/skas/process.c
index 7a97775..4761f8b 100644
--- a/arch/um/os-Linux/skas/process.c
+++ b/arch/um/os-Linux/skas/process.c
@@ -45,7 +45,7 @@ static int ptrace_dump_regs(int pid)
  * Signals that are OK to receive in the stub - we'll just continue it.
  * SIGWINCH will happen when UML is inside a detached screen.
  */
-#define STUB_SIG_MASK ((1 << SIGVTALRM) | (1 << SIGWINCH))
+#define STUB_SIG_MASK ((1 << SIGALRM) | (1 << SIGWINCH))
 
 /* Signals that the stub will finish with - anything else is an error */
 #define STUB_DONE_MASK (1 << SIGTRAP)
@@ -181,12 +181,23 @@ static int userspace_tramp(void *stack)
        void *addr;
        int err, fd;
        unsigned long long offset;
+       timer_t timer;
+
+       struct stub_data *data = (struct stub_data *) stack;
 
        ptrace(PTRACE_TRACEME, 0, 0, 0);
 
        signal(SIGTERM, SIG_DFL);
        signal(SIGWINCH, SIG_IGN);
-       err = set_interval();
+
+       err = os_timer_create(&timer);
+       if (err) {
+               printk(UM_KERN_ERR "userspace_tramp - creation of timer failed, "
+                      "errno = %d\n", err);
+               exit(1);
+       }
+
+       err = os_timer_set_interval(&timer, &data->timer);
        if (err) {
                printk(UM_KERN_ERR "userspace_tramp - setting timer failed, "
                       "errno = %d\n", err);
@@ -249,8 +260,9 @@ int userspace_pid[NR_CPUS];
 int start_userspace(unsigned long stub_stack)
 {
        void *stack;
-       unsigned long sp;
+       unsigned long sp, remain;
        int pid, status, n, flags, err;
+       struct stub_data *data = (struct stub_data *) stub_stack;
 
        stack = mmap(NULL, UM_KERN_PAGE_SIZE,
                     PROT_READ | PROT_WRITE | PROT_EXEC,
@@ -266,6 +278,18 @@ int start_userspace(unsigned long stub_stack)
 
        flags = CLONE_FILES | SIGCHLD;
 
+       remain = os_timer_remain(NULL);
+       if (remain == 0)
+               remain = UM_NSEC_PER_SEC / UM_HZ;
+
+       *data = ((struct stub_data) { 
+                       .timer  = ((struct itimerspec)
+                               { .it_value.tv_sec  = 0,
+                                 .it_value.tv_nsec = remain,
+                                 .it_interval.tv_sec  = 0,
+                                 .it_interval.tv_nsec = UM_NSEC_PER_SEC / UM_HZ })
+       });
+
        pid = clone(userspace_tramp, (void *) sp, flags, (void *) stub_stack);
        if (pid < 0) {
                err = -errno;
@@ -282,7 +306,7 @@ int start_userspace(unsigned long stub_stack)
                               "errno = %d\n", errno);
                        goto out_kill;
                }
-       } while (WIFSTOPPED(status) && (WSTOPSIG(status) == SIGVTALRM));
+       } while (WIFSTOPPED(status) && (WSTOPSIG(status) == SIGALRM));
 
        if (!WIFSTOPPED(status) || (WSTOPSIG(status) != SIGSTOP)) {
                err = -EINVAL;
@@ -315,8 +339,6 @@ int start_userspace(unsigned long stub_stack)
 
 void userspace(struct uml_pt_regs *regs)
 {
-       struct itimerval timer;
-       unsigned long long nsecs, now;
        int err, status, op, pid = userspace_pid[0];
        /* To prevent races if using_sysemu changes under us.*/
        int local_using_sysemu;
@@ -325,13 +347,8 @@ void userspace(struct uml_pt_regs *regs)
        /* Handle any immediate reschedules or signals */
        interrupt_end();
 
-       if (getitimer(ITIMER_VIRTUAL, &timer))
-               printk(UM_KERN_ERR "Failed to get itimer, errno = %d\n", errno);
-       nsecs = timer.it_value.tv_sec * UM_NSEC_PER_SEC +
-               timer.it_value.tv_usec * UM_NSEC_PER_USEC;
-       nsecs += os_nsecs();
-
        while (1) {
+
                /*
                 * This can legitimately fail if the process loads a
                 * bogus value into a segment register.  It will
@@ -401,19 +418,7 @@ void userspace(struct uml_pt_regs *regs)
                        case SIGTRAP:
                                relay_signal(SIGTRAP, (struct siginfo *)&si, regs);
                                break;
-                       case SIGVTALRM:
-                               now = os_nsecs();
-                               if (now < nsecs)
-                                       break;
-                               block_signals();
-                               (*sig_info[sig])(sig, (struct siginfo *)&si, regs);
-                               unblock_signals();
-                               nsecs = timer.it_value.tv_sec *
-                                       UM_NSEC_PER_SEC +
-                                       timer.it_value.tv_usec *
-                                       UM_NSEC_PER_USEC;
-                               nsecs += os_nsecs();
-                               break;
+                       case SIGALRM:
                        case SIGIO:
                        case SIGILL:
                        case SIGBUS:
@@ -460,8 +465,8 @@ __initcall(init_thread_regs);
 
 int copy_context_skas0(unsigned long new_stack, int pid)
 {
-       struct timeval tv = { .tv_sec = 0, .tv_usec = UM_USEC_PER_SEC / UM_HZ };
        int err;
+       unsigned long remain;
        unsigned long current_stack = current_stub_stack();
        struct stub_data *data = (struct stub_data *) current_stack;
        struct stub_data *child_data = (struct stub_data *) new_stack;
@@ -472,11 +477,19 @@ int copy_context_skas0(unsigned long new_stack, int pid)
         * prepare offset and fd of child's stack as argument for parent's
         * and child's mmap2 calls
         */
-       *data = ((struct stub_data) { .offset   = MMAP_OFFSET(new_offset),
-                                     .fd       = new_fd,
-                                     .timer    = ((struct itimerval)
-                                                  { .it_value = tv,
-                                                    .it_interval = tv }) });
+       remain = os_timer_remain(NULL);
+       if (remain == 0)
+               remain = UM_NSEC_PER_SEC / UM_HZ;
+
+       *data = ((struct stub_data) { 
+                       .offset = MMAP_OFFSET(new_offset),
+                       .fd     = new_fd,
+                       .timer  = ((struct itimerspec)
+                                            { .it_value.tv_sec  = 0,
+                                              .it_value.tv_nsec = remain,
+                                              .it_interval.tv_sec  = 0,
+                                              .it_interval.tv_nsec = UM_NSEC_PER_SEC / UM_HZ })
+       });
 
        err = ptrace_setregs(pid, thread_regs);
        if (err < 0) {
diff --git a/arch/um/os-Linux/time.c b/arch/um/os-Linux/time.c
index e9824d5..0e2bb7d 100644
--- a/arch/um/os-Linux/time.c
+++ b/arch/um/os-Linux/time.c
@@ -1,4 +1,5 @@
 /*
+ * Copyright (C) 2012-2014 Cisco Systems
  * Copyright (C) 2000 - 2007 Jeff Dike (jdike{addtoit,linux.intel}.com)
  * Licensed under the GPL
  */
@@ -10,177 +11,172 @@
 #include <sys/time.h>
 #include <kern_util.h>
 #include <os.h>
-#include "internal.h"
+#include <string.h>
+#include <timer-internal.h>
 
-int set_interval(void)
-{
-       int usec = UM_USEC_PER_SEC / UM_HZ;
-       struct itimerval interval = ((struct itimerval) { { 0, usec },
-                                                         { 0, usec } });
-
-       if (setitimer(ITIMER_VIRTUAL, &interval, NULL) == -1)
-               return -errno;
+static timer_t event_high_res_timer = 0;
 
-       return 0;
+static inline long long timeval_to_ns(const struct timeval *tv)
+{
+       return ((long long) tv->tv_sec * UM_NSEC_PER_SEC) +
+               tv->tv_usec * UM_NSEC_PER_USEC;
 }
 
-int timer_one_shot(int ticks)
+static inline long long timespec_to_ns(const struct timespec *ts)
 {
-       unsigned long usec = ticks * UM_USEC_PER_SEC / UM_HZ;
-       unsigned long sec = usec / UM_USEC_PER_SEC;
-       struct itimerval interval;
-
-       usec %= UM_USEC_PER_SEC;
-       interval = ((struct itimerval) { { 0, 0 }, { sec, usec } });
+       return ((long long) ts->tv_sec * UM_NSEC_PER_SEC) +
+               ts->tv_nsec;
+}
 
-       if (setitimer(ITIMER_VIRTUAL, &interval, NULL) == -1)
-               return -errno;
+long long os_persistent_clock_emulation (void) {
+       struct timespec realtime_tp;
 
-       return 0;
+       clock_gettime(CLOCK_REALTIME, &realtime_tp);
+       return timespec_to_ns(&realtime_tp);
 }
 
 /**
- * timeval_to_ns - Convert timeval to nanoseconds
- * @ts:                pointer to the timeval variable to be converted
- *
- * Returns the scalar nanosecond representation of the timeval
- * parameter.
- *
- * Ripped from linux/time.h because it's a kernel header, and thus
- * unusable from here.
+ * os_timer_create() - create an new posix (interval) timer
  */
-static inline long long timeval_to_ns(const struct timeval *tv)
-{
-       return ((long long) tv->tv_sec * UM_NSEC_PER_SEC) +
-               tv->tv_usec * UM_NSEC_PER_USEC;
+int os_timer_create(void* timer) {
+
+       timer_t* t = timer;
+
+       if(t == NULL) {
+               t = &event_high_res_timer;
+       }
+
+       if (timer_create(
+               CLOCK_MONOTONIC,
+               NULL,
+               t) == -1) {
+               return -1;
+       }
+       return 0;
 }
 
-long long disable_timer(void)
+int os_timer_set_interval(void* timer, void* i)
 {
-       struct itimerval time = ((struct itimerval) { { 0, 0 }, { 0, 0 } });
-       long long remain, max = UM_NSEC_PER_SEC / UM_HZ;
+       struct itimerspec its;
+       unsigned long long nsec;
+       timer_t* t = timer;
+       struct itimerspec* its_in = i;
 
-       if (setitimer(ITIMER_VIRTUAL, &time, &time) < 0)
-               printk(UM_KERN_ERR "disable_timer - setitimer failed, "
-                      "errno = %d\n", errno);
+       if(t == NULL) {
+               t = &event_high_res_timer;
+       }
 
-       remain = timeval_to_ns(&time.it_value);
-       if (remain > max)
-               remain = max;
+       nsec = UM_NSEC_PER_SEC / UM_HZ;
 
-       return remain;
-}
+       if(its_in != NULL) {
+               its.it_value.tv_sec = its_in->it_value.tv_sec;
+               its.it_value.tv_nsec = its_in->it_value.tv_nsec;
+       } else {
+               its.it_value.tv_sec = 0;
+               its.it_value.tv_nsec = nsec;
+       }
 
-long long os_nsecs(void)
-{
-       struct timeval tv;
+       its.it_interval.tv_sec = 0;
+       its.it_interval.tv_nsec = nsec;
 
-       gettimeofday(&tv, NULL);
-       return timeval_to_ns(&tv);
-}
+       if(timer_settime(*t, 0, &its, NULL) == -1) {
+               return -errno;
+       }
 
-#ifdef UML_CONFIG_NO_HZ_COMMON
-static int after_sleep_interval(struct timespec *ts)
-{
        return 0;
 }
 
-static void deliver_alarm(void)
+/**
+ * os_timer_remain() - returns the remaining nano seconds of the given interval
+ *                     timer
+ * Because this is the remaining time of an interval timer, which correspondends
+ * to HZ, this value can never be bigger than one second. Just
+ * the nanosecond part of the timer is returned.
+ * The returned time is relative to the start time of the interval timer.
+ * Return an negative value in an error case.
+ */
+long os_timer_remain(void* timer)
 {
-       alarm_handler(SIGVTALRM, NULL, NULL);
-}
+       struct itimerspec its;
+       timer_t* t = timer;
 
-static unsigned long long sleep_time(unsigned long long nsecs)
-{
-       return nsecs;
-}
+       if(t == NULL) {
+               t = &event_high_res_timer;
+       }
 
-#else
-unsigned long long last_tick;
-unsigned long long skew;
+       if(timer_gettime(t, &its) == -1) {
+               return -errno;
+       }
+
+       return its.it_value.tv_nsec;
+}
 
-static void deliver_alarm(void)
+int os_timer_one_shot(int ticks)
 {
-       unsigned long long this_tick = os_nsecs();
-       int one_tick = UM_NSEC_PER_SEC / UM_HZ;
+       struct itimerspec its;
+       unsigned long long nsec;
+       unsigned long sec;
 
-       /* Protection against the host's time going backwards */
-       if ((last_tick != 0) && (this_tick < last_tick))
-               this_tick = last_tick;
+    nsec = (ticks + 1);
+    sec = nsec / UM_NSEC_PER_SEC;
+       nsec = nsec % UM_NSEC_PER_SEC;
 
-       if (last_tick == 0)
-               last_tick = this_tick - one_tick;
+       its.it_value.tv_sec = nsec / UM_NSEC_PER_SEC;
+       its.it_value.tv_nsec = nsec;
 
-       skew += this_tick - last_tick;
+       its.it_interval.tv_sec = 0;
+       its.it_interval.tv_nsec = 0; // we cheat here
 
-       while (skew >= one_tick) {
-               alarm_handler(SIGVTALRM, NULL, NULL);
-               skew -= one_tick;
-       }
-
-       last_tick = this_tick;
+       timer_settime(event_high_res_timer, 0, &its, NULL);
+       return 0;
 }
 
-static unsigned long long sleep_time(unsigned long long nsecs)
+/**
+ * os_timer_disable() - disable the posix (interval) timer
+ * Returns the remaining interval timer time in nanoseconds
+ */
+long long os_timer_disable(void)
 {
-       return nsecs > skew ? nsecs - skew : 0;
+       struct itimerspec its;
+
+       memset(&its, 0, sizeof(struct itimerspec));
+       timer_settime(event_high_res_timer, 0, &its, &its);
+
+       return its.it_value.tv_sec * UM_NSEC_PER_SEC + its.it_value.tv_nsec;
 }
 
-static inline long long timespec_to_us(const struct timespec *ts)
+long long os_vnsecs(void)
 {
-       return ((long long) ts->tv_sec * UM_USEC_PER_SEC) +
-               ts->tv_nsec / UM_NSEC_PER_USEC;
+       struct timespec ts;
+
+       clock_gettime(CLOCK_PROCESS_CPUTIME_ID,&ts);
+       return timespec_to_ns(&ts);
 }
 
-static int after_sleep_interval(struct timespec *ts)
+long long os_nsecs(void)
 {
-       int usec = UM_USEC_PER_SEC / UM_HZ;
-       long long start_usecs = timespec_to_us(ts);
-       struct timeval tv;
-       struct itimerval interval;
-
-       /*
-        * It seems that rounding can increase the value returned from
-        * setitimer to larger than the one passed in.  Over time,
-        * this will cause the remaining time to be greater than the
-        * tick interval.  If this happens, then just reduce the first
-        * tick to the interval value.
-        */
-       if (start_usecs > usec)
-               start_usecs = usec;
-
-       start_usecs -= skew / UM_NSEC_PER_USEC;
-       if (start_usecs < 0)
-               start_usecs = 0;
-
-       tv = ((struct timeval) { .tv_sec  = start_usecs / UM_USEC_PER_SEC,
-                                .tv_usec = start_usecs % UM_USEC_PER_SEC });
-       interval = ((struct itimerval) { { 0, usec }, tv });
-
-       if (setitimer(ITIMER_VIRTUAL, &interval, NULL) == -1)
-               return -errno;
+       struct timespec ts;
 
-       return 0;
+       clock_gettime(CLOCK_MONOTONIC,&ts);
+       return timespec_to_ns(&ts);
 }
-#endif
 
-void idle_sleep(unsigned long long nsecs)
+/**
+ * os_idle_sleep() - sleep for a given time of nsecs
+ * @nsecs: nanoseconds to sleep
+ */
+void os_idle_sleep(unsigned long long nsecs)
 {
        struct timespec ts;
 
-       /*
-        * nsecs can come in as zero, in which case, this starts a
-        * busy loop.  To prevent this, reset nsecs to the tick
-        * interval if it is zero.
-        */
-       if (nsecs == 0)
-               nsecs = UM_NSEC_PER_SEC / UM_HZ;
-
-       nsecs = sleep_time(nsecs);
-       ts = ((struct timespec) { .tv_sec       = nsecs / UM_NSEC_PER_SEC,
-                                 .tv_nsec      = nsecs % UM_NSEC_PER_SEC });
-
-       if (nanosleep(&ts, &ts) == 0)
-               deliver_alarm();
-       after_sleep_interval(&ts);
+       if (nsecs <= 0) {
+               return;
+       }
+
+       ts = ((struct timespec) {
+                       .tv_sec  = nsecs / UM_NSEC_PER_SEC,
+                       .tv_nsec = nsecs % UM_NSEC_PER_SEC
+       });
+
+       clock_nanosleep(CLOCK_MONOTONIC, 0, &ts, NULL);
 }



------------------------------------------------------------------------------
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

