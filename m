Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IxQs6-0000Ka-Cq for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 28 Nov 2007 09:38:50 -0800
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1IxQs4-0002gD-Qb
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 28 Nov 2007 09:38:50 -0800
Date: Wed, 28 Nov 2007 12:38:37 -0500
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20071128173837.GA7174@c2.user-mode-linux.org>
References: <E1IxMK0-0006ae-2s@dorka.pomaz.szeredi.hu>
	<20071128125030.GB21791@elte.hu>
	<E1IxMfh-0006fN-HQ@dorka.pomaz.szeredi.hu>
	<20071128150840.GB5518@c2.user-mode-linux.org>
	<E1IxOzn-00075w-Gq@dorka.pomaz.szeredi.hu>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <E1IxOzn-00075w-Gq@dorka.pomaz.szeredi.hu>
Subject: Re: [uml-devel] -rt doesn't compile for UML
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
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: mingo@elte.hu, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

On Wed, Nov 28, 2007 at 04:38:39PM +0100, Miklos Szeredi wrote:
> It doesn't help in this case.  I've gotten as far as realizing that
> the latency tracer needs the irqflags tracing
> (Documentation/irqflags-tracing.tx) and that UML doesn't yet support
> that.

Try the patch below - no guarantees, however, it boots here and
printks stuff.

-- 
Work email - jdike at linux dot intel dot com


Index: linux-2.6.22/arch/um/Kconfig
===================================================================
--- linux-2.6.22.orig/arch/um/Kconfig	2007-11-28 10:57:24.000000000 -0500
+++ linux-2.6.22/arch/um/Kconfig	2007-11-28 12:36:39.000000000 -0500
@@ -33,18 +33,13 @@ config PCI
 config PCMCIA
 	bool
 
-# Yet to do!
-config TRACE_IRQFLAGS_SUPPORT
-	bool
-	default n
-
 config LOCKDEP_SUPPORT
 	bool
 	default y
 
 config STACKTRACE_SUPPORT
 	bool
-	default n
+	default y
 
 config GENERIC_CALIBRATE_DELAY
 	bool
Index: linux-2.6.22/arch/um/Kconfig.debug
===================================================================
--- linux-2.6.22.orig/arch/um/Kconfig.debug	2007-11-28 10:57:22.000000000 -0500
+++ linux-2.6.22/arch/um/Kconfig.debug	2007-11-28 11:34:19.000000000 -0500
@@ -2,6 +2,10 @@ menu "Kernel hacking"
 
 source "lib/Kconfig.debug"
 
+config TRACE_IRQFLAGS_SUPPORT
+	bool
+	default y
+
 config GPROF
 	bool "Enable gprof support"
 	depends on DEBUG_INFO && FRAME_POINTER
Index: linux-2.6.22/arch/um/include/sysdep-i386/tls.h
===================================================================
--- linux-2.6.22.orig/arch/um/include/sysdep-i386/tls.h	2007-11-28 12:36:28.000000000 -0500
+++ linux-2.6.22/arch/um/include/sysdep-i386/tls.h	2007-11-28 12:36:39.000000000 -0500
@@ -1,8 +1,6 @@
 #ifndef _SYSDEP_TLS_H
 #define _SYSDEP_TLS_H
 
-# ifndef __KERNEL__
-
 /* Change name to avoid conflicts with the original one from <asm/ldt.h>, which
  * may be named user_desc (but in 2.4 and in header matching its API was named
  * modify_ldt_ldt_s). */
@@ -19,13 +17,6 @@ typedef struct um_dup_user_desc {
 	unsigned int  useable:1;
 } user_desc_t;
 
-# else /* __KERNEL__ */
-
-#  include <asm/ldt.h>
-typedef struct user_desc user_desc_t;
-
-# endif /* __KERNEL__ */
-
 #define GDT_ENTRY_TLS_MIN_I386 6
 #define GDT_ENTRY_TLS_MIN_X86_64 12
 
Index: linux-2.6.22/arch/um/include/sysdep-x86_64/tls.h
===================================================================
--- linux-2.6.22.orig/arch/um/include/sysdep-x86_64/tls.h	2007-11-28 12:36:28.000000000 -0500
+++ linux-2.6.22/arch/um/include/sysdep-x86_64/tls.h	2007-11-28 12:36:39.000000000 -0500
@@ -1,8 +1,6 @@
 #ifndef _SYSDEP_TLS_H
 #define _SYSDEP_TLS_H
 
-# ifndef __KERNEL__
-
 /* Change name to avoid conflicts with the original one from <asm/ldt.h>, which
  * may be named user_desc (but in 2.4 and in header matching its API was named
  * modify_ldt_ldt_s). */
@@ -20,10 +18,4 @@ typedef struct um_dup_user_desc {
 	unsigned int  lm:1;
 } user_desc_t;
 
-# else /* __KERNEL__ */
-
-#  include <asm/ldt.h>
-typedef struct user_desc user_desc_t;
-
-# endif /* __KERNEL__ */
 #endif /* _SYSDEP_TLS_H */
