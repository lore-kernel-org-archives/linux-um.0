Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D8Mei-0007PL-NN for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 07 Mar 2005 10:08:36 -0800
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1D8Meh-0005eK-K8 for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 07 Mar 2005 10:08:36 -0800
Message-Id: <200503072038.j27KcSbc003988@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] [PATCH 10/16] UML - Make syscall debugging code
	configurable
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
Date: Mon, 07 Mar 2005 15:38:28 -0500
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

This patch makes some debug code in the system call path configurable.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.11/arch/um/Kconfig.debug
===================================================================
--- linux-2.6.11.orig/arch/um/Kconfig.debug	2005-03-05 12:07:34.000000000 -0500
+++ linux-2.6.11/arch/um/Kconfig.debug	2005-03-05 12:18:28.000000000 -0500
@@ -40,4 +40,14 @@
         If you're involved in UML kernel development and want to use gcov,
         say Y.  If you're unsure, say N.
 
+config SYSCALL_DEBUG
+	bool "Enable system call debugging"
+	default N
+	depends on DEBUG_INFO
+	help
+	This adds some system debugging to UML, including keeping a ring buffer
+	with recent system calls and some global and per-task statistics.
+
+	If unsure, say N
+
 endmenu
Index: linux-2.6.11/arch/um/defconfig
===================================================================
--- linux-2.6.11.orig/arch/um/defconfig	2005-03-05 12:07:41.000000000 -0500
+++ linux-2.6.11/arch/um/defconfig	2005-03-05 12:18:28.000000000 -0500
@@ -52,7 +52,6 @@
 # CONFIG_BSD_PROCESS_ACCT_V3 is not set
 CONFIG_SYSCTL=y
 # CONFIG_AUDIT is not set
-CONFIG_LOG_BUF_SHIFT=14
 # CONFIG_HOTPLUG is not set
 CONFIG_KOBJECT_UEVENT=y
 CONFIG_IKCONFIG=y
@@ -61,9 +60,10 @@
 CONFIG_KALLSYMS=y
 # CONFIG_KALLSYMS_ALL is not set
 CONFIG_KALLSYMS_EXTRA_PASS=y
+CONFIG_BASE_FULL=y
+CONFIG_BASE_SMALL=0
 CONFIG_FUTEX=y
 CONFIG_EPOLL=y
-# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
 CONFIG_SHMEM=y
 CONFIG_CC_ALIGN_FUNCTIONS=0
 CONFIG_CC_ALIGN_LABELS=0
@@ -241,6 +241,11 @@
 # CONFIG_NET_PCMCIA is not set
 
 #
+# PCMCIA network device support
+#
+# CONFIG_NET_PCMCIA is not set
+
+#
 # Wan interfaces
 #
 # CONFIG_WAN is not set
@@ -437,3 +442,4 @@
 CONFIG_PT_PROXY=y
 # CONFIG_GPROF is not set
 # CONFIG_GCOV is not set
+# CONFIG_SYSCALL_DEBUG is not set
Index: linux-2.6.11/arch/um/kernel/Makefile
===================================================================
--- linux-2.6.11.orig/arch/um/kernel/Makefile	2005-03-05 12:14:17.000000000 -0500
+++ linux-2.6.11/arch/um/kernel/Makefile	2005-03-05 12:18:28.000000000 -0500
@@ -18,6 +18,7 @@
 obj-$(CONFIG_GPROF)	+= gprof_syms.o
 obj-$(CONFIG_GCOV)	+= gmon_syms.o
 obj-$(CONFIG_TTY_LOG)	+= tty_log.o
+obj-$(CONFIG_SYSCALL_DEBUG) += syscall_user.o
 
 obj-$(CONFIG_MODE_TT) += tt/
 obj-$(CONFIG_MODE_SKAS) += skas/
Index: linux-2.6.11/arch/um/kernel/skas/syscall_user.c
===================================================================
--- linux-2.6.11.orig/arch/um/kernel/skas/syscall_user.c	2005-03-05 12:14:17.000000000 -0500
+++ linux-2.6.11/arch/um/kernel/skas/syscall_user.c	2005-03-05 12:18:28.000000000 -0500
@@ -6,6 +6,7 @@
 #include <stdlib.h>
 #include <signal.h>
 #include "kern_util.h"
