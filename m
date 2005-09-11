Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EEQKs-0007VO-Ic	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 11 Sep 2005 04:49:26 -0700
Received: from smtp.osdl.org ([65.172.181.4])
	by mail.sourceforge.net with esmtps (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.44)	id 1EEQKr-0003Bo-CA
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 11 Sep 2005 04:49:26 -0700
From: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <20050911092802.1ab931ac@localhost>
Message-ID: <Pine.LNX.4.58.0509110437120.4912@g5.osdl.org>
References: <20050910174452.907256000@zion.home.lan>
	<20050910174630.063774000@zion.home.lan>
	<20050911092802.1ab931ac@localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Subject: [uml-devel] Re: [patch 7/7] uml: retry host close() on EINTR
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
Date: Sun, 11 Sep 2005 04:49:17 -0700 (PDT)
To: Paolo Ornati <ornati@fastwebnet.it>
Cc: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>, Jeff Dike <jdike@addtoit.com>, LKML <linux-kernel@vger.kernel.org>, user-mode-linux-devel@lists.sourceforge.net



On Sun, 11 Sep 2005, Paolo Ornati wrote:
> 
> So glibc doc is wrong here:

Yes.

> SUSV3:
> -------------------------------------------------------------
> If close() is interrupted by a signal that is to be caught, it shall
> return -1 with errno set to [EINTR] and the state of fildes is
> unspecified
> -------------------------------------------------------------
> 
> Unspecified! ;-)

I don't know of any system where re-trying the close() is the right thing
to do, but I guess they exist. I think the Linux behaviour of "hey, it's
closed, live with it" is pretty universal - almost nobody ever tests the
return value of close().

Even the "careful" users that want to hear about IO errors have to really 
do an fsync(), so any IO errors should show up there. Of course, checking 
the return value of "close()" in addition to the fsync() is always a good 
idea anyway, and I suspect they do.

In Linux, another thread may return with the same fd in open() even _long_
before the close() that released it has even finished. The kernel releases
the fd itself early, and then the rest (anything that could return EINTR -
things like TCP linger stuff etc) is all done with just the "struct file".

So retrying is really really wrong. And not just on Linux. I think this is 
true on _most_  if not all unix implementations out there.

		Linus


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
