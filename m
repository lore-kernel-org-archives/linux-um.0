Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <elicooper@gmx.com>) id 1ahKDN-0007R8-Iq
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 19 Mar 2016 16:59:01 +0000
Received: from mout.gmx.net ([212.227.17.22])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1ahKDM-0002fs-II
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 19 Mar 2016 16:59:01 +0000
From: Eli Cooper <elicooper@gmx.com>
Date: Sun, 20 Mar 2016 00:58:38 +0800
Message-Id: <1458406721-7478-1-git-send-email-elicooper@gmx.com>
Subject: [uml-devel] [PATCH v3 0/3] um: fix and extend FPU support
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Richard Weinberger <richard@nod.at>, Jeff Dike <jdike@addtoit.com>

This series first fixes a bug that results in corrupted FPU state after
invoking signal handlers. It also adds support for the extended processor
state (XSTATE) for x86_64 UML, especially the YMM registers used by AVX(2)
instructions.

Tested with a minimal multi-threaded FPU-intensive test program (see below).
This series supersedes the previous sigreturn fix as that one is incorrect
when the process is multi-threaded.

Changes since v2:
 - Add an improved sigreturn fix to this series
 - Merge the ptrace changes into the last commit
 - Make the selftest program multi-threaded

Changes since v1:
 - Refactor functions with oversized stack frame
 - Add a tiny selftest program to the cover letter

Eli Cooper (3):
  um: fix FPU state preservation around signal handlers
  um: extend fpstate to _xstate to support YMM registers
  um: add extended processor state save/restore support

 arch/um/include/shared/registers.h    |  2 ++
 arch/um/kernel/process.c              |  2 +-
 arch/um/os-Linux/signal.c             | 28 ++++++++++++++------
 arch/x86/um/os-Linux/registers.c      | 49 +++++++++++++++++++++++++++++++++--
 arch/x86/um/ptrace_32.c               |  5 ++--
 arch/x86/um/ptrace_64.c               | 16 ++++++------
 arch/x86/um/shared/sysdep/ptrace_64.h |  4 +--
 arch/x86/um/signal.c                  | 37 +++++++++-----------------
 arch/x86/um/user-offsets.c            |  2 +-
 9 files changed, 95 insertions(+), 50 deletions(-)

--
/* Test if context switches preserve YMM registers, multi-threaded version
 * The main function, threads and the signal handler all have their unique
 * ymm0 value, and constantly detect if someone steps on their toes.
 * Should loop forever.
 */
#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <signal.h>
#include <unistd.h>
#include <pthread.h>
#include <sys/time.h>
#include <immintrin.h>

#define N 10

void sighandler(int signum)
{
	int n = 0xffff;
	register uint32_t eax asm("eax");

	__m256i m0 = _mm256_set_epi64x(0x1234L << 32, 0, 0, 0);
	while (n--) {
		asm("vextracti128 $1,%ymm0,%xmm1");
		asm("vpextrd $3,%xmm1,%eax");
		if (eax != 0x1234)
			exit(3);
	}
}

void thread(void *arg)
{
	long n = (long)arg;
	register uint32_t eax asm("eax");

	__m256i m0 = _mm256_set_epi64x(n << 32, 0, 0, 0);
	do {
		asm("vextracti128 $1,%ymm0,%xmm1");
		asm("vpextrd $3,%xmm1,%eax");
	} while (eax == n);
	exit(2);
}

int main()
{
	register uint32_t eax asm("eax");
	pthread_t threads[N];
	struct itimerval itv;
	struct timeval tv;
	struct sigaction act;

	tv.tv_sec = 0;
	tv.tv_usec = 100000;
	itv.it_interval = tv;
	itv.it_value = tv;

	act.sa_handler = sighandler;
	act.sa_flags = 0;
	sigemptyset(&act.sa_mask);
	sigaction(SIGALRM, &act, NULL);

	setitimer(ITIMER_REAL, &itv, NULL);

	for (long i = 0; i < N; i++)
		pthread_create(threads + i, NULL, (void *)thread, (void *)i);

	__m256i m0 = _mm256_set_epi64x(0xabcdL << 32, 0, 0, 0);
	do {
		asm("vextracti128 $1,%ymm0,%xmm1");
		asm("vpextrd $3,%xmm1,%eax");
	} while (eax == 0xabcd);
	printf("%lx\n", eax);

	return 1;
}

------------------------------------------------------------------------------
Transform Data into Opportunity.
Accelerate data analysis in your applications with
Intel Data Analytics Acceleration Library.
Click to learn more.
http://pubads.g.doubleclick.net/gampad/clk?id=278785231&iu=/4140
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

