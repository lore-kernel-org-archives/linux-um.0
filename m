Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CXOEt-0001h0-Pz for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 25 Nov 2004 10:21:07 -0800
Received: from plam.fujitsu-siemens.com ([217.115.66.9])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1CXOEs-0006xF-5W for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 25 Nov 2004 10:21:07 -0800
Message-ID: <41A6228D.4050908@fujitsu-siemens.com>
From: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [uml-devel] UML 2.6.10-rc2-mm3 + incremental crashes
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
Date: Thu, 25 Nov 2004 19:21:01 +0100
To: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux devel <user-mode-linux-devel@lists.sourceforge.net>

Have started to test with the new 2.6.10-rc2-mm3 + incrementals tree.

First, it didn't compile, because there are inconsistent definitions
for __pgd_alloc in include/linux/mm.h and arch/um/kernel/mem.c.
I added "fastcall" in arch/um/kernel/mem.c, then the build succeeded.

But now the kernel crashes on startup. Please ignore the error messages
regarding ext3.ko. For the "first shot" I didn't update the initrd.
But the kernel should handle the fs in ext2-mode anyway.

Bodo


Error messages from SKAS:

Loading kernel/fs/ext3/ext3.ko
ext3: version magic '2.6.9-skas3-v7-bb3 gcc-3.3' should be '2.6.10-rc2-mm3 gcc-3.3'
insmod: error inserting '/lib/modules/2.6.9-skas3-v7-bb3/kernel/fs/ext3/ext3.ko': -1 Invalid module format
umount: invalid option -n
umount: invalid option -n
Kernel panic - not syncing: Kernel mode fault at addr 0x4, ip 0x8048347

EIP: 0073:[<08048347>] CPU: 0 Not tainted ESP: 007b:bffffe80 EFLAGS: 00000246
     Not tainted
EAX: ffffffda EBX: bfffff87 ECX: 00000000 EDX: 00000000
ESI: 00000000 EDI: 00000002 EBP: bffffe84 DS: 007b ES: 007b
Call Trace:
  [<a004323d>] notifier_call_chain+0x1d/0x40
  [<a0032996>] panic+0x56/0x110
  [<a0018465>] segv+0x85/0x1e0
  [<a0018576>] segv+0x196/0x1e0
  [<a01c27a0>] __libc_write+0x0/0x60
  [<a01ab474>] sigemptyset+0x24/0x40
  [<a01ab474>] sigemptyset+0x24/0x40
  [<a00168a2>] change_signals+0x42/0x80
  [<a00188e8>] segv_handler+0x178/0x260
  [<a001884f>] segv_handler+0xdf/0x260
  [<a001da83>] sig_handler_common_skas+0xa3/0xc0
  [<a002e2bf>] sig_handler+0x2f/0x40
  [<a00149f3>] um_virt_to_phys+0x43/0x80
  [<a01ab228>] __restore+0x0/0x8
  [<a0072a9c>] invalidate_bdev+0xc/0x30
  [<a001dc58>] do_buffer_op+0x78/0x140
  [<a001de40>] copy_chunk_to_user+0x0/0x30
  [<a001de40>] copy_chunk_to_user+0x0/0x30
  [<a00198ae>] setjmp_wrapper+0x4e/0x60
  [<a0019876>] setjmp_wrapper+0x16/0x60
  [<a00149f3>] um_virt_to_phys+0x43/0x80
  [<a001db13>] maybe_map+0x23/0x80
  [<a001dbcc>] do_op+0x5c/0x70
  [<a001dc58>] do_buffer_op+0x78/0x140
  [<a001dee0>] strncpy_chunk_from_user+0x0/0x60
  [<a001dee0>] strncpy_chunk_from_user+0x0/0x60
  [<a00198ae>] setjmp_wrapper+0x4e/0x60
  [<a0019876>] setjmp_wrapper+0x16/0x60
  [<a001c4af>] map+0xff/0x130
  [<a0016938>] enable_mask+0x38/0x50
  [<a01ab474>] sigemptyset+0x24/0x40
  [<a0016a22>] set_signals+0x72/0x160
  [<a01ab474>] sigemptyset+0x24/0x40
  [<a00168a2>] change_signals+0x42/0x80
  [<a0016938>] enable_mask+0x38/0x50
  [<a01ab474>] sigemptyset+0x24/0x40
  [<a0016a22>] set_signals+0x72/0x160
  [<a0073939>] invalidate_bh_lru+0x19/0x40
  [<a007396a>] invalidate_bh_lrus+0xa/0x10
  [<a009e3e8>] vfs_quota_off+0xa8/0x220
  [<a008d231>] do_umount+0x1b1/0x1d0
  [<a008d2b7>] sys_umount+0x67/0x90
  [<a00182bb>] handle_page_fault+0x16b/0x1f0
  [<a0018465>] segv+0x85/0x1e0
  [<a001d53a>] execute_syscall_skas+0xda/0x120
  [<a00172cc>] record_syscall_start+0x4c/0x60
  [<a001d5b0>] handle_syscall+0x30/0x60
  [<a001c7e0>] handle_trap+0x30/0x130
  [<a001cc38>] userspace+0x188/0x1e0
  [<a001d190>] fork_handler+0x0/0x80
  [<a01ab228>] __restore+0x0/0x8
  [<a001d190>] fork_handler+0x0/0x80
  [<a01ab3e1>] __kill+0x11/0x20



