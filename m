Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Dnl2D-0001Wz-FX	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 29 Jun 2005 15:27:57 -0700
Received: from imap.gmx.net ([213.165.64.20] helo=mail.gmx.net)
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.41)
	id 1Dnl2C-0002Jb-F9	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 29 Jun 2005 15:27:57 -0700
Received: from luthien by zitrone.obstwiese with local (Exim 4.50)
	id 1Dnkjq-0000ic-8z	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 30 Jun 2005 00:08:58 +0200
From: Dominik Vogt <dominik.vogt@gmx.de>
Subject: Re: [uml-devel] Kernel panic in dump fpu with 2.6.11.11
Message-ID: <20050629220858.GA2709@gmx.de>
Reply-To: dominik.vogt@gmx.de
References: <6028.1119969442@www81.gmx.net> <42C169D0.50206@tuxrocks.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="opJtzjQTFsWo+cga"
Content-Disposition: inline
In-Reply-To: <42C169D0.50206@tuxrocks.com>
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
Date: Thu, 30 Jun 2005 00:08:58 +0200
To: user-mode-linux-devel@lists.sourceforge.net


--opJtzjQTFsWo+cga
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 28, 2005 at 09:16:32AM -0600, Frank Sorenson wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>=20
> Dominik Vogt wrote:
> > in dump_fpu(), so that copy_fpu_fxsave_tt() is never called.  The
> > application always coredumps in
> >=20
> >   /lib/tls/libc.so.6(__clone+0x5a)[0x4026118a]
> >=20
> > which I guess is part of the threading library in libc.  This
> > crash is 100% reproducable.
>=20
> UML doesn't support TLS yet.  Try disabling it by moving /lib/tls out of
> the way ("mv /lib/tls /lib/tls.disabled" for example).

Ah!  Thanks a lot.  This information saved me a lot of further
debugging.  I didn't even notice I had a /lib/tls directory.  The
application works fine without it.

Ciao

Dominik ^_^  ^_^

 --
Dominik Vogt, dominik.vogt@gmx.de

--opJtzjQTFsWo+cga
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFCwxv6meSprTOr4tgRAvdVAJ9jI3GWgifI/S+M+KtPidxvez+YogCg60r+
KxcT8akC3KyT8oZ2w0NwRN0=
=Ozxo
-----END PGP SIGNATURE-----

--opJtzjQTFsWo+cga--


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
