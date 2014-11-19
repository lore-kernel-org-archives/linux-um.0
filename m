Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <toralf.foerster@gmx.de>) id 1Xr8iA-0002cR-KH
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 19 Nov 2014 17:06:34 +0000
Received: from mout.gmx.net ([212.227.17.20])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Xr8i8-0004Vr-Vs
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 19 Nov 2014 17:06:34 +0000
Received: from [192.168.178.21] ([78.54.141.44]) by mail.gmx.com (mrgmx103)
	with ESMTPSA (Nemesis) id 0MUpI8-1XRoMv4BQa-00Y9ef for
	<user-mode-linux-devel@lists.sourceforge.net>; Wed, 19 Nov 2014 18:06:26
	+0100
Message-ID: <546CCE10.4010007@gmx.de>
Date: Wed, 19 Nov 2014 18:06:24 +0100
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
Subject: [uml-devel] starting an UML image sometimes failed,
 next (identical) attempt works
To: UML devel <user-mode-linux-devel@lists.sourceforge.net>

/me wonders, why the same call few seconds later works (current git kernel), but not for the first time :

$ nice start_uml.sh -r trinity 
+ /usr/local/bin/linux-v3.18-rc4 earlyprintk ubda=/home/tfoerste/virtual/uml/trinity ubdb=/mnt/ramdisk/trinity_swap eth0=tuntap,tap0,72:ef:3d:9f:c3:5a mem=2000M con0=fd:0,fd:1 con=pts umid=uml_trinity rootfstype=ext4 softlockup_all_cpu_backtrace=1

Locating the bottom of the address space ... 0x1000
Locating the top of the address space ... 0xc0000000
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
Adding 28835840 bytes to physical memory to account for exec-shield gap
Kernel virtual memory size shrunk to 953155584 bytes
bootconsole [earlycon0] enabled
PID hash table entries: 4096 (order: 2, 16384 bytes)
Dentry cache hash table entries: 262144 (order: 8, 1048576 bytes)
Inode-cache hash table entries: 131072 (order: 7, 524288 bytes)
Memory: 2022804K/2076160K available (4848K kernel code, 310K rwdata, 1784K rodata, 118K init, 240K bss, 53356K reserved)
SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=1, Nodes=1
NR_IRQS:15
Calibrating delay loop... 2072.57 BogoMIPS (lpj=10362880)
pid_max: default: 32768 minimum: 301
Mount-cache hash table entries: 4096 (order: 2, 16384 bytes)
Mountpoint-cache hash table entries: 4096 (order: 2, 16384 bytes)
Checking for host processor cmov support...Yes
Checking that host ptys support output SIGIO...tty_output : read failed, err = -1
Checking that host ptys support SIGIO on close...No, enabling workaround
devtmpfs: initialized
Using 2.6 host AIO
xor: measuring software checksum speed
   8regs     :  2519.200 MB/sec
   8regs_prefetch:  2843.600 MB/sec
   32regs    :  1999.200 MB/sec
   32regs_prefetch:  1238.400 MB/sec
