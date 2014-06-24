Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <toralf.foerster@gmx.de>) id 1WzXhj-0005Q8-3x
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 24 Jun 2014 20:52:35 +0000
Received: from mout.gmx.net ([212.227.17.21])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1WzXhg-0006uL-Vm
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 24 Jun 2014 20:52:34 +0000
Received: from [192.168.178.21] ([78.54.143.120]) by mail.gmx.com (mrgmx102)
	with ESMTPSA (Nemesis) id 0MUCTO-1X8n841UnK-00R47Y for
	<user-mode-linux-devel@lists.sourceforge.net>; Tue, 24 Jun 2014 22:52:26
	+0200
Message-ID: <53A9E509.4020103@gmx.de>
Date: Tue, 24 Jun 2014 22:52:25 +0200
From: =?UTF-8?B?VG9yYWxmIEbDtnJzdGVy?= <toralf.foerster@gmx.de>
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
Subject: [uml-devel] was is the max. memory for a 32 bit UML decreased ?
To: UML devel <user-mode-linux-devel@lists.sourceforge.net>

IIRC in former times I could assign an UML instance 2047M, but nowadays
even 2044M is too big.

FWIW my host and guest are both 32 bit Gentoo Linux, I do use kernel
3.15.1 for the host system and latest git tree kernel for the UML guest.

-- 
Toralf


------------------------------------------------------------------------------
Open source business process management suite built on Java and Eclipse
Turn processes into business applications with Bonita BPM Community Edition
Quickly connect people, data, and systems into organized workflows
Winner of BOSSIE, CODIE, OW2 and Gartner awards
http://p.sf.net/sfu/Bonitasoft
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