Index: linux-2.6.22/arch/um/kernel/sysrq.c
===================================================================
--- linux-2.6.22.orig/arch/um/kernel/sysrq.c	2007-11-28 10:57:22.000000000 -0500
+++ linux-2.6.22/arch/um/kernel/sysrq.c	2007-11-28 12:36:39.000000000 -0500
@@ -7,6 +7,7 @@
 #include "linux/kernel.h"
 #include "linux/module.h"
 #include "linux/kallsyms.h"
+#include "linux/stacktrace.h"
 #include "asm/page.h"
 #include "asm/processor.h"
 #include "sysrq.h"
@@ -78,3 +79,4 @@ void show_stack(struct task_struct *task
 	printk("Call Trace: \n");
 	show_trace(task, esp);
 }
+
Index: linux-2.6.22/arch/um/sys-i386/tls.c
===================================================================
--- linux-2.6.22.orig/arch/um/sys-i386/tls.c	2007-11-28 12:36:28.000000000 -0500
+++ linux-2.6.22/arch/um/sys-i386/tls.c	2007-11-28 12:36:39.000000000 -0500
@@ -24,7 +24,8 @@ int do_set_thread_area(struct user_desc 
 	u32 cpu;
 
 	cpu = get_cpu();
-	ret = os_set_thread_area(info, userspace_pid[cpu]);
+	ret = os_set_thread_area((struct um_dup_user_desc *) info,
+				 userspace_pid[cpu]);
 	put_cpu();
 
 	if (ret)
@@ -40,7 +41,8 @@ int do_get_thread_area(struct user_desc 
 	u32 cpu;
 
 	cpu = get_cpu();
-	ret = os_get_thread_area(info, userspace_pid[cpu]);
+	ret = os_get_thread_area((struct um_dup_user_desc *) info,
+				 userspace_pid[cpu]);
 	put_cpu();
 
 	if (ret)
Index: linux-2.6.22/include/asm-um/irqflags.h
===================================================================
--- linux-2.6.22.orig/include/asm-um/irqflags.h	2007-11-28 10:57:22.000000000 -0500
+++ linux-2.6.22/include/asm-um/irqflags.h	2007-11-28 11:34:19.000000000 -0500
@@ -1,6 +1,31 @@
 #ifndef __UM_IRQFLAGS_H
 #define __UM_IRQFLAGS_H
 
-/* Empty for now */
+#include "os.h"
+
+static inline int raw_irqs_disabled_flags(unsigned long flags)
+{
+	return flags == 0;
+}
+
+static inline void raw_local_irq_disable(void)
+{
+	block_signals();
+}
+
+static inline void raw_local_irq_enable(void)
+{
+	unblock_signals();
+}
+
+static inline void raw_local_irq_restore(unsigned long flags)
+{
+	set_signals(flags);
+}
+
+#define raw_local_irq_save(flags) do { typecheck(unsigned long, flags); \
+				       (flags) = get_signals();		\
+				       block_signals(); } while(0)
+
 
 #endif
Index: linux-2.6.22/arch/um/include/os.h
===================================================================
--- linux-2.6.22.orig/arch/um/include/os.h	2007-11-28 12:36:28.000000000 -0500
+++ linux-2.6.22/arch/um/include/os.h	2007-11-28 12:36:39.000000000 -0500
@@ -213,8 +213,8 @@ extern int helper_wait(int pid);
 
 
 /* tls.c */
-extern int os_set_thread_area(user_desc_t *info, int pid);
-extern int os_get_thread_area(user_desc_t *info, int pid);
+extern int os_set_thread_area(struct um_dup_user_desc *info, int pid);
+extern int os_get_thread_area(struct um_dup_user_desc *info, int pid);
 
 /* umid.c */
 extern int umid_file_name(char *name, char *buf, int len);
Index: linux-2.6.22/arch/um/kernel/Makefile
===================================================================
--- linux-2.6.22.orig/arch/um/kernel/Makefile	2007-11-28 12:36:28.000000000 -0500
+++ linux-2.6.22/arch/um/kernel/Makefile	2007-11-28 12:36:39.000000000 -0500
@@ -15,6 +15,8 @@ obj-$(CONFIG_BLK_DEV_INITRD) += initrd.o
 obj-$(CONFIG_GPROF)	+= gprof_syms.o
 obj-$(CONFIG_GCOV)	+= gmon_syms.o
 
+subarch-obj-$(CONFIG_STACKTRACE) += kernel/stacktrace.o
+
 USER_OBJS := config.o
 
 include arch/um/scripts/Makefile.rules
Index: linux-2.6.22/arch/um/sys-i386/sysrq.c
===================================================================
--- linux-2.6.22.orig/arch/um/sys-i386/sysrq.c	2007-11-28 12:36:28.000000000 -0500
+++ linux-2.6.22/arch/um/sys-i386/sysrq.c	2007-11-28 12:36:39.000000000 -0500
@@ -7,6 +7,7 @@
 #include "linux/smp.h"
 #include "linux/sched.h"
 #include "linux/kallsyms.h"
+#include <asm/stacktrace.h>
 #include "asm/ptrace.h"
 #include "sysrq.h"
 
@@ -44,33 +45,97 @@ static inline int valid_stack_ptr(struct
 }
 
 /* Adapted from i386 (we also print the address we read from). */
-static inline unsigned long print_context_stack(struct thread_info *tinfo,
-				unsigned long *stack, unsigned long ebp)
+static unsigned long print_context_stack(struct thread_info *tinfo,
+					 unsigned long *stack, unsigned long ebp,
+					 const struct stacktrace_ops *ops,
+					 void *data)
 {
 	unsigned long addr;
 
 #ifdef CONFIG_FRAME_POINTER
 	while (valid_stack_ptr(tinfo, (void *)ebp)) {
 		addr = *(unsigned long *)(ebp + 4);
-		printk("%08lx:  [<%08lx>]", ebp + 4, addr);
-		print_symbol(" %s", addr);
-		printk("\n");
+		ops->address(data, addr);
 		ebp = *(unsigned long *)ebp;
 	}
 #else
 	while (valid_stack_ptr(tinfo, stack)) {
 		addr = *stack;
-		if (__kernel_text_address(addr)) {
-			printk("%08lx:  [<%08lx>]", (unsigned long) stack, addr);
-			print_symbol(" %s", addr);
-			printk("\n");
-		}
+		if (__kernel_text_address(addr))
+			ops->address(data, addr);
 		stack++;
 	}
 #endif
 	return ebp;
 }
 
+void dump_trace(struct task_struct *task, struct pt_regs *regs,
+	        unsigned long *stack, const struct stacktrace_ops *ops,
+		void *data)
+{
+	struct thread_info *context;
+	unsigned long ebp = 0;
+
+	if (!task)
+		task = current;
+
+	if (!stack) {
+		unsigned long dummy;
+		stack = &dummy;
+		if (task != current)
+			stack = (unsigned long *) KSTK_ESP(task);
+	}
+
+#ifdef CONFIG_FRAME_POINTER
+	if (!ebp) {
+		if (task == current) {
+			/* Grab ebp right from our regs */
+			asm ("movl %%ebp, %0" : "=r" (ebp) : );
+		} else {
+			ebp = KSTK_EBP(task);
+		}
+	}
+#endif
+
+	context = (struct thread_info *)
+		((unsigned long)stack & (~(THREAD_SIZE - 1)));
+	ebp = print_context_stack(context, stack, ebp, ops, data);
+}
+
+static void show_trace_warning_symbol(void *data, char *msg,
+				      unsigned long symbol)
+{
+	printk(data);
+	print_symbol(msg, symbol);
+	printk("\n");
+}
+
+static void show_trace_warning(void *data, char *msg)
+{
+	printk("%s%s\n", (char *) data, msg);
+}
+
+static int show_trace_stack(void *data, char *name)
+{
+	return 0;
+}
+
+/*
+ * Print one address/symbol entries per line.
+ */
+static void show_trace_address(void *data, unsigned long addr)
+{
+	printk("%s [<%08lx>] ", (char *) data, addr);
+	print_symbol("%s\n", addr);
+}
+
+static const struct stacktrace_ops show_trace_ops = {
+	.warning = show_trace_warning,
+	.warning_symbol = show_trace_warning_symbol,
+	.stack = show_trace_stack,
+	.address = show_trace_address,
+};
+
 void show_trace(struct task_struct* task, unsigned long * stack)
 {
 	unsigned long ebp;
@@ -79,7 +144,8 @@ void show_trace(struct task_struct* task
 	/* Turn this into BUG_ON if possible. */
 	if (!stack) {
 		stack = (unsigned long*) &stack;
-		printk("show_trace: got NULL stack, implicit assumption task == current");
+		printk("show_trace: got NULL stack, implicit assumption "
+		       "task == current");
 		WARN_ON(1);
 	}
 
@@ -94,7 +160,7 @@ void show_trace(struct task_struct* task
 
 	context = (struct thread_info *)
 		((unsigned long)stack & (~(THREAD_SIZE - 1)));
-	print_context_stack(context, stack, ebp);
+	print_context_stack(context, stack, ebp, &show_trace_ops, "");
 
 	printk("\n");
 }
Index: linux-2.6.22/include/asm-um/stacktrace.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.22/include/asm-um/stacktrace.h	2007-11-28 12:36:39.000000000 -0500
@@ -0,0 +1,6 @@
+#ifndef __UM_STACKTRACE_H
+#define __UM_STACKTRACE_H
+
+#include "asm/arch/stacktrace.h"
+
+#endif

-------------------------------------------------------------------------
SF.Net email is sponsored by: The Future of Linux Business White Paper
from Novell.  From the desktop to the data center, Linux is going
mainstream.  Let it simplify your IT future.
http://altfarm.mediaplex.com/ad/ck/8857-50307-18918-4
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