xor: using function: 8regs_prefetch (2843.600 MB/sec)
prandom: seed boundary self test passed
prandom: 100 self tests passed
NET: Registered protocol family 16
raid6: int32x1    235 MB/s
raid6: int32x2    292 MB/s
raid6: int32x4    188 MB/s
raid6: int32x8    183 MB/s
raid6: using algorithm int32x2 (292 MB/s)
raid6: using intx1 recovery algorithm
Switched to clocksource itimer
NET: Registered protocol family 2
TCP established hash table entries: 16384 (order: 4, 65536 bytes)
TCP bind hash table entries: 16384 (order: 6, 327680 bytes)
TCP: Hash tables configured (established 16384 bind 16384)
TCP: reno registered
UDP hash table entries: 1024 (order: 3, 49152 bytes)
UDP-Lite hash table entries: 1024 (order: 3, 49152 bytes)
NET: Registered protocol family 1
RPC: Registered named UNIX socket transport module.
RPC: Registered udp transport module.
RPC: Registered tcp transport module.
RPC: Registered tcp NFSv4.1 backchannel transport module.
console [stderr0] disabled
mconsole (version 2) initialized on /home/tfoerste/.uml/uml_trinity/mconsole
Checking host MADV_REMOVE support...OK
UML Audio Relay (host dsp = /dev/sound/dsp, host mixer = /dev/sound/mixer)
Host TLS support detected
Detected host type: i386 (GDT indexes 6 to 9)
futex hash table entries: 256 (order: 0, 7168 bytes)
audit: initializing netlink subsys (disabled)
audit: type=2000 audit(1416416597.671:1): initialized
zpool: loaded
zbud: loaded
NFS: Registering the id_resolver key type
Key type id_resolver registered
Key type id_legacy registered
nfs4filelayout_init: NFSv4 File Layout Driver Registering...
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
msgmni has been set to 3950
alg: No test for stdrng (krng)
Block layer SCSI generic (bsg) driver version 0.4 loaded (major 254)
io scheduler noop registered (default)
loop: module loaded
device-mapper: uevent: version 1.0.3
device-mapper: ioctl: 4.28.0-ioctl (2014-09-17) initialised: dm-devel@redhat.com
TCP: cubic registered
NET: Registered protocol family 10
sit: IPv6 over IPv4 tunneling driver
NET: Registered protocol family 17

Key type dns_resolver registered
Initialized stdio console driver
Console initialized on /dev/tty0
                                console [tty0] enabled
console [tty0] enabled
                      bootconsole [earlycon0] disabled
bootconsole [earlycon0] disabled
                                Initializing software serial port version 1
console [mc-1] enabled
Failed to initialize ubd device 0 :Couldn't determine size of device's file
 ubdb: unknown partition table
Netdevice 0 (72:ef:3d:9f:c3:5a) : 
TUN/TAP backend - 
Btrfs loaded
winch_thread : TIOCSCTTY failed on fd 1 err = 1
VFS: Cannot open root device "98:0" or unknown-block(98,0): error -6
Please append a correct "root=" boot option; here are the available partitions:
6210          262144 ubdb  driver: uml-blkdev
Kernel panic - not syncing: VFS: Unable to mount root fs on unknown-block(98,0)
CPU: 0 PID: 1 Comm: swapper Not tainted 3.18.0-rc4 #12
Stack:
 085c8b17 085c8b17 086f8547 085068c1 fffffffa 864aff40 864afef8 08509f65
 00000000 864afed0 864aff20 085060bd 085d4920 08739180 085c5be0 864aff30
 00000000 fffffffa 864aff40 00008001 864aff6c 08048f9d 085c5be0 864aff40
Call Trace:
 [<085068c1>] ? printk+0x38/0x3a
 [<08060ae9>] show_stack+0x119/0x180
 [<085068c1>] ? printk+0x38/0x3a
 [<08509f65>] dump_stack+0x26/0x28
 [<085060bd>] panic+0x8f/0x1a9
 [<08048f9d>] mount_block_root+0x1e0/0x261
 [<0811bea8>] ? SyS_mknod+0x28/0x30
 [<0804907e>] mount_root+0x60/0x66
 [<080491c3>] prepare_namespace+0x13f/0x185
 [<08048cb2>] kernel_init_freeable+0x190/0x19d
 [<0804821f>] ? repair_env_string+0x0/0x91
 [<0850493b>] kernel_init+0xb/0xe0
 [<0805f69b>] new_thread_handler+0x6b/0x90



-- 
Toralf
pgp key: 0076 E94E


------------------------------------------------------------------------------
Download BIRT iHub F-Type - The Free Enterprise-Grade BIRT Server
from Actuate! Instantly Supercharge Your Business Reports and Dashboards
with Interactivity, Sharing, Native Excel Exports, App Integration & more
Get technology previously reserved for billion-dollar corporations, FREE
http://pubads.g.doubleclick.net/gampad/clk?id=157005751&iu=/4140/ostg.clktrk
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

