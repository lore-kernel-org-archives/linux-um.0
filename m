Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BpkgY-0003A7-3h for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 28 Jul 2004 02:25:18 -0700
Received: from webhosting.rdsbv.ro ([213.157.185.164] helo=hosting.rdsbv.ro)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.34) id 1BpkgX-0001uO-A7
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 28 Jul 2004 02:25:18 -0700
From: "Catalin(ux aka Dino) BOIE" <util@deuroconsult.ro>
In-Reply-To: <200407280422.i6S4M7fL008720@ccure.user-mode-linux.org>
Message-ID: <Pine.LNX.4.60.0407281208080.23608@hosting.rdsbv.ro>
References: <200407280422.i6S4M7fL008720@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Subject: [uml-devel] Re: uml-patch-2.6.7-1 [bug report 2]
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
Date: Wed, 28 Jul 2004 12:25:11 +0300 (EEST)
To: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

> Here is a belated patch that updates UML to 2.6.7.  The update was the only
> change from the 2.6.6 UML.

Host is 2.6.7 without patches.

./linux mem=32M ubd0=ROOTx
Checking for the skas3 patch in the host...not found
Checking for /proc/mm...not found
tracing thread pid = 14560
Linux version 2.6.7-1um (root@dino) (gcc version 3.3.4) #1 Wed Jul 28 
10:50:24 EEST 2004
On node 0 totalpages: 8192
   DMA zone: 8192 pages, LIFO batch:2
   Normal zone: 0 pages, LIFO batch:1
   HighMem zone: 0 pages, LIFO batch:1
Built 1 zonelists
Kernel command line: mem=32M ubd0=ROOTx root=98:0
PID hash table entries: 16 (order 4: 128 bytes)
Memory: 28728k available
Calibrating delay loop... 1667.89 BogoMIPS
Security Scaffold v1.0.0 initialized
Capability LSM initialized
Dentry cache hash table entries: 4096 (order: 2, 16384 bytes)
Inode-cache hash table entries: 2048 (order: 1, 8192 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
Checking for host processor cmov support...Yes
Checking for host processor xmm support...No
Checking that ptrace can change system call numbers...OK
Checking that host ptys support output SIGIO...Yes
Checking that host ptys support SIGIO on close...No, enabling workaround
Checking for /dev/anon on the host...Not available (open failed with errno 
2)
NET: Registered protocol family 16
mconsole (version 2) initialized on /root/.uml/bcNIqz/mconsole
UML Watchdog Timer
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
Initializing Cryptographic API
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
netconsole: not configured, aborting
md: linear personality registered as nr 1
md: raid0 personality registered as nr 2
md: raid1 personality registered as nr 3
md: raid5 personality registered as nr 4
raid5: measuring checksumming speed
    8regs     :  3810.000 MB/sec
    8regs_prefetch:  2555.600 MB/sec
    32regs    :  1729.200 MB/sec
    32regs_prefetch:  1715.200 MB/sec
raid5: using function: 8regs (3810.000 MB/sec)
raid6: int32x1    619 MB/s
raid6: int32x2    603 MB/s
raid6: int32x4    476 MB/s
raid6: int32x8    347 MB/s
raid6: using algorithm int32x1 (619 MB/s)
md: raid6 personality registered as nr 8
md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
device-mapper: 4.1.0-ioctl (2003-12-10) initialised: dm@uk.sistina.com
NET: Registered protocol family 2
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 2048 bind 4096)
NET: Registered protocol family 1
NET: Registered protocol family 10
IPv6 over IPv4 tunneling driver
NET: Registered protocol family 17
NET: Registered protocol family 15
Initializing software serial port version 1
Kernel panic: fix_range fixing wrong address space, current = 0xa08cc700
  <6>SysRq : Show Regs

EIP: 0073:[<a01de26d>] CPU: 0 Not tainted ESP: 007b:a08c17ac EFLAGS: 
00000292
     Not tainted
EAX: 00000000 EBX: 0000394b ECX: 0000000a EDX: ffffffff
ESI: a001d480 EDI: 00000000 EBP: a08c17d4 DS: 007b ES: 007b
Call Trace: [<a010b2d4>] [<a001c11f>] [<a00357b1>] [<a0042406>] 
[<a0034cb5>]
    [<a0034d37>] [<a0016728>] [<a001e6c6>] [<a001e63b>] [<a001eb89>] 
[<a001ae69>]
    [<a001d212>] [<a0207669>] [<a00372de>] [<a0037288>] [<a0012558>] 
[<a0045659>]
    [<a0045630>] [<a01c4630>] [<a00455d0>] [<a00166fa>] [<a001934d>] 
[<a00455d0>]
    [<a00166df>] [<a002fd0d>] [<a00455d0>] [<a00455d0>] [<a002fd91>] 
[<a01dc3a0>]
    [<a0017050>] [<a0016495>] [<a00455d0>] [<a001d398>] [<a001d3f5>] 
[<a001d480>]
    [<a01c4978>] [<a001d480>] [<a01de26d>]
sleeping process 14665 got unexpected signal : 10


If I start gdb:
att 14560
Attaching to program: /data/UML3/kernels/K2.6.7, process 14560
0xa01da830 in pause () at sock.h:805
805     sock.h: No such file or directory.
         in sock.h
(gdb) bt
#0  0xa01da830 in pause () at sock.h:805
#1  0xa001ede5 in tracer_panic (
     format=0xa022a300 "sleeping process %d got unexpected signal : %d\n")
     at arch/um/kernel/tt/tracer.c:86
#2  0xa001ef34 in sleeping_process_signal (pid=14665, sig=10)
     at arch/um/kernel/tt/tracer.c:153
#3  0xa001f3e5 in tracer (init_proc=0xa001db60 <start_kernel_proc>,
     sp=0xa0277ffc) at arch/um/kernel/tt/tracer.c:292
#4  0xa001dccb in start_uml_tt () at arch/um/kernel/tt/process_kern.c:507
#5  0xa001bfe3 in linux_main (argc=-1610612736, argv=0x2000000)
     at arch/um/kernel/um_arch.c:389
#6  0xa000e3a6 in main (argc=4, argv=0xbffff554, envp=0xbffff568)
     at arch/um/main.c:146

---
Catalin(ux aka Dino) BOIE
catab at deuroconsult.ro
http://kernel.umbrella.ro/


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
