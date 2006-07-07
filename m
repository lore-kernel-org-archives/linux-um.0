Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1FyeHq-0006au-7H for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 06 Jul 2006 17:33:39 -0700
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1FyeHp-0000il-7A
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 06 Jul 2006 17:33:37 -0700
Message-Id: <200607070033.k670XndD008727@ccure.user-mode-linux.org>
Mime-Version: 1.0
Date: Thu, 06 Jul 2006 20:33:49 -0400
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] [PATCH 14/19] UML - Remove syscall debugging
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

Eliminate an unused debug option.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.17/arch/um/Kconfig.debug
===================================================================
--- linux-2.6.17.orig/arch/um/Kconfig.debug	2006-07-06 12:02:43.000000000 -0400
+++ linux-2.6.17/arch/um/Kconfig.debug	2006-07-06 12:55:06.000000000 -0400
@@ -47,13 +47,4 @@ config GCOV
         If you're involved in UML kernel development and want to use gcov,
         say Y.  If you're unsure, say N.
 
-config SYSCALL_DEBUG
-	bool "Enable system call debugging"
-	depends on DEBUG_INFO
-	help
-	This adds some system debugging to UML, including keeping a ring buffer
-	with recent system calls and some global and per-task statistics.
-
-	If unsure, say N
-
 endmenu
Index: linux-2.6.17/arch/um/kernel/Makefile
===================================================================
--- linux-2.6.17.orig/arch/um/kernel/Makefile	2006-07-06 12:02:43.000000000 -0400
+++ linux-2.6.17/arch/um/kernel/Makefile	2006-07-06 12:55:06.000000000 -0400
@@ -15,7 +15,6 @@ obj-y = config.o exec_kern.o exitcode.o 
 obj-$(CONFIG_BLK_DEV_INITRD) += initrd.o
 obj-$(CONFIG_GPROF)	+= gprof_syms.o
 obj-$(CONFIG_GCOV)	+= gmon_syms.o
-obj-$(CONFIG_SYSCALL_DEBUG) += syscall.o
 
 obj-$(CONFIG_MODE_TT) += tt/
 obj-$(CONFIG_MODE_SKAS) += skas/
