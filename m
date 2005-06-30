Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Do0Eb-0008Dt-Ch	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 30 Jun 2005 07:41:45 -0700
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1Do0Ea-0005yB-MN	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 30 Jun 2005 07:41:45 -0700
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20050630143119.GA4337@ccure.user-mode-linux.org>
References: <200506230238.35960.blaisorblade@yahoo.it>
	<20050623011255.GB15548@ccure.user-mode-linux.org>
	<200506230336.28927.blaisorblade@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200506230336.28927.blaisorblade@yahoo.it>
Subject: [uml-devel] Re: Skas0 general testing?
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
Date: Thu, 30 Jun 2005 10:31:19 -0400
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: Bodo Stroesser <bstroesser@fujitsu-siemens.com>, user-mode-linux-devel@lists.sourceforge.net

On Thu, Jun 23, 2005 at 03:36:26AM +0200, Blaisorblade wrote:
> I specified "operations done on the host" exactly for this purpose. That patch 
> will touch SKAS3 code, but if I set all three options to "yes" the code 
> should do the same things (again, in terms of strace output).
> 
> But however, if to keep the code clean we change (let's say) where a certain 
> signal handler is set to later in the boot process, *hoping* that it does not 
> hurt, that's against my definition.

OK, I straced UML booting and shutting down on a skas3 host, with and without
the skas0 patch.

I looked at the initialization, syscall interception, and page fault handing,
and they are identical in the two runs:

Initialization:

	access("/proc/mm", W_OK)                = 0
	write(1, "Checking for /proc/mm...found\n", 30) = 30
	fork()                                  = 25144
	wait4(25144, [WIFSTOPPED(s) && WSTOPSIG(s) == SIGSTOP], WUNTRACED, NULL) = 25144
	--- SIGCHLD (Child exited) ---
	ptrace(PTRACE_???, 25144, 0, 0xbffff7e0) = 0
	write(1, "Checking for the skas3 patch in "..., 49) = 49
	ptrace(PTRACE_???, 25144, 0, 0x823c100) = 0
	ptrace(PTRACE_???, 25144, 0, 0x823c1e0) = 0
	ptrace(PTRACE_CONT, 25144, 0, SIG_0)    = 0

Syscall interception:

	wait4(25145, [WIFSTOPPED(s) && WSTOPSIG(s) == SIGSEGV], WUNTRACED, NULL) = 25145
	ptrace(PTRACE_???, 25145, 0, 0x8a41888) = 0
	ptrace(PTRACE_???, 25145, 0, 0x8a41938) = 0
	ptrace(PTRACE_???, 25145, 0, 0x8a41b38) = 0
	write(14, "6\0\0\0\0\20\0@\0\20\0\0\5\0\0\0\21\0\0\0\3\0\0\0\0p\270"..., 28) = 28
	ptrace(PTRACE_???, 25145, 0, 0x8a41888) = 0
	ptrace(PTRACE_???, 25145, 0, 0x8a41938) = 0
	ptrace(PTRACE_SYSCALL, 25145, 0, SIG_0) = 0

Page fault:

	wait4(25145, [WIFSTOPPED(s) && WSTOPSIG(s) == 133], WUNTRACED, NULL) = 25145
	ptrace(PTRACE_???, 25145, 0, 0x8a41888) = 0
	ptrace(PTRACE_???, 25145, 0, 0x8a41938) = 0
	ptrace(PTRACE_POKEUSER, 25145, 4*ORIG_EAX, 0x14) = 0
	ptrace(PTRACE_SYSCALL, 25145, 0, SIG_0) = 0
	--- SIGCHLD (Child exited) ---
	wait4(25145, [WIFSTOPPED(s) && WSTOPSIG(s) == 133], WUNTRACED, NULL) = 25145
	ptrace(PTRACE_???, 25145, 0, 0x8a41888) = 0
	ptrace(PTRACE_???, 25145, 0, 0x8a41938) = 0
	ptrace(PTRACE_SYSCALL, 25145, 0, SIG_0) = 0

With this, are you OK with skas0 being sent to Andrew?

				Jeff


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
