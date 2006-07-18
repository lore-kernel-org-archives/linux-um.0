Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1G2ePa-0005NE-6q for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 17 Jul 2006 18:30:10 -0700
Received: from adsl-230-146.dsl.uva.nl ([146.50.230.146] helo=hypnos.var.cx)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1G2ePZ-000479-PO
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 17 Jul 2006 18:30:10 -0700
Date: Tue, 18 Jul 2006 03:30:18 +0200
From: Frank v Waveren <fvw@var.cx>
Message-ID: <20060718013017.GA29457@var.cx>
References: <20060715152343.GA12263@var.cx>
	<200607161231.51516.blaisorblade@yahoo.it>
	<20060716120531.GA20515@var.cx>
	<200607162124.36818.blaisorblade@yahoo.it>
Mime-Version: 1.0
In-Reply-To: <200607162124.36818.blaisorblade@yahoo.it>
Subject: Re: [uml-devel] cap-bound not working in uml
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1522964679=="
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net


--===============1522964679==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Nq2Wo0NMKNjxTN9z"
Content-Disposition: inline


--Nq2Wo0NMKNjxTN9z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 16, 2006 at 09:24:36PM +0200, Blaisorblade wrote:
> On Sunday 16 July 2006 14:05, Frank v Waveren wrote:
> > On Sun, Jul 16, 2006 at 12:31:51PM +0200, Blaisorblade wrote:
> > > On Saturday 15 July 2006 17:23, Frank v Waveren wrote:
> > > > I was trying to limit some unecessary capabilities in a UML instance
> > > > with /proc/sys/kernel/cap-bound, but it turned out not to take.
> > >
> > > To remove capabilities from the whole system (i.e. all processes) the
> > > recommended way wasn't to use lcap (or a similar program bundled with
> > > libcap)?
> >
> > Yup, lcap is just an interface to /proc/sys/kernel/cap-bound.
>=20
> I remember maybe some differences UML specific capabilities code in arch/=
um=20
> (it used to clear some capabilities, i.e. /dev/mem or /dev/kmem access).=
=20
> Check for that...

There used to be (in the tt mode jail support), but it's all gone now
(leaving some undefined prototypes in the headers about jail mode and
such by the way).

Oh well, I'll have to go poke in a live non-UML kernel and see what's
different, I'll keep the list posted.

--=20
Frank v Waveren                                  Key fingerprint: BDD7 D61E
fvw@var.cx                                              5D39 CF05 4BFC F57A
Public key: hkp://wwwkeys.pgp.net/468D62C8              FA00 7D51 468D 62C8

--Nq2Wo0NMKNjxTN9z
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)

iD8DBQFEvDmp+gB9UUaNYsgRAoSKAJ9Tru/VwVeUsUZ8TlUbvMBY9nfheACgh/rB
eYXUYwrL2AMmna/IYGG8yU8=
=MN1Z
-----END PGP SIGNATURE-----

--Nq2Wo0NMKNjxTN9z--


--===============1522964679==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============1522964679==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

--===============1522964679==--
