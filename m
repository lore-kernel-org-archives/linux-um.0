Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1B9EEH-0005Bp-3Y for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 01 Apr 2004 18:16:21 -0800
Received: from mx1.redhat.com ([66.187.233.31])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.30) id 1B9EEG-0002Re-7J
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 01 Apr 2004 18:16:20 -0800
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com
	[172.16.52.254])
	by mx1.redhat.com (8.12.10/8.12.10) with ESMTP id i322GDjj004014
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Thu, 1 Apr 2004 21:16:13 -0500
Received: from devserv.devel.redhat.com (devserv.devel.redhat.com
	[172.16.58.1])
	by int-mx1.corp.redhat.com (8.11.6/8.11.6) with ESMTP id i322GDj02785
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Thu, 1 Apr 2004 21:16:13 -0500
From: Pete Zaitcev <zaitcev@redhat.com>
Message-Id: <20040401181616.26d1fcb7.zaitcev@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: [uml-devel] Timer patch for 2.6
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Thu, 1 Apr 2004 18:16:16 -0800
To: user-mode-linux-devel@lists.sourceforge.net
Cc: zaitcev@redhat.com

Guys,

this is a relatively straightforward port of the IBM on-demand-timer
patch which they developed for s390.

I was unable to verify that it actually works in UML. My UML seems to
be hosed by a recent Fedora update, known good setups fail to work, too.
So, I am posting this mainly for review. I am terribly confused by
the way timers work in UML. In particular, it appears that every
process has to set up a timer. So... what are the implications
for implementation of stop_hz_timer()? I reckon that we don't care
about timers of processes which are not runnable anyway, and so
I did not attempt to do anything about timers of them. I only start
and stop interval timer of the current thread (which runs the idle
loop). This is the sort of thing which bothers me about this.

If Jeff wants to apply this to his 2.6 tree and throw it onto
developers to test, it would be fine, but personally I'd like someone
to read this first. Like I said, I am completely lost in arch/um/.

-- Pete

diff -ur -X dontdiff linux-2.6.4-uml-1/arch/um/include/time_user.h linux-2.6.4-uml-1-t1/arch/um/include/time_user.h
--- linux-2.6.4-uml-1/arch/um/include/time_user.h	2003-07-13 20:31:22.000000000 -0700
+++ linux-2.6.4-uml-1-t1/arch/um/include/time_user.h	2004-03-31 15:58:11.000000000 -0800
@@ -6,11 +6,15 @@
 #ifndef __TIME_USER_H__
 #define __TIME_USER_H__
 
-extern void timer(void);
+/* struct timeval has the same layout in user and kernel */
+extern void timer(struct timeval *tv);
+
 extern void switch_timers(int to_real);
 extern void set_interval(int timer_type);
-extern void idle_sleep(int secs);
+extern void idle_sleep(void);
 extern void enable_timer(void);
+extern void enable_hz_timer(int delta_usec);
+extern void disable_hz_timer(struct timeval *delta);
 extern unsigned long time_lock(void);
 extern void time_unlock(unsigned long);
 
diff -ur -X dontdiff linux-2.6.4-uml-1/arch/um/Kconfig linux-2.6.4-uml-1-t1/arch/um/Kconfig
--- linux-2.6.4-uml-1/arch/um/Kconfig	2004-03-14 16:58:33.000000000 -0800
+++ linux-2.6.4-uml-1-t1/arch/um/Kconfig	2004-03-31 22:50:39.000000000 -0800
@@ -219,6 +219,15 @@
 	up for the time spent at the breakpoint.  This could result in a 
 	noticable lag.  If this is a problem, then disable this option.
 
+config NO_IDLE_HZ
+	bool "Stop periodic timer when idle"
+	default n
+
+config NO_IDLE_HZ_INIT
+	bool "Idle HZ timer on by default"
+	depends on NO_IDLE_HZ
+	default y
+
 endmenu
 
 source "init/Kconfig"
diff -ur -X dontdiff linux-2.6.4-uml-1/arch/um/kernel/irq.c linux-2.6.4-uml-1-t1/arch/um/kernel/irq.c
--- linux-2.6.4-uml-1/arch/um/kernel/irq.c	2004-03-14 16:58:33.000000000 -0800
+++ linux-2.6.4-uml-1-t1/arch/um/kernel/irq.c	2004-03-31 22:47:24.000000000 -0800
@@ -278,6 +278,10 @@
 	unsigned int status;
 
 	irq_enter();
