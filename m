Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CKek9-0003HA-Ak for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 21 Oct 2004 08:20:45 -0700
Received: from plam.fujitsu-siemens.com ([217.115.66.9])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1CKek7-0007gV-Sy for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 21 Oct 2004 08:20:45 -0700
Message-ID: <4177D503.2030409@fujitsu-siemens.com>
From: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------000603010307030502030703"
Subject: [uml-devel] Bad handling of invalif systemcalls
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
Date: Thu, 21 Oct 2004 17:25:55 +0200
To: Jeff Dike <jdike@addtoit.com>, BlaisorBlade <blaisorblade_spam@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------000603010307030502030703
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

If a process in UML does a systemcall with the systemcall number
being less than 0, in TT-mode and SKAS-mode using SYSEMU, the
process is killed by an SIGTRAP instead of simply returning -ENOSYS.
In SKAS-mode without SYSEMU, UML even crashes, no matter if SYSEMU
is unsupported by the host or switched off in UML:

     Kernel panic - not syncing: handle_trap - failed to wait at end of syscall, errno = 4, status = 2943

The reason is, that UML can't distinguish between a debugger trap
and an systemcall interception. Currently, it checks the systemcall
number. If it is less than 0, it assumes the event to be a debugger
trap. It would be better to assume a debugger trap only, if the
syscall number is -1 (which it is guaranteed to be in case of a
debugger event), but even then UML wouldn't be safe. Syscalls with
syscall number -1 still would be a problem!

AFAICS, the only solution for this is using the PTRACE_O_TRACESYSGOOD
option. This option seems to be specific for linux, but the problem
maybe is specific for linux, too.

So, here attached are three patches. The first adds a check for
availability and function of
     ptrace(PTRACE_SETOPTIONS,,,PTRACE_O_TRACESYSGOOD) to the normal
ptrace checks.

The second implements the usage of the option in SKAS-mode.

The third does the same for TT-mode.

For the third patch I'm quite anxious, that there could go something
wrong when using the debugger. I don't understand much about this.
Maybe someone else could look into this?

Regards
Bodo

--------------000603010307030502030703
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

--- a/arch/um/kernel/process.c	2004-10-21 11:53:30.637195537 +0200
+++ b/arch/um/kernel/process.c	2004-10-21 11:59:49.758543527 +0200
@@ -13,6 +13,7 @@
 #include <setjmp.h>
 #include <sys/time.h>
 #include <sys/ptrace.h>
+#include <linux/ptrace.h>
 #include <sys/wait.h>
 #include <sys/mman.h>
 #include <asm/ptrace.h>
@@ -255,6 +256,9 @@
 	printk("Checking that ptrace can change system call numbers...");
 	pid = start_ptraced_child(&stack);
 
