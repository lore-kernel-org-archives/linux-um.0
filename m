Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CcRGB-0003DQ-Hq for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 09 Dec 2004 08:35:19 -0800
Received: from outpost.ds9a.nl ([213.244.168.210] ident=postfix)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1CcRG9-0004VT-2a for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 09 Dec 2004 08:35:19 -0800
From: bert hubert <ahu@ds9a.nl>
Message-ID: <20041209163510.GA11091@outpost.ds9a.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [uml-devel] panic on empty commandline
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
Date: Thu, 9 Dec 2004 17:35:10 +0100
To: jdike@addtoit.com
Cc: user-mode-linux-devel@lists.sourceforge.net

$ ./linux
Checking PROT_EXEC mmap in /tmp...OK
Linux version 2.6.10-rc3 (ahu@d800.ds9a.nl) (gcc version 3.3.4 (Debian 1:3.3.4-13)) #2 Thu Dec 9 15:36:16 CET 2004
Built 1 zonelists
Kernel command line: root=98:0
PID hash table entries: 256 (order: 8, 4096 bytes)
Dentry cache hash table entries: 8192 (order: 3, 32768 bytes)
Inode-cache hash table entries: 4096 (order: 2, 16384 bytes)
Memory: 27440k available
Security Framework v1.0.0 initialized
Capability LSM initialized
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
Checking for host processor cmov support...Yes
Checking for host processor xmm support...No
Checking that ptrace can change system call numbers...OK
Checking syscall emulation patch for ptrace...missing
Checking that host ptys support output SIGIO...Yes
Checking that host ptys support SIGIO on close...No, enabling workaround
Checking for /dev/anon on the host...Not available (open failed with errno 2)
NET: Registered protocol family 16
NET: Registered protocol family 23
mconsole (version 2) initialized on /home/ahu/.uml/oJLt21/mconsole
ubd: Synchronous mode
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
devfs: 2004-01-31 Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x1
seclvl: Error during initialization: rc = [-22]
Initializing Cryptographic API
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
loop: loaded (max 8 devices)
elevator: using anticipatory as default io scheduler
nbd: registered device at major 43
Kernel panic - not syncing: read of switch_pipe failed, errno = 9
 
EIP: 0073:[<a02986f2>] CPU: 0 Not tainted ESP: 007b:a0dfb6b4 EFLAGS: 00000286
    Not tainted
EAX: 00000000 EBX: 00000001 ECX: a0dfb754 EDX: a0dfb6d4
ESI: 00000008 EDI: 0000000a EBP: a0dfb6bc DS: 007b ES: 007b
Call Trace: 
 [<a004108d>] notifier_call_chain+0x2d/0x50
 [<a016d226>] bust_spinlocks+0x46/0x50
 [<a0032ad1>] panic+0x71/0x120
 [<a0017090>] copy_from_user_proc+0x0/0x10
 [<a001c6c3>] switch_to_tt+0x1e3/0x220
 [<a02dceab>] schedule+0x2ab/0x480
 [<a003551d>] do_exit+0x1ad/0x3a0
 [<a0012693>] um_execve+0x23/0x60
 [<a0043cc6>] ____call_usermodehelper+0x76/0xb0
 [<a0043c50>] ____call_usermodehelper+0x0/0xb0
 [<a0016968>] run_kernel_thread+0x78/0x80
 [<a02987c4>] sigemptyset+0x24/0x40
 [<a0043c50>] ____call_usermodehelper+0x0/0xb0
 [<a0016930>] run_kernel_thread+0x40/0x80
 [<a0043c50>] ____call_usermodehelper+0x0/0xb0
 [<a001c8a8>] new_thread_handler+0xe8/0x110
 [<a0043c50>] ____call_usermodehelper+0x0/0xb0
 [<a0298698>] __restore+0x0/0x8
 [<a02986f2>] __sigprocmask+0x22/0x50

 tracing thread pid = 843
sleeping process 2222 got unexpected signal : 11

actually_do_remove : couldn't open directory '/home/ahu/.uml/oJLt21', errno = 2
actually_do_remove : couldn't open directory '/home/ahu/.uml/oJLt21', errno = 2


-- 
http://www.PowerDNS.com      Open source, database driven DNS Software 
http://lartc.org           Linux Advanced Routing & Traffic Control HOWTO


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
