Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Message-ID: <F47F4E3B83BE854AA0BCB998C69295169D2B67@tiki.fastmail.usf.edu>
From: "Gaspar, Alessio (USF Lakeland)" <alessio@lklnd.usf.edu>
Subject: [uml-devel] 2.6.12-bs1-skas0 hanging after INIT
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
Date: Tue, 12 Jul 2005 12:33:14 -0400
Content-Transfer-Encoding: 8bit
To: Blaisorblade <blaisorblade@yahoo.it>, user-mode-linux-user@lists.sourceforge.net
Cc: user-mode-linux-devel@lists.sourceforge.net

Hi, 

I have a uml 2.6.12-bs1-skas0 hanging after Init on a smp ssi host. If I
boot with ./linux init=/bin/sh then I get a shell but it can handle only
internal commands (e.g. cd) and hangs at the first external command
(ls,ps,...)

My configuration is a SMP xeon based server running 2.6.10-ssi-i386-smp
from the open SSI project (http://openssi.org), distribution is Debian
Sarge (installed when it was still testing)
	
Concerning the UML I'm trying to compile I'm working with a 2.6.12
kernel patched with the patch-2.12.2 from kernel.org and the uml patch
from BlaisorBlade 2.6.12-bb2-skas0 (I tried numerous variant before to
settle on that one... more details available if needed) fetched at
http://www.user-mode-linux.org/~blaisorblade/patches/guest/uml-2.6.12-bb
2-skas0/uml-2.6.12-bb2-skas0.patch.bz2

The root FS is the root_fs_toms1.7.205 downloaded from
user-mode-linux.org but I also tested with a debian 3.0-r1 from the same
site without more success (just in case...)

Here are the approaches I tried so far and the details I can provide
(let me
know if you can think of something else): 


________________________________________________________________________
__
[1] SNAPSHOT

here is what happens at boot time: 


~/uml/kernels$ ./linux 
Checking for /proc/mm...not found
Checking for the skas3 patch in the host...not found
Checking PROT_EXEC mmap in /tmp...OK
Linux version 2.6.12.2-bb2-skas0 (alessio@xxx) (gcc version 3.3.5
(Debian 1:3.3.5-13)) #4 Mon Jul 11 14:54:19 EDT 2005
Built 1 zonelists
Kernel command line: root=98:0
PID hash table entries: 256 (order: 8, 4096 bytes)
Dentry cache hash table entries: 8192 (order: 3, 32768 bytes)
Inode-cache hash table entries: 4096 (order: 2, 16384 bytes)
Memory: 29548k available
Mount-cache hash table entries: 512
Checking for host processor cmov support...Yes
Checking for host processor xmm support...No
Checking that ptrace can change system call numbers...OK
Checking syscall emulation patch for ptrace...missing
Checking that host ptys support output SIGIO...No, enabling workaround
Checking that host ptys support SIGIO on close...No, enabling workaround
Checking for /dev/anon on the host...Not available (open failed with
errno 2)
NET: Registered protocol family 16
mconsole (version 2) initialized on /home/alessio/.uml/eTXJSG/mconsole
ubd: Synchronous mode
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
NET: Registered protocol family 2
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP established hash table entries: 2048 (order: 2, 16384 bytes)
TCP bind hash table entries: 2048 (order: 1, 8192 bytes)
TCP: Hash tables configured (established 2048 bind 2048)
NET: Registered protocol family 1
NET: Registered protocol family 17
Initialized stdio console driver
Console initialized on /dev/tty0
Initializing software serial port version 1
 ubda: unknown partition table
VFS: Mounted root (ext2 filesystem) readonly.
line_ioctl: tty0: ioctl KDSIGACCEPT called
INIT: version 2.84 booting


from then on a killall -9 linux is necessary to unstuck the situation.


________________________________________________________________________
___
[2] APPLYING SKASx to the host kernel

not feasible (at least for me), the open SSI modifications and the uml
host SKASx patches collide, I'd prefer fix the problem in TT or SKAS0
mode rather than mixing the two patches... 



________________________________________________________________________
___
[3]  Searching the mailing list... 

1. This looks very similar to the following (old) post (not fully
solved)
http://sourceforge.net/mailarchive/message.php?msg_id=9165179
Contacted the author to check for any update, waiting on his response. 

2. jeff's initial skas0 post suggested problems w/ SMP hosts
http://sourceforge.net/mailarchive/forum.php?thread_id=7637144&forum_id=
3648
is this still true in 2.6.12-bs1-skas0? If yes, then I guess we don't
need to look further... 

3. I can't tell if the skas03 bug dating back to 2.6.9-v7 that
BlaisorBlade pointed out in his recent post is also the one affecting
skas0

________________________________________________________________________
___
[4] status of uml processes

While trying to run ./linux, a ps -A u |grep username-running-uml
reveals that there are indeed processes stuck
	
alessio      115044  0.7  0.2 32788 4448 pts/16   S+   17:14   0:00
./linux
alessio      115052  0.0  0.2 32788 4448 pts/16   S+   17:14   0:00
./linux
alessio      115053  0.0  0.2 32788 4448 pts/16   S+   17:14   0:00
./linux
alessio      115054  0.0  0.0   420  420 pts/16   T+   17:14   0:00

alessio      115055  0.0  0.0   420  420 pts/16   T+   17:14   0:00


________________________________________________________________________
___
[5] stracing 

execve("./linux", ["./linux"], [/* 18 vars */]) = 0
uname({sys="Linux", node="xxx", ...}) = 0
brk(0)                                  = 0x8261000
brk(0x8282000)                          = 0x8282000
rt_sigprocmask(SIG_SETMASK, [IO], NULL, 8) = 0
getrlimit(RLIMIT_STACK, {rlim_cur=8192*1024, rlim_max=RLIM_INFINITY}) =
0
rt_sigaction(SIGINT, {0x8056bd0, [], SA_RESTORER|SA_NOMASK|SA_ONESHOT,
0x818cf48}, NULL, 8) = 0
rt_sigaction(SIGTERM, {0x8056bd0, [], SA_RESTORER|SA_NOMASK|SA_ONESHOT,
0x818cf48}, NULL, 8) = 0
rt_sigaction(SIGHUP, {0x8056bd0, [], SA_RESTORER|SA_NOMASK|SA_ONESHOT,
0x818cf48}, NULL, 8) = 0
fstat64(1, {st_mode=S_IFCHR|0620, st_rdev=makedev(136, 16), ...}) = 0
old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS,
-1, 0) = 0xb7fff000
access("/proc/mm", W_OK)                = -1 ENOENT (No such file or
directory)
write(1, "Checking for /proc/mm...not foun"..., 34) = 34
old_mmap(NULL, 4096, PROT_READ|PROT_WRITE|PROT_EXEC,
MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xb7ffe000
clone(child_stack=0xb7ffefd8, flags=0|SIGCHLD) = 116524
--- SIGCHLD (Child exited) @ 0 (0) ---
waitpid(116524, [{WIFSTOPPED(s) && WSTOPSIG(s) == SIGSTOP}], WUNTRACED)
= 116524
ptrace(0x34 /* PTRACE_??? */, 116524, 0, 0xbfffe270) = -1 EIO
(Input/output error)
write(1, "Checking for the skas3 patch in "..., 53) = 53
ptrace(PTRACE_GETREGS, 116524, 0, 0x8252ac0) = 0
ptrace(PTRACE_GETFPXREGS, 116524, 0, 0x8252ba0) = 0
ptrace(PTRACE_CONT, 116524, 0, SIG_0)   = 0
waitpid(116524, [{WIFEXITED(s) && WEXITSTATUS(s) == 1}], 0) = 116524
--- SIGCHLD (Child exited) @ 0 (0) ---
munmap(0xb7ffe000, 4096)                = 0
gettimeofday({1121117270, 331958}, NULL) = 0
getpid()                                = 116523
open("/tmp/vm_file-r6C26y", O_RDWR|O_CREAT|O_EXCL, 0600) = 3
unlink("/tmp/vm_file-r6C26y")           = 0
fchmod(3, 0777)                         = 0
_llseek(3, 4096, [4096], SEEK_SET)      = 0
write(3, "\0", 1)                       = 1
old_mmap(NULL, 4096, PROT_READ|PROT_WRITE|PROT_EXEC, MAP_PRIVATE, 3, 0)
= 0xb7ffe000
write(1, "Checking PROT_EXEC mmap in /tmp."..., 34) = 34
write(1, "OK\n", 3)                     = 3
munmap(0xb7ffe000, 4096)                = 0
close(3)                                = 0
uname({sys="Linux", node="xxx", ...}) = 0
gettimeofday({1121117270, 333276}, NULL) = 0
getpid()                                = 116523
open("/tmp/vm_file-erqd9X", O_RDWR|O_CREAT|O_EXCL, 0600) = 3
unlink("/tmp/vm_file-erqd9X")           = 0
fchmod(3, 0777)                         = 0
_llseek(3, 33554432, [33554432], SEEK_SET) = 0
write(3, "\0", 1)                       = 1
fcntl64(3, F_SETFD, FD_CLOEXEC)         = 0
mmap2(0x8800000, 25165824, PROT_READ|PROT_WRITE, MAP_SHARED|MAP_FIXED,
3, 0x800) = 0x8800000
_llseek(3, 1912832, [1912832], SEEK_SET) = 0
write(3, "U\211\345\203\354\f\211\34$\211t$\4\211|$\10\271\374\367"...,
4096) = 4096
mkdir("/home/alessio/.uml/", 0777)      = -1 EEXIST (File exists)
gettimeofday({1121117270, 335289}, NULL) = 0
getpid()                                = 116523
open("/home/alessio/.uml/1npSkn", O_RDWR|O_CREAT|O_EXCL, 0600) = 4
close(4)                                = 0
unlink("/home/alessio/.uml/1npSkn")     = 0
mkdir("/home/alessio/.uml/1npSkn", 0777) = 0
open("/home/alessio/.uml/1npSkn/pid", O_RDWR|O_CREAT|O_EXCL|O_LARGEFILE,
0644) = 4
getpid()                                = 116523
write(4, "116523\n", 7)                 = 7
close(4)                                = 0
mprotect(0x821a000, 8192, PROT_READ|PROT_WRITE|PROT_EXEC) = 0
rt_sigaction(SIGSEGV, {0x806d9b0, [USR1 ALRM VTALRM WINCH IO],
SA_RESTORER|SA_STACK, 0x818cf48}, NULL, 8) = 0
rt_sigaction(SIGTRAP, {0x806d9b0, [USR1 ALRM VTALRM WINCH IO],
SA_RESTORER|SA_STACK, 0x818cf48}, NULL, 8) = 0
rt_sigaction(SIGFPE, {0x806d9b0, [USR1 ALRM VTALRM WINCH IO],
SA_RESTORER|SA_STACK, 0x818cf48}, NULL, 8) = 0
rt_sigaction(SIGILL, {0x806d9b0, [USR1 ALRM VTALRM WINCH IO],
SA_RESTORER|SA_STACK, 0x818cf48}, NULL, 8) = 0
rt_sigaction(SIGBUS, {0x806d9b0, [USR1 ALRM VTALRM WINCH IO],
SA_RESTORER|SA_STACK, 0x818cf48}, NULL, 8) = 0
rt_sigaction(SIGUSR2, {0x806d9b0, [USR1 ALRM VTALRM WINCH IO],
SA_RESTORER|SA_STACK, 0x818cf48}, NULL, 8) = 0
rt_sigaction(SIGHUP, {SIG_IGN}, {0x8056bd0, [],
SA_RESTORER|SA_NOMASK|SA_ONESHOT, 0x818cf48}, 8) = 0
rt_sigaction(SIGVTALRM, {0x805bdb0, [USR1 ALRM WINCH IO],
SA_RESTORER|SA_STACK|SA_RESTART, 0x818cf48}, NULL, 8) = 0
rt_sigaction(SIGIO, {0x806d9b0, [USR1 ALRM VTALRM WINCH IO],
SA_RESTORER|SA_STACK|SA_RESTART, 0x818cf48}, NULL, 8) = 0
rt_sigaction(SIGWINCH, {SIG_IGN}, {SIG_DFL}, 8) = 0
rt_sigaction(SIGWINCH, {0x806d9b0, [USR1 ALRM VTALRM IO],
SA_RESTORER|SA_STACK|SA_RESTART, 0x818cf48}, NULL, 8) = 0
rt_sigprocmask(SIG_BLOCK, NULL, [IO], 8) = 0
sigaltstack({ss_sp=0x8218000, ss_flags=0, ss_size=16380}, NULL) = 0
rt_sigaction(SIGUSR1, {0x805f770, [], SA_RESTORER|SA_STACK, 0x818cf48},
NULL, 8) = 0
getpid()                                = 116523
kill(116523, SIGUSR1)                   = 0
--- SIGUSR1 (User defined signal 1) @ 0 (0) ---
rt_sigprocmask(SIG_UNBLOCK, [USR1], [USR1 IO], 8) = 0
rt_sigprocmask(SIG_BLOCK, NULL, [IO], 8) = 0
rt_sigprocmask(SIG_SETMASK, [IO], NULL, 8) = 0
sigaltstack({ss_sp=0, ss_flags=SS_DISABLE, ss_size=0}, NULL) = 0
rt_sigprocmask(SIG_SETMASK, [IO], NULL, 8) = 0
rt_sigprocmask(SIG_BLOCK, NULL, [IO], 8) = 0
rt_sigprocmask(SIG_BLOCK, [ALRM VTALRM IO], NULL, 8) = 0
getpid()                                = 116523
rt_sigprocmask(SIG_SETMASK, NULL, [ALRM VTALRM IO], 8) = 0
rt_sigprocmask(SIG_BLOCK, [ALRM VTALRM IO], NULL, 8) = 0
rt_sigprocmask(SIG_UNBLOCK, [], [ALRM VTALRM IO], 8) = 0
rt_sigprocmask(SIG_BLOCK, [ALRM VTALRM IO], NULL, 8) = 0
rt_sigprocmask(SIG_SETMASK, NULL, [ALRM VTALRM IO], 8) = 0
rt_sigprocmask(SIG_BLOCK, [ALRM VTALRM IO], NULL, 8) = 0
rt_sigprocmask(SIG_UNBLOCK, [], [ALRM VTALRM IO], 8) = 0
rt_sigprocmask(SIG_BLOCK, [ALRM VTALRM IO], NULL, 8) = 0
rt_sigprocmask(SIG_SETMASK, NULL, [ALRM VTALRM IO], 8) = 0
rt_sigprocmask(SIG_BLOCK, [ALRM VTALRM IO], NULL, 8) = 0
rt_sigprocmask(SIG_UNBLOCK, [], [ALRM VTALRM IO], 8) = 0
rt_sigprocmask(SIG_BLOCK, [ALRM VTALRM IO], NULL, 8) = 0
rt_sigprocmask(SIG_SETMASK, NULL, [ALRM VTALRM IO], 8) = 0
rt_sigprocmask(SIG_BLOCK, [ALRM VTALRM IO], NULL, 8) = 0
rt_sigprocmask(SIG_UNBLOCK, [], [ALRM VTALRM IO], 8) = 0
rt_sigprocmask(SIG_BLOCK, [ALRM VTALRM IO], NULL, 8) = 0
rt_sigprocmask(SIG_SETMASK, NULL, [ALRM VTALRM IO], 8) = 0
rt_sigprocmask(SIG_BLOCK, [ALRM VTALRM IO], NULL, 8) = 0
rt_sigprocmask(SIG_UNBLOCK, [], [ALRM VTALRM IO], 8) = 0
rt_sigprocmask(SIG_BLOCK, [ALRM VTALRM IO], NULL, 8) = 0
rt_sigprocmask(SIG_SETMASK, NULL, [ALRM VTALRM IO], 8) = 0
rt_sigprocmask(SIG_BLOCK, [ALRM VTALRM IO], NULL, 8) = 0
rt_sigprocmask(SIG_UNBLOCK, [], [ALRM VTALRM IO], 8) = 0
rt_sigprocmask(SIG_BLOCK, [ALRM VTALRM IO], NULL, 8) = 0
rt_sigprocmask(SIG_SETMASK, NULL, [ALRM VTALRM IO], 8) = 0
rt_sigprocmask(SIG_BLOCK, [ALRM VTALRM IO], NULL, 8) = 0
rt_sigprocmask(SIG_UNBLOCK, [], [ALRM VTALRM IO], 8) = 0
rt_sigprocmask(SIG_BLOCK, [ALRM VTALRM IO], NULL, 8) = 0
rt_sigprocmask(SIG_SETMASK, NULL, [ALRM VTALRM IO], 8) = 0
rt_sigprocmask(SIG_BLOCK, [ALRM VTALRM IO], NULL, 8) = 0
rt_sigprocmask(SIG_UNBLOCK, [], [ALRM VTALRM IO], 8) = 0
rt_sigprocmask(SIG_BLOCK, [ALRM VTALRM IO], NULL, 8) = 0
rt_sigprocmask(SIG_SETMASK, NULL, [ALRM VTALRM IO], 8) = 0
rt_sigprocmask(SIG_BLOCK, [ALRM VTALRM IO], NULL, 8) = 0
rt_sigprocmask(SIG_UNBLOCK, [], [ALRM VTALRM IO], 8) = 0
rt_sigprocmask(SIG_BLOCK, [ALRM VTALRM IO], NULL, 8) = 0
rt_sigprocmask(SIG_SETMASK, NULL, [ALRM VTALRM IO], 8) = 0
rt_sigprocmask(SIG_BLOCK, [ALRM VTALRM IO], NULL, 8) = 0
rt_sigprocmask(SIG_UNBLOCK, [], [ALRM VTALRM IO], 8) = 0
rt_sigprocmask(SIG_BLOCK, [ALRM VTALRM IO], NULL, 8) = 0
rt_sigprocmask(SIG_SETMASK, NULL, [ALRM VTALRM IO], 8) = 0
rt_sigprocmask(SIG_BLOCK, [ALRM VTALRM IO], NULL, 8) = 0
rt_sigprocmask(SIG_UNBLOCK, [], [ALRM VTALRM IO], 8) = 0
rt_sigprocmask(SIG_BLOCK, [ALRM VTALRM IO], NULL, 8) = 0
rt_sigprocmask(SIG_SETMASK, NULL, [ALRM VTALRM IO], 8) = 0
rt_sigprocmask(SIG_BLOCK, [ALRM VTALRM IO], NULL, 8) = 0
rt_sigprocmask(SIG_UNBLOCK, [], [ALRM VTALRM IO], 8) = 0
rt_sigprocmask(SIG_BLOCK, [ALRM VTALRM IO], NULL, 8) = 0
rt_sigprocmask(SIG_SETMASK, NULL, [ALRM VTALRM IO], 8) = 0
rt_sigprocmask(SIG_BLOCK, [ALRM VTALRM IO], NULL, 8) = 0
rt_sigprocmask(SIG_UNBLOCK, [], [ALRM VTALRM IO], 8) = 0
rt_sigprocmask(SIG_BLOCK, [ALRM VTALRM IO], NULL, 8) = 0
rt_sigprocmask(SIG_SETMASK, NULL, [ALRM VTALRM IO], 8) = 0
rt_sigprocmask(SIG_BLOCK, [ALRM VTALRM IO], NULL, 8) = 0
rt_sigprocmask(SIG_UNBLOCK, [], [ALRM VTALRM IO], 8) = 0
rt_sigprocmask(SIG_BLOCK, [ALRM VTALRM IO], NULL, 8) = 0
rt_sigprocmask(SIG_SETMASK, NULL, [ALRM VTALRM IO], 8) = 0
rt_sigprocmask(SIG_BLOCK, [ALRM VTALRM IO], NULL, 8) = 0
rt_sigprocmask(SIG_UNBLOCK, [], [ALRM VTALRM IO], 8) = 0
rt_sigprocmask(SIG_BLOCK, [ALRM VTALRM IO], NULL, 8) = 0
rt_sigprocmask(SIG_SETMASK, NULL, [ALRM VTALRM IO], 8) = 0
rt_sigprocmask(SIG_BLOCK, [ALRM VTALRM IO], NULL, 8) = 0
rt_sigprocmask(SIG_UNBLOCK, [], [ALRM VTALRM IO], 8) = 0
rt_sigprocmask(SIG_BLOCK, [ALRM VTALRM IO], NULL, 8) = 0
rt_sigprocmask(SIG_SETMASK, NULL, [ALRM VTALRM IO], 8) = 0
rt_sigprocmask(SIG_BLOCK, [ALRM VTALRM IO], NULL, 8) = 0
rt_sigprocmask(SIG_UNBLOCK, [], [ALRM VTALRM IO], 8) = 0
rt_sigprocmask(SIG_BLOCK, [ALRM VTALRM IO], NULL, 8) = 0
rt_sigprocmask(SIG_SETMASK, NULL, [ALRM VTALRM IO], 8) = 0
rt_sigprocmask(SIG_BLOCK, [ALRM VTALRM IO], NULL, 8) = 0
rt_sigprocmask(SIG_UNBLOCK, [], [ALRM VTALRM IO], 8) = 0
rt_sigprocmask(SIG_BLOCK, [ALRM VTALRM IO], NULL, 8) = 0
uname({sys="Linux", node="xxx", ...}) = 0
rt_sigprocmask(SIG_SETMASK, NULL, [ALRM VTALRM IO], 8) = 0
rt_sigprocmask(SIG_BLOCK, [ALRM VTALRM IO], NULL, 8) = 0
rt_sigprocmask(SIG_UNBLOCK, [], [ALRM VTALRM IO], 8) = 0
rt_sigprocmask(SIG_BLOCK, [ALRM VTALRM IO], NULL, 8) = 0



... and so on so forth...


________________________________________________________________________
___
[6] gdb-ing 

Not enough experience in kernel development to extract meaningful data
from my little step-walk in the booting kernel... If anyone is
interested in the faulty binary I'll post it somewhere


Thanks for your time! 

Alessio Gaspar 



-------------------------------------------------------
This SF.Net email is sponsored by the 'Do More With Dual!' webinar happening
July 14 at 8am PDT/11am EDT. We invite you to explore the latest in dual
core and dual graphics technology at this free one hour event hosted by HP,
AMD, and NVIDIA.  To register visit http://www.hp.com/go/dualwebinar
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
