Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FIRX2-0000Di-6m for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 12 Mar 2006 06:26:52 -0800
Received: from s93.xrea.com ([218.216.67.44])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1FIRX0-0007ay-Nx
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 12 Mar 2006 06:26:52 -0800
Message-Id: <200603121426.AA00812@bbb-jz5c7z9hn9y.digitalinfra.co.jp>
From: Jun OKAJIMA <okajima@digitalinfra.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: [uml-devel] Sharing code pages between host and guest
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
Date: Sun, 12 Mar 2006 23:26:09 +0900
To: user-mode-linux-devel@lists.sourceforge.net


Hello Jeff, Long time no see.

I am studying now for how you share same content page between host and guest.
In other words, if host and guest use just very same binary of glibc,
then, how to share code pages of glibc (or bash or...).
I think one of the biggest problem of virtualization is memory,
and one common technique to solve it is sharing pages, dont you?

My question is, if you share /lib through HostFS,
can I share code pages of /lib/libc.6.so between host and guest?

                  --- Okajima, Jun. Tokyo, Japan.








-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
