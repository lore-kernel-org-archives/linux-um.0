Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FKP32-0008FC-28 for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 17 Mar 2006 16:12:00 -0800
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]
	helo=grelber.thyrsus.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1FKP30-0000p8-IG
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 17 Mar 2006 16:11:59 -0800
From: Rob Landley <rob@landley.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603171912.12082.rob@landley.net>
Subject: [uml-devel] kernel BUG at drivers/block/loop.c:621
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
Date: Fri, 17 Mar 2006 19:12:11 -0500
To: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

I can reproduce the following in 2.6.16-rc5, User Mode Linux:

kernel BUG at drivers/block/loop.c:621!
Kernel panic - not syncing: BUG!

EIP: 0073:[<ffffe410>] CPU: 0 Not tainted ESP: 007b:b7de1f9c EFLAGS: 00200246
    Not tainted
EAX: 00000000 EBX: 000018be ECX: 00000013 EDX: 000018be
ESI: 000018bb EDI: 00000011 EBP: b7de1fb8 DS: 007b ES: 007b
09b87bb4:  [<0806c762>] show_regs+0x102/0x110
09b87bd0:  [<0805b6fc>] panic_exit+0x2c/0x50
09b87be0:  [<0807ff7d>] notifier_call_chain+0x2d/0x50
09b87c00:  [<08071095>] panic+0x75/0x120
09b87c20:  [<0812e181>] loop_thread+0x151/0x160
09b87c4c:  [<08065297>] run_kernel_thread+0x37/0x60
09b87cfc:  [<0805bbd1>] new_thread_handler+0x91/0xc0
09b87d20:  [<ffffe420>] disks+0xf7e7ec84/0x4

The reproduction sequence is a bit involved (my mount regression test and the 
current svn snapshot of busybox are involved), and running the following 
sequence of commands:

mount; mount -a; mount; mount /dev/loop1 /images/vfat.dir ; 
losetup /dev/loop1; ls; vi /etc/fstab; cat /etc/fstab; losetup /dev/loop0; 
mount /images/vfat.img /images/vfat.dir -o ro

The current busybox mount is still broken in a couple of known places (hence 
the testing; I'm fixing it).  But it probably shouldn't panic the kernel...

Rob
-- 
Never bet against the cheap plastic solution.


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
