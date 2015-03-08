Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <toralf.foerster@gmx.de>) id 1YUiWH-0003JP-Ox
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 08 Mar 2015 21:13:53 +0000
Received: from mout.gmx.net ([212.227.15.18])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1YUiWF-00064P-DO
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 08 Mar 2015 21:13:53 +0000
Received: from [192.168.178.24] ([80.171.108.136]) by mail.gmx.com (mrgmx003)
	with ESMTPSA (Nemesis) id 0LjZhg-1XtAm10368-00bYip for
	<user-mode-linux-devel@lists.sourceforge.net>; Sun, 08 Mar 2015 22:13:45
	+0100
Message-ID: <54FCBB88.70605@gmx.de>
Date: Sun, 08 Mar 2015 22:13:44 +0100
From: =?UTF-8?B?VG9yYWxmIEbDtnJzdGVy?= <toralf.foerster@gmx.de>
MIME-Version: 1.0
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
Subject: [uml-devel] starting an 32 bit x86 chroot uml image at a ahrdened
 Gentoo amd64 system fails
To: UML devel <user-mode-linux-devel@lists.sourceforge.net>

Well, in fact, since I switched from x86 to amd64 under Gentoo, I never managed to get that chroot to be booted.
During boot of the UML guest it just hangs around  "devtmpfs: mounted" w/o any output

Today I decided to try  defconfig, and now I do get at least an output. Any hints how to continue ? :


tfoerste@t44 ~/devel/linux $ start_uml.sh -r trinity                   
+ STTRACE=
+ /home/tfoerste/devel/linux/linux earlyprintk ubda=/home/tfoerste/virtual/uml/trinity ubdb=/mnt/ramdisk/trinity_swap eth0=tuntap,tap0,72:ef:3d:9f:c3:5a mem=1000M con0=fd:0,fd:1 con=pts umid=uml_trinity rootfstype=ext4 softlockup_all_cpu_backtrace=1
Core dump limits :
        soft - 0
        hard - NONE
Checking that ptrace can change system call numbers...OK
Checking syscall emulation patch for ptrace...OK
Checking advanced syscall emulation patch for ptrace...OK
Checking environment variables for a tempdir...none found
Checking if /dev/shm is on tmpfs...OK
Checking PROT_EXEC mmap in /dev/shm...OK
Checking for the skas3 patch in the host:
  - /proc/mm...not found: No such file or directory
  - PTRACE_FAULTINFO...not found
  - PTRACE_LDT...not found
UML running in SKAS0 mode
bootconsole [earlycon0] enabled
PID hash table entries: 4096 (order: 3, 32768 bytes)
Dentry cache hash table entries: 131072 (order: 8, 1048576 bytes)
Inode-cache hash table entries: 65536 (order: 7, 524288 bytes)
Memory: 1001892K/1024000K available (2481K kernel code, 619K rwdata, 772K rodata, 112K init, 156K bss, 22108K reserved, 0K cma-reserved)
NR_IRQS:15
Calibrating delay loop... 5599.23 BogoMIPS (lpj=27996160)
pid_max: default: 32768 minimum: 301
Mount-cache hash table entries: 2048 (order: 2, 16384 bytes)
Mountpoint-cache hash table entries: 2048 (order: 2, 16384 bytes)
Initializing cgroup subsys blkio
Initializing cgroup subsys devices
Initializing cgroup subsys freezer
Checking that host ptys support output SIGIO...Yes
Checking that host ptys support SIGIO on close...No, enabling workaround
devtmpfs: initialized
Using 2.6 host AIO
NET: Registered protocol family 16
Switched to clocksource itimer
NET: Registered protocol family 2
TCP established hash table entries: 8192 (order: 4, 65536 bytes)
TCP bind hash table entries: 8192 (order: 4, 65536 bytes)
TCP: Hash tables configured (established 8192 bind 8192)
TCP: reno registered
UDP hash table entries: 512 (order: 2, 16384 bytes)
UDP-Lite hash table entries: 512 (order: 2, 16384 bytes)
NET: Registered protocol family 1
console [stderr0] disabled
mconsole (version 2) initialized on /home/tfoerste/.uml/uml_trinity/mconsole
Checking host MADV_REMOVE support...OK
futex hash table entries: 256 (order: 0, 6144 bytes)
VFS: Disk quotas dquot_6.5.2
VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
io scheduler noop registered
io scheduler deadline registered (default)
TCP: cubic registered
NET: Registered protocol family 17
Initialized stdio console driver
Console initialized on /dev/tty0
                                console [tty0] enabled
console [tty0] enabled
                      bootconsole [earlycon0] disabled
bootconsole [earlycon0] disabled
                                Initializing software serial port version 1
console [mc-1] enabled
Netdevice 0 (72:ef:3d:9f:c3:5a) : 
TUN/TAP backend - 
winch_thread : TIOCSCTTY failed on fd 1 err = 1
EXT4-fs (ubda): mounted filesystem with ordered data mode. Opts: (null)
VFS: Mounted root (ext4 filesystem) readonly on device 98:0.
devtmpfs: mounted

Modules linked in:
Pid: 1, comm: swapper Not tainted 4.0.0-rc2-00424-g1711fd9
RIP: 0033:[<0000000060250abe>]
RSP: 0000037066baff08  EFLAGS: 00010202
RAX: 0000000060250aac RBX: 00000000606069a8 RCX: 00000370664d7b99
RDX: 0000000060235550 RSI: 0000037066bb0fe8 RDI: 000000009e5b1000
RBP: 0000037066bb0fe8 R08: 0000000000000000 R09: 0000000000000000
R10: 000000009e019778 R11: 0000000000000246 R12: 000000009e5b1000
R13: 0000037066bb0000 R14: 0000000060235a60 R15: 00000000602d95a8
Kernel panic - not syncing: Segfault with no mm
CPU: 0 PID: 1 Comm: swapper Not tainted 4.0.0-rc2-00424-g1711fd9 #1
Stack:

Modules linked in:
Pid: 1, comm: swapper Not tainted 4.0.0-rc2-00424-g1711fd9
RIP: 0033:[<00000000602388b1>]
RSP: 0000000060573450  EFLAGS: 00010202
RAX: 0000000000000006 RBX: 000000006049c25e RCX: 00000000606069a8
RDX: 0000000000000000 RSI: 0000000060615338 RDI: 0000000000000000
RBP: 0000000060573480 R08: 0000000060573059 R09: 000000006027e906
R10: 0000000000000008 R11: 00000000003b91b9 R12: 0000037066baff0f
R13: 0000000000000001 R14: 00000000605736f0 R15: 0000000000000001
Kernel panic - not syncing: Segfault with no mm
+ rc=1
+ rm /mnt/ramdisk/trinity_swap
+ [[ 1 -ne 0 ]]
++ expr 1 % 128
+ RC=1
+ reset
+ exit 1



-- 
Toralf
pgp key: 7B1A 07F4 EC82 0F90 D4C2  8936 872A E508 0076 E94E


------------------------------------------------------------------------------
Dive into the World of Parallel Programming The Go Parallel Website, sponsored
by Intel and developed in partnership with Slashdot Media, is your hub for all
things parallel software development, from weekly thought leadership blogs to
news, videos, case studies, tutorials and more. Take a look and join the 
conversation now. http://goparallel.sourceforge.net/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

