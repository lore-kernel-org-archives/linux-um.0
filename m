Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CNXza-0007i1-Uh for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 29 Oct 2004 07:44:38 -0700
Received: from plam.fujitsu-siemens.com ([217.115.66.9])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1CNXzW-000814-1L for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 29 Oct 2004 07:44:38 -0700
Message-ID: <41825719.8060702@fujitsu-siemens.com>
From: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------090704090409080501090207"
Subject: [uml-devel] Testtools
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
Date: Fri, 29 Oct 2004 16:43:37 +0200
To: Jeff Dike <jdike@addtoit.com>
Cc: BlaisorBlade <blaisorblade_spam@yahoo.it>, user-mode-linux-devel@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------090704090409080501090207
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

As promised, here are the next test tools.

interrupted_syscall.c checks, whether syscall restarting is correctly
done for
- nanosleep(), which returns -ERESTART_RESTARTBLOCK on interruption
- read(), which returns -ERESTARTSYS on interruption.
- sigsuspend(), which does do_signal() while being in the syscall and/or
   on return to user.
The test sets SIG_IGN or a signal handler (nanosleep, read) and it tests
with and without SA_RESTART (read). And it does the test twice, once the
test running normal, and one with the test being PTRACE_SYSCALL'ed.
At least for SIG_IGN, this makes a difference.

kernel_restorer.c uses a directly coded call to sys_rt_sigaction(). By this
way, it can force the kernel to use it's own restorer-stub (For UML at the
moment, this is the code on the stack). It does this for both possible
stack-layouts / restorers.
A further test done by this tool is the exploit for sigreturn() doing a
wrong systemcall restart handling. This case is done for sigreturn() and
rt_sigreturn()

Bodo

--------------090704090409080501090207
Content-Type: text/plain;
 name="interrupted_syscall.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="interrupted_syscall.c"

/*
 *  interrupted_syscall.c
 *
 *  Testtool for UML
 *  This tool tests several cases of interrupted syscalls and
 *  checks for the syscall restarting being correctly done.
 *
 *  Copyright (C) 2004 Fujitsu Siemens Computers GmbH
 *  Author: Bodo Stroesser (bodo.stroesser@fujitsu-siemens.com)
 *
 *  Licensed under the GPL
 */

#include <stdio.h>
#include <time.h>
#include <signal.h>
#include <errno.h>
#include <sys/ptrace.h>
#include <asm/ptrace.h>
#include <sys/wait.h>
#include <sys/mman.h>

int child, tester;
int traced;
int pipe_fd[2];

volatile int * counterp;

char outbuf[512], *p;

void sighdlr( int sig)
{
	if ( ! traced ) {
		printf("Signal %d caught\n", sig);
	}
}

void alarm_writer( int parent, int count)
{
	while ( count-- ) {
		sleep( 1);
		if ( kill( parent, SIGALRM) ) {
			perror("kill( parent, SIGALRM)");
			exit(1);
		}
	}
	if ( pipe_fd[0] == -1 )
		goto out;

	sleep( 1);
	close( pipe_fd[0]);
	if ( write( pipe_fd[1], "X", 1) != 1 ) {
		perror("write( pipe_fd[1], \"X\", 1)");
		exit(1);
	}
    out:
	sleep(60);
	exit(0);
}

void
prepare( int mkpipe, int count, void * hdlr, int flags)
{
	struct sigaction sa;
	int ret;
	int pid = getpid();

	if ( mkpipe ) {
		if ( pipe( pipe_fd) ) {
			perror("pipe( pipe_fd)");
			exit(1);
		}
	} else 
		pipe_fd[0] = pipe_fd[1] = -1;

	memset( &sa, 0, sizeof( sa));
	sa.sa_handler = hdlr;
	sa.sa_flags = flags;
	if ( sigaction( SIGALRM, &sa, NULL) ) {
		perror("sigaction( SIGALRM, &sa)");
		exit(1);
	}
	if ( (child = fork()) < 0 ) {
		perror("fork()");
		exit(1);
	}
	else if ( !child )
		alarm_writer( pid, count); /* Child will never return */

	if ( mkpipe ) {
		close( pipe_fd[1]);
		pipe_fd[1] = -1;
	}
	counterp[0] = 0;
	counterp[1] = 0;
	if ( hdlr == SIG_IGN )
		counterp[2] = 0;
	else
		counterp[2] = 1;

	p = outbuf;
}

