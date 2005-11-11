Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EafqP-0002BU-9C for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 11 Nov 2005 12:49:57 -0800
Received: from mail.nagafix.co.uk ([194.145.196.85])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1EafqP-0003Ux-4m
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 11 Nov 2005 12:49:57 -0800
From: Antoine Martin <antoine@nagafix.co.uk>
In-Reply-To: <200511111848.01764.blaisorblade@yahoo.it>
References: <1131140395.27405.6.camel@localhost.localdomain>
	<200511111848.01764.blaisorblade@yahoo.it>
Content-Type: text/plain
Message-Id: <1131742176.23542.17.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [uml-devel] Re: 2.6.14-bs1
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
Date: Fri, 11 Nov 2005 20:49:36 +0000
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net, Jeff Dike <jdike@addtoit.com>

> However, I just remembered I have an Ubuntu with GCC 4.0... so I could test 
> the thing.
Or you could use a gentoo chroot. (if you leave it to build overnight..)

> > I've had quite a few problems with 2.6.14 not booting on 2.6.13 and
> > 2.6.14 hosts. (errors have been reported by other users - unfortunately
> > the strace isn't very useful)
> 
> I've not looked deeply at the strace, but I don't see anything much clear.
> 
> Also, I suppose the problem is with SKAS0 and no regression is seen in other 
> modes.
> 
> However, given that you're having this compilation problem (caused by 
> uml-fix-misassembling-skas0-stub-segv, which you can unapply for testing), 
I tried removing this patch (and its sibling ^segv^) but patch -R moaned
at me, and after unmerging it by hand I still got the same error so I
gave up (for now anyway)

> you could test the 32-bit binaries I've built and uploaded on my homepage.
I couldn't find the link (I didn't look very long).

> For at least one people they run better than home-compiled binaries, and 
> there's no report of the opposite.
I'll try that.

I'm currently working on those root_fs images, coming along nicely but
it takes *a lot* of time. I should have something ready within a few
days.

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
