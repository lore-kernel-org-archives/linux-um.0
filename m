Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D4Hdn-0000Yw-M5 for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 24 Feb 2005 03:58:47 -0800
Received: from dgate2.fujitsu-siemens.com ([217.115.66.36])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1D4Hdl-0005YH-2H for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 24 Feb 2005 03:58:46 -0800
Message-ID: <421DC16D.5060705@fujitsu-siemens.com>
From: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [uml-devel] soft lockups on idle UML
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
Date: Thu, 24 Feb 2005 12:58:37 +0100
To: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux devel <user-mode-linux-devel@lists.sourceforge.net>

My UML was idle for 18 hours. When looking to the console,
I found the following messages, UML still is running:


  BUG: soft lockup detected on CPU#0!

EIP: 0000:[<00000000>] CPU: 0 Not tainted EFLAGS: 00000000
     Not tainted
EAX: 00000000 EBX: 00000000 ECX: 00000000 EDX: 00000000
ESI: 00000000 EDI: 00000000 EBP: 00000000 DS: 0000 ES: 0000
Call Trace:
a0267780:  [<a00195f0>] um_timer+0x10/0x50
a02677a0:  [<a005d1b6>] handle_IRQ_event+0x36/0x90
a02677d0:  [<a005d2be>] __do_IRQ+0xae/0x110
a02677f0:  [<a00141ff>] do_IRQ+0x2f/0x40
a0267800:  [<a001953b>] timer_irq+0x11b/0x170
a0267830:  [<a001991a>] timer_handler+0x7a/0x90
a0267840:  [<a00198ad>] timer_handler+0xd/0x90
a0267850:  [<a0021fc2>] sig_handler_common_skas+0x92/0x130
a0267874:  [<a00218f0>] start_kernel_proc+0x0/0x30
a0267880:  [<a002f8bc>] alarm_handler+0x4c/0x70
a02678a0:  [<a01c7e68>] __restore+0x0/0x8
a02678bc:  [<a00218f0>] start_kernel_proc+0x0/0x30
a02678e0:  [<a01de7ba>] __libc_nanosleep+0x1a/0x60
a0267920:  [<a0019590>] boot_timer_handler+0x0/0x50
a0267928:  [<a01c7e68>] __restore+0x0/0x8
a026796c:  [<a01c80b4>] sigemptyset+0x24/0x40
a0267980:  [<a002f6c3>] change_signals+0x43/0x80
a026798c:  [<a01c80b4>] sigemptyset+0x24/0x40
a02679a0:  [<a002f6c3>] change_signals+0x43/0x80
a02679b8:  [<a01c7e68>] __restore+0x0/0x8
a02679ec:  [<a01c80b4>] sigemptyset+0x24/0x40
a0267a00:  [<a002f4db>] set_signals+0x7b/0x170
a0267a14:  [<a01c7d2b>] __libc_longjmp+0x3b/0x60
a0267a30:  [<a0020667>] switch_threads+0x47/0x50
a0267a6c:  [<a01c80b4>] sigemptyset+0x24/0x40
a0267a80:  [<a002f6c3>] change_signals+0x43/0x80
a0267b20:  [<a0035a44>] finish_task_switch+0x24/0xa0
a0267b40:  [<a020d920>] schedule+0x2e0/0x500
a0267b80:  [<a0018e5e>] idle_sleep+0x1e/0x20
a0267b90:  [<a001936a>] uml_idle_timer+0x3a/0x80
a0267ba0:  [<a001648f>] default_idle+0x4f/0x70
a0267bb0:  [<a00164a1>] default_idle+0x61/0x70
a0267bd0:  [<a00218e4>] init_idle_skas+0x24/0x30
a0267be0:  [<a00025bb>] start_kernel+0x17b/0x1c0
a0267bf0:  [<a002191b>] start_kernel_proc+0x2b/0x30
a0267c00:  [<a002eeca>] run_kernel_thread+0x3a/0x50
a0267c18:  [<a00218f0>] start_kernel_proc+0x0/0x30
a0267c28:  [<a002eeaf>] run_kernel_thread+0x1f/0x50
a0267cc4:  [<a00218f0>] start_kernel_proc+0x0/0x30
a0267cd0:  [<a00215a1>] new_thread_handler+0xb1/0x110
a0267cd4:  [<a00218f0>] start_kernel_proc+0x0/0x30
a0267ce0:  [<a0020698>] thread_wait+0x28/0x50
a0267d20:  [<a01c7e68>] __restore+0x0/0x8
a0267d60:  [<a01c8021>] __kill+0x11/0x20

