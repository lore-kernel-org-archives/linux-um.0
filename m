Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EGhS9-0003Lq-Vr	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 17 Sep 2005 11:30:21 -0700
Received: from mail.nagafix.co.uk ([213.228.237.37])
	by mail.sourceforge.net with esmtp (Exim 4.44)	id 1EGhS9-0000c6-0b
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 17 Sep 2005 11:30:22 -0700
Subject: Re: [uml-devel] testing: 2.6.13 to 2.6.14-rc1 TT boot hangs early
	(sometimes)
From: Antoine Martin <antoine@nagafix.co.uk>
In-Reply-To: <200509171741.30694.blaisorblade@yahoo.it>
References: <1126653933.3769.45.camel@localhost>
	 <200509162124.42522.blaisorblade@yahoo.it>
	 <1126901562.17715.9.camel@localhost>
	 <200509171741.30694.blaisorblade@yahoo.it>
Content-Type: text/plain
Message-Id: <1126982040.1169.17.camel@localhost>
Mime-Version: 1.0
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
Date: Sat, 17 Sep 2005 19:34:00 +0100
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: UML devel <user-mode-linux-devel@lists.sourceforge.net>, Jeff Dike <jdike@addtoit.com>

> Sorry, was talking about UML. But I assume it locks up. Was SMP enabled? In 
> that case, there's a couple of things in -bs1 (just published) which may help 
> it.
Initial testing reveals (one just one x86 box so far), that the kernel
stops booting right after:
Checking PROT_EXEC mmap in /tmp...OK
only when using:
2.6.12-bs11
2.6.13-bs1
but not using 2.6.12-bb12

Hope that helps...
Antoine




-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
