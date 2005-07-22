Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Dvvoq-0007Qx-RT	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 22 Jul 2005 04:35:56 -0700
Received: from mail.nagafix.co.uk ([213.228.237.37])
	by mail.sourceforge.net with esmtp (Exim 4.44)	id 1Dvvop-0007Lh-MZ
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 22 Jul 2005 04:35:56 -0700
From: antoine <antoine@nagafix.co.uk>
In-Reply-To: <20050721220839.F01B389B90@sc8-sf-spam1.sourceforge.net>
References: <20050721220839.F01B389B90@sc8-sf-spam1.sourceforge.net>
Content-Type: text/plain
Message-Id: <1122032119.13225.9.camel@dhcp-192-168-22-217.internal>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [uml-devel] 2.6.12-bs7 vs 2.6.12-bb8
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
Date: Fri, 22 Jul 2005 12:35:19 +0100
To: UML devel <user-mode-linux-devel@lists.sourceforge.net>, Blaisorblade <blaisorblade@yahoo.it>

Paolo,

I've just stared testing your latest patches on a amd64 box running
2.6.13-rc3-git4, bb8 seems to run (so far) but bs7 comes up with:
./vmlinux mem=128M root=/dev/ubda ubd0=./root_fs
(...)
[42949373.440000] Initializing software serial port version 1
[42949373.440000]  ubda: unknown partition table
[42949373.810000] kjournald starting.  Commit interval 5 seconds
[42949373.810000] EXT3-fs: mounted filesystem with ordered data mode.
[42949373.810000] VFS: Mounted root (ext3 filesystem) readonly.
[42949374.110000] Kernel panic - not syncing: Kernel mode fault at addr
0x0, ip 0x0
[42949374.110000]
[42949374.110000] Modules linked in:
[42949374.110000] Pid: 1, comm: init Not tainted 2.6.12-bs7
[42949374.110000] RIP: 4000:[<0000000000000000>]
[42949374.110000] RSP: 00000000604a7c30  EFLAGS: 00010202
[42949374.110000] RAX: 0000000000000001 RBX: 0000000000000000 RCX:
00000000601a14ea
[42949374.110000] RDX: 00000000600108de RSI: 0000000000000001 RDI:
00000000604a7b00
[42949374.110000] RBP: 0000000000000000 R08: 0000000000000000 R09:
00000000ffffffff
[42949374.110000] R10: 0000000000000008 R11: 0000000000000246 R12:
0000000000000000
[42949374.110000] R13: 0000000000000000 R14: 000000000000000a R15:
0000000000000009
[42949374.110000] Call Trace:
[42949374.110000] 604a7708:  [<600163cf>] panic_exit+0x2f/0x50
[42949374.110000] 604a7728:  [<6004f6eb>] notifier_call_chain+0x2b/0x50
[42949374.110000] 604a7758:  [<6003d104>] panic+0xe4/0x180
[42949374.110000] 604a7798:  [<601a14ea>] sigprocmask+0x4a/0xb0
[42949374.110000] 604a77d8:  [<6001529f>] handle_page_fault+0x9f/0x2b0
[42949374.110000] 604a7848:  [<60015663>] segv+0x1b3/0x270
[42949374.110000] 604a78d8:  [<60012fc1>] change_signals+0x51/0x80
[42949374.110000] 604a7928:  [<60015af9>] segv_handler+0x169/0x1f0
[42949374.110000] 604a7978:  [<6001928a>] sig_handler_common_tt
+0xfa/0x1a0
[42949374.110000] 604a79e8:  [<601a1270>] __restore_rt+0x0/0x10
[42949374.110000] 604a7a78:  [<600108de>] run_kernel_thread+0x2e/0x50
[42949374.110000] 604a7a88:  [<601a14ea>] sigprocmask+0x4a/0xb0
[42949374.110000] 604a7ae8:  [<600108f1>] run_kernel_thread+0x41/0x50
[42949374.110000] 604a7af8:  [<6000d190>] init+0x0/0xf0
[42949374.110000] 604a7b38:  [<600108de>] run_kernel_thread+0x2e/0x50
[42949374.110000] 604a7be8:  [<60017773>] new_thread_handler+0x113/0x130
[42949374.110000] 604a7cd8:  [<601a14ea>] sigprocmask+0x4a/0xb0
[42949374.110000]
[42949374.110000]

I haven't got much time at the moment to help with testing but things
should get back to normal in the next few days.

Thanks
Antoine



-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
