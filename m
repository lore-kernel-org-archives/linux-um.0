Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <thomas@m3y3r.de>) id 1Ya86I-0001G7-IL
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 23 Mar 2015 19:33:26 +0000
Received: from www17.your-server.de ([213.133.104.17])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Ya86F-00058I-VA
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 23 Mar 2015 19:33:26 +0000
Message-ID: <1427137459.4915.26.camel@m3y3r.de>
From: Thomas Meyer <thomas@m3y3r.de>
Date: Mon, 23 Mar 2015 20:04:19 +0100
In-Reply-To: <CAFLxGvxqucFWqFxTVCHwwkHQ0s4HUXeJjMmun3tfs_-dQ3JAZA@mail.gmail.com>
References: <F66C82F4-14F8-4354-9B7F-FC764D2A18F9@m3y3r.de>
	<CAFLxGvxqucFWqFxTVCHwwkHQ0s4HUXeJjMmun3tfs_-dQ3JAZA@mail.gmail.com>
Mime-Version: 1.0
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
Subject: Re: [uml-devel] Kmsg dumper patches?
To: Richard Weinberger <richard.weinberger@gmail.com>
Cc: Daniel Walter <sahne@0x90.at>, UML devel <user-mode-linux-devel@lists.sourceforge.net>

Am Montag, den 26.01.2015, 21:44 +0100 schrieb Richard Weinberger:
> On Sun, Jan 18, 2015 at 1:27 PM, Thomas Meyer <thomas@m3y3r.de> wrote:
> > Hi,
> >
> > Any news. On this?
> >
> > http://sourceforge.net/p/user-mode-linux/mailman/message/32947218/
> > http://sourceforge.net/p/user-mode-linux/mailman/message/32947219/
> > http://sourceforge.net/p/user-mode-linux/mailman/message/32947217/
> 
> Easy answer, fallen through the cracks. :-\
> Thanks for the reminder!
> 
> I'm fine with 1/3, please add a more detailed changelog and resend.

okay, will do so.

> For 2/3 I'm not sure why we need this feature, can't you use earlyprintk?

Mainly for give the user more info why the uml kernel is currently
crashing. Mainly for the kernel command line parameter
"initrd=initfd.file.bin" with too few physical memory. E.g:

$ ../linux-um/linux mem=56m initrd=initrd.img 
Core dump limits :
	soft - 0
	hard - NONE
Checking that ptrace can change system call numbers...OK
Checking syscall emulation patch for ptrace...OK
Checking advanced syscall emulation patch for ptrace...OK
Checking environment variables for a tempdir...none found
Checking if /dev/shm is on tmpfs...OK
Checking PROT_EXEC mmap in /dev/shm...OK
Checking for the skas3 patch in the host:
  - /proc/mm...not found: No such file or directory
  - PTRACE_FAULTINFO...not found
  - PTRACE_LDT...not found
UML running in SKAS0 mode
Adding 31641600 bytes to physical memory to account for exec-shield gap
kmsg_dump:
<1>[    0.000000] bootmem alloc of 44301012 bytes failed!
<0>[    0.000000] Kernel panic - not syncing: Out of memory
<4>[    0.000000] CPU: 0 PID: 0 Comm: swapper Not tainted 4.0.0-rc4-11419-gdda564b-dirty #181
<6>[    0.000000] Stack:
<4>[    0.000000]  608bde10 600a2e72 608bde20 606a2dcf
<4>[    0.000000]  603e9410 00000000 608bde20 606a5bf9
<4>[    0.000000]  608bdf40 606a282f 60010634 00000000
<6>[    0.000000] Call Trace:
<6>[    0.000000]  [<606a2dcf>] ? printk+0x0/0x94
<6>[    0.000000]  [<60031820>] show_stack+0x110/0x1e0
<6>[    0.000000]  [<600a2e72>] ? dump_stack_print_info+0xd2/0xf0
<6>[    0.000000]  [<606a2dcf>] ? printk+0x0/0x94
<6>[    0.000000]  [<603e9410>] ? bust_spinlocks+0x0/0x60
<6>[    0.000000]  [<606a5bf9>] dump_stack+0x2a/0x2c
<6>[    0.000000]  [<606a282f>] panic+0x169/0x311
<6>[    0.000000]  [<60010634>] ? 0x60010634
<6>[    0.000000]  [<606a26c6>] ? panic+0x0/0x311
<6>[    0.000000]  [<606a2dcf>] ? printk+0x0/0x94
<6>[    0.000000]  [<6001070c>] ? 0x6001070c
<6>[    0.000000]  [<60010634>] ? 0x60010634
<6>[    0.000000]  [<600107c1>] 0x600107c1
<6>[    0.000000]  [<60010d60>] 0x60010d60
<6>[    0.000000]  [<60006216>] 0x60006216
<6>[    0.000000]  [<60033772>] uml_finishsetup+0x52/0x70
<6>[    0.000000] 

