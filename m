Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
From: Stefan Hofmann <sh@luci.de>
In-Reply-To: <1151740200.5540.7.camel@chronos>
References: <1151740200.5540.7.camel@chronos>
Date: Mon, 03 Jul 2006 10:17:45 +0200
Message-Id: <1151914665.5505.7.camel@chronos>
Mime-Version: 1.0
Subject: Re: [uml-devel] [uml-user] Kernel panic - not syncing: Kernel mode
	signal 7	(with 2.6.17.1	and .2)
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
To: user-mode-linux-user@lists.sourceforge.net
Cc: user-mode-linux-devel@lists.sourceforge.net

Am Samstag, den 01.07.2006, 09:49 +0200 schrieb Stefan Hofmann:

Hi *,

> after upgrading my (host + guest) debian system to 2.6.17.2, I often get
> an uml kernel panic like this:

can anyone help me, please? My systems run very dirty and I cannot use
any 2.6.17.x kernels. Am I alone with this problem? Under 2.6.16.20 I
never saw such a kernel panic.

Host kernel is  2.6.17.3-skas3-v9-pre9
Guest kernel is 2.6.17.3 unpatched

TIA & greetings,
stefan


======================================================================
p2p login: Kernel panic - not syncing: Kernel mode signal 7
 
EIP: 0073:[<400f7d18>] CPU: 0 Not tainted ESP: 007b:bfe00998 EFLAGS:
00000246
    Not tainted
EAX: ffffffda EBX: 00000005 ECX: 08074400 EDX: 00001400
ESI: 00001400 EDI: 08074400 EBP: bfe009b8 DS: 007b ES: 007b
0e98f4d8:  [<080853bd>] notifier_call_chain+0x27/0x3e
0e98f4f0:  [<0805b60c>] relay_signal+0x0/0x97
0e98f4f4:  [<080769e7>] panic+0x70/0x102
0e98f50c:  [<0805b6a3>] bus_handler+0x0/0x5b
0e98f528:  [<0806e42a>] sig_handler_common_skas+0x92/0xe1
0e98f548:  [<0806a2d9>] sig_handler+0x35/0x52
0e98f59c:  [<080d76e5>] do_mpage_readpage+0x19f/0x3f0
0e98f5d4:  [<0806327d>] ubd_handler+0xb8/0xba
0e98f618:  [<080fc86f>] blk_remove_plug+0x39/0x6b
0e98f62c:  [<08063284>] ubd_intr+0x5/0xb
0e98f630:  [<080950eb>] handle_IRQ_event+0x4a/0x6e

======================================================================
exterior.moz login: Kernel panic - not syncing: Kernel mode signal 7
 
EIP: 0073:[<4008d026>] CPU: 0 Not tainted ESP: 007b:bfaff1d8 EFLAGS:
00010206
    Not tainted
EAX: 4014b340 EBX: 4014a8c0 ECX: 00002009 EDX: 083ff8a8
ESI: 083fd8a0 EDI: 00008759 EBP: bfaff210 DS: 007b ES: 007b
0bb6f7b8:  [<080853bd>] notifier_call_chain+0x27/0x3e
0bb6f7d0:  [<0805b60c>] relay_signal+0x0/0x97
0bb6f7d4:  [<080769e7>] panic+0x70/0x102
0bb6f7ec:  [<0805b6a3>] bus_handler+0x0/0x5b
0bb6f808:  [<0806e42a>] sig_handler_common_skas+0x92/0xe1
0bb6f828:  [<0806a2d9>] sig_handler+0x35/0x52
0bb6f87c:  [<080a3808>] do_anonymous_page+0x5f/0x15b
0bb6f8a8:  [<0805cb5e>] do_op+0x50/0x54
0bb6f8b8:  [<0805cbd7>] do_buffer_op+0x75/0x152

======================================================================
template-etch.moz login: Kernel panic - not syncing: Kernel mode signal
7
 
EIP: 0073:[<400e59ae>] CPU: 0 Not tainted ESP: 007b:bf79a474 EFLAGS:
00000212
    Not tainted
EAX: ffffffda EBX: 080a7708 ECX: bf79a4f4 EDX: 40157ff4
ESI: 00000006 EDI: 00000087 EBP: bf79a478 DS: 007b ES: 007b
09f374a8:  [<080853bd>] notifier_call_chain+0x27/0x3e
09f374c0:  [<0805b60c>] relay_signal+0x0/0x97
09f374c4:  [<080769e7>] panic+0x70/0x102
09f374dc:  [<0805b6a3>] bus_handler+0x0/0x5b
09f374f8:  [<0806e42a>] sig_handler_common_skas+0x92/0xe1
09f37518:  [<0806a2d9>] sig_handler+0x35/0x52
09f3756c:  [<080b0503>] alloc_slabmgmt+0x27/0x67
09f375a8:  [<0805a350>] um_timer+0x99/0xa6
09f375c8:  [<08072935>] try_to_wake_up+0x90/0xa5

======================================================================
template-sarge.moz login: Kernel panic - not syncing: Kernel mode signal
7
 
EIP: 0073:[<400d1e53>] CPU: 0 Not tainted ESP: 007b:bf828e48 EFLAGS:
00000246
    Not tainted
EAX: ffffffda EBX: 00000006 ECX: 080a9bf8 EDX: 00001000
ESI: 00000000 EDI: 4015d8c0 EBP: bf828e8c DS: 007b ES: 007b
09c176b8:  [<080853bd>] notifier_call_chain+0x27/0x3e
09c176d0:  [<0805b60c>] relay_signal+0x0/0x97
09c176d4:  [<080769e7>] panic+0x70/0x102
09c176ec:  [<0805b6a3>] bus_handler+0x0/0x5b
09c17708:  [<0806e42a>] sig_handler_common_skas+0x92/0xe1
09c17728:  [<0806a2d9>] sig_handler+0x35/0x52
09c1777c:  [<080b0503>] alloc_slabmgmt+0x27/0x67
09c177ac:  [<0809ad30>] __alloc_pages+0x5c/0x31e
09c177c4:  [<080cd2a3>] inode_init_once+0xcd/0xd3
09c177e0:  [<080f1ca8>] init_once+0x22/0x24




Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
