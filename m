Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GjNy1-0002Qp-Eb for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 12 Nov 2006 14:38:21 -0800
Received: from [62.123.212.160] (helo=demachaut.etinarcadiaego.dyndns.org)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1GjNxy-00044e-H6
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 12 Nov 2006 14:38:21 -0800
Date: Sun, 12 Nov 2006 23:43:10 +0100
From: Stefano Melchior <stefano.melchior@openlabs.it>
Message-ID: <20061112224310.GA9721@SteX>
References: <335f7ed41.45513990@default.domain> <20061108081924.GA13080@SteX>
MIME-Version: 1.0
In-Reply-To: <20061108081924.GA13080@SteX>
Subject: Re: [uml-devel] [Pkg-uml-devel] Are you aware to 386945 and lkml
	0609.2/1537.html
Reply-To: stefano.melchior@openlabs.it
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0220350072=="
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: user-mode-linux-devel@lists.sourceforge.net, shaulka@012.net.il
Cc: pkg-uml-devel@lists.alioth.debian.org


--===============0220350072==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ZGiS0Q5IWpPtfppv"
Content-Disposition: inline


--ZGiS0Q5IWpPtfppv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 08, 2006 at 09:19:24AM +0100, Stefano Melchior wrote:
Dear UML developer,
it was reported by Debian users that the new convention in sysvinit
package to prevent shm to be exec breaks some application.
For this moment, I mean in order to allow the upcoming stable release
Etch to be released, the changes to the package were reverted only to
avoid dosemu and u-m-l package related not to be broken.

As mentioned in the following mail [*], it would be possible to provide a
kernel side support for this sysvinit security need: the patch linked at
the

http://uwsg.iu.edu/hypermail/linux/kernel/0609.2/1537.html

can come in help. Would it be possible to manage this issue/need in order
to introduce this patch in the kernel?
What do you think it would be good to fix this issue?

Thank you in advance

SteX

[*]
> On Wed, Nov 08, 2006 at 01:57:36AM +0200, shaulka@012.net.il wrote:
> Dear,
> >   I can't  run rootstrap. I believe the reason is
> >=20
> >     http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D386945
> >=20
> > Just want to make sure you are aware of that.
> >=20
> >   While searching about it, I came across=20
> > http://uwsg.iu.edu/hypermail/linux/kernel/0609.2/1537.html.
>=20
> please, have a look at the #396506 which reported the same question, and
> Mattia answered that it was already fixed in "sysvinit-2.86.ds1-28". This
> should be ready for etch.
> Anyway you cann temporaily add a line in the /etc/fstab such as the
> following:
>=20
> shm             /dev/shm        tmpfs    nodev,nosuid    0       0
>=20
> and mount it.
> Try again rootstrap.
>=20
> Cheers
>=20
> SteX
>=20
> --=20
> Stefano Melchior, GPG key =3D D52DF829 - <stefano.melchior@openlabs.it>
> http://www.openlabs.it/~stex    --     <stefano.melchior@openlabs.it>
> http://etinarcadiaego.dyndns.org  --  <ste@etinarcadiaego.dyndns.org>
> Skype ID "stefanomelchior"



> _______________________________________________
> Pkg-uml-devel mailing list
> Pkg-uml-devel@lists.alioth.debian.org
> http://lists.alioth.debian.org/mailman/listinfo/pkg-uml-devel

--=20
Stefano Melchior, GPG key =3D D52DF829 - <stefano.melchior@openlabs.it>
http://www.openlabs.it/~stex    --     <stefano.melchior@openlabs.it>
http://etinarcadiaego.dyndns.org  --  <ste@etinarcadiaego.dyndns.org>
Skype ID "stefanomelchior"

--ZGiS0Q5IWpPtfppv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iQCVAwUBRVejfolnkxrVLfgpAQJ+TAP/bIzkIw1UU98cSLE4Ch+n0Joky6SDWV/h
SnmLAKpkslEdJTsl0xjBd3w4bsPBGQRHPe7GBrqnOk/ADHJ/FW7Hceddmdatg3Qq
FKPSIawqjNhwafcdyf2AHVVZtShY57qlZeUrH1Afo9l8baqjw7eWnLmP5jlAD0uZ
+rwy2kjp7f4=
=A9KI
-----END PGP SIGNATURE-----

--ZGiS0Q5IWpPtfppv--


--===============0220350072==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--===============0220350072==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

--===============0220350072==--
