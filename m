Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CY3hN-0006ii-RV for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 27 Nov 2004 06:37:17 -0800
Received: from ns.theshore.net ([67.18.92.50] helo=www.theshore.net)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1CY3hM-0001ov-QU for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 27 Nov 2004 06:37:17 -0800
Received: from hawk (mothership.theshore.net [69.137.84.52])
	by www.theshore.net (8.12.9/8.9.1) with SMTP id iAREbG5h022160
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sat, 27 Nov 2004 09:37:16 -0500
Message-ID: <091a01c4d48e$9dddcd60$0201a8c0@hawk>
From: "Christopher S. Aker" <caker@theshore.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Subject: [uml-devel] 2.6.10-rc2-mm3 + incrementals - Kernel panic - not
	syncing: Segfault with no mm
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
Date: Sat, 27 Nov 2004 08:37:24 -0600
To: uml-devel <user-mode-linux-devel@lists.sourceforge.net>

Host: 2.6.9+skas-v7

Checking for the skas3 patch in the host...found
Checking for /proc/mm...found
Checking PROT_EXEC mmap in /tmp...OK
Linux version 2.6.10-rc2-mm3-linode9 (root@nova1.theshore.net) (gcc version 3.3.3
20040412 (Red Hat Linux 3.3.3-7)) #1 Sat Nov 27 09:30:45 EST 2004
Built 1 zonelists
Kernel command line: mem=192M fake_ide fakehd con=null con0=fd:0,fd:1 devfs=nomount
root=/dev/ubda ubda=/linodes/linode2/14983.fs ubdb=/linodes/linode2/14936.fs
eth0=tuntap,linode2_0,fe:fd:40:3e:e7:03 token_max=400000 token_refill=512
fakehd : Changing ubd name to "hd".
PID hash table entries: 1024 (order: 10, 16384 bytes)
Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
Memory: 189056k available
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
Checking for host processor cmov support...Yes
Checking for host processor xmm support...
No
Checking that ptrace can change system call numbers...OK
Checking syscall emulation patch for ptrace...OK
Checking that host ptys support output SIGIO...Yes
Checking that host ptys support SIGIO on close...No, enabling workaround
Checking for /dev/anon on the host...Not available (open failed with errno 6)
NET: Registered protocol family 16
fscache: general fs caching registered
CacheFS: general fs caching v0.1 registered
mconsole (version 2) initialized on /linodes/linode2/.uml/linode2/mconsole
Netdevice 0 (fe:fd:40:3e:e7:03) : TUN/TAP backend -
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
devfs: 2004-01-31 Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x0
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
SGI XFS with ACLs, security attributes, no debug enabled
SGI XFS Quota Management subsystem
Initializing Cryptographic API
Kernel panic - not syncing: Segfault with no mm

EIP: 0073:[<80362481>] CPU: 0 Not tainted ESP: 007b:b7ffefa0 EFLAGS: 00000296
    Not tainted
