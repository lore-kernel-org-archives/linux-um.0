Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CMpk4-0000FC-M1 for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 27 Oct 2004 08:29:40 -0700
Received: from plam.fujitsu-siemens.com ([217.115.66.9])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1CMpk1-0006hw-OE for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 27 Oct 2004 08:29:39 -0700
Message-ID: <417FBB39.30003@fujitsu-siemens.com>
From: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------000102050909080008070607"
Subject: [uml-devel] New breakout from UML
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
Date: Wed, 27 Oct 2004 17:14:01 +0200
To: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-devel@lists.sourceforge.net, BlaisorBlade <blaisorblade_spam@yahoo.it>

This is a multi-part message in MIME format.
--------------000102050909080008070607
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by
	plam.fujitsu-siemens.com id i9RFE6t05233

There is another possibility to break out from UML and execute
syscalls on the host!

The problem is, that after having done ptrace_notify() in
syscall_trace(), we could be restarted with PTRACE_SINGLESTEP,
but will not execute do_signal(), since the debugger stop was not
initiated by a real signal! Thus the next instruction to process
isn't checked and is singlestepped even if it is a syscall.

The sequence for breaking out is:
1) PTRACE_SYSCALL until the syscall-exit tracepoint is reached.
2) modify the registers of the traced process to meet the parameters
    and syscall number wanted
3) lower EIP of the traced process by 2, for syscall restarting
4) proceed with PTRACE_SINGLESTEP --> Breakout!

I've included this as a new test case in breakout.c. It's test case 4.
The old test case 4 is moved to 5.

Further I've written a new test, which tests singlestepping in case of
a signal handler being called. In 2.6.9 on i386, singlestepping is
continued in the signal handler. UML 2.6.9 should do the same, I think.
Running the new test on UML, I saw singlestepping being broken in some
cases. The traced p=FCrocess suddenly continued with PTRACE_CONT!
I think, the reason is a signal other than SIGTRAP interrupting the
process (maybe a SIGSEGV/pagefault?). After having processed that event,
the kernel continues the userspace instead of singlestepping it.
Thus, we have to remember PT_DTRACE and not reset it!
Also, the test showed some differences between singlestepping on i386
and UML. It tries to singlestep 3 cases:
1) singlestepping a sigsuspend(), that waits for a SIGALRM
    signal handling is called from sys_sigsuspend() here
2) singlestepping a kill(getpid(), SIGALRM)
    signal_handling is called on the return from syscall
3) singlestepping a program loop without syscalls, waiting for SIGALRM
    signal_handling is called on return from kernel (after a interrupt /
    rescheduling)

The attached patch should:
- fix the breakout
   - set TIF_SIGPENDING after calling ptrace_notify()
- fix the broken singlestepping
   - don't reset PT_DTRACE/singlestep_syscall while singlestepping
   - reset flags from ptrace_disable() and sys_ptrace() only.
- make singlestepping on UML behave the same as on 2.6.9 i386
   - not only set singlestep_syscall if is_syscall(), but also reset
     it if !is_syscall()
   - call ptrace_notify(), if a signal handler stackframe is generated
     (setting TIF_SIGPENDING not needed here)
   - remove force_sig(SIGTRAP) from execute_syscall_* and let
     ptrace_notify() be called from syscall_trace() in case of
     singlestepping.

I've tested the patch on hosts running 2.6.7 and 2.6.9 in TT and SKAS
with and without SYSEMU. (2.6.9 needs skas3.v6 + my latest patch)
I couldn't see any differences between the 6 cases.
And calling "step_sighdlr debug" shows the tracepoints to be exactly the
same on UML and i386. Only speed / timing let the output vary.

Both new tests are attached.

Bodo

--------------000102050909080008070607
Content-Type: text/plain;
 name="patch-singlestep-sighdlr"
Content-Disposition: inline;
 filename="patch-singlestep-sighdlr"
Content-Transfer-Encoding: 7bit

diff -pur a/arch/um/kernel/process_kern.c b/arch/um/kernel/process_kern.c
--- a/arch/um/kernel/process_kern.c	2004-10-26 18:50:23.542150873 +0200
+++ b/arch/um/kernel/process_kern.c	2004-10-26 16:28:43.728794504 +0200
@@ -408,8 +408,6 @@ int singlestepping(void * t)
 	if ( ! (task->ptrace & PT_DTRACE) )
 		return(0);
 
