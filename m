Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <toralf.foerster@gmx.de>) id 1XLHYt-0006Ts-7k
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 23 Aug 2014 20:05:19 +0000
Received: from mout.gmx.net ([212.227.17.20])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1XLHYr-0001EQ-AD
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 23 Aug 2014 20:05:19 +0000
Message-ID: <53F8F3F2.7010502@gmx.de>
Date: Sat, 23 Aug 2014 22:05:06 +0200
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
Subject: Re: [uml-devel] [PATCH] UML: UBD: Fix for processes stuck in D
 state forever in UserModeLinux
To: Thorsten Knabe <linux@thorsten-knabe.de>, Richard Weinberger <richard@nod.at>
Cc: UML devel <user-mode-linux-devel@lists.sourceforge.net>

I just applied the patch in http://article.gmane.org/gmane.linux.kernel/1773197 on top of latest git tree of Linus and fuzz tested a 32bit UML - works better than before. I'd say it now hangs less often than before - just a first impression.

-- 
Toralf


------------------------------------------------------------------------------
Slashdot TV.  
Video for Nerds.  Stuff that matters.
http://tv.slashdot.org/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