BUG: soft lockup detected on CPU#0!

EIP: 0000:[<00000000>] CPU: 0 Not tainted EFLAGS: 00000000
     Not tainted
EAX: 00000000 EBX: 00000000 ECX: 00000000 EDX: 00000000
ESI: 00000000 EDI: 00000000 EBP: 00000000 DS: 0000 ES: 0000
Call Trace:
a0267780:  [<a00195f0>] um_timer+0x10/0x50
a02677a0:  [<a005d1b6>] handle_IRQ_event+0x36/0x90
a02677d0:  [<a005d2be>] __do_IRQ+0xae/0x110
a02677f0:  [<a00141ff>] do_IRQ+0x2f/0x40
a0267800:  [<a001953b>] timer_irq+0x11b/0x170
a0267830:  [<a001991a>] timer_handler+0x7a/0x90
a0267840:  [<a00198ad>] timer_handler+0xd/0x90
a0267850:  [<a0021fc2>] sig_handler_common_skas+0x92/0x130
a0267874:  [<a00218f0>] start_kernel_proc+0x0/0x30
a0267880:  [<a002f8bc>] alarm_handler+0x4c/0x70
a02678a0:  [<a01c7e68>] __restore+0x0/0x8
a02678bc:  [<a00218f0>] start_kernel_proc+0x0/0x30
a02678e0:  [<a01de7ba>] __libc_nanosleep+0x1a/0x60
a0267920:  [<a0019590>] boot_timer_handler+0x0/0x50
a0267928:  [<a01c7e68>] __restore+0x0/0x8
a026796c:  [<a01c80b4>] sigemptyset+0x24/0x40
a0267980:  [<a002f6c3>] change_signals+0x43/0x80
a026798c:  [<a01c80b4>] sigemptyset+0x24/0x40
a02679a0:  [<a002f6c3>] change_signals+0x43/0x80
a02679ac:  [<a01c80b4>] sigemptyset+0x24/0x40
a02679bc:  [<a01c80b4>] sigemptyset+0x24/0x40
a02679d0:  [<a002f5a2>] set_signals+0x142/0x170
a02679ec:  [<a01c80b4>] sigemptyset+0x24/0x40
a0267a00:  [<a002f4db>] set_signals+0x7b/0x170
a0267a14:  [<a01c7d2b>] __libc_longjmp+0x3b/0x60
a0267a30:  [<a0020667>] switch_threads+0x47/0x50
a0267a6c:  [<a01c80b4>] sigemptyset+0x24/0x40
a0267a80:  [<a002f6c3>] change_signals+0x43/0x80
a0267b20:  [<a0035a44>] finish_task_switch+0x24/0xa0
a0267b40:  [<a020d920>] schedule+0x2e0/0x500
a0267b80:  [<a0018e5e>] idle_sleep+0x1e/0x20
a0267b90:  [<a001936a>] uml_idle_timer+0x3a/0x80
a0267ba0:  [<a001648f>] default_idle+0x4f/0x70
a0267bb0:  [<a00164a1>] default_idle+0x61/0x70
a0267bd0:  [<a00218e4>] init_idle_skas+0x24/0x30
a0267be0:  [<a00025bb>] start_kernel+0x17b/0x1c0
a0267bf0:  [<a002191b>] start_kernel_proc+0x2b/0x30
a0267c00:  [<a002eeca>] run_kernel_thread+0x3a/0x50
a0267c18:  [<a00218f0>] start_kernel_proc+0x0/0x30
a0267c28:  [<a002eeaf>] run_kernel_thread+0x1f/0x50
a0267cc4:  [<a00218f0>] start_kernel_proc+0x0/0x30
a0267cd0:  [<a00215a1>] new_thread_handler+0xb1/0x110
a0267cd4:  [<a00218f0>] start_kernel_proc+0x0/0x30
a0267ce0:  [<a0020698>] thread_wait+0x28/0x50
a0267d20:  [<a01c7e68>] __restore+0x0/0x8
a0267d60:  [<a01c8021>] __kill+0x11/0x20


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