> earlyprintk on UML will print everything to stdout.
sadly, this happens so early that no early console will be available,
therefore the kmessage dumper.

> 3/3 is also fine but please coordinate with Daniel and his ftrace work. Daniel?

Daniel, any news on this?
As far as I understand the code, that's all necessary for
TRACE_IRQFLAGS_SUPPORT support...

but I may be wrong here! ;-)

Btw. I played with LOCKDEP support and above patches and got this
warning: Real bug or does this one need an annotation?

[    1.490000] =================================
[    1.490000] [ INFO: inconsistent lock state ]
[    1.490000] 4.0.0-rc4-11419-gdda564b-dirty #181 Not tainted
[    1.490000] ---------------------------------
[    1.490000] inconsistent {HARDIRQ-ON-W} -> {IN-HARDIRQ-W} usage.
[    1.490000] swapper/1 [HC1[1]:SC0[0]:HE0:SE1] takes:
[    1.490000]  (sigio_spinlock){?.+.+.}, at: [<00000000600312da>] sigio_lock+0x1a/0x20
[    1.490000] {HARDIRQ-ON-W} state was registered at:
[    1.490000]   [<0000000060034a05>] __save_stack_trace+0x25/0x50
[    1.490000]   [<0000000060034a54>] save_stack_trace+0x24/0x30
[    1.490000]   [<000000006008ff44>] save_trace+0x54/0x100
[    1.490000]   [<0000000060095bd4>] mark_lock+0x1f4/0x950
[    1.490000]   [<00000000600974af>] __lock_acquire+0x99f/0xfa0
[    1.490000]   [<0000000060098624>] lock_acquire+0xa4/0xe0
[    1.490000]   [<00000000606ad153>] _raw_spin_lock+0x33/0x90
[    1.490000]   [<00000000600312da>] sigio_lock+0x1a/0x20
[    1.490000]   [<00000000600477cd>] sigio_broken+0x2d/0x370
[    1.490000]   [<0000000060006ae9>] 0x60006ae9
[    1.490000]   [<000000006002e43d>] do_one_initcall+0xed/0x270
[    1.490000]   [<0000000060002025>] 0x60002025
[    1.490000]   [<00000000606a1e35>] kernel_init+0x15/0x170
[    1.490000]   [<0000000060030091>] new_thread_handler+0x81/0xb0
[    1.490000] irq event stamp: 168808
[    1.490000] hardirqs last  enabled at (168807): [<00000000606ad790>] _raw_spin_unlock_irq+0x40/0x60
[    1.490000] hardirqs last disabled at (168808): [<0000000060189fa6>] end_buffer_async_read+0x76/0x270
[    1.490000] softirqs last  enabled at (168114): [<0000000060115541>] bdi_register+0x181/0x1a0
[    1.490000] softirqs last disabled at (168112): [<0000000060115500>] bdi_register+0x140/0x1a0
[    1.490000] 
[    1.490000] other info that might help us debug this:
[    1.490000]  Possible unsafe locking scenario:
[    1.490000] 
[    1.490000]        CPU0
[    1.490000]        ----
[    1.490000]   lock(sigio_spinlock);
[    1.490000]   <Interrupt>
[    1.490000]     lock(sigio_spinlock);
[    1.490000] 
[    1.490000]  *** DEADLOCK ***
[    1.490000] 
[    1.490000] 2 locks held by swapper/1:
[    1.490000]  #0:  (ubd_lock){+.+.+.}, at: [<00000000600067aa>] 0x600067aa
[    1.490000]  #1:  (&bdev->bd_mutex){+.+.+.}, at: [<0000000060190bfc>] __blkdev_get+0x8c/0x5a0
[    1.490000] 
[    1.490000] stack backtrace:
[    1.490000] CPU: 0 PID: 1 Comm: swapper Not tainted 4.0.0-rc4-11419-gdda564b-dirty #181
[    1.490000] Stack:
[    1.490000]  64970f40 600a2e72 64970f50 6132bcd0
[    1.490000]  6496e040 6008f950 64970f50 606a5bf9
[    1.490000]  64970fb0 600958e0 6191bf00 6191bf00
[    1.490000] Call Trace:
[    1.490000]  [<606a2dcf>] ? printk+0x0/0x94
[    1.490000]  [<60031820>] show_stack+0x110/0x1e0
[    1.490000]  [<600a2e72>] ? dump_stack_print_info+0xd2/0xf0
[    1.490000]  [<6008f950>] ? __print_lock_name+0x0/0xc0
[    1.490000]  [<606a5bf9>] dump_stack+0x2a/0x2c
[    1.490000]  [<600958e0>] print_usage_bug+0x360/0x460
[    1.490000]  [<60034a54>] ? save_stack_trace+0x24/0x30
[    1.490000]  [<60092e10>] ? check_usage_forwards+0x0/0x160
[    1.490000]  [<60096297>] mark_lock+0x8b7/0x950
[    1.490000]  [<600959e0>] ? mark_lock+0x0/0x950
[    1.490000]  [<60097680>] __lock_acquire+0xb70/0xfa0
[    1.490000]  [<60084510>] ? local_clock+0x10/0x20
[    1.490000]  [<60098624>] lock_acquire+0xa4/0xe0
[    1.490000]  [<600312da>] ? sigio_lock+0x1a/0x20
[    1.490000]  [<600985db>] ? lock_acquire+0x5b/0xe0
[    1.490000]  [<60048210>] ? get_signals+0x0/0x10
[    1.490000]  [<606ad420>] ? _raw_spin_lock_irqsave+0x0/0xc0
[    1.490000]  [<606ad153>] _raw_spin_lock+0x33/0x90
[    1.490000]  [<600312da>] ? sigio_lock+0x1a/0x20
[    1.490000]  [<6002f3c0>] ? reactivate_fd+0x70/0xc0
[    1.490000]  [<600312da>] sigio_lock+0x1a/0x20
[    1.490000]  [<60047520>] add_sigio_fd+0x20/0x180
[    1.490000]  [<60048210>] ? get_signals+0x0/0x10
[    1.490000]  [<606ad420>] ? _raw_spin_lock_irqsave+0x0/0xc0
[    1.490000]  [<6002f3ce>] reactivate_fd+0x7e/0xc0
[    1.490000]  [<60140ed0>] ? kfree+0x0/0x1c0
[    1.490000]  [<60140ed0>] ? kfree+0x0/0x1c0
[    1.490000]  [<60044ea0>] ? os_read_file+0x0/0x30
[    1.490000]  [<60140ed0>] ? kfree+0x0/0x1c0
[    1.490000]  [<603ba6c0>] ? blk_end_request+0x0/0x20
[    1.490000]  [<600405da>] ubd_intr+0x9a/0x150
[    1.490000]  [<60048210>] ? get_signals+0x0/0x10
[    1.490000]  [<600a3744>] handle_irq_event_percpu+0x74/0x170
[    1.490000]  [<60045e40>] ? os_waiting_for_events+0x0/0xf0
[    1.490000]  [<60045e40>] ? os_waiting_for_events+0x0/0xf0
[    1.490000]  [<600a388a>] handle_irq_event+0x4a/0x80
[    1.490000]  [<600a3840>] ? handle_irq_event+0x0/0x80
[    1.490000]  [<600a6634>] handle_edge_irq+0xd4/0x150
[    1.490000]  [<600a2f5c>] generic_handle_irq+0x2c/0x40
[    1.490000]  [<6002f92b>] do_IRQ+0x3b/0x60
[    1.490000]  [<6002f8f0>] ? do_IRQ+0x0/0x60
[    1.490000]  [<6002f9cf>] sigio_handler+0x7f/0xc0
[    1.490000]  [<60048021>] sig_handler_common+0x71/0xe0
[    1.490000]  [<6008fb84>] ? trace_hardirqs_off+0x14/0x20
[    1.490000]  [<6009711c>] ? __lock_acquire+0x60c/0xfa0
[    1.490000]  [<6008fb0c>] ? trace_hardirqs_off_caller+0x9c/0x100
[    1.490000]  [<600fe750>] ? get_page_from_freelist+0x0/0xad0
[    1.490000]  [<600ff61b>] ? __alloc_pages_nodemask+0x21b/0xbd0
[    1.490000]  [<600959e0>] ? mark_lock+0x0/0x950
[    1.490000]  [<60084510>] ? local_clock+0x10/0x20
[    1.490000]  [<6009018e>] ? lock_release_holdtime+0x2e/0x240
[    1.490000]  [<60098bd0>] ? lock_release+0xf0/0x2b0
[    1.490000]  [<60141f5f>] ? cache_alloc_refill+0x1df/0x9c0
[    1.490000]  [<6008fb70>] ? trace_hardirqs_off+0x0/0x20
[    1.490000]  [<606ad674>] ? _raw_spin_unlock+0x34/0x40
[    1.490000]  [<60141f5f>] ? cache_alloc_refill+0x1df/0x9c0
[    1.490000]  [<60141541>] ? cache_alloc_debugcheck_after.isra.57+0x151/0x330
[    1.490000]  [<6008fb70>] ? trace_hardirqs_off+0x0/0x20
[    1.490000]  [<6003f3e5>] ? do_ubd_request+0x95/0x470
[    1.490000]  [<603bb4b5>] ? blk_fetch_request+0x15/0x40
[    1.490000]  [<600959e0>] ? mark_lock+0x0/0x950
[    1.490000]  [<600963bd>] ? mark_held_locks+0x8d/0x110
[    1.490000]  [<606ad790>] ? _raw_spin_unlock_irq+0x40/0x60
[    1.490000]  [<60047fb0>] ? sig_handler_common+0x0/0xe0
[    1.490000]  [<60048090>] ? real_alarm_handler+0x0/0x60
[    1.490000]  [<60047f8c>] unblock_signals+0x8c/0xb0
[    1.490000]  [<606ad79c>] _raw_spin_unlock_irq+0x4c/0x60
[    1.490000]  [<603bbb64>] blk_queue_bio+0x224/0x2f0
[    1.490000]  [<603b8dc9>] ? generic_make_request_checks+0x1d9/0x360
[    1.490000]  [<6018c140>] ? _submit_bh+0x0/0x230
[    1.490000]  [<603b9028>] generic_make_request+0xd8/0x180
[    1.490000]  [<603b917f>] submit_bio+0xaf/0x220
[    1.490000]  [<606ad674>] ? _raw_spin_unlock+0x34/0x40
[    1.490000]  [<6018c276>] _submit_bh+0x136/0x230
[    1.490000]  [<60189f30>] ? end_buffer_async_read+0x0/0x270
[    1.490000]  [<6018c702>] block_read_full_page+0x262/0x3c0
[    1.490000]  [<6018ef70>] ? blkdev_get_block+0x0/0x20
[    1.490000]  [<600f3359>] ? __add_to_page_cache_locked+0x199/0x360
[    1.490000]  [<60104f20>] ? put_page+0x0/0xd0
[    1.490000]  [<600f4200>] ? pagecache_get_page+0x0/0x2f0
[    1.490000]  [<6018f9ed>] blkdev_readpage+0x1d/0x20
[    1.490000]  [<600f45a5>] do_read_cache_page+0xb5/0x220
[    1.490000]  [<6018f9d0>] ? blkdev_readpage+0x0/0x20
[    1.490000]  [<600f472e>] read_cache_page+0x1e/0x20
[    1.490000]  [<603cf012>] read_dev_sector+0x32/0xb0
[    1.490000]  [<603d1af8>] read_lba+0xf8/0x1b0
[    1.490000]  [<603d2304>] find_valid_gpt+0x174/0x930
[    1.490000]  [<603d2b3c>] efi_partition+0x7c/0x480
[    1.490000]  [<603e8020>] ? snprintf+0x0/0x90
[    1.490000]  [<603d2ac0>] ? efi_partition+0x0/0x480
[    1.490000]  [<603d0dd5>] check_partition+0x145/0x2b0
[    1.490000]  [<603cc300>] ? get_gendisk+0x0/0x1e0
[    1.490000]  [<603cf805>] rescan_partitions+0x95/0x310
[    1.490000]  [<603cc300>] ? get_gendisk+0x0/0x1e0
[    1.490000]  [<60190f59>] __blkdev_get+0x3e9/0x5a0
[    1.490000]  [<6016e829>] ? unlock_new_inode+0x69/0xa0
[    1.490000]  [<60191155>] blkdev_get+0x45/0x590
[    1.490000]  [<6016e829>] ? unlock_new_inode+0x69/0xa0
[    1.490000]  [<6018f871>] ? bdget+0x161/0x180
[    1.490000]  [<603cccf1>] add_disk+0x611/0x680
[    1.490000]  [<604288a1>] ? platform_device_add+0xf1/0x330
[    1.490000]  [<6003f895>] ubd_disk_register+0xd5/0x1a0
[    1.490000]  [<600402a5>] ubd_add+0x155/0x2f0
[    1.490000]  [<6003f7c0>] ? ubd_disk_register+0x0/0x1a0
[    1.490000]  [<606a2dcf>] ? printk+0x0/0x94
[    1.490000]  [<603e0ab2>] ? kobject_uevent+0x12/0x20
[    1.490000]  [<60040150>] ? ubd_add+0x0/0x2f0
[    1.490000]  [<606a2dcf>] ? printk+0x0/0x94
[    1.490000]  [<600067b3>] 0x600067b3
[    1.490000]  [<603e3bd0>] ? strcmp+0x0/0x40
[    1.490000]  [<600066dc>] ? 0x600066dc
[    1.490000]  [<6002e43d>] do_one_initcall+0xed/0x270
[    1.490000]  [<600776f0>] ? parameq+0x0/0x80
[    1.490000]  [<60077a4b>] ? parse_args+0x2db/0x650
[    1.490000]  [<6002e350>] ? do_one_initcall+0x0/0x270
[    1.490000]  [<6002e350>] ? do_one_initcall+0x0/0x270
[    1.490000]  [<603e3ad0>] ? strcpy+0x0/0x30
[    1.490000]  [<60002025>] 0x60002025
[    1.490000]  [<606a1e35>] kernel_init+0x15/0x170
[    1.490000]  [<60030091>] new_thread_handler+0x81/0xb0
[    1.490000] 
[    1.490000]  ubda: ubda1 ubda2 ubda3
[    1.490000] Netdevice 0 (ee:12:b7:84:00:e0) : 



------------------------------------------------------------------------------
Dive into the World of Parallel Programming The Go Parallel Website, sponsored
by Intel and developed in partnership with Slashdot Media, is your hub for all
things parallel software development, from weekly thought leadership blogs to
news, videos, case studies, tutorials and more. Take a look and join the 
conversation now. http://goparallel.sourceforge.net/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

