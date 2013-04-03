Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <pbutler@pt.com>) id 1UNFWX-0005Ba-BI
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 03 Apr 2013 04:42:13 +0000
Received: from ottawa.pt.com ([209.217.107.194] helo=ottgw.pt.com)
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1UNFWV-00058R-VI for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 03 Apr 2013 04:42:13 +0000
Received: from notes4.pt.com (notes4.corp.pt.com [10.81.15.15])
	by ottgw.pt.com (Postfix) with ESMTP id 698C342531
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Tue,  2 Apr 2013 23:12:48 -0400 (EDT)
Message-ID: <45722.173.206.176.149.1364962278.squirrel@webmail3.pt.com>
Date: Wed, 3 Apr 2013 00:11:18 -0400 (EDT)
From: "Peter Butler" <pbutler@pt.com>
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
Subject: [uml-devel] BUG: failure at
	block/blk-core.c:2985/blk_flush_plug_list()
To: user-mode-linux-devel@lists.sourceforge.net

Running UML from vanilla kernel 3.8.5 compiled with default kernel
configuration and booted with Fedora 18 root fs (as downloaded from
http://fs.devloop.org.uk/).  Boots fine about 3/4 of the time, the rest of
the time it crashes - see output below for an example.



command line:

./linux ubd0=Fedora18-AMD64-root_fs rw mem=4096M con0=fd:0,fd:1



source code BUG() line:

BUG_ON(plug->magic != PLUG_MAGIC);



console output:

.
.
.
.
[  OK  ] Started Load Random Seed.
[  OK  ] Started Configure read-only root support.
[  OK  ] Started udev Coldplug all Devices.
         Starting udev Wait for Complete Device Initialization...
         Starting Show Plymouth Boot Screen...
BUG: failure at block/blk-core.c:2985/blk_flush_plug_list()!
Kernel panic - not syncing: BUG!
Call Trace:
15f4a7d70:  [<6024769a>] panic+0x145/0x2a7
15f4a7da8:  [<60247555>] panic+0x0/0x2a7
15f4a7de8:  [<602477fc>] printk+0x0/0xa0
15f4a7e60:  [<600182c0>] _init+0x7e0/0x8b0
15f4a7e80:  [<6018ae95>] blk_flush_plug_list+0x19f/0x260
15f4a7ec0:  [<6004678f>] sigsuspend+0x0/0x9e
15f4a7ed0:  [<600182c0>] _init+0x7e0/0x8b0
15f4a7ef0:  [<6024bb90>] schedule+0x6a/0x78
15f4a7f00:  [<6004532e>] set_current_blocked+0x17/0x19
15f4a7f10:  [<600467eb>] sigsuspend+0x5c/0x9e
15f4a7f30:  [<6001e726>] winch_thread+0x204/0x242
15f4a7fd0:  [<6001e522>] winch_thread+0x0/0x242


Modules linked in: autofs4
Pid: 1598706048, comm:  Not tainted 3.8.5
RIP: 6c28:[<000000015f4a5818>]
RSP: 0000000000000000  EFLAGS: 16096d530
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 000000015f4a53a8 RSI: 000000015f4a53a8 RDI: 000000015f4a53b8
RBP: 0000000000000000 R08: 0000000000000000 R09: 000000015f4a5380
R10: 000000015f4a5380 R11: 0000000000000001 R12: 0000000c00000000
R13: 0000000015b9ad10 R14: 00000000515ba557 R15: 0000000015b9ad10
Call Trace:
15f4a7cc8:  [<6006bba2>] __module_text_address+0x14/0x5a
15f4a7ce0:  [<6001c4af>] panic_exit+0x3a/0x58
15f4a7cf0:  [<6004e962>] __kernel_text_address+0x30/0x5c
15f4a7d10:  [<60056554>] notifier_call_chain+0x32/0x5c
15f4a7d38:  [<600182c0>] _init+0x7e0/0x8b0
15f4a7d50:  [<6005658e>] __atomic_notifier_call_chain+0x10/0x12
15f4a7d60:  [<600565a6>] atomic_notifier_call_chain+0x16/0x18
15f4a7d70:  [<602476cd>] panic+0x178/0x2a7
15f4a7da8:  [<60247555>] panic+0x0/0x2a7
15f4a7de8:  [<602477fc>] printk+0x0/0xa0
15f4a7e60:  [<600182c0>] _init+0x7e0/0x8b0
15f4a7e80:  [<6018ae95>] blk_flush_plug_list+0x19f/0x260
15f4a7ec0:  [<6004678f>] sigsuspend+0x0/0x9e
15f4a7ed0:  [<600182c0>] _init+0x7e0/0x8b0
15f4a7ef0:  [<6024bb90>] schedule+0x6a/0x78
15f4a7f00:  [<6004532e>] set_current_blocked+0x17/0x19
15f4a7f10:  [<600467eb>] sigsuspend+0x5c/0x9e
15f4a7f30:  [<6001e726>] winch_thread+0x204/0x242
15f4a7fd0:  [<6001e522>] winch_thread+0x0/0x242




------------------------------------------------------------------------------
Minimize network downtime and maximize team effectiveness.
Reduce network management and security costs.Learn how to hire 
the most talented Cisco Certified professionals. Visit the 
Employer Resources Portal
http://www.cisco.com/web/learning/employer_resources/index.html
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

