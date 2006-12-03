Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GqyXU-00005F-OS for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 03 Dec 2006 13:06:20 -0800
Received: from smtp-vbr17.xs4all.nl ([194.109.24.37])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1GqyXT-00088U-4o
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 03 Dec 2006 13:06:20 -0800
Received: from localhost.localdomain (cubeadsl.xs4all.nl [82.92.220.254])
	by smtp-vbr17.xs4all.nl (8.13.8/8.13.8) with ESMTP id kB3L69jr039762
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sun, 3 Dec 2006 22:06:13 +0100 (CET)
	(envelope-from rsnel@cube.dyndns.org)
Date: Sun, 3 Dec 2006 22:06:08 +0100
Message-ID: <20061203210608.GA2704@cube.dyndns.org>
Mime-Version: 1.0
Content-Disposition: inline
From: rsnel@cube.dyndns.org
Subject: [uml-devel] ZONE_DMA and dm_create->init_emergency_isa_pool
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: user-mode-linux-devel@lists.sourceforge.net

Hello,

When I want to create a device mapper table in user-mode-linux, I get 

BUG: failure at mm/bounce.c:85/init_emergency_isa_pool()!
(full stack trace below)

I think this behaviour was introduced by:
[PATCH] uml: get rid of ZONE_DMA use

I got it to work by reversing the patch.

Greetings,

Rik.

Trace:
BUG: failure at mm/bounce.c:85/init_emergency_isa_pool()!
Kernel panic - not syncing: BUG!
 
 EIP: 0073:[<401300c4>] CPU: 0 Not tainted ESP: 007b:bf433948 EFLAGS:
 00000246
     Not tainted
     EAX: ffffffda EBX: 00000003 ECX: c134fd03 EDX: 08050408
     ESI: 400287c0 EDI: 40026180 EBP: bf433a98 DS: 007b ES: 007b
     0901bd78:  [<080686b0>] show_regs+0xb4/0xb9
     0901bda4:  [<0805a4c3>] panic_exit+0x25/0x3f
     0901bdb8:  [<0807b018>] notifier_call_chain+0x1d/0x3c
     0901bdd8:  [<0807b0a7>] atomic_notifier_call_chain+0x11/0x13
     0901bdec:  [<0806f96e>] panic+0x52/0xdd
     0901be0c:  [<0809b91b>] init_emergency_isa_pool+0x4b/0x5d
     0901be28:  [<080f3cbd>] blk_queue_bounce_limit+0x33/0x48
     0901be3c:  [<081106a5>] alloc_dev+0xf4/0x285
     0901be64:  [<081109c1>] dm_create+0xb/0x20
     0901be70:  [<08113205>] dev_create+0x3f/0x9b
     0901be90:  [<08114047>] ctl_ioctl+0xd7/0x10e
     0901beb8:  [<080ae385>] do_ioctl+0x45/0x5a
     0901bed8:  [<080ae717>] vfs_ioctl+0x1ec/0x209
     0901bf00:  [<080ae762>] sys_ioctl+0x2e/0x4c
     0901bf28:  [<0805ac46>] handle_syscall+0x86/0xa0
     0901bf74:  [<08065805>] handle_trap+0xbe/0xc7
     0901bf90:  [<08065bf3>] userspace+0x123/0x166
     0901bfdc:  [<0805a985>] fork_handler+0x74/0x7c
     0901bffc:  [<a55a5a5a>] 0xa55a5a5a

-- 
Nothing is ever a total loss; it can always serve as a bad example.

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