void
cleanup( int ok, int syscalls, int signals)
{
	int status;

	int syscall_count = counterp[0];
	int signal_count = counterp[1];

	printf( outbuf);

	if ( pipe_fd[0] != -1 )
		close( pipe_fd[0]);
	if ( pipe_fd[1] != -1 )
		close( pipe_fd[1]);

	kill( child, SIGKILL);

	waitpid( child, &status, 0);

	if ( traced ) {
		printf("Syscalls: %d, Signals: %d ==> ", syscall_count, signal_count);
		if ( syscall_count != syscalls || signal_count != signals ) {
			ok = 0;
			printf(" ERROR!\nExpected: Syscalls: %d Signals: %d\n", syscalls, signals);
		}
		else
			printf("OK.\n");
	}

	if ( ! ok ) {
		printf("Test failed!\n");
		exit(1);
	}
	printf("Test succeeded\n\n");
}


int
tester_fn( void)
{
	struct timespec ts, ts2;
	sigset_t set;
	char buf[10];
	int ret, errno_sav;

	sigprocmask( SIG_BLOCK, NULL, &set);


	printf("\n=====> Test case 1: nanosleep() 3.5 seconds, SIGALRM after 1 and 2 seconds, SIG_IGN\n");

	prepare( 0, 2, SIG_IGN, 0);

	ts = (struct timespec){ 3, 500000000};
	ret = nanosleep( &ts, &ts2);
	if ( ret ) {
		p+=sprintf(p, "ERROR: nanosleep(): %s", strerror( errno));
		p+=sprintf(p, ";  remaining time=%ld/%ld\n", ts2.tv_sec, ts2.tv_nsec);
	}
	else
		p+=sprintf(p, "OK: nanosleep() returns OK.\n");

	cleanup( ret == 0 , 6, 2);


	printf("\n=====> Test case 2: nanosleep() 3.5 seconds, SIGALRM after 1 and 2 seconds, signal handler\n");

	prepare( 0, 2, sighdlr, 0);

	ts = (struct timespec){ 3, 500000000};
	ret = nanosleep( &ts, &ts2);
	if ( ret ) {
		p+=sprintf(p, "OK: nanosleep(): %s", strerror( errno));
		p+=sprintf(p, ";  remaining time=%ld/%ld\n", ts2.tv_sec, ts2.tv_nsec);
	}
	else
		p+=sprintf(p, "ERROR: nanosleep() returns OK.\n");

	cleanup( ret && ts2.tv_sec == 2 , 4, 1);


	printf("\n=====> Test case 3: read(), SIGALRM after 1 and 2 seconds, 1 Byte after 3rd second, SIG_IGN\n");

	prepare( 1, 2, SIG_IGN, 0);

	ret = read( pipe_fd[0], buf, sizeof( buf));
	if ( ret != 1 )
		p+=sprintf(p, "ERROR: read( pipe_fd[0], buf, sizeof(buf)): %s\n", strerror( errno));
	else 
		p+=sprintf(p, "OK: read received %d bytes\n", ret);

	cleanup( ret == 1 , 6, 2);


	printf("\n=====> Test case 4: read(), SIGALRM after 1 and 2 seconds, 1 Byte after 3rd second, signal handler, SA_RESTART\n");

	prepare( 1, 2, sighdlr, SA_RESTART);

	ret = read( pipe_fd[0], buf, sizeof( buf));
	if ( ret != 1 )
		p+=sprintf(p, "ERROR: read( pipe_fd[0], buf, sizeof(buf)): %s\n", strerror( errno));
	else 
		p+=sprintf(p, "OK: read received %d bytes\n", ret);

	cleanup( ret == 1 , 10, 2);


	printf("\n=====> Test case 5: read(), SIGALRM after 1 second, 1 Byte after 2nd second, signal handler, ! SA_RESTART\n");

	prepare( 1, 1, sighdlr, 0);

	ret = read( pipe_fd[0], buf, sizeof( buf));
	errno_sav = errno;
	if ( ret != 1 )
		p+=sprintf(p, "OK: read( pipe_fd[0], buf, sizeof(buf)): %s\n", strerror( errno));
	else 
		p+=sprintf(p, "ERROR: read received %d bytes\n", ret);

	cleanup( ret == -1 && errno_sav == EINTR , 4, 1);


	printf("\n=====> Test case 6: sigsuspend(), SIGALRM after 1 second, signal handler, SA_RESTART\n");

	prepare( 0, 1, sighdlr, SA_RESTART);

	ret = sigsuspend( &set);
	errno_sav = errno;
	if ( ret < 0 )
		p+=sprintf(p, "OK: sigsuspend(): %s\n", strerror( errno));
	else 
		p+=sprintf(p, "ERROR: sigsuspend returns OK.\n");

	cleanup( ret == -1 && errno_sav == EINTR , 4, 1);
}