-	task->ptrace &= ~PT_DTRACE;
-
 	if (task->thread.singlestep_syscall)
 		return(0);
 
diff -pur a/arch/um/kernel/ptrace.c b/arch/um/kernel/ptrace.c
--- a/arch/um/kernel/ptrace.c	2004-10-26 18:50:33.677475951 +0200
+++ b/arch/um/kernel/ptrace.c	2004-10-26 16:42:41.613329208 +0200
@@ -24,6 +24,8 @@
  */
 void ptrace_disable(struct task_struct *child)
 { 
+	child->ptrace &= ~PT_DTRACE;
+	child->thread.singlestep_syscall = 0;
 }
 
 long sys_ptrace(long request, long pid, long addr, long data)
@@ -143,6 +145,8 @@ long sys_ptrace(long request, long pid, 
 		ret = -EIO;
 		if ((unsigned long) data > _NSIG)
 			break;
+		child->ptrace &= ~PT_DTRACE;
+		child->thread.singlestep_syscall = 0;
 		if (request == PTRACE_SYSCALL) {
 			set_tsk_thread_flag(child, TIF_SYSCALL_TRACE);
 		}
@@ -164,6 +168,8 @@ long sys_ptrace(long request, long pid, 
 		ret = 0;
 		if (child->state == TASK_ZOMBIE)	/* already dead */
 			break;
+		child->ptrace &= ~PT_DTRACE;
+		child->thread.singlestep_syscall = 0;
 		child->exit_code = SIGKILL;
 		wake_up_process(child);
 		break;
@@ -175,6 +181,7 @@ long sys_ptrace(long request, long pid, 
 			break;
 		clear_tsk_thread_flag(child, TIF_SYSCALL_TRACE);
 		child->ptrace |= PT_DTRACE;
+		child->thread.singlestep_syscall = 0;
 		child->exit_code = data;
 		/* give it a chance to run. */
 		wake_up_process(child);
@@ -303,6 +310,8 @@ long sys_ptrace(long request, long pid, 
 
 void syscall_trace(union uml_pt_regs *regs, int entryexit)
 {
+	int is_singlestep = (current->ptrace & PT_DTRACE) && entryexit;
+
 	if (unlikely(current->audit_context)) {
 		if (!entryexit)
 			audit_syscall_entry(current, regs->orig_eax,
@@ -312,15 +321,16 @@ void syscall_trace(union uml_pt_regs *re
 			audit_syscall_exit(current, regs->eax);
 	}
 
-	if (!test_thread_flag(TIF_SYSCALL_TRACE))
+	if (!test_thread_flag(TIF_SYSCALL_TRACE) && !is_singlestep)
 		return;
 	if (!(current->ptrace & PT_PTRACED))
 		return;
 
 	/* the 0x80 provides a way for the tracing parent to distinguish
 	   between a syscall stop and SIGTRAP delivery */
-	ptrace_notify(SIGTRAP | ((current->ptrace & PT_TRACESYSGOOD)
-				 ? SYSCALL_TRAP : 0));
+	ptrace_notify(SIGTRAP | (((current->ptrace & PT_TRACESYSGOOD) &&
+				 !is_singlestep) ? SYSCALL_TRAP : 0));
+	set_thread_flag(TIF_SIGPENDING); /* force do_signal() --> is_syscall() */
 
 	/*
 	 * this isn't the same as continuing with a signal, but it will do
diff -pur a/arch/um/kernel/signal_kern.c b/arch/um/kernel/signal_kern.c
--- a/arch/um/kernel/signal_kern.c	2004-10-26 18:49:53.885051881 +0200
+++ b/arch/um/kernel/signal_kern.c	2004-10-26 18:25:13.287729206 +0200
@@ -133,9 +133,9 @@ static int kern_do_signal(struct pt_regs
 	 * on the host.  The tracing thread will check this flag and 
 	 * PTRACE_SYSCALL if necessary.
 	 */
-	if((current->ptrace & PT_DTRACE) && 
-	   is_syscall(PT_REGS_IP(&current->thread.regs)))
-		current->thread.singlestep_syscall = 1;
+	if(current->ptrace & PT_DTRACE) 
+		current->thread.singlestep_syscall =
+	   		is_syscall(PT_REGS_IP(&current->thread.regs));
 	return(handled_sig);
 }
 
diff -pur a/arch/um/kernel/skas/syscall_kern.c b/arch/um/kernel/skas/syscall_kern.c
--- a/arch/um/kernel/skas/syscall_kern.c	2004-10-26 18:50:23.542150873 +0200
+++ b/arch/um/kernel/skas/syscall_kern.c	2004-10-26 18:22:46.885922957 +0200
@@ -28,11 +28,6 @@ long execute_syscall_skas(void *r)
 		res = -ENOSYS;
 	else res = EXECUTE_SYSCALL(syscall, regs);
 
-	if(current->thread.singlestep_syscall){
-		current->thread.singlestep_syscall = 0;
-		force_sig(SIGTRAP, current);
-	}
-
 	return(res);
 }
 
diff -pur a/arch/um/kernel/tt/syscall_kern.c b/arch/um/kernel/tt/syscall_kern.c
--- a/arch/um/kernel/tt/syscall_kern.c	2004-10-26 18:50:23.543150707 +0200
+++ b/arch/um/kernel/tt/syscall_kern.c	2004-10-26 18:23:19.266571866 +0200
@@ -30,11 +30,6 @@ long execute_syscall_tt(void *r)
 		res = -ENOSYS;
 	else res = EXECUTE_SYSCALL(syscall, regs);
 
-	if(current->thread.singlestep_syscall){
-		current->thread.singlestep_syscall = 0;
-		force_sig(SIGTRAP, current);
-	}
-
 	return(res);
 }
 
diff -pur a/arch/um/sys-i386/signal.c b/arch/um/sys-i386/signal.c
--- a/arch/um/sys-i386/signal.c	2004-10-26 18:49:53.870054359 +0200
+++ b/arch/um/sys-i386/signal.c	2004-10-26 18:13:34.805157517 +0200
@@ -4,6 +4,7 @@
  */
 
 #include "linux/signal.h"
+#include "linux/ptrace.h"
 #include "asm/current.h"
 #include "asm/ucontext.h"
 #include "asm/uaccess.h"
@@ -244,6 +245,9 @@ int setup_signal_stack_sc(unsigned long 
 	PT_REGS_EAX(regs) = (unsigned long) sig;
 	PT_REGS_EDX(regs) = (unsigned long) 0;
 	PT_REGS_ECX(regs) = (unsigned long) 0;
+
+	if ((current->ptrace & PT_DTRACE) && (current->ptrace & PT_PTRACED))
+		ptrace_notify(SIGTRAP);
 	return(0);
 }
 
@@ -292,6 +296,8 @@ int setup_signal_stack_si(unsigned long 
 	PT_REGS_EDX(regs) = (unsigned long) &frame->info;
 	PT_REGS_ECX(regs) = (unsigned long) &frame->uc;
 
+	if ((current->ptrace & PT_DTRACE) && (current->ptrace & PT_PTRACED))
+		ptrace_notify(SIGTRAP);
 	return(0);
 }
 

--------------000102050909080008070607
Content-Type: text/plain;
 name="breakout.c"
Content-Disposition: inline;
 filename="breakout.c"
Content-Transfer-Encoding: 7bit

/*
 *  breakout.c
 *
 *  Testtool for UML
 *  This tool tries to breakout from UML or to crash UML
 *  Hopefully it has no success!
 *
 *  Copyright (C) 2004 Fujitsu Siemens Computers GmbH
 *  Author: Bodo Stroesser (bodo.stroesser@fujitsu-siemens.com)
 *
 *  Licensed under the GPL
 */

#define VERSION_STRING "breakout  V1.0"
#include <stdio.h>
#include <signal.h>
#include <sched.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <sys/mman.h>
#include <sys/ptrace.h>
#include <asm/ptrace.h>
#include <unistd.h>
#include <asm/unistd.h>
#include <errno.h>

volatile int * stepme;


int
parent_fn( pid_t child)
{
	int ret, status;
	unsigned long code, eip;
	static int count = 0;

	printf("Parent: childs PID is %d\n", child);

	while (1) {
		ret = waitpid( child, &status, 0);
		if ( ret != child ) {
			fprintf( stderr, "Parent: ");
			perror("waitpid");
			exit(1);
		}
		if ( WIFSTOPPED(status) && WSTOPSIG(status) == SIGTRAP ) {
			errno = 0;
			eip = ptrace( PTRACE_PEEKUSER, child, (void *)(EIP*4), (void *)0);
			if ( errno ) {
				fprintf( stderr, "Parent: ");
				perror("ptrace( PTRACE_PEEKUSER, child, EIP, 0)");
				exit(1);
			}
			printf("Parent: eip = 0x%08x, ", eip);
			code = ptrace( PTRACE_PEEKTEXT, child, eip, (void *)0);
			if ( errno )
				printf("ptrace( PTRACE_PEEKTEXT, child, eip, 0): %s", strerror( errno));
			printf("code = %02x %02x %02x %02x, ",
				code&0xff, (code>>8)&0xff, (code>>16)&0xff, (code>>24)&0xff);
			if ( (code & 0xffff) == 0x80cd || (code & 0xffff) == 0x340f )
				printf("SYSCALL!, ");
			else
				printf("          ");
			if ( *stepme == 2 ) {
				if ( ++count == 3 ) {
					errno = 0;
					ptrace( PTRACE_POKEUSER, child, (void *)(EIP*4), (void *)(eip-2));
					if ( errno ) {
						fprintf( stderr, "Parent: ");
						perror("ptrace( PTRACE_POKEUSER, child, EIP, eip-2)");
						exit(1);
					}
					ptrace( PTRACE_POKEUSER, child, (void *)(EAX*4), (void *)__NR_getpid);
					if ( errno ) {
						fprintf( stderr, "Parent: ");
						perror("ptrace( PTRACE_POKEUSER, child, EAX, __NR_getpid)");
						exit(1);
					}
					*stepme = 1;
				}
				else {
					printf("Doing SYSCALL_TRACE ...\n");
					fflush( stdout);
					if ( ptrace( PTRACE_SYSCALL, child, (void *)0, (void *)0) < 0 ) {
						fprintf( stderr, "Parent: ");
						perror("ptrace( PTRACE_SYSCALL, child, 0, 0)");
						exit(1);
					}
				}
			}
			if ( *stepme == 1 ) {
				printf("Doing SINGLESTEP ...\n");
				fflush( stdout);
				if ( ptrace( PTRACE_SINGLESTEP, child, (void *)0, (void *)0) < 0 ) {
					fprintf( stderr, "Parent: ");
					perror("ptrace( PTRACE_SINGLESTEP, child, 0, 0)");
					exit(1);
				}
			}
			else if ( *stepme == 0 ) {
				printf("Doing CONTINUE ...\n");
				fflush( stdout);
				if ( ptrace( PTRACE_CONT, child, (void *)0, (void *)0) < 0 ) {
					fprintf( stderr, "Parent: ");
					perror("ptrace( PTRACE_CONT, child, 0, 0)");
					exit(1);
				}
				count = 0;
			}
		}
		else {
			printf("\nParent: Childs status is %x: exiting\n", status);
			return (status != 0);
		}
	}
}


int getpid_sysenter(void)
{
	long res;
	__asm__ volatile ("	call 1f\n\t"
			"	jmp  2f\n\t"
			"1:	push %%ecx\n\t"
			"	push %%edx\n\t"
			"	push %%ebp\n\t"
			"	movl %%esp,%%ebp\n\t"
			"	sysenter\n\t"
			/* Note: the following code is for information only!
			 * It is never executed, since the kernel jumps to the
			 * vsyscall-page on return. This is hard-coded, because
			 * sysenter dosn't save a return address.
			 */
			"       pop  %%ebp\n\t"
			"       pop  %%edx\n\t"
			"       pop  %%ecx\n\t"
			"	ret\n\t"
			"2:	"
				: "=a" (res)
				: "0" (__NR_getpid));
	return res;
}

int getpid_int0x80(void)
{
	long res;
	__asm__ volatile ("	int $0x80\n\t"
				: "=a" (res)
				: "0" (__NR_getpid));
}

int getpid_vsyscall(void)
{
	long res;
	__asm__ volatile ("	call 0xffffe400\n\t"
				: "=a" (res)
				: "0" (__NR_getpid));
	return res;
}


int
child_fn( void)
{
	pid_t pid, mypid = getpid();

	printf("        Child: untraced: my PID is %d\n", mypid);
	fflush( stdout);

	if ( ptrace( PTRACE_TRACEME, 0, (void *)0, (void *)0) ) {
		fprintf( stderr, "        Child: ");
		perror("ptrace( PTRACE_TRACEME, 0, 0, 0)");
		exit(1);
	}
	kill( mypid, SIGTRAP);

	printf("\n========== Test Case 1: singlestep sycall via sysenter ==========\n\n");
	fflush( stdout);

	*stepme = 1;
	kill( mypid, SIGTRAP);
	pid = getpid_sysenter();
	*stepme = 0;
	printf("        Child: traced: my PID is %d\n", pid);
	fflush( stdout);
	if ( pid != mypid )
		return 1;

	printf("\n========== Test Case 2: singlestep sycall via int $0x80 ==========\n\n");
	fflush( stdout);

	*stepme = 1;
	kill( mypid, SIGTRAP);
	pid = getpid_int0x80();
	*stepme = 0;
	printf("        Child: traced: my PID is %d\n", pid);
	fflush( stdout);
	if ( pid != mypid )
		return 1;

	printf("\n========== Test Case 3: singlestep sycall via vsyscall-page ==========\n\n");
	fflush( stdout);

	*stepme = 1;
	kill( mypid, SIGTRAP);
	pid = getpid_vsyscall();
	*stepme = 0;
	printf("        Child: traced: my PID is %d\n", pid);
	fflush( stdout);
	if ( pid != mypid )
		return 1;

	printf("\n========== Test Case 4: trace sycall via int $0x80 (twice) ==========\n\n");
	fflush( stdout);

	*stepme = 2;
	kill( mypid, SIGTRAP);
	pid = getpid_int0x80();
	*stepme = 0;
	printf("        Child: traced: my PID is %d\n", pid);
	fflush( stdout);
	if ( pid != mypid )
		return 1;

	return 0;
}


int
main( void)
{
	int res;
	pid_t child;

	printf(VERSION_STRING "\n");

	stepme = mmap( NULL, 4096, PROT_WRITE|PROT_READ, MAP_SHARED|MAP_ANONYMOUS, 0, 0);
	if ( stepme == MAP_FAILED ) {
		perror("mmap");
		exit(1);
	}

	printf("Parent: my PID is %d\n", getpid());
	fflush( stdout);

	child = fork();

	if ( child < 0 ) {
		perror("fork");
		exit(1);
	}
	else if ( child ) {
		res = parent_fn( child);
		if ( res )
			return res;

		printf("\n========== Test Case 5: syscall(-1) ==========\n\n");
		__asm__ volatile ("	int $0x80\n\t"
					: "=a" (res)
					: "0" (-1));
		printf("Syscall( -1) returns %d\n", res);
		if ( res != -ENOSYS ) {
			printf("Syscall( -1): wrong result!!!!!\n");
			return 1;
		}

		printf("\n========== Test ended normally ==========\n");

		return 0;
	} else {
		res = child_fn();
		if ( res )
			printf("        Child: pid != traced pid --> BREAKOUT!!!\n");
		return res;
	}
}

--------------000102050909080008070607
Content-Type: text/plain;
 name="step_sighdlr.c"
Content-Disposition: inline;
 filename="step_sighdlr.c"
Content-Transfer-Encoding: 7bit

#include <signal.h>
#include <unistd.h>
#include <errno.h>
#include <stdio.h>
#include <sched.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <sys/mman.h>
#include <sys/ptrace.h>
#include <asm/ptrace.h>
#include <asm/unistd.h>

volatile int * stepme;


void sighdlr( int sig)
{
	*stepme = 2;
	printf("sighdlr(): signal %d caught\n", sig);
	fflush( stdout);
	*stepme = 4;
}

int
child_fn( void)
{
	int mypid = getpid();
	int ret, errno_sav;
	int result = 0;
	sigset_t set_b, set_ub;


	printf("Address of sighdlr(): %p\n", sighdlr);

	ret = sigprocmask( SIG_BLOCK, NULL, &set_b);
	if ( ret ) {
		perror("sigprocmask( SIG_BLOCK, NULL, &set_b)");
		exit(1);
	}
	memcpy( &set_ub, &set_b, sizeof( sigset_t));
	sigaddset( &set_b, SIGALRM);
	sigdelset( &set_ub, SIGALRM);

	*stepme = 0;
	if ( ptrace( PTRACE_TRACEME, 0, (void *)0, (void *)0) ) {
		perror("ptrace( PTRACE_TRACEME, 0, 0, 0)");
		exit(1);
	}

	printf("\n========== Test case 1: Singlestep signal handler: running while sigsuspend() ==========\n");
	fflush( stdout);
	ret = sigprocmask( SIG_SETMASK, &set_b, NULL);
	if ( ret ) {
		perror("sigprocmask( SIG_SETMASK, &set_b, NULL)");
		exit(1);
	}
	ret = (int )signal( SIGALRM, sighdlr);
	if ( ret == (int )SIG_ERR ) {
		perror("signal()");
		return 1;
	}
	ret = alarm( 1);
	if ( ret ) {
		perror("alarm()");
		return 1;
	}
	*(stepme+1) = 0;
	*stepme = 1;
	ret = kill( mypid, SIGTRAP);
	if ( ret ) {
		*stepme = 0;
		perror("kill( mypid, SIGTRAP");
		return 1;
	}
	ret = sigsuspend( &set_ub);
	*stepme = 8;
	if ( ret ) {
		errno_sav=errno;
		perror("sigsuspend()");
		if ( errno_sav != EINTR ) {
			printf("ERROR: sigsuspend() didn't return -EINTR\n");
			fflush( stdout);
			return 1;
		}
	} else {
		printf("ERROR: sigsuspend() returns O.K. --> this should never happen!\n");
		fflush( stdout);
		return 1;
	}

	if ( *(stepme+1) != 0x0f ) {
		printf("Failed: 0x%x\n", *(stepme+1));
		result+=2;
	}
	else
		printf("Succeeded\n");
	fflush( stdout);

	printf("\n========== Test case 2: Singlestep signal handler: started by kill( getpid(), SIGALRM) ==========\n");
	fflush( stdout);
	ret = sigprocmask( SIG_SETMASK, &set_ub, NULL);
	if ( ret ) {
		perror("sigprocmask( SIG_SETMASK, &set_ub, NULL)");
		exit(1);
	}
	ret = (int )signal( SIGALRM, sighdlr);
	if ( ret == (int )SIG_ERR ) {
		perror("signal()");
		return 1;
	}
	*(stepme+1) = 0;
	*stepme = 1;
	ret = kill( mypid, SIGTRAP);
	if ( ret ) {
		*stepme = 0;
		perror("kill( mypid, SIGTRAP");
		return 1;
	}
	ret = kill( mypid, SIGALRM);
	if ( ret ) {
		*stepme = 0;
		perror("kill( mypid, SIGALRM");
		return 1;
	}
	*stepme = 8;

	if ( *(stepme+1) != 0x0f ) {
		printf("Failed: 0x%x\n", *(stepme+1));
		result+=4;
	}
	else
		printf("Succeeded\n");
	fflush( stdout);

	printf("\n========== Test case 3: Singlestep signal handler: running while looping ==========\n");
	fflush( stdout);
	ret = sigprocmask( SIG_SETMASK, &set_ub, NULL);
	if ( ret ) {
		perror("sigprocmask( SIG_SETMASK, &set_ub, NULL)");
		exit(1);
	}
	ret = (int )signal( SIGALRM, sighdlr);
	if ( ret == (int )SIG_ERR ) {
		perror("signal()");
		return 1;
	}
	*(stepme+1) = 0;
	*stepme = 1;
	ret = alarm( 1);
	if ( ret ) {
		perror("alarm()");
		return 1;
	}
	ret = kill( mypid, SIGTRAP);
	if ( ret ) {
		*stepme = 0;
		perror("kill( mypid, SIGTRAP");
		return 1;
	}
	while ( *stepme == 1 ) ;
	*stepme = 8;

	if ( *(stepme+1) != 0x0f ) {
		printf("Failed: 0x%x\n", *(stepme+1));
		result+=8;
	}
	else
		printf("Succeeded\n");
	fflush( stdout);

	return result;
}


int
parent_fn( pid_t child, int debug)
{
	int ret, status, sig;
	unsigned long code, eip;
	unsigned long addrhist[4] = {0,0,0,0};
	int addrnum=0;
	int trace_this = 1;

	while (1) {
		ret = waitpid( child, &status, 0);
		if ( ret != child ) {
			fprintf( stderr, "Parent: ");
			perror("waitpid");
			exit(1);
		}
		if ( WIFSTOPPED(status) &&
		     (WSTOPSIG(status) == SIGTRAP || WSTOPSIG(status) == SIGALRM) ) {
			sig = WSTOPSIG(status);
			if ( debug ) {
				errno = 0;
				eip = ptrace( PTRACE_PEEKUSER, child, (void *)(EIP*4), (void *)0);
				if ( errno ) {
					fprintf( stderr, "Parent: ");
					perror("ptrace( PTRACE_PEEKUSER, 0, 0, 0)");
					exit(1);
				}
				if ( eip == addrhist[0] && eip == addrhist[1] &&
				     eip == addrhist[2] && eip == addrhist[3] ) {
					fprintf( stderr, "Parent: Can't get out of trace loop\n");
					exit(1);
				}
				if ( eip == addrhist[addrnum] && sig != SIGALRM ) {
					if ( trace_this ) {
						trace_this = 0;
						printf("Output stopped while looping\n");
						fflush( stdout);
					}
				} else {
					if ( !trace_this ) {
						trace_this = 1;
						printf("Output restarted after loop\n");
					}
				}
				addrhist[addrnum++] = eip;
				addrnum %= 4;
			}
			else 
				trace_this = 0;

			*(stepme+1) |= *stepme;
			if ( sig == SIGTRAP)
				sig = 0;
			else {
				printf("Signal SIGALRM traced");
				if ( trace_this )
					printf(" --->\n");
				else
					putchar('\n');
			}

			if ( trace_this ) {
				printf("Parent: eip = 0x%08x, ", eip);
				code = ptrace( PTRACE_PEEKTEXT, child, eip, (void *)0);
				if ( errno )
					printf("ptrace( PTRACE_PEEKUSER, 0, 0, 0): %s", strerror( errno));
				printf("code = %02x %02x %02x %02x, ",
					code&0xff, (code>>8)&0xff, (code>>16)&0xff, (code>>24)&0xff);
				if ( (code & 0xffff) == 0x80cd || (code & 0xffff) == 0x340f )
					printf("SYSCALL!, ");
				else
					printf("          ");
				printf("stepme=%d, ", *stepme);
			}

			if ( *stepme && *stepme != 8 ) {
				if ( trace_this )
					printf("Doing SINGLESTEP ...\n");
				fflush( stdout);
				if ( ptrace( PTRACE_SINGLESTEP, child, (void *)0, (void *)sig) < 0 ) {
					fprintf( stderr, "Parent: ");
					perror("ptrace( PTRACE_SINGLESTEP, 0, 0, 0)");
					exit(1);
				}
			}
			else {
				if ( trace_this )
					printf("Doing CONTINUE ...\n");
				fflush( stdout);
				if ( ptrace( PTRACE_CONT, child, (void *)0, (void *)sig) < 0 ) {
					fprintf( stderr, "Parent: ");
					perror("ptrace( PTRACE_CONT, 0, 0, 0)");
					exit(1);
				}
			}
		}
		else {
			printf("\nParent: Childs status is %x: exiting\n", status);
			fflush( stdout);
			return (status != 0);
		}
	}
}


int
main( int argc, char ** argv)
{
	int res;
	pid_t child;

	stepme = mmap( NULL, 4096, PROT_WRITE|PROT_READ, MAP_SHARED|MAP_ANONYMOUS, 0, 0);
	if ( stepme == MAP_FAILED ) {
		perror("mmap");
		exit(1);
	}

	child = fork();

	if ( child < 0 ) {
		perror("fork");
		exit(1);
	}
	else if ( child ) {
		res = parent_fn( child, (argc == 2 && ! strcmp("debug", argv[1])));
		return res;
	} else {
		res = child_fn();
		return res;
	}
}

--------------000102050909080008070607--


-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
