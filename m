Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D0qPR-0004dZ-Q2 for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 14 Feb 2005 16:17:45 -0800
Received: from ns.theshore.net ([67.18.92.50] helo=www.theshore.net)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1D0qPQ-0004ln-8x for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 14 Feb 2005 16:17:45 -0800
Message-ID: <170001c512f4$2c279940$0201a8c0@hawk>
From: "Christopher S. Aker" <caker@theshore.net>
References: <200502110411.35438.blaisorblade@yahoo.it>
	<169101c512ef$6c905850$0201a8c0@hawk>
Subject: Re: [uml-devel] SKAS-v8: RC2 released against 2.6.7 - 2.6.11-rc3-bk6
	kernels
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
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
Date: Mon, 14 Feb 2005 18:20:33 -0600
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net

> I just rolled a 2.6.11-rc4+cfq-ts-21 host kernel and I'll be testing this today.

2.6.11 doesn't seem to be ready for host duty yet:

----
[root@host27 root]# uname -a
Linux host27.linode.com 2.6.11-rc4-1-bigmem64 #1 SMP Mon Feb 14 15:55:09 EST 2005
i686 i686 i386 GNU/Linux
----

[root@host27 root]# /vbin/kernel/2.6.11-rc3-mm2-aio
Checking for /proc/mm...found
Checking for the skas3 patch in the host...found
Checking PROT_EXEC mmap in /tmp...OK

[root@host27 root]#

----
[root@host27 root]# /vbin/kernel/2.6.11-rc3-mm2-aio
Checking for /proc/mm...found
Checking for the skas3 patch in the host...found
Checking PROT_EXEC mmap in /tmp...OK

[root@host27 root]# /vbin/kernel/2.6.10-linode11
Checking for the skas3 patch in the host...found
Checking for /proc/mm...found
Checking PROT_EXEC mmap in /tmp...OK
Linux version 2.6.10-linode11 (root@nova1.theshore.net) (gcc version 3.3.3 20040412
(Red Hat Linux 3.3.3-7)) #1 Wed Jan 19 14:49:24 EST 2005
Built 1 zonelists
Kernel command line: root=98:0
PID hash table entries: 256 (order: 8, 4096 bytes)
Dentry cache hash table entries: 8192 (order: 3, 32768 bytes)
Inode-cache hash table entries: 4096 (order: 2, 16384 bytes)
Memory: 27024k available
Security Framework v1.0.0 initialized
Capability LSM initialized
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
Checking for host processor cmov support...Yes
Checking for host processor xmm support...No
Checking that ptrace can change system call numbers...OK
Checking syscall emulation patch for ptrace...<0>Kernel panic - not syncing:
check_sysemu : expected SIGTRAP, got status = 256

EIP: 0000:[<00000000>] CPU: 0 Not tainted EFLAGS: 00000000
    Not tainted
EAX: 00000000 EBX: 00000000 ECX: 00000000 EDX: 00000000
ESI: 00000000 EDI: 00000000 EBP: 00000000 DS: 0000 ES: 0000
Call Trace:
 [<80033994>] vprintk+0xe4/0x134
 [<80041616>] notifier_call_chain+0x1e/0x38
 [<80032e65>] panic+0x55/0x104
 [<803513c3>] check_sysemu+0x33/0x150
 [<80351425>] check_sysemu+0x95/0x150
 [<803515b3>] check_ptrace+0xd3/0x124
 [<80022f04>] start_kernel_proc+0x0/0x2c
 [<80008bf9>] check_bugs+0xd/0x1c
 [<80022f04>] start_kernel_proc+0x0/0x2c
 [<80002553>] start_kernel+0x163/0x1a4
 [<8000250c>] start_kernel+0x11c/0x1a4
 [<80313781>] __sigjmp_save+0x2d/0x3c
 [<80022f29>] start_kernel_proc+0x25/0x2c
 [<80019e95>] run_kernel_thread+0x45/0x4c
 [<80022f04>] start_kernel_proc+0x0/0x2c
 [<80019e70>] run_kernel_thread+0x20/0x4c
 [<80022f04>] start_kernel_proc+0x0/0x2c
 [<80022cb7>] new_thread_handler+0x63/0x94
 [<80022f04>] start_kernel_proc+0x0/0x2c
 [<803138c8>] __restore+0x0/0x8
 [<80313b21>] kill+0x11/0x20

----
[root@host27 root]# /vbin/kernel/2.4.29-linode39-1um
Checking for the skas3 patch in the host...found
Checking for /proc/mm...found
Checking PROT_EXEC mmap in /tmp...OK
Checking for /dev/anon on the host...Not available (open failed with errno 6)
Linux version 2.4.29-linode39-1um (root@nova1.theshore.net) (gcc version 3.3.3
20040412 (Red Hat Linux 3.3.3-7)) #1 Wed Jan 19 12:22:14 EST 2005
On node 0 totalpages: 8192
zone(0): 8192 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Kernel command line: root=/dev/ubd0
Calibrating delay loop... 3853.51 BogoMIPS
Memory: 27296k available
Dentry cache hash table entries: 4096 (order: 3, 32768 bytes)
Inode cache hash table entries: 2048 (order: 2, 16384 bytes)
Mount cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer cache hash table entries: 1024 (order: 0, 4096 bytes)
Page-cache hash table entries: 8192 (order: 3, 32768 bytes)
Checking for host processor cmov support...Yes
Checking for host processor xmm support...No
Checking that ptrace can change system call numbers...OK
Checking syscall emulation patch for ptrace...<0>Kernel panic: check_ptrace :
expected SIGTRAP, got status = 256
In idle task - not syncing
 <6>SysRq : Show Regs

EIP: 0000:[<00000000>] CPU: 0 Not tainted EFLAGS: 00000000
    Not tainted
EAX: 00000000 EBX: 00000000 ECX: 00000000 EDX: 00000000
ESI: 00000000 EDI: 00000000 EBP: 00000000 DS: 0000 ES: 0000
Call Trace: [<80312ce7>] [<8031a484>] [<800125cf>] [<801a9f8e>] [<80195875>]
   [<8001f15e>] [<80014bc7>] [<8000755e>] [<800075ae>] [<8033a198>] [<8031a0bb>]
   [<80199d5c>] [<80007b91>] [<800024cb>] [<80199d5c>] [<80002472>] [<802ab4f1>]
   [<80199d81>] [<80199d5c>] [<80190441>] [<80199d5c>] [<8019041c>] [<80199d5c>]
   [<80199ac5>] [<80199d5c>] [<80199561>] [<802ab638>] [<802ab891>]


-Chris



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
