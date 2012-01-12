Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard@nod.at>) id 1RlRN9-0006qA-H8
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 12 Jan 2012 20:35:43 +0000
Received: from a.ns.miles-group.at ([95.130.255.143] helo=radon.swed.at)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1RlRN4-0002P2-Jl
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 12 Jan 2012 20:35:43 +0000
Message-ID: <4F0F440E.2020102@nod.at>
Date: Thu, 12 Jan 2012 21:35:26 +0100
From: Richard Weinberger <richard@nod.at>
MIME-Version: 1.0
References: <201201111314.32937.toralf.foerster@gmx.de>
	<CAFLxGvwXtinKJSFeD=-YjT9oLuhFSK_0HASjTD_3ib531RxbAA@mail.gmail.com>
	<201201122130.37127.toralf.foerster@gmx.de>
In-Reply-To: <201201122130.37127.toralf.foerster@gmx.de>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0406468721966332020=="
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
Subject: Re: [uml-devel] current kernel (git version
 linux-v3.2-6100-ge343a89) crashes
To: "user-mode-linux-devel@lists.sourceforge.net" <user-mode-linux-devel@lists.sourceforge.net>
Cc: toralf.foerster@gmx.de

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--===============0406468721966332020==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig6F96648C9412965CDCED5FA3"

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig6F96648C9412965CDCED5FA3
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi!

Am 12.01.2012 21:30, schrieb Toralf F=F6rster:
>=20
> richard -rw- weinberger wrote at 13:19:34
>> 2012/1/11 Toralf F=F6rster <toralf.foerster@gmx.de>:
>>> Hello,
>>>
>>> with a recent kernel (pre-rc1) I realized this crash and wondering
>>
>>> whether it is worth to bisect or if there's already a fix flying arou=
nd :
>> Could be this one:
>> http://marc.info/?l=3Dlinux-kernel&m=3D132616456304183&w=3D2
>> http://marc.info/?l=3Dlinux-kernel&m=3D132616483904249&w=3D2

These two are the solution to it.

> No, rather this :
>=20
> tfoerste@n22 ~/devel/linux $ git bisect good
> ccbc60d3e19a1b6ae66ca0d89b3da02dde62088b is the first bad commit
> commit ccbc60d3e19a1b6ae66ca0d89b3da02dde62088b
> Author: Ben Hutchings <ben@decadent.org.uk>
> Date:   Thu Nov 24 07:04:39 2011 +0000
>=20
>     topology: Provide CPU topology in sysfs in !SMP configurations
>    =20
>     We should provide topology information to userland even if it's not=

>     very interesting.  The current code appears to work properly for !S=
MP
>     (tested on i386).
>    =20
>     Reference: http://bugs.debian.org/649216
>     Reported-by: Marcus Osdoba <marcus.osdoba@googlemail.com>
>     Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
>     Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
>=20
> :040000 040000 35e6984434f296f290d34ed09e7b01803b43eaea=20
> 12d103589fd05d970d9ac75fd16ad2afc433ac95 M      drivers
>=20
>=20
> ?

Yes, this commit is causing the bug.

Thanks,
//richard


--------------enig6F96648C9412965CDCED5FA3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.18 (GNU/Linux)

iQEcBAEBAgAGBQJPD0QSAAoJEN9758yqZn9ekiwH/0HmRxBkjYxIeXYfghEJ8wTe
G1WlCsVYCZgCqGB8apFX5h0+6i9s6XSctZ6nl1gRyk85GB6ihvB1hUKmMr6MpLqg
yYlC7e3mncN1/tWydTfk19A0dNUHlU8RtncpbB/W1vKXzZZuW7np0dB8oPOI6Vau
/KFTGswaEhHVlMkX3OvrVw5S77NOjYqCBpKTRRyFg39R0783L8iORledpW5TqD6r
H+3YeNYEMd8W8gyS2/hZPuw5KL/2+1yWYbufpheUt7ayWREnUDMMc41RCG3ZO84Y
OSv1VcYG31D2AK+izZE6YGyyQzttNuiRbfS1Qzbw85tAswIC9Z4PeGlT5sUFeRQ=
=TfWA
-----END PGP SIGNATURE-----

--------------enig6F96648C9412965CDCED5FA3--


--===============0406468721966332020==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
RSA(R) Conference 2012
Mar 27 - Feb 2
Save $400 by Jan. 27
Register now!
http://p.sf.net/sfu/rsa-sfdev2dev2
--===============0406468721966332020==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

--===============0406468721966332020==--