int
main( int argc, char **argv)
{
	int status, ret, sig, debug;
	sigset_t set;

	sigprocmask( SIG_BLOCK, NULL, &set);
	sigdelset( &set, SIGCHLD);
	sigprocmask( SIG_SETMASK, NULL, &set);

	counterp = mmap( NULL, 4096, PROT_WRITE|PROT_READ, MAP_SHARED|MAP_ANONYMOUS, 0, 0);
	if ( counterp == MAP_FAILED ) {
		perror("mmap");
		exit(1);
	}

	debug = argc > 1 && !strcmp("debug",argv[1]);

	tester = fork();
	if ( tester < 0 ) {
		perror("fork()");
		exit(1);
	}
	if ( ! tester ) {
		printf("\n\nStarting Test: UNTRACED\n\n");
		traced = 0;
		tester_fn();
		if ( ptrace( PTRACE_TRACEME, 0, (void *)0, (void *)0) ) {
			perror("ptrace( PTRACE_TRACEME, 0, 0, 0)");
			exit(1);
		}
		printf("\nStarting Test: TRACED\n");
		traced = 1;
		kill( getpid(), SIGTRAP);
		tester_fn();
		exit(0);
	}

	while (1) {
		ret = waitpid( tester, &status, 0);
		if ( ret != tester ) {
			fprintf( stderr, "Tracer: ");
			perror("waitpid");
			exit(1);
		}
		if ( WIFSTOPPED(status) && WSTOPSIG(status) == SIGTRAP ) {
			sig = 0;
			counterp[0]++;
			if ( debug )
				printf("TRAP: syscall-# = %d, count = %d\n",
				       ptrace( PTRACE_PEEKUSER, tester, (void *)(ORIG_EAX*4), NULL),
				       counterp[0]);
		}
		else if ( WIFSTOPPED(status) && WSTOPSIG(status) == SIGALRM ) {
			if ( debug )
				printf("SIGCHLD !!!!!\n");
			sig = SIGALRM;
			if ( counterp[2] )
				printf("Signal %d caught\n", sig);
			else
				printf("Signal %d ignored\n", sig);
			counterp[1]++;
		}
		else if ( WIFSTOPPED(status) && WSTOPSIG(status) == SIGCHLD ) {
			if ( debug )
				printf("SIGCHLD !!!!!\n");
			sig = SIGCHLD;
		}
		else {
			printf("\nTracer: Tester's status is %x: exiting\n", status);
			return (status != 0);
		}
		if ( ptrace( PTRACE_SYSCALL, tester, (void *)0, sig) < 0 ) {
			fprintf( stderr, "Parent: ");
			perror("ptrace( PTRACE_SYSCALL, tester, 0, sig)");
			exit(1);
		}
	}
}

--------------090704090409080501090207
Content-Type: text/plain;
 name="kernel_restorer.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="kernel_restorer.c"

/*
 *  kernel_restorer.c
 *
 *  Testtool for UML
 *  This tool tests the kernels restorer code stubs.
 *  Also it checks, whether syscall restarting is skipped on
 *  return from sys_sigreturn() and sys_rt_sigreturn()
 *
 *  Copyright (C) 2004 Fujitsu Siemens Computers GmbH
 *  Author: Bodo Stroesser (bodo.stroesser@fujitsu-siemens.com)
 *
 *  Licensed under the GPL
 */