+#include "uml-config.h"
 #include "syscall_user.h"
 #include "sysdep/ptrace.h"
 #include "sysdep/sigcontext.h"
@@ -14,6 +15,11 @@
 void handle_syscall(union uml_pt_regs *regs)
 {
 	long result;
+#if UML_CONFIG_SYSCALL_DEBUG
+  	int index;
+  
+  	index = record_syscall_start(UPT_SYSCALL_NR(regs));
+#endif
 
 	syscall_trace(regs, 0);
 	result = execute_syscall_skas(regs);
@@ -21,6 +27,9 @@
 	REGS_SET_SYSCALL_RETURN(regs->skas.regs, result);
 
 	syscall_trace(regs, 1);
+#if UML_CONFIG_SYSCALL_DEBUG
+  	record_syscall_end(index, result);
+#endif
 }
 
 /*
Index: linux-2.6.11/arch/um/kernel/syscall_kern.c
===================================================================
--- linux-2.6.11.orig/arch/um/kernel/syscall_kern.c	2005-03-05 12:14:17.000000000 -0500
+++ linux-2.6.11/arch/um/kernel/syscall_kern.c	2005-03-05 12:18:28.000000000 -0500
@@ -154,6 +154,22 @@
 	return error;
 }
 
+DEFINE_SPINLOCK(syscall_lock);
+
+static int syscall_index = 0;
+
+int next_syscall_index(int limit)
+{
+	int ret;
+
+	spin_lock(&syscall_lock);
+	ret = syscall_index;
+	if(++syscall_index == limit)
+		syscall_index = 0;
+	spin_unlock(&syscall_lock);
+	return(ret);
+}
+
 /*
  * Overrides for Emacs so that we follow Linus's tabbing style.
  * Emacs will notice this stuff at the end of the file and automatically
Index: linux-2.6.11/arch/um/kernel/syscall_user.c
===================================================================
--- linux-2.6.11.orig/arch/um/kernel/syscall_user.c	2005-03-05 12:07:34.000000000 -0500
+++ linux-2.6.11/arch/um/kernel/syscall_user.c	2005-03-05 12:18:28.000000000 -0500
@@ -46,3 +46,51 @@
  * c-file-style: "linux"
  * End:
  */
+/* 
+ * Copyright (C) 2002 Jeff Dike (jdike@karaya.com)
+ * Licensed under the GPL
+ */
+
+#include <stdlib.h>
+#include <sys/time.h>
+#include "kern_util.h"
+#include "syscall_user.h"
+
+struct {
+	int syscall;
+	int pid;
+	long result;
+	struct timeval start;
+	struct timeval end;
+} syscall_record[1024];
+
+int record_syscall_start(int syscall)
+{
+	int max, index;
+
+	max = sizeof(syscall_record)/sizeof(syscall_record[0]);
+	index = next_syscall_index(max);
+
+	syscall_record[index].syscall = syscall;
+	syscall_record[index].pid = current_pid();
+	syscall_record[index].result = 0xdeadbeef;
+	gettimeofday(&syscall_record[index].start, NULL);
+	return(index);
+}
+
+void record_syscall_end(int index, long result)
+{
+	syscall_record[index].result = result;
+	gettimeofday(&syscall_record[index].end, NULL);
+}
+
+/*
+ * Overrides for Emacs so that we follow Linus's tabbing style.
+ * Emacs will notice this stuff at the end of the file and automatically
+ * adjust the settings for this buffer only.  This must remain at the end
+ * of the file.
+ * ---------------------------------------------------------------------------
+ * Local variables:
+ * c-file-style: "linux"
+ * End:
+ */
Index: linux-2.6.11/arch/um/kernel/tt/syscall_kern.c
===================================================================
--- linux-2.6.11.orig/arch/um/kernel/tt/syscall_kern.c	2005-03-05 12:07:34.000000000 -0500
+++ linux-2.6.11/arch/um/kernel/tt/syscall_kern.c	2005-03-05 12:18:28.000000000 -0500
@@ -22,8 +22,10 @@
 	long res;
 	int syscall;
 
