Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from lithops.sigma-star.at ([195.201.40.130])
 by casper.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gK8IP-0004ZF-IQ
 for linux-um@lists.infradead.org; Tue, 06 Nov 2018 20:49:59 +0000
From: Richard Weinberger <richard@nod.at>
Subject: Re: 4.20-rc1 looks broken for UML
Date: Tue, 06 Nov 2018 21:49:45 +0100
Message-ID: <2177266.HJA9EnQ7lp@blindfold>
In-Reply-To: <6298063.A9SzxUBULK@blindfold>
References: <4a096c4f-6552-dbcb-676b-a87306dde07a@kot-begemot.co.uk>
 <e5c51b9c-97d5-ae12-b06f-303f0469d46b@kot-begemot.co.uk>
 <6298063.A9SzxUBULK@blindfold>
MIME-Version: 1.0
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: hch@lst.de
Cc: axboe@kernel.dk, linux-um@lists.infradead.org, Anton Ivanov <anton.ivanov@kot-begemot.co.uk>

Christoph,

Anton found a problem in your "ubd: remove use of blk_rq_map_sg" patch.
With CONFIG_DEBUG_PAGEALLOC enabled, the ubd driver crashes because it tries
to deref address 0x12345678, which is the poison from store_stackinfo().

Please see below for more info.

Am Dienstag, 6. November 2018, 20:56:04 CET schrieb Richard Weinberger:
> Am Dienstag, 6. November 2018, 20:09:44 CET schrieb Anton Ivanov:
> I did a test with your .config and indeed, UML hangs.
> 
> The offending commit is this one:
> commit ecb0a83e3198f2c1142901687afacbc73602a13b
> Author: Christoph Hellwig <hch@lst.de>
> Date:   Thu Oct 18 22:55:03 2018 +0200
> 
>     ubd: remove use of blk_rq_map_sg
>     
>     There is no good reason to create a scatterlist in the ubd driver,
>     it can just iterate the request directly.
>     
>     Signed-off-by: Christoph Hellwig <hch@lst.de>
>     [rw: Folded in improvements as discussed with hch and jens]
>     Signed-off-by: Richard Weinberger <richard@nod.at>
>     Signed-off-by: Jens Axboe <axboe@kernel.dk>
> 
> Please check your root filesystem, it is possible that the broken block
> driver broke it and you see further problems.
> Let me figure what in your .config triggers the issue.

[    1.810000] Pid: 1, comm: swapper Not tainted 4.20.0-rc1-00062-g8053e5b93eca-dirty
[    1.810000] RIP: 0033:[<000000006003c436>]

