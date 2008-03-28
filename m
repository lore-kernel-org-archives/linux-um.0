Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JfNJ5-0002n8-V8 for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 28 Mar 2008 15:44:20 -0700
Received: from mail.nagafix.co.uk ([194.145.196.85])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1JfNJ4-0006XG-IM
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 28 Mar 2008 15:44:19 -0700
Received: from [192.168.2.100] (77-103-4-42.cable.ubr02.camd.blueyonder.co.uk
	[77.103.4.42])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: antoine@nagafix.co.uk)
	by mail.nagafix.co.uk (Postfix) with ESMTP id 1F393439A6
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Fri, 28 Mar 2008 22:44:09 +0000 (GMT)
Message-ID: <47ED74B8.8060602@nagafix.co.uk>
Date: Fri, 28 Mar 2008 22:44:08 +0000
From: Antoine Martin <antoine@nagafix.co.uk>
MIME-Version: 1.0
Subject: [uml-devel] syscall failed
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
To: UML devel <user-mode-linux-devel@lists.sourceforge.net>

FYI: (skas4 host)

[43492659.840000] syscall_stub_done : ret = -12, offset = 548682067984,
data = 000000007f115010
[43492659.840000] syscall_stub_done : syscall 9 failed, return value =
0xfffffff4, expected return value = 0x47a0000
[43492659.840000]     syscall parameters: 0x47a0000 0x1000 0x7 0x11 0x3
0xc4c9000
[43492659.840000] Failed to flush page for address 0x47a0000
[43531234.700000] syscall_stub_done : ret = -12, offset = 548682067984,
data = 000000007f6a8010
[43531234.700000] syscall_stub_done : syscall 9 failed, return value =
0xfffffff4, expected return value = 0x4e9e2000
[43531234.700000]     syscall parameters: 0x4e9e2000 0x1000 0x7 0x11 0x3
0x1db9c000
[43531234.700000] Failed to flush page for address 0x4e9e2000
[43580225.490000] syscall_stub_done : ret = -12, offset = 548682067984,
data = 000000007f7ca010
[43580225.490000] syscall_stub_done : syscall 9 failed, return value =
0xfffffff4, expected return value = 0x6178000
[43580225.490000]     syscall parameters: 0x6178000 0x1000 0x7 0x11 0x3
0x8d02000
[43580225.490000] Failed to flush page for address 0x6178000
[43604789.740000] line_write_room: tty0: no room left in buffer
[43607449.300000] syscall_stub_done : ret = -12, offset = 548682067984,
data = 000000007f0d2010
[43607449.300000] syscall_stub_done : syscall 9 failed, return value =
0xfffffff4, expected return value = 0x514b4000
[43607449.300000]     syscall parameters: 0x514b4000 0x1000 0x7 0x11 0x3
0x1157d000
[43607449.300000] Failed to flush page for address 0x514b4000

-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://ad.doubleclick.net/clk;164216239;13503038;w?http://sf.net/marketplace
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
