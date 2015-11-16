Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <vegard.nossum@oracle.com>) id 1ZyGJc-0006NW-Nn
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 16 Nov 2015 09:43:12 +0000
Received: from aserp1040.oracle.com ([141.146.126.69])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1ZyGJb-00034X-QF
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 16 Nov 2015 09:43:12 +0000
From: Vegard Nossum <vegard.nossum@oracle.com>
Message-ID: <5649A525.9010404@oracle.com>
Date: Mon, 16 Nov 2015 10:43:01 +0100
MIME-Version: 1.0
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
Subject: [uml-devel] WARNING: CPU: 0 PID: 908 at
 include/linux/thread_info.h:128 sigsuspend+0xab/0xc0()
To: Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>
Cc: user-mode-linux-devel@lists.sourceforge.net

Hi,

Starting UML like this:

./vmlinux rootfstype=hostfs rw ignore_console_loglevel con=xterm 
init=/bin/bash

Results in unpredictable behaviour, most of the time an xterm flashes on
my screen but the process aborts with only "Aborted" on the console
where I ran the command, sometimes the xterm remains there but frozen,
sometimes the xterm spews this warning non-stop:

[   12.790000] WARNING: CPU: 0 PID: 908 at 
include/linux/thread_info.h:128 sigsuspend+0xab/0xc0()
[   12.790000] CPU: 0 PID: 908 Comm: deferwq Tainted: G        W 
4.2.5+ #37
[   12.790000] Stack:
[   12.790000]  6243fe78 600753f2 6243fe68 00000009
[   12.790000]  00000000 605cc5f4 6243fe88 605cf5a7
[   12.790000]  6243fee8 60040f3d 6243fec8 600511eb
[   12.790000] Call Trace:
[   12.790000]  [<600511eb>] ? sigsuspend+0xab/0xc0
[   12.790000]  [<605cc5f4>] ? printk+0x0/0x94
[   12.790000]  [<60029f0b>] show_stack+0xdb/0x1a0
[   12.790000]  [<600753f2>] ? dump_stack_print_info+0xd2/0xf0
[   12.790000]  [<605cc5f4>] ? printk+0x0/0x94
[   12.790000]  [<605cf5a7>] dump_stack+0x2a/0x2c
[   12.790000]  [<60040f3d>] warn_slowpath_common+0x9d/0xf0
[   12.790000]  [<600511eb>] ? sigsuspend+0xab/0xc0
[   12.790000]  [<605d0030>] ? __schedule+0x0/0x610
[   12.790000]  [<60051140>] ? sigsuspend+0x0/0xc0
[   12.790000]  [<60051140>] ? sigsuspend+0x0/0xc0
[   12.790000]  [<605cc5f4>] ? printk+0x0/0x94
[   12.790000]  [<6004111c>] warn_slowpath_null+0x1c/0x20
[   12.790000]  [<600511eb>] sigsuspend+0xab/0xc0
[   12.790000]  [<6002e7ca>] winch_thread+0x16a/0x250
[   12.790000]  [<605cc5f4>] ? printk+0x0/0x94
[   12.790000]  [<6002e660>] ? winch_thread+0x0/0x250
[   12.790000]
[   12.790000] ---[ end trace 6fe139d6fbc54eb3 ]---

Some (hopefully relevant) bits from my .config:

$ grep 'UML\|PTY\|TTY\|xterm' .config
CONFIG_UML=y
# UML-specific options
CONFIG_UML_X86=y
# UML Character Devices
CONFIG_PTY_CHAN=y
CONFIG_TTY_CHAN=y
CONFIG_CON_CHAN="xterm"
# CONFIG_UML_SOUND is not set
CONFIG_TTY=y
CONFIG_UNIX98_PTYS=y
CONFIG_LEGACY_PTYS=y
CONFIG_LEGACY_PTY_COUNT=256
# CONFIG_TTY_PRINTK is not set
# CONFIG_UML_RANDOM is not set
# CONFIG_UML_WATCHDOG is not set
# UML Network Devices
# CONFIG_UML_NET is not set

Thanks,


Vegard

------------------------------------------------------------------------------
Presto, an open source distributed SQL query engine for big data, initially
developed by Facebook, enables you to easily query your data on Hadoop in a 
more interactive manner. Teradata is also now providing full enterprise
support for Presto. Download a free open source copy now.
http://pubads.g.doubleclick.net/gampad/clk?id=250295911&iu=/4140
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

