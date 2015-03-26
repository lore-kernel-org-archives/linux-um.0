Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard@nod.at>) id 1Yb6ss-0007Zm-9t
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 26 Mar 2015 12:27:38 +0000
Received: from mail.sigma-star.at ([95.130.255.111])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Yb6sq-0005UM-8l for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 26 Mar 2015 12:27:38 +0000
From: Richard Weinberger <richard@nod.at>
Date: Thu, 26 Mar 2015 13:27:16 +0100
Message-Id: <1427372838-16605-5-git-send-email-richard@nod.at>
In-Reply-To: <1427372838-16605-1-git-send-email-richard@nod.at>
References: <1427372838-16605-1-git-send-email-richard@nod.at>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
Subject: [uml-devel] [PATCH 5/7] um: Remove broken SMP support
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Richard Weinberger <richard@nod.at>, linux-kernel@vger.kernel.org

At times where UML used the TT mode to operate it had
kind of SMP support. It never got finished nor was
stable.
Let's rip out that cruft and stop confusing developers
which do tree-wide SMP cleanups.

If someone wants SMP support UML it has do be done from scratch.

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 arch/um/Kconfig.um                      |  30 ----
 arch/um/include/asm/processor-generic.h |   8 --
 arch/um/include/asm/smp.h               |  26 ----
 arch/um/kernel/Makefile                 |   2 +-
 arch/um/kernel/irq.c                    |   3 -
 arch/um/kernel/process.c                |  11 --
 arch/um/kernel/skas/process.c           |   4 +-
 arch/um/kernel/smp.c                    | 238 --------------------------------
 arch/um/kernel/um_arch.c                |  35 -----
 arch/x86/um/asm/barrier.h               |  11 --
 10 files changed, 2 insertions(+), 366 deletions(-)
 delete mode 100644 arch/um/kernel/smp.c

diff --git a/arch/um/Kconfig.um b/arch/um/Kconfig.um
index a7520c9..ff86fbe 100644
--- a/arch/um/Kconfig.um
+++ b/arch/um/Kconfig.um
@@ -95,36 +95,6 @@ config MAGIC_SYSRQ
 	  The keys are documented in <file:Documentation/sysrq.txt>. Don't say Y
 	  unless you really know what this hack does.
 
-config SMP
-	bool "Symmetric multi-processing support"
-	default n
-	depends on BROKEN
-	help
-	  This option enables UML SMP support.
-	  It is NOT related to having a real SMP box. Not directly, at least.
-
-	  UML implements virtual SMP by allowing as many processes to run
-	  simultaneously on the host as there are virtual processors configured.
-
-	  Obviously, if the host is a uniprocessor, those processes will
-	  timeshare, but, inside UML, will appear to be running simultaneously.
-	  If the host is a multiprocessor, then UML processes may run
-	  simultaneously, depending on the host scheduler.
-
-	  This, however, is supported only in TT mode. So, if you use the SKAS
-	  patch on your host, switching to TT mode and enabling SMP usually
-	  gives	you worse performances.
-	  Also, since the support for SMP has been under-developed, there could
-	  be some bugs being exposed by enabling SMP.
-
-	  If you don't know what to do, say N.
-
-config NR_CPUS
-	int "Maximum number of CPUs (2-32)"
-	range 2 32
-	depends on SMP
-	default "32"
-
 config HIGHMEM
 	bool "Highmem support"
 	depends on !64BIT && BROKEN
