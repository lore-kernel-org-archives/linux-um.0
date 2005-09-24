Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EJC0F-0003zE-UA	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 24 Sep 2005 08:31:51 -0700
Received: from mail.dravanet.hu ([212.40.69.7])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44)	id 1EJC0C-0003vc-E7
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 24 Sep 2005 08:31:52 -0700
Received: from mail (mail [192.168.69.23])j8OFVUFZ014351
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sat, 24 Sep 2005 17:31:36 +0200
From: Hegedus Gabor <hygylista@jpm.hu>
In-Reply-To: <200509241242.22417.blaisorblade@yahoo.it>
References: <200509241242.22417.blaisorblade@yahoo.it>
Content-Type: text/plain
Message-Id: <1127575895.8538.24.camel@hygyhome>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [uml-devel] x86_64 kernel panic in skas mode
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
Date: Sat, 24 Sep 2005 17:31:35 +0200
To: user-mode-linux-devel@lists.sourceforge.net

Hi!

I have an x86_64 kernel (2.6.13-2) (on a celeron 64bit processor, debian
sarge). I patched it with -v9-pre7. When I start the uml It found the
skas patch, then: 

Unable to load iterpreter
Kernel panic: kernel BUG at memory.c:337!

When I start it with mode=tt, then it starts tt mode successfully.

This guest binary compilled on a 32 bit system, with a 2.4.25 kernel.

I try to compille a 2.6.13-2 guest system, but this is failed too.

bye
  HyGy



-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