+#ifdef CONFIG_NO_IDLE_HZ
+	if (!timer_ticking)		/* SMP implications... XXX */
+		start_hz_timer();
+#endif
 	kstat_this_cpu.irqs[irq]++;
 	spin_lock(&desc->lock);
 	desc->handler->ack(irq);
diff -ur -X dontdiff linux-2.6.4-uml-1/arch/um/kernel/process_kern.c linux-2.6.4-uml-1-t1/arch/um/kernel/process_kern.c
--- linux-2.6.4-uml-1/arch/um/kernel/process_kern.c	2004-03-14 16:58:33.000000000 -0800
+++ linux-2.6.4-uml-1-t1/arch/um/kernel/process_kern.c	2004-03-31 14:46:37.000000000 -0800
@@ -209,8 +209,9 @@
 		irq_stat[smp_processor_id()].idle_timestamp = jiffies;
 		if(need_resched())
 			schedule();
-		
-		idle_sleep(10);
+
+		stop_hz_timer();
+		idle_sleep();
 	}
 }
 
diff -ur -X dontdiff linux-2.6.4-uml-1/arch/um/kernel/time.c linux-2.6.4-uml-1-t1/arch/um/kernel/time.c
--- linux-2.6.4-uml-1/arch/um/kernel/time.c	2004-03-14 16:58:33.000000000 -0800
+++ linux-2.6.4-uml-1-t1/arch/um/kernel/time.c	2004-03-31 15:57:59.000000000 -0800
@@ -23,14 +23,17 @@
  */
 extern struct timespec wall_to_monotonic;
 
-extern struct timeval xtime;
-
 struct timeval local_offset = { 0, 0 };
 
-void timer(void)
+/*
+ * This is just a way to cross user-kernel boundary.
+ * For the moment, it is almost the same as do_gettimeofday, but non-locking.
+ * It may get different if guest time ever diverges from host time.
+ */
+void timer(struct timeval *tv)
 {
-	gettimeofday(&xtime, NULL);
-	timeradd(&xtime, &local_offset, &xtime);
+	gettimeofday(tv, NULL);
+	timeradd(tv, &local_offset, tv);
 }
 
 void set_interval(int timer_type)
@@ -53,6 +56,26 @@
 		       errno);
 }
 
+void enable_hz_timer(int delta_usec)
+{
+	struct itimerval enable = ((struct itimerval) { { 0, 1000000/hz() },
+							{ 0, delta_usec }});
+	if(setitimer(ITIMER_REAL, &enable, NULL))
+		printk("enable_hz_timer - setitimer failed, errno = %d\n",
+		       errno);
+}
+
+void disable_hz_timer(struct timeval *delta)
+{
+	struct itimerval enable;
+
+	enable.it_interval = ((struct timeval) { 0, 0 });
+	enable.it_value = *delta;
+	if(setitimer(ITIMER_REAL, &enable, NULL))
+		printk("disable_hz_timer - setitimer failed, errno = %d\n",
+		       errno);
+}
+
 void switch_timers(int to_real)
 {
 	struct itimerval disable = ((struct itimerval) { { 0, 0 }, { 0, 0 }});
@@ -171,13 +194,9 @@
 	return(0);
 }
 
-void idle_sleep(int secs)
+void idle_sleep(void)
 {
-	struct timespec ts;
-
-	ts.tv_sec = secs;
-	ts.tv_nsec = 0;
-	nanosleep(&ts, NULL);
+	pause();
 }
 
 /*
diff -ur -X dontdiff linux-2.6.4-uml-1/arch/um/kernel/time_kern.c linux-2.6.4-uml-1-t1/arch/um/kernel/time_kern.c
--- linux-2.6.4-uml-1/arch/um/kernel/time_kern.c	2004-03-14 16:58:33.000000000 -0800
+++ linux-2.6.4-uml-1-t1/arch/um/kernel/time_kern.c	2004-04-01 15:50:01.000000000 -0800
@@ -3,6 +3,7 @@
  * Licensed under the GPL
  */
 
