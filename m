Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Bqygt-0002wU-Hs for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 31 Jul 2004 11:34:43 -0700
Received: from dns01.mail.yahoo.co.jp ([211.14.15.204])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.34)
	id 1Bqygt-0003j1-1F for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 31 Jul 2004 11:34:43 -0700
Message-ID: <410BE63B.30209@yahoo.co.jp>
From: "shigekazun@yahoo.co.jp" <shigekazun@yahoo.co.jp>
MIME-Version: 1.0
Subject: Re: [uml-devel] 2.6.7-1: ifconfig kernel panic
References: <410BA9E4.9000007@yahoo.co.jp>
In-Reply-To: <410BA9E4.9000007@yahoo.co.jp>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
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
Date: Sun, 01 Aug 2004 03:34:35 +0900
To: "shigekazun@yahoo.co.jp" <shigekazun@yahoo.co.jp>
Cc: user-mode-linux-devel@lists.sourceforge.net

Resolved by 'random' patch.

  kernel-source-2.6.7 <http://packages.debian.org/kernel-source-2.6.7>
+ uml-patch-2.6.7-1 <http://www.user-mode-linux.org/mirror/uml-patch-2.6.7-1.bz2>
+ random <http://user-mode-linux.sf.net/work/2.6/2.6.7-1um/random>

Now 'ifconfig' works fine.

ns:~# ifconfig
eth0      Link encap:Ethernet  HWaddr FE:FD:C0:A8:88:C8
          inet addr:192.168.136.200  Bcast:192.168.136.255  Mask:255.255.255.0
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
          TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000
          RX bytes:0 (0.0 b)  TX bytes:0 (0.0 b)
          Interrupt:5

lo        Link encap:Local Loopback
          inet addr:127.0.0.1  Mask:255.0.0.0
          UP LOOPBACK RUNNING  MTU:16436  Metric:1
          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
          TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:0
          RX bytes:0 (0.0 b)  TX bytes:0 (0.0 b)

Thanks,
--
shigekazun

shigekazun@yahoo.co.jp wrote:
> Hi,
> 
> My environtment are;
> 	host	host-skas3-2.6.7-v1.patch
> 	guest	uml-patch-2.6.7-1.bz2 (with its default defconfig)
> Under the UML guest, simple 'ifconfig' command causes kernel panic.
> uml-patch-2.4.26-2.bz2 was OK with the same environment.
> 
> ns:~# ifconfig
> Kernel panic: Kernel mode fault at addr 0x55, ip 0x400ea414
> In interrupt handler - not syncing
>  <6>SysRq : Show Regs
> 
> EIP: 0073:[<400ea414>] CPU: 0 Not tainted ESP: 007b:bffffb68 EFLAGS: 00000246
>     Not tainted
> EAX: ffffffda EBX: 00000004 ECX: 000089f3 EDX: bffffb90
> ESI: bffffb90 EDI: 000089f3 EBP: bffffbc8 DS: 007b ES: 007b
> Call Trace: [<a00371ca>] [<a001cbdb>] [<a004424d>] [<a00364db>] [<a002f781>]
>    [<a001bf71>] [<a0019cd3>] [<a001c315>] [<a0023c91>] [<a001c425>] [<a020d538>]
>    [<a01b7451>] [<a020d664>] [<a0019e81>] [<a0019cd3>] [<a020d664>] [<a0019e81>]
>    [<a0019cd3>] [<a0031654>] [<a0031731>] [<a0223bb0>] [<a0017730>] [<a00222f0>]
>    [<a0031654>] [<a0022387>] [<a001bc17>] [<a0019e81>] [<a020d664>] [<a0023d66>]
>    [<a001749e>] [<a0023e04>] [<a001749e>] [<a0023e57>] [<a0023f10>] [<a0023fb2>]
>    [<a01c4c91>] [<a0023e04>] [<a0023e57>] [<a01b6f0f>] [<a01c6fc7>] [<a01c5331>]
>    [<a01c7212>] [<a01bd3bf>] [<a007bf0c>] [<a005f6d2>] [<a00236b2>] [<a0019d32>]
>    [<a001aba9>] [<a0023741>] [<a00226aa>] [<a00229e3>] [<a0023340>] [<a00233e1>]
>    [<a020d538>] [<a0023340>] [<a002330d>] [<a0224abd>]




-------------------------------------------------------
This SF.Net email is sponsored by OSTG. Have you noticed the changes on
Linux.com, ITManagersJournal and NewsForge in the past few weeks? Now,
one more big change to announce. We are now OSTG- Open Source Technology
Group. Come see the changes on the new OSTG site. www.ostg.com
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
