Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CoFo8-00050J-1X for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 10 Jan 2005 22:47:12 -0800
Received: from ns.theshore.net ([67.18.92.50] helo=www.theshore.net)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1CoFo7-0001we-JW for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 10 Jan 2005 22:47:11 -0800
Received: from hawk (mothership.theshore.net [69.137.84.52])
	by www.theshore.net (8.12.9/8.9.1) with SMTP id j0B6l9ie020545
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Tue, 11 Jan 2005 01:47:10 -0500
Message-ID: <063e01c4f7a9$aabaf790$0201a8c0@hawk>
From: "Christopher S. Aker" <caker@theshore.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Subject: [uml-devel] kernel BUG at net/ipv4/tcp_output.c:277!
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
Date: Tue, 11 Jan 2005 00:49:13 -0600
To: uml-devel <user-mode-linux-devel@lists.sourceforge.net>

I've had reports of this crash from a user who says he experiences this crash several
times a day.  I'm not sure if this is related to another crash which produces no
console output that I've been chasing for a few weeks, or if this is even related to
UML or a bug in x86.

Host: 2.6.10 w/ SKAS-v7
UML: 2.6.9-bb4

-----
kernel BUG at net/ipv4/tcp_output.c:277!
Kernel panic - not syncing: BUG!

EIP: 0073:[<40058f08>] CPU: 0 Not tainted ESP: 007b:be9ff5cc EFLAGS: 00000246
Not tainted
EAX: ffffffda EBX: 00000003 ECX: be9ff5d4 EDX: 0865bd7c
ESI: ffffffe0 EDI: 00000000 EBP: be9ff5ec DS: 007b ES: 007b
Call Trace:
[<80034549>] vprintk+0xe9/0x13c
[<800421ee>] notifier_call_chain+0x1e/0x38
[<80033a9e>] panic+0x56/0xbc
[<802792ef>] tcp_transmit_skb+0x8a7/0x8a8
[<80053afb>] kmem_cache_alloc+0x13/0x50
[<8023a57b>] skb_clone+0x9b/0x19c
[<8027af05>] tcp_send_synack+0x12d/0x134
[<8030f1d7>] sigemptyset+0x17/0x30
[<80277de2>] tcp_rcv_synsent_state_process+0x526/0x570
[<8027874c>] tcp_rcv_state_process+0x920/0xa28
[<8027f6e8>] tcp_v4_do_rcv+0x74/0xf0
[<802398a3>] __release_sock+0x37/0x50
[<80031fd4>] prepare_to_wait+0x4c/0x54
[<80239e65>] release_sock+0x5d/0x64
[<8028cc17>] inet_wait_for_connect+0x7f/0xd8
[<80032088>] autoremove_wake_function+0x0/0x3c
[<80032088>] autoremove_wake_function+0x0/0x3c
[<80023056>] copy_from_user_skas+0x56/0x80
[<8028cd1e>] inet_stream_connect+0xae/0x180
[<80237a8d>] sys_connect+0x71/0x90
[<80022fae>] buffer_op+0x2a/0x50
[<80022e64>] do_buffer_op+0x0/0x120
[<80022fd4>] copy_chunk_from_user+0x0/0x2c
[<80023056>] copy_from_user_skas+0x56/0x80
[<80022fd4>] copy_chunk_from_user+0x0/0x2c
[<80238471>] sys_socketcall+0x95/0x1b8
[<8005b9d4>] sys_munmap+0x34/0x3c
[<800228a6>] execute_syscall_skas+0xaa/0xec
[<80022918>] handle_syscall+0x30/0x58
[<80021afc>] handle_trap+0x34/0x110
[<80021f33>] userspace+0x1c7/0x1e4
[<8030eef8>] __restore+0x0/0x8
[<8030f151>] kill+0x11/0x20
-----

Thanks,
-Chris



-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