+#include "linux/config.h"
 #include "linux/kernel.h"
 #include "linux/module.h"
 #include "linux/unistd.h"
@@ -41,6 +42,22 @@
 /* Changed at early boot */
 int timer_irq_inited = 0;
 
+#ifdef CONFIG_NO_IDLE_HZ
+
+#ifdef CONFIG_NO_IDLE_HZ_INIT
+int sysctl_hz_timer = 0;
+#else
+int sysctl_hz_timer = 1;
+#endif
+
+/*
+ * This is terribly non-SMP, but we take timer ticks on CPU0 currently anyway.
+ * For symmetric processing, refer to the arch/s390/time.c implementation.
+ */
+int timer_ticking = 1;
+u64 timer_last_jiffy = 0;	/* Valid when !timer_ticking */
+#endif
+
 static int first_tick;
 static unsigned long long prev_tsc;
 static long long delta;   		/* Deviation per interval */
@@ -97,10 +114,13 @@
 irqreturn_t um_timer(int irq, void *dev, struct pt_regs *regs)
 {
 	unsigned long flags;
+	struct timeval timeb;
 
 	do_timer(regs);
 	write_seqlock_irqsave(&xtime_lock, flags);
-	timer();
+	timer(&timeb);
+	xtime.tv_sec = timeb.tv_sec;
+	xtime.tv_nsec = timeb.tv_usec * 1000;
 	write_sequnlock_irqrestore(&xtime_lock, flags);
 	return(IRQ_HANDLED);
 }
@@ -202,6 +222,119 @@
 
 __initcall(timer_init);
 
