Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <thomas@m3y3r.de>) id 1YrDxD-00028k-9K
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 09 May 2015 23:14:43 +0000
Received: from www17.your-server.de ([213.133.104.17])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1YrDx9-0004Fx-4j
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 09 May 2015 23:14:43 +0000
Received: from [217.255.202.154] (helo=localhost.localdomain)
	by www17.your-server.de with esmtpsa
	(TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256) (Exim 4.80.1)
	(envelope-from <thomas@m3y3r.de>) id 1YrDx0-0001b8-Fe
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 10 May 2015 01:14:32 +0200
Message-ID: <1431213268.603436.33.camel@m3y3r.de>
From: Thomas Meyer <thomas@m3y3r.de>
Date: Sun, 10 May 2015 01:14:28 +0200
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
Subject: [uml-devel] [PATCH v6] um: Add a high resolution timer subsystem
To: user-mode-linux-devel <user-mode-linux-devel@lists.sourceforge.net>

Hi,

Changes:
- also create posix timer in stub_clone_handler()
- incorporated antons remarks


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
diff --git a/arch/um/include/asm/irq.h b/arch/um/include/asm/irq.h
index 4a2037f..0f2a5b1 100644
--- a/arch/um/include/asm/irq.h
+++ b/arch/um/include/asm/irq.h
@@ -16,8 +16,9 @@
 #define TELNETD_IRQ 		12
 #define XTERM_IRQ 		13
 #define RANDOM_IRQ 		14
+#define HRTIMER_IRQ		15
 
-#define LAST_IRQ RANDOM_IRQ
+#define LAST_IRQ HRTIMER_IRQ
 #define NR_IRQS (LAST_IRQ + 1)
 
 #endif
diff --git a/arch/um/include/shared/as-layout.h b/arch/um/include/shared/as-layout.h
index ca1843e..798aa6e 100644
--- a/arch/um/include/shared/as-layout.h
+++ b/arch/um/include/shared/as-layout.h
@@ -17,7 +17,7 @@
 
 /* Some constant macros are used in both assembler and
  * C code.  Therefore we cannot annotate them always with
- * 'UL' and other type specifiers unilaterally.  We
+ * 'UL' and other type specifiers unilaterally. We
  * use the following macros to deal with this.
  */
 
@@ -28,6 +28,13 @@
 #define _UML_AC(X, Y)	__UML_AC(X, Y)
 #endif
 
+/**
+ * userspace stub address space layout:
+ * Below macros define the layout of the stub code and data
+ * which are mapped in each userspace process:
+ *  - one page of code located at 0x100000 followed by
+ *  - one page of data
+ */
 #define STUB_START _UML_AC(, 0x100000)
 #define STUB_CODE _UML_AC((unsigned long), STUB_START)
 #define STUB_DATA _UML_AC((unsigned long), STUB_CODE + UM_KERN_PAGE_SIZE)
diff --git a/arch/um/include/shared/kern_util.h b/arch/um/include/shared/kern_util.h
index 83a91f9..0282b36 100644
--- a/arch/um/include/shared/kern_util.h
+++ b/arch/um/include/shared/kern_util.h
@@ -37,6 +37,7 @@ extern void initial_thread_cb(void (*proc)(void *), void *arg);
 extern int is_syscall(unsigned long addr);
 
 extern void timer_handler(int sig, struct siginfo *unused_si, struct uml_pt_regs *regs);
+extern void hrtimer_handler(int sig, struct siginfo *unused_si, struct uml_pt_regs *regs);
 
 extern int start_uml(void);
 extern void paging_init(void);
diff --git a/arch/um/include/shared/os.h b/arch/um/include/shared/os.h
index d824528..7f7368b 100644
--- a/arch/um/include/shared/os.h
+++ b/arch/um/include/shared/os.h
@@ -217,7 +217,8 @@ extern int set_umid(char *name);
 extern char *get_umid(void);
 
 /* signal.c */
-extern void timer_init(void);
+extern void uml_timer_set_signal_handler(void);
+extern void uml_hrtimer_set_signal_handler(void);
 extern void set_sigstack(void *sig_stack, int size);
 extern void remove_sigstack(void);
 extern void set_handler(int sig);
@@ -238,12 +239,16 @@ extern void um_early_printk(const char *s, unsigned int n);
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
-	long offset;
+	unsigned long offset;
 	int fd;
-	struct itimerval timer;
+	struct itimerspec timer;
 	long err;
 };
 
diff --git a/arch/um/include/shared/timer-internal.h b/arch/um/include/shared/timer-internal.h
new file mode 100644
index 0000000..afdc6dc
--- /dev/null
+++ b/arch/um/include/shared/timer-internal.h
@@ -0,0 +1,18 @@
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
+extern void timer_lock(void);
+extern void timer_unlock(void);
+
+extern long long hrtimer_disable(void);
+
+#endif
diff --git a/arch/um/kernel/irq.c b/arch/um/kernel/irq.c
index 23cb935..4c1966a 100644
--- a/arch/um/kernel/irq.c
+++ b/arch/um/kernel/irq.c
@@ -338,20 +338,20 @@ static struct irq_chip normal_irq_type = {
 	.irq_unmask = dummy,
 };
 
