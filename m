Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CAAfo-00031e-NA for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 22 Sep 2004 10:12:56 -0700
Received: from plam.fujitsu-siemens.com ([217.115.66.9])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1CAAfm-000859-Iw for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 22 Sep 2004 10:12:56 -0700
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: [uml-devel] Minor problems with interrupted systemcalls
Message-ID: <8B6FF516CBA0194AB0996705076B02520F7C38@ABGEX01E.abg.fsc.net>
From: "Stroesser, Bodo" <Bodo.Stroesser@fujitsu-siemens.com>
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
Date: Wed, 22 Sep 2004 19:12:37 +0200
Content-Transfer-Encoding: 8bit
To: user-mode-linux-devel@lists.sourceforge.net
Cc: BlaisorBlade <blaisorblade_spam@yahoo.it>, Jeff Dike <jdike@addtoit.com>

On Tuesday 21 September 2004 19:31, BlaisorBlade wrote:

> ...
> Ignoring a return value for a good reason should always be documented
in the code as you did here - also, the i386 handle_signal() returns a
void, while here we must understand just how to handle this - should
kern_do_signal return 0 or 1?
> 
> Actually, do_signal is not standard among archs, and its return value
it's either ignored or used as whether the syscall is interrupted or not
(for sigsuspend and such, below).
> ...
> Yes, I agree they should be similar. Er, shouldn't the check "Did we
come from a syscall" be added like in i386 to handle_signal too? The
"ERESTART_*" 
handling in handle_signal is at least useless in case we are not
handling a syscall, and may cause bugs (I'm not sure here, but why
bother?).
> ...

Thank you for pointing out this!

Thinking about it lead me to a bug in the patch. Systemcall restarting
never was done, if a signal handler had to be started. The problem came
from removing the call to do_signal(result) in syscall_handler_tt() and
handle_syscall() (The argument "result" had been the syscall-result read
from the regs). Now do_signal() is called only with parameter "0" or
"-EINTR", so no syscall restart is done.

To fix the problem, I made a new patch. Now
- handle_signal() is void
- do_signal() no longer takes a parameter
- syscall restarting is always based on the result found in the regs and
is done only if "we come from a syscall"
- sys_sigsuspend() and sys_rt_sigsuspend() write -EINTR into the regs
before calling kern_do_signal()
- I did some reordering of the code in handle_signal()/kern_do_signal()
to be more similar to i386.
I hope, now it works correctly and the code is as similar to i386 as
possible.

I tested with 2.6.8.1-1 + incremental patches up to September 12, 2004
(hope, the tests were more complete than the last time ...), it works
fine for me. You'll find the new patch at the end of this mail.

There are two more issues:

- 2.6.8.1-1 panics on my host, which doesn't support sysemu. Last Monday
I wrote a mail "(no subject)"  (sorry, i missed to give it a title)
about this with a patch appended. This patch helps for me, but is it the
right place to patch? What did happen exactly?

- Did you read the last part of kern_do_signal() regarding
singlestepping syscalls? The comments are about tt-mode only (tracing
thread ...), but it's a problem in skas-mode too! I wrote a little test
that forks, then the child is singlestepped by the parent. In tt-mode it
works fine, but in skas-mode the singlestepped systemcalls are executed
on the host! Even more: bad guys could write a program using "sysenter"
instead of "int 0x80" and they could execute their syscall on the host
in tt- and skas-mode. I've tried to do that, and I could do it. Even the
hosts vsyscall-page helped me, because it is executable for user
programs in UML, but can't be read via ptrace( PEEKTEXT, ...). And: if a
invalid systemcall number is passed in eax, the host will skip all
syscall handling, so the next "singlestep"-trap visible to a uml-user
will be after the next valid systemcall. I am working to create a patch
for this all. Do you think, I should integrate it with the systemcall
restart patch below before sending to LKML?

Greets 
Bodo




--- orig/arch/um/kernel/tt/syscall_user.c	2004-09-22
12:46:00.508456961 +0200
+++ new/arch/um/kernel/tt/syscall_user.c	2004-09-22
12:49:23.409926312 +0200
@@ -17,10 +17,6 @@
 #include "syscall_user.h"
 #include "tt.h"
 
