Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KOhGT-0000x5-QN for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 31 Jul 2008 16:08:58 -0700
Received: from shiva.jussieu.fr ([134.157.0.129])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1KOhGS-0002bM-6Z
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 31 Jul 2008 16:08:57 -0700
Received: from mailhost.aero.jussieu.fr (blizzard.aero.jussieu.fr
	[134.157.176.35])
	by shiva.jussieu.fr (8.14.3/jtpda-5.4) with ESMTP id m6VN8mQ7087792
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Fri, 1 Aug 2008 01:08:48 +0200 (CEST)
Received: from andromede.nanardon (thauvin-tun.aero.jussieu.fr
	[134.157.177.142]) (authenticated bits=0)
	by mailhost.aero.jussieu.fr (8.13.4/8.13.4) with ESMTP id
	m6VN8eAa027557
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Fri, 1 Aug 2008 01:08:41 +0200
From: Olivier Thauvin <nanardon@nanardon.zarb.org>
Date: Fri, 1 Aug 2008 01:08:34 +0200
MIME-Version: 1.0
Message-Id: <200808010108.35145.nanardon@nanardon.zarb.org>
Subject: [uml-devel] Running 32bits code on 64bits kernel-uml
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1310216458=="
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: user-mode-linux-devel@lists.sourceforge.net

--===============1310216458==
Content-Type: multipart/signed; boundary="nextPart2355035.12leBdXeGY";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart2355035.12leBdXeGY
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

I did some tests to run Mandriva distro inside UML and during my test I did=
=20
notice it is impossible to run 32bits inside a 64bits kernel UML. The probl=
em=20
is not related to the host system and as solution it possible to run a 32bi=
ts=20
kernel on a 64bits host system.

However, more and more distribution come with a biarch support, the only=20
32bits application usually mandatory on linux system is lilo or grub,=20
completly useless with UML, but this is problematic in some case.

I never notice in FAQ or documentation this limitation. Is this normal ? Is=
=20
there any plan to remove this limitation ? Is there a technical problem to=
=20
fix this denying to fix this ?

Best regards.

--nextPart2355035.12leBdXeGY
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkiSRfMACgkQk29cDOWzfVBWSACeJRPFbKvQwbIWdBN+OPdcBZa+
uwMAoPAKU1pX9u7FyShP8e1NuGEmgy7q
=vexK
-----END PGP SIGNATURE-----

--nextPart2355035.12leBdXeGY--


--===============1310216458==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
--===============1310216458==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

--===============1310216458==--