EAX: 00000000 EBX: 00000b9f ECX: 00000013 EDX: 00000b9f
ESI: 00000b9e EDI: 00000000 EBP: 00000000 DS: 007b ES: 007b
Call Trace:
 [<800338a4>] vprintk+0xe4/0x134
 [<800424e6>] notifier_call_chain+0x1e/0x38
 [<80032d61>] panic+0x55/0x104
 [<8001c98e>] segv+0x152/0x1c4
 [<80362507>] sigemptyset+0x17/0x30
 [<8001b085>] change_signals+0x41/0x6c
 [<8001ccf0>] segv_handler+0x160/0x208
 [<80362481>] kill+0x11/0x20
 [<8001cc5f>] segv_handler+0xcf/0x208
 [<800215c4>] sig_handler_common_skas+0x7c/0x98
 [<800215dd>] sig_handler_common_skas+0x95/0x98
 [<8002eda9>] sig_handler+0x31/0x34
 [<80362228>] __restore+0x0/0x8
 [<8002ffd2>] check_rlimit+0x1e/0x94
 [<80362507>] sigemptyset+0x17/0x30
 [<80362507>] sigemptyset+0x17/0x30
 [<8001b1c8>] set_signals+0x6c/0x10c
 [<80362507>] sigemptyset+0x17/0x30
 [<8001b1c8>] set_signals+0x6c/0x10c
 [<80362507>] sigemptyset+0x17/0x30
 [<8001b085>] change_signals+0x41/0x6c
 [<8002ee2c>] os_usecs+0x10/0x2c
 [<8003e8bf>] update_process_times+0x83/0xfc
 [<8001c120>] timer_irq+0x18c/0x1a4
 [<800215c4>] sig_handler_common_skas+0x7c/0x98
 [<80362507>] sigemptyset+0x17/0x30
 [<8001b02f>] change_sig+0x4b/0x60
 [<80362228>] __restore+0x0/0x8
 [<80362507>] sigemptyset+0x17/0x30
 [<8001b085>] change_signals+0x41/0x6c
 [<80362446>] sigprocmask+0x1a/0x44
 [<80030064>] account_user_time+0x1c/0x9c
 [<8003e860>] update_process_times+0x24/0xfc
 [<8001b0ba>] block_signals+0xa/0x10
 [<8001c419>] timer_handler+0x2d/0x60
 [<8001c3f9>] timer_handler+0xd/0x60
 [<800215c4>] sig_handler_common_skas+0x7c/0x98
 [<80021565>] sig_handler_common_skas+0x1d/0x98
 [<8002ee09>] alarm_handler+0x5d/0x70
 [<80362228>] __restore+0x0/0x8
 [<80362446>] sigprocmask+0x1a/0x44
 [<80362507>] sigemptyset+0x17/0x30
 [<8001b1c8>] set_signals+0x6c/0x10c
 [<80362507>] sigemptyset+0x17/0x30
 [<8001b1c8>] set_signals+0x6c/0x10c
 [<80362507>] sigemptyset+0x17/0x30
 [<8001b085>] change_signals+0x41/0x6c
 [<80362507>] sigemptyset+0x17/0x30
 [<8001b1c8>] set_signals+0x6c/0x10c
 [<80362507>] sigemptyset+0x17/0x30
 [<80362507>] sigemptyset+0x17/0x30
 [<8001b1c8>] set_signals+0x6c/0x10c
 [<80362507>] sigemptyset+0x17/0x30
 [<8001b1c8>] set_signals+0x6c/0x10c
 [<80362507>] sigemptyset+0x17/0x30
 [<80362507>] sigemptyset+0x17/0x30
 [<8001b085>] change_signals+0x41/0x6c
 [<8001b0ca>] unblock_signals+0xa/0x10
 [<80034314>] release_task+0x94/0x158
 [<80035098>] exit_notify+0x36c/0x770
 [<80035041>] exit_notify+0x315/0x770
 [<80035643>] do_exit+0x1a7/0x474
 [<80035616>] do_exit+0x17a/0x474
 [<80044d75>] ____call_usermodehelper+0x69/0xa4
 [<80044d0c>] ____call_usermodehelper+0x0/0xa4
 [<80018f7d>] run_kernel_thread+0x45/0x4c
 [<80044d0c>] ____call_usermodehelper+0x0/0xa4
 [<80018f58>] run_kernel_thread+0x20/0x4c
 [<8001b0ca>] unblock_signals+0xa/0x10
 [<8002fd8c>] finish_task_switch+0x24/0xa4
 [<80044d0c>] ____call_usermodehelper+0x0/0xa4
 [<8002fe1d>] schedule_tail+0x11/0xf4
 [<80044d0c>] ____call_usermodehelper+0x0/0xa4
 [<80020dd7>] new_thread_handler+0x63/0x94
 [<80044d0c>] ____call_usermodehelper+0x0/0xa4
 [<80362228>] __restore+0x0/0x8
 [<80362481>] kill+0x11/0x20




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