+#ifdef CONFIG_NO_IDLE_HZ
+
+/*
+ * Start the HZ tick on the current CPU.
+ * The cpu_idle used to call this function, but a monitor call does it now.
+ */
+void start_hz_timer(void)
+{
+	struct timeval timeb;
+	signed long delta_sec, delta_nsec;
+	unsigned int ticks;
+	unsigned long flags;
+
+	if (sysctl_hz_timer != 0)
+		return;
+
+	/* disable monitor call */
+	timer_ticking = 1;
+
+	/* irq_enter(smp_processor_id(), 0); */ /* Not in arch/um */
+
+	write_seqlock_irqsave(&xtime_lock, flags);
+	timer(&timeb);
+
+	/* Calculate how many ticks have passed */
+	delta_sec = timeb.tv_sec - xtime.tv_sec;
+	if ((delta_nsec = timeb.tv_usec * 1000 - xtime.tv_nsec) < 0) {
+		delta_sec -= 1;
+		delta_nsec += 1000000000L;
+		if (delta_nsec < 0) {
+			/* This is BUG, but we hate BUGs in interrupts. */
+			delta_nsec = 0;
+		}
+	}
+	if (delta_sec <= 0)
+		ticks = 0;
+	else
+		ticks = delta_sec * HZ + delta_nsec / (1000000000/HZ);
+
+	/* Update xtime as in any normal timer interrupt */
+	/* Use an integral number of ticks */
+	xtime.tv_nsec += (ticks % HZ) * (1000000000/HZ);
+	if (xtime.tv_nsec >= 1000000000) {
+		xtime.tv_nsec -= 1000000000;
+		xtime.tv_sec += 1;
+	}
+	xtime.tv_sec += ticks / HZ;
+
+	/* Set the clock comparator to the next tick. */
+	if ((delta_nsec = timeb.tv_usec * 1000 - xtime.tv_nsec) < 0) {
+		delta_nsec += 1000000000L;
+		if (delta_nsec > (1000000000/HZ)) {
+			/* This is BUG, but we hate BUGs in interrupts. */
+			delta_nsec = (1000000000/HZ);
+		}
+	}
+	enable_hz_timer((delta_nsec + 999) / 1000);
+
+	write_sequnlock_irqrestore(&xtime_lock, flags);
+
+	/* Charge the ticks. */
+	if (ticks > 0) {
+		do_timer_ticks(ticks);
+	}
+
+	/* irq_exit(smp_processor_id(), 0); */ /* Not in um */
+}
+
+/*
+ * Stop the HZ tick on the current CPU.
+ * Only cpu_idle may call this function. The next_timer_event() does the
+ * heavy lifting, so should not be called if we have anything better to do.
+ */
+void stop_hz_timer(void)
+{
+	struct timeval deltaval;
+	unsigned int delta_jiffies;
+	unsigned long flags;
+	void *tfn;	/* For future readings from /proc */
+
+	if (sysctl_hz_timer != 0)
+		return;
+
+	/*
+	 * XXX Martin mentions a race with testing if(need_resched())
+	 * in the idle loop... Not sure what the problem is there.
+	 * The s390 has this outside of stop_hz_timer().
+	 */
+	local_irq_save(flags);
+
+	/* 
+	 * This cpu is going to sleep. Setup the clock
+	 * comparator for the next event if nothing on tq_timer
+	 * is pending.
+	 *
+	 * Classic code did if (!TQ_ACTIVE(tq_timer)) here.
+	 * The if (delta_jiffies > 1) should take care of it.
+	 */
+	delta_jiffies = next_timer_event(&tfn) - jiffies;
+	if (delta_jiffies > 1) {
+		deltaval.tv_sec = delta_jiffies / HZ;
+		deltaval.tv_usec = (delta_jiffies % HZ) * (1000000/HZ);
+		disable_hz_timer(&deltaval);
+	}
+
+	/* enable monitor call */
+	timer_ticking = 0;
+
+	local_irq_restore(flags);
+}
+
+#endif
+
 /*
  * Overrides for Emacs so that we follow Linus's tabbing style.
  * Emacs will notice this stuff at the end of the file and automatically
diff -ur -X dontdiff linux-2.6.4-uml-1/include/asm-um/system-generic.h linux-2.6.4-uml-1-t1/include/asm-um/system-generic.h
--- linux-2.6.4-uml-1/include/asm-um/system-generic.h	2004-03-14 16:58:34.000000000 -0800
+++ linux-2.6.4-uml-1-t1/include/asm-um/system-generic.h	2004-03-29 23:19:59.000000000 -0800
@@ -45,3 +45,13 @@
 #define switch_to(prev, next, last) prev = _switch_to(prev, next, last)
 
 #endif
+
+#ifdef CONFIG_NO_IDLE_HZ
+extern void stop_hz_timer(void);
+extern void start_hz_timer(void);
+extern int timer_ticking;
+#else
+#define stop_hz_timer()		/* */
+#define start_hz_timer()	/* */
+#define timer_ticking   (0)
+#endif
diff -ur -X dontdiff linux-2.6.4-uml-1/include/linux/sched.h linux-2.6.4-uml-1-t1/include/linux/sched.h
--- linux-2.6.4-uml-1/include/linux/sched.h	2004-03-14 15:44:43.000000000 -0800
+++ linux-2.6.4-uml-1-t1/include/linux/sched.h	2004-03-29 23:19:59.000000000 -0800
@@ -166,6 +166,9 @@
 extern void cpu_init (void);
 extern void trap_init(void);
 extern void update_process_times(int user);
+#ifdef CONFIG_NO_IDLE_HZ
+extern void update_process_times_us(int user, int system);
+#endif
 extern void update_one_process(struct task_struct *p, unsigned long user,
 			       unsigned long system, int cpu);
 extern void scheduler_tick(int user_tick, int system);
@@ -598,6 +601,9 @@
 extern unsigned long itimer_ticks;
 extern unsigned long itimer_next;
 extern void do_timer(struct pt_regs *);
+#ifdef CONFIG_NO_IDLE_HZ
+extern void do_timer_ticks(int ticks);
+#endif
 
 extern int FASTCALL(wake_up_state(struct task_struct * tsk, unsigned int state));
 extern int FASTCALL(wake_up_process(struct task_struct * tsk));
diff -ur -X dontdiff linux-2.6.4-uml-1/include/linux/sysctl.h linux-2.6.4-uml-1-t1/include/linux/sysctl.h
--- linux-2.6.4-uml-1/include/linux/sysctl.h	2004-03-14 15:44:44.000000000 -0800
+++ linux-2.6.4-uml-1-t1/include/linux/sysctl.h	2004-03-29 23:19:59.000000000 -0800
@@ -131,6 +131,7 @@
 	KERN_PRINTK_RATELIMIT_BURST=61,	/* int: tune printk ratelimiting */
 	KERN_PTY=62,		/* dir: pty driver */
 	KERN_NGROUPS_MAX=63,	/* int: NGROUPS_MAX */
