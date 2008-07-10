Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KH02a-0007Xz-V3 for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 10 Jul 2008 10:34:51 -0700
Received: from mail.gmx.net ([213.165.64.20])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1KH02a-000064-79
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 10 Jul 2008 10:34:48 -0700
From: Toralf =?iso-8859-1?q?F=F6rster?= <toralf.foerster@gmx.de>
Date: Thu, 10 Jul 2008 19:34:29 +0200
References: <200807101619.54052.toralf.foerster@gmx.de>
	<20080710165811.GA18429@c2.user-mode-linux.org>
In-Reply-To: <20080710165811.GA18429@c2.user-mode-linux.org>
MIME-Version: 1.0
Message-Id: <200807101934.33636.toralf.foerster@gmx.de>
Subject: Re: [uml-devel] UML kernel failed to start betvee 2.6.8-rc8 and
	current git sources
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1768476055=="
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Jeff Dike <jdike@addtoit.com>
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

--===============1768476055==
Content-Type: multipart/signed; boundary="nextPart7463171.7x93uD96zl";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart7463171.7x93uD96zl
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

At Thursday 10 July 2008 18:58:11 Jeff Dike wrote :
> On Thu, Jul 10, 2008 at 04:19:51PM +0200, Toralf F=F6rster wrote:
> > from v2.6.26-rc8 to v2.6.26-rc9-56-g6329d30 sth. affected UML, b/c my u=
ser mode linux kernel produces this :
>=20
> That UML runs fine here.  Did you also upgrade the host kernel between
> rc8 and now?
>=20
Yes, but that's not the reason. The UML crashes both under host kernel
2.6.24-gentoo-r8 and 2.6.25-gentoo-r6. The last (available) working UML ker=
nel
is linux-v2.6.26-rc8-227 (tested under host kernel 2.6.25-gentoo-r6).

=2D-=20
MfG/Sincerely

Toralf F=F6rster
pgp finger print: 7B1A 07F4 EC82 0F90 D4C2 8936 872A E508 7DB6 9DA3

--nextPart7463171.7x93uD96zl
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkh2SCkACgkQhyrlCH22naMjTwCgqfwm5tDOy6N5qLQ+0NYgnHnD
l/sAoL074J3w1fI1wkVDU7MoRXuxopI+
=07pG
-----END PGP SIGNATURE-----

--nextPart7463171.7x93uD96zl--


--===============1768476055==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Sponsored by: SourceForge.net Community Choice Awards: VOTE NOW!
Studies have shown that voting for your favorite open source project,
along with a healthy diet, reduces your potential for chronic lameness
and boredom. Vote Now at http://www.sourceforge.net/community/cca08
--===============1768476055==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

--===============1768476055==--

