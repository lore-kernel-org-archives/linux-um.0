Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D8MeL-0007NB-Mu for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 07 Mar 2005 10:08:13 -0800
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1D8MeI-0005al-Lp for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 07 Mar 2005 10:08:13 -0800
Message-Id: <200503072038.j27KcKbc003983@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] [PATCH 9/16] UML - Clean up the syscall path
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
Date: Mon, 07 Mar 2005 15:38:20 -0500
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

This patch removes some useless code from the system call path, and
removes some debug code, which will reappear in a configurable form in
the syscall-debug patch.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.11/arch/um/kernel/Makefile
===================================================================
--- linux-2.6.11.orig/arch/um/kernel/Makefile	2005-03-05 12:07:34.000000000 -0500
+++ linux-2.6.11/arch/um/kernel/Makefile	2005-03-05 12:14:17.000000000 -0500
@@ -10,9 +10,9 @@
 	helper.o init_task.o irq.o irq_user.o ksyms.o main.o mem.o mem_user.o \
 	physmem.o process.o process_kern.o ptrace.o reboot.o resource.o \
 	sigio_user.o sigio_kern.o signal_kern.o signal_user.o smp.o \
-	syscall_kern.o syscall_user.o sysrq.o sys_call_table.o tempfile.o \
-	time.o time_kern.o tlb.o trap_kern.o trap_user.o uaccess_user.o \
-	um_arch.o umid.o user_util.o
+	syscall_kern.o sysrq.o sys_call_table.o tempfile.o time.o time_kern.o \
+	tlb.o trap_kern.o trap_user.o uaccess_user.o um_arch.o umid.o \
+	user_util.o
 
 obj-$(CONFIG_BLK_DEV_INITRD) += initrd_kern.o initrd_user.o
 obj-$(CONFIG_GPROF)	+= gprof_syms.o
Index: linux-2.6.11/arch/um/kernel/skas/include/skas.h
===================================================================
--- linux-2.6.11.orig/arch/um/kernel/skas/include/skas.h	2005-03-05 12:07:35.000000000 -0500
+++ linux-2.6.11/arch/um/kernel/skas/include/skas.h	2005-03-05 12:14:58.000000000 -0500
@@ -30,6 +30,7 @@
 extern void user_signal(int sig, union uml_pt_regs *regs);
 extern int new_mm(int from);
 extern void start_userspace(int cpu);
+extern long execute_syscall_skas(void *r);
 
 #endif
 
Index: linux-2.6.11/arch/um/kernel/skas/syscall_user.c
===================================================================
--- linux-2.6.11.orig/arch/um/kernel/skas/syscall_user.c	2005-03-05 12:07:34.000000000 -0500
+++ linux-2.6.11/arch/um/kernel/skas/syscall_user.c	2005-03-05 12:14:17.000000000 -0500
@@ -9,22 +9,18 @@
 #include "syscall_user.h"
 #include "sysdep/ptrace.h"
 #include "sysdep/sigcontext.h"
