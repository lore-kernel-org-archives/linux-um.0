Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from [10.3.1.91] (helo=sc8-sf-mx1-new.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Do0f9-0001R6-JO	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 30 Jun 2005 08:09:11 -0700
Received: from smtp001.mail.ukl.yahoo.com ([217.12.11.32])
	by sc8-sf-mx1-new.sourceforge.net with smtp (Exim 4.44)
	id 1Do0f4-0004gz-PH	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 30 Jun 2005 08:09:11 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] Re: Skas0 general testing?
References: <200506230238.35960.blaisorblade@yahoo.it>
	<200506230336.28927.blaisorblade@yahoo.it>
	<20050630143119.GA4337@ccure.user-mode-linux.org>
In-Reply-To: <20050630143119.GA4337@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506301714.42462.blaisorblade@yahoo.it>
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
Date: Thu, 30 Jun 2005 17:14:41 +0200
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Jeff Dike <jdike@addtoit.com>, Bodo Stroesser <bstroesser@fujitsu-siemens.com>

On Thursday 30 June 2005 16:31, Jeff Dike wrote:
> On Thu, Jun 23, 2005 at 03:36:26AM +0200, Blaisorblade wrote:
> > I specified "operations done on the host" exactly for this purpose. That
> > patch will touch SKAS3 code, but if I set all three options to "yes" the
> > code should do the same things (again, in terms of strace output).
> >
> > But however, if to keep the code clean we change (let's say) where a
> > certain signal handler is set to later in the boot process, *hoping* that
> > it does not hurt, that's against my definition.

> OK, I straced UML booting and shutting down on a skas3 host, with and
> without the skas0 patch.
Interesting, you'll tell the world how you deleted all the junk out of this... 
(possibly on the Wiki but email is ok).
> I looked at the initialization, syscall interception, and page fault
> handing, and they are identical in the two runs:

> Initialization:

> 	access("/proc/mm", W_OK)                = 0
> 	write(1, "Checking for /proc/mm...found\n", 30) = 30
> 	fork()                                  = 25144
> 	wait4(25144, [WIFSTOPPED(s) && WSTOPSIG(s) == SIGSTOP], WUNTRACED, NULL) =
> 25144 --- SIGCHLD (Child exited) ---
> 	ptrace(PTRACE_???, 25144, 0, 0xbffff7e0) = 0
> 	write(1, "Checking for the skas3 patch in "..., 49) = 49
> 	ptrace(PTRACE_???, 25144, 0, 0x823c100) = 0
> 	ptrace(PTRACE_???, 25144, 0, 0x823c1e0) = 0
> 	ptrace(PTRACE_CONT, 25144, 0, SIG_0)    = 0
>
> Syscall interception:
>
> 	wait4(25145, [WIFSTOPPED(s) && WSTOPSIG(s) == SIGSEGV], WUNTRACED, NULL) =
> 25145 ptrace(PTRACE_???, 25145, 0, 0x8a41888) = 0
> 	ptrace(PTRACE_???, 25145, 0, 0x8a41938) = 0
> 	ptrace(PTRACE_???, 25145, 0, 0x8a41b38) = 0
> 	write(14, "6\0\0\0\0\20\0@\0\20\0\0\5\0\0\0\21\0\0\0\3\0\0\0\0p\270"...,
> 28) = 28 ptrace(PTRACE_???, 25145, 0, 0x8a41888) = 0
> 	ptrace(PTRACE_???, 25145, 0, 0x8a41938) = 0
> 	ptrace(PTRACE_SYSCALL, 25145, 0, SIG_0) = 0
>
> Page fault:
>
> 	wait4(25145, [WIFSTOPPED(s) && WSTOPSIG(s) == 133], WUNTRACED, NULL) =
> 25145 ptrace(PTRACE_???, 25145, 0, 0x8a41888) = 0
> 	ptrace(PTRACE_???, 25145, 0, 0x8a41938) = 0
> 	ptrace(PTRACE_POKEUSER, 25145, 4*ORIG_EAX, 0x14) = 0
> 	ptrace(PTRACE_SYSCALL, 25145, 0, SIG_0) = 0
> 	--- SIGCHLD (Child exited) ---
> 	wait4(25145, [WIFSTOPPED(s) && WSTOPSIG(s) == 133], WUNTRACED, NULL) =
> 25145 ptrace(PTRACE_???, 25145, 0, 0x8a41888) = 0
> 	ptrace(PTRACE_???, 25145, 0, 0x8a41938) = 0
> 	ptrace(PTRACE_SYSCALL, 25145, 0, SIG_0) = 0
>
> With this, are you OK with skas0 being sent to Andrew?
Yes, I'm fine. Send it for -mm now

I'd also like to ship it against 2.6.12 for wider testing.
And the open question is: we (actually you) tested the whole patchset; is 
there any known bug (for skas0) fixed only by patches we are leaving out?
-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

		
___________________________________ 
Yahoo! Messenger: chiamate gratuite in tutto il mondo 
http://it.beta.messenger.yahoo.com



-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
