Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Gs7wv-0005OE-K3 for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 06 Dec 2006 17:21:21 -0800
Received: from [218.104.33.231] (helo=centecnetworks.com)
	by mail.sourceforge.net with smtp (Exim 4.44) id 1Gs7ws-0000R5-JV
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 06 Dec 2006 17:21:21 -0800
Message-ID: <45776C74.7060408@centecnetworks.com>
Date: Thu, 07 Dec 2006 09:20:52 +0800
From: Miao Qingjun <qmiao@centecnetworks.com>
MIME-Version: 1.0
Subject: [uml-devel] uml crash
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0829793678=="
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

--===============0829793678==
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: 7bit

 (sorry for previous hard-readable mail)

Here is a list of uml crash messages.
(uml guest: 2.6.18, uml host:2.6.12+skas3)

BUG: failure at linux/mm/prio_tree.c:125/vma_prio_tree_remove()!

Kernel panic - not syncing: BUG!

EIP: 0073:[<40015791>] CPU: 0 Tainted: P ESP: 007b:bf8ec4fc EFLAGS: 00000206

Tainted: P

EAX: ffffffda EBX: 401e8000 ECX: 00015800 EDX: 4001afb4

ESI: bf8ec554 EDI: 080531c0 EBP: bf8ec688 DS: 007b ES: 007b

0a139aa8: [<080712c1>] show_regs+0xed/0x10f

0a139ac4: [<0805da00>] panic_exit+0x2c/0x4b

0a139ad4: [<08085871>] notifier_call_chain+0x28/0x3f

0a139af4: [<0808591e>] atomic_notifier_call_chain+0x1f/0x21

0a139b08: [<08076a08>] panic+0x71/0x100

0a139b24: [<080a227d>] vma_prio_tree_next+0x0/0x4b

0a139b48: [<080a6a5a>] __remove_shared_vm_struct+0x48/0x64

0a139b5c: [<080a6a9c>] unlink_file_vma+0x26/0x28

0a139b70: [<080a3b48>] free_pgtables+0x2d/0x79

0a139b98: [<080a83d5>] unmap_region+0xb8/0xea

0a139bcc: [<080a8684>] do_munmap+0xde/0x159

0a139bf8: [<080a873b>] sys_munmap+0x3c/0x4f

0a139c18: [<0805e3c4>] handle_syscall+0xc8/0xe4

0a139c88: [<0806d949>] userspace+0x2a2/0x3a6

0a139cf0: [<0805e041>] fork_handler+0xe2/0xf0

0a139d20: [<b7f00420>] 0xb7f00420

Kernel panic - not syncing: Segfault with no mm

EIP: 0073:[<b7fc6402>] CPU: 0 Tainted: P ESP: 007b:b7fc2fa8 EFLAGS: 00000

246

Tainted: P

EAX: 00000000 EBX: 00005e44 ECX: 00000013 EDX: 00005e44

ESI: 00005e3e EDI: 00000011 EBP: b7fc2fb8 DS: 007b ES: 007b

09b3d5b0: [<080712c1>] show_regs+0xed/0x10f

09b3d5cc: [<0805da00>] panic_exit+0x2c/0x4b

09b3d5dc: [<08085871>] notifier_call_chain+0x28/0x3f

09b3d5fc: [<0808591e>] atomic_notifier_call_chain+0x1f/0x21

09b3d610: [<08076a08>] panic+0x71/0x100

09b3d62c: [<0805d137>] segv+0x279/0x2e7

09b3d6f8: [<0805ceb8>] segv_handler+0x6f/0x75

09b3d71c: [<0806e352>] sig_handler_common_skas+0xc2/0xfd

09b3d740: [<0806a615>] sig_handler+0x2f/0x4c

09b3d758: [<b7fc6420>] 0xb7fc6420

09b3da48: [<080d493d>] __sync_single_inode+0xe6/0x20d

09b3da78: [<080d4b00>] __writeback_single_inode+0x9c/0x177

