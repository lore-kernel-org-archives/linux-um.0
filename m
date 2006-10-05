Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GVacU-0004QE-M9 for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 05 Oct 2006 14:19:06 -0700
Received: from smtp006.mail.ukl.yahoo.com ([217.12.11.95])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1GVacR-0003zJ-1u
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 05 Oct 2006 14:19:06 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Date: Thu, 5 Oct 2006 22:14:31 +0200
References: <451E9BAB.5030009@linuxbox.cz>
	<200610011725.16069.blaisorblade@yahoo.it>
	<451FE3F0.1070304@linuxbox.cz>
In-Reply-To: <451FE3F0.1070304@linuxbox.cz>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200610052214.31864.blaisorblade@yahoo.it>
Subject: Re: [uml-devel] SKAS mode not working, x86_64 SMP host, x86_64 guest, 
	problems with noprocmm
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Nikola Ciprich <nikola.ciprich@linuxbox.cz>

On Sunday 01 October 2006 17:51, Nikola Ciprich wrote:
> Hi Paolo and others,
> thanks a lot for explanation. I'll just add some things I've noticed
> (and also few another questions ;):
> My setup is dualcore opteron machine, running SMP 2.6.18, patched with
> skasv9-pre9 with fremap support.

Argh... I thought I marked that as "for developers" (there was a single 
release for 2.6.18-rc4, but separate ones for 2.6.18...) - that patch 
(fremap) is IMHO very stable, but I've been its only tester till now.

> guests:
> vanilla 2.6.18-x86_64 SKAS
>     - crashes trying to access /proc/mm

When 64bit guests try using /proc/mm they'll crash, as explained, so you can 
skip testing/reporting this case.

> vanilla 2.6.18-x86_64 noprocmm OR skas0
>     - works equally well, even performance is pretty much the same
> (measured on kernel compilation), there's just this problem with
> /sbin/halt hang

> vanilla 2.6.18-x86 - doesn't matter which arguments are passed
>     - hangs, strace shows following:
...
>         kill(8120, SIGKILL)                     = 0
>         +++ killed by SIGKILL +++

> 2.6.18-x86_64 with bb1 patch
>     - SKAS crashes as expected
>     - noprocmm or skas0 is weird:
>        if run, panics with:
>             [42949373.500000] VFS: Mounted root (ext2 filesystem) readonly.
>             Usage: init 0123456SsQqAaBbCcUu
>             [42949373.500000] Kernel panic - not syncing: Attempted to
> kill init!
>       - aparentrly init is being executed in some strange way?

Ok, you are the second user reporting this problem. Some option is not being 
parsed correctly by UML, so it is passed to init.

So you obtain this as a regression in -bb1... try unapplying 
patches/tls/x86-64-support.diff (you find separate patches in the broken-out 
folder in the archive).

>     - given init=/bin/sh hangs, tracing shows following loop:
>         --- SIGCHLD (Child exited) @ 0 (0) ---
>         wait4(1381, [{WIFSTOPPED(s) && WSTOPSIG(s) == SIGSEGV}],
> WSTOPPED, NULL) = 1381
>         ptrace(PTRACE_GETREGS, 1381, 0, 0x60aec330) = 0
>         ptrace(PTRACE_GETFPREGS, 1381, 0, 0x60aec408) = 0
>         ptrace(PTRACE_CONT, 1381, 0, SIGSEGV)   = 0
>     - round and round
>
> I hope it helps in some way.

-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade
http://www.user-mode-linux.org/~blaisorblade

Chiacchiera con i tuoi amici in tempo reale! 
 http://it.yahoo.com/mail_it/foot/*http://it.messenger.yahoo.com 


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
