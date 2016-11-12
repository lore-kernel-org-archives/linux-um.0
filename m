Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <thomas@m3y3r.de>) id 1c5X35-0003O8-AK
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 12 Nov 2016 12:04:43 +0000
Received: from www17.your-server.de ([213.133.104.17])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1c5X33-0001ri-PT
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 12 Nov 2016 12:04:43 +0000
Received: from [95.222.27.215] (helo=linux)
	by www17.your-server.de with esmtpsa
	(TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256) (Exim 4.85_2)
	(envelope-from <thomas@m3y3r.de>) id 1c5Wma-0000R5-SP
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 12 Nov 2016 12:47:40 +0100
Message-ID: <1478951260.265331.11.camel@m3y3r.de>
From: Thomas Meyer <thomas@m3y3r.de>
Date: Sat, 12 Nov 2016 12:47:40 +0100
Mime-Version: 1.0
Subject: [uml-devel] vma-merge warning
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
To: user-mode-linux-devel@lists.sourceforge.net

Hi,

my kernel log is full with those messages:

any ideas? I have CONFIG_LOCKDEP=y set.

[ 3237.220000] ------------[ cut here ]------------
[ 3237.220000] WARNING: CPU: 0 PID: 1445 at mm/mmap.c:1110 vma_merge+0x323/0x3c0
[ 3237.220000] Modules linked in:
[ 3237.220000] CPU: 0 PID: 1445 Comm: mdadm Tainted: G        W       4.9.0-rc3-00262-g53886f5 #277
[ 3237.220000] Stack:
[ 3237.220000]  ae8d5a40 600c3024 00000009 00000000
[ 3237.220000]  6014fb9c 00000000 ae8d5a50 604d4aac
[ 3237.220000]  ae8d5ab0 6006606e 456ae8d5a70 60193b13
[ 3237.220000] Call Trace:
[ 3237.220000]  [<60193b13>] ? [ 3237.220000] vma_merge+0x323/0x3c0
 [<6014fb9c>] ? [ 3237.220000] printk+0x0/0x94
 [<60043b29>] [ 3237.220000] show_stack+0x129/0x190
 [<600c3024>] ? [ 3237.220000] dump_stack_print_info+0xe4/0xf0
 [<6014fb9c>] ? [ 3237.220000] printk+0x0/0x94
 [<604d4aac>] [ 3237.220000] dump_stack+0x2a/0x2e
 [<6006606e>] [ 3237.220000] __warn+0x11e/0x150
 [<60193b13>] ? [ 3237.220000] vma_merge+0x323/0x3c0
 [<607fa224>] ? [ 3237.220000] _raw_spin_unlock_irqrestore+0x54/0x80
 [<600661ef>] [ 3237.220000] warn_slowpath_null+0x1f/0x30
 [<60193b13>] [ 3237.220000] vma_merge+0x323/0x3c0
 [<601951f0>] ? [ 3237.220000] may_expand_vm+0x0/0x170
 [<6019783d>] [ 3237.220000] mprotect_fixup+0x14d/0x2e0
 [<601cb87c>] [ 3237.220000] setup_arg_pages+0x10c/0x470
 [<6023f3d5>] [ 3237.220000] load_elf_binary+0x475/0xfa0
 [<6005a288>] ? [ 3237.220000] set_signals+0x28/0x50
 [<600b7be6>] ? [ 3237.220000] lock_release+0x736/0x7f0
 [<600b7463>] ? [ 3237.220000] lock_acquire+0x203/0x250
 [<600b1e2e>] ? [ 3237.220000] lock_acquired+0x4ae/0x530
 [<601ccfb4>] ? [ 3237.220000] search_binary_handler+0xa4/0x290
 [<600e98a0>] ? [ 3237.220000] try_module_get+0x0/0x1d0
 [<600e98a0>] ? [ 3237.220000] try_module_get+0x0/0x1d0
 [<601ccf9b>] [ 3237.220000] search_binary_handler+0x8b/0x290
 [<6008ecf5>] ? [ 3237.220000] __task_pid_nr_ns+0x225/0x240
 [<600c8b90>] ? [ 3237.220000] debug_lockdep_rcu_enabled+0x0/0x40
 [<601cb220>] ? [ 3237.220000] copy_strings+0x0/0x500
 [<600c8b90>] ? [ 3237.220000] debug_lockdep_rcu_enabled+0x0/0x40
 [<6043a658>] [ 3237.220000] exec_binprm+0x18c/0x364
 [<601cb220>] ? [ 3237.220000] copy_strings+0x0/0x500
 [<601cde98>] [ 3237.220000] do_execveat_common+0x6d8/0x8c0
 [<601ce436>] [ 3237.220000] SyS_execve+0x36/0x40
 [<60046288>] [ 3237.220000] handle_syscall+0x98/0xc0
 [<6005d662>] [ 3237.220000] userspace+0x3c2/0x4d0
 [<60058c1f>] ? [ 3237.220000] save_registers+0x1f/0x50
 [<60060c77>] ? [ 3237.220000] arch_prctl+0x117/0x1e0
 [<600422e5>] [ 3237.220000] fork_handler+0x85/0x90
[ 3237.220000] 
[ 3237.220000] ---[ end trace 3d18ccfe26aa207a ]---
[ 3237.270000] reboot: System halted

with kind regards
thomas


------------------------------------------------------------------------------
Developer Access Program for Intel Xeon Phi Processors
Access to Intel Xeon Phi processor-based developer platforms.
With one year of Intel Parallel Studio XE.
Training and support from Colfax.
Order your platform today. http://sdm.link/xeonphi
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

