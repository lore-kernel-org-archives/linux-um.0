Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EhF0b-0004IQ-Ht for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 29 Nov 2005 15:35:37 -0800
Received: from mail.nagafix.co.uk ([194.145.196.85])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1EhF0a-0001K2-WC
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 29 Nov 2005 15:35:37 -0800
Received: from localhost (localhost [127.0.0.1])
	by mail.nagafix.co.uk (Postfix) with ESMTP id D8FC9AF078
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Tue, 29 Nov 2005 23:35:14 +0000 (GMT)
Received: from mail.nagafix.co.uk ([127.0.0.1])
	by localhost (viper.nagafix.co.uk [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 14596-02 for
	<user-mode-linux-devel@lists.sourceforge.net>; 
	Tue, 29 Nov 2005 23:35:02 +0000 (GMT)
Received: from [192.168.0.2] (host-87-74-21-109.bulldogdsl.com [87.74.21.109])
	by mail.nagafix.co.uk (Postfix) with ESMTP id 4F2D6AF075
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Tue, 29 Nov 2005 23:35:02 +0000 (GMT)
From: Antoine Martin <antoine@nagafix.co.uk>
Content-Type: text/plain
Message-Id: <1133307314.13162.50.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [uml-devel] testing of 2.6.15-rc1+patches and 2.6.15-rc3 x86 guests
	on amd64 host
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
Date: Tue, 29 Nov 2005 23:35:14 +0000
To: UML devel <user-mode-linux-devel@lists.sourceforge.net>

All of this testing was done on an amd64 host.

* With a 2.6.15-rc1 (+ 17-11-2005 patches from UML site) in skas0 mode:
Runs quite well, but when running some long compilation (php, gcc or
xorg for example) it ends up crashing (this not new to this version - I
believe this bug has been present for a long time, just never diagnosed
- but this is 100% reproducible):
During boot the kernel prints out a lot of:
"load_TLS(O_FORCE) in fork_handler returned -2"
Then for example, try:
emerge -a php
(...)
/bin/sh ../../libtool --mode=compile g++ -DHAVE_CONFIG_H -I. -I.
-I../../autocfg     -O2 -march=athlon-xp -fomit-frame-pointer  -c -o
arena.lo `test -f 'arena.cpp' || echo './'`arena.cpp
mkdir .libs
g++ -DHAVE_CONFIG_H -I. -I. -I../../autocfg -O2 -march=athlon-xp
-fomit-frame-pointer -c arena.cpp -MT arena.lo -MD -MP
-MF .deps/arena.TPlo  -fPIC -DPIC -o .libs/arena.lo
[42951313.910000] Kernel panic - not syncing: Kernel mode signal 7

* Same kernel but in TT mode does not boot:
(...)
[42949377.540000] VFS: Mounted root (ext3 filesystem) readonly.
[42949377.560000] line_ioctl: tty0: ioctl KDSIGACCEPT called
[42949377.560000] os_set_fd_async : failed to set O_ASYNC and O_NONBLOCK
on fd # 6, errno = 9
[42949377.560000] register_winch_irq - failed to register IRQ
[42949377.560000] os_set_fd_async : failed to set O_ASYNC and O_NONBLOCK
on fd # 6, errno = 9
[42949377.560000] register_winch_irq - failed to register IRQ
INIT: [42949377.560000] os_set_fd_async : failed to set O_ASYNC and
O_NONBLOCK on fd # 6, errno = 9
[42949377.560000] register_winch_irq - failed to register IRQ
version 2.86 booting[42949377.560000] os_set_fd_async : failed to set
O_ASYNC and O_NONBLOCK on fd # 6, errno = 9
[42949377.560000] register_winch_irq - failed to register IRQ

[42949377.580000] Kernel panic - not syncing: read of switch_pipe
failed, errno = 11


* Now, with 2.6.15-rc3 it does not boot:
either in TT mode:
Checking PROT_EXEC mmap in /tmp...OK
UML running in TT mode
tracing thread pid = 11250
Child 11253 exited with signal 7
(hangs there until I kill it)

* or in skas0 mode:
Checking PROT_EXEC mmap in /tmp...OK
Checking for the skas3 patch in the host:
  - /proc/mm...not found
  - PTRACE_FAULTINFO...not found
  - PTRACE_LDT...not found
UML running in SKAS0 mode
(then it exits)

This is the same problem I had reported earlier, where it gets stuck -
strace extract follows:
sigaltstack({ss_sp=0x200000000, ss_flags=0,
ss_size=11529956872819846383}, NULL) = 0
rt_sigprocmask(SIG_SETMASK, [IO], NULL, 8) = 0
rt_sigprocmask(SIG_BLOCK, NULL, [IO], 8) = 0
rt_sigprocmask(SIG_BLOCK, [ALRM VTALRM IO], NULL, 8) = 0
getpid()                                = 11503
rt_sigprocmask(SIG_SETMASK, NULL, [ALRM VTALRM IO], 8) = 0
rt_sigprocmask(SIG_BLOCK, [ALRM VTALRM IO], NULL, 8) = 0
rt_sigprocmask(SIG_UNBLOCK, [], [ALRM VTALRM IO], 8) = 0
rt_sigprocmask(SIG_BLOCK, [ALRM VTALRM IO], NULL, 8) = 0
(repeat for a while - then)
--- SIGBUS (Bus error) @ 0 (0) ---
rt_sigprocmask(SIG_UNBLOCK, [USR1], [BUS USR1 ALRM VTALRM WINCH IO], 8)
= 0
rt_sigprocmask(SIG_UNBLOCK, [ALRM VTALRM IO], NULL, 8) = 0
rt_sigprocmask(SIG_SETMASK, NULL, [BUS WINCH], 8) = 0
rt_sigprocmask(SIG_BLOCK, [ALRM VTALRM IO], NULL, 8) = 0
rt_sigprocmask(SIG_UNBLOCK, [ALRM VTALRM IO], [BUS ALRM VTALRM WINCH
IO], 8) = 0
rt_sigprocmask(SIG_BLOCK, [], NULL, 8)  = 0
(this repeats until)
rt_sigprocmask(SIG_BLOCK, [ALRM VTALRM IO], NULL, 8) = 0
rt_sigprocmask(SIG_UNBLOCK, [ALRM VTALRM IO], [BUS ALRM VTALRM WINCH
IO], 8) = 0
rt_sigprocmask(SIG_BLOCK, [], NULL, 8)  = 0
open("/uml/.uml/3", O_RDONLY|O_NONBLOCK|O_LARGEFILE|O_DIRECTORY) = 4
fstat64(0x4, 0xa05735ac)                = 0
fcntl64(4, F_SETFD, FD_CLOEXEC)         = 0
getdents64(4, /* 3 entries */, 131072)  = 72
unlink("/uml/.uml/3/pid")               = 0
getdents64(4, /* 0 entries */, 131072)  = 0
rmdir("/uml/.uml/3")                    = 0
getpid()                                = 11503
rt_sigprocmask(SIG_BLOCK, [ALRM VTALRM IO], NULL, 8) = 0
rt_sigprocmask(SIG_SETMASK, [IO], NULL, 8) = 0
rt_sigprocmask(SIG_BLOCK, [PROF], [IO], 8) = 0
setitimer(ITIMER_VIRTUAL, {it_interval={0, 0},
it_value={11530534155079122944, 27}}, NULL) = 0
setitimer(ITIMER_REAL, {it_interval={0, 0},
it_value={11530534155079122944, 27}}, NULL) = 0
rt_sigaction(SIGALRM, {SIG_IGN}, NULL, 8) = 0
rt_sigaction(SIGVTALRM, {SIG_IGN}, NULL, 8) = 0
rt_sigaction(SIGIO, {SIG_IGN}, NULL, 8) = 0
rt_sigprocmask(SIG_UNBLOCK, [ALRM VTALRM IO], NULL, 8) = 0
write(1, "\n", 1
)                       = 1
munmap(0x55556000, 4096)                = 0
exit_group(1)                           = ?

Let me know what I can do to help.

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
