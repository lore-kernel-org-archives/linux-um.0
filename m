Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <menage@google.com>) id 1MGPBW-0001oe-J5
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 16 Jun 2009 03:18:06 +0000
Received: from [216.239.33.17] (helo=smtp-out.google.com)
	by 72vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MGNSe-0006VR-1Z
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 16 Jun 2009 01:27:42 +0000
From: Paul Menage <menage@google.com>
Date: Mon, 15 Jun 2009 17:17:24 -0700
Message-ID: <20090616001248.30398.84278.stgit@menage.mtv.corp.google.com>
MIME-Version: 1.0
Subject: [uml-devel] [RFC][PATCH 0/5] UML: Support lockdep on x86-64 UML
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
To: peterz@infradead.org, mingo@redhat.com, jdike@addtoit.com
Cc: user-mode-linux-devel@lists.sourceforge.net

The following series provides the basic support for lockdep on UML
running on x86-64, and fixes a few lockdep-generated warnings.

It's not yet sufficient to properly use lockdep yet - currently
lockdep disables itself with the stacktrace/warning below; presumably
there's a point in the UML code where an unblock_signals() call needs
to be accompanied by a trace_hardirqs_off(), but I'm not familiar
enough with the UML code to figure out which one(s). Any suggestions
from those more familiar with either lockdep or UML would be welcome.

 [<0000000060025e3d>] show_trace+0x61/0x78
 [<0000000060025f64>] dump_stack+0x22/0x2e
 [<0000000060043192>] warn_slowpath_common+0x66/0x90
 [<00000000600431ce>] warn_slowpath_null+0x12/0x14
 [<00000000600648c3>] check_flags+0xbb/0x1c0
 [<0000000060069dcc>] lock_acquire+0x61/0xd9
 [<0000000060082236>] find_get_page+0x47/0xb1
 [<0000000060082539>] find_lock_page+0x25/0x77
 [<0000000060082ed9>] find_or_create_page+0x3c/0xa8
 [<00000000600cdca3>] __getblk+0x144/0x25e
 [<0000000060119025>] jread+0x13c/0x24c
 [<00000000601191a8>] do_one_pass+0x73/0x4b9
 [<00000000601196c3>] journal_recover+0x54/0xf1
 [<000000006011c159>] journal_load+0x59/0xa5
 [<0000000060109eec>] ext3_fill_super+0x10c7/0x1884
 [<00000000600ad64a>] get_sb_bdev+0x123/0x175
 [<00000000601068f2>] ext3_get_sb+0x12/0x14
 [<00000000600ac475>] vfs_kern_mount+0x5d/0xae
 [<00000000600ac52e>] do_kern_mount+0x52/0x103
 [<00000000600c476e>] do_mount+0x7ca/0x861
 [<00000000600c4894>] sys_mount+0x8f/0xeb
 [<00000000600129f3>] mount_block_root+0xf8/0x2d3
 [<0000000060012c1e>] mount_root+0x50/0x57
 [<0000000060012d47>] prepare_namespace+0x122/0x14d
 [<00000000600121f2>] kernel_init+0x10f/0x120
 [<000000006003443d>] run_kernel_thread+0x41/0x4a
 [<0000000060024c9d>] new_thread_handler+0x7f/0xb2
 [<ffffffffffffffff>] 0xffffffffffffffff
---[ end trace ee4fa9a354ebc0b4 ]---
possible reason: unannotated irqs-on.
irq event stamp: 29900
hardirqs last  enabled at (29899): [<00000000600a87a5>] kmem_cache_alloc+0xa0/0x10b
hardirqs last disabled at (29900): [<00000000600240a3>] sigio_handler+0x18/0x76
softirqs last  enabled at (19414): [<00000000601c1706>] xfrm_state_unlock_afinfo+0xe/0x10
softirqs last disabled at (19412): [<00000000601d0cda>] _write_lock_bh+0x13/0x77



---

Paul Menage (5):
      UML: Remove sigio_lock()/sigio_unlock() lockdep warnings
      UML: Avoid lockdep issues during initialization
      UML: Enable CONFIG_STACKTRACE_SUPPORT
      UML: Enable CONFIG_TRACE_IRQFLAGS_SUPPORT
      UML: Fix some apparent bitrot


 arch/um/Kconfig.common             |    4 +-
 arch/um/drivers/slip_kern.c        |    1 -
 arch/um/drivers/slirp_kern.c       |    1 -
 arch/um/include/asm/dma-mapping.h  |    4 +-
 arch/um/include/asm/system.h       |   39 ++++++++++++---------
 arch/um/include/shared/as-layout.h |    4 +-
 arch/um/include/shared/sigio.h     |    4 +-
 arch/um/kernel/Makefile            |    1 +
 arch/um/kernel/irq.c               |    1 +
 arch/um/kernel/process.c           |    1 -
 arch/um/kernel/sigio.c             |    8 ++--
 arch/um/kernel/skas/process.c      |   28 ++++++++++++++-
 arch/um/kernel/stacktrace.c        |   68 ++++++++++++++++++++++++++++++++++++
 arch/um/kernel/sysrq.c             |   20 +++++++++++
 arch/um/kernel/um_arch.c           |   20 -----------
 arch/um/os-Linux/sigio.c           |   55 +++++++++++++++--------------
 16 files changed, 179 insertions(+), 80 deletions(-)
 create mode 100644 arch/um/kernel/stacktrace.c


------------------------------------------------------------------------------
Crystal Reports - New Free Runtime and 30 Day Trial
Check out the new simplified licensing option that enables unlimited
royalty-free distribution of the report engine for externally facing 
server and web deployment.
http://p.sf.net/sfu/businessobjects
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

