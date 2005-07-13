Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DsZ8z-0006E6-W8	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 12 Jul 2005 21:46:49 -0700
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]
	helo=grelber.thyrsus.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.44)
	id 1DsZ8z-00049e-Od	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 12 Jul 2005 21:46:50 -0700
Received: from localhost.localdomain (grelber.thyrsus.com [192.168.1.31])
	by grelber.thyrsus.com (8.13.1/8.13.1) with ESMTP id j6D6A25T031818
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Wed, 13 Jul 2005 02:10:02 -0400
From: Rob Landley <rob@landley.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200507122346.40320.rob@landley.net>
Subject: [uml-devel] Am I doing something wrong with -skas0?
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
Date: Tue, 12 Jul 2005 23:46:40 -0500
To: user-mode-linux-devel@lists.sourceforge.net

So: I apply Blaisorblad's 2.6.12-bb2-skas0 rollup patch, build with skas 
support, and it crashes (as mentioned earlier) with:

VFS: Mounted root (hostfs filesystem) readonly.
Kernel panic - not syncing: get_skas_faultinfo : failed to wait for 
SIGUSR1/SIGTRAP, pid = 7944, n = 7944, errno = 0, status = 0xb

And then a dump (which I pasted in a few messages back...)

Is there an obvious way to track this down further?  I ran it under strace and 
filtered out the setsigmask stuff, but unfortunately the result's not very 
interesting.  Lots of stuff happens, then:

waitpid(7944, [{WIFSTOPPED(s) && WSTOPSIG(s) == SIGSEGV}], WUNTRACED) = 7944
ptrace(PTRACE_GETREGS, 7944, 0, 0x88e1804) = 0
ptrace(PTRACE_GETFPXREGS, 7944, 0, 0x88e18b4) = 0
ptrace(PTRACE_CONT, 7944, 0, SIGSEGV)   = 0
--- SIGCHLD (Child exited) @ 0 (0) ---
waitpid(7944, [{WIFSTOPPED(s) && WSTOPSIG(s) == SIGUSR1}], WUNTRACED) = 7944
getpid()                                = 7939
ptrace(PTRACE_SETREGS, 7944, 0, 0x88e7764) = 0
ptrace(PTRACE_CONT, 7944, 0, SIG_0)     = 0
--- SIGCHLD (Child exited) @ 0 (0) ---
waitpid(7944, [{WIFSTOPPED(s) && WSTOPSIG(s) == SIGTRAP}], WUNTRACED) = 7944
ptrace(PTRACE_SETREGS, 7944, 0, 0x88e1804) = 0
ptrace(PTRACE_SETFPXREGS, 7944, 0, 0x88e18b4) = 0
ptrace(PTRACE_SYSCALL, 7944, 0, SIG_0)  = 0
--- SIGCHLD (Child exited) @ 0 (0) ---
waitpid(7944, [{WIFSTOPPED(s) && WSTOPSIG(s) == SIGSEGV}], WUNTRACED) = 7944
ptrace(PTRACE_GETREGS, 7944, 0, 0x88e1804) = 0
ptrace(PTRACE_GETFPXREGS, 7944, 0, 0x88e18b4) = 0
ptrace(PTRACE_CONT, 7944, 0, SIGSEGV)   = 0
waitpid(7944, [{WIFSIGNALED(s) && WTERMSIG(s) == SIGSEGV}], WUNTRACED) = 7944
--- SIGCHLD (Child exited) @ 0 (0) ---
ioctl(1, SNDCTL_TMR_TIMEBASE or TCGETS, 0x88e793c) = -1 ENOTTY (Inappropriate 
ioctl for device)
write(1, "Kernel panic - not syncing: get_"..., 131) = 131

And so on through a ptrace of it dumping stack.

Am I doing it right?  Is there anything I can do to help track this down?

Rob


-------------------------------------------------------
This SF.Net email is sponsored by the 'Do More With Dual!' webinar happening
July 14 at 8am PDT/11am EDT. We invite you to explore the latest in dual
core and dual graphics technology at this free one hour event hosted by HP,
AMD, and NVIDIA.  To register visit http://www.hp.com/go/dualwebinar
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
