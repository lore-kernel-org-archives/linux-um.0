Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
From: "Catalin(ux aka Dino) BOIE" <util@deuroconsult.ro>
Message-ID: <Pine.LNX.4.61.0412201149350.708@webhosting.rdsbv.ro>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Subject: [uml-devel] [PANIC] 2.6.9-bb4 with 2.6.9-skas3-v7
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
Date: Mon, 20 Dec 2004 11:51:20 +0200 (EET)
To: user-mode-linux-devel@lists.sourceforge.net
Cc: user-mode-linux-user@lists.sourceforge.net

ReiserFS: ubda: using ordered data mode
ReiserFS: ubda: journal params: device ubda, size 512, journal first block 
18, max trans len 256, max batch 225, max commit age 30, max trans age 30
ReiserFS: ubda: checking transaction log (ubda)
ReiserFS: ubda: Using r5 hash to sort names
VFS: Mounted root (reiserfs filesystem) readonly.
Kernel panic - not syncing: Kernel mode fault at addr 0x1e, ip 0x0

EIP: 0073:[<08048100>] CPU: 0 Not tainted ESP: 007b:bfffff20 EFLAGS: 
00000246
     Not tainted
EAX: 00000000 EBX: 00000000 ECX: 00000000 EDX: 00000000
ESI: 00000000 EDI: 00000000 EBP: 00000000 DS: 007b ES: 007b
Call Trace:
  [<0807bed1>] vprintk+0xf1/0x150
  [<080886a6>] notifier_call_chain+0x26/0x40
  [<0807b507>] panic+0x57/0xe0
  [<080669a6>] segv+0x86/0x1f0
  [<08066a80>] segv+0x160/0x1f0
  [<08064f93>] change_signals+0x43/0x80
  [<080b7000>] sys_stat64+0x0/0x40
  [<08066d8c>] segv_handler+0xbc/0xd0
  [<08064ffd>] unblock_signals+0xd/0x20
  [<080693de>] sig_handler_common_skas+0x7e/0xb0
  [<08069405>] sig_handler_common_skas+0xa5/0xb0
  [<08066dc3>] sig_handler+0x13/0x20
  [<08067b3a>] setjmp_wrapper+0x1a/0x60
  [<080b7de8>] flush_old_exec+0x208/0x810
  [<08067b6d>] setjmp_wrapper+0x4d/0x60
  [<080b7de8>] flush_old_exec+0x208/0x810
  [<080b7de8>] flush_old_exec+0x208/0x810
  [<08067b3a>] setjmp_wrapper+0x1a/0x60
  [<08065134>] set_signals+0x74/0x140
  [<08065134>] set_signals+0x74/0x140
  [<080633df>] um_virt_to_phys+0x4f/0x90
  [<080b88ab>] do_execve+0x1cb/0x270
  [<0805bea0>] init+0x0/0x110
  [<08066e43>] do_longjmp+0x13/0x20
  [<0805fa0a>] um_execve+0x4a/0x50
  [<080be6b1>] dupfd+0x41/0x60
  [<0805be7f>] run_init_process+0x2f/0x50
  [<080be78d>] sys_dup+0xd/0x30
  [<0805bf3d>] init+0x9d/0x110
  [<0805bea0>] init+0x0/0x110
  [<08062e6a>] run_kernel_thread+0x3a/0x40
  [<0805bea0>] init+0x0/0x110
  [<08062e4f>] run_kernel_thread+0x1f/0x40
  [<08064ffd>] unblock_signals+0xd/0x20
  [<08078454>] finish_task_switch+0x24/0x70
  [<0805bea0>] init+0x0/0x110
  [<080784b0>] schedule_tail+0x10/0x70
  [<0805bea0>] init+0x0/0x110
  [<08068b14>] new_thread_handler+0x64/0xa0
  [<0805bea0>] init+0x0/0x110

No modules, Slackware 10.
With modules, all is working fine.
I'll try to compile linux with debugging symbols and I will see if I can 
debug the problem.

---
Catalin(ux aka Dino) BOIE
catab at deuroconsult.ro
http://kernel.umbrella.ro/


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