+	KERN_S390_HZ_TIMER=64,	/* int: hz timer on or off (not just s390) */
 };
 
 
diff -ur -X dontdiff linux-2.6.4-uml-1/include/linux/timer.h linux-2.6.4-uml-1-t1/include/linux/timer.h
--- linux-2.6.4-uml-1/include/linux/timer.h	2003-08-24 14:25:05.000000000 -0700
+++ linux-2.6.4-uml-1-t1/include/linux/timer.h	2004-04-01 15:48:31.000000000 -0800
@@ -94,4 +94,8 @@
 extern void run_local_timers(void);
 extern void it_real_fn(unsigned long);
 
+#ifdef CONFIG_NO_IDLE_HZ
+extern unsigned long next_timer_event(void **);
+#endif
+
 #endif
diff -ur -X dontdiff linux-2.6.4-uml-1/kernel/sysctl.c linux-2.6.4-uml-1-t1/kernel/sysctl.c
--- linux-2.6.4-uml-1/kernel/sysctl.c	2004-03-14 15:44:46.000000000 -0800
+++ linux-2.6.4-uml-1-t1/kernel/sysctl.c	2004-03-31 17:30:50.000000000 -0800
@@ -106,6 +106,9 @@
 #endif
 extern int sysctl_userprocess_debug;
 #endif
+#ifdef CONFIG_NO_IDLE_HZ	/* Not just s390 anymore */
+extern int sysctl_hz_timer;
+#endif
 
 #if defined(CONFIG_PPC32) && defined(CONFIG_6xx)
 extern unsigned long powersave_nap;
@@ -846,6 +849,16 @@
 		.mode		= 0644,
 		.proc_handler	= &proc_dointvec,
 	},
+#ifdef CONFIG_NO_IDLE_HZ
+	{
+		.ctl_name	= KERN_S390_HZ_TIMER,
+		.procname	= "hz_timer",
+		.data		= &sysctl_hz_timer,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= &proc_dointvec,
+	},
+#endif
 	{ .ctl_name = 0 }
 };
 
diff -ur -X dontdiff linux-2.6.4-uml-1/kernel/timer.c linux-2.6.4-uml-1-t1/kernel/timer.c
--- linux-2.6.4-uml-1/kernel/timer.c	2004-03-14 15:44:46.000000000 -0800
+++ linux-2.6.4-uml-1-t1/kernel/timer.c	2004-04-01 16:25:54.000000000 -0800
@@ -428,6 +428,146 @@
 	spin_unlock_irq(&base->lock);
 }
 
