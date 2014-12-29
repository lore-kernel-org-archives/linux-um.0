Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <toralf.foerster@gmx.de>) id 1Y5axD-00030F-1W
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 29 Dec 2014 14:05:51 +0000
Received: from mout.gmx.net ([212.227.15.19])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Y5aww-00081h-V1
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 29 Dec 2014 14:05:50 +0000
Message-ID: <54A15CA4.60907@gmx.de>
Date: Mon, 29 Dec 2014 14:52:36 +0100
From: =?UTF-8?B?VG9yYWxmIEbDtnJzdGVy?= <toralf.foerster@gmx.de>
MIME-Version: 1.0
References: <54A11D8E.2010605@gmx.de>
	<5238511D-1948-4596-ADFE-478EC46A7868@m3y3r.de>
In-Reply-To: <5238511D-1948-4596-ADFE-478EC46A7868@m3y3r.de>
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
Subject: Re: [uml-devel] does a x86 (== 32 bit) uml image works at a 64 bit
 system Gentoo hardened Linux ?
To: Thomas Meyer <thomas@m3y3r.de>
Cc: UML devel <user-mode-linux-devel@lists.sourceforge.net>

On 12/29/2014 10:55 AM, Thomas Meyer wrote:
> Probably you need this patch for 3.19
> 
> https://lkml.org/lkml/2014/12/10/222

right, helped a little bit, now v3.19-rc1-58-g29169f8 gives:

...
EXT4-fs (ubda): mounted filesystem with ordered data mode. Opts: (null)
VFS: Mounted root (ext4 filesystem) readonly on device 98:0.
devtmpfs: mounted
NMI watchdog: BUG: soft lockup - CPU#0 stuck for 22s! [swapper:1]

EIP: 0023:[<df5e5c9e>] CPU: 0 Not tainted ESP: 002b:864afea8 EFLAGS: 00000246
    Not tainted
EAX: 00000007 EBX: 000072db ECX: 864afee4 EDX: 40000002
ESI: 0a201a28 EDI: 000072db EBP: 864afef4 DS: 002b ES: 002b

EIP: 0023:[<08064260>] CPU: 0 Tainted: G             L ESP: 002b:864af5b0 EFLAGS: 00010202
    Tainted: G             L
EAX: 864a8000 EBX: 00000023 ECX: 00000001 EDX: 0871f844
ESI: 0a201a28 EDI: 864a8000 EBP: 864af5d0 DS: 002b ES: 002b
Kernel panic - not syncing: Segfault with no mm
CPU: 0 PID: 1 Comm: swapper Tainted: G             L 3.19.0-rc1-00058-g29169f8-dirty #5
Stack:
 85f6f000 86449280 0b7d04c0 0a201a28 864af5f4 864af604 08072258 86449280
 864af5e8 080642ed 864a0000 085393ac 864af604 85f6ebd8 864af5f4 08064328
 000000c8 864af620 0810aa5b 864af604 85f6ec28 00000000 00000010 85f6ebdc
Call Trace:
 [<08072258>] ? os_free_irq_by_cb+0xe8/0x110
 [<080642ed>] __save_stack_trace+0x1d/0x40
 [<08064328>] save_stack_trace+0x18/0x20
 [<0810aa5b>] set_track+0x5b/0xe0
 [<08525463>] free_debug_processing+0x15a/0x2a5
 [<08072258>] ? os_free_irq_by_cb+0xe8/0x110
 [<085255e2>] __slab_free+0x34/0x2b0
 [<08072258>] ? os_free_irq_by_cb+0xe8/0x110
 [<080642ed>] ? __save_stack_trace+0x1d/0x40
 [<08064328>] ? save_stack_trace+0x18/0x20
 [<0810aa5b>] ? set_track+0x5b/0xe0
 [<0810a9a7>] ? init_object+0x67/0x70
 [<0810d5c1>] kfree+0x111/0x150
 [<08072258>] ? os_free_irq_by_cb+0xe8/0x110
 [<085254f7>] ? free_debug_processing+0x1ee/0x2a5
 [<0806ce07>] ? ubd_intr+0x77/0x110
 [<08072258>] ? os_free_irq_by_cb+0xe8/0x110
 [<08072258>] os_free_irq_by_cb+0xe8/0x110
 [<0805fb60>] ? same_irq_and_dev+0x0/0x30
 [<0805fbf8>] free_irq_by_cb+0x38/0x50
 [<0805fb60>] ? same_irq_and_dev+0x0/0x30
 [<0805ff21>] um_free_irq+0x21/0x40
 [<0806623e>] __free_winch+0x1e/0x60
 [<080662c3>] free_winch+0x43/0x50
 [<080663c5>] winch_cleanup+0x45/0x60
 [<08060cda>] do_uml_exitcalls+0x1a/0x30
 [<08061582>] uml_cleanup+0x12/0x20
 [<08072354>] last_ditch_exit+0x24/0x30
 [<080742f9>] ? set_signals+0x19/0x50
 [<0852b85c>] ? _raw_spin_unlock_irqrestore+0x1c/0x20
 [<08064ea4>] ? free_irqs+0x64/0xe0
 [<0805feed>] ? sigio_handler+0x7d/0x90
 [<0807412c>] ? sig_handler_common+0xbc/0xd0
 [<0852b831>] ? _raw_spin_unlock+0x11/0x20
 [<0810ceb4>] ? 
