Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <toralf.foerster@gmx.de>) id 1XGvAh-0007jh-Gf
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 11 Aug 2014 19:22:19 +0000
Received: from mout.gmx.net ([212.227.17.20])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1XGvAg-0002p8-77
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 11 Aug 2014 19:22:19 +0000
Received: from [192.168.178.21] ([80.171.177.84]) by mail.gmx.com (mrgmx103)
	with ESMTPSA (Nemesis) id 0M2L60-1WRQRj2RIC-00s8cq for
	<user-mode-linux-devel@lists.sourceforge.net>; Mon, 11 Aug 2014 21:22:11
	+0200
Message-ID: <53E917E2.7060704@gmx.de>
Date: Mon, 11 Aug 2014 21:22:10 +0200
From: =?UTF-8?B?VG9yYWxmIEbDtnJzdGVy?= <toralf.foerster@gmx.de>
MIME-Version: 1.0
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
Subject: [uml-devel] spinlock recursion w/ 3.16.0-10473-gc8d6637
To: UML devel <user-mode-linux-devel@lists.sourceforge.net>

/me wonders who could/should be informed about this BUG message from a 32 bit UML guest (the "dirty" comes from reverted commit 8c86e70a)


BUG: spinlock recursion on CPU#0, rngd/1231
 lock: 0x86f1588, .magic: dead4ead, .owner: rngd/1231, .owner_cpu: 0
CPU: 0 PID: 1231 Comm: rngd Not tainted 3.16.0-10473-gc8d6637-dirty #3
Stack:
 085bfb48 085bfb48 00000003 086f0547 85f6e1c0 086f1588 00000008 85f9f990
 08500fcf 00000000 85f9f964 85f9f9bc 084fd789 085cc734 086f1588 dead4ead
 85f6e408 000004cf 00000000 8437ab40 086f1588 085ca958 85f9f9cc 084fd7ab
Call Trace:
 [<084fd7ab>] ? spin_bug+0x1b/0x1f
 [<08500fcf>] dump_stack+0x26/0x28
 [<084fd789>] spin_dump+0xa1/0xa8
 [<084fd7ab>] spin_bug+0x1b/0x1f
 [<080a0db3>] do_raw_spin_lock+0x43/0x100
 [<0809739c>] ? finish_task_switch.constprop.53+0x3c/0x90
 [<08505421>] _raw_spin_lock+0x11/0x20
 [<08060622>] sigio_lock+0x12/0x20
 [<08071261>] add_sigio_fd+0x11/0x100
 [<0805ec9a>] reactivate_fd+0x6a/0x80
 [<08060597>] sigio_interrupt+0x37/0x40
 [<080a59bf>] handle_irq_event_percpu+0x2f/0x130
 [<080a9c94>] ? rcu_bh_qs+0x44/0x50
 [<080a5af4>] handle_irq_event+0x34/0x50
 [<080a8100>] handle_edge_irq+0xf0/0x120
 [<080a53cb>] generic_handle_irq+0x2b/0x30
 [<0805eda5>] do_IRQ+0x25/0x40
 [<0805ee25>] sigio_handler+0x65/0x90
 [<08071ade>] sig_handler_common+0xae/0xd0
 [<08071c2e>] ? set_signals+0x1e/0x40
 [<080d6d87>] ? get_page_from_freelist+0x327/0x5b0
 [<080d77d7>] ? __alloc_pages_nodemask+0xe7/0x7e0
 [<08062a23>] ? copy_chunk_from_user+0x23/0x30
 [<085054c1>] ? _raw_spin_unlock+0x11/0x20
 [<08106514>] ? deactivate_slab+0x424/0x470
 [<084fec79>] ? alloc_debug_processing+0xce/0x152
 [<0805f388>] ? uml_kmalloc+0x18/0x20
 [<08062a23>] ? copy_chunk_from_user+0x23/0x30
 [<08071c2e>] ? set_signals+0x1e/0x40
 [<084fef8f>] ? __slab_alloc.constprop.65+0x292/0x2be
 [<085054ec>] ? _raw_spin_unlock_irqrestore+0x1c/0x20
 [<0805f388>] ? uml_kmalloc+0x18/0x20
 [<080980f4>] ? default_wake_function+0x14/0x20
 [<0811f67e>] ? pollwake+0x6e/0x70
 [<08062a53>] ? copy_chunk_to_user+0x23/0x30
 [<0810690b>] ? __kmalloc+0x7b/0x140
 [<08071a0b>] unblock_signals+0x4b/0x70
 [<08071c2e>] set_signals+0x1e/0x40
 [<08070ef4>] update_thread+0x134/0x140
 [<0807132d>] add_sigio_fd+0xdd/0x100
 [<0805ec9a>] reactivate_fd+0x6a/0x80
 [<0806e3e9>] rng_dev_read+0x149/0x260
 [<080980e0>] ? default_wake_function+0x0/0x20
 [<0810d713>] vfs_read+0x93/0x190
 [<0810dd01>] SyS_read+0x51/0xa0
 [<080629e0>] handle_syscall+0x60/0x80
 [<0804d120>] ? pidmap_init+0x8b/0xaf
 [<084bf67c>] ? ptrace+0x2c/0x70
 [<080794a2>] ? get_fp_registers+0x22/0x40
 [<080745ac>] userspace+0x46c/0x5e0
 [<080799f6>] ? os_set_thread_area+0x26/0x40
 [<08078a0c>] ? do_set_thread_area+0x1c/0x50
 [<08078b88>] ? arch_switch_tls+0xb8/0x100
 [<0805f720>] fork_handler+0x60/0x70


-- 
Toralf


------------------------------------------------------------------------------
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