+#ifdef CONFIG_NO_IDLE_HZ
+
+/*
+ * Lock ordering direction is backwards, see __mod_timer().
+ */
+static inline void lock_all_bases(void)
+{
+	int i;
+	tvec_base_t *base;
+
+repeat:
+	i = NR_CPUS;
+	while (i != 0) {
+		--i;
+		if (!cpu_isset(i, cpu_online_map))
+			continue;
+		base = &per_cpu(tvec_bases, i);
+		if (!spin_trylock(&base->lock)) {
+			while (++i < NR_CPUS) {
+				if (cpu_isset(i, cpu_online_map)) {
+					base = &per_cpu(tvec_bases, i);
+					spin_unlock(&base->lock);
+				}
+			}
+			cpu_relax();
+			goto repeat;
+		}
+	}
+}
+
+static inline void unlock_all_bases(void)
+{
+	int cpuno;
+	tvec_base_t *base;
+
+	for_each_cpu(cpuno) {
+		base = &per_cpu(tvec_bases, cpuno);
+		spin_unlock(&base->lock);
+		base++;
+	}
+}
+
+static unsigned long scan_one_tvec(unsigned long expiry, int tvec_off,
+    void **fn)
+{
+	int cpuno;
+	int i;
+	tvec_base_t *base;
+	struct list_head *list, *p;
+	struct timer_list *timer;
+
+	for_each_cpu(cpuno) {
+		base = &per_cpu(tvec_bases, cpuno);
+
+		/*
+		 * This is gross. We intentionally go out of array bounds.
+		 */
+		list = base->tv2.vec + tvec_off;
+
+		for (i = 0; i < TVN_SIZE; i++) {
+			list_for_each(p, list + i) {
+				timer = list_entry(p, struct timer_list, entry);
+				if (time_before(timer->expires, expiry)) {
+					*fn = timer->function;
+					expiry = timer->expires;
+				}
+			}
+		}
+	}
+	return expiry;
+}
+
+/*
+ * Find out when the next timer event is due to happen. This
+ * is used on S/390 to stop all activity when all cpus are idle.
+ * This is called with all locks relevant to stop_hz_timer taken
+ * and interrupts closed, but it has to take locks in tvecs.
+ *
+ * Scan first 256 jiffies on all CPUs, then next 63*256 jiffies, etc.
+ *
+ * The function pointer is returned for the benefit of diagnostic code.
+ * Do not try to call it or anything so crazy.
+ *
+ * We do not return a timer_list pointer because it would push its
+ * locking outside of this module, and we really do not want it.
+ *
+ * XXX The horizon is a stupid idea. It can cause all guests to convoy
+ * and suddenly thrash an otherwise idle host. Return "found nothing" instead.
+ */
+unsigned long next_timer_event(void **fn)
+{
+	int cpuno;
+	int i;
+	tvec_base_t *base;
+	unsigned long next_expiry, horizon;
+	struct list_head *p;
+	struct timer_list *timer;
+
+	lock_all_bases();
+
+	*fn = NULL;
+	horizon = jiffies + 1*24*60*60*HZ;	/* 1 day horizon */
+	next_expiry = horizon;
+
+	for_each_cpu(cpuno) {
+		base = &per_cpu(tvec_bases, cpuno);
+		for (i = 0; i < TVR_SIZE; i++) {
+			list_for_each(p, base->tv1.vec + i) {
+				timer = list_entry(p, struct timer_list, entry);
+				if (time_before(timer->expires, next_expiry)) {
+					*fn = timer->function;
+					next_expiry = timer->expires;
+				}
+			}
+		}
+	}
+
+	for (i = 0; i < 4; i++) {
+
+		/*
+		 * Premature optimization is the root of all evil, but...
+		 */
+		if (time_after_eq(next_expiry, jiffies + 1))
+			break;
+
+		/*
+		 * Found something, no reason to do higher bits,
+		 * whatever it is, it is going to be later than what we have.
+		 */
+		if (next_expiry != horizon)
+			break;
+
+		next_expiry = scan_one_tvec(next_expiry, i*TVN_SIZE, fn);
+	}
+
+	unlock_all_bases();
+	return next_expiry;
+}
+#endif /* CONFIG_NO_IDLE_HZ */
+
 /******************************************************************/
 
 /*
@@ -674,7 +814,7 @@
 		update_wall_time_one_tick();
 	} while (ticks);
 
-	if (xtime.tv_nsec >= 1000000000) {
+	while (xtime.tv_nsec >= 1000000000) {
 	    xtime.tv_nsec -= 1000000000;
 	    xtime.tv_sec++;
 	    time_interpolator_update(NSEC_PER_SEC);
@@ -749,6 +889,20 @@
 }
 
 /*
+ * Called from the timer interrupt handler to charge a couple of ticks
+ * to the current process.
+ */
+void update_process_times_us(int user_ticks, int system_ticks)
+{
+	struct task_struct *p = current;
+	int cpu = smp_processor_id();
+
+	update_one_process(p, user_ticks, system_ticks, cpu);
+	run_local_timers();
+	scheduler_tick(user_ticks, system_ticks);
+}
+
+/*
  * Nr of active tasks - counted in fixed-point numbers
  */
 static unsigned long count_active_tasks(void)
@@ -776,7 +930,7 @@
 	static int count = LOAD_FREQ;
 
 	count -= ticks;
-	if (count < 0) {
+	while (count < 0) {
 		count += LOAD_FREQ;
 		active_tasks = count_active_tasks();
 		CALC_LOAD(avenrun[0], EXP_1, active_tasks);
@@ -850,6 +1004,15 @@
 	update_times();
 }
 
+void do_timer_ticks(int ticks)
+{
+	jiffies_64 += ticks;
+#ifndef CONFIG_SMP
+	update_process_times_us(0, ticks);
+#endif
+	update_times();
+}
+
 #if !defined(__alpha__) && !defined(__ia64__)
 
 /*


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