#define __KERNEL__
#include <asm/signal.h>
#include <asm/siginfo.h>
#include <asm/sigcontext.h>
#include <asm/ucontext.h>
#include <unistd.h>
#include <errno.h>
#include <asm/unistd.h>

int counter;
int mod_eip;

void sighdlr( int sig)
{
	struct sigcontext * sc = (struct sigcontext *)(&sig + 1);

	printf("sighdlr(): signal %d caught\n", sig);
	if ( --counter )
		alarm(1);
	else if ( mod_eip )
		sc->eip -= 2;
}


void rt_sighdlr( int sig, siginfo_t * info, struct ucontext * uc)
{
	printf("rt_sighdlr(): signal %d caught\n", sig);
	if ( --counter )
		alarm(1);
	else if ( mod_eip )
		uc->uc_mcontext.eip -= 2;
}

_syscall4( int, rt_sigaction, int, signr, struct k_sigaction *, new, struct k_sigaction *, old, int, size)


void
prepare( struct k_sigaction *sa, void * hdlr, int count)
{
	int ret;

	counter = count;
	sa->sa.sa_handler = hdlr;
	sa->sa.sa_flags = SA_RESTART;
	if ( hdlr == rt_sighdlr )
		sa->sa.sa_flags |= SA_SIGINFO;
	ret = rt_sigaction( SIGALRM, sa, NULL, sizeof( sigset_t));
	if ( ret ) {
		perror("rt_sigaction()");
		exit(1);
	}
	
	alarm(1);
}


void
test_suspend( void)
{
	int ret, errno_sav;
	sigset_t set;

	memset( &set, 0, sizeof( sigset_t));

	ret = sigsuspend( &set);
	if ( ret ) {
		errno_sav=errno;
		perror("sigsuspend()");
		if ( errno_sav != EINTR ) {
			printf("ERROR: sigsuspend() didn't return -EINTR\n");
			exit(1);
		}
	} else {
		printf("ERROR: sigsuspend() returns O.K. --> this should never happen!\n");
		exit(1);
	}

	if ( counter ) {
		printf("ERROR: signal counter not counted down to 0, is %d\n", counter);
		exit(1);
	}
	printf("==> OK.\n");
}


void
test_loop( void)
{
	__asm__ volatile ("	call 1f	\n"
			"	jmp  2f	\n"
			"	ret	\n"
			"	nop	\n"
			"1:	jmp  1b	\n"
			"2:		\n"
				: : "a" (-ERESTARTSYS));

	alarm(0);

	if ( counter ) {
		printf("ERROR: signal counter not counted down to 0, is %d\n", counter);
		exit(1);
	}
	printf("==> OK.\n");
}


int
main( void)
{
	struct k_sigaction sa;

	sa.sa.sa_restorer = NULL;
	memset( sa.sa.sa_mask.sig, 0xff, sizeof( sigset_t));

	mod_eip = 0;

	printf("\nTesting kernels restorer for sigreturn(): this simply shouldn't crash\n\n");

	prepare( &sa, sighdlr, 1);

	test_suspend();

	printf("\nTesting kernels restorer for rt_sigreturn(): this simply shouldn't crash\n\n");

	prepare( &sa, rt_sighdlr, 1);

	test_suspend();

	mod_eip = 1;

	printf("\nTesting correct returncode-handling for sigreturn()\n");

	prepare( &sa, sighdlr, 3);

	test_loop();

	printf("\nTesting correct returncode-handling for rt_sigreturn()\n");

	prepare( &sa, rt_sighdlr, 3);

	test_loop();

	return 0;
}

--------------090704090409080501090207--


-------------------------------------------------------
This Newsletter Sponsored by: Macrovision 
For reliable Linux application installations, use the industry's leading
setup authoring tool, InstallShield X. Learn more and evaluate 
today. http://clk.atdmt.com/MSI/go/ins0030000001msi/direct/01/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