diff --git a/arch/um/include/asm/processor-generic.h b/arch/um/include/asm/processor-generic.h
index cbc5edd..2d1e0dd 100644
--- a/arch/um/include/asm/processor-generic.h
+++ b/arch/um/include/asm/processor-generic.h
@@ -98,16 +98,8 @@ struct cpuinfo_um {
 
 extern struct cpuinfo_um boot_cpu_data;
 
-#define my_cpu_data		cpu_data[smp_processor_id()]
-
-#ifdef CONFIG_SMP
-extern struct cpuinfo_um cpu_data[];
-#define current_cpu_data cpu_data[smp_processor_id()]
-#else
 #define cpu_data (&boot_cpu_data)
 #define current_cpu_data boot_cpu_data
-#endif
-
 
 #define KSTK_REG(tsk, reg) get_thread_reg(reg, &tsk->thread.switch_buf)
 extern unsigned long get_wchan(struct task_struct *p);
diff --git a/arch/um/include/asm/smp.h b/arch/um/include/asm/smp.h
index e450793..9c3be35 100644
--- a/arch/um/include/asm/smp.h
+++ b/arch/um/include/asm/smp.h
@@ -1,32 +1,6 @@
 #ifndef __UM_SMP_H
 #define __UM_SMP_H
 
-#ifdef CONFIG_SMP
-
-#include <linux/bitops.h>
-#include <asm/current.h>
-#include <linux/cpumask.h>
-
-#define raw_smp_processor_id() (current_thread->cpu)
-
-#define cpu_logical_map(n) (n)
-#define cpu_number_map(n) (n)
-extern int hard_smp_processor_id(void);
-#define NO_PROC_ID -1
-
-extern int ncpus;
-
-
-static inline void smp_cpus_done(unsigned int maxcpus)
-{
-}
-
-extern struct task_struct *idle_threads[NR_CPUS];
-
-#else
-
 #define hard_smp_processor_id()		0
 
 #endif
-
-#endif
diff --git a/arch/um/kernel/Makefile b/arch/um/kernel/Makefile
index 2d840a0..b7e31e5 100644
--- a/arch/um/kernel/Makefile
+++ b/arch/um/kernel/Makefile
@@ -12,7 +12,7 @@ clean-files :=
 
 obj-y = config.o exec.o exitcode.o irq.o ksyms.o mem.o \
 	physmem.o process.o ptrace.o reboot.o sigio.o \
-	signal.o smp.o syscall.o sysrq.o time.o tlb.o trap.o \
+	signal.o syscall.o sysrq.o time.o tlb.o trap.o \
 	um_arch.o umid.o maccess.o skas/
 
 obj-$(CONFIG_BLK_DEV_INITRD) += initrd.o
diff --git a/arch/um/kernel/irq.c b/arch/um/kernel/irq.c
index 1d8505b..23cb935 100644
--- a/arch/um/kernel/irq.c
+++ b/arch/um/kernel/irq.c
@@ -35,9 +35,6 @@ void sigio_handler(int sig, struct siginfo *unused_si, struct uml_pt_regs *regs)
 	struct irq_fd *irq_fd;
 	int n;
 
-	if (smp_sigio_handler())
-		return;
-
 	while (1) {
 		n = os_waiting_for_events(active_fds);
 		if (n <= 0) {
diff --git a/arch/um/kernel/process.c b/arch/um/kernel/process.c
index f17bca8..68b9119 100644
--- a/arch/um/kernel/process.c
+++ b/arch/um/kernel/process.c
@@ -259,17 +259,6 @@ int strlen_user_proc(char __user *str)
 	return strlen_user(str);
 }
 
-int smp_sigio_handler(void)
-{
-#ifdef CONFIG_SMP
-	int cpu = current_thread_info()->cpu;
-	IPI_handler(cpu);
-	if (cpu != 0)
-		return 1;
-#endif
-	return 0;
-}
-
 int cpu(void)
 {
 	return current_thread_info()->cpu;
diff --git a/arch/um/kernel/skas/process.c b/arch/um/kernel/skas/process.c
index 082955d..527fa58 100644
--- a/arch/um/kernel/skas/process.c
+++ b/arch/um/kernel/skas/process.c
@@ -21,9 +21,7 @@ static int __init start_kernel_proc(void *unused)
 
 	cpu_tasks[0].pid = pid;
 	cpu_tasks[0].task = current;
-#ifdef CONFIG_SMP
-	init_cpu_online(get_cpu_mask(0));
-#endif
+
 	start_kernel();
 	return 0;
 }
diff --git a/arch/um/kernel/smp.c b/arch/um/kernel/smp.c
deleted file mode 100644
index 5c8c3ea..0000000
--- a/arch/um/kernel/smp.c
+++ /dev/null
@@ -1,238 +0,0 @@
-/*
- * Copyright (C) 2000 - 2007 Jeff Dike (jdike@{addtoit,linux.intel}.com)
- * Licensed under the GPL
- */
-
-#include <linux/percpu.h>
-#include <asm/pgalloc.h>
-#include <asm/tlb.h>
-
-#ifdef CONFIG_SMP
-
-#include <linux/sched.h>
-#include <linux/module.h>
-#include <linux/threads.h>
-#include <linux/interrupt.h>
-#include <linux/err.h>
-#include <linux/hardirq.h>
-#include <asm/smp.h>
-#include <asm/processor.h>
-#include <asm/spinlock.h>
-#include <kern.h>
-#include <irq_user.h>
-#include <os.h>
-
-/* Per CPU bogomips and other parameters
- * The only piece used here is the ipi pipe, which is set before SMP is
- * started and never changed.
- */
-struct cpuinfo_um cpu_data[NR_CPUS];
-
-/* A statistic, can be a little off */
-int num_reschedules_sent = 0;
-
-/* Not changed after boot */
-struct task_struct *idle_threads[NR_CPUS];
-
-void smp_send_reschedule(int cpu)
-{
-	os_write_file(cpu_data[cpu].ipi_pipe[1], "R", 1);
-	num_reschedules_sent++;
-}
-
-void smp_send_stop(void)
-{
-	int i;
-
-	printk(KERN_INFO "Stopping all CPUs...");
-	for (i = 0; i < num_online_cpus(); i++) {
-		if (i == current_thread->cpu)
-			continue;
-		os_write_file(cpu_data[i].ipi_pipe[1], "S", 1);
-	}
-	printk(KERN_CONT "done\n");
-}
-
-static cpumask_t smp_commenced_mask = CPU_MASK_NONE;
-static cpumask_t cpu_callin_map = CPU_MASK_NONE;
-
-static int idle_proc(void *cpup)
-{
-	int cpu = (int) cpup, err;
-
-	err = os_pipe(cpu_data[cpu].ipi_pipe, 1, 1);
-	if (err < 0)
-		panic("CPU#%d failed to create IPI pipe, err = %d", cpu, -err);
-
-	os_set_fd_async(cpu_data[cpu].ipi_pipe[0]);
-
-	wmb();
-	if (cpu_test_and_set(cpu, cpu_callin_map)) {
-		printk(KERN_ERR "huh, CPU#%d already present??\n", cpu);
-		BUG();
-	}
-
-	while (!cpu_isset(cpu, smp_commenced_mask))
-		cpu_relax();
-
-	notify_cpu_starting(cpu);
-	set_cpu_online(cpu, true);
-	default_idle();
-	return 0;
-}
-
-static struct task_struct *idle_thread(int cpu)
-{
-	struct task_struct *new_task;
-
-	current->thread.request.u.thread.proc = idle_proc;
-	current->thread.request.u.thread.arg = (void *) cpu;
-	new_task = fork_idle(cpu);
-	if (IS_ERR(new_task))
-		panic("copy_process failed in idle_thread, error = %ld",
-		      PTR_ERR(new_task));
-
-	cpu_tasks[cpu] = ((struct cpu_task)
-		          { .pid = 	new_task->thread.mode.tt.extern_pid,
-			    .task = 	new_task } );
-	idle_threads[cpu] = new_task;
-	panic("skas mode doesn't support SMP");
-	return new_task;
-}
-
-void smp_prepare_cpus(unsigned int maxcpus)
-{
-	struct task_struct *idle;
-	unsigned long waittime;
-	int err, cpu, me = smp_processor_id();
-	int i;
-
-	for (i = 0; i < ncpus; ++i)
-		set_cpu_possible(i, true);
-
-	set_cpu_online(me, true);
-	cpu_set(me, cpu_callin_map);
-
-	err = os_pipe(cpu_data[me].ipi_pipe, 1, 1);
-	if (err < 0)
-		panic("CPU#0 failed to create IPI pipe, errno = %d", -err);
-
-	os_set_fd_async(cpu_data[me].ipi_pipe[0]);
-
-	for (cpu = 1; cpu < ncpus; cpu++) {
-		printk(KERN_INFO "Booting processor %d...\n", cpu);
-
-		idle = idle_thread(cpu);
-
-		init_idle(idle, cpu);
-
-		waittime = 200000000;
-		while (waittime-- && !cpu_isset(cpu, cpu_callin_map))
-			cpu_relax();
-
-		printk(KERN_INFO "%s\n",
-		       cpu_isset(cpu, cpu_calling_map) ? "done" : "failed");
-	}
-}
-
-void smp_prepare_boot_cpu(void)
-{
-	set_cpu_online(smp_processor_id(), true);
-}
-
-int __cpu_up(unsigned int cpu, struct task_struct *tidle)
-{
-	cpu_set(cpu, smp_commenced_mask);
-	while (!cpu_online(cpu))
-		mb();
-	return 0;
-}
-
-int setup_profiling_timer(unsigned int multiplier)
-{
-	printk(KERN_INFO "setup_profiling_timer\n");
-	return 0;
-}
-
-void smp_call_function_slave(int cpu);
-
-void IPI_handler(int cpu)
-{
-	unsigned char c;
-	int fd;
-
-	fd = cpu_data[cpu].ipi_pipe[0];
-	while (os_read_file(fd, &c, 1) == 1) {
-		switch (c) {
-		case 'C':
-			smp_call_function_slave(cpu);
-			break;
-
-		case 'R':
-			scheduler_ipi();
-			break;
-
-		case 'S':
-			printk(KERN_INFO "CPU#%d stopping\n", cpu);
-			while (1)
-				pause();
-			break;
-
-		default:
-			printk(KERN_ERR "CPU#%d received unknown IPI [%c]!\n",
-			       cpu, c);
-			break;
-		}
-	}
-}
-
-int hard_smp_processor_id(void)
-{
-	return pid_to_processor_id(os_getpid());
-}
-
-static DEFINE_SPINLOCK(call_lock);
-static atomic_t scf_started;
-static atomic_t scf_finished;
-static void (*func)(void *info);
-static void *info;
-
-void smp_call_function_slave(int cpu)
-{
-	atomic_inc(&scf_started);
-	(*func)(info);
-	atomic_inc(&scf_finished);
-}
-
-int smp_call_function(void (*_func)(void *info), void *_info, int wait)
-{
-	int cpus = num_online_cpus() - 1;
-	int i;
-
-	if (!cpus)
-		return 0;
-
-	/* Can deadlock when called with interrupts disabled */
-	WARN_ON(irqs_disabled());
-
-	spin_lock_bh(&call_lock);
-	atomic_set(&scf_started, 0);
-	atomic_set(&scf_finished, 0);
-	func = _func;
-	info = _info;
-
-	for_each_online_cpu(i)
-		os_write_file(cpu_data[i].ipi_pipe[1], "C", 1);
-
-	while (atomic_read(&scf_started) != cpus)
-		barrier();
-
-	if (wait)
-		while (atomic_read(&scf_finished) != cpus)
-			barrier();
-
-	spin_unlock_bh(&call_lock);
-	return 0;
-}
-
-#endif
diff --git a/arch/um/kernel/um_arch.c b/arch/um/kernel/um_arch.c
index dbd5bda..cd09285 100644
--- a/arch/um/kernel/um_arch.c
+++ b/arch/um/kernel/um_arch.c
@@ -66,12 +66,6 @@ static int show_cpuinfo(struct seq_file *m, void *v)
 {
 	int index = 0;
 
-#ifdef CONFIG_SMP
-	index = (struct cpuinfo_um *) v - cpu_data;
-	if (!cpu_online(index))
-		return 0;
-#endif
-
 	seq_printf(m, "processor\t: %d\n", index);
 	seq_printf(m, "vendor_id\t: User Mode Linux\n");
 	seq_printf(m, "model name\t: UML\n");
@@ -168,23 +162,6 @@ __uml_setup("debug", no_skas_debug_setup,
 "    this flag is not needed to run gdb on UML in skas mode\n\n"
 );
 
-#ifdef CONFIG_SMP
-static int __init uml_ncpus_setup(char *line, int *add)
-{
-	if (!sscanf(line, "%d", &ncpus)) {
-		printf("Couldn't parse [%s]\n", line);
-		return -1;
-	}
-
-	return 0;
-}
-
-__uml_setup("ncpus=", uml_ncpus_setup,
-"ncpus=<# of desired CPUs>\n"
-"    This tells an SMP kernel how many virtual processors to start.\n\n"
-);
-#endif
-
 static int __init Usage(char *line, int *add)
 {
 	const char **p;
@@ -380,15 +357,3 @@ void __init check_bugs(void)
 void apply_alternatives(struct alt_instr *start, struct alt_instr *end)
 {
 }
-
-#ifdef CONFIG_SMP
-void alternatives_smp_module_add(struct module *mod, char *name,
-				 void *locks, void *locks_end,
-				 void *text,  void *text_end)
-{
-}
-
-void alternatives_smp_module_del(struct module *mod)
-{
-}
-#endif
diff --git a/arch/x86/um/asm/barrier.h b/arch/x86/um/asm/barrier.h
index 2d7d9a1..aec75a5 100644
--- a/arch/x86/um/asm/barrier.h
+++ b/arch/x86/um/asm/barrier.h
@@ -36,22 +36,11 @@
 #endif /* CONFIG_X86_PPRO_FENCE */
 #define dma_wmb()	barrier()
 
-#ifdef CONFIG_SMP
-
-#define smp_mb()	mb()
-#define smp_rmb()	dma_rmb()
-#define smp_wmb()	barrier()
-#define set_mb(var, value) do { (void)xchg(&var, value); } while (0)
-
-#else /* CONFIG_SMP */
-
 #define smp_mb()	barrier()
 #define smp_rmb()	barrier()
 #define smp_wmb()	barrier()
 #define set_mb(var, value) do { var = value; barrier(); } while (0)
 
-#endif /* CONFIG_SMP */
-
 #define read_barrier_depends()		do { } while (0)
 #define smp_read_barrier_depends()	do { } while (0)
 
-- 
1.8.4.5


------------------------------------------------------------------------------
Dive into the World of Parallel Programming The Go Parallel Website, sponsored
by Intel and developed in partnership with Slashdot Media, is your hub for all
things parallel software development, from weekly thought leadership blogs to
news, videos, case studies, tutorials and more. Take a look and join the 
conversation now. http://goparallel.sourceforge.net/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

