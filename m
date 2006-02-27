Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-list2-b.sourceforge.net ([10.3.1.8]
	helo=sc8-sf-list2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FDm3L-0008NM-DL for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 27 Feb 2006 09:20:55 -0800
In-reply-to: <20060227170826.GA5481@ccure.user-mode-linux.org> (message from
	Jeff Dike on Mon, 27 Feb 2006 12:08:26 -0500)
Subject: Re: [uml-devel] [Announce] mountlo 0.5 - Loopback mounting in
	userspace
References: <E1FDk1G-0004S6-00@dorka.pomaz.szeredi.hu>
	<20060227170826.GA5481@ccure.user-mode-linux.org>
Message-Id: <E1FDm2v-0004gV-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
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
Date: Mon, 27 Feb 2006 18:20:30 +0100
To: jdike@addtoit.com
Cc: fuse-devel@lists.sourceforge.net, user-mode-linux-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org

> > I'm proud to announce a new version of my pet project 'mountlo', a
> > utility which works similarly to 'mount -o loop', but the filesystem
> > runs entirely in userspace.
> > 
> > While arguably it is quite useless, I like it because it combines some
> > of my favorite technologies (Linux, UML and FUSE) with very little
> > additional glue code.
> 
> Very cute.  I'm in the process of doing something similar, except I'm
> integrating a FUSE server into the UML kernel to export the UML
> filesystem to the host.  So far, I can cd and ls inside the mount -
> lookup and readdir are implemented.

Great.  I always wanted to do the exporting inside the kernel, but put
it off as being too hard :)

Miklos


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
