Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1C4bKH-0006E1-K9 for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 07 Sep 2004 01:27:41 -0700
Received: from webhosting.rdsbv.ro ([213.157.185.164] helo=hosting.rdsbv.ro)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.34) id 1C4bKE-00041C-L5
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 07 Sep 2004 01:27:41 -0700
Received: from hosting.rdsbv.ro (hosting.rdsbv.ro [213.157.185.164])
	by hosting.rdsbv.ro (8.12.11/8.12.11) with ESMTP id i878R6nu008303
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Tue, 7 Sep 2004 11:27:06 +0300
From: "Catalin(ux aka Dino) BOIE" <util@deuroconsult.ro>
Message-ID: <Pine.LNX.4.61.0409071058020.25003@hosting.rdsbv.ro>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Subject: [uml-devel] Host: 2.6.7, guest: 2.6.8.1, without SKAS
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
Date: Tue, 7 Sep 2004 11:27:06 +0300 (EEST)
To: user-mode-linux-devel@lists.sourceforge.net

Hello!

This is what I get when I run a 2.6.8.1 guest:

tracing thread pid = 20281
Linux version 2.6.8.1-1um (root@dino) (gcc version 3.3.4) #1 Mon Sep 6 
14:03:34 EEST 2004
Built 1 zonelists
Kernel command line: mem=64M root=98:0
PID hash table entries: 16 (order 4: 128 bytes)
Dentry cache hash table entries: 16384 (order: 4, 65536 bytes)
Inode-cache hash table entries: 8192 (order: 3, 32768 bytes)
Memory: 61072k available
Calibrating delay loop... 1648.23 BogoMIPS
Security Scaffold v1.0.0 initialized
Capability LSM initialized
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
Checking for host processor cmov support...Yes
Checking for host processor xmm support...No
Checking that ptrace can change system call numbers...OK
Checking that host ptys support output SIGIO...Yes
Checking that host ptys support SIGIO on close...No, enabling workaround
Checking for /dev/anon on the host...Not available (open failed with errno 
2)
NET: Registered protocol family 16
TC classifier action (bugs to netdev@oss.sgi.com cc hadi@cyberus.ca)
mconsole (version 2) initialized on /root/.uml/cGozAB/mconsole
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
Initializing Cryptographic API
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
netconsole: not configured, aborting
NET: Registered protocol family 2
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 4096 bind 8192)
NET: Registered protocol family 1
NET: Registered protocol family 10
IPv6 over IPv4 tunneling driver
NET: Registered protocol family 17
NET: Registered protocol family 15
Initializing software serial port version 1
Kernel panic: fix_range fixing wrong address space, current = 0xa3fba760
  <6>SysRq : Show Regs

EIP: 0073:[<a01a2d9b>] CPU: 0 Not tainted ESP: 007b:a0369688 EFLAGS: 
00000246
     Not tainted
EAX: 00000000 EBX: 00000001 ECX: a036973c EDX: a03696bc
ESI: 00000008 EDI: 00000001 EBP: a03696a4 DS: 007b ES: 007b
Call Trace: [<a0101a04>] [<a001a30f>] [<a0030e41>] [<a003c676>] 
[<a0030425>]
    [<a00304a7>] [<a0015a08>] [<a001c6e6>] [<a001c65b>] [<a001cb89>] 
[<a0019349>]
    [<a001b452>] [<a01e5c44>] [<a0032b2e>] [<a0032ad8>] [<a00115e8>] 
[<a003f479>]
    [<a003f450>] [<a01a29e0>] [<a003f3f0>] [<a00159da>] [<a0017ccd>] 
[<a003f3f0>]
    [<a00159bf>] [<a002c001>] [<a001b583>] [<a003f3f0>] [<a001b628>] 
[<a001b685>]
    [<a01a2d28>] [<a01a2d9b>]
sleeping process 20369 got unexpected signal : 10


If I try to run "./K2.6.8.1 debug" gdb hangs.

Can you help me investigate this?

Thank you!
---
Catalin(ux aka Dino) BOIE
catab at deuroconsult.ro
http://kernel.umbrella.ro/


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
