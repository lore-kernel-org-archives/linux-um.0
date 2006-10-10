Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GXQr1-0002IS-G7 for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 10 Oct 2006 16:17:43 -0700
Received: from ns.theshore.net ([67.18.92.50] helo=www.theshore.net)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1GXQr0-00016I-1O
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 10 Oct 2006 16:17:43 -0700
Received: from [68.52.239.10] (c-68-52-239-10.hsd1.tn.comcast.net
	[68.52.239.10])
	by www.theshore.net (8.13.6/8.9.1) with ESMTP id k9ANHell003333
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Tue, 10 Oct 2006 19:17:40 -0400
Message-ID: <452C29F2.8050908@theshore.net>
Date: Tue, 10 Oct 2006 18:17:06 -0500
From: "Christopher S. Aker" <caker@theshore.net>
MIME-Version: 1.0
Subject: [uml-devel] Kernel mode fault at addr 0x92c00000, ip 0x80bcead
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: user-mode-linux-devel@lists.sourceforge.net

This is 2.6.18-um, on top of a 2.6.16.29-skas3-v8.2 host.

Kernel file is here:
http://www.theshore.net/~caker/uml/kernels/2.6.18-linode25


Kernel panic - not syncing: Kernel mode fault at addr 0x92c00000, ip 
0x80bcead

EIP: 0073:[<080bcead>] CPU: 0 Not tainted ESP: 007b:bf55b798 EFLAGS: 
00200246
     Not tainted
