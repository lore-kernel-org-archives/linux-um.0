Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CRZAQ-0005UU-QB for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 09 Nov 2004 08:48:26 -0800
Received: from plam.fujitsu-siemens.com ([217.115.66.9])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1CRZAP-0005ep-UJ for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 09 Nov 2004 08:48:26 -0800
Message-ID: <4190F385.1000802@fujitsu-siemens.com>
From: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
MIME-Version: 1.0
References: <20041029092641.8558.qmail@web26102.mail.ukl.yahoo.com>
	<200411021952.09095.blaisorblade_spam@yahoo.it>
In-Reply-To: <200411021952.09095.blaisorblade_spam@yahoo.it>
Content-Type: multipart/mixed; boundary="------------080609080405030001030304"
Subject: [uml-devel] Re: Stop at startup on 2.6 NPTL hosts
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
Date: Tue, 09 Nov 2004 17:42:45 +0100
To: Blaisorblade <blaisorblade_spam@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net, Jeff Dike <jdike@addtoit.com>, Roland Kaeser <roli8200@yahoo.de>, Nuno Silva <nuno.silva@vgertech.com>, Antoine Martin <antoine@nagafix.co.uk>, =?ISO-8859-1?Q?Sven_K=F6hler?= <skoehler@upb.de>, Dennis Muhlestein <devel@muhlesteins.com>

This is a multi-part message in MIME format.
--------------080609080405030001030304
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Blaisorblade wrote:
> On Friday 29 October 2004 11:26, Roland Kaeser wrote:
> This is executed by a clone() child. What happens is that, with NPTL, both the 
> father and the son have the same pid, so the SIGSTOP is routed to the wrong 
> thread. However, this is not expected: having the same pid should be reserved 
> to when clone is called with CLONE_THREAD in the flags. I've verified that 
> this is not happening in this case, even with strace (to make sure glibc is 
> not playing any dirty tricks). But for some reasons, the kernel is behaving 
> as if this happened.
Sorry, I have to oppose. The threads don't have the same pid! Only the getpid()-
call to the lib returns the pid of the father.

I wrote a small test program (attached). Please compile it with:

    gcc -static -o test_getpid_static test_getpid.c        and
    gcc -o test_getpid_nptl test_getpid.c

Using the two programs, you can see the following:
1) having linked my test with -static, each "getpid()" in the test results in a
    syscall (try "strace test_getpid_static")
2) linking without -static (I assume, this means using NPTL), only the first
    getpid() does a syscall, I guess, the further calls deliver a pid-value
    buffered in the lib! (try "strace test_getpid_static")
The test here requests and prints out its pid twice, then it exits. But strace will
show you two getpid()-calls only in case of the _static program.

3) the pid-history seen in 1 and 2 is used even for a child created with "clone()",
    regardless which clone-flags are used! Try "test_getpid_static clone" and
    "test_getpid_nptl clone" to see, what happens.
    After printing its pid twice, the program now creates a child via "clone()". The
    child requests its *real* pid via a "by-hand-syscall". Than it stops itself and
    is ptraced by the father, which prints out a message, if the child does a *real*
    getpid()-syscall.
    Note: If you remove the two getpid()-calls at the beginning of main(), the
    child will work correctly even with NPTL, since there isn't yet a buffered pid ...

Summary: I guess, the behavior of NPTL is a bug. Do you agree? To which list should
a bugreport be mailed?
To work around, we could use the by-hand-syscall for os_getpid(). I didn't test it,
but I'm quite shure, that it fixes the problem.

Bodo

--------------080609080405030001030304
Content-Type: text/plain;
 name="test_getpid.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="test_getpid.c"

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

char childstack[ 8*1024];


int my_getpid()
{
	long res;
	__asm__ volatile ("	int $0x80\n\t"
				: "=a" (res)
				: "0" (__NR_getpid));
	return res;
}


int
child_fn( void * unused)
{
	pid_t me = my_getpid();

	printf("Child: my PID via 'int $0x80' is %d\n", me);

	ptrace(PTRACE_TRACEME, 0, 0, 0);
	kill( me, SIGSTOP);

	printf("Child: my PID via 'getpid()' is %d\n", getpid());

	return 0;
}


int
main( int argc, char ** argv)
{
	int ret, status, suppress=0;
	pid_t child;

	printf("Parent: my PID is %d\n", getpid());
	printf("Parent: my PID is %d\n", getpid());

	if ( argc < 2 || strcmp( argv[1], "clone") )
		return 0;

	child = clone( child_fn, childstack+8*1024-4, SIGCHLD, NULL);

	if ( child < 0 ) {
		perror("clone");
		exit(1);
	}
	printf("Parent: childs PID is %d\n", child);

	do {
		ret = waitpid(child, &status, WUNTRACED);
		if(ret < 0) {
			perror("waitpid()");
			exit(1);
		}
	} while(WIFSTOPPED(status) && (WSTOPSIG(status) == SIGVTALRM));

	if(!WIFSTOPPED(status) || (WSTOPSIG(status) != SIGSTOP)) {
		printf("Parent: waitpid(): expected SIGSTOP, got status = %d\n", status);
		return 1;
	}

	while (1) {
		if ( ptrace( PTRACE_SYSCALL, child, (void *)0, 0) < 0 ) {
			perror("ptrace( PTRACE_SYSCALL, child, 0, 0)");
			exit(1);
		}
		ret = waitpid( child, &status, 0);
		if ( ret != child ) {
			perror("waitpid");
			return 1;
		}
		if ( WIFSTOPPED(status) && WSTOPSIG(status) == SIGTRAP ) {
			errno = 0;
			ret = ptrace( PTRACE_PEEKUSER, child, (void *)(ORIG_EAX*4), NULL);
			if ( errno ) {
				perror("ptrace( PTRACE_PEEKUSER, child, ORIG_EAX, NULL)");
				return 1;
			}
			if ( ret == __NR_getpid ) {
				if ( (suppress ^= 1) )
					printf("Parent: Child does a getpid() syscall!\n");
			}
		}
		else {
			printf("Parent: Child's status is %x: exiting\n", status);
			return (status != 0);
		}
	}
}

--------------080609080405030001030304--


-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
