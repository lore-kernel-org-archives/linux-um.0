Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CYtkx-00069s-Cd for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 29 Nov 2004 14:12:27 -0800
Received: from smtp005.mail.ukl.yahoo.com ([217.12.11.36])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.41)
	id 1CYtkw-00047G-Bg for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 29 Nov 2004 14:12:27 -0800
From: Blaisorblade <blaisorblade_spam@yahoo.it>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200411292315.25368.blaisorblade_spam@yahoo.it>
Subject: [uml-devel] 2.6.9-bb3 on 2.6.9 host problem - triggering a host bug?
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
Date: Mon, 29 Nov 2004 23:15:25 +0100
To: user-mode-linux-devel@lists.sourceforge.net

Checking for the skas3 patch in the host...found
Checking for /proc/mm...found
Checking PROT_EXEC mmap in /tmp...OK
Linux version 2.6.9-skas3-v7-bb3nobodo-rework-hang (paolo@zion) (gcc version 
3.3.2 (Mandrake Linux 10.0 3.3.2-6mdk)) #9 FriNov 26 03:51:10 CET 2004
Built 1 zonelists
Kernel command line: ubd0s=slack90.rootfs rootfs=/dev/ubd0 ubd7=slack90.swapfs 
mem=64m eth0=tuntap,,,192.168.0.100 UML_XDISPLAY=192.168.0.100:0 
UML_IP=192.168.0.3 con=xterm con0=fd:0,fd:1 root=98:0
PID hash table entries: 512 (order: 9, 8192 bytes)
Dentry cache hash table entries: 16384 (order: 4, 65536 bytes)
Inode-cache hash table entries: 8192 (order: 3, 32768 bytes)
Memory: 61792k available
Kernel panic - not syncing: Segfault with no mm

EIP: 0000:[<00000000>] CPU: 0 Not tainted EFLAGS: 00000000
    Not tainted
EAX: 00000000 EBX: 00000000 ECX: 00000000 EDX: 00000000
ESI: 00000000 EDI: 00000000 EBP: 00000000 DS: 0000 ES: 0000
Call Trace:
 [<080791d3>] printk+0x13/0x20
 [<0808bbd6>] notifier_call_chain+0x26/0x50
 [<08078468>] panic+0x58/0xc0
 [<0805f2a2>] segv+0x192/0x1d0
 [<081e2157>] sigemptyset+0x17/0x30
 [<0805d483>] change_signals+0x43/0x70
 [<0805f673>] segv_handler+0xc3/0xd0
 [<0805d4cd>] unblock_signals+0xd/0x10
 [<08061cc4>] sig_handler_common_skas+0xa4/0xc0
 [<080616a0>] start_kernel_proc+0x0/0x30
 [<0805f6a3>] sig_handler+0x13/0x20
 [<081e1e88>] __restore+0x0/0x8
 [<080616a0>] start_kernel_proc+0x0/0x30
 [<0804871d>] start_kernel+0xfd/0x1b0
 [<0805d509>] enable_mask+0x39/0x50
 [<081e2157>] sigemptyset+0x17/0x30
 [<081e1e88>] __restore+0x0/0x8
 [<08071158>] file_io+0x28/0x80
 [<08071158>] file_io+0x28/0x80
 [<0805d509>] enable_mask+0x39/0x50
 [<081e2157>] sigemptyset+0x17/0x30
 [<0805d509>] enable_mask+0x39/0x50
 [<081e2157>] sigemptyset+0x17/0x30
 [<08071158>] file_io+0x28/0x80
 [<0805d509>] enable_mask+0x39/0x50
 [<081e2157>] sigemptyset+0x17/0x30
 [<0805d5f0>] set_signals+0x80/0x180
 [<08079727>] release_console_sem+0x1f7/0x270
 [<080795f5>] release_console_sem+0xc5/0x270
 [<080793a5>] vprintk+0x1c5/0x2e0
 [<080791d3>] printk+0x13/0x20
 [<0804cfb0>] free_all_bootmem+0x10/0x20
 [<0805969a>] mem_init+0xfa/0x110
 [<08059662>] mem_init+0xc2/0x110
 [<080616c7>] start_kernel_proc+0x27/0x30
 [<0805ad0a>] run_kernel_thread+0x3a/0x50
 [<080616a0>] start_kernel_proc+0x0/0x30
 [<0805acef>] run_kernel_thread+0x1f/0x50
 [<080616a0>] start_kernel_proc+0x0/0x30
 [<080613c7>] new_thread_handler+0x67/0xa0
 [<080616a0>] start_kernel_proc+0x0/0x30
 [<081e1e88>] __restore+0x0/0x8
 [<081e20e1>] kill+0x11/0x20

-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729
http://www.user-mode-linux.org/~blaisorblade


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
