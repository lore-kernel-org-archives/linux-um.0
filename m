Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard@nod.at>) id 1T8W9D-0002E9-OJ
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 03 Sep 2012 12:52:59 +0000
Received: from a.ns.miles-group.at ([95.130.255.143] helo=radon.swed.at)
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1T8W99-0003HA-DY
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 03 Sep 2012 12:52:59 +0000
Message-ID: <5044A81B.4080209@nod.at>
Date: Mon, 03 Sep 2012 14:52:43 +0200
From: Richard Weinberger <richard@nod.at>
MIME-Version: 1.0
References: <201209022245.20413.PeterHuewe@gmx.de>
In-Reply-To: <201209022245.20413.PeterHuewe@gmx.de>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0347607080745167525=="
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
Subject: Re: [uml-devel] Emulate I2C subsystem/slaves
To: =?ISO-8859-1?Q?Peter_H=FCwe?= <PeterHuewe@gmx.de>
Cc: user-mode-linux-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--===============0347607080745167525==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig92680F4B337C02581D2A9BEE"

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig92680F4B337C02581D2A9BEE
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Am 02.09.2012 22:45, schrieb Peter H=FCwe:
> I'm curious if there have ever been any attempts to emulate i2c devices=
 under=20
> uml in order to facilitate driver development by using stub drivers.

I know none.

> If there weren't any attemps yet, what to you thing would be the best s=
trategy =20
> to achieve this goal?
> Are there any good starting points?=20
> The main thing I'm lacking is a good idea how to register the 'stub dev=
ices'.

Look at any i2c driver. Implement the i2c driver interface and instead of=
 directly
writing to hardware registers write to something else.
Same for read...
E.g. Your i2c emulator could have a TCP back-end.
Host<->Guest i2c pass-through is also possible.
BTW: All this is not UML specific. Iff it makes sense for only UML we can=

put it into arch/um/drivers/.
Otherwise drivers/ is fine.

> Or is this something that is not really desired by the uml project?

If there is a use case, why not. :-)

Thanks,
//richard


--------------enig92680F4B337C02581D2A9BEE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.18 (GNU/Linux)

iQEcBAEBAgAGBQJQRKggAAoJEN9758yqZn9eRmAIAJvMHTuim5ry0TJgToxmJozS
Mg03M3FAcUJ5HHQDDFLJT1nJ5bdUt0A+p4o5sK+kdY0DlsV+MuwZWd3ktBgY4nzx
2ctxwUZT7SJPU/g4vnWptuLZEk50AcgBwxWv1gseFXYelQaSsiRQPDgbezhXzmOJ
XNetJ7zvsk9+8PzL7rJw9MCeYquxyIcIIM3W6mlPbvOu1ag4v/V3Sy6QpRXgy0GV
CbLhp1S/T8WRdUFasfvjC/HJ0f8mA5t9kI1QgyqeZPQk6zXCQvQXcC0M8QL0fDwY
BMDzfgZvUt0I4KeiPyE82thJSeXsiVSaoKdPdGCspOJQjo/RkyKDkenUhIXi/y0=
=+ZQl
-----END PGP SIGNATURE-----

--------------enig92680F4B337C02581D2A9BEE--


--===============0347607080745167525==
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
--===============0347607080745167525==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

--===============0347607080745167525==--


