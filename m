Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CQqwO-0000Yh-0D for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 07 Nov 2004 09:35:00 -0800
Received: from [217.204.41.189] (helo=kula.newsnow.net)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.41) id 1CQqwN-0006NK-3j
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 07 Nov 2004 09:34:59 -0800
Received: from r3bh172.chello.upc.cz ([213.220.251.172] helo=[192.168.0.4])
	by kula.newsnow.net with esmtp (Exim 3.35 #1 (Debian))
	id 1CQqwK-0007r6-00
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sun, 07 Nov 2004 17:34:56 +0000
Message-ID: <418E5CA1.90308@praguespringpeople.org>
From: Struan Bartlett <struan@praguespringpeople.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [uml-devel] FYI: Re bug report [ 745826 ] run cat /dev/urandom
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
Date: Sun, 07 Nov 2004 18:34:25 +0100
To: user-mode-linux-devel@lists.sourceforge.net

Posted to SourceForge:

For the record, this is not entirely fixed. I'm running a Debian host
with 2.4.25 kernel and host-skas3-2.4.25.patch, and a Debian
guest with 2.4.27 kernel and uml-patch-2.4.26-3.

In one xterm I ran "while true; do ls -la /dev/*; done" (see
also bug report 617709). In the other, "cat /dev/urandom".
After 5-10 seconds, the 'linux' host process crashes
completely with:

Scheduling in interrupt
Kernel panic: kernel BUG at sched.c:564!

In interrupt handler - not syncing
 <6>SysRq : Show Regs

EIP: 0023:[<400e4b38>] CPU: 0 Not tainted ESP: 002b:bffffc68
EFLAGS: 00000246
    Not tainted
EAX: ffffffda EBX: 00000001 ECX: 0804cdf0 EDX: 00001000
ESI: 00001000 EDI: 0804cdf0 EBP: bffffc88 DS: 002b ES: 002b
Call Trace: [<a0010e5f>] [<a00cae60>] [<a018db51>]
[<a018dade>] [<a000dc93>] 
   [<a00cade9>] [<a00b526f>] [<a0010e5f>] [<a001d2ec>]
[<a012d637>] [<a017561e>] 
   [<a0010e5f>] [<a017561e>] [<a0010405>] [<a00103f1>]
[<a0010e5f>] [<a000d965>] 
   [<a017561e>] [<a0175616>] [<a00b26ec>] [<a00bd0d1>]
[<a0015e2f>] [<a00bd268>] 
   [<a00e1fc4>] [<a00b4caf>] [<a00e0057>] [<a00c32d5>]
[<a00b4caf>] [<a00c3a6a>] 
   [<a012f024>] [<a00c42e2>] [<a00b2816>] [<a00b2855>]
[<a00b277e>] [<a00c3035>] 
   [<a00c8bc0>] [<a001622f>] [<a001a8e3>] [<a0016153>]
[<a001607b>] [<a0016037>] 
   [<a00b26ec>] [<a0015de1>] [<a0015dcf>] [<a00ada41>]
[<a00ada52>] [<a00b3dfe>] 
   [<a00b4108>] [<a00bb278>] [<a00bb211>] [<a00bb211>]
[<a00bb278>] [<a00b4bed>] 
   [<a00b4ba8>] [<a012ef38>] [<a014639d>] [<a014639d>]
[<a012ef38>] [<a00c8db0>] 
   [<a00bb56e>] [<a00bb3e0>] [<a00bb7f0>] [<a00b0404>]
[<a00bb7f0>] [<a00bb304>] 
   [<a0053f2f>] [<a00bb64c>] [<a00ab920>] [<a00b0404>]
[<a00bb3d4>] [<a00c8c7b>] 
   [<a00bb304>] [<a00bb458>] [<a00bb59c>] [<a00bb64c>]
[<a012f024>] [<a00bb59c>] 
   [<a00bb3d4>] [<a00b0404>] [<a00bb64c>] [<a00bb458>]
[<a00bb59c>] [<a00bb59c>] 
   [<a00b597f>] [<a00b2855>] [<a00bb458>] [<a00be776>]
[<a00be776>] [<a00be81d>] 
   [<a0146380>] [<a00b0658>] [<a00be81d>] [<a00e031b>]
[<a00e05d6>] [<a00bb59c>] 
   [<a00e1458>] [<a00bb637>] [<a00e0057>] [<a00e0057>]
[<a00c3a29>] [<a00c32d5>] 
   [<a00c5f3d>] [<a00c5e11>] [<a00c0e91>] [<a00c5d50>]
[<a0033e1a>] [<a00bad8e>] 
   [<a00b35bb>] [<a00b36e3>] [<a00baddc>] [<a00badd3>]
[<a00b9fb5>] [<a00ba0bd>] 
   [<a00b01ba>] [<a00ba31a>] [<a00b26ec>] [<a00baa87>]
[<a00baa71>] [<a012ef38>] 
   [<a012efd1>] 



-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
