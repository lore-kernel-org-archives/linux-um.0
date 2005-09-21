Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EI8V8-0003Sp-2i	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 21 Sep 2005 10:35:22 -0700
Received: from mail.nagafix.co.uk ([213.228.237.37])
	by mail.sourceforge.net with esmtp (Exim 4.44)	id 1EI8V6-0003BX-J9
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 21 Sep 2005 10:35:21 -0700
From: Antoine Martin <antoine@nagafix.co.uk>
In-Reply-To: <20050921034708.E91E31388A@sc8-sf-spam2.sourceforge.net>
References: <20050921034708.E91E31388A@sc8-sf-spam2.sourceforge.net>
Content-Type: text/plain
Message-Id: <1127324098.3977.34.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [uml-devel] Re: User-mode-linux-devel digest, Vol 1 #2054 - 9 msgs
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
Date: Wed, 21 Sep 2005 18:34:58 +0100
To: Majid Salame <msalame@nortel.com>
Cc: user-mode-linux-devel@lists.sourceforge.net, Blaisorblade <blaisorblade@yahoo.it>

> > There's none, but vanilla 2.6.10 has included UML support; I=20
> > wouldn't call=20
> > that trustworthy (especially from the "security" point of view).
> >=20
> > The amount of patches which went in for UML before 2.6.11 was=20
> > released was so=20
> > big, and they were so heavy, I never got around to releasing=20
> > a -bs patch for=20
> > that.
> >=20
> > That said, why do you need 2.6.10?=20
> 
> The kernel in-house we run our apps on is 2.6.10, and therefore I
> would
> like to create a UML based on that.
> Would it possible to provide a bs patch for 2.6.10
If you're talking about the host kernel, you should still be able to use
a 2.6.13+ kernel as guest on a 2.6.10 host.
Running anything older is a foolish (for the guest and only slightly
less so for the host - unless you have many bugfixes backported for that
kernel version by your vendor), you are missing out on numerous bug
fixes and not likely to find a sympathetic ear if you do encounter a
real bug.

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
