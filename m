Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CM62c-0002IY-J6 for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 25 Oct 2004 07:41:46 -0700
Received: from plam.fujitsu-siemens.com ([217.115.66.9])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1CM62b-0008A5-1G for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 25 Oct 2004 07:41:46 -0700
Message-ID: <417D1277.3090603@fujitsu-siemens.com>
From: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
MIME-Version: 1.0
References: <4177D503.2030409@fujitsu-siemens.com>
	<200410212209.i9LM92FL005362@ccure.user-mode-linux.org>
In-Reply-To: <200410212209.i9LM92FL005362@ccure.user-mode-linux.org>
Content-Type: multipart/mixed; boundary="------------030501030700070005060500"
Subject: [uml-devel] Re: Bad handling of invalif systemcalls
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
Date: Mon, 25 Oct 2004 16:49:27 +0200
To: Jeff Dike <jdike@addtoit.com>
Cc: BlaisorBlade <blaisorblade_spam@yahoo.it>, user-mode-linux-devel@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------030501030700070005060500
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Jeff Dike wrote:
> 
> I would be tempted to #define SIGSYSCALL (SIGTRAP + 0x80) or something just
> to make the +0x80 bit less magic-looking.
O.K. I defined it in signal_user.h, hope it's OK there. Consequently the
definition is used in arch/um/kernel/ptrace.c to replace the 0x80 at the
call to ptrace_notify().
> 
> In the SIGTRAP case, you might as well inline do_sigtrap.  One line functions
> are pretty much a waste.
Sorry, I tried to inline it, but it failed to compile. At the moment tracer.c
contains functions without much knowledge about task structure only. Without
including the specific headers, inlining cannot be used.

So, attached you'll find the revised patches.

Bodo

--------------030501030700070005060500
Content-Type: text/plain;
 name="patch-TRACESYSGOOD-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-TRACESYSGOOD-1"

From: Bodo Stroesser <bstroesser@fujitsu-siemens.com>

Patch 1/3 to implement usage of PTRACE_O_TRACESYSGOOD
This is necessary, to fix UMLs bad behavior when a process does
a systemcall with syscall-number less than 0.

Insert a check for availability and function of
  ptrace(PTRACE_SETOPTIONS,,,PTRACE_O_TRACESYSGOOD)
into the normal ptrace checks at startup.

Signed-off-by: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
---