Index: linux-2.6.17/arch/um/kernel/skas/syscall.c
===================================================================
--- linux-2.6.17.orig/arch/um/kernel/skas/syscall.c	2006-07-06 12:02:43.000000000 -0400
+++ linux-2.6.17/arch/um/kernel/skas/syscall.c	2006-07-06 12:55:06.000000000 -0400
@@ -18,11 +18,7 @@ void handle_syscall(union uml_pt_regs *r
 	struct pt_regs *regs = container_of(r, struct pt_regs, regs);
 	long result;
 	int syscall;
-#ifdef UML_CONFIG_SYSCALL_DEBUG
-  	int index;
 
-  	index = record_syscall_start(UPT_SYSCALL_NR(r));
-#endif
 	syscall_trace(r, 0);
 
 	current->thread.nsyscalls++;
@@ -44,7 +40,4 @@ void handle_syscall(union uml_pt_regs *r
 	REGS_SET_SYSCALL_RETURN(r->skas.regs, result);
 
 	syscall_trace(r, 1);
-#ifdef UML_CONFIG_SYSCALL_DEBUG
-  	record_syscall_end(index, result);
-#endif
 }
Index: linux-2.6.17/arch/um/kernel/tt/syscall_kern.c
===================================================================
--- linux-2.6.17.orig/arch/um/kernel/tt/syscall_kern.c	2006-07-06 12:02:43.000000000 -0400
+++ linux-2.6.17/arch/um/kernel/tt/syscall_kern.c	2006-07-06 12:55:06.000000000 -0400
@@ -21,18 +21,11 @@ void syscall_handler_tt(int sig, struct 
 	void *sc;
 	long result;
 	int syscall;
-#ifdef CONFIG_SYSCALL_DEBUG
-	int index;
-#endif
+
 	sc = UPT_SC(&regs->regs);
 	SC_START_SYSCALL(sc);
 
 	syscall = UPT_SYSCALL_NR(&regs->regs);
-
-#ifdef CONFIG_SYSCALL_DEBUG
-	index = record_syscall_start(syscall);
-#endif
-
 	syscall_trace(&regs->regs, 0);
 
 	current->thread.nsyscalls++;
@@ -50,7 +43,4 @@ void syscall_handler_tt(int sig, struct 
 	SC_SET_SYSCALL_RETURN(sc, result);
 
 	syscall_trace(&regs->regs, 1);
-#ifdef CONFIG_SYSCALL_DEBUG
-  	record_syscall_end(index, result);
-#endif
 }
Index: linux-2.6.17/arch/um/kernel/tt/tracer.c
===================================================================
--- linux-2.6.17.orig/arch/um/kernel/tt/tracer.c	2006-07-06 12:02:43.000000000 -0400
+++ linux-2.6.17/arch/um/kernel/tt/tracer.c	2006-07-06 12:55:06.000000000 -0400
@@ -188,10 +188,7 @@ int tracer(int (*init_proc)(void *), voi
 	int status, pid = 0, sig = 0, cont_type, tracing = 0, op = 0;
 	int proc_id = 0, n, err, old_tracing = 0, strace = 0;
 	int local_using_sysemu = 0;
-#ifdef UML_CONFIG_SYSCALL_DEBUG
-	unsigned long eip = 0;
-	int last_index;
-#endif
+
 	signal(SIGPIPE, SIG_IGN);
 	setup_tracer_winch();
 	tracing_pid = os_getpid();
@@ -282,23 +279,6 @@ int tracer(int (*init_proc)(void *), voi
 		else if(WIFSTOPPED(status)){
 			proc_id = pid_to_processor_id(pid);
 			sig = WSTOPSIG(status);
-#ifdef UML_CONFIG_SYSCALL_DEBUG
-			if(signal_index[proc_id] == 1024){
-				signal_index[proc_id] = 0;
-				last_index = 1023;
-			}
-			else last_index = signal_index[proc_id] - 1;
-			if(((sig == SIGPROF) || (sig == SIGVTALRM) ||
-			    (sig == SIGALRM)) &&
-			   (signal_record[proc_id][last_index].signal == sig)&&
-			   (signal_record[proc_id][last_index].pid == pid))
-				signal_index[proc_id] = last_index;
-			signal_record[proc_id][signal_index[proc_id]].pid = pid;
-			gettimeofday(&signal_record[proc_id][signal_index[proc_id]].time, NULL);
-			eip = ptrace(PTRACE_PEEKUSR, pid, PT_IP_OFFSET, 0);
-			signal_record[proc_id][signal_index[proc_id]].addr = eip;
-			signal_record[proc_id][signal_index[proc_id]++].signal = sig;
-#endif
 			if(proc_id == -1){
 				sleeping_process_signal(pid, sig);
 				continue;
Index: linux-2.6.17/arch/um/kernel/syscall.c
===================================================================
--- linux-2.6.17.orig/arch/um/kernel/syscall.c	2006-07-06 12:02:43.000000000 -0400
+++ /dev/null	1970-01-01 00:00:00.000000000 +0000
@@ -1,36 +0,0 @@
-/*
- * Copyright (C) 2002 Jeff Dike (jdike@karaya.com)
- * Licensed under the GPL
- */
-
-#include "kern_util.h"
-#include "syscall.h"
-#include "os.h"
-
-struct {
-	int syscall;
-	int pid;
-	long result;
-	unsigned long long start;
-	unsigned long long end;
-} syscall_record[1024];
-
-int record_syscall_start(int syscall)
-{
-	int max, index;
-
-	max = sizeof(syscall_record)/sizeof(syscall_record[0]);
-	index = next_syscall_index(max);
-
-	syscall_record[index].syscall = syscall;
-	syscall_record[index].pid = current_pid();
-	syscall_record[index].result = 0xdeadbeef;
-	syscall_record[index].start = os_nsecs();
-	return(index);
-}
-
-void record_syscall_end(int index, long result)
-{
-	syscall_record[index].result = result;
-	syscall_record[index].end = os_nsecs();
-}
Index: linux-2.6.17/arch/um/defconfig
===================================================================
--- linux-2.6.17.orig/arch/um/defconfig	2006-06-20 17:24:29.000000000 -0400
+++ linux-2.6.17/arch/um/defconfig	2006-07-06 12:55:24.000000000 -0400
@@ -526,4 +526,3 @@ CONFIG_FORCED_INLINING=y
 # CONFIG_RCU_TORTURE_TEST is not set
 # CONFIG_GPROF is not set
 # CONFIG_GCOV is not set
-# CONFIG_SYSCALL_DEBUG is not set


Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
