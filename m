Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <stian@nixia.no>) id 1afNmA-0002EM-U1
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 14 Mar 2016 08:22:54 +0000
Received: from [195.159.66.51] (helo=ramslauken.nlc.no)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1afNm9-00086Z-9C for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 14 Mar 2016 08:22:54 +0000
Received: from mail.nlc.no (ramslauken.nlc.no [195.159.66.51])
	(Authenticated sender: stian@nixia.no)
	by ramslauken.nlc.no (Postfix) with ESMTPA id CD3731D14A9
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Mon, 14 Mar 2016 08:58:45 +0100 (CET)
MIME-Version: 1.0
Date: Mon, 14 Mar 2016 08:58:45 +0100
From: stian@nixia.no
In-Reply-To: <56E3C055.1080301@gmx.com>
References: <1457274987-20078-1-git-send-email-elicooper@gmx.com>
	<1457274987-20078-2-git-send-email-elicooper@gmx.com>
	<56E08B1A.4080809@nod.at> <56E3C055.1080301@gmx.com>
Message-ID: <da47737df6fd95a3c870b7d486ef34f7@nixia.no>
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
To: user-mode-linux-devel@lists.sourceforge.net


> /* test if signal handling preserves XMM registers */
> #include <stdio.h>
> #include <unistd.h>
> #include <signal.h>
>
> int count;
>
> void sighandler(int signum)
> {
>         count++;
>
>         /* alarm(1) without calling libc */
>         asm("mov $0x1,%rdi");
>         asm("mov $0x25,%rax");
>         asm("syscall");
>
>         asm("movq $0xdeadbeef,%r11");
>         /* the following two instructions
>          * modify xmm0 and xmm1 registers */
>         asm("vmovq %r11,%xmm0");
>         asm("vmovq %r11,%xmm1");
> }
>
> int main()
> {
>         struct sigaction act;
>         double a = 3.14159, b = 2.71828;
>
>         act.sa_handler = sighandler;
>         act.sa_flags = 0;
>         sigemptyset(&act.sa_mask);
>         sigaction(SIGALRM, &act, NULL);
>
>         alarm(1);
>
>         /* this loop should run indefinitely */
>         while (a + b == a + b) ;
>
>         printf("count = %d\n", count);

if you put a break here in gdb, and dump the FPU regs, what does it 
say?

Can be that either we a lacking or missplaced a fwait (to flush FPU)

>         return 1;
> }


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