diff -puNr a/arch/um/include/signal_user.h b/arch/um/include/signal_user.h
--- a/arch/um/include/signal_user.h	2004-10-25 13:05:37.008823813 +0200
+++ b/arch/um/include/signal_user.h	2004-10-25 12:18:02.060620621 +0200
@@ -14,6 +14,8 @@ extern void set_handler(int sig, void (*
 extern int set_signals(int enable);
 extern int get_signals(void);
 
+#define SYSCALL_TRAP 0x80
+
 #endif
 
 /*
diff -puNr a/arch/um/kernel/process.c b/arch/um/kernel/process.c
--- a/arch/um/kernel/process.c	2004-10-25 13:05:37.008823813 +0200
+++ b/arch/um/kernel/process.c	2004-10-25 11:41:57.287362002 +0200
@@ -13,6 +13,7 @@
 #include <setjmp.h>
 #include <sys/time.h>
 #include <sys/ptrace.h>
+#include <linux/ptrace.h>
 #include <sys/wait.h>
 #include <sys/mman.h>
 #include <asm/ptrace.h>
@@ -255,6 +256,9 @@ void __init check_ptrace(void)
 	printk("Checking that ptrace can change system call numbers...");
 	pid = start_ptraced_child(&stack);
 
+	if(ptrace(PTRACE_SETOPTIONS, pid, 0, (void *)PTRACE_O_TRACESYSGOOD) < 0)
+		panic("check_ptrace: PTRACE_SETOPTIONS failed, errno = %d", errno);
+
 	while(1){
 		if(ptrace(PTRACE_SYSCALL, pid, 0, 0) < 0)
 			panic("check_ptrace : ptrace failed, errno = %d", 
@@ -262,8 +266,8 @@ void __init check_ptrace(void)
 		CATCH_EINTR(n = waitpid(pid, &status, WUNTRACED));
 		if(n < 0)
 			panic("check_ptrace : wait failed, errno = %d", errno);
-		if(!WIFSTOPPED(status) || (WSTOPSIG(status) != SIGTRAP))
-			panic("check_ptrace : expected SIGTRAP, "
+		if(!WIFSTOPPED(status) || (WSTOPSIG(status) != (SIGTRAP | 0x80)))
+			panic("check_ptrace : expected (SIGTRAP | 0x80), "
 			      "got status = %d", status);
 		
 		syscall = ptrace(PTRACE_PEEKUSER, pid, PT_SYSCALL_NR_OFFSET,
diff -puNr a/arch/um/kernel/ptrace.c b/arch/um/kernel/ptrace.c
--- a/arch/um/kernel/ptrace.c	2004-10-25 13:05:37.009823648 +0200
+++ b/arch/um/kernel/ptrace.c	2004-10-25 12:27:41.169919438 +0200
@@ -17,6 +17,7 @@
 #include "kern_util.h"
 #include "ptrace_user.h"
 #include "skas_ptrace.h"
+#include "signal_user.h"
 
 /*
  * Called by kernel/ptrace.c when detaching..
@@ -319,7 +320,7 @@ void syscall_trace(union uml_pt_regs *re
 	/* the 0x80 provides a way for the tracing parent to distinguish
 	   between a syscall stop and SIGTRAP delivery */
 	ptrace_notify(SIGTRAP | ((current->ptrace & PT_TRACESYSGOOD)
-				 ? 0x80 : 0));
+				 ? SYSCALL_TRAP : 0));
 
 	/*
 	 * this isn't the same as continuing with a signal, but it will do

--------------030501030700070005060500
Content-Type: text/plain;
 name="patch-TRACESYSGOOD-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-TRACESYSGOOD-2"

From: Bodo Stroesser <bstroesser@fujitsu-siemens.com>

Patch 2/3 to implement usage of PTRACE_O_TRACESYSGOOD
This is necessary, to fix UMLs bad behavior when a process does
a systemcall with syscall-number less than 0.

This patch makes SKAS-mode use PTRACE_O_TRACESYSGOOD and fixes
the problems in SKAS.

Signed-off-by: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
---

diff -puNr a/arch/um/kernel/skas/process.c b/arch/um/kernel/skas/process.c
--- a/arch/um/kernel/skas/process.c	2004-10-25 12:58:06.944199612 +0200
+++ b/arch/um/kernel/skas/process.c	2004-10-25 12:57:31.217103722 +0200
@@ -11,6 +11,7 @@
 #include <sched.h>
 #include <sys/wait.h>
 #include <sys/ptrace.h>
+#include <linux/ptrace.h>
 #include <sys/mman.h>
 #include <sys/user.h>
 #include <asm/unistd.h>
@@ -54,14 +55,9 @@ static void handle_segv(int pid)
 /*To use the same value of using_sysemu as the caller, ask it that value (in local_using_sysemu)*/
 static void handle_trap(int pid, union uml_pt_regs *regs, int local_using_sysemu)
 {
-	int err, syscall_nr, status;
+	int err, status;
 
-	syscall_nr = PT_SYSCALL_NR(regs->skas.regs);
-	UPT_SYSCALL_NR(regs) = syscall_nr;
-	if(syscall_nr < 0){
-		relay_signal(SIGTRAP, regs);
-		return;
-	}
+	UPT_SYSCALL_NR(regs) = PT_SYSCALL_NR(regs->skas.regs);
 
 	if (!local_using_sysemu)
 	{
@@ -76,7 +72,8 @@ static void handle_trap(int pid, union u
 			      "errno = %d\n", errno);
 
 		CATCH_EINTR(err = waitpid(pid, &status, WUNTRACED));
-		if((err < 0) || !WIFSTOPPED(status) || (WSTOPSIG(status) != SIGTRAP))
+		if((err < 0) || !WIFSTOPPED(status) ||
+		                (WSTOPSIG(status) != (SIGTRAP|SYSCALL_TRAP)))
 			panic("handle_trap - failed to wait at end of syscall, "
 			      "errno = %d, status = %d\n", errno, status);
 	}
@@ -125,6 +122,10 @@ void start_userspace(int cpu)
 		panic("start_userspace : expected SIGSTOP, got status = %d",
 		      status);
 
+	if (ptrace(PTRACE_SETOPTIONS, pid, NULL, (void *)PTRACE_O_TRACESYSGOOD) < 0)
+		panic("start_userspace : PTRACE_SETOPTIONS failed, errno=%d\n", 
+		      errno);
+
 	if(munmap(stack, PAGE_SIZE) < 0)
 		panic("start_userspace : munmap failed, errno = %d\n", errno);
 
@@ -161,9 +162,13 @@ void userspace(union uml_pt_regs *regs)
 			case SIGSEGV:
 				handle_segv(pid);
 				break;
-			case SIGTRAP:
+			case (SIGTRAP|SYSCALL_TRAP):
 			        handle_trap(pid, regs, local_using_sysemu);
 				break;
+			case SIGTRAP:
+				UPT_SYSCALL_NR(regs) = -1;
+				relay_signal(SIGTRAP, regs);
+				break;
 			case SIGIO:
 			case SIGVTALRM:
 			case SIGILL:

--------------030501030700070005060500
Content-Type: text/plain;
 name="patch-TRACESYSGOOD-3"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-TRACESYSGOOD-3"

From: Bodo Stroesser <bstroesser@fujitsu-siemens.com>

Patch 3/3 to implement usage of PTRACE_O_TRACESYSGOOD
This is necessary, to fix UMLs bad behavior when a process does
a systemcall with syscall-number less than 0.

This patch makes TT-mode use PTRACE_O_TRACESYSGOOD and fixes
the problems in TT.
I'm not quite sure, that this patch doesn't cause problems with
debugger usage. It should be testet by someone, who has more
know how about TT-mode debugger.

Signed-off-by: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
---

diff -puNr a/arch/um/kernel/tt/exec_user.c b/arch/um/kernel/tt/exec_user.c
--- a/arch/um/kernel/tt/exec_user.c	2004-10-25 12:37:19.166402155 +0200
+++ b/arch/um/kernel/tt/exec_user.c	2004-10-25 11:52:33.462230402 +0200
@@ -10,6 +10,7 @@
 #include <errno.h>
 #include <sys/wait.h>
 #include <sys/ptrace.h>
+#include <linux/ptrace.h>
 #include <signal.h>
 #include "user_util.h"
 #include "kern_util.h"
@@ -37,6 +38,9 @@ void do_exec(int old_pid, int new_pid)
 
 	kill(old_pid, SIGKILL);
 
+	if (ptrace(PTRACE_SETOPTIONS, new_pid, 0, (void *)PTRACE_O_TRACESYSGOOD) < 0)
+		tracer_panic("do_exec: PTRACE_SETOPTIONS failed, errno = %d", errno);
+
 	if(ptrace_setregs(new_pid, regs) < 0)
 		tracer_panic("do_exec failed to start new proc - errno = %d",
 			     errno);
diff -puNr a/arch/um/kernel/tt/include/tt.h b/arch/um/kernel/tt/include/tt.h
--- a/arch/um/kernel/tt/include/tt.h	2004-10-25 12:37:19.164402486 +0200
+++ b/arch/um/kernel/tt/include/tt.h	2004-10-25 11:52:33.461230567 +0200
@@ -27,6 +27,7 @@ extern int is_tracing(void *task);
 extern void syscall_handler(int sig, union uml_pt_regs *regs);
 extern void exit_kernel(int pid, void *task);
 extern int do_syscall(void *task, int pid);
+extern void do_sigtrap(void *task);
 extern int is_valid_pid(int pid);
 extern void remap_data(void *segment_start, void *segment_end, int w);
 
diff -puNr a/arch/um/kernel/tt/syscall_user.c b/arch/um/kernel/tt/syscall_user.c
--- a/arch/um/kernel/tt/syscall_user.c	2004-10-25 12:37:19.165402321 +0200
+++ b/arch/um/kernel/tt/syscall_user.c	2004-10-25 11:52:33.462230402 +0200
@@ -43,21 +43,19 @@ void syscall_handler_tt(int sig, union u
 	record_syscall_end(index, result);
 }
 
+void do_sigtrap(void *task)
+{
+	UPT_SYSCALL_NR(TASK_REGS(task)) = -1;
+}
+
 int do_syscall(void *task, int pid)
 {
 	unsigned long proc_regs[FRAME_SIZE];
-	union uml_pt_regs *regs;
-	int syscall;
 
 	if(ptrace_getregs(pid, proc_regs) < 0)
 		tracer_panic("Couldn't read registers");
-	syscall = PT_SYSCALL_NR(proc_regs);
-
-	regs = TASK_REGS(task);
-	UPT_SYSCALL_NR(regs) = syscall;
 
-	if(syscall < 0)
-		return(0);
+	UPT_SYSCALL_NR(TASK_REGS(task)) = PT_SYSCALL_NR(proc_regs);
 
 	if(((unsigned long *) PT_IP(proc_regs) >= &_stext) && 
 	   ((unsigned long *) PT_IP(proc_regs) <= &_etext))
diff -puNr a/arch/um/kernel/tt/tracer.c b/arch/um/kernel/tt/tracer.c
--- a/arch/um/kernel/tt/tracer.c	2004-10-25 12:37:19.165402321 +0200
+++ b/arch/um/kernel/tt/tracer.c	2004-10-25 12:34:44.695929300 +0200
@@ -13,6 +13,7 @@
 #include <string.h>
 #include <sys/mman.h>
 #include <sys/ptrace.h>
+#include <linux/ptrace.h>
 #include <sys/time.h>
 #include <sys/wait.h>
 #include "user.h"
@@ -71,6 +72,8 @@ void attach_process(int pid)
 	   (ptrace(PTRACE_CONT, pid, 0, 0) < 0))
 		tracer_panic("OP_FORK failed to attach pid");
 	wait_for_stop(pid, SIGSTOP, PTRACE_CONT, NULL);
+	if (ptrace(PTRACE_SETOPTIONS, pid, 0, (void *)PTRACE_O_TRACESYSGOOD) < 0)
+		tracer_panic("OP_FORK: PTRACE_SETOPTIONS failed, errno = %d", errno);
 	if(ptrace(PTRACE_CONT, pid, 0, 0) < 0)
 		tracer_panic("OP_FORK failed to continue process");
 }
