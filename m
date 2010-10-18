Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <toralf.foerster@gmx.de>) id 1P7nfr-00041y-QB
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 18 Oct 2010 11:14:39 +0000
Received: from mailout-de.gmx.net ([213.165.64.23] helo=mail.gmx.net)
	by sog-mx-3.v43.ch3.sourceforge.com with smtp (Exim 4.69)
	id 1P7nfp-00025o-6F for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 18 Oct 2010 11:14:39 +0000
From: Toralf =?iso-8859-1?q?F=F6rster?= <toralf.foerster@gmx.de>
Date: Mon, 18 Oct 2010 13:14:26 +0200
References: <201010131328.06465.toralf.foerster@gmx.de>
	<201010181105.17077.toralf.foerster@gmx.de>
	<AANLkTi=UyWg6PUrE_jEs0oqZ_tVw1mMQsoUrDnnqtcHa@mail.gmail.com>
In-Reply-To: <AANLkTi=UyWg6PUrE_jEs0oqZ_tVw1mMQsoUrDnnqtcHa@mail.gmail.com>
MIME-Version: 1.0
Message-Id: <201010181314.27780.toralf.foerster@gmx.de>
Subject: Re: [uml-devel] Fwd: Re: UML kernel crash of v2.6.36-rcX kernel
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
To: richard -rw- weinberger <richard.weinberger@gmail.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Richard Weinberger <richard@nod.at>, Christoph Hellwig <hch@lst.de>, user-mode-linux-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org


richard -rw- weinberger wrote at 11:31:31
> Does this help?
> =

> --- linux-2.6.36-rc8/fs/hostfs/hostfs_user.c.orig       2010-10-18
> 11:24:33.844592000 +0200
> +++ linux-2.6.36-rc8/fs/hostfs/hostfs_user.c    2010-10-18
> 11:24:44.594679000 +0200
> @@ -388,6 +388,6 @@
>         spare_out[1] =3D buf.f_spare[1];
>         spare_out[2] =3D buf.f_spare[2];
>         spare_out[3] =3D buf.f_spare[3];
> -       spare_out[4] =3D buf.f_spare[4];
> +
>         return 0;
>  }

yes - definitely (BTW I like a preceeding "diff --git" line to make the pat=
ch =

utility happy ;) )

-- =

MfG/Kind regards
Toralf F=F6rster

pgp finger print: 7B1A 07F4 EC82 0F90 D4C2 8936 872A E508 7DB6 9DA3


---------------------------------------------------------------------------=
---
Download new Adobe(R) Flash(R) Builder(TM) 4
The new Adobe(R) Flex(R) 4 and Flash(R) Builder(TM) 4 (formerly =

Flex(R) Builder(TM)) enable the development of rich applications that run
across multiple browsers and platforms. Download your free trials today!
http://p.sf.net/sfu/adobe-dev2dev
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

