Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard@nod.at>) id 1SB1Mx-0008K6-Ux
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 23 Mar 2012 10:05:15 +0000
Received: from a.ns.miles-group.at ([95.130.255.143] helo=radon.swed.at)
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1SB1Mr-0001QO-Vb
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 23 Mar 2012 10:05:15 +0000
Message-ID: <4F6C4AC8.8090907@nod.at>
Date: Fri, 23 Mar 2012 11:04:56 +0100
From: Richard Weinberger <richard@nod.at>
MIME-Version: 1.0
References: <201203231101.55668.toralf.foerster@gmx.de>
In-Reply-To: <201203231101.55668.toralf.foerster@gmx.de>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0598630353684308974=="
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
Subject: Re: [uml-devel] kernel 3.3 panics during shutdown of an UML image
To: user-mode-linux-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--===============0598630353684308974==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig6B9D384D4200D6A34F73863D"

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig6B9D384D4200D6A34F73863D
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Am 23.03.2012 11:01, schrieb Toralf F=F6rster:
> Hello,
> tried today the new kernel (just to play with my image) and git htis :
>=20
>  * Bringing down interface lo
>  *   Removing addresses
>  * Stopping syslog-ng ...
> Kernel panic - not syncing: Kernel mode fault at addr 0x0, ip 0x0
>=20
> EIP: 0073:[<40001172>] CPU: 0 Not tainted ESP: 007b:bff09224 EFLAGS: 00=
200246

What shows?
addr2line -v linux 40001172

I'm sure it's something in drivers/line.c...

Thanks,
//richard


--------------enig6B9D384D4200D6A34F73863D
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.18 (GNU/Linux)

iQEcBAEBAgAGBQJPbErOAAoJEN9758yqZn9ey9gH/2RA9+73aqoKfTZiLsLCSSDl
jgfUXWycR7PrxYh5CRNvxMH3NYDWNsO/kDFC4GwpMPUnL3Z7LQkbqDQb/PemzMc2
jCXvlm2RxykvZG1Z1YDEtCgM9efbR4iY6E5v/ptPFWDmcOuWbJdTDCWuKXQepq7v
1z0095SEzpIhCP3+4bENuu3CfvOKRO1GyVFjNkfyVadpo82wDBnWNJhwI5dG7Dq4
4fiq7Ma/p35wZ1hm0V1L9H5VZikTUdeJw6Hgm1+gQJPnjNcV0TZkwV8pS89m2h+x
SWntodK0uyPeQkECsiiYQVzx1VpuVxl8J6zGWTYpp+OiHyJGt16CA64goWVHyD4=
=Us0n
-----END PGP SIGNATURE-----

--------------enig6B9D384D4200D6A34F73863D--


--===============0598630353684308974==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
This SF email is sponsosred by:
Try Windows Azure free for 90 days Click Here 
http://p.sf.net/sfu/sfd2d-msazure
--===============0598630353684308974==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

--===============0598630353684308974==--


