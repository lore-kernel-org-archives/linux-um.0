Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JHoYe-0003m3-GF for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 23 Jan 2008 14:59:00 -0800
Received: from mail.nagafix.co.uk ([194.145.196.85])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1JHoYb-0000LD-9d
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 23 Jan 2008 14:58:59 -0800
Received: from [192.168.0.6] (80-195-236-49.cable.ubr02.camd.blueyonder.co.uk
	[80.195.236.49])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: antoine@nagafix.co.uk)
	by mail.nagafix.co.uk (Postfix) with ESMTP id 071C643A08
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Wed, 23 Jan 2008 22:58:45 +0000 (GMT)
Message-ID: <4797C6A5.1030408@nagafix.co.uk>
Date: Wed, 23 Jan 2008 22:58:45 +0000
From: Antoine Martin <antoine@nagafix.co.uk>
MIME-Version: 1.0
Subject: [uml-devel] console and do_syscall_stub
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
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: User-mode Linux Kernel Development <user-mode-linux-devel@lists.sourceforge.net>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

[42949466.740000] Failed to open console 12, err = -2
[42949466.740000] Failed to open console 12, err = -2
[42949466.740000] Failed to open console 12, err = -2
[42949466.740000] Failed to open console 12, err = -2
[42949466.740000] Failed to open console 12, err = -2
[42949466.740000] Failed to open console 12, err = -2
[42949466.740000] Failed to open console 12, err = -2
[42949466.740000] Failed to open console 12, err = -2
[42949466.740000] Failed to open console 12, err = -2
[42949466.740000] Failed to open console 12, err = -2
[42949466.740000] do_syscall_stub : ret = -12, offset = 548682067984,
data = 00000000606b1010
[42949466.740000] do_syscall_stub: syscall 9 failed, return value =
0xfffffffffffffff4, expected return value = 0x17c17000
[42949466.740000]     syscall parameters: 0x17c17000 0x1000 0x7 0x11 0x3
0x3e19000
[42949466.740000] Failed to flush page for address 0x17c17000


Linux localhost 2.6.23.12 #5 Tue Dec 25 14:26:58 GMT 2007 x86_64 UML
User Mode Linux GNU/Linux

Any ideas?
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.7 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFHl8alGK2zHPGK1rsRCnm/AJ9HmHmE7vK4RdFamfM/wVmt72qEdQCfcY7s
hXzAKIdkAh7VDZ+BjxsUP8U=
=gd57
-----END PGP SIGNATURE-----

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