+	if(ptrace(PTRACE_SETOPTIONS, pid, 0, (void *)PTRACE_O_TRACESYSGOOD) < 0)
+		panic("check_ptrace: PTRACE_SETOPTIONS failed, errno = %d", errno);
+
 	while(1){
 		if(ptrace(PTRACE_SYSCALL, pid, 0, 0) < 0)
 			panic("check_ptrace : ptrace failed, errno = %d", 
@@ -262,8 +266,8 @@
 		CATCH_EINTR(n = waitpid(pid, &status, WUNTRACED));
 		if(n < 0)
 			panic("check_ptrace : wait failed, errno = %d", errno);
-		if(!WIFSTOPPED(status) || (WSTOPSIG(status) != SIGTRAP))
-			panic("check_ptrace : expected SIGTRAP, "
+		if(!WIFSTOPPED(status) || (WSTOPSIG(status) != (SIGTRAP + 0x80)))
+			panic("check_ptrace : expected SIGTRAP + 0x80, "
 			      "got status = %d", status);
 		
 		syscall = ptrace(PTRACE_PEEKUSER, pid, PT_SYSCALL_NR_OFFSET,

--------------000603010307030502030703
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

--- a/arch/um/kernel/skas/process.c	2004-10-21 10:50:27.770336304 +0200
+++ b/arch/um/kernel/skas/process.c	2004-10-21 11:34:50.764261057 +0200
@@ -11,6 +11,7 @@
 #include <sched.h>
 #include <sys/wait.h>
 #include <sys/ptrace.h>
+#include <linux/ptrace.h>
 #include <sys/mman.h>
 #include <sys/user.h>
 #include <asm/unistd.h>
@@ -54,14 +55,9 @@
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
@@ -76,7 +72,7 @@
 			      "errno = %d\n", errno);
 
 		CATCH_EINTR(err = waitpid(pid, &status, WUNTRACED));
-		if((err < 0) || !WIFSTOPPED(status) || (WSTOPSIG(status) != SIGTRAP))
+		if((err < 0) || !WIFSTOPPED(status) || (WSTOPSIG(status) != (SIGTRAP + 0x80)))
 			panic("handle_trap - failed to wait at end of syscall, "
 			      "errno = %d, status = %d\n", errno, status);
 	}
@@ -124,6 +120,10 @@
 		panic("start_userspace : expected SIGSTOP, got status = %d",
 		      status);
 
+	if (ptrace(PTRACE_SETOPTIONS, pid, NULL, (void *)PTRACE_O_TRACESYSGOOD) < 0)
+		panic("start_userspace : PTRACE_SETOPTIONS failed, errno=%d\n", 
+		      errno);
+
 	if(munmap(stack, PAGE_SIZE) < 0)
 		panic("start_userspace : munmap failed, errno = %d\n", errno);
 
@@ -160,9 +160,13 @@
 			case SIGSEGV:
 				handle_segv(pid);
 				break;
-			case SIGTRAP:
+			case SIGTRAP + 0x80:
 			        handle_trap(pid, regs, local_using_sysemu);
 				break;
+			case SIGTRAP:
+				UPT_SYSCALL_NR(regs) = -1;
+				relay_signal(SIGTRAP, regs);
+				break;
 			case SIGIO:
 			case SIGVTALRM:
 			case SIGILL:

--------------000603010307030502030703
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

--- a/arch/um/kernel/tt/include/tt.h	2004-10-21 15:00:19.909225710 +0200
+++ b/arch/um/kernel/tt/include/tt.h	2004-10-21 15:00:49.982255966 +0200
@@ -27,6 +27,7 @@
 extern void syscall_handler(int sig, union uml_pt_regs *regs);
 extern void exit_kernel(int pid, void *task);
 extern int do_syscall(void *task, int pid);
+extern void do_sigtrap(void *task);
 extern int is_valid_pid(int pid);
 extern void remap_data(void *segment_start, void *segment_end, int w);
 
--- a/arch/um/kernel/tt/tracer.c	2004-10-21 14:35:01.568140412 +0200
+++ b/arch/um/kernel/tt/tracer.c	2004-10-21 15:42:09.283536999 +0200
@@ -13,6 +13,7 @@
 #include <string.h>
 #include <sys/mman.h>
 #include <sys/ptrace.h>
+#include <linux/ptrace.h>
 #include <sys/time.h>
 #include <sys/wait.h>
 #include "user.h"
@@ -71,6 +72,8 @@
 	   (ptrace(PTRACE_CONT, pid, 0, 0) < 0))
 		tracer_panic("OP_FORK failed to attach pid");
 	wait_for_stop(pid, SIGSTOP, PTRACE_CONT, NULL);
+	if (ptrace(PTRACE_SETOPTIONS, pid, 0, (void *)PTRACE_O_TRACESYSGOOD) < 0)
+		tracer_panic("OP_FORK: PTRACE_SETOPTIONS failed, errno = %d", errno);
 	if(ptrace(PTRACE_CONT, pid, 0, 0) < 0)
 		tracer_panic("OP_FORK failed to continue process");
 }
@@ -141,7 +144,7 @@
 	 * any more, the trace of those will land here.  So, we need to just 
 	 * PTRACE_SYSCALL it.
 	 */
-	case SIGTRAP:
+	case (SIGTRAP + 0x80):
 		if(ptrace(PTRACE_SYSCALL, pid, 0, 0) < 0)
 			tracer_panic("sleeping_process_signal : Failed to "
 				     "PTRACE_SYSCALL pid %d, errno = %d\n",
@@ -196,6 +199,10 @@
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
@@ -323,14 +330,22 @@
 				 */
 				pid = cpu_tasks[proc_id].pid;
 				break;
+			case (SIGTRAP + 0x80):
+				if(!tracing && (debugger_pid != -1)){
+					child_signal(pid, status&0x7fff);
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
--- a/arch/um/kernel/tt/syscall_user.c	2004-10-21 15:02:31.903412902 +0200
+++ b/arch/um/kernel/tt/syscall_user.c	2004-10-21 14:59:58.836708066 +0200
@@ -43,21 +43,19 @@
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
--- a/arch/um/kernel/tt/exec_user.c	2004-10-21 15:37:21.876032761 +0200
+++ b/arch/um/kernel/tt/exec_user.c	2004-10-21 15:38:38.940297443 +0200
@@ -10,6 +10,7 @@
 #include <errno.h>
 #include <sys/wait.h>
 #include <sys/ptrace.h>
+#include <linux/ptrace.h>
 #include <signal.h>
 #include "user_util.h"
 #include "kern_util.h"
@@ -37,6 +38,9 @@
 
 	kill(old_pid, SIGKILL);
 
+	if (ptrace(PTRACE_SETOPTIONS, new_pid, 0, (void *)PTRACE_O_TRACESYSGOOD) < 0)
+		tracer_panic("do_exec: PTRACE_SETOPTIONS failed, errno = %d", errno);
+
 	if(ptrace_setregs(new_pid, regs) < 0)
 		tracer_panic("do_exec failed to start new proc - errno = %d",
 			     errno);

--------------000603010307030502030703--


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
