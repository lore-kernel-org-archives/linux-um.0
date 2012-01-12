Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <toralf.foerster@gmx.de>) id 1RlRIM-0003UA-HJ
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 12 Jan 2012 20:30:46 +0000
Received: from mailout-de.gmx.net ([213.165.64.23])
	by sog-mx-2.v43.ch3.sourceforge.com with smtp (Exim 4.76)
	id 1RlRIL-0002AD-9t for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 12 Jan 2012 20:30:46 +0000
From: Toralf =?iso-8859-1?q?F=F6rster?= <toralf.foerster@gmx.de>
Date: Thu, 12 Jan 2012 21:30:36 +0100
References: <201201111314.32937.toralf.foerster@gmx.de>
	<CAFLxGvwXtinKJSFeD=-YjT9oLuhFSK_0HASjTD_3ib531RxbAA@mail.gmail.com>
In-Reply-To: <CAFLxGvwXtinKJSFeD=-YjT9oLuhFSK_0HASjTD_3ib531RxbAA@mail.gmail.com>
MIME-Version: 1.0
Message-Id: <201201122130.37127.toralf.foerster@gmx.de>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
Subject: Re: [uml-devel] current kernel (git version
	linux-v3.2-6100-ge343a89) crashes
To: richard -rw- weinberger <richard.weinberger@gmail.com>
Cc: user-mode-linux-devel@lists.sourceforge.net


richard -rw- weinberger wrote at 13:19:34
> 2012/1/11 Toralf F=F6rster <toralf.foerster@gmx.de>:
> > Hello,
> > =

> > with a recent kernel (pre-rc1) I realized this crash and wondering
> =

> > whether it is worth to bisect or if there's already a fix flying around=
 :
> Could be this one:
> http://marc.info/?l=3Dlinux-kernel&m=3D132616456304183&w=3D2
> http://marc.info/?l=3Dlinux-kernel&m=3D132616483904249&w=3D2
No, rather this :

tfoerste@n22 ~/devel/linux $ git bisect good
ccbc60d3e19a1b6ae66ca0d89b3da02dde62088b is the first bad commit
commit ccbc60d3e19a1b6ae66ca0d89b3da02dde62088b
Author: Ben Hutchings <ben@decadent.org.uk>
Date:   Thu Nov 24 07:04:39 2011 +0000

    topology: Provide CPU topology in sysfs in !SMP configurations
    =

    We should provide topology information to userland even if it's not
    very interesting.  The current code appears to work properly for !SMP
    (tested on i386).
    =

    Reference: http://bugs.debian.org/649216
    Reported-by: Marcus Osdoba <marcus.osdoba@googlemail.com>
    Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
    Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

:040000 040000 35e6984434f296f290d34ed09e7b01803b43eaea =

12d103589fd05d970d9ac75fd16ad2afc433ac95 M      drivers


?
-- =

MfG/Sincerely
Toralf F=F6rster
pgp finger print: 7B1A 07F4 EC82 0F90 D4C2 8936 872A E508 7DB6 9DA3

---------------------------------------------------------------------------=
---
RSA(R) Conference 2012
Mar 27 - Feb 2
Save $400 by Jan. 27
Register now!
http://p.sf.net/sfu/rsa-sfdev2dev2
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

