Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EFxBa-0007Cv-Gr	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 15 Sep 2005 10:06:10 -0700
Received: from mail.nagafix.co.uk ([213.228.237.37])
	by mail.sourceforge.net with esmtp (Exim 4.44)	id 1EFxBY-0006o7-Rp
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 15 Sep 2005 10:06:10 -0700
Received: from localhost (localhost [127.0.0.1])
	by mail.nagafix.co.uk (Postfix) with ESMTP id 1919E457A6
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Fri, 16 Sep 2005 00:12:34 +0100 (BST)
Received: from mail.nagafix.co.uk ([127.0.0.1])
 by localhost (viper.nagafix.co.uk [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 19510-04 for <user-mode-linux-devel@lists.sourceforge.net>;
 Fri, 16 Sep 2005 00:12:31 +0100 (BST)
Received: from [192.168.22.91] (angel.hildebrand.co.uk [81.91.99.6])
	by mail.nagafix.co.uk (Postfix) with ESMTP id CF851457A5
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Fri, 16 Sep 2005 00:12:31 +0100 (BST)
From: Antoine Martin <antoine@nagafix.co.uk>
Content-Type: text/plain
Message-Id: <1126803951.5268.39.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [uml-devel] 2.6.14-rc1 x86 on 2.6.13.1 amd64 host: guest segfaults
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
Date: Thu, 15 Sep 2005 18:05:51 +0100
To: UML devel <user-mode-linux-devel@lists.sourceforge.net>

Host is running 2.6.13.1

I tried mode=skas0 but it seems to always default to TT.
Or has this not been merged in mainline yet?


***
Here is a strace of a x86 guest:
strace ./kernel32 mode=skas0 root=/dev/ubda mem=384M ubd0=./root_fs32
console0=fd:0,fd:1
(..)


gettimeofday({2451808977522855, 18446659740416081920}, NULL) = 0
open("/tmp/vm_file-WEUjnm", O_RDWR|O_CREAT|O_EXCL, 0600) = 5
unlink("/tmp/vm_file-WEUjnm")           = 0
fchmod(5, 0777)                         = 0
_llseek(5, 402653184, [402653184], SEEK_SET) = 0
write(5, "\0", 1)                       = 1
fcntl64(5, F_SETFD, FD_CLOEXEC)         = 0
mmap2(0xa0800000, 394264576, PROT_READ|PROT_WRITE, MAP_SHARED|MAP_FIXED,
5, 0x800) = 0xffffffffa0800000
mkdir("/root/.uml/", 0777)              = -1 EEXIST (File exists)
mkdir("/root/.uml/1", 0777)             = 0
open("/root/.uml/1/pid", O_RDWR|O_CREAT|O_EXCL|O_LARGEFILE, 0644) = 6
getpid()                                = 6026
write(6, "6026\n", 5)                   = 5
close(6)                                = 0
mprotect(0xa0256000, 8192, PROT_READ|PROT_WRITE|PROT_EXEC) = 0
rt_sigaction(SIGPIPE, {0x1000000000000001, [], 0}, {SIG_DFL}, 8) = 0
socketcall(0x8, 0xffffc360)             = 0
fcntl64(6, F_SETFD, FD_CLOEXEC)         = 0
fcntl64(7, F_SETFD, FD_CLOEXEC)         = 0
rt_sigaction(SIGWINCH, {0x10000000a0019a60, [], 0}, {SIG_DFL}, 8) = 0
getpid()                                = 6026
write(1, "tracing thread pid = 6026\n", 26tracing thread pid = 6026
) = 26
clone(child_stack=0xa0257fd4, flags=CLONE_FILES|SIGCHLD) = 6027
--- SIGCHLD (Child exited) @ 0 (0) ---
waitpid(6027, [{WIFSTOPPED(s) && WSTOPSIG(s) == SIGSTOP}], WSTOPPED) =
6027
ptrace(0x15 /* PTRACE_??? */, 6027, 0, 0x1) = 0
ptrace(PTRACE_CONT, 6027, 0, SIG_0)     = 0
rt_sigaction(SIGSEGV, {0x10000000a0019be0, [], 0}, {SIG_DFL}, 8) = 0
rt_sigaction(SIGUSR1, {0x10000000a00184f0, [], 0}, {SIG_DFL}, 8) = 0
waitpid(4294967295, [{WIFSTOPPED(s) && WSTOPSIG(s) == SIGSEGV}],
WSTOPPED) = 6027
--- SIGCHLD (Child exited) @ 0 (0) ---
ptrace(PTRACE_CONT, 6027, 0, SIGSEGV)   = 0
waitpid(4294967295, [{WIFSTOPPED(s) && WSTOPSIG(s) == SIGUSR1}],
WSTOPPED) = 6027
--- SIGCHLD (Child exited) @ 0 (0) ---
munmap(0, 2692743168)                   = 0
--- SIGSEGV (Segmentation fault) @ 0 (0) ---
--- SIGSEGV (Segmentation fault) @ 0 (0) ---
+++ killed by SIGSEGV +++



**
And here is a amd64 guest:
(This trace was much much longer)
(...)
It seems to spin for an awful long time on:
rt_sigprocmask(SIG_BLOCK, [], NULL, 8)  = 0
rt_sigprocmask(SIG_SETMASK, NULL, [], 8) = 0
rt_sigprocmask(SIG_BLOCK, [ALRM VTALRM IO], NULL, 8) = 0
rt_sigprocmask(SIG_UNBLOCK, [ALRM VTALRM IO], [ALRM VTALRM IO], 8) = 0

Reducing the ram seemed to help, no idea what this is about!

Another weirdness, this command line works:
# ./kernel64 root=/dev/ubda mem=256M ubd0=./root_fs64
eth0=tuntap,tap0,FE:F0:00:00:00:01,10.0.0.254 eth1=pcap,eth0
console0=fd:0,fd:1 umid=1
But this one does not:
# ./kernel64 root=/dev/ubda mem=256M ubd0=./root_fs64
eth0=tuntap,tap0,FE:F0:00:00:00:01,10.0.0.254 eth1=pcap,eth0
console0=fd:0,fd:1 console=pty umid=1 gentoo=nodevfs nodevfs selinux=1
enforcing=0
With this one it crashes after checking for PROT_EXEC.
Is this to do with command line size limitations?


** Last issue, when running in a 2.6.14-rc1 guest, I can't 'emerge
--sync', it dies before rebuilding its cache:
Here is the strace:
(..)
>>> checking server timestamp ...

>>>
>>> Timestamps on the server and in the local repository are the same.
>>> Cancelling all further sync action. You are already up to date.
>>>

) = 247
ioctl(2, SNDCTL_TMR_TIMEBASE or TCGETS, 0x7f7fc2da50) = -1 ENOTTY
(Inappropriate ioctl for device)
stat("/var/log/emerge.log", {st_mode=S_IFREG|0660, st_size=222087, ...})
= 0
open("/var/log/emerge.log", O_WRONLY|O_APPEND|O_CREAT, 0666) = 3
fstat(3, {st_mode=S_IFREG|0660, st_size=222087, ...}) = 0
mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0)
= 0x40018000
fstat(3, {st_mode=S_IFREG|0660, st_size=222087, ...}) = 0
lseek(3, 222087, SEEK_SET)              = 222087
fstat(3, {st_mode=S_IFREG|0660, st_size=222087, ...}) = 0
fcntl(3, F_SETLK, {type=F_WRLCK, whence=SEEK_SET, start=0, len=0}) = 0
fstat(3, {st_mode=S_IFREG|0660, st_size=222087, ...}) = 0
lseek(3, 222087, SEEK_SET)              = 222087
write(3, "1126803520:  *** terminating.\n", 30) = 30
fcntl(3, F_SETLKW, {type=F_UNLCK, whence=SEEK_SET, start=0, len=0}) = 0
close(3)                                = 0
munmap(0x40018000, 4096)                = 0
ioctl(2, SNDCTL_TMR_TIMEBASE or TCGETS, 0x7f7fc2daf0) = -1 ENOTTY
(Inappropriate ioctl for device)
wait4(-1, 0x7f7fc2e034, 0, NULL)        = -1 ECHILD (No child processes)
open("/var/cache/edb/mtimedb", O_WRONLY|O_CREAT|O_TRUNC, 0666) = 3
fstat(3, {st_mode=S_IFREG|0664, st_size=0, ...}) = 0
fstat(3, {st_mode=S_IFREG|0664, st_size=0, ...}) = 0
mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0)
= 0x40018000
write(3, "\200\2}q\1(U\4infoq\2}q\3(U\17/usr/share/i"..., 1772) = 1772
close(3)                                = 0
munmap(0x40018000, 4096)                = 0
chown("/var/cache/edb/mtimedb", 0, 250) = 0
chmod("/var/cache/edb/mtimedb", 0664)   = 0
rt_sigaction(SIGINT, NULL, {0x403330d0, [], SA_RESTORER, 0x40b72ba0}, 8)
= 0
rt_sigaction(SIGINT, {SIG_DFL}, NULL, 8) = 0
rt_sigaction(SIGTERM, NULL, {0x403330d0, [], SA_RESTORER, 0x40b72ba0},
8) = 0
rt_sigaction(SIGTERM, {SIG_DFL}, NULL, 8) = 0
munmap(0x4009f000, 200704)              = 0
close(4)                                = 0
munmap(0x40016000, 4096)                = 0
munmap(0x40017000, 4096)                = 0
exit_group(0)                           = ?


Any clues?

Thanks
Antoine



-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
