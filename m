Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard@nod.at>) id 1Scks8-0006Ej-82
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 07 Jun 2012 22:08:04 +0000
Received: from a.ns.miles-group.at ([95.130.255.143] helo=radon.swed.at)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Scks7-00037n-Cm
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 07 Jun 2012 22:08:04 +0000
Message-ID: <4FD1263B.5070208@nod.at>
Date: Fri, 08 Jun 2012 00:07:55 +0200
From: Richard Weinberger <richard@nod.at>
MIME-Version: 1.0
References: <4FD1164B.6060307@gmail.com> <4FD11C88.6090308@nod.at>
	<4FD11F90.5080407@gmail.com>
In-Reply-To: <4FD11F90.5080407@gmail.com>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============3457656376672528886=="
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
Subject: Re: [uml-devel] [PATCH] um: pass siginfo to guest process
To: =?ISO-8859-1?Q?Martin_P=E4rtel?= <martin.partel@gmail.com>
Cc: "user-mode-linux-devel@lists.sourceforge.net" <user-mode-linux-devel@lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--===============3457656376672528886==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigB192E981B893AE05566981D8"

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigB192E981B893AE05566981D8
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Am 07.06.2012 23:39, schrieb Martin P=E4rtel:
> On 06/08/2012 12:26 AM, Richard Weinberger wrote:
>=20
>> Am 07.06.2012 22:59, schrieb Martin P=E4rtel:
>>> Signal handlers in UML guest processes now get correct siginfo_t fiel=
ds
>>> for SIGTRAP, SIGFPE, SIGILL and SIGBUS. Specifically, si_addr and si_=
code
>>> are now correct where previously they were si_addr =3D NULL and si_co=
de =3D 128.
>>
>> What exactly is broken?
>> In my SIGSEGV test case si_addr is not NULL, it contains the correct f=
aulting address.
>>
>=20
>=20
> SIGSEGV is probably fine. At least SIGFPE is not. Test program below.
>=20
>>> +
>>> +            ptrace(PTRACE_GETSIGINFO, pid, 0,&si);
>>> +
>>
>> Doesn't this leak the host siginfo_t into the guest?
>>
>=20
>=20
> Docs for PTRACE_GETSIGINFO say `si' gets a copy. After that, `si' is no=
t used for anything other than giving it to the guest. But I really can't=
 say I
> understand the surrounding code too well so please review carefully :)

I was not talking about a memory leak.
What I meant was a information leak.
Using the host siginfo_t a guest process may get it's UID, PID, memory lo=
cation, etc... on the host side.

Anyway, thanks for the test case!
This seems to be really broken.
I had only a few minutes to look at the issue but I think the correct way=
 to fix is changing
arch/um/kernel/trap.c:relay_signal() to use force_sig_info() instead of f=
orce_sig().
Create siginfo_t and fill by hand like segv() does.

Thanks,
//richard


--------------enigB192E981B893AE05566981D8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.18 (GNU/Linux)

iQEcBAEBAgAGBQJP0SY7AAoJEN9758yqZn9eFMQH/1yB1SyGrMmGz8llQ4k2Uwm2
iyySP3vrn6u8iIFUKkxeb6QmvfsFfDOU7K+nAfS9AlPoih4s0BxXXAGJeSUDIcpB
1ANs+JfMwg9kTeIz6cJEMQmHg4kf4nuPjRVfzwToMUdaj4G1B9PXq2m27rVbkDRM
tWEQQJGNzAIiVOFycSgvQ0+BeEe1zkvzGHLfinAjtN/p4GVRPrH2aZt8L/vwgR9u
lyEz6FbLOvp17p2krCU20F4zcam57ZMTTB1jmzpoF0SkPQBgj6x8/TTgrPtROjyH
sUd+7l/Ctqba/s6hpxtglKKJO9DXXpOdNlpT86P0a/ZjgD61og32otZzmE2xWvk=
=YNav
-----END PGP SIGNATURE-----

--------------enigB192E981B893AE05566981D8--


--===============3457656376672528886==
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
--===============3457656376672528886==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

--===============3457656376672528886==--