-/* XXX Bogus */
-#define ERESTARTSYS	512
-#define ERESTARTNOINTR	513
-#define ERESTARTNOHAND	514
 
 void syscall_handler_tt(int sig, union uml_pt_regs *regs)
 {
@@ -42,9 +38,6 @@
 	UPT_SC(regs) = sc;
 
 	SC_SET_SYSCALL_RETURN(sc, result);
-	if((result == -ERESTARTNOHAND) || (result == -ERESTARTSYS) || 
-	   (result == -ERESTARTNOINTR))
-		do_signal(result);
 
 	syscall_trace(regs, 0);
 	record_syscall_end(index, result);
@@ -63,7 +56,7 @@
 	regs = TASK_REGS(task);
 	UPT_SYSCALL_NR(regs) = syscall;
 
-	if(syscall < 1) return(0);
+	if(syscall < 0) return(0);
 
 	if((syscall != __NR_sigreturn) &&
 	   ((unsigned long *) PT_IP(proc_regs) >= &_stext) && 
--- orig/arch/um/kernel/skas/syscall_user.c	2004-09-22
12:45:54.685419251 +0200
+++ new/arch/um/kernel/skas/syscall_user.c	2004-09-22
12:49:23.409926312 +0200
@@ -10,10 +10,6 @@
 #include "sysdep/ptrace.h"
 #include "sysdep/sigcontext.h"
 
-/* XXX Bogus */
-#define ERESTARTSYS	512
-#define ERESTARTNOINTR	513
-#define ERESTARTNOHAND	514
 
 void handle_syscall(union uml_pt_regs *regs)
 {
@@ -26,9 +22,6 @@
 	result = execute_syscall(regs);
 
 	REGS_SET_SYSCALL_RETURN(regs->skas.regs, result);
-	if((result == -ERESTARTNOHAND) || (result == -ERESTARTSYS) || 
-	   (result == -ERESTARTNOINTR))
-		do_signal(result);
 
 	syscall_trace(regs, 0);
 	record_syscall_end(index, result);
--- orig/arch/um/kernel/skas/process.c	2004-09-22 12:46:00.508456961
+0200
+++ new/arch/um/kernel/skas/process.c	2004-09-22 13:33:58.479855435
+0200
@@ -63,7 +63,7 @@
 
 	syscall_nr = PT_SYSCALL_NR(regs->skas.regs);
 	UPT_SYSCALL_NR(regs) = syscall_nr;
-	if(syscall_nr < 1){
+	if(syscall_nr < 0){
 		relay_signal(SIGTRAP, regs);
 		return;
 	}
--- orig/arch/um/kernel/process_kern.c	2004-09-22 12:45:54.679420243
+0200
+++ new/arch/um/kernel/process_kern.c	2004-09-22 13:19:07.593079661
+0200
@@ -137,7 +137,7 @@
 void interrupt_end(void)
 {
 	if(need_resched()) schedule();
-	if(test_tsk_thread_flag(current, TIF_SIGPENDING)) do_signal(0);
+	if(test_tsk_thread_flag(current, TIF_SIGPENDING)) do_signal();
 }
 
 void release_thread(struct task_struct *task)
--- orig/arch/um/kernel/signal_kern.c	2004-09-22 12:45:54.681419912
+0200
+++ new/arch/um/kernel/signal_kern.c	2004-09-22 13:46:01.701338876
+0200
@@ -49,48 +49,53 @@
 /*
  * OK, we're invoking a handler
  */	
-static int handle_signal(struct pt_regs *regs, unsigned long signr, 
-			 struct k_sigaction *ka, siginfo_t *info, 
-			 sigset_t *oldset, int error)
+static void handle_signal(struct pt_regs *regs, unsigned long signr, 
+			  siginfo_t *info, sigset_t *oldset)
 {
-        __sighandler_t handler;
+	struct k_sigaction *ka = &current->sighand->action[signr -1];
 	void (*restorer)(void);
 	unsigned long sp;
-	sigset_t save;
-	int err, ret;
+	int err;
 
-	ret = 0;
 	/* Always make any pending restarted system calls return -EINTR
*/
 	current_thread_info()->restart_block.fn = do_no_restart_syscall;
-	switch(error){
-	case -ERESTART_RESTARTBLOCK:
-	case -ERESTARTNOHAND:
-		ret = -EINTR;
-		break;
-
-	case -ERESTARTSYS:
-		if (!(ka->sa.sa_flags & SA_RESTART)) {
-			ret = -EINTR;
-			break;
+
+	/* Did we come from a system call? */
+	if(PT_REGS_SYSCALL_NR(regs) >= 0){
+		/* If so, check system call restarting.. */
+		switch(PT_REGS_SYSCALL_RET(regs)){
+			case -ERESTART_RESTARTBLOCK:
+			case -ERESTARTNOHAND:
+				PT_REGS_SYSCALL_RET(regs) = -EINTR;
+				break;
+
+			case -ERESTARTSYS:
+				if (!(ka->sa.sa_flags & SA_RESTART)) {
+					PT_REGS_SYSCALL_RET(regs) =
-EINTR;
+					break;
+				}
+			/* fallthrough */
+			case -ERESTARTNOINTR:
+				PT_REGS_RESTART_SYSCALL(regs);
+				PT_REGS_ORIG_SYSCALL(regs) =
PT_REGS_SYSCALL_NR(regs);
 		}
-		/* fallthrough */
-	case -ERESTARTNOINTR:
-		PT_REGS_RESTART_SYSCALL(regs);
-		PT_REGS_ORIG_SYSCALL(regs) = PT_REGS_SYSCALL_NR(regs);
-
-		/* This is because of the UM_SET_SYSCALL_RETURN and the
fact
-		 * that on i386 the system call number and return value
are
-		 * in the same register.  When the system call restarts,
%eax
-		 * had better have the system call number in it.  Since
the
-		 * return value doesn't matter (except that it shouldn't
be
-		 * -ERESTART*), we'll stick the system call number
there.
-		 */
-		ret = PT_REGS_SYSCALL_NR(regs);
-		break;
 	}
 
-	handler = ka->sa.sa_handler;
-	save = *oldset;
+	sp = PT_REGS_SP(regs);
+	if((ka->sa.sa_flags & SA_ONSTACK) && (sas_ss_flags(sp) == 0))
+		sp = current->sas_ss_sp + current->sas_ss_size;
+	
+	if (ka->sa.sa_flags & SA_RESTORER) restorer =
ka->sa.sa_restorer;
+	else restorer = NULL;
+
+	if(ka->sa.sa_flags & SA_SIGINFO)
+		err = setup_signal_stack_si(sp, signr, (unsigned long)
ka->sa.sa_handler,
+					    restorer, regs, info,
oldset);
+	else
+		err = setup_signal_stack_sc(sp, signr, (unsigned long)
ka->sa.sa_handler,
+					    restorer, regs, oldset);
+	if(err)
+		force_segv(signr);
 
 	if (ka->sa.sa_flags & SA_ONESHOT)
 		ka->sa.sa_handler = SIG_DFL;
@@ -104,47 +109,23 @@
 		spin_unlock_irq(&current->sighand->siglock);
 	}
 
-	sp = PT_REGS_SP(regs);
-
-	if((ka->sa.sa_flags & SA_ONSTACK) && (sas_ss_flags(sp) == 0))
-		sp = current->sas_ss_sp + current->sas_ss_size;
-	
-	if(error != 0) PT_REGS_SET_SYSCALL_RETURN(regs, ret);
-
-	if (ka->sa.sa_flags & SA_RESTORER) restorer =
ka->sa.sa_restorer;
-	else restorer = NULL;
-
-	if(ka->sa.sa_flags & SA_SIGINFO)
-		err = setup_signal_stack_si(sp, signr, (unsigned long)
handler,
-					    restorer, regs, info,
&save);
-	else
-		err = setup_signal_stack_sc(sp, signr, (unsigned long)
handler,
-					    restorer, regs, &save);
-	if(err) goto segv;
-
-	return(0);
- segv:
-	force_segv(signr);
-	return(1);
+	return;
 }
 
-static int kern_do_signal(struct pt_regs *regs, sigset_t *oldset, int
error)
+static int kern_do_signal(struct pt_regs *regs, sigset_t *oldset)
 {
 	siginfo_t info;
-	struct k_sigaction *ka;
-	int err, sig;
+	int sig;
 
 	if (!oldset)
 		oldset = &current->blocked;
 
 	sig = get_signal_to_deliver(&info, regs, NULL);
-	if(sig == 0)
-		return(0);
-
-	/* Whee!  Actually deliver the signal.  */
-	ka = &current->sighand->action[sig -1 ];
-	err = handle_signal(regs, sig, ka, &info, oldset, error);
-	if(!err) return(1);
+	if(sig > 0) {
+		/* Whee!  Actually deliver the signal.  */
+		handle_signal(regs, sig, &info, oldset);
+		return(1);
+	}
 
 	/* Did we come from a system call? */
 	if(PT_REGS_SYSCALL_NR(regs) >= 0){
@@ -174,9 +155,9 @@
 	return(0);
 }
 
-int do_signal(int error)
+int do_signal( void)
 {
-	return(kern_do_signal(&current->thread.regs, NULL, error));
+	return(kern_do_signal(&current->thread.regs, NULL));
 }
 
 /*
@@ -193,10 +174,11 @@
 	recalc_sigpending();
 	spin_unlock_irq(&current->sighand->siglock);
 
+	PT_REGS_SYSCALL_RET(&current->thread.regs) = -EINTR;
 	while (1) {
 		current->state = TASK_INTERRUPTIBLE;
 		schedule();
-		if(kern_do_signal(&current->thread.regs, &saveset,
-EINTR))
+		if(kern_do_signal(&current->thread.regs, &saveset))
 			return(-EINTR);
 	}
 }
@@ -219,10 +201,11 @@
 	recalc_sigpending();
 	spin_unlock_irq(&current->sighand->siglock);
 
+	PT_REGS_SYSCALL_RET(&current->thread.regs) = -EINTR;
 	while (1) {
 		current->state = TASK_INTERRUPTIBLE;
 		schedule();
-		if (kern_do_signal(&current->thread.regs, &saveset,
-EINTR))
+		if (kern_do_signal(&current->thread.regs, &saveset))
 			return(-EINTR);
 	}
 }
--- orig/arch/um/include/kern_util.h	2004-09-22 12:45:54.661423217
+0200
+++ new/arch/um/include/kern_util.h	2004-09-22 13:18:39.944648725
+0200
@@ -29,7 +29,7 @@
 extern void syscall_segv(int sig);
 extern int current_pid(void);
 extern unsigned long alloc_stack(int order, int atomic);
-extern int do_signal(int error);
+extern int do_signal(void);
 extern int is_stack_fault(unsigned long sp);
 extern unsigned long segv(unsigned long address, unsigned long ip, 
 			  int is_write, int is_user, void *sc);


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
