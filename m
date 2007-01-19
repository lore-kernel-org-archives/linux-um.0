Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1H7wHn-0001A1-Sf for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 19 Jan 2007 08:08:16 -0800
Received: from nemesis.fprintf.net ([66.134.112.218])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1H7wHg-0006y4-Oh
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 19 Jan 2007 08:08:12 -0800
From: Daniel Gryniewicz <dang@gentoo.org>
In-Reply-To: <45B0A4B7.7050702@nagafix.co.uk>
References: <200701171715.35504.blaisorblade@yahoo.it>
	<45AE684D.7070802@theshore.net> <45AE67C0.5080003@nagafix.co.uk>
	<45AE7DFC.9050704@nagafix.co.uk>  <45B0A4B7.7050702@nagafix.co.uk>
Date: Fri, 19 Jan 2007 11:07:38 -0500
Message-Id: <1169222858.11134.52.camel@athena.fprintf.net>
Mime-Version: 1.0
Subject: Re: [uml-devel] buggy UML AMD64?
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0288879491=="
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Antoine Martin <antoine@nagafix.co.uk>
Cc: user-mode-linux-devel@lists.sourceforge.net


--===============0288879491==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-cfbPVkYjzG3ymgbxP7Wi"


--=-cfbPVkYjzG3ymgbxP7Wi
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2007-01-19 at 11:00 +0000, Antoine Martin wrote:
> Is anyone else having stability problems on AMD64? Or am I the only one=20
> using it?
> Not only is x86 UML broken on AMD64, I am also getting (seemingly)=20
> random crashes running 64-bit UML.
> The Gentoo guests in particular randomly fail to compile code - failing=20
> in completely random places. When you try again, it might work or just=20
> fail later when you run the binary...
> These used to work reliably before so I am not just doing it wrong (as=20
> is often the case ;)
> To summarize, that leaves us with:
> * x86 unable to run kernels 2.6 due to a bug in host >2.6.16
> (and most x86 guests require 2.6 to use latest glibc)
> * amd64 unable to run x86 guests
> * amd64 unable to run amd64 guests reliably
> ...
>=20

I'm the gentoo usermode-sources maintainer, and I run UML almost
exclusively on amd64.  I have, at any given time, from 4 to 20 UMLs
running on my main dev box, most of them 32-bit, and I haven't had any
stability problems.

Is your RAM OK?  Which kernels do you have inside and outside?  How are
you trying to build the 32-bit UMLs?

Daniel

--=-cfbPVkYjzG3ymgbxP7Wi
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.1 (GNU/Linux)

iD8DBQBFsOzKomPajV0RnrERAniSAJ4o9mBXgI5hNuvhWjHMX1TB4xi4eACfYCP+
0eCan9mb26WWxk6ZaNESNks=
=A4lv
-----END PGP SIGNATURE-----

--=-cfbPVkYjzG3ymgbxP7Wi--



--===============0288879491==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============0288879491==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

--===============0288879491==--