-static struct irq_chip SIGVTALRM_irq_type = {
-	.name = "SIGVTALRM",
-	.irq_disable = dummy,
-	.irq_enable = dummy,
-	.irq_ack = dummy,
-	.irq_mask = dummy,
-	.irq_unmask = dummy,
+static struct irq_chip SIGUSR2_irq_type = {
+       .name = "SIGUSR2",
+       .irq_disable = dummy,
+       .irq_enable = dummy,
+       .irq_ack = dummy,
+       .irq_mask = dummy,
+       .irq_unmask = dummy,
 };
 
 void __init init_IRQ(void)
 {
 	int i;
 
-	irq_set_chip_and_handler(TIMER_IRQ, &SIGVTALRM_irq_type, handle_edge_irq);
+	irq_set_chip_and_handler(HRTIMER_IRQ, &SIGUSR2_irq_type, handle_edge_irq);
 
 	for (i = 1; i < NR_IRQS; i++)
 		irq_set_chip_and_handler(i, &normal_irq_type, handle_edge_irq);
diff --git a/arch/um/kernel/physmem.c b/arch/um/kernel/physmem.c
index 9034fc8..5f6642d 100644
--- a/arch/um/kernel/physmem.c
+++ b/arch/um/kernel/physmem.c
@@ -119,14 +119,23 @@ void __init setup_physmem(unsigned long start, unsigned long reserve_end,
 		     len - bootmap_size - reserve);
 }
 
+/**
+ * phys_mapping() - maps a physical address to an offset address
+ * phys:    the physical address
+ * offset_out:  the offset in the memory map area
+ *
+ * Returns an file descriptor, or -1 when unknown physical address
+ */
 int phys_mapping(unsigned long phys, unsigned long long *offset_out)
 {
 	int fd = -1;
 
+	/* first check normal memory */
 	if (phys < physmem_size) {
 		fd = physmem_fd;
 		*offset_out = phys;
 	}
+	/* than check io memory */
 	else if (phys < __pa(end_iomem)) {
 		struct iomem_region *region = iomem_regions;
 
@@ -140,6 +149,7 @@ int phys_mapping(unsigned long phys, unsigned long long *offset_out)
 			region = region->next;
 		}
 	}
+	/* last check highmem */
 	else if (phys < __pa(end_iomem) + highmem) {
 		fd = physmem_fd;
 		*offset_out = phys - iomem_size;
diff --git a/arch/um/kernel/process.c b/arch/um/kernel/process.c
index 68b9119..b8a8d10 100644
--- a/arch/um/kernel/process.c
+++ b/arch/um/kernel/process.c
@@ -27,6 +27,7 @@
 #include <kern_util.h>
 #include <os.h>
 #include <skas.h>
+#include <timer-internal.h>
 
 /*
  * This is a per-cpu array.  A processor only modifies its entry and it only
@@ -201,12 +202,8 @@ void initial_thread_cb(void (*proc)(void *), void *arg)
 
 void arch_cpu_idle(void)
 {
-	unsigned long long nsecs;
-
 	cpu_tasks[current_thread_info()->cpu].pid = os_getpid();
-	nsecs = disable_timer();
-	idle_sleep(nsecs);
-	local_irq_enable();
+	os_idle_sleep(UM_NSEC_PER_SEC / UM_HZ);
 }
 
 int __cant_sleep(void) {
diff --git a/arch/um/kernel/skas/clone.c b/arch/um/kernel/skas/clone.c
index 289771d..5f283b1 100644
--- a/arch/um/kernel/skas/clone.c
+++ b/arch/um/kernel/skas/clone.c
@@ -20,37 +20,63 @@
  * on some systems.
  */
 
+/**
+ * stub_clone_handler() - userspace clone handler stub
+ *
+ * this stub clone hanlder is mmaped(?)/available in all userspace
+ * processes. It's used to copy an mm context from an fork syscall in the
+ * traced userspace process
+ */
 void __attribute__ ((__section__ (".__syscall_stub")))
 stub_clone_handler(void)
 {
 	struct stub_data *data = (struct stub_data *) STUB_DATA;
+	struct sigevent sev;
+	timer_t timerid;
 	long err;
 
+	/* clone "from" process */
 	err = stub_syscall2(__NR_clone, CLONE_PARENT | CLONE_FILES | SIGCHLD,
 			    STUB_DATA + UM_KERN_PAGE_SIZE / 2 - sizeof(void *));
-	if (err != 0)
+	/* Parent: exit here, child, continue */
+	if (err != 0) {
 		goto out;
+	}
 
+	/* set child to ptrace */
 	err = stub_syscall4(__NR_ptrace, PTRACE_TRACEME, 0, 0, 0);
 	if (err)
 		goto out;
 
-	err = stub_syscall3(__NR_setitimer, ITIMER_VIRTUAL,
-			    (long) &data->timer, 0);
+	/* create a new posix interval timer */
+	sev.sigev_notify = SIGEV_SIGNAL;
+	sev.sigev_signo = SIGUSR2;
+	sev.sigev_value.sival_ptr = NULL;
+
+	err = stub_syscall3(__NR_timer_create, CLOCK_MONOTONIC,
+				(long) &sev, (long) &timerid);
 	if (err)
 		goto out;
 
+	/* set interval to the given value from copy_context_skas0() */
+	err = stub_syscall4(__NR_timer_settime, (long) timerid, 0l,
+						(long) &data->timer, 0l);
+	if (err)
+		goto out;
+
+	/* switch to new stack */
 	remap_stack(data->fd, data->offset);
 	goto done;
 
  out:
 	/*
-	 * save current result.
-	 * Parent: pid;
-	 * child: retcode of mmap already saved and it jumps around this
-	 * assignment
+	 * Save current result.
+	 * - Parent: pid from clone() call
+	 * - Child:  "retcode of mmap already saved and it jumps around this
+	 *            assignment"???
 	 */
 	data->err = err;
+
  done:
 	trap_myself();
 }
diff --git a/arch/um/kernel/skas/mmu.c b/arch/um/kernel/skas/mmu.c
index 94abdcc..df9c9ab 100644
--- a/arch/um/kernel/skas/mmu.c
+++ b/arch/um/kernel/skas/mmu.c
@@ -47,6 +47,13 @@ static int init_stub_pte(struct mm_struct *mm, unsigned long proc,
 	return -ENOMEM;
 }
 
+/**
+ * init_new_context() - creates or copies an mm context
+ * @task:	the belonging task
+ * @mm:		the mm struct to be setup/allocated
+ *
+ * called by mm_init() (kernel/fork.c)
+ */
 int init_new_context(struct task_struct *task, struct mm_struct *mm)
 {
  	struct mm_context *from_mm = NULL;
@@ -59,13 +66,15 @@ int init_new_context(struct task_struct *task, struct mm_struct *mm)
 		goto out;
 
 	to_mm->id.stack = stack;
-	if (current->mm != NULL && current->mm != &init_mm)
+	if (current->mm != NULL && current->mm != &init_mm) {
 		from_mm = &current->mm->context;
+	}
 
-	if (from_mm)
-		to_mm->id.u.pid = copy_context_skas0(stack,
-						     from_mm->id.u.pid);
-	else to_mm->id.u.pid = start_userspace(stack);
+	if (from_mm) {
+		to_mm->id.u.pid = copy_context_skas0(stack, from_mm->id.u.pid);
+	} else {
+		to_mm->id.u.pid = start_userspace(stack);
+	}
 
 	if (to_mm->id.u.pid < 0) {
 		ret = to_mm->id.u.pid;
diff --git a/arch/um/kernel/skas/process.c b/arch/um/kernel/skas/process.c
index 527fa58..2b0c35a 100644
--- a/arch/um/kernel/skas/process.c
+++ b/arch/um/kernel/skas/process.c
@@ -43,6 +43,9 @@ int __init start_uml(void)
 				 &init_task.thread.switch_buf);
 }
 
+/**
+ * current_stub_stack() - returns the address of the current mm stack
+ */
 unsigned long current_stub_stack(void)
 {
 	if (current->mm == NULL)
diff --git a/arch/um/kernel/time.c b/arch/um/kernel/time.c
index 117568d..ed64037 100644
--- a/arch/um/kernel/time.c
+++ b/arch/um/kernel/time.c
@@ -1,4 +1,5 @@
 /*
+ * Copyright (C) 2012-2014 Cisco Systems
  * Copyright (C) 2000 - 2007 Jeff Dike (jdike@{addtoit,linux.intel}.com)
  * Licensed under the GPL
  */
@@ -8,32 +9,36 @@
 #include <linux/interrupt.h>
 #include <linux/jiffies.h>
 #include <linux/threads.h>
+#include <linux/spinlock.h>
 #include <asm/irq.h>
 #include <asm/param.h>
 #include <kern_util.h>
 #include <os.h>
+#include <timer-internal.h>
 
-void timer_handler(int sig, struct siginfo *unused_si, struct uml_pt_regs *regs)
+void hrtimer_handler(int sig, struct siginfo *unused_si, struct uml_pt_regs *regs)
 {
 	unsigned long flags;
 
 	local_irq_save(flags);
-	do_IRQ(TIMER_IRQ, regs);
+	do_IRQ(HRTIMER_IRQ, regs);
 	local_irq_restore(flags);
 }
 
-static void itimer_set_mode(enum clock_event_mode mode,
+static void timer_set_mode(enum clock_event_mode mode,
 			    struct clock_event_device *evt)
 {
 	switch (mode) {
 	case CLOCK_EVT_MODE_PERIODIC:
-		set_interval();
+		os_timer_set_interval(NULL, NULL);
 		break;
 
+	case CLOCK_EVT_MODE_ONESHOT:
+		os_timer_one_shot(1);
+
 	case CLOCK_EVT_MODE_SHUTDOWN:
 	case CLOCK_EVT_MODE_UNUSED:
-	case CLOCK_EVT_MODE_ONESHOT:
-		disable_timer();
+		os_timer_disable();
 		break;
 
 	case CLOCK_EVT_MODE_RESUME:
@@ -41,68 +46,74 @@ static void itimer_set_mode(enum clock_event_mode mode,
 	}
 }
 
-static int itimer_next_event(unsigned long delta,
+static int timer_next_event(unsigned long delta,
 			     struct clock_event_device *evt)
 {
-	return timer_one_shot(delta + 1);
+	return os_timer_one_shot(delta);
 }
 
-static struct clock_event_device itimer_clockevent = {
-	.name		= "itimer",
+static struct clock_event_device timer_clockevent = {
+	.name		= "timer",
 	.rating		= 250,
 	.cpumask	= cpu_all_mask,
 	.features	= CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT,
-	.set_mode	= itimer_set_mode,
-	.set_next_event = itimer_next_event,
-	.shift		= 32,
+	.set_mode	= timer_set_mode,
+	.set_next_event = timer_next_event,
+	.shift		= 0,
+	.max_delta_ns	= 0xffffffff,
+	.min_delta_ns	= TIMER_MIN_DELTA, //microsecond resolution should be enough for anyone, same as 640K RAM
 	.irq		= 0,
+	.mult		= 1,
 };
 
-static irqreturn_t um_timer(int irq, void *dev)
+static irqreturn_t um_timer_irq(int irq, void *dev)
 {
-	(*itimer_clockevent.event_handler)(&itimer_clockevent);
+	(*timer_clockevent.event_handler)(&timer_clockevent);
 
 	return IRQ_HANDLED;
 }
 
-static cycle_t itimer_read(struct clocksource *cs)
+static cycle_t timer_read(struct clocksource *cs)
 {
-	return os_nsecs() / 1000;
+	return os_nsecs() / TIMER_MULTIPLIER;
 }
 
-static struct clocksource itimer_clocksource = {
-	.name		= "itimer",
+static struct clocksource timer_clocksource = {
+	.name		= "timer",
 	.rating		= 300,
-	.read		= itimer_read,
+	.read		= timer_read,
 	.mask		= CLOCKSOURCE_MASK(64),
 	.flags		= CLOCK_SOURCE_IS_CONTINUOUS,
 };
 
-static void __init setup_itimer(void)
+static void __init timer_setup(void)
 {
 	int err;
 
-	err = request_irq(TIMER_IRQ, um_timer, 0, "timer", NULL);
-	if (err != 0)
+	err = request_irq(HRTIMER_IRQ, um_timer_irq, IRQF_TIMER, "hr timer", NULL);
+	if (err != 0) {
 		printk(KERN_ERR "register_timer : request_irq failed - "
 		       "errno = %d\n", -err);
+		return;
+    }
+
+    err = os_timer_create(NULL);
+    if (err != 0) {
+        printk(KERN_ERR "creation of timer failed - errno = %d\n", -err);
+        return;
+    }
 
-	itimer_clockevent.mult = div_sc(HZ, NSEC_PER_SEC, 32);
-	itimer_clockevent.max_delta_ns =
-		clockevent_delta2ns(60 * HZ, &itimer_clockevent);
-	itimer_clockevent.min_delta_ns =
-		clockevent_delta2ns(1, &itimer_clockevent);
-	err = clocksource_register_hz(&itimer_clocksource, USEC_PER_SEC);
+	err = clocksource_register_hz(&timer_clocksource, NSEC_PER_SEC/TIMER_MULTIPLIER);
 	if (err) {
 		printk(KERN_ERR "clocksource_register_hz returned %d\n", err);
 		return;
 	}
-	clockevents_register_device(&itimer_clockevent);
+	clockevents_register_device(&timer_clockevent);
 }
 
 void read_persistent_clock(struct timespec *ts)
 {
-	long long nsecs = os_nsecs();
+	long long nsecs = os_persistent_clock_emulation();
 
 	set_normalized_timespec(ts, nsecs / NSEC_PER_SEC,
 				nsecs % NSEC_PER_SEC);
@@ -110,6 +121,6 @@ void read_persistent_clock(struct timespec *ts)
 
 void __init time_init(void)
 {
-	timer_init();
-	late_time_init = setup_itimer;
+	uml_hrtimer_set_signal_handler();
+	late_time_init = timer_setup;
 }
diff --git a/arch/um/os-Linux/internal.h b/arch/um/os-Linux/internal.h
deleted file mode 100644
index 0dc2c9f..0000000
--- a/arch/um/os-Linux/internal.h
+++ /dev/null
@@ -1 +0,0 @@
-void alarm_handler(int sig, struct siginfo *unused_si, mcontext_t *mc);
diff --git a/arch/um/os-Linux/main.c b/arch/um/os-Linux/main.c
index df9191a..bd5907e 100644
--- a/arch/um/os-Linux/main.c
+++ b/arch/um/os-Linux/main.c
@@ -168,8 +168,8 @@ int __init main(int argc, char **argv, char **envp)
 	 * some time) and cause a segfault.
 	 */
 
-	/* stop timers and set SIGVTALRM to be ignored */
-	disable_timer();
+	/* stop timers and set timer signal to be ignored */
+	os_timer_disable();
 
 	/* disable SIGIO for the fds and set SIGIO to be ignored */
 	err = deactivate_all_fds();
diff --git a/arch/um/os-Linux/signal.c b/arch/um/os-Linux/signal.c
index 7b605e4..ee6db2e 100644
--- a/arch/um/os-Linux/signal.c
+++ b/arch/um/os-Linux/signal.c
@@ -13,7 +13,6 @@
 #include <kern_util.h>
 #include <os.h>
 #include <sysdep/mcontext.h>
-#include "internal.h"
 
 void (*sig_info[NSIG])(int, struct siginfo *, struct uml_pt_regs *) = {
 	[SIGTRAP]	= relay_signal,
@@ -23,7 +22,8 @@ void (*sig_info[NSIG])(int, struct siginfo *, struct uml_pt_regs *) = {
 	[SIGBUS]	= bus_handler,
 	[SIGSEGV]	= segv_handler,
 	[SIGIO]		= sigio_handler,
-	[SIGVTALRM]	= timer_handler };
+	[SIGUSR2]	= hrtimer_handler
+};
 
 static void sig_handler_common(int sig, struct siginfo *si, mcontext_t *mc)
 {
@@ -38,7 +38,7 @@ static void sig_handler_common(int sig, struct siginfo *si, mcontext_t *mc)
 	}
 
 	/* enable signals if sig isn't IRQ signal */
-	if ((sig != SIGIO) && (sig != SIGWINCH) && (sig != SIGVTALRM))
+	if ((sig != SIGIO) && (sig != SIGWINCH) && (sig != SIGVTALRM) && (sig != SIGUSR2))
 		unblock_signals();
 
 	(*sig_info[sig])(sig, si, &r);
@@ -55,8 +55,8 @@ static void sig_handler_common(int sig, struct siginfo *si, mcontext_t *mc)
 #define SIGIO_BIT 0
 #define SIGIO_MASK (1 << SIGIO_BIT)
 
-#define SIGVTALRM_BIT 1
-#define SIGVTALRM_MASK (1 << SIGVTALRM_BIT)
+#define SIGUSR2_BIT 2
+#define SIGUSR2_MASK (1 << SIGUSR2_BIT)
 
 static int signals_enabled;
 static unsigned int signals_pending;
@@ -78,46 +78,47 @@ void sig_handler(int sig, struct siginfo *si, mcontext_t *mc)
 	set_signals(enabled);
 }
 
-static void real_alarm_handler(mcontext_t *mc)
+static void real_hralarm_handler(mcontext_t *mc)
 {
 	struct uml_pt_regs regs;
 
 	if (mc != NULL)
 		get_regs_from_mc(&regs, mc);
 	regs.is_user = 0;
-	unblock_signals();
-	timer_handler(SIGVTALRM, NULL, &regs);
+	hrtimer_handler(SIGUSR2, NULL, &regs);
 }
 
-void alarm_handler(int sig, struct siginfo *unused_si, mcontext_t *mc)
+void hralarm_handler(int sig, struct siginfo *unused_si, mcontext_t *mc)
 {
 	int enabled;
 
 	enabled = signals_enabled;
 	if (!signals_enabled) {
-		signals_pending |= SIGVTALRM_MASK;
+		signals_pending |= SIGUSR2_MASK;
 		return;
 	}
 
 	block_signals();
-
-	real_alarm_handler(mc);
+	real_hralarm_handler(mc);
 	set_signals(enabled);
 }
 
-void timer_init(void)
+void uml_hrtimer_set_signal_handler(void)
 {
-	set_handler(SIGVTALRM);
+	set_handler(SIGUSR2);
 }
 
 void set_sigstack(void *sig_stack, int size)
 {
-	stack_t stack = ((stack_t) { .ss_flags	= 0,
-				     .ss_sp	= (__ptr_t) sig_stack,
-				     .ss_size 	= size - sizeof(void *) });
+	stack_t stack = ((stack_t) {
+	            .ss_flags = 0,
+				.ss_sp    = (__ptr_t) sig_stack,
+				.ss_size  = size - sizeof(void *)
+	});
 
-	if (sigaltstack(&stack, NULL) != 0)
+	if (sigaltstack(&stack, NULL) != 0) {
 		panic("enabling signal stack failed, errno = %d\n", errno);
+	}
 }
 
 static void (*handlers[_NSIG])(int sig, struct siginfo *si, mcontext_t *mc) = {
@@ -129,10 +130,9 @@ static void (*handlers[_NSIG])(int sig, struct siginfo *si, mcontext_t *mc) = {
 
 	[SIGIO] = sig_handler,
 	[SIGWINCH] = sig_handler,
-	[SIGVTALRM] = alarm_handler
+	[SIGUSR2] = hralarm_handler
 };
 
-
 static void hard_handler(int sig, siginfo_t *si, void *p)
 {
 	struct ucontext *uc = p;
@@ -176,6 +176,13 @@ static void hard_handler(int sig, siginfo_t *si, void *p)
 	} while (pending);
 }
 
+/**
+ * set_handler() - enable signal in process' signal mask
+ * @sig:    The signal to enable
+ *
+ * Enable the given signal in the process' signal mask and
+ * attach hard_handler() as handler routine
+ */
 void set_handler(int sig)
 {
 	struct sigaction action;
@@ -186,9 +193,9 @@ void set_handler(int sig)
 
 	/* block irq ones */
 	sigemptyset(&action.sa_mask);
-	sigaddset(&action.sa_mask, SIGVTALRM);
 	sigaddset(&action.sa_mask, SIGIO);
 	sigaddset(&action.sa_mask, SIGWINCH);
+	sigaddset(&action.sa_mask, SIGUSR2);
 
 	if (sig == SIGSEGV)
 		flags |= SA_NODEFER;
@@ -281,8 +288,8 @@ void unblock_signals(void)
 		if (save_pending & SIGIO_MASK)
 			sig_handler_common(SIGIO, NULL, NULL);
 
-		if (save_pending & SIGVTALRM_MASK)
-			real_alarm_handler(NULL);
+		if (save_pending & SIGUSR2_MASK)
+			real_hralarm_handler(NULL);
 	}
 }
 
@@ -298,9 +305,11 @@ int set_signals(int enable)
 		return enable;
 
 	ret = signals_enabled;
-	if (enable)
+	if (enable) {
 		unblock_signals();
-	else block_signals();
+	} else {
+	    block_signals();
+    }
 
 	return ret;
 }
diff --git a/arch/um/os-Linux/skas/process.c b/arch/um/os-Linux/skas/process.c
index 7a97775..30065e1 100644
--- a/arch/um/os-Linux/skas/process.c
+++ b/arch/um/os-Linux/skas/process.c
@@ -45,7 +45,7 @@ static int ptrace_dump_regs(int pid)
  * Signals that are OK to receive in the stub - we'll just continue it.
  * SIGWINCH will happen when UML is inside a detached screen.
  */
-#define STUB_SIG_MASK ((1 << SIGVTALRM) | (1 << SIGWINCH))
+#define STUB_SIG_MASK ((1 << SIGVTALRM) | (1 << SIGWINCH) | (1 << SIGUSR2))
 
 /* Signals that the stub will finish with - anything else is an error */
 #define STUB_DONE_MASK (1 << SIGTRAP)
@@ -176,17 +176,59 @@ static void handle_trap(int pid, struct uml_pt_regs *regs,
 
 extern int __syscall_stub_start;
 
+/**
+ * userspace_tramp() - userspace trampoline
+ * @stack:  The address of the stub stack used for the new process
+ *          (used for SIGSEGV handling).
+ *
+ * The trampoline does execute as a new process after clone()
+ * For each new userspace process the below code sets up
+ * all necessary data:
+ * 1.) enable ptrace from parent (the uml kernel)
+ * 2.) Setup signal handling. Signals are inherited by the parent, i.e
+ *     the uml kernel
+ * 3.) Create and start an posix (interval) timer for this process.
+ *     This timer will emulate the kernel timer ticks.
+ *     The timer signal will be processed by the kernel process in userspace()
+ * 4.) Map stub code page in the new process, i.e. the
+ *     userspace process:
+ *     The stub codes is used to catch syscalls from the userspace to
+ *     the kernel.
+ *     See linker scripts arch/um/kernel/dyn.lds.S (dynamic) resp.
+ *                        arch/um/kernel/uml.lds.S (static)
+ *     for __syscall_stub_start defintion and
+ *     arch/um/kernel/skas/clone.c for the stub_handler itself.
+ * 5.) Map stub data page in the new process, i.e. the
+ *     userspace process:
+ *     Setup an SIGSEGV handler into the new process.
+ *     Page faults will be catched and signaled to the kernel via this
+ *     mechanism.
+ *     See arch/x86/um/stub_segv.c for the handler itself.
+ * 6.) Stop the new process and wait for the kernel to SIGCONT it agian
+ *     when it will get scheduled()
+ */
 static int userspace_tramp(void *stack)
 {
 	void *addr;
 	int err, fd;
 	unsigned long long offset;
+	timer_t timer;
+
+	struct stub_data *data = (struct stub_data *) stack;
 
 	ptrace(PTRACE_TRACEME, 0, 0, 0);
 
 	signal(SIGTERM, SIG_DFL);
 	signal(SIGWINCH, SIG_IGN);
-	err = set_interval();
+
+	err = os_timer_create(&timer);
+	if (err) {
+		printk(UM_KERN_ERR "userspace_tramp - creation of timer failed, "
+		       "errno = %d\n", err);
+		exit(1);
+	}
+
+	err = os_timer_set_interval(&timer, &data->timer);
 	if (err) {
 		printk(UM_KERN_ERR "userspace_tramp - setting timer failed, "
 		       "errno = %d\n", err);
@@ -246,11 +288,18 @@ static int userspace_tramp(void *stack)
 #define NR_CPUS 1
 int userspace_pid[NR_CPUS];
 
+/**
+ * start_userspace() - start a new userspace process with a new mm context
+ * @stub_stack: Address of the new process' stack
+ *
+ * called by init_new_context()
+ */
 int start_userspace(unsigned long stub_stack)
 {
 	void *stack;
 	unsigned long sp;
 	int pid, status, n, flags, err;
+	struct stub_data *data = (struct stub_data *) stub_stack;
 
 	stack = mmap(NULL, UM_KERN_PAGE_SIZE,
 		     PROT_READ | PROT_WRITE | PROT_EXEC,
@@ -266,6 +315,14 @@ int start_userspace(unsigned long stub_stack)
 
 	flags = CLONE_FILES | SIGCHLD;
 
+	*data = ((struct stub_data) { 
+			.timer  = ((struct itimerspec)
+				{ .it_value.tv_sec  = 0,
+				  .it_value.tv_nsec = os_timer_remain(NULL),
+				  .it_interval.tv_sec  = 0,
+				  .it_interval.tv_nsec = UM_NSEC_PER_SEC / UM_HZ })
+	});
+
 	pid = clone(userspace_tramp, (void *) sp, flags, (void *) stub_stack);
 	if (pid < 0) {
 		err = -errno;
@@ -313,10 +370,15 @@ int start_userspace(unsigned long stub_stack)
 	return err;
 }
 
+/**
+ * userspace() - user space control loop
+ * @regs:	the register's save memory
+ *
+ * The main loop that traces and controls each spwaned userspace
+ * process
+ */
 void userspace(struct uml_pt_regs *regs)
 {
-	struct itimerval timer;
-	unsigned long long nsecs, now;
 	int err, status, op, pid = userspace_pid[0];
 	/* To prevent races if using_sysemu changes under us.*/
 	int local_using_sysemu;
@@ -325,13 +387,8 @@ void userspace(struct uml_pt_regs *regs)
 	/* Handle any immediate reschedules or signals */
 	interrupt_end();
 
-	if (getitimer(ITIMER_VIRTUAL, &timer))
-		printk(UM_KERN_ERR "Failed to get itimer, errno = %d\n", errno);
-	nsecs = timer.it_value.tv_sec * UM_NSEC_PER_SEC +
-		timer.it_value.tv_usec * UM_NSEC_PER_USEC;
-	nsecs += os_nsecs();
-
 	while (1) {
+
 		/*
 		 * This can legitimately fail if the process loads a
 		 * bogus value into a segment register.  It will
@@ -388,32 +445,19 @@ void userspace(struct uml_pt_regs *regs)
 			switch (sig) {
 			case SIGSEGV:
 				if (PTRACE_FULL_FAULTINFO) {
-					get_skas_faultinfo(pid,
-							   &regs->faultinfo);
-					(*sig_info[SIGSEGV])(SIGSEGV, (struct siginfo *)&si,
-							     regs);
+					get_skas_faultinfo(pid,&regs->faultinfo);
+					(*sig_info[SIGSEGV])(SIGSEGV, (struct siginfo *)&si, regs);
+				} else {
+					handle_segv(pid, regs);
 				}
-				else handle_segv(pid, regs);
 				break;
 			case SIGTRAP + 0x80:
-			        handle_trap(pid, regs, local_using_sysemu);
+				handle_trap(pid, regs, local_using_sysemu);
 				break;
 			case SIGTRAP:
 				relay_signal(SIGTRAP, (struct siginfo *)&si, regs);
 				break;
-			case SIGVTALRM:
-				now = os_nsecs();
-				if (now < nsecs)
-					break;
-				block_signals();
-				(*sig_info[sig])(sig, (struct siginfo *)&si, regs);
-				unblock_signals();
-				nsecs = timer.it_value.tv_sec *
-					UM_NSEC_PER_SEC +
-					timer.it_value.tv_usec *
-					UM_NSEC_PER_USEC;
-				nsecs += os_nsecs();
-				break;
+			case SIGUSR2:
 			case SIGIO:
 			case SIGILL:
 			case SIGBUS:
@@ -448,8 +492,7 @@ static int __init init_thread_regs(void)
 	thread_regs[REGS_IP_INDEX] = STUB_CODE +
 				(unsigned long) stub_clone_handler -
 				(unsigned long) &__syscall_stub_start;
-	thread_regs[REGS_SP_INDEX] = STUB_DATA + UM_KERN_PAGE_SIZE -
-		sizeof(void *);
+	thread_regs[REGS_SP_INDEX] = STUB_DATA + UM_KERN_PAGE_SIZE - sizeof(void *);
 #ifdef __SIGNAL_FRAMESIZE
 	thread_regs[REGS_SP_INDEX] -= __SIGNAL_FRAMESIZE;
 #endif
@@ -458,26 +501,51 @@ static int __init init_thread_regs(void)
 
 __initcall(init_thread_regs);
 
+/**
+ * copy_context_skas0() - copy an mm context
+ * new_stack:	void pointer of new stack, a zeroed page
+ * pid:			the pid of the mm parent, this proces is cloned
+ *				into a new one
+ *
+ * Copy an mm context from an existing task
+ * 1.) get file descriptor and offset of the mmaped new_stack
+ * 2.) set current stub stack's data: file descriptor, offset and timer data
+ * 3.) Restore parents registers to init_thread_regs()
+ * 4.) Continue parent (==from_mm) in stub_clone_handler(), see also 
+ *     init_thread_regs(). This will clone a new process with same
+ *     mm.
+ * 5.) 
+ *
+ * Returns the PID of the new process
+ */
 int copy_context_skas0(unsigned long new_stack, int pid)
 {
-	struct timeval tv = { .tv_sec = 0, .tv_usec = UM_USEC_PER_SEC / UM_HZ };
 	int err;
 	unsigned long current_stack = current_stub_stack();
 	struct stub_data *data = (struct stub_data *) current_stack;
 	struct stub_data *child_data = (struct stub_data *) new_stack;
 	unsigned long long new_offset;
+
 	int new_fd = phys_mapping(to_phys((void *)new_stack), &new_offset);
 
 	/*
 	 * prepare offset and fd of child's stack as argument for parent's
 	 * and child's mmap2 calls
 	 */
-	*data = ((struct stub_data) { .offset	= MMAP_OFFSET(new_offset),
-				      .fd	= new_fd,
-				      .timer    = ((struct itimerval)
-					           { .it_value = tv,
-						     .it_interval = tv }) });
-
+	*data = ((struct stub_data) { 
+			.offset	= MMAP_OFFSET(new_offset),
+			.fd     = new_fd,
+			.timer  = ((struct itimerspec)
+					     { .it_value.tv_sec  = 0,
+					       .it_value.tv_nsec = os_timer_remain(NULL),
+					       .it_interval.tv_sec  = 0,
+					       .it_interval.tv_nsec = UM_NSEC_PER_SEC / UM_HZ })
+	});
+
+	/* set parents regs
+	 * this set the registers to the saved registers done in the initcall
+	 * init_thread_regs()
+	 */
 	err = ptrace_setregs(pid, thread_regs);
 	if (err < 0) {
 		err = -errno;
@@ -486,6 +554,7 @@ int copy_context_skas0(unsigned long new_stack, int pid)
 		return err;
 	}
 
+	/* set parents fp registers */
 	err = put_fp_registers(pid, thread_fp_regs);
 	if (err < 0) {
 		printk(UM_KERN_ERR "copy_context_skas0 : put_fp_registers "
@@ -493,7 +562,9 @@ int copy_context_skas0(unsigned long new_stack, int pid)
 		return err;
 	}
 
-	/* set a well known return code for detection of child write failure */
+	/* set a well known return code for detection of child write failure,
+	 * i.e. on the new stack
+	 */
 	child_data->err = 12345678;
 
 	/*
@@ -508,8 +579,10 @@ int copy_context_skas0(unsigned long new_stack, int pid)
 		return err;
 	}
 
+	/* wait for parents stub_clone_handler() to finish */
 	wait_stub_done(pid);
 
+	/* get childs pid, the pid of the cloned parent process */
 	pid = data->err;
 	if (pid < 0) {
 		printk(UM_KERN_ERR "copy_context_skas0 - stub-parent reports "
diff --git a/arch/um/os-Linux/time.c b/arch/um/os-Linux/time.c
index e9824d5..5a7f49c 100644
--- a/arch/um/os-Linux/time.c
+++ b/arch/um/os-Linux/time.c
@@ -1,4 +1,5 @@
 /*
+ * Copyright (C) 2012-2014 Cisco Systems
  * Copyright (C) 2000 - 2007 Jeff Dike (jdike{addtoit,linux.intel}.com)
  * Licensed under the GPL
  */
@@ -10,177 +11,177 @@
 #include <sys/time.h>
 #include <kern_util.h>
 #include <os.h>
-#include "internal.h"
+#include <string.h>
+#include <timer-internal.h>
 
-int set_interval(void)
-{
-	int usec = UM_USEC_PER_SEC / UM_HZ;
-	struct itimerval interval = ((struct itimerval) { { 0, usec },
-							  { 0, usec } });
-
-	if (setitimer(ITIMER_VIRTUAL, &interval, NULL) == -1)
-		return -errno;
+static timer_t event_high_res_timer = 0;
 
-	return 0;
+static inline long long timeval_to_ns(const struct timeval *tv)
+{
+	return ((long long) tv->tv_sec * UM_NSEC_PER_SEC) +
+		tv->tv_usec * UM_NSEC_PER_USEC;
 }
 
-int timer_one_shot(int ticks)
+static inline long long timespec_to_ns(const struct timespec *ts)
 {
-	unsigned long usec = ticks * UM_USEC_PER_SEC / UM_HZ;
-	unsigned long sec = usec / UM_USEC_PER_SEC;
-	struct itimerval interval;
-
-	usec %= UM_USEC_PER_SEC;
-	interval = ((struct itimerval) { { 0, 0 }, { sec, usec } });
+	return ((long long) ts->tv_sec * UM_NSEC_PER_SEC) +
+		ts->tv_nsec;
+}
 
-	if (setitimer(ITIMER_VIRTUAL, &interval, NULL) == -1)
-		return -errno;
+long long os_persistent_clock_emulation (void) {
+	struct timespec realtime_tp;
 
-	return 0;
+	clock_gettime(CLOCK_REALTIME, &realtime_tp);
+	return timespec_to_ns(&realtime_tp);
 }
 
 /**
- * timeval_to_ns - Convert timeval to nanoseconds
- * @ts:		pointer to the timeval variable to be converted
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
-	return ((long long) tv->tv_sec * UM_NSEC_PER_SEC) +
-		tv->tv_usec * UM_NSEC_PER_USEC;
-}
+int os_timer_create(void* timer) {
 
-long long disable_timer(void)
-{
-	struct itimerval time = ((struct itimerval) { { 0, 0 }, { 0, 0 } });
-	long long remain, max = UM_NSEC_PER_SEC / UM_HZ;
+	struct sigevent sev;
+	timer_t* t = timer;
 
-	if (setitimer(ITIMER_VIRTUAL, &time, &time) < 0)
-		printk(UM_KERN_ERR "disable_timer - setitimer failed, "
-		       "errno = %d\n", errno);
+	if(t == NULL) {
+		t = &event_high_res_timer;
+	}
 
-	remain = timeval_to_ns(&time.it_value);
-	if (remain > max)
-		remain = max;
+	sev.sigev_notify = SIGEV_SIGNAL;
+	sev.sigev_signo = SIGUSR2; /* note - hrtimer now has its own signal */
+	sev.sigev_value.sival_ptr = &event_high_res_timer;
 
-	return remain;
+	if (timer_create(
+		CLOCK_MONOTONIC,
+		&sev,
+		t) == -1) {
+		return -1;
+	}
+	return 0;
 }
 
-long long os_nsecs(void)
+int os_timer_set_interval(void* timer, void* i)
 {
-	struct timeval tv;
+	struct itimerspec its;
+	unsigned long long nsec;
+	timer_t* t = timer;
+	struct itimerspec* its_in = i;
 
-	gettimeofday(&tv, NULL);
-	return timeval_to_ns(&tv);
-}
+	if(t == NULL) {
+		t = &event_high_res_timer;
+	}
+
+	nsec = UM_NSEC_PER_SEC / UM_HZ;
+
+	if(its_in != NULL) {
+		its.it_value.tv_sec = its_in->it_value.tv_sec;
+		its.it_value.tv_nsec = its_in->it_value.tv_nsec;
+	} else {
+		its.it_value.tv_sec = 0;
+		its.it_value.tv_nsec = nsec;
+	}
+
+	its.it_interval.tv_sec = 0;
+	its.it_interval.tv_nsec = nsec;
+
+	if(timer_settime(*t, 0, &its, NULL) == -1) {
+		return -errno;
+	}
 
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
-	alarm_handler(SIGVTALRM, NULL, NULL);
-}
+	struct itimerspec its;
+	timer_t* t = timer;
 
-static unsigned long long sleep_time(unsigned long long nsecs)
-{
-	return nsecs;
-}
+	if(t == NULL) {
+		t = &event_high_res_timer;
+	}
 
-#else
-unsigned long long last_tick;
-unsigned long long skew;
+	if(timer_gettime(t, &its) == -1) {
+		return -errno;
+	}
 
-static void deliver_alarm(void)
-{
-	unsigned long long this_tick = os_nsecs();
-	int one_tick = UM_NSEC_PER_SEC / UM_HZ;
+	return its.it_value.tv_nsec;
+}
 
-	/* Protection against the host's time going backwards */
-	if ((last_tick != 0) && (this_tick < last_tick))
-		this_tick = last_tick;
+int os_timer_one_shot(int ticks)
+{
+	struct itimerspec its;
+	unsigned long long nsec;
+	unsigned long sec;
 
-	if (last_tick == 0)
-		last_tick = this_tick - one_tick;
+    nsec = (ticks + 1);
+    sec = nsec / UM_NSEC_PER_SEC;
+	nsec = nsec % UM_NSEC_PER_SEC;
 
-	skew += this_tick - last_tick;
+	its.it_value.tv_sec = nsec / UM_NSEC_PER_SEC;
+	its.it_value.tv_nsec = nsec;
 
-	while (skew >= one_tick) {
-		alarm_handler(SIGVTALRM, NULL, NULL);
-		skew -= one_tick;
-	}
+	its.it_interval.tv_sec = 0;
+	its.it_interval.tv_nsec = 0; // we cheat here
 
-	last_tick = this_tick;
+	timer_settime(event_high_res_timer, 0, &its, NULL);
+	return 0;
 }
 
-static unsigned long long sleep_time(unsigned long long nsecs)
+/**
+ * os_timer_disable() - disable the posix (interval) timer
+ * Returns the remaining interval timer time in nanoseconds
+ */
+long long os_timer_disable(void)
 {
-	return nsecs > skew ? nsecs - skew : 0;
+	struct itimerspec its;
+
+	memset(&its, 0, sizeof(struct itimerspec));
+	timer_settime(event_high_res_timer, 0, &its, &its);
+
+	return its.it_value.tv_sec * UM_NSEC_PER_SEC + its.it_value.tv_nsec;
 }
 
-static inline long long timespec_to_us(const struct timespec *ts)
+long long os_vnsecs(void)
 {
-	return ((long long) ts->tv_sec * UM_USEC_PER_SEC) +
-		ts->tv_nsec / UM_NSEC_PER_USEC;
+	struct timespec ts;
+
+	clock_gettime(CLOCK_PROCESS_CPUTIME_ID,&ts);
+	return timespec_to_ns(&ts);
 }
 
-static int after_sleep_interval(struct timespec *ts)
+long long os_nsecs(void)
 {
-	int usec = UM_USEC_PER_SEC / UM_HZ;
-	long long start_usecs = timespec_to_us(ts);
-	struct timeval tv;
-	struct itimerval interval;
-
-	/*
-	 * It seems that rounding can increase the value returned from
-	 * setitimer to larger than the one passed in.  Over time,
-	 * this will cause the remaining time to be greater than the
-	 * tick interval.  If this happens, then just reduce the first
-	 * tick to the interval value.
-	 */
-	if (start_usecs > usec)
-		start_usecs = usec;
-
-	start_usecs -= skew / UM_NSEC_PER_USEC;
-	if (start_usecs < 0)
-		start_usecs = 0;
-
-	tv = ((struct timeval) { .tv_sec  = start_usecs / UM_USEC_PER_SEC,
-				 .tv_usec = start_usecs % UM_USEC_PER_SEC });
-	interval = ((struct itimerval) { { 0, usec }, tv });
-
-	if (setitimer(ITIMER_VIRTUAL, &interval, NULL) == -1)
-		return -errno;
+	struct timespec ts;
 
-	return 0;
+	clock_gettime(CLOCK_MONOTONIC,&ts);
+	return timespec_to_ns(&ts);
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
 
-	/*
-	 * nsecs can come in as zero, in which case, this starts a
-	 * busy loop.  To prevent this, reset nsecs to the tick
-	 * interval if it is zero.
-	 */
-	if (nsecs == 0)
-		nsecs = UM_NSEC_PER_SEC / UM_HZ;
-
-	nsecs = sleep_time(nsecs);
-	ts = ((struct timespec) { .tv_sec	= nsecs / UM_NSEC_PER_SEC,
-				  .tv_nsec	= nsecs % UM_NSEC_PER_SEC });
-
-	if (nanosleep(&ts, &ts) == 0)
-		deliver_alarm();
-	after_sleep_interval(&ts);
+	if (nsecs <= 0) {
+		return;
+	}
+
+	ts = ((struct timespec) {
+			.tv_sec  = nsecs / UM_NSEC_PER_SEC,
+			.tv_nsec = nsecs % UM_NSEC_PER_SEC
+	});
+
+	clock_nanosleep(CLOCK_MONOTONIC, 0, &ts, NULL);
 }
diff --git a/arch/um/os-Linux/util.c b/arch/um/os-Linux/util.c
index faee55e..10ecc06 100644
--- a/arch/um/os-Linux/util.c
+++ b/arch/um/os-Linux/util.c
@@ -102,6 +102,7 @@ void os_fix_helper_signals(void)
 	signal(SIGWINCH, SIG_IGN);
 	signal(SIGINT, SIG_DFL);
 	signal(SIGTERM, SIG_DFL);
+	signal(SIGUSR2, SIG_IGN);
 }
 
 void os_dump_core(void)



------------------------------------------------------------------------------
One dashboard for servers and applications across Physical-Virtual-Cloud 
Widest out-of-the-box monitoring support with 50+ applications
Performance metrics, stats and reports that give you Actionable Insights
Deep dive visibility with transaction tracing using APM Insight.
http://ad.doubleclick.net/ddm/clk/290420510;117567292;y
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

