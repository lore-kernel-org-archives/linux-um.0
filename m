Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BwSnY-0008RR-Kx for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 15 Aug 2004 14:44:16 -0700
Received: from mail.scgiservices.com ([198.107.3.67])
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.34) id 1BwSnX-0001QY-QB
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 15 Aug 2004 14:44:16 -0700
Received: from SCG2 (c-67-160-159-191.client.comcast.net [67.160.159.191])
	(using TLSv1 with cipher RC4-MD5 (128/128 bits))
	(No client certificate requested)
	by mail.scgiservices.com (Postfix) with ESMTP id F0B272A3B2
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sun, 15 Aug 2004 14:44:14 -0700 (PDT)
From: "Anthony Brock" <brocka@sterlingcgi.com>
Subject: RE: [uml-devel] SKAS on AMD 64-Bit
Message-ID: <LEEIJGBJEEABAGOFFGAHKEHLCBAA.brocka@sterlingcgi.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
In-Reply-To: <s1136e9c.066@ORANGE.OUS.EDU>
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
Date: Sun, 15 Aug 2004 14:44:12 -0700
To: user-mode-linux-devel@lists.sourceforge.net

Given a lack of responses to my inquiry, I've attempted to migrate the
existing patches to the "arch/i386" and "include/asm-i386" directories to
the corresponding "arch/x86_64" and "include/asm-x86_64" directories.

However, I am experiencing the following issue during boot of a previously
functional guest UML when I use the new Host Kernel:

Checking for the skas3 patch in the host...found
Checking for /proc/mm...found
Linux version 2.6.7-1um (root@vs1) (gcc version 3.3.3 (SuSE Linux)) #2 Thu
Jul 29 08:57:53 PDT 2004
On node 0 totalpages: 122880
  DMA zone: 122880 pages, LIFO batch:16
  Normal zone: 0 pages, LIFO batch:1
  HighMem zone: 0 pages, LIFO batch:1
Built 1 zonelists

*** OUTPUT TRIMMED ***

kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Kernel panic: kernel BUG at mm/mmap.c:700!


Any ideas? How would I generate a backtrace for this issue?

I am attaching a copy of the non-functional patch. This patch applies
against a vanilla 2.6.7 kernel with host-skas3-2.6.7-v1.patch pre-applied
(in other words, it's a patch to the SKAS3 patch). Thanks in advance!

Tony



-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
