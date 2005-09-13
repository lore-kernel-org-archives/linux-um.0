Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EFFOg-0004oy-C5	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 13 Sep 2005 11:20:46 -0700
Received: from smtp001.mail.ukl.yahoo.com ([217.12.11.32])
	by mail.sourceforge.net with smtp (Exim 4.44)	id 1EFFOb-0003xL-Nc
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 13 Sep 2005 11:20:46 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509132001.40992.blaisorblade@yahoo.it>
Subject: [uml-devel] "Sleeping in atomic section" with ubd aio patch
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
Date: Tue, 13 Sep 2005 20:01:40 +0200
To: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

Today I was running latest 2.6 UML git snapshot I have (from 8 September), 
compiled with spinlock debugging, and got a big number of long series of 
traces like this one (they varied a bit, but the core is 
do_io->kmem_cache_alloc).

It's just because things are called under spinlocks and GFP_KERNEL is used - 
but if possible, it'd be better to use something better than GFP_ATOMIC 
(since this is performance critical).

Debug: sleeping function called from invalid context 
at /home/paolo/Admin/kernel/6/VCS/linux-2.6.git/mm/slab.c:2097
in_atomic():0, irqs_disabled():1
a05bb5f0:  [<a0015c52>] dump_stack+0x22/0x30
a05bb610:  [<a0048ddc>] __might_sleep+0xac/0xd0
a05bb630:  [<a0094a38>] kmem_cache_alloc+0x98/0xb0
a05bb660:  [<a003b266>] do_io+0x3b6/0x520
a05bb760:  [<a003a6ba>] do_ubd_request+0x12a/0x180
a05bb7f0:  [<a01d146d>] __generic_unplug_device+0x2d/0x40
a05bb800:  [<a01d1500>] generic_unplug_device+0x80/0x180
a05bb830:  [<a01d1621>] blk_backing_dev_unplug+0x21/0x30
a05bb840:  [<a00bca6a>] block_sync_page+0x3a/0x50
a05bb850:  [<a0087556>] sync_page+0x46/0x60
a05bb860:  [<a02c79e9>] __wait_on_bit_lock+0x49/0x70
a05bb880:  [<a0087e39>] __lock_page+0x89/0xa0
a05bb900:  [<a008866a>] do_generic_mapping_read+0x3ca/0x770
a05bb9e0:  [<a0088e5e>] __generic_file_aio_read+0x26e/0x2c0
a05bba60:  [<a0088f03>] generic_file_aio_read+0x53/0x90
a05bba90:  [<a00b53bc>] do_sync_read+0xdc/0x130
a05bbb60:  [<a00b54f3>] vfs_read+0xe3/0x290
a05bbba0:  [<a00b5a2b>] sys_read+0x4b/0x80
a05bbbd0:  [<a001e687>] handle_syscall+0x117/0x140
a05bbc70:  [<a001d5a6>] userspace+0x236/0x3c0
a05bbcf0:  [<a001e1d8>] fork_handler+0xb8/0xd0
a05bbd20:  [<ffffe420>] _etext+0x5fd3398a/0x0

-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it



-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