RIP is rq_for_each_segment(bvec, req, iter) { in ubd_queue_rq().

[    1.810000] RSP: 000000009ec5b4d0  EFLAGS: 00010206
[    1.810000] RAX: 0000000000001000 RBX: 0000000000000000 RCX: 0000000000000000
[    1.810000] RDX: 00000000478b0000 RSI: 0000000000001000 RDI: 00000000603dff36
[    1.810000] RBP: 000000009ec5b530 R08: 0000000000000000 R09: 0000000000083700
[    1.810000] R10: 0000000000000000 R11: 0000000000000246 R12: 000000002804c000
[    1.810000] R13: 0000000012345678 R14: 0000000000001000 R15: 0000000000000000

R13 is the poison.

[    1.810000] Kernel panic - not syncing: Segfault with no mm 00000000123456a8

Kernel tried to access it, plus a little offset.

Can it be that your change introduced a use-after-free bug in UML's block driver?

[    1.810000] CPU: 0 PID: 1 Comm: swapper Not tainted 4.20.0-rc1-00062-g8053e5b93eca-dirty #245
[    1.810000] Stack:
[    1.810000]  9d8c0c00 9d8c0c00 9d8c4140 00000000
[    1.810000]  9f5bf478 00001000 9d8b86a0 9ec5b5d0
[    1.810000]  9d8c0c00 9d8c4140 00000000 9d8c4180
[    1.810000] Call Trace:
[    1.810000]  [<603f595d>] blk_mq_dispatch_rq_list+0x32d/0x5c0
[    1.810000]  [<6040d6f8>] ? deadline_remove_request+0xa8/0xd0
[    1.810000]  [<6040d901>] ? dd_dispatch_request+0x1e1/0x2a0
[    1.810000]  [<603f5630>] ? blk_mq_dispatch_rq_list+0x0/0x5c0
[    1.810000]  [<603f9ca6>] blk_mq_do_dispatch_sched+0xe6/0x100
[    1.810000]  [<603fa401>] blk_mq_sched_dispatch_requests+0x111/0x180
[    1.810000]  [<603f7e80>] ? __blk_mq_get_tag.isra.0+0x0/0xa0
[    1.810000]  [<603f3904>] __blk_mq_run_hw_queue+0xf4/0x120
[    1.810000]  [<60044848>] ? set_signals+0x28/0x50
[    1.810000]  [<603f396d>] __blk_mq_delay_run_hw_queue+0x3d/0xd0
[    1.810000]  [<603f3b5d>] blk_mq_run_hw_queue+0x10d/0x1d0
[    1.810000]  [<603f7e80>] ? __blk_mq_get_tag.isra.0+0x0/0xa0
[    1.810000]  [<603f848d>] blk_mq_get_tag+0x16d/0x2d0
[    1.810000]  [<60083910>] ? autoremove_wake_function+0x0/0x40
[    1.810000]  [<603f277f>] blk_mq_get_request+0x13f/0x3d0
[    1.810000]  [<603fa4ba>] ? __blk_mq_sched_bio_merge+0x4a/0xd0
[    1.810000]  [<603f5343>] blk_mq_make_request+0x113/0x400
[    1.810000]  [<60044820>] ? set_signals+0x0/0x50
[    1.810000]  [<603e67e0>] ? blk_queue_enter+0x0/0x220
[    1.810000]  [<603e0ef0>] ? bio_endio+0x0/0x130
[    1.810000]  [<603e722e>] generic_make_request+0x27e/0x450
[    1.810000]  [<603e75c1>] ? submit_bio+0x1c1/0x1d0
[    1.810000]  [<60044820>] ? set_signals+0x0/0x50
[    1.810000]  [<60044820>] ? set_signals+0x0/0x50
[    1.810000]  [<603e75c1>] submit_bio+0x1c1/0x1d0
[    1.810000]  [<6017bcaf>] ? submit_bh_wbc.isra.1+0x21f/0x230
[    1.810000]  [<6017b940>] ? guard_bio_eod+0x70/0x1c0
[    1.810000]  [<6017bcaf>] submit_bh_wbc.isra.1+0x21f/0x230
[    1.810000]  [<6017ca30>] ? __breadahead+0x0/0x90
[    1.810000]  [<6017c3d2>] submit_bh+0x12/0x20
[    1.810000]  [<601ef9f5>] __ext4_get_inode_loc+0x415/0x4e0
[    1.810000]  [<601f2dee>] ext4_iget+0x6e/0xdb0
[    1.810000]  [<603aaec1>] ? avc_has_perm_noaudit+0xd1/0x130
[    1.810000]  [<601f3b60>] ext4_iget_normal+0x30/0x40
[    1.810000]  [<6020e074>] ext4_lookup+0x114/0x210
[    1.810000]  [<6015cee0>] ? d_alloc_parallel+0x0/0x5a0
[    1.810000]  [<6014a146>] __lookup_slow+0x106/0x190
[    1.810000]  [<6014e411>] ? lookup_fast+0x61/0x3a0
[    1.810000]  [<6014a213>] lookup_slow+0x43/0x70
[    1.810000]  [<6014d900>] ? trailing_symlink+0x0/0x2d0
[    1.810000]  [<6014e87d>] walk_component+0x12d/0x360
[    1.810000]  [<6014eb20>] ? link_path_walk+0x70/0x520
[    1.810000]  [<6014eab0>] ? link_path_walk+0x0/0x520
[    1.810000]  [<6014e750>] ? walk_component+0x0/0x360
[    1.810000]  [<6014d900>] ? trailing_symlink+0x0/0x2d0
[    1.810000]  [<6014f556>] path_lookupat+0x1c6/0x240
[    1.810000]  [<607aeeb0>] ? _raw_spin_unlock+0x0/0x20
[    1.810000]  [<607aed60>] ? _raw_spin_lock+0x0/0x20
[    1.810000]  [<60044848>] ? set_signals+0x28/0x50
[    1.810000]  [<60150d82>] filename_lookup+0xc2/0x1a0
[    1.810000]  [<607aeeb0>] ? _raw_spin_unlock+0x0/0x20
[    1.810000]  [<6014f390>] ? path_lookupat+0x0/0x240
[    1.810000]  [<6012e6f3>] ? kmem_cache_alloc+0xd3/0x120
[    1.810000]  [<6002d31a>] ? __strncpy_from_user+0x4a/0xa0
[    1.810000]  [<6012e620>] ? kmem_cache_alloc+0x0/0x120
[    1.810000]  [<60150899>] ? getname_flags+0xb9/0x310
[    1.810000]  [<600fc2be>] ? strndup_user+0x9e/0xc0
[    1.810000]  [<60150f33>] user_path_at_empty+0x43/0x50
[    1.810000]  [<60167bf5>] do_mount+0x85/0xfa0
[    1.810000]  [<600fc0a5>] ? memdup_user+0x85/0x100
[    1.810000]  [<600fc2be>] ? strndup_user+0x9e/0xc0
[    1.810000]  [<60168f63>] ksys_mount+0xd3/0x110
[    1.810000]  [<60729ba0>] ? strncmp+0x0/0x60
[    1.810000]  [<60729ba0>] ? strncmp+0x0/0x60
[    1.810000]  [<600272b0>] ? do_one_initcall+0x0/0x1a0
[    1.810000]  [<604a225f>] devtmpfs_mount+0x4f/0xa0
[    1.810000]  [<600272b0>] ? do_one_initcall+0x0/0x1a0
[    1.810000]  [<60001a85>] 0x60001a85
[    1.810000]  [<60163250>] ? ksys_dup+0x0/0x90
[    1.810000]  [<600272b0>] ? do_one_initcall+0x0/0x1a0
[    1.810000]  [<60001091>] 0x60001091
[    1.810000]  [<607aef4c>] ? _raw_spin_unlock_irq+0x1c/0x20
[    1.810000]  [<600908fa>] ? printk+0x0/0x94
[    1.810000]  [<607a8797>] kernel_init+0x27/0x150
[    1.810000]  [<60029061>] new_thread_handler+0x81/0xc0

Thanks,
//richard



_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

