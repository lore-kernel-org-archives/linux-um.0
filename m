Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from [10.3.1.93] (helo=sc8-sf-list1-new.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FdjkS-00058w-Kx for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 10 May 2006 01:08:44 -0700
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1FdjkS-0000I0-Ki for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 10 May 2006 01:08:44 -0700
Received: from ns.theshore.net ([67.18.92.50] helo=www.theshore.net)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1FdjkS-0005xP-8l
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 10 May 2006 01:08:44 -0700
Received: from [192.168.1.3] (mothership.theshore.net [69.137.72.192])
	by www.theshore.net (8.13.6/8.9.1) with ESMTP id k4A88enu028690
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Wed, 10 May 2006 04:08:40 -0400
Message-ID: <44619F72.7060009@theshore.net>
From: "Christopher S. Aker" <caker@theshore.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [uml-devel] Kernel mode fault at addr 0x87800000, ip 0x400007b0
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
Date: Wed, 10 May 2006 03:08:18 -0500
To: user-mode-linux-devel@lists.sourceforge.net

2.6.16 + bb1

Kernel panic - not syncing: Kernel mode fault at addr 0x87800000, ip 
0x400007b0

EIP: 0073:[<400007b0>] CPU: 0 Not tainted ESP: 007b:bfe19380 EFLAGS: 
00000212
     Not tainted
EAX: 00000000 EBX: 00000000 ECX: 00000000 EDX: 00000000
ESI: 00000000 EDI: 00000000 EBP: 00000000 DS: 007b ES: 007b
87163704:  [<80053225>] notifier_call_chain+0x27/0x3e
87163720:  [<80040ebb>] panic+0x70/0x102
87163738:  [<8001ea71>] segv+0x292/0x2c0
87163794:  [<80022cd6>] fix_range+0x46/0x4a
87163804:  [<8001e7a0>] segv_handler+0xa5/0xe4
87163828:  [<8001e6fb>] segv_handler+0x0/0xe4
8716382c:  [<80033ef6>] sig_handler_common_skas+0x92/0xe1
8716384c:  [<8002fd7e>] sig_handler+0x62/0x6d
87163860:  [<8038fbf8>] __restore+0x0/0x8
871638a0:  [<80254a39>] vsnprintf+0x343/0x4de
871638c4:  [<800319f1>] setjmp_wrapper+0x36/0x85
87163900:  [<8006ce70>] vma_prio_tree_insert+0x29/0x54
87163914:  [<80071896>] vma_link+0x8d/0xb4
87163934:  [<80072478>] __do_mmap_pgoff+0x41b/0x75e
87163950:  [<80023073>] buffer_op+0x47/0x77
87163954:  [<80022eda>] do_buffer_op+0x0/0x152
87163964:  [<800231f2>] copy_chunk_to_user+0x0/0x37
87163980:  [<800232ed>] copy_to_user_skas+0xc4/0x104
87163990:  [<800231f2>] copy_chunk_to_user+0x0/0x37
871639b0:  [<800ad8c5>] create_elf_tables+0x612/0x729
871639c0:  [<8005ddec>] mutex_debug_check_no_locks_freed+0x9d/0x158
87163a04:  [<8007d6c2>] kfree+0x4d/0x9f
87163a18:  [<800301f2>] set_signals+0x1a/0x25
87163a20:  [<800ae0a0>] load_elf_binary+0xb8/0x1040
87163a4c:  [<800319f1>] setjmp_wrapper+0x36/0x85
87163aac:  [<800676c9>] buffered_rmqueue+0xf0/0x201
87163ae8:  [<80023073>] buffer_op+0x47/0x77
87163aec:  [<80022eda>] do_buffer_op+0x0/0x152
87163afc:  [<800230a3>] copy_chunk_from_user+0x0/0x37
87163b2c:  [<8005ddec>] mutex_debug_check_no_locks_freed+0x9d/0x158
87163b48:  [<8008abbb>] copy_strings+0x2c9/0x369
87163b5c:  [<8008c062>] search_binary_handler+0xe6/0x10b
87163b78:  [<80254c36>] snprintf+0x27/0x2b
87163b8c:  [<8001ef7c>] set_cmdline+0x67/0x106
87163bb4:  [<80018abb>] execve1+0x85/0x87
87163bdc:  [<80018b51>] sys_execve+0x3a/0x5d
87163bf4:  [<80022b32>] handle_syscall+0x11a/0x138
87163c70:  [<80032ee3>] handle_trap+0x35/0x12b
87163c7c:  [<8003221d>] save_registers+0x40/0x70
87163c98:  [<80033504>] userspace+0x1c1/0x212
87163cf4:  [<80022764>] fork_handler+0xef/0xff
87163d20:  [<8038fbf8>] __restore+0x0/0x8
87163d60:  [<8038fe51>] kill+0x11/0x20

-Chris


-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
