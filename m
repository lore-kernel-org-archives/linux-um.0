Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Eo3pj-0000tC-MO for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 18 Dec 2005 11:04:35 -0800
Received: from mail.nagafix.co.uk ([194.145.196.85])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1Eo3pd-0007Qo-GK
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 18 Dec 2005 11:04:32 -0800
Received: from localhost (localhost [127.0.0.1])
	by mail.nagafix.co.uk (Postfix) with ESMTP id D81394576C
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sun, 18 Dec 2005 19:04:22 +0000 (GMT)
Received: from mail.nagafix.co.uk ([127.0.0.1])
	by localhost (viper.nagafix.co.uk [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 13007-07 for
	<user-mode-linux-devel@lists.sourceforge.net>; 
	Sun, 18 Dec 2005 19:04:17 +0000 (GMT)
Received: from [192.168.0.2] (host-84-9-44-68.bulldogdsl.com [84.9.44.68])
	by mail.nagafix.co.uk (Postfix) with ESMTP id CA8CF45772
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sun, 18 Dec 2005 19:04:16 +0000 (GMT)
From: Antoine Martin <antoine@nagafix.co.uk>
In-Reply-To: <1113844082.11747.33.camel@cobra>
References: <200504181134.53390.markc@renta.net>
	<1113830263.11747.3.camel@cobra> <1113841384.12075.6.camel@localhost>
	<1113844082.11747.33.camel@cobra>
Content-Type: text/plain
Message-Id: <1134932639.10491.78.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [uml-devel] skas3 (almost) works on amd64?
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
Date: Sun, 18 Dec 2005 19:03:58 +0000
To: UML devel <user-mode-linux-devel@lists.sourceforge.net>

(..)
> > I can't speak to how stable it was. I'm pretty sure I wasn't using Skas,
> It isn't skas as the skas3 code hasn't been ported to x86_64 yet.
Or has it?
I've just removed mode=skas0 from the command line during testing and I
was surprised to see this:
Checking that ptrace can change system call numbers...OK
Checking syscall emulation patch for ptrace...missing
Checking PROT_EXEC mmap in /dev/shm/...OK
Checking if syscall restart handling in host can be skipped...OK
Checking for the skas3 patch in the host:
  - /proc/mm...found
  - PTRACE_FAULTINFO...found
  - PTRACE_LDT...found
UML running in SKAS3 mode
??????
The host was patched with the skas patch (even though it is a 64bit
kernel) as the patch does not seem to interfere and it clearly provides
something useful!

Now it doesn't quite work for me, but it is close enough that I feel it
is well worth investigating (skas3 being much faster - even though skas0
is pretty good - skas3 stills has the advantage)

Here are some test results:
* with kernel32-2.6.15-rc5:
it gets stuck right after printing "SKAS3 mode", here is the full strace
(not big 16KB):
http://uml.nagafix.co.uk/logs/2.6.15-rc5-skas3.strace
the last few lines are:
sigaltstack({ss_sp=0xa0464000, ss_flags=0x3ffc,
ss_size=11548988665867022973}, NULL) = 0
rt_sigaction(SIGUSR1, {0x8000000a0023390, [], 0}, NULL, 8) = 0
rt_sigprocmask(SIG_UNBLOCK, [USR1], NULL, 8) = 0
getpid()                                = 22917
kill(22917, SIGUSR1)                    = 0
--- SIGUSR1 (User defined signal 1) @ 0 (0) ---
rt_sigprocmask(SIG_UNBLOCK, [USR1], [USR1], 8) = 0
sigaltstack({ss_sp=0x200000000, ss_flags=0, ss_size=6979621237}, NULL) =
0
getpid()                                = 22917
pause(
--- It hangs there until I ^C it.

* with kernel32-2.6.14.4-bs3 and kernel32-2.6.13-bs3 (and others):
as above but the strace is different!?, here it is (76KB)
http://uml.nagafix.co.uk/logs/2.6.14.4-bs3.strace
difference is that this is similar to what was reported a while back:
lots of these:
rt_sigprocmask(SIG_BLOCK, [ALRM VTALRM IO], NULL, 8) = 0
rt_sigprocmask(SIG_UNBLOCK, [], [ALRM VTALRM IO], 8) = 0
rt_sigprocmask(SIG_BLOCK, [ALRM VTALRM IO], NULL, 8) = 0
rt_sigprocmask(SIG_SETMASK, NULL, [ALRM VTALRM IO], 8) = 0
And at the end:
kill(23087, SIGKILL)                    = 0
--- SIGCHLD (Child exited) @ 0 (0) ---
ptrace(PTRACE_KILL, 23087, 0x8000, 0xa001ab33) = 0
Segmentation fault

* with 2.4.32-bs2:
Apart from this warning near the top:
Checking for /dev/anon on the host...Not available (open failed with
errno 2)
It spins (consuming CPU) after mounting root (or mounting devfs if
enabled) with:
rt_sigprocmask(SIG_BLOCK, [ALRM VTALRM IO], NULL, 8) = 0
rt_sigprocmask(SIG_UNBLOCK, [ALRM VTALRM IO], [ALRM VTALRM IO], 8) = 0
Interestingly similar to 2.6.14/2.6.13 above, log here (a lot bigger:
260MB uncompressed / 220KB compressed):
http://uml.nagafix.co.uk/logs/2.4.32-bs2.strace.bz2

* with 2.6.15-rc1:
As with 2.4.32, it spins after mounting root, but seems to be on this:
--- SIGCHLD (Child exited) @ 0 (0) ---
waitpid(23866, [{WIFSTOPPED(s) && WSTOPSIG(s) == SIGSEGV}], WSTOPPED) =
23866
ptrace(PTRACE_GETREGS, 23866, 0, 0xa07af9d4) = 0
ptrace(PTRACE_GETFPXREGS, 23866, 0, 0xa07afbcc) = 0
ptrace(0x34 /* PTRACE_??? */, 23866, 0, 0xa07afdcc) = 0
gettimeofday({1021846869037274, 11531684934252935416}, NULL) = 0
write(4, "137333\t 1134874842.237917  Alloc"..., 49) = 49
ptrace(PTRACE_SETREGS, 23866, 0, 0xa07af9d4) = 0
ptrace(PTRACE_SETFPXREGS, 23866, 0, 0xa07afbcc) = 0
ptrace(PTRACE_SYSCALL, 23866, 0, SIG_0) = 0
--- SIGCHLD (Child exited) @ 0 (0) ---
full log here (700MB/840KB)


The kernels were built using vanilla gcc-3.4.4, and the tests were
repeated on 2 separate platforms (gentoo 2005.1 and FC4) - selinux was
disabled for the tests.

Antoine



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
