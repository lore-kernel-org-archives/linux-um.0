Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard@nod.at>) id 1TN1l7-0005a0-1p
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 13 Oct 2012 13:28:05 +0000
Received: from a.ns.miles-group.at ([95.130.255.143] helo=radon.swed.at)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1TN1l5-00025b-D7
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 13 Oct 2012 13:28:05 +0000
Message-ID: <50796C57.9070303@nod.at>
Date: Sat, 13 Oct 2012 15:27:51 +0200
From: Richard Weinberger <richard@nod.at>
MIME-Version: 1.0
References: <14846952.alsA7bkick@vault01>
In-Reply-To: <14846952.alsA7bkick@vault01>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============7454682084094902370=="
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
Subject: Re: [uml-devel] linux-3.6.x ARCH=um will not build
To: "Dave Humphreys (Bob)" <dave@bob-the-boat.me.uk>
Cc: user-mode-linux-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--===============7454682084094902370==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig7C3C7DA56DA266AA48298CDB"

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig7C3C7DA56DA266AA48298CDB
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Am 13.10.2012 15:13, schrieb Dave Humphreys (Bob):
> Apologies if this repeats any previous attempts made by me: problems wi=
th=20
> something called 'gmane'
>=20
> =3D=3D=3D
>  ...
>   CC      arch/um/os-Linux/signal.o
> arch/um/os-Linux/signal.c:18:8: error: conflicting types for 'sig_info'=

> /nfs4xp/software/krn/linux-3.6.x/linux-3.6.2-um64/arch/um/include/share=
d/as-
> layout.h:64:15: note: previous declaration of 'sig_info' was here
>=20
> I get the above error when trying to build both linux-3.6 and linux-3.6=
=2E2 in=20
> both x86 (gcc-4.7.2) and x86_64 (gcc-4.6.3) environments.
>=20
> Since both files involved in the conflict are part of the source distri=
bution,=20
> I don't think that it can be a fault with my environment; but then I do=
n't=20
> understand why it obviously works for others.
>=20
> arch/um/os-Linux/signal.c:18:8
> arch/um/include/shared/as-layout.h:64:15

Already known and fixed. :)
http://www.spinics.net/lists/mm-commits/msg91703.html

Thanks,
//richard


--------------enig7C3C7DA56DA266AA48298CDB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.18 (GNU/Linux)

iQEcBAEBAgAGBQJQeWxbAAoJEN9758yqZn9eoDAIALh85762AV6/92LQXt/Hd53i
5g5bneHbOOjc55VGCHBn2x+DW8C9+xomMaL4TyTroTR/j4AvFVr/MnwKcV1Q7rv2
3GHsMwyZHuxcB53v0atqX0Myw1d5omOJGPBLp6Hl3KezxCqRMqMZV0eCInCt+xLy
l6bgqi6Og2Aw9KFtJRBWp/2uOvWymVe2NP0E3sr4KxBFww8WHTqrXgAQT8wMdiXr
Y+fLUEOzzg0Xh5whceaLXltOWikE7rmO07S5l7eSz5AhmtVDK7SHVd/wqBtOr3Zi
MQ/UTRglNEDRq9K5HzkZgNs12cCytCBhlLPPIDLVRxteNzFaxHOCiDTh9gtX79Y=
=X2Zu
-----END PGP SIGNATURE-----

--------------enig7C3C7DA56DA266AA48298CDB--


--===============7454682084094902370==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Don't let slow site performance ruin your business. Deploy New Relic APM
Deploy New Relic app performance management and know exactly
what is happening inside your Ruby, Python, PHP, Java, and .NET app
Try New Relic at no cost today and get our sweet Data Nerd shirt too!
http://p.sf.net/sfu/newrelic-dev2dev
--===============7454682084094902370==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

--===============7454682084094902370==--