-
+#include "skas.h"
 
 void handle_syscall(union uml_pt_regs *regs)
 {
 	long result;
-	int index;
-
-	index = record_syscall_start(UPT_SYSCALL_NR(regs));
 
 	syscall_trace(regs, 0);
-	result = execute_syscall(regs);
+	result = execute_syscall_skas(regs);
 
 	REGS_SET_SYSCALL_RETURN(regs->skas.regs, result);
 
 	syscall_trace(regs, 1);
-	record_syscall_end(index, result);
 }
 
 /*
Index: linux-2.6.11/arch/um/kernel/syscall_kern.c
===================================================================
--- linux-2.6.11.orig/arch/um/kernel/syscall_kern.c	2005-03-05 12:07:34.000000000 -0500
+++ linux-2.6.11/arch/um/kernel/syscall_kern.c	2005-03-05 12:14:17.000000000 -0500
@@ -154,27 +154,6 @@
 	return error;
 }
 
-long execute_syscall(void *r)
-{
-	return(CHOOSE_MODE_PROC(execute_syscall_tt, execute_syscall_skas, r));
-}
-
-DEFINE_SPINLOCK(syscall_lock);
-
-static int syscall_index = 0;
-
-int next_syscall_index(int limit)
-{
-	int ret;
-
-	spin_lock(&syscall_lock);
-	ret = syscall_index;
-	if(++syscall_index == limit)
-		syscall_index = 0;
-	spin_unlock(&syscall_lock);
-	return(ret);
-}
-
 /*
  * Overrides for Emacs so that we follow Linus's tabbing style.
  * Emacs will notice this stuff at the end of the file and automatically
Index: linux-2.6.11/arch/um/kernel/tt/include/tt.h
===================================================================
--- linux-2.6.11.orig/arch/um/kernel/tt/include/tt.h	2005-03-05 12:07:34.000000000 -0500
+++ linux-2.6.11/arch/um/kernel/tt/include/tt.h	2005-03-05 12:14:17.000000000 -0500
@@ -30,6 +30,7 @@
 extern void do_sigtrap(void *task);
 extern int is_valid_pid(int pid);
 extern void remap_data(void *segment_start, void *segment_end, int w);
+extern long execute_syscall_tt(void *r);
 
 #endif
 
Index: linux-2.6.11/arch/um/kernel/tt/syscall_user.c
===================================================================
--- linux-2.6.11.orig/arch/um/kernel/tt/syscall_user.c	2005-03-05 12:07:34.000000000 -0500
+++ linux-2.6.11/arch/um/kernel/tt/syscall_user.c	2005-03-05 12:14:17.000000000 -0500
@@ -22,15 +22,14 @@
 {
 	void *sc;
 	long result;
-	int index, syscall;
+	int syscall;
 
 	syscall = UPT_SYSCALL_NR(regs);
 	sc = UPT_SC(regs);
 	SC_START_SYSCALL(sc);
 
-	index = record_syscall_start(syscall);
 	syscall_trace(regs, 0);
-	result = execute_syscall(regs);
+	result = execute_syscall_tt(regs);
 
 	/* regs->sc may have changed while the system call ran (there may
 	 * have been an interrupt or segfault), so it needs to be refreshed.
@@ -40,7 +39,6 @@
 	SC_SET_SYSCALL_RETURN(sc, result);
 
 	syscall_trace(regs, 1);
-	record_syscall_end(index, result);
 }
 
 void do_sigtrap(void *task)
Index: linux-2.6.11/arch/um/kernel/tt/tracer.c
===================================================================
--- linux-2.6.11.orig/arch/um/kernel/tt/tracer.c	2005-03-05 12:07:34.000000000 -0500
+++ linux-2.6.11/arch/um/kernel/tt/tracer.c	2005-03-05 12:14:17.000000000 -0500
@@ -184,9 +184,8 @@
 int tracer(int (*init_proc)(void *), void *sp)
 {
 	void *task = NULL;
-	unsigned long eip = 0;
 	int status, pid = 0, sig = 0, cont_type, tracing = 0, op = 0;
-	int last_index, proc_id = 0, n, err, old_tracing = 0, strace = 0;
+	int proc_id = 0, n, err, old_tracing = 0, strace = 0;
 	int local_using_sysemu = 0;
 
 	signal(SIGPIPE, SIG_IGN);
@@ -279,22 +278,6 @@
 		else if(WIFSTOPPED(status)){
 			proc_id = pid_to_processor_id(pid);
 			sig = WSTOPSIG(status);
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
-			eip = ptrace(PTRACE_PEEKUSER, pid, PT_IP_OFFSET, 0);
-			signal_record[proc_id][signal_index[proc_id]].addr = eip;
-			signal_record[proc_id][signal_index[proc_id]++].signal = sig;
-			
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
