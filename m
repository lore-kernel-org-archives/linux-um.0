Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <elicooper@gmx.com>) id 1ag78J-0000it-1j
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 16 Mar 2016 08:48:47 +0000
Received: from mout.gmx.net ([212.227.15.18])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1ag78I-0004Rh-2i
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 16 Mar 2016 08:48:47 +0000
From: Eli Cooper <elicooper@gmx.com>
Date: Wed, 16 Mar 2016 16:48:26 +0800
Message-Id: <1458118109-3178-1-git-send-email-elicooper@gmx.com>
Subject: [uml-devel] [PATCH v2 0/3] um: Add support for extended processor
	state
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

This series adds support for the extended processor state (XSTATE) for
x86_64 UML, especially the YMM registers used by AVX/AVX2 instructions.

Modern userspace programs built with AVX can now run inside x86_64 UML
without YMM registers getting corrupted.

Tested with a tiny selftest program below, which of course requires the
following patch I sent earlier today to run correctly.
  um: fix FPU register double-restore after sigreturn

Also tested with a latest Arch Linux image on a CPU with AVX2 support.
Without YMM support in UML, a lot of programs crash unexpectedly,
or result in bad results (e.g., calculating SHA256 in OpenSSL).


Changes since v1:
 - Refactor functions with oversized stack frame
 - Add a tiny selftest program to the cover letter

Eli Cooper (3):
  um: extend _fpstate to _xstate
  um: add extended processor state save/restore support
  um: fix ptrace PTRACE_GETFPREGS and PTRACE_SETFPREG support

 arch/um/include/shared/registers.h    |  2 ++
 arch/um/kernel/process.c              |  2 +-
 arch/um/os-Linux/signal.c             | 28 ++++++++++++-----
 arch/x86/um/os-Linux/registers.c      | 49 ++++++++++++++++++++++++++++--
 arch/x86/um/ptrace_32.c               |  5 +--
 arch/x86/um/ptrace_64.c               | 16 +++++-----
 arch/x86/um/shared/sysdep/ptrace_64.h |  4 +--
 arch/x86/um/signal.c                  | 57 +++++++++++++++++++++++------------
 arch/x86/um/user-offsets.c            |  2 +-
 9 files changed, 121 insertions(+), 44 deletions(-)

---
/* test if context switches preserve YMM registers, should exit with code 0 */
#include <stdint.h>
#include <unistd.h>
#include <signal.h>
#include <immintrin.h>

int flag;
void sighandler(int signum)
{
	if (flag)
		exit(0);
	alarm(1);
	flag = 1;
	__m256i m0 = _mm256_set_epi64x(0, 0, 0, 0);
}

int main()
{
	register uint32_t a asm("eax") = 0;
	signal(SIGALRM, sighandler);
	alarm(1);

	__m256i m0 = _mm256_set_epi64x(1L << 32, 0, 0, 0);
	do {
		asm("vextracti128 $1,%ymm0,%xmm1");
		asm("vpextrd $3,%xmm1,%eax");
	} while (a == 1);

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

