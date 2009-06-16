Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <menage@google.com>) id 1MGNSH-0007nt-U5
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 16 Jun 2009 01:27:17 +0000
Received: from smtp-out.google.com ([216.239.45.13])
	by 3b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MGNSG-0006ov-Tk
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 16 Jun 2009 01:27:17 +0000
From: Paul Menage <menage@google.com>
Date: Mon, 15 Jun 2009 17:17:39 -0700
Message-ID: <20090616001739.30398.50579.stgit@menage.mtv.corp.google.com>
In-Reply-To: <20090616001248.30398.84278.stgit@menage.mtv.corp.google.com>
References: <20090616001248.30398.84278.stgit@menage.mtv.corp.google.com>
MIME-Version: 1.0
Subject: [uml-devel] [PATCH 3/5] UML: Enable CONFIG_STACKTRACE_SUPPORT
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
To: peterz@infradead.org, mingo@redhat.com, jdike@addtoit.com
Cc: user-mode-linux-devel@lists.sourceforge.net

UML: Enable CONFIG_STACKTRACE_SUPPORT

Adds a simple stacktrace function, only tested/enabled on X86

Signed-off-by: Paul Menage <menage@google.com>

---

 arch/um/Kconfig.common      |    2 +
 arch/um/kernel/Makefile     |    1 +
 arch/um/kernel/stacktrace.c |   68 +++++++++++++++++++++++++++++++++++++++++++
 arch/um/kernel/sysrq.c      |   20 +++++++++++++
 4 files changed, 90 insertions(+), 1 deletions(-)
 create mode 100644 arch/um/kernel/stacktrace.c

diff --git a/arch/um/Kconfig.common b/arch/um/Kconfig.common
index 8a54ae4..b757c36 100644
--- a/arch/um/Kconfig.common
+++ b/arch/um/Kconfig.common
@@ -44,7 +44,7 @@ config LOCKDEP_SUPPORT
 
 config STACKTRACE_SUPPORT
 	bool
-	default n
+	default UML_X86
 
 config GENERIC_CALIBRATE_DELAY
 	bool
diff --git a/arch/um/kernel/Makefile b/arch/um/kernel/Makefile
index 388ec0a..b1867a0 100644
--- a/arch/um/kernel/Makefile
+++ b/arch/um/kernel/Makefile
@@ -14,6 +14,7 @@ obj-y = config.o exec.o exitcode.o init_task.o irq.o ksyms.o mem.o \
 obj-$(CONFIG_BLK_DEV_INITRD) += initrd.o
 obj-$(CONFIG_GPROF)	+= gprof_syms.o
 obj-$(CONFIG_GCOV)	+= gmon_syms.o
+obj-$(CONFIG_STACKTRACE_SUPPORT) += stacktrace.o
 
 USER_OBJS := config.o
 
diff --git a/arch/um/kernel/stacktrace.c b/arch/um/kernel/stacktrace.c
new file mode 100644
index 0000000..a0d6a60
--- /dev/null
+++ b/arch/um/kernel/stacktrace.c
@@ -0,0 +1,68 @@
+/*
+ * Simple stacktrace function. Only tested on x86, but can probably
+ * be adapted to other architectures with minimal work. (E.g. checking
+ * stack direction)
+ */
+#include "linux/stddef.h"
+#include <linux/stacktrace.h>
+#include <linux/kallsyms.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/sched.h>
+
+static void save_stack_address(unsigned long addr, struct stack_trace *trace)
+{
+	if (!__kernel_text_address(addr))
+		return;
+
+	if (trace->skip) {
+		trace->skip--;
+		return;
+	}
+
+	trace->entries[trace->nr_entries++] = addr;
+}
+
+#define THREAD_MASK (THREAD_SIZE-1)
+
+#ifdef CONFIG_FRAME_POINTER
+
+struct stack_frame {
+	struct stack_frame *next_frame;
+	unsigned long return_address;
+};
+
+void save_stack_trace(struct stack_trace *trace)
+{
+	unsigned long addr;
+	struct stack_frame *frame, *end;
+	frame = __builtin_frame_address(0);
+	end = (struct stack_frame *)
+		((((unsigned long)frame) + THREAD_MASK) & ~THREAD_MASK);
+	while (trace->nr_entries < trace->max_entries) {
+		addr = frame->return_address;
+		save_stack_address(addr, trace);
+		if (frame->next_frame <= frame || frame->next_frame > end)
+			break;
+		frame = frame->next_frame;
+	}
+	if (trace->nr_entries < trace->max_entries)
+		trace->entries[trace->nr_entries++] = ULONG_MAX;
+}
+#else
+
+void save_stack_trace(struct stack_trace *trace)
+{
+	unsigned long addr;
+	unsigned long *stack = (unsigned long *)&stack;
+	while (trace->nr_entries < trace->max_entries) {
+		addr = *stack;
+		save_stack_address(addr, trace);
+		stack++;
+		if (!(stack & THREAD_MASK))
+			break;
+	}
+	if (trace->nr_entries < trace->max_entries)
+		trace->entries[trace->nr_entries++] = ULONG_MAX;
+}
+#endif
diff --git a/arch/um/kernel/sysrq.c b/arch/um/kernel/sysrq.c
index 56d43d0..42b832c 100644
--- a/arch/um/kernel/sysrq.c
+++ b/arch/um/kernel/sysrq.c
@@ -11,6 +11,25 @@
 
 /* Catch non-i386 SUBARCH's. */
 #if !defined(CONFIG_UML_X86) || defined(CONFIG_64BIT)
+#ifdef CONFIG_STACKTRACE
+void show_trace(struct task_struct *task, unsigned long * stack)
+{
+	struct stack_trace trace;
+	unsigned long entries[64];
+
+	if (!stack) {
+		stack = (unsigned long *) &stack;
+		WARN_ON(1);
+	}
+
+	trace.nr_entries = 0;
+	trace.max_entries = ARRAY_SIZE(entries);
+	trace.entries = entries;
+	trace.skip = 0;
+	save_stack_trace(&trace);
+	print_stack_trace(&trace, 0);
+}
+#else
 void show_trace(struct task_struct *task, unsigned long * stack)
 {
 	unsigned long addr;
@@ -33,6 +52,7 @@ void show_trace(struct task_struct *task, unsigned long * stack)
 	}
 	printk(KERN_INFO "\n");
 }
+#endif  /& CONFIG_STACKTRACE */
 #endif
 
 /*


------------------------------------------------------------------------------
Crystal Reports - New Free Runtime and 30 Day Trial
Check out the new simplified licensing option that enables unlimited
royalty-free distribution of the report engine for externally facing 
server and web deployment.
http://p.sf.net/sfu/businessobjects
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

