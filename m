Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BqEdJ-0005Xc-Ct for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 29 Jul 2004 10:23:57 -0700
Received: from vs1.mcgroarty.net ([69.44.158.141] helo=mcg.mcgroarty.net)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:RC4-SHA:128)
	(Exim 4.34) id 1BqEdJ-0007tR-3a
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 29 Jul 2004 10:23:57 -0700
Subject: Re: [uml-devel] help needed for running uml on a sarge
Message-ID: <20040729172344.GA32201@mcgroarty.net>
References: <1359.157.182.42.226.1090946399.squirrel@www.csee.wvu.edu>
	<200407272357.02784.a_mulyadi@telkom.net>
	<50485.151.205.59.135.1091030391.squirrel@www.csee.wvu.edu>
	<200407292017.42409.a_mulyadi@telkom.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="huq684BweRXVnRxX"
Content-Disposition: inline
In-Reply-To: <200407292017.42409.a_mulyadi@telkom.net>
From: Brian McGroarty <brian@mcgroarty.net>
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
Date: Thu, 29 Jul 2004 12:23:44 -0500
To: Mulyadi Santosa <a_mulyadi@telkom.net>
Cc: atanugul@csee.wvu.edu, user-mode-linux-devel@lists.sourceforge.net


--huq684BweRXVnRxX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 29, 2004 at 08:17:42PM +0700, Mulyadi Santosa wrote:
>=20
> about your 2nd ext2 image...looks like it's fine.....the only problem , t=
he=20
> image boots into runlevel 5 (X Window mode). Maybe you can do loopback=20
> mounting and manually edit the file /etc/inittab inside the image to boot=
=20
> into runlevel 2 or 3

Don't forget also - you can pass "-s" on the command line to go
single-user, just as you can with a normal kernel.

--huq684BweRXVnRxX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFBCTKg2PBacobwYH4RAo3AAJ41pgAs8nhPv4ifmh+jE9xgwzUZWACfcCEM
WsfYP6ciw9wA9CxkiGcuSRg=
=FR/l
-----END PGP SIGNATURE-----

--huq684BweRXVnRxX--


-------------------------------------------------------
This SF.Net email is sponsored by OSTG. Have you noticed the changes on
Linux.com, ITManagersJournal and NewsForge in the past few weeks? Now,
one more big change to announce. We are now OSTG- Open Source Technology
Group. Come see the changes on the new OSTG site. www.ostg.com
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
