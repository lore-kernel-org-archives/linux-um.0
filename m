Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard.weinberger@gmail.com>) id 1VNdWn-0008Lw-Ix
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 22 Sep 2013 06:52:21 +0000
Received: from mail-ve0-f175.google.com ([209.85.128.175])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1VNdWl-0006GG-Tj
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 22 Sep 2013 06:52:21 +0000
Received: by mail-ve0-f175.google.com with SMTP id jy13so1438891veb.20
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sat, 21 Sep 2013 23:52:14 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <52376466.2040601@gmx.de>
References: <52376466.2040601@gmx.de>
Date: Sun, 22 Sep 2013 08:52:14 +0200
Message-ID: <CAFLxGvyw7j_xGpk0F-DLLhxJFEXUjW_Jc0ggKySmRe0NszDAuw@mail.gmail.com>
From: richard -rw- weinberger <richard.weinberger@gmail.com>
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
Subject: Re: [uml-devel] difference of a shell script versus command line
 WRT "winch_thread : TIOCSCTTY failed on fd 1 err = 1"
To: =?ISO-8859-1?Q?Toralf_F=F6rster?= <toralf.foerster@gmx.de>
Cc: UML devel <user-mode-linux-devel@lists.sourceforge.net>

On Mon, Sep 16, 2013 at 10:04 PM, Toralf F=F6rster <toralf.foerster@gmx.de>=
 wrote:
> If I run the following script
>
> $> cat l.sh
> #!/bin/sh
> #
>
> /usr/local/bin/linux-v3.11-8718-g0fb5ca1 earlyprintk ubda=3D/home/tfoerst=
e/virtual/uml/n22unst4 ubdb=3D/mnt/ramdisk/n22unst4_swap eth0=3Dtuntap,tap2=
,72:ef:3d:5d:d3:db mem=3D1025M con0=3Dfd:0,fd:1 con=3Dpts umid=3Duml_n22uns=
t4 rootfstype=3Dext4
>
>
> then during start of the UML I get
>
> ...
> Netdevice 0 (72:ef:3d:5d:d3:db) :
> TUN/TAP backend -
> winch_thread : TIOCSCTTY failed on fd 1 err =3D 1

Hmm, that's a regression introduced by:
commit 250127216dd6635f5730752d7444bdec992aecb0
Author: Richard Weinberger <richard@nod.at>
Date:   Sun Aug 18 13:30:09 2013 +0200

    um: Run UML in it's own session.

    If UML is not run by a shell it can happen that UML
    will kill unrelated proceses upon a fatal exit because
    it issues a kill(0, ...).
    To prevent such oddities we create a new session in main().

    Reported-and-tested-by: Richard W.M. Jones <rjones@redhat.com>
    Signed-off-by: Richard Weinberger <richard@nod.at>


The winch-thread also has it's own session, this seems to be to an issue.

-- =

Thanks,
//richard

---------------------------------------------------------------------------=
---
LIMITED TIME SALE - Full Year of Microsoft Training For Just $49.99!
1,500+ hours of tutorials including VisualStudio 2012, Windows 8, SharePoint
2013, SQL 2012, MVC 4, more. BEST VALUE: New Multi-Library Power Pack inclu=
des
Mobile, Cloud, Java, and UX Design. Lowest price ever! Ends 9/22/13. =

http://pubads.g.doubleclick.net/gampad/clk?id=3D64545871&iu=3D/4140/ostg.cl=
ktrk
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

