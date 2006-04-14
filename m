Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FUXVg-0002gr-Lm for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 14 Apr 2006 16:15:28 -0700
Received: from main.gmane.org ([80.91.229.2] helo=ciao.gmane.org)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1FUXVf-000175-2C
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 14 Apr 2006 16:15:28 -0700
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1FUXVa-0000jy-Tt for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 15 Apr 2006 01:15:22 +0200
Received: from dslb-084-061-142-114.pools.arcor-ip.net ([84.61.142.114])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sat, 15 Apr 2006 01:15:22 +0200
Received: from skoehler by dslb-084-061-142-114.pools.arcor-ip.net with local
	(Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sat, 15 Apr 2006 01:15:22 +0200
From: =?ISO-8859-1?Q?Sven_K=F6hler?= <skoehler@upb.de>
Message-ID: <e1pae6$21m$1@sea.gmane.org>
References: <OJEEKGNKKDLJIEPBEJMIIEPCCAAA.brocka@sterlingcgi.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigE4B7F932F60E8CF09BC1CE5E"
In-Reply-To: <OJEEKGNKKDLJIEPBEJMIIEPCCAAA.brocka@sterlingcgi.com>
Subject: [uml-devel] Re: TLS, Debian and 2.6.16.5
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
Date: Sat, 15 Apr 2006 01:15:15 +0200
To: user-mode-linux-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigE4B7F932F60E8CF09BC1CE5E
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

> I'm in the process of setting up a new Debian box that needs a decent s=
ource
> of entropy. So, I have downloaded and installed a relatively new UML ke=
rnel:
>=20
> www:/usr/share/doc/rng-tools# uname -a
> Linux www.myserver.com 2.6.16.5 #1 Fri Apr 14 11:44:51 PDT 2006 i686
> GNU/Linux
>=20
> I then downloaded and installed the rng-tools package. Unfortunately, t=
his
> software segments everything I try to use it. However, when I rename
> /lib/tls to /lib/tls.disabled the issue disappears. Are the TLS patches=
 for
> UML included in this kernel? If not, is there a stable set of patches t=
o add
> it?

2.6.17 includes TLS support.

My Gentoo had some problems with iptables, so i had to revert to 2.6.16.


--------------enigE4B7F932F60E8CF09BC1CE5E
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.1 (Cygwin)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEQC0D7Ww7FjRBE4ARAvCPAKDl9tUXm1qb1xuO2RotEcrfDN2P7wCghsuS
k+HxeVyv0mAeyNptK6+hB9k=
=EGsO
-----END PGP SIGNATURE-----

--------------enigE4B7F932F60E8CF09BC1CE5E--



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
