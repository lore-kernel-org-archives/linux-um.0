Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FPRnD-0002jN-63 for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 31 Mar 2006 14:08:31 -0800
Received: from ns.theshore.net ([67.18.92.50] helo=www.theshore.net)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1FPRnB-0002G2-GG
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 31 Mar 2006 14:08:31 -0800
Received: from [192.168.1.3] (mothership.theshore.net [69.137.72.192])
	by www.theshore.net (8.13.6/8.9.1) with ESMTP id k2VM8RAL024819
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Fri, 31 Mar 2006 17:08:28 -0500
Message-ID: <442DA85B.1060804@theshore.net>
From: "Christopher S. Aker" <caker@theshore.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [uml-devel] Kernel panic - not syncing: Kernel mode signal 7
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
Date: Fri, 31 Mar 2006 16:08:27 -0600
To: user-mode-linux-devel@lists.sourceforge.net

I'm posting this for posterity.  I've asked the user to upgrade to 
2.6.16.1-bs1 for now.  He's hit this twice in the last month...

http://www.theshore.net/~caker/uml/kernels/2.6.15-linode16

Kernel panic - not syncing: Kernel mode signal 7

EIP: 0073:[<8038d4f1>] CPU: 0 Not tainted ESP: 007b:b7ffefb8 EFLAGS: 
00000292
Not tainted
EAX: 00000000 EBX: 000018fc ECX: 00000013 EDX: 000018fc
ESI: 000018f8 EDI: 00000000 EBP: 00000000 DS: 007b ES: 007b
89ae3724: [<800512ed>] notifier_call_chain+0x27/0x3e
89ae3740: [<8003f047>] panic+0x70/0x102
89ae3758: [<8001f343>] relay_signal+0x4b/0xcb
89ae3778: [<8001f41c>] bus_handler+0x59/0x5b
89ae3784: [<8001ccdb>] unblock_signals+0xf/0x13
89ae378c: [<8002587d>] sig_handler_common_skas+0x89/0xdf
89ae37ac: [<80032385>] sig_handler+0x35/0x37
89ae37b8: [<8038d298>] __restore+0x0/0x8
89ae37f8: [<8010963d>] journal_get_descriptor_buffer+0x6b/0xaa
89ae3818: [<8001cd7c>] get_signals+0x35/0x51
89ae3874: [<8038d19d>] __libc_longjmp+0x3d/0x50
89ae3878: [<8038d18d>] __libc_longjmp+0x2d/0x50
89ae3890: [<80024bc1>] start_idle_thread+0x0/0x110
89ae38ac: [<800808f9>] __find_get_block+0x44/0xc1
89ae38b4: [<80024b86>] switch_threads+0x4a/0x85
89ae38cc: [<800809a1>] __getblk+0x2b/0x51
89ae38e8: [<80080a3d>] __bread+0x1f/0x3d
89ae38f8: [<800f21ff>] ext3_get_branch+0x63/0xe4
89ae3918: [<800f29f1>] ext3_get_block_handle+0x24a/0x3cb
89ae396c: [<8001cd2f>] enable_mask+0x50/0x68
89ae3980: [<8001cd7c>] get_signals+0x35/0x51
89ae3a0c: [<8001ccdb>] unblock_signals+0xf/0x13
89ae3a14: [<80080868>] bh_lru_install+0x7f/0xcc
89ae3a54: [<800808f9>] __find_get_block+0x44/0xc1
89ae3a74: [<800809a1>] __getblk+0x2b/0x51
89ae3ab4: [<80105d37>] journal_write_commit_record+0x40/0x104
89ae3af4: [<801062a3>] journal_commit_transaction+0x4a8/0xed5
89ae3b7c: [<80059340>] finish_wait+0x53/0x6a
89ae3b94: [<80108cc0>] kjournald+0xc7/0x1fb
89ae3bb4: [<8038d5e7>] sigemptyset+0x17/0x30
89ae3bc0: [<80059357>] autoremove_wake_function+0x0/0x57
89ae3be0: [<80059357>] autoremove_wake_function+0x0/0x57
89ae3c04: [<80108bf0>] commit_timeout+0x0/0x9
89ae3c1c: [<80108bf9>] kjournald+0x0/0x1fb
89ae3c28: [<80032337>] run_kernel_thread+0x77/0x7b
89ae3c38: [<80108bf9>] kjournald+0x0/0x1fb
89ae3c48: [<800322ff>] run_kernel_thread+0x3f/0x7b
89ae3ca4: [<8001ccdb>] unblock_signals+0xf/0x13
89ae3cac: [<8003b6eb>] schedule_tail+0x2a/0x18a
89ae3cd8: [<80108bf9>] kjournald+0x0/0x1fb
89ae3ce4: [<80024fc7>] new_thread_handler+0xcf/0x124
89ae3ce8: [<80108bf9>] kjournald+0x0/0x1fb
89ae3d20: [<8038d298>] __restore+0x0/0x8
89ae3d60: [<8038d4f1>] kill+0x11/0x20

-Chris


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
