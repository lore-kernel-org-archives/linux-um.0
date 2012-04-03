Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <rrs@researchut.com>) id 1SF4DK-0008VG-A6
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 03 Apr 2012 13:56:02 +0000
Received: from mail-ob0-f175.google.com ([209.85.214.175])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1SF4DE-0003Wd-Vn
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 03 Apr 2012 13:56:02 +0000
Received: by obbuo13 with SMTP id uo13so4948830obb.34
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Tue, 03 Apr 2012 06:55:51 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by localhost (Postfix) with ESMTP id 80959420FC0
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Tue,  3 Apr 2012 18:56:54 +0530 (IST)
Message-ID: <4F7AFA9E.5020306@debian.org>
Date: Tue, 03 Apr 2012 18:56:54 +0530
From: Ritesh Raj Sarraf <rrs@debian.org>
MIME-Version: 1.0
References: <E1SEjI8-0007kU-RE@franck.debian.org>
In-Reply-To: <E1SEjI8-0007kU-RE@franck.debian.org>
Reply-To: rrs@debian.org
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============8275971535410045382=="
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
Subject: [uml-devel] UML static linking and embedded library
To: user-mode-linux-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--===============8275971535410045382==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature";
	boundary="------------enigA7F6BEE15608E23963C192F1"

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigA7F6BEE15608E23963C192F1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hello Richard and others,

I currently have 2 severity E(rrors) lintian rejects for the build I am
preparing for Debian.

The details for both the rejects are explained at:

http://lintian.debian.org/tags/binary-or-shlib-defines-rpath.html
http://lintian.debian.org/tags/embedded-library.html


Richard, Is this something that can be worked out upstream?

If there were decisions cautiously made for a reason, I can work it out
with an override to lintian. Just that I want to check out with you guys
first.



Ritesh


-------- Original Message --------
Subject: user-mode-linux_3.2-1um-1_i386.changes REJECTED
Date: Mon, 02 Apr 2012 15:35:36 +0000
From: Debian FTP Masters <ftpmaster@ftp-master.debian.org>
To: Ritesh Raj Sarraf <rrs@debian.org>, User Mode Linux Maintainers
<pkg-uml-pkgs@lists.alioth.debian.org>




Reject Reasons:
user-mode-linux: lintian output: 'binary-or-shlib-defines-rpath
usr/bin/linux.uml /lib', automatically rejected package.
user-mode-linux: If you have a good reason, you may override this
lintian tag.

user-mode-linux: lintian output: 'embedded-library usr/bin/linux.uml:
libpcap', automatically rejected package.
user-mode-linux: If you have a good reason, you may override this
lintian tag.



=3D=3D=3D

Please feel free to respond to this email if you don't understand why
your files were rejected, or if you upload new files which address our
concerns.



--------------enigA7F6BEE15608E23963C192F1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.18 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iQIcBAEBCgAGBQJPevqeAAoJEKY6WKPy4XVpySwP/2P3Z9uoyh7tBsjgn/KzjrC2
lxIPoBzhn5pTXhM+Kp+mRagF2t6BcztQ1zLBUQNOz7v9163jtnPh1hAmdLz3En8X
wmy9XfB3T+S8nvs09eqOnoGvtG91LhWt10XnezO8aQ3CHQij2ELxp8oXiJfcxhv+
ltc+Wz6sQxayxP4Ahm91/Z8D1oGTA71eu3oVOV/Ejcw69JhUE3HAKIICu1jZFzbe
0JO16aKr6rSSc3fykKJhaJlyrCktK09/BT6aVaOaWCC7jq7VjUbFKcWMPLbuquza
AEz2b6zeS6xNc6iquUH7icFB8tubntSNGFJdeWDHNjRk6XqHWKqI05qH2e8qSFQc
ZlONAnSbzuPzOV+gxEPS+r9K3AidTTDgfabOfw0FIYb+5aLTo/qoaMhQig7S54e4
zRyx1bp6uVwTI5ZRPkOVvKm4qnsoGxIzShd5fltZHJwTXrH3pa+yxzWe9RYej5zy
UDqYyhL6FE4/yVN6Ys0aJXKzaAkK7XqPO35fGyAFAanUxLFIZNde9YDUiXN8Jkv6
hEEEXk53tumovMkqdSLFQK64Yk/0eQhRIaq2qwe1f1UsROs17xPYQxrGpGSNZs0A
bHHibJ9gUQDuRVM0RK/aUoSVBmxnsFWiMh/RnnaYIL8cWrCyBgSwXWW+M7Pb/WRv
pt6XgTxh4+k29ZSFaWYo
=pBRh
-----END PGP SIGNATURE-----

--------------enigA7F6BEE15608E23963C192F1--


--===============8275971535410045382==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Better than sec? Nothing is better than sec when it comes to
monitoring Big Data applications. Try Boundary one-second 
resolution app monitoring today. Free.
http://p.sf.net/sfu/Boundary-dev2dev
--===============8275971535410045382==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

--===============8275971535410045382==--