09b3dae0: [<080d4d4f>] sync_sb_inodes+0x174/0x2ca

09b3db1c: [<080d4f26>] writeback_inodes+0x81/0x83

09b3db38: [<0809e517>] wb_kupdate+0x75/0xe8

09b3db8c: [<0809ed54>] __pdflush+0xc4/0x162

09b3dbb0: [<0809ee41>] pdflush+0x4f/0x51

09b3dbf0: [<0808bcfa>] kthread+0xb2/0xda

09b3dc2c: [<08069b57>] run_kernel_thread+0x50/0x69

09b3dce0: [<0805dee1>] new_thread_handler+0xbc/0x10e

09b3dd20: [<b7fc6420>] 0xb7fc6420

BUG: warning at linux/kernel/irq/manage.c:353/free_irq()

27c59268: [<0805bd72>] dump_stack+0x22/0x24

27c59280: [<08096e6b>] free_irq+0x116/0x11b

27c592ac: [<08062d53>] close_devices+0x2a/0x84

27c592c0: [<0805aaa3>] do_uml_exitcalls+0x13/0x21

27c592cc: [<0805b1e8>] uml_cleanup+0x12/0x19

27c592d4: [<0805b206>] machine_power_off+0x8/0xf

27c592dc: [<0805b215>] machine_halt+0x8/0xb

27c592e4: [<0805da1b>] panic_exit+0x47/0x4b

27c592f4: [<08085391>] notifier_call_chain+0x28/0x3f

27c59314: [<0808543e>] atomic_notifier_call_chain+0x1f/0x21

27c59328: [<08076528>] panic+0x71/0x100

27c59344: [<0805d0af>] segv+0x1f1/0x2e7

27c59410: [<0805ceb8>] segv_handler+0x6f/0x75

27c59434: [<0806de72>] sig_handler_common_skas+0xc2/0xfd

27c59458: [<0806a135>] sig_handler+0x2f/0x4c

27c59470: [<b7fb1420>] 0xb7fb1420

27c59768: [<08089575>] __rcu_process_callbacks+0x67/0xb4

27c59780: [<080895dc>] rcu_process_callbacks+0x1a/0x30

27c59790: [<0807c83b>] tasklet_action+0x44/0x9a

27c597b0: [<0807c537>] __do_softirq+0x5c/0xc8

27c597d4: [<0807c5ec>] do_softirq+0x49/0x4f

27c597e8: [<0807c639>] irq_exit+0x47/0x4f

27c597fc: [<0805c267>] timer_handler+0x3f/0x78

27c59818: [<0806de72>] sig_handler_common_skas+0xc2/0xfd

27c5983c: [<08069dc6>] real_alarm_handler+0x37/0x58

27c59854: [<0806a0f7>] alarm_handler+0x48/0x57

27c59868: [<b7fb1420>] 0xb7fb1420

27c59bfc: [<080950c8>] sys_init_module+0x51/0x178

27c59c18: [<0805e3c4>] handle_syscall+0xc8/0xe4

27c59c88: [<0806d469>] userspace+0x2a2/0x3a6

27c59cf0: [<0805e041>] fork_handler+0xe2/0xf0

27c59d20: [<b7fb1420>] 0xb7fb1420

VFS: Close: file count is 0
Kernel panic - not syncing: Kernel mode fault at addr 0x9, ip 0x400007e2

