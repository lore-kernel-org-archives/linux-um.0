Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard@nod.at>) id 1SB1OV-0008TC-RY
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 23 Mar 2012 10:06:51 +0000
Received: from a.ns.miles-group.at ([95.130.255.143] helo=radon.swed.at)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1SB1OQ-0005f4-B0
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 23 Mar 2012 10:06:51 +0000
Message-ID: <4F6C4B2E.6030702@nod.at>
Date: Fri, 23 Mar 2012 11:06:38 +0100
From: Richard Weinberger <richard@nod.at>
MIME-Version: 1.0
References: <201203231101.55668.toralf.foerster@gmx.de>
	<4F6C4AC8.8090907@nod.at>
In-Reply-To: <4F6C4AC8.8090907@nod.at>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============4772813871614513983=="
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
Subject: Re: [uml-devel] kernel 3.3 panics during shutdown of an UML image
To: user-mode-linux-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--===============4772813871614513983==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigF3C140F397E3430A6980BADE"

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigF3C140F397E3430A6980BADE
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Am 23.03.2012 11:04, schrieb Richard Weinberger:
> Am 23.03.2012 11:01, schrieb Toralf F=F6rster:
>> Hello,
>> tried today the new kernel (just to play with my image) and git htis :=

>>
>>  * Bringing down interface lo
>>  *   Removing addresses
>>  * Stopping syslog-ng ...
>> Kernel panic - not syncing: Kernel mode fault at addr 0x0, ip 0x0
>>
>> EIP: 0073:[<40001172>] CPU: 0 Not tainted ESP: 007b:bff09224 EFLAGS: 0=
0200246
>=20
> What shows?
> addr2line -v linux 40001172

Ups,
addr2line -e ...

Thanks,
//richard


--------------enigF3C140F397E3430A6980BADE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.18 (GNU/Linux)

iQEcBAEBAgAGBQJPbEsuAAoJEN9758yqZn9eWv0H/0O1eldx4MP88PtWkuqim48P
uEGnFnTmFVv+t8vUwlGvn/RjybkVDeNH7wDJI9JEn1fuHfg538AIltf85fu2Nsj0
KgbahmXrQAP+gMTKfyY4ZiiS8cyj5l0ggOCrZo5efr371NfNnX2aVUpsG/yNEf5s
JMr8FJTOrIstdDfm3qXXQqSXkOIVeA1YzLwm95h42nizLyIYS8mody3FFxzEotxK
AlAmH8Xsz0S0f1f3FUiXteR3+DAbb37ACGD/OlVu75ZDyc1FnI82DxPnPYlTPYMc
TRqBRPWgH48w3cKCW/9DDjXtLWL73ZkiRiNIBWjC+QHair/boXpDQXpIf5hnH/I=
=5p1J
-----END PGP SIGNATURE-----

--------------enigF3C140F397E3430A6980BADE--


--===============4772813871614513983==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
This SF email is sponsosred by:
Try Windows Azure free for 90 days Click Here 
http://p.sf.net/sfu/sfd2d-msazure
--===============4772813871614513983==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

--===============4772813871614513983==--


