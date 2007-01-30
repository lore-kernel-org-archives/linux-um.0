Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HBxqL-0001ff-Gx for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 30 Jan 2007 10:36:33 -0800
Received: from mail.nagafix.co.uk ([194.145.196.85])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HBxqF-0006iB-DK
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 30 Jan 2007 10:36:30 -0800
Received: from [192.168.0.6] (82-45-188-29.cable.ubr02.camd.blueyonder.co.uk
	[82.45.188.29])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.nagafix.co.uk (Postfix) with ESMTP id 2080843B1E
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Tue, 30 Jan 2007 18:36:16 +0000 (GMT)
Message-ID: <45BF901F.40206@nagafix.co.uk>
Date: Tue, 30 Jan 2007 18:36:15 +0000
From: Antoine Martin <antoine@nagafix.co.uk>
MIME-Version: 1.0
Subject: [uml-devel] do_syscall_stub: syscall 9 failed
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

Just caught this in `dmesg`

[42977596.520000] Adding 131064k swap on /dev/ubdb.  Priority:-1 
extents:1 across:131064k
[42980169.290000] do_syscall_stub : ret = -12, offset = 548682067984, 
data = 0000000060b16010
[42980169.290000] do_syscall_stub: syscall 9 failed, return value = 
0xfffffffffffffff4, expected return value = 0x477a000
[42980169.290000]     syscall parameters: 0x477a000 0x1000 0x7 0x11 0x3 
0xad0c000
[42980169.290000] fix_range_common: failed, killing current process

Whilst trying to compile gcc (big beast) on a 64-bit UML instance.
Earlier it had failed and triggered OOM, which is why I added the swap, 
now it may still not have enough (compilation crashed in a similar 
manner) but this time there is no OOM message.

Any ideas what this is?

Cheers
Antoine

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