+#ifdef CONFIG_SYSCALL_DEBUG
 	current->thread.nsyscalls++;
 	nsyscalls++;
+#endif
 	syscall = UPT_SYSCALL_NR(&regs->regs);
 
 	if((syscall >= NR_syscalls) || (syscall < 0))
Index: linux-2.6.11/arch/um/kernel/tt/syscall_user.c
===================================================================
--- linux-2.6.11.orig/arch/um/kernel/tt/syscall_user.c	2005-03-05 12:14:17.000000000 -0500
+++ linux-2.6.11/arch/um/kernel/tt/syscall_user.c	2005-03-05 12:18:28.000000000 -0500
@@ -23,11 +23,17 @@
 	void *sc;
 	long result;
 	int syscall;
+#ifdef UML_CONFIG_DEBUG_SYSCALL
+	int index;
+#endif
 
 	syscall = UPT_SYSCALL_NR(regs);
 	sc = UPT_SC(regs);
 	SC_START_SYSCALL(sc);
 
+#ifdef UML_CONFIG_DEBUG_SYSCALL
+  	index = record_syscall_start(syscall);
+#endif
 	syscall_trace(regs, 0);
 	result = execute_syscall_tt(regs);
 
@@ -39,6 +45,9 @@
 	SC_SET_SYSCALL_RETURN(sc, result);
 
 	syscall_trace(regs, 1);
+#ifdef UML_CONFIG_DEBUG_SYSCALL
+  	record_syscall_end(index, result);
+#endif
 }
 
 void do_sigtrap(void *task)
Index: linux-2.6.11/arch/um/kernel/tt/tracer.c
===================================================================
--- linux-2.6.11.orig/arch/um/kernel/tt/tracer.c	2005-03-05 12:14:17.000000000 -0500
+++ linux-2.6.11/arch/um/kernel/tt/tracer.c	2005-03-05 12:18:28.000000000 -0500
@@ -13,7 +13,6 @@
 #include <string.h>
 #include <sys/mman.h>
 #include <sys/ptrace.h>
-#include <linux/ptrace.h>
 #include <sys/time.h>
 #include <sys/wait.h>
 #include "user.h"
@@ -187,7 +186,10 @@
 	int status, pid = 0, sig = 0, cont_type, tracing = 0, op = 0;
 	int proc_id = 0, n, err, old_tracing = 0, strace = 0;
 	int local_using_sysemu = 0;
-
+#ifdef UML_CONFIG_SYSCALL_DEBUG
+	unsigned long eip = 0;
+	int last_index;
+#endif
 	signal(SIGPIPE, SIG_IGN);
 	setup_tracer_winch();
 	tracing_pid = os_getpid();
@@ -278,6 +280,23 @@
 		else if(WIFSTOPPED(status)){
 			proc_id = pid_to_processor_id(pid);
 			sig = WSTOPSIG(status);
+#ifdef UML_CONFIG_SYSCALL_DEBUG
+			if(signal_index[proc_id] == 1024){
+				signal_index[proc_id] = 0;
+				last_index = 1023;
+			}
+			else last_index = signal_index[proc_id] - 1;
+			if(((sig == SIGPROF) || (sig == SIGVTALRM) || 
+			    (sig == SIGALRM)) &&
+			   (signal_record[proc_id][last_index].signal == sig)&&
+			   (signal_record[proc_id][last_index].pid == pid))
+				signal_index[proc_id] = last_index;
+			signal_record[proc_id][signal_index[proc_id]].pid = pid;
+			gettimeofday(&signal_record[proc_id][signal_index[proc_id]].time, NULL);
+			eip = ptrace(PTRACE_PEEKUSER, pid, PT_IP_OFFSET, 0);
+			signal_record[proc_id][signal_index[proc_id]].addr = eip;
+			signal_record[proc_id][signal_index[proc_id]++].signal = sig;
+#endif			
 			if(proc_id == -1){
 				sleeping_process_signal(pid, sig);
 				continue;



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
