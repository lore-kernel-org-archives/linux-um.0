Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard@nod.at>) id 1RCwAo-0007uL-UU
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 09 Oct 2011 16:24:22 +0000
Received: from a.ns.miles-group.at ([95.130.255.143] helo=radon.swed.at)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1RCwAn-00030c-E7
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 09 Oct 2011 16:24:22 +0000
Message-ID: <4E91CAA9.1070401@nod.at>
Date: Sun, 09 Oct 2011 18:24:09 +0200
From: Richard Weinberger <richard@nod.at>
MIME-Version: 1.0
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============8388815158843220167=="
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
Subject: [uml-devel] Advice to all glibc 2.12 users
To: "user-mode-linux-devel@lists.sourceforge.net" <user-mode-linux-devel@lists.sourceforge.net>, user-mode-linux-user@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--===============8388815158843220167==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig0215B9155377E804C68EDC2A"

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig0215B9155377E804C68EDC2A
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

glibc 2.12's pthread_cond_signal() is broken on UML because it does not
have FUTEX_WAKE_OP.

The issue got fixed in 2.12.2:
http://sourceware.org/ml/libc-alpha/2010-08/msg00019.html

Sadly, some distros (like CentOS 6.0) still ship glibc 2.12.1.
So you have to expect problems when them on top of UML...

Thanks,
//richard


--------------enig0215B9155377E804C68EDC2A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.16 (GNU/Linux)

iQEcBAEBAgAGBQJOkcqtAAoJEN9758yqZn9eR3QIAJWlfg07ZQk0z90IC/62VPYA
pKCECLVNCc2PR6adMG8niELg7rVb+n1+LJS0RleeBZ8scDIUtFRZj/q+1bcQZt3k
ZaKRcqL5uTVV1n/T2pex1ichwWom6AL9GbsgF2HtroIP8B1merzWxMsb7HtKwUSm
nit8xpuTdKbstB9XP08ilP1KBa1UzOJdFUoWKsNL2o3JAQUMObjMvtq4xVtKRNes
jA8Mj1D8oM7PPrNc1seOa3eFfS6C0acShFAH2+0Q4N6xcTb3RZv0pYAuQkiQQPEL
6jNWaK4GNMolWjfmIoF59mSEY1sMcXaEQ85X/Mp/M9elV5Hj3rd+3me8CWDCXZw=
=xUm3
-----END PGP SIGNATURE-----

--------------enig0215B9155377E804C68EDC2A--


--===============8388815158843220167==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
All of the data generated in your IT infrastructure is seriously valuable.
Why? It contains a definitive record of application performance, security
threats, fraudulent activity, and more. Splunk takes this data and makes
sense of it. IT sense. And common sense.
http://p.sf.net/sfu/splunk-d2dcopy2
--===============8388815158843220167==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

--===============8388815158843220167==--


