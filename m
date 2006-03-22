Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
From: Stefano Melchior <stefano.melchior@openlabs.it>
Subject: Re: [uml-devel] memory option crashes the uml bootstrap phase
Message-ID: <20060322110400.GA6861@SteX>
Reply-To: stefano.melchior@openlabs.it
References: <20060321142624.GA18505@SteX> <20060321145054.GB18505@SteX>
	<200603211954.08891.blaisorblade@yahoo.it>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="cNdxnHkX5QqsyA0e"
Content-Disposition: inline
In-Reply-To: <200603211954.08891.blaisorblade@yahoo.it>
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
Date: Wed, 22 Mar 2006 12:04:00 +0100
To: user-mode-linux-devel@lists.sourceforge.net
Cc: user-mode-linux-user@lists.sourceforge.net


--cNdxnHkX5QqsyA0e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 21, 2006 at 07:54:08PM +0100, Blaisorblade wrote:
Dear all,
>=20
> No, that crash is likely a race condition and the code treats mem=3D256{m=
,M} the=20
> same way.=20
> Verified in arch/um/kernel/physmem.c:uml_mem_setup and lib/cmdline.c:memp=
arse.
>=20
> However, test increasing /proc/sys/vm/max_map_count and disabling=20
> CONFIG_MODE_TT as suggested by Jeff, I've already seen this to fix this=
=20
> problem.
thus the point is if you need to disable TT mode by default, isn't it?
Now user-mode-linux is in debian "unstable" [1] and I need to provide a
config file as default configuration for the pkg: you suggested me to act
this way=20

#
# UML-specific options
#
CONFIG_MODE_TT=3Dn
^^^^^^^^^^^^^^^^
# CONFIG_HOST_2G_2G is not set
CONFIG_KERNEL_HALF_GIGS=3D1
CONFIG_MODE_SKAS=3Dy

and rebuild the bin, didn't you?

Cheers

SteX

[1] http://packages.qa.debian.org/u/user-mode-linux.html

--=20
Stefano Melchior, GPG key =3D D52DF829 - <stefano.melchior@openlabs.it>
http://etinarcadiaego.dyndns.org    --     http://www.stex.name
Skype ID "stefanomelchior"

--cNdxnHkX5QqsyA0e
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iQCVAwUBRCEvIIlnkxrVLfgpAQJtxgQAlTlBFDcDOXHd/FQwu1wBfnIgvG+SjW3P
FkkVNY/gFrBwWE3LZY38w94Eyd5cO5XUuCqLZ5UZhKha3fJ2B2yWhzwdy+K1yJgS
Bo+hjv4DB5Qpcrrbd0WTsqqFgDrQrgjurmeBLgoMf0Blx+euzutbfdUdx3NkR/um
zNyGk+DvdVE=
=Z8EX
-----END PGP SIGNATURE-----

--cNdxnHkX5QqsyA0e--


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