EIP: 0073:[<400007e2>] CPU: 0 Tainted: P ESP: 007b:bfb2d068 EFLAGS: 00000212
Tainted: P
EAX: ffffffda EBX: 00000000 ECX: 00005401 EDX: bfb2d078
ESI: 406baa64 EDI: 40177ff4 EBP: bfb2d0a8 DS: 007b ES: 007b
09b6d730: [<080712c1>] show_regs+0xed/0x10f
09b6d74c: [<0805da00>] panic_exit+0x2c/0x4b
09b6d75c: [<08085871>] notifier_call_chain+0x28/0x3f
09b6d77c: [<0808591e>] atomic_notifier_call_chain+0x1f/0x21
09b6d790: [<08076a08>] panic+0x71/0x100
09b6d7ac: [<0805d0af>] segv+0x1f1/0x2e7
09b6d878: [<0805ceb8>] segv_handler+0x6f/0x75
09b6d89c: [<0806e352>] sig_handler_common_skas+0xc2/0xfd
09b6d8c0: [<0806a615>] sig_handler+0x2f/0x4c
09b6d8d8: [<b7f67420>] 0xb7f67420
09b6dbf0: [<080c4fd0>] sys_ioctl+0x3b/0x5b
09b6dc18: [<0805e3c4>] handle_syscall+0xc8/0xe4
09b6dc88: [<0806d949>] userspace+0x2a2/0x3a6
09b6dcf0: [<0805e041>] fork_handler+0xe2/0xf0
09b6dd20: [<b7f67420>] 0xb7f6742


BUG: warning at linux/kernel/irq/manage.c:353/free_irq()
winch_interrupt : read failed, errno = 9
fd 31 is losing SIGWINCH support
299e5a38: [<0805bd72>] dump_stack+0x22/0x24
299e5a50: [<0809734b>] free_irq+0x116/0x11b
299e5a7c: [<0806151a>] free_winch+0x59/0x67
299e5a90: [<08061568>] winch_cleanup+0x16/0x27
299e5aa0: [<0805aaa3>] do_uml_exitcalls+0x13/0x21
299e5aac: [<0805b1e8>] uml_cleanup+0x12/0x19
299e5ab4: [<0805b206>] machine_power_off+0x8/0xf
299e5abc: [<0805b215>] machine_halt+0x8/0xb
299e5ac4: [<0805da1b>] panic_exit+0x47/0x4b
299e5ad4: [<08085871>] notifier_call_chain+0x28/0x3f
299e5af4: [<0808591e>] atomic_notifier_call_chain+0x1f/0x21
299e5b08: [<08076a08>] panic+0x71/0x100
299e5b24: [<080ab350>] vunmap+0x0/0x5f
299e5b40: [<080949dd>] load_module+0x9d/0xbf1
299e5bfc: [<080955a8>] sys_init_module+0x51/0x178
299e5c18: [<0805e3c4>] handle_syscall+0xc8/0xe4
299e5c88: [<0806d949>] userspace+0x2a2/0x3a6
299e5cf0: [<0805e041>] fork_handler+0xe2/0xf0
299e5d20: [<b7fa9420>] 0xb7fa9420

BUG: warning at linux/kernel/irq/manage.c:353/free_irq()
299e5a48: [<0805bd72>] dump_stack+0x22/0x24
299e5a60: [<0809734b>] free_irq+0x116/0x11b
299e5a8c: [<08063235>] close_devices+0x2a/0x84
299e5aa0: [<0805aaa3>] do_uml_exitcalls+0x13/0x21
299e5aac: [<0805b1e8>] uml_cleanup+0x12/0x19
299e5ab4: [<0805b206>] machine_power_off+0x8/0xf
299e5abc: [<0805b215>] machine_halt+0x8/0xb
299e5ac4: [<0805da1b>] panic_exit+0x47/0x4b
299e5ad4: [<08085871>] notifier_call_chain+0x28/0x3f
299e5af4: [<0808591e>] atomic_notifier_call_chain+0x1f/0x21
299e5b08: [<08076a08>] panic+0x71/0x100
299e5b24: [<080ab350>] vunmap+0x0/0x5f
299e5b40: [<080949dd>] load_module+0x9d/0xbf1
299e5bfc: [<080955a8>] sys_init_module+0x51/0x178
299e5c18: [<0805e3c4>] handle_syscall+0xc8/0xe4
299e5c88: [<0806d949>] userspace+0x2a2/0x3a6
299e5cf0: [<0805e041>] fork_handler+0xe2/0xf0
299e5d20: [<b7fa9420>] 0xb7fa9420




--===============0829793678==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============0829793678==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

--===============0829793678==--
