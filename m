Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EPtx6-0004B0-HI	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 12 Oct 2005 20:40:20 -0700
Received: from slartibartfast.pa.net ([66.59.111.182])
	by mail.sourceforge.net with esmtp (Exim 4.44)	id 1EPtx4-0006u2-3s
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 12 Oct 2005 20:40:20 -0700
From: William Stearns <wstearns@pobox.com>
Reply-To: William Stearns <wstearns@pobox.com>
Message-ID: <Pine.LNX.4.64.0510122241080.6495@sparrow>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Subject: [uml-devel] 2.6.14-rc4;
	panic: do_syscall_stub : failed to wait for SIGUSR1/SIGTRAP
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
Date: Wed, 12 Oct 2005 23:39:02 -0400 (EDT)
To: ML-uml-devel <user-mode-linux-devel@lists.sourceforge.net>
Cc: William Stearns <wstearns@pobox.com>

Good evening, all,
 	This is from 2.6.14-rc4 + Jeff's 2 patches:
[PATCH 1/2] UML - Fix Al's build tidying
 	(was there ever a 2/2?  I didn't see one in the list)
UML - Resend - Revert use of host AIO

 	i386 FC3 host has no skas patch, so skas0 is in effect.

md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
VFS: Mounted root (ext2 filesystem) readonly.
Kernel panic - not syncing: do_syscall_stub : failed to wait for 
SIGUSR1/SIGTRAP, pid = 3357, n = 3357, errno = 0, status = 0xb7f


EIP: 0000:[<0000007b>] CPU: 0 Not tainted EFLAGS: 00000000
     Not tainted
EAX: 00000000 EBX: 00000c8c ECX: 00000013 EDX: 00000c8c
ESI: 00000c89 EDI: 0000007b EBP: 00000000 DS: 0025 ES: 4611
14603510:  [<080751ec>] show_regs+0xb0/0xd0
14603530:  [<08062cf7>] panic_exit+0x27/0x48
14603550:  [<08086922>] notifier_call_chain+0x1e/0x3c
14603580:  [<08078e66>] panic+0x56/0xfc
146035a0:  [<08063e57>] wait_stub_done+0x73/0xd0
146035e0:  [<080635c2>] do_syscall_stub+0x62/0x1c8
14603670:  [<080637ce>] run_syscall_stub+0xa6/0xd4
14603690:  [<08063a45>] unmap+0xad/0xd0
14603710:  [<0806529f>] do_ops+0xaf/0xf8
14603750:  [<08061c86>] fix_range_common+0x1d2/0x284
146037d0:  [<0806531f>] fix_range+0x37/0x3c
14603800:  [<080653d8>] force_flush_all_skas+0x34/0x38
14603820:  [<08061f87>] force_flush_all+0xb/0x10
14603830:  [<080634cb>] flush_thread_skas+0xb/0x2c
14603840:  [<0805c76f>] flush_thread+0xb/0x10
14603850:  [<080b8adf>] flush_old_exec+0x2bf/0xae4
146039a0:  [<080d6699>] load_elf_binary+0x33d/0xea0
14603af0:  [<080b9554>] search_binary_handler+0x54/0xf0
14603b30:  [<080b9785>] do_execve+0x195/0x234
14603b70:  [<0805c7b4>] execve1+0x28/0x7c
14603ba0:  [<0805c81d>] um_execve+0x15/0x50
14603bc0:  [<0805c164>] run_init_process+0x40/0x6c
14603bf0:  [<0805c256>] init+0xc6/0x168
14603c10:  [<080714d5>] run_kernel_thread+0x31/0x38
14603cd0:  [<08064d0c>] new_thread_handler+0xb0/0x10c
14603d20:  [<b7fec420>] 0xb7fec420

 	This first kernel didn't have tt support built in, so I recompiled 
with tt support as well and ran it with a mode=tt and it got further:

Enabling local filesystem quotas:  [  OK  ]
swapon: /dev/ubd/1: No such device or address
                                              Enabling swap space:  [  OK 
]
Kernel panic - not syncing: Kernel mode fault at addr 0x66ab, ip 
0xa002f711

 	Cheers,
 	- Bill

---------------------------------------------------------------------------
 	"A computer without a Microsoft operating system is like a dog
without bricks tied to its head."
 	-- Steve on slashdot
--------------------------------------------------------------------------
William Stearns (wstearns@pobox.com).  Mason, Buildkernel, freedups, p0f,
rsync-backup, ssh-keyinstall, dns-check, more at:   http://www.stearns.org
--------------------------------------------------------------------------


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
