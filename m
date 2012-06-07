Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard@nod.at>) id 1SclUC-0002L4-Tu
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 07 Jun 2012 22:47:24 +0000
Received: from a.ns.miles-group.at ([95.130.255.143] helo=radon.swed.at)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1SclUC-00077R-4M
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 07 Jun 2012 22:47:24 +0000
Message-ID: <4FD12F74.7040001@nod.at>
Date: Fri, 08 Jun 2012 00:47:16 +0200
From: Richard Weinberger <richard@nod.at>
MIME-Version: 1.0
References: <4FD1164B.6060307@gmail.com> <4FD11C88.6090308@nod.at>
	<4FD11F90.5080407@gmail.com> <4FD1263B.5070208@nod.at>
	<4FD12E3D.7050401@gmail.com>
In-Reply-To: <4FD12E3D.7050401@gmail.com>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============6146558929274465156=="
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
Subject: Re: [uml-devel] [PATCH] um: pass siginfo to guest process
To: =?ISO-8859-1?Q?Martin_P=E4rtel?= <martin.partel@gmail.com>
Cc: "user-mode-linux-devel@lists.sourceforge.net" <user-mode-linux-devel@lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--===============6146558929274465156==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig6393B6849624D49855788F0C"

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig6393B6849624D49855788F0C
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Am 08.06.2012 00:42, schrieb Martin P=E4rtel:
> Oh, darn, indeed. Well, getting si_code right fixed my immediate proble=
m, but I might look at this again some time next week unless you've fixed=
 it
> yourself by then. Thanks!
>=20

I can wait for your patch.
No need to hurry. :)

Thanks,
//richard


--------------enig6393B6849624D49855788F0C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.18 (GNU/Linux)

iQEcBAEBAgAGBQJP0S90AAoJEN9758yqZn9eS50H+wRL7x7sZQJI9vO+K+VtkzQM
SoDwQLxythvUMdSlt6PUPhCT3qMBgXwDPoFWg1GdAwQ9ep/G6gI3vJF40lKcZRfo
R/ZLpkeYCtIeiQgnjPFJoEoPObpzG0el3hYHTpyewEdX1B+kdr8WytQwlEbhlVy+
2ZgD76pIazbqKE+QKNcDGDJ0paLzNbVpzlFHSsgYwzn7BBHOtQe6F48/GEhfWCbI
BKGI3wwdsUFZlH8XBqAecghvFBGZ3xKPunKOK5mK6U6JJbZkJDyRVlVg7cTT99kC
UjRerVlpOW50QhGKxOC0of19jPueWK9CkOpiZb5T2740EvP40LplLVUUsuJDWZc=
=jPBm
-----END PGP SIGNATURE-----

--------------enig6393B6849624D49855788F0C--


--===============6146558929274465156==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
--===============6146558929274465156==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

--===============6146558929274465156==--