Error messages from TT:

Loading kernel/fs/ext3/ext3.ko
ext3: version magic '2.6.9-skas3-v7-bb3 gcc-3.3' should be '2.6.10-rc2-mm3 gcc-3.3'
insmod: error inserting '/lib/modules/2.6.9-skas3-v7-bb3/kernel/fs/ext3/ext3.ko': -1 Invalid module format
umount: invalid option -n
umount: invalid option -n
Kernel panic - not syncing: Kernel mode fault at addr 0x4, ip 0xa0072a9c

EIP: 0073:[<a0072a9c>] CPU: 0 Not tainted ESP: 007b:afe93b44 EFLAGS: 00010292
     Not tainted
EAX: 00000000 EBX: 00000000 ECX: 00000000 EDX: 00000000
ESI: 00000002 EDI: aff30aa4 EBP: afe93b6c DS: 007b ES: 007b
Call Trace:
  [<a004323d>] notifier_call_chain+0x1d/0x40
  [<a0032996>] panic+0x56/0x110
  [<a0018465>] segv+0x85/0x1e0
  [<a0072a9c>] invalidate_bdev+0xc/0x30
  [<a0018576>] segv+0x196/0x1e0
  [<a0072a9c>] invalidate_bdev+0xc/0x30
  [<a01ab474>] sigemptyset+0x24/0x40
  [<a00168a2>] change_signals+0x42/0x80
  [<a001bd6d>] sig_handler_common_tt+0x8d/0x110
  [<a00188e8>] segv_handler+0x178/0x260
  [<a0072a9c>] invalidate_bdev+0xc/0x30
  [<a001884f>] segv_handler+0xdf/0x260
  [<a001bd6d>] sig_handler_common_tt+0x8d/0x110
  [<a002e2ae>] sig_handler+0x1e/0x40
  [<a01ab228>] __restore+0x0/0x8
  [<a0072a9c>] invalidate_bdev+0xc/0x30
  [<a01ab474>] sigemptyset+0x24/0x40
  [<a0016938>] enable_mask+0x38/0x50
  [<a01ab090>] __sigjmp_save+0x40/0x60
  [<a0018aa0>] __do_user_copy+0x90/0xd0
  [<a0018a3c>] __do_user_copy+0x2c/0xd0
  [<a001c2b1>] __do_strnlen_user+0x81/0xc0
  [<a001c275>] __do_strnlen_user+0x45/0xc0
  [<a0018a3c>] __do_user_copy+0x2c/0xd0
  [<a002e1a9>] os_map_memory+0x49/0x70
  [<a01ab474>] sigemptyset+0x24/0x40
  [<a01ab090>] __sigjmp_save+0x40/0x60
  [<a0018aa0>] __do_user_copy+0x90/0xd0
  [<a01ab474>] sigemptyset+0x24/0x40
  [<a0018a3c>] __do_user_copy+0x2c/0xd0
  [<a0016a22>] set_signals+0x72/0x160
  [<a0016938>] enable_mask+0x38/0x50
  [<a01ab474>] sigemptyset+0x24/0x40
  [<a0016a22>] set_signals+0x72/0x160
  [<a01ab474>] sigemptyset+0x24/0x40
  [<a00168a2>] change_signals+0x42/0x80
  [<a0016938>] enable_mask+0x38/0x50
  [<a01ab474>] sigemptyset+0x24/0x40
  [<a0016a22>] set_signals+0x72/0x160
  [<a0073939>] invalidate_bh_lru+0x19/0x40
  [<a007396a>] invalidate_bh_lrus+0xa/0x10
  [<a009e3e8>] vfs_quota_off+0xa8/0x220
  [<a008d231>] do_umount+0x1b1/0x1d0
  [<a008d2b7>] sys_umount+0x67/0x90
  [<a001170f>] sys_execve+0x3f/0x50
  [<a01ab474>] sigemptyset+0x24/0x40
  [<a001aaba>] execute_syscall_tt+0xda/0x120
  [<a00172cc>] record_syscall_start+0x4c/0x60
  [<a001ab3f>] syscall_handler_tt+0x3f/0x70
  [<a001bd6d>] sig_handler_common_tt+0x8d/0x110
  [<a002e2ae>] sig_handler+0x1e/0x40
  [<a01ab228>] __restore+0x0/0x8





-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
