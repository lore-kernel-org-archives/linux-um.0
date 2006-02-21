Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FBanV-0007Y2-Pb for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 21 Feb 2006 08:55:33 -0800
Received: from [212.34.199.38] (helo=etinarcadiaego.dyndns.org)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1FBanT-0002xO-9V
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 21 Feb 2006 08:55:34 -0800
From: Stefano Melchior <stefano.melchior@openlabs.it>
Subject: Re: [uml-devel] "Configuring network interfaces...execvp of 'uml_net'
	failed - errno = 2" error msg
Message-ID: <20060221165108.GD9131@SteX>
Reply-To: stefano.melchior@openlabs.it
References: <20060217115152.GA17278@SteX>
	<200602171307.51262.blaisorblade@yahoo.it>
	<20060217134755.GA17720@SteX>
	<200602171505.29505.blaisorblade@yahoo.it>
	<20060221110240.GA8285@SteX> <20060221161450.GZ28322@alcor.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ieNMXl1Fr3cevapt"
Content-Disposition: inline
In-Reply-To: <20060221161450.GZ28322@alcor.net>
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
Date: Tue, 21 Feb 2006 17:51:08 +0100
To: Matt Zimmerman <mdz@debian.org>
Cc: Andreas Schuldei <andreas@schuldei.org>, pkg-uml-devel@lists.alioth.debian.org, user-mode-linux-devel@lists.sourceforge.net


--ieNMXl1Fr3cevapt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 21, 2006 at 08:14:50AM -0800, Matt Zimmerman wrote:
Hi Matt,
> On Tue, Feb 21, 2006 at 12:02:40PM +0100, Stefano Melchior wrote:
> > Once discovered the issue and find the workaround [1], I am wondering w=
hy,
> > if you moved uml_net from /usr/bin to /usr/lib/uml/, you left the other
> > uml_* executable on the first dir.
>=20
> This was to comply with the FHS:
>=20
> http://www.pathname.com/fhs/pub/fhs-2.3.html
>=20
> uml_net is not intended to be executed by a user, only invoked as an
> auxiliary program by UML itself.
>=20
> I discussed this with Jeff at the time, and he agreed that it should move,
> but never moved it upstream apparently.
>=20
> I patched the Debian UML sources to match.
>=20
> > Is it worthy to move all of them to /usr/lib/uml/?
>=20
> No, see above.

Ok, I understood, thank you.
On the Makefile of uml_net source, and I read:

BIN_DIR ?=3D /usr/bin

If Jeff, Paolo and the UML devel team all agree, we can patch it and
transform the line in:

BIN_DIR ?=3D /usr/lib/uml

The same with uml_switch, isn't it?
Do you agree?

Cheers

SteX
--=20
Stefano Melchior, GPG key =3D D52DF829 - <stefano.melchior@openlabs.it>
http://etinarcadiaego.dyndns.org    --     http://www.stex.name
Skype ID "stefanomelchior"

--ieNMXl1Fr3cevapt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iQCVAwUBQ/tE/IlnkxrVLfgpAQJguAQAuhNpOB9EHOjrMM8lxOMyV1x8j6a3Tu5T
Fk/WctzGQy5fH0pa+24EEn+tl/anVe4TCVzRT7EkUlzMLrOHF+4ENl/uKdaqnsbR
ESUm9N774+EEMrGlX+umkz6iwN4cGpCyIDIUvChLyaDfGZ+xSPF3ODiCF31nvdvR
4cSuArjo0CE=
=gdVI
-----END PGP SIGNATURE-----

--ieNMXl1Fr3cevapt--


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