@@ -141,7 +144,7 @@ static void sleeping_process_signal(int 
 	 * any more, the trace of those will land here.  So, we need to just 
 	 * PTRACE_SYSCALL it.
 	 */
-	case SIGTRAP:
+	case (SIGTRAP|SYSCALL_TRAP):
 		if(ptrace(PTRACE_SYSCALL, pid, 0, 0) < 0)
 			tracer_panic("sleeping_process_signal : Failed to "
 				     "PTRACE_SYSCALL pid %d, errno = %d\n",
@@ -196,6 +199,10 @@ int tracer(int (*init_proc)(void *), voi
 		printf("waitpid on idle thread failed, errno = %d\n", errno);
 		exit(1);
 	}
+	if (ptrace(PTRACE_SETOPTIONS, pid, 0, (void *)PTRACE_O_TRACESYSGOOD) < 0) {
+		printf("Failed to PTRACE_SETOPTIONS for idle thread, errno = %d\n", errno);
+		exit(1);
+	}
 	if((ptrace(PTRACE_CONT, pid, 0, 0) < 0)){
 		printf("Failed to continue idle thread, errno = %d\n", errno);
 		exit(1);
@@ -323,14 +330,22 @@ int tracer(int (*init_proc)(void *), voi
 				 */
 				pid = cpu_tasks[proc_id].pid;
 				break;
+			case (SIGTRAP|SYSCALL_TRAP):
+				if(!tracing && (debugger_pid != -1)){
+					child_signal(pid, W_STOPCODE(SIGTRAP));
+					continue;
+				}
+				tracing = 0;
+				do_syscall(task, pid);
+				sig = SIGUSR2;
+				break;
 			case SIGTRAP:
 				if(!tracing && (debugger_pid != -1)){
 					child_signal(pid, status);
 					continue;
 				}
 				tracing = 0;
-				if(do_syscall(task, pid))
-					sig = SIGUSR2;
+				do_sigtrap(task);
 				break;
 			case SIGPROF:
 				if(tracing) sig = 0;

--------------030501030700070005060500--


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