EIP: 0023:[<080662a8>] CPU: 0 Not tainted ESP: 002b:0871efdc EFLAGS: 00010282
    Not tainted
EAX: 00200200 EBX: 85f932ec ECX: ffffffe8 EDX: 00100100
ESI: 00000000 EDI: f0200000 EBP: 0871efe4 DS: 002b ES: 002b
Kernel panic - not syncing: Segfault with no mm
CPU: 0 PID: 1 Comm: swapper Not tainted 3.19.0-rc1-00058-g29169f8-dirty #5
Stack:
 0852b791 00100100 0871eff4 080663c5 087217ec 087014ac 0871f000 08060cda
 0875a3c0 0871f008 08061582 0871f018 08072354 00000000 871b5000 0871f710
 df5e5c70 0000000f 00000063 00000000 0000002b 0000002b f0200000 00000000
Call Trace:
 [<0852b791>] ? _raw_spin_lock+0x11/0x20
 [<080663c5>] winch_cleanup+0x45/0x60
 [<08060cda>] do_uml_exitcalls+0x1a/0x30
 [<08061582>] uml_cleanup+0x12/0x20
 [<08072354>] last_ditch_exit+0x24/0x30
 [<080d7d08>] ? mempool_free_slab+0x18/0x20
 [<080642ed>] ? __save_stack_trace+0x1d/0x40
 [<08064328>] ? save_stack_trace+0x18/0x20
 [<08060616>] ? deactivate_slab+0x424/0x470map_memory+0x56/0xc0

 [<080742f9>] ?  ? __munmap+0x16/0x40set_signals+0x19/0x50

 [<08072c41>] [<080db1fc>] ? get_page_from_freelist+0x32c/0x5b0os_unmap_memory+0x31/0x50

 [<0852b831>] [<08062042>] ?  ? _raw_spin_unlock+0x11/0x20flush_tlb_kernel_range_common+0xa2/0x180

 [<0810ceb4>] [<08062863>] ?  ? deactivate_slab+0x424/0x470flush_tlb_kernel_vm+0x13/0x20

 [<0852b831>] [<08062e30>] ?  ? _raw_spin_unlock+0x11/0x20segv+0x60/0x310

 [<0810ceb4>] [<08073ffa>] ?  ? deactivate_slab+0x424/0x470unblock_signals+0x1a/0x90
 [<080642ed>] [<080a8fcb>] ?  ? __save_stack_trace+0x1d/0x40handle_irq_event_percpu+0x10b/0x130

 [<0852b831>] [<0852b791>] ?  ? _raw_spin_unlock+0x11/0x20_raw_spin_lock+0x11/0x20

 [<080a902e>] [<0810ceb4>] ?  ? handle_irq_event+0x3e/0x50deactivate_slab+0x424/0x470

 [<080742f9>] [<080642ed>] ?  ? set_signals+0x19/0x50__save_stack_trace+0x1d/0x40

 [<080742f9>] [<0852b831>] ?  ? set_signals+0x19/0x50_raw_spin_unlock+0x11/0x20

 [<0852b85c>] [<0810ceb4>] ?  ? _raw_spin_unlock_irqrestore+0x1c/0x20deactivate_slab+0x424/0x470

 [<08064ea4>] [<080642ed>] ?  ? free_irqs+0x64/0xe0__save_stack_trace+0x1d/0x40

 [<0806314b>] [<0852b831>] ?  ? segv_handler+0x6b/0x80_raw_spin_unlock+0x11/0x20 [<0807669c>]
 ? userspace_tramp+0xc/0x2b0
 [<0807412c>] ? sig_handler_common+0xbc/0xd0
 [<0810ceb4>] [<08076690>] ?  ? deactivate_slab+0x424/0x470userspace_tramp+0x0/0x2b0

 [<080642ed>] [<0807669c>] ?  ? __save_stack_trace+0x1d/0x40userspace_tramp+0xc/0x2b0

 [<0852b831>] [<08074208>] ?  ? _raw_spin_unlock+0x11/0x20sig_handler+0x58/0x90

 [<0812ce49>] [<08073cfe>] ?  ? unlock_new_inode+0x59/0x60hard_handler+0x8e/0xd0

 [<08074318>] [<08076690>] ?  ? set_signals+0x38/0x50userspace_tramp+0x0/0x2b0

 [<084dbe93>] [<08076690>] ?  ? __waitpid_nocancel+0x19/0x76userspace_tramp+0x0/0x2b0

 [<08076d45>] [<0807669c>] ?  ? start_userspace+0x125/0x220userspace_tramp+0xc/0x2b0

 [<080636aa>]
 ? /home/tfoerste/workspace/bin/start_uml.sh: line 108: 28833 Terminated              $LINUX earlyprintk ubda=$ROOTFS ubdb=$SWAP eth0=$NET mem=$MEM $TTY umid=uml_$NAME rootfstype=ext4 "$ARGS"


-- 
Toralf
pgp key: 7B1A 07F4 EC82 0F90 D4C2  8936 872A E508 0076 E94E


------------------------------------------------------------------------------
Dive into the World of Parallel Programming! The Go Parallel Website,
sponsored by Intel and developed in partnership with Slashdot Media, is your
hub for all things parallel software development, from weekly thought
leadership blogs to news, videos, case studies, tutorials and more. Take a
look and join the conversation now. http://goparallel.sourceforge.net
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

