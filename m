Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1FzkGi-00061d-Ip for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 09 Jul 2006 18:09:00 -0700
Received: from nemesis.fprintf.net ([66.134.112.218])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1FzkGh-0008OK-0z
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 09 Jul 2006 18:09:00 -0700
From: Daniel Gryniewicz <dang@gentoo.org>
Date: Sun, 09 Jul 2006 21:08:35 -0400
Message-Id: <1152493715.28826.13.camel@athena.fprintf.net>
Mime-Version: 1.0
Subject: [uml-devel] UML fails to build with CONFIG_MK7 set
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1991829245=="
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: user-mode-linux-devel <user-mode-linux-devel@lists.sourceforge.net>


--===============1991829245==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-tHP8Vuf2ZlElP5US4VnL"


--=-tHP8Vuf2ZlElP5US4VnL
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi, all.

I got a bug report (http://bugs.gentoo.org/show_bug.cgi?id=3D138536) about
UML 2.6.16-bs2 failing to build.  I've checked it out, and it fails to
build because CONFIG_MK7 is set, which sets CONFIG_X86_USE_3DNOW, which
causes asm/arch/string.h to pull in asm/mmx.h, which doesn't exist
(because it's in asm/arch/mxx.h, this being UML).  The obvious solution
is to symlink it in, but this raises another question:

How useful are the various arch settings when building UML?  Does it
actually make a difference if I build with K7 rather than i686?  If so,
this should probably be fixed.  If not, the options to select ARCHES
should probably be removed when configuring UML.

Daniel

--=-tHP8Vuf2ZlElP5US4VnL
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.4-ecc0.1.6 (GNU/Linux)

iD8DBQBEsaiTomPajV0RnrERAq+sAKCDqI/58N/3+PtkYmJsFdnkXVYG5gCdFoG8
2VW4oGrjPxJHg4w5uVGa1Nw=
=chCu
-----END PGP SIGNATURE-----

--=-tHP8Vuf2ZlElP5US4VnL--



--===============1991829245==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642

--===============1991829245==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

--===============1991829245==--