EAX: ffffffda EBX: 00000003 ECX: 40118003 EDX: 000fa718
ESI: 40118003 EDI: 4021271b EBP: bf55b7d8 DS: 007b ES: 007b
85a0f2f8:  [<800519a0>] notifier_call_chain+0x2a/0x40
85a0f314:  [<8003ef57>] panic+0x70/0x102
85a0f32c:  [<8001eb96>] segv+0x29d/0x2cb
85a0f35c:  [<80058df6>] autoremove_wake_function+0x2f/0x57
85a0f368:  [<8007f636>] kmem_cache_free+0x54/0xdc
85a0f384:  [<8004c62d>] __mod_timer+0x75/0xb3
85a0f3f8:  [<8001e8ba>] segv_handler+0xa5/0xe4
85a0f41c:  [<8001e815>] segv_handler+0x0/0xe4
85a0f420:  [<80034abc>] sig_handler_common_skas+0x94/0xe5
85a0f444:  [<80030bdd>] sig_handler+0x5d/0x68
85a0f45c:  [<8039a828>] __restore+0x0/0x8
85a0f49c:  [<800350cf>] csum_partial+0xdb/0xe8
85a0f4bc:  [<80062d52>] handle_IRQ_event+0x45/0x69
85a0f4d8:  [<802585d3>] rb_erase+0x5b/0x102
85a0f4e8:  [<8007f636>] kmem_cache_free+0x54/0xdc
85a0f4f0:  [<8004c593>] lock_timer_base+0x2a/0x4f
85a0f504:  [<8004c62d>] __mod_timer+0x75/0xb3
85a0f510:  [<8024f14c>] as_can_break_anticipation+0xef/0x182
85a0f524:  [<8024eb7c>] as_antic_waitnext+0x29/0x68
85a0f530:  [<8024f206>] as_can_anticipate+0x27/0x37
85a0f53c:  [<8024fab4>] as_dispatch_request+0x2f4/0x378
85a0f548:  [<80261c6c>] __add_entropy_words+0x74/0x174
85a0f564:  [<8024594b>] elv_next_request+0x45/0x156
85a0f570:  [<80068274>] mempool_free+0x83/0x93
85a0f584:  [<8002a9de>] do_ubd_request+0x2b/0xbd
85a0f5a0:  [<8001a1ce>] find_irq_by_fd+0x53/0x83
85a0f5a8:  [<80030b12>] maybe_sigio_broken+0x1a/0x58
85a0f5c4:  [<8003a6bc>] __activate_task+0x27/0x3f
85a0f5e8:  [<8003a6bc>] __activate_task+0x27/0x3f
85a0f600:  [<8003a7f7>] activate_task+0x6e/0x7b
85a0f614:  [<800466cc>] local_bh_enable+0x8/0xa9
85a0f624:  [<8003a8d6>] try_to_wake_up+0x90/0xa5
85a0f638:  [<80327340>] ipt_do_table+0x248/0x323
85a0f640:  [<800466cc>] local_bh_enable+0x8/0xa9
85a0f648:  [<80058df6>] autoremove_wake_function+0x2f/0x57
85a0f670:  [<803291a5>] ip_nat_fn+0x7b/0x1e7
85a0f684:  [<802e1607>] ip_local_deliver_finish+0x0/0x1ef
85a0f688:  [<80328b03>] ipt_hook+0x37/0x3b
85a0f6a4:  [<802d8569>] nf_iterate+0x63/0x7b
85a0f6b8:  [<802fe15e>] tcp_v4_rcv+0x4ce/0x8c5
85a0f6c8:  [<802e1607>] ip_local_deliver_finish+0x0/0x1ef
85a0f718:  [<80030fc0>] set_signals+0x1c/0x28
85a0f720:  [<800466cc>] local_bh_enable+0x8/0xa9
85a0f724:  [<8004c62d>] __mod_timer+0x75/0xb3
85a0f738:  [<80030fc0>] set_signals+0x1c/0x28
85a0f74c:  [<802aafe2>] skb_checksum+0xe7/0x28f
85a0f75c:  [<802aa2ce>] pskb_expand_head+0xdc/0x15f
85a0f788:  [<802afd31>] skb_checksum_help+0x9c/0x13e
85a0f7ac:  [<803292fc>] ip_nat_fn+0x1d2/0x1e7
85a0f7dc:  [<802e6c72>] dst_output+0x0/0x14
85a0f7e0:  [<80329528>] ip_nat_local_fn+0x75/0xf3
85a0f7f4:  [<802e6c72>] dst_output+0x0/0x14
85a0f804:  [<802e6c72>] dst_output+0x0/0x14
85a0f808:  [<802d8569>] nf_iterate+0x63/0x7b
85a0f81c:  [<802e6c72>] dst_output+0x0/0x14
85a0f82c:  [<802e6c72>] dst_output+0x0/0x14
85a0f830:  [<802d85ec>] nf_hook_slow+0x6b/0xe4
85a0f84c:  [<802e6c72>] dst_output+0x0/0x14
85a0f86c:  [<802e4a44>] ip_queue_xmit+0x3d7/0x4c2
85a0f884:  [<802e6c72>] dst_output+0x0/0x14
85a0f88c:  [<800327ac>] setjmp_wrapper+0x5c/0x60
85a0f8b0:  [<80032778>] setjmp_wrapper+0x28/0x60
85a0f8ec:  [<8007f413>] kmem_cache_alloc+0x3b/0x5d
85a0f914:  [<8006942b>] buffered_rmqueue+0xa2/0x11a
85a0f944:  [<802f7668>] tcp_transmit_skb+0x2b8/0x4b1
85a0f964:  [<802f83f5>] tcp_snd_test+0x33/0xf4
85a0f984:  [<802f91fd>] tcp_push_one+0xde/0x159
85a0f9ac:  [<802eca55>] tcp_sendmsg+0x438/0xe54
85a0fa0c:  [<80032778>] setjmp_wrapper+0x28/0x60
85a0fa30:  [<8030a718>] inet_sendmsg+0x4a/0x56
85a0fa48:  [<802a4aad>] do_sock_write+0xbb/0xc5
85a0fa6c:  [<802a4c5f>] sock_aio_write+0x95/0x99
85a0fae0:  [<80082978>] do_sync_write+0xde/0x124
85a0fb00:  [<800347c6>] switch_threads+0x61/0x6e
85a0fb3c:  [<80058dc7>] autoremove_wake_function+0x0/0x57
85a0fb5c:  [<8002311f>] buffer_op+0x47/0x77
85a0fb60:  [<80022f86>] do_buffer_op+0x0/0x152
85a0fb90:  [<80082b81>] vfs_write+0x1c3/0x23d
85a0fbc8:  [<80082ccc>] sys_write+0x51/0x80
85a0fbf0:  [<80022bda>] handle_syscall+0x11a/0x138
85a0fc58:  [<80032eed>] move_registers+0x4c/0x66
85a0fc6c:  [<80033b68>] handle_trap+0x31/0x12d
85a0fc74:  [<80032f47>] save_registers+0x40/0x6c
85a0fc94:  [<80034192>] userspace+0x1c7/0x21e
85a0fcf0:  [<80022808>] fork_handler+0xef/0xff
85a0fd1c:  [<8039a828>] __restore+0x0/0x8
85a0fd5c:  [<8039aa81>] kill+0x11/0x20

Is this a UML issue?

-Chris


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
