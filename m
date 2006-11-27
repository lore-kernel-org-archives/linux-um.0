Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GoX0b-000808-RU for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 26 Nov 2006 19:18:18 -0800
Received: from [218.104.33.231] (helo=centecnetworks.com)
	by mail.sourceforge.net with smtp (Exim 4.44) id 1GoX0Y-00010Q-JW
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 26 Nov 2006 19:18:17 -0800
Received: from [127.0.0.1] ([218.104.33.229])
	(envelope-sender <qmiao@centecnetworks.com>)
	by 192.168.25.7 with ESMTP
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Mon, 27 Nov 2006 11:18:46 +0800
Message-ID: <456A58ED.9000106@centecnetworks.com>
Date: Mon, 27 Nov 2006 11:18:05 +0800
From: Miao Qingjun <qmiao@centecnetworks.com>
MIME-Version: 1.0
Subject: [uml-devel] UML crash by SIG_BUS
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1534305653=="
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: user-mode-linux-devel@lists.sourceforge.net

--===============1534305653==
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: 7bit

Hi,

my uml is often crashed by SIG_BUS.

Can anybody help me resolve this problem?

The host is 2.6.12fc3-skas3-v9-pre7.
And here is a list of error messages:

Kernel panic - not syncing: Kernel mode signal 7

EIP: 0073:[<400007e2>] CPU: 0 Not tainted ESP: 007b:bff001cc EFLAGS:
00200246
Not tainted
EAX: ffffffda EBX: 4014b008 ECX: 0003dd75 EDX: 0804a008
ESI: 00000001 EDI: 00000000 EBP: bff00238 DS: 007b ES: 007b
09be3828: [<080712c1>] show_regs+0xed/0x10f
09be3844: [<0805da00>] panic_exit+0x2c/0x4b
09be3854: [<08085871>] notifier_call_chain+0x28/0x3f
09be3874: [<0808591e>] atomic_notifier_call_chain+0x1f/0x21
09be3888: [<08076a08>] panic+0x71/0x100
09be38a4: [<0805d2a5>] bus_handler+0x0/0x56
09be38c4: [<0806e352>] sig_handler_common_skas+0xc2/0xfd
09be38e8: [<0806a615>] sig_handler+0x2f/0x4c
09be3900: [<b7f0a420>] 0xb7f0a420
09be3bf4: [<2983f016>] _init_XXX+0x16/0x21 [XXX]
09be3bfc: [<08095665>] sys_init_module+0x10e/0x178
09be3c18: [<0805e3c4>] handle_syscall+0xc8/0xe4
09be3c88: [<0806d949>] userspace+0x2a2/0x3a6
09be3cf0: [<0805e041>] fork_handler+0xe2/0xf0
09be3d20: [<b7f0a420>] 0xb7f0a420




--===============1534305653==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============1534305653==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

--===============1534305653==--
