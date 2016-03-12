Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <elicooper@gmx.com>) id 1aedd5-0005xu-Ac
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 12 Mar 2016 07:06:27 +0000
Received: from mout.gmx.net ([212.227.15.15])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1aedd4-0003Gi-FQ for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 12 Mar 2016 07:06:27 +0000
References: <1457274987-20078-1-git-send-email-elicooper@gmx.com>
	<1457274987-20078-2-git-send-email-elicooper@gmx.com>
	<56E08B1A.4080809@nod.at>
From: Eli Cooper <elicooper@gmx.com>
Message-ID: <56E3C055.1080301@gmx.com>
Date: Sat, 12 Mar 2016 15:08:05 +0800
MIME-Version: 1.0
In-Reply-To: <56E08B1A.4080809@nod.at>
Subject: Re: [uml-devel] [PATCH 1/3] um: extend _fpstate to _xstate
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Richard Weinberger <richard@nod.at>, user-mode-linux-devel@lists.sourceforge.net
Cc: Jeff Dike <jdike@addtoit.com>

Hi Richard,

On 2016/3/10 4:44, Richard Weinberger wrote:
> Hmm, this needs rework. Having everything on the stack is not good.

Okay, I'll rework the functions whose stack size is greater than the
warning threshold by using kmalloc.

> Can you also create a selftest such that this bug cannot happen again?

It seems that instead of writing a self-test showing this problem cannot
happen again, I wrote a test that manifested another bug that is not
directly related to my patch.

Without applying my patch, the current UML should support XMM registers
because those are covered by _fpstate and PTRACE_GETFPREGS. But it
seemed that XMM registers are not restored after the signal handler returns.

In the following quick test, the main loop should run indefinitely
despite XMM registers are modified by the signal handler. But in UML,
the loop breaks randomly within a minute or two, showing that the
registers are corrupted. So far I haven't found the cause. Any hints?

Thanks,
Eli

---
/* test if signal handling preserves XMM registers */
#include <stdio.h>
#include <unistd.h>
#include <signal.h>

int count;

void sighandler(int signum)
{
        count++;

        /* alarm(1) without calling libc */
        asm("mov $0x1,%rdi");
        asm("mov $0x25,%rax");
        asm("syscall");

        asm("movq $0xdeadbeef,%r11");
        /* the following two instructions
         * modify xmm0 and xmm1 registers */
        asm("vmovq %r11,%xmm0");
        asm("vmovq %r11,%xmm1");
}

int main()
{
        struct sigaction act;
        double a = 3.14159, b = 2.71828;

        act.sa_handler = sighandler;
        act.sa_flags = 0;
        sigemptyset(&act.sa_mask);
        sigaction(SIGALRM, &act, NULL);

        alarm(1);

        /* this loop should run indefinitely */
        while (a + b == a + b) ;

        printf("count = %d\n", count);
        return 1;
}

------------------------------------------------------------------------------
Transform Data into Opportunity.
Accelerate data analysis in your applications with
Intel Data Analytics Acceleration Library.
Click to learn more.
http://pubads.g.doubleclick.net/gampad/clk?id=278785111&iu=/4140
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

